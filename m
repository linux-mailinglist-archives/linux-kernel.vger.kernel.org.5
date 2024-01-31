Return-Path: <linux-kernel+bounces-45807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACB5843674
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8DB81F25807
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB213E48E;
	Wed, 31 Jan 2024 06:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJh75lgN"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8EA3E468;
	Wed, 31 Jan 2024 06:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706681532; cv=none; b=CoAdMhZv7MxC8ip4V1oqdDrPPjJe8sjJu3hIGUhqdrNGTATHi7eKg5K357kRhUftAz6ccT3saZXzDT05Y9e3CvnIUyLEqSHSiBVsSqjx7eQuLgYcyvJpPBNPjeKTondb1dqp7ZQEzy56bscpKmI8dqDDskGQtZDbkWfYQMeLiIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706681532; c=relaxed/simple;
	bh=mu2PJBPgefwjPGR0jIXvfZTLHyYhtnX/VReaTVPoTVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kwnLW+AdspUFFBL3X9+/srepjEIkFu3uqjb0afeGjzkFInXTcrq7e46PRujtPFme3yfx+FKYCKp9yz6zamolBZrL/BxgLavE4O/p2tDxszGo9ojXQh98wHgDZGVy1JPlqZKPDmpq+sjY0mzz0eA0BQZasPOnrcVlfBB9RJqwOjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJh75lgN; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d7005ea1d0so397459a12.1;
        Tue, 30 Jan 2024 22:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706681530; x=1707286330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=767tVFDk9eahiEnIqxc4y21cu1uOjml/5mgDBZGAIjE=;
        b=MJh75lgNaWVpfUcQKJlEhL5/Palgg3WvonB3SgLxZKCAmEKSCPsg9YlBui8yi3JCy7
         gSTEVdEhP9VJzTM9z4H8An/JyD4ThgNALPPVW5EoQLwBh1kVxFvrJ0Y3rzBUerYUqoLX
         AIWeBGcWpPYeqx5ke8F9VGA1uRXmS2PITJijyNQAO6w52HEqnqYx+EVIZCvifOJyl9OB
         snpvTJrz3uzRpzsvOhongl3WA/16E628LucTbwfGPyqONiSdmarJsWGapHub2meGvnrc
         RPKIG4BR7KpKDOQelswG2m219ejh4Y5b8TdqcH2IJfjVwyEZOW4wMdkut18DfsHag9Fc
         aKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706681530; x=1707286330;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=767tVFDk9eahiEnIqxc4y21cu1uOjml/5mgDBZGAIjE=;
        b=qZRF2NOOb1xyaytHuHkCKpW+wxY77rTeLXSxDnS88djaK1q5AU3yYmwibZ+c9PI842
         xANmlh1H1YmxWOXHAHGsLhTQkpqyFiCBhJYcnZ9n6b2yh2gP3echQFgmUwEuLm3ZiXQ8
         mB8sjUHySs6Y+q1Ap9mkVesRPgq1i8+AhCN2UF6XeIP15QuURCYYo2x9i1OT85SCq/3t
         fYccNqIbT1Jobx0VkWvAWawuabz3sLtzpkM121emMv+Ik47aaVfGL/qNe8ZNU3EortIl
         euJFPxd+DTSX0SmQBxC+rG7DVFXDM+J77g+9DT4aD6ZaX2COxzDPPu4WnYPFTKhBekDp
         tEuQ==
X-Gm-Message-State: AOJu0Ywkb034JO+KhEOaJ8qqEXGVu6MiUE2sqxs/Ljc8uxQVgaif3tKk
	udW/LPvfT7sgM9JzjyDgUPQEZGxaSQeluK8rkVgpL1ZOq72NYr4k
X-Google-Smtp-Source: AGHT+IH31L7Ogu54Gqy+OTD41pP3AjjPhxRAt8al8fuh8G1fncdIIM2YvdzB6OqJXZP/9eEx/V70Bw==
X-Received: by 2002:a05:6a20:d38c:b0:19c:8673:77 with SMTP id iq12-20020a056a20d38c00b0019c86730077mr932844pzb.2.1706681529902;
        Tue, 30 Jan 2024 22:12:09 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t19-20020a62d153000000b006dddd685bbesm9337814pfl.122.2024.01.30.22.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 22:12:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <698500ed-5e90-4436-a90d-d153eb9f73c3@roeck-us.net>
Date: Tue, 30 Jan 2024 22:12:07 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] hwmon: Add driver for MPS MPQ8785 Synchronous
 Step-Down Converter
Content-Language: en-US
To: Charles Hsu <ythsu0511@gmail.com>, jdelvare@suse.com, corbet@lwn.net,
 Delphine_CC_Chiu@Wiwynn.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240131055526.2700452-1-ythsu0511@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240131055526.2700452-1-ythsu0511@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/24 21:55, Charles Hsu wrote:
> Add support for mpq8785 device from Monolithic Power Systems, Inc.
> (MPS) vendor. This is synchronous step-down controller.
> 
> Signed-off-by: Charles Hsu <ythsu0511@gmail.com>
> 
> ---
> Change in v1:
>      Initial patchset.
> Change in v2:
>      1.Add pmbus support status registers.
>      2.Add mpq8785 in trivial-devices.yaml.
>      3.Remove format[PSC_VOLTAGE_OUT].
>      4.Fix MODULE_DESCRIPTION.
> Change in v3:
>      1.Identify vout_mode.
>      2.Separate dt-binding.
> ---
>   Documentation/hwmon/index.rst   |  1 +
>   Documentation/hwmon/mpq8785.rst | 94 +++++++++++++++++++++++++++++++++
>   drivers/hwmon/pmbus/Kconfig     |  9 ++++
>   drivers/hwmon/pmbus/Makefile    |  1 +
>   drivers/hwmon/pmbus/mpq8785.c   | 91 +++++++++++++++++++++++++++++++
>   5 files changed, 196 insertions(+)
>   create mode 100644 Documentation/hwmon/mpq8785.rst
>   create mode 100644 drivers/hwmon/pmbus/mpq8785.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index c7ed1f73ac06..085ad6ca9b05 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -163,6 +163,7 @@ Hardware Monitoring Kernel Drivers
>      mp2975
>      mp5023
>      mp5990
> +   mpq8785
>      nct6683
>      nct6775
>      nct7802
> diff --git a/Documentation/hwmon/mpq8785.rst b/Documentation/hwmon/mpq8785.rst
> new file mode 100644
> index 000000000000..bf8176b87086
> --- /dev/null
> +++ b/Documentation/hwmon/mpq8785.rst
> @@ -0,0 +1,94 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +Kernel driver mpq8785
> +=======================
> +
> +Supported chips:
> +
> +  * MPS MPQ8785
> +
> +    Prefix: 'mpq8785'
> +
> +Author: Charles Hsu <ythsu0511@gmail.com>
> +
> +Description
> +-----------
> +
> +The MPQ8785 is a fully integrated, PMBus-compatible, high-frequency, synchronous
> +buck converter. The MPQ8785 offers a very compact solution that achieves up to
> +40A output current per phase, with excellent load and line regulation over a
> +wide input supply range. The MPQ8785 operates at high efficiency over a wide
> +output current load range.
> +
> +The PMBus interface provides converter configurations and key parameters
> +monitoring.
> +
> +The MPQ8785 adopts MPS's proprietary multi-phase digital constant-on-time (MCOT)
> +control, which provides fast transient response and eases loop stabilization.
> +The MCOT scheme also allows multiple MPQ8785 devices to be connected in parallel
> +with excellent current sharing and phase interleaving for high-current
> +applications.
> +
> +Fully integrated protection features include over-current protection (OCP),
> +over-voltage protection (OVP), under-voltage protection (UVP), and
> +over-temperature protection (OTP).
> +
> +The MPQ8785 requires a minimal number of readily available, standard external
> +components, and is available in a TLGA (5mmx6mm) package.
> +
> +Device compliant with:
> +
> +- PMBus rev 1.3 interface.
> +
> +The driver exports the following attributes via the 'sysfs' files
> +for input voltage:
> +
> +**in1_input**
> +
> +**in1_label**
> +
> +**in1_max**
> +
> +**in1_max_alarm**
> +
> +**in1_min**
> +
> +**in1_min_alarm**
> +
> +**in1_crit**
> +
> +**in1_crit_alarm**
> +
> +The driver provides the following attributes for output voltage:
> +
> +**in2_input**
> +
> +**in2_label**
> +
> +**in2_alarm**
> +
> +The driver provides the following attributes for output current:
> +
> +**curr1_input**
> +
> +**curr1_label**
> +
> +**curr1_max**
> +
> +**curr1_max_alarm**
> +
> +**curr1_crit**
> +
> +**curr1_crit_alarm**
> +
> +The driver provides the following attributes for temperature:
> +
> +**temp1_input**
> +
> +**temp1_max**
> +
> +**temp1_max_alarm**
> +
> +**temp1_crit**
> +
> +**temp1_crit_alarm**
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 294808f5240a..557ae0c414b0 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -377,6 +377,15 @@ config SENSORS_MPQ7932
>   	  This driver can also be built as a module. If so, the module will
>   	  be called mpq7932.
>   
> +config SENSORS_MPQ8785
> +	tristate "MPS MPQ8785"
> +	help
> +	  If you say yes here you get hardware monitoring functionality support
> +	  for power management IC MPS MPQ8785.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called mpq8785.
> +
>   config SENSORS_PIM4328
>   	tristate "Flex PIM4328 and compatibles"
>   	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index cf8a76744545..f14ecf03ad77 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -39,6 +39,7 @@ obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
>   obj-$(CONFIG_SENSORS_MP5023)	+= mp5023.o
>   obj-$(CONFIG_SENSORS_MP5990)	+= mp5990.o
>   obj-$(CONFIG_SENSORS_MPQ7932)	+= mpq7932.o
> +obj-$(CONFIG_SENSORS_MPQ8785)	+= mpq8785.o
>   obj-$(CONFIG_SENSORS_PLI1209BC)	+= pli1209bc.o
>   obj-$(CONFIG_SENSORS_PM6764TR)	+= pm6764tr.o
>   obj-$(CONFIG_SENSORS_PXE1610)	+= pxe1610.o
> diff --git a/drivers/hwmon/pmbus/mpq8785.c b/drivers/hwmon/pmbus/mpq8785.c
> new file mode 100644
> index 000000000000..b5bfc5d8a96b
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/mpq8785.c
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Driver for MPS MPQ8785 Step-Down Converter
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include "pmbus.h"
> +
> +static int mpq8785_identify(struct i2c_client *client,
> +			    struct pmbus_driver_info *info)
> +{
> +	int vout_mode;
> +
> +	vout_mode = pmbus_read_byte_data(client, 0, PMBUS_VOUT_MODE);

Excellent solution, but it will have to return an error if reading
VOUT_MODE fails. Something like:

	vout_mode = ...;
	if (vout_mode < 0 || vout_mode == 0xff)
		return vout_mode < 0 ? vout_mode : -ENODEV;

	switch (vout_mode >> 5) {
	...

The output mode _has_ to be valid.

Thanks,
Guenter


