Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169257E83F5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346419AbjKJUcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344581AbjKJUbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:31:32 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A8C3AE3B;
        Fri, 10 Nov 2023 07:34:50 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cc394f4cdfso17889345ad.0;
        Fri, 10 Nov 2023 07:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699630490; x=1700235290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=LOTAcu4FmLa0ZO5e/oRiQFa94EdrML0eRYVvFKo0n7w=;
        b=S0rLqJeiDW64851X+KMapNgz8+jmjd7syBqL09nLK6kcoVqbckk0LJpGprKvEiHBr2
         INmxIA/Ba4wKsZ07/pJa9SKYIelNXazWGBKjs1truOJoLSs1X20NNwLrIrhg9mn46Mn0
         cXAddpoGXLEkTjqKBohqbEJAgN0gQOrwPdUz+wmRYAi8ZyAP37QfHpF9dseaenl0Inly
         AyhCG5nSoc7esWGFp3onB/HIqTcoV3782L3RiQ59VMjswwyQ1okO4HyZhLr8PVuRc6yq
         FcYbdtg/g1W1fdr+4tqigp7g2x2LHq7q6eZFVCiV+PWmcLBKlm8FZVh8BKbdkCOk3zyM
         xK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699630490; x=1700235290;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LOTAcu4FmLa0ZO5e/oRiQFa94EdrML0eRYVvFKo0n7w=;
        b=Yo46bMHcIqHJrtoEMoeC3YkwnIqLqfsIQYc9aLPHStt66PZAvZIEDk/4tG0RzrSpry
         1B9MsgjeTO70Hm3Y8Xw6sLnJV9xo2S60O6VrUpJRiMxl6uP/NyeOSUurYURzeZW7hOZ6
         VqZeFZt70aUqrSsJFbtJz6R/eutSEOxSqvQSWjJnoH+gXrC4M0XFQHFWmMdhQZL7GCih
         YAS+oopLq5LYGBA+J1WynfWws8S5pQfTDGZUu5ygdDr9T8Qgw9rRM6/LxKkaYOVOKPy1
         X91TgkcvaGP9eHpUqSJAmv/wKHXs1K0KrzArbXJaiH+m0ZsUq7vDimt663biiRHfpBMR
         B8KQ==
X-Gm-Message-State: AOJu0Yxcj3zCzFPvvEsa63T6PJOhZZAbpHPxyf7G7roiAxZefnPIfjUR
        HdbZelW4Nejq1ckl4Zp0ioQ=
X-Google-Smtp-Source: AGHT+IHsMQ2Z1fVX2V6vFRC918SDXXUwAN1cGrm2Pu93OANrkqIk6CjfGgySZ4JBSbFcWaUkiVKpaw==
X-Received: by 2002:a17:902:e84f:b0:1b5:561a:5ca9 with SMTP id t15-20020a170902e84f00b001b5561a5ca9mr9190228plg.50.1699630489743;
        Fri, 10 Nov 2023 07:34:49 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902eb0600b001cc3b988fd6sm5493973plb.265.2023.11.10.07.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 07:34:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <84782418-958c-4477-a9d1-e1eb2714b225@roeck-us.net>
Date:   Fri, 10 Nov 2023 07:34:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hwmon: (pmbus) Add support for MPS Multi-phase
 mp5990
Content-Language: en-US
To:     Peter Yin <peteryin.openbmc@gmail.com>, patrick@stwcx.xyz,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20231109044844.614007-1-peteryin.openbmc@gmail.com>
 <20231109044844.614007-3-peteryin.openbmc@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20231109044844.614007-3-peteryin.openbmc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/23 20:48, Peter Yin wrote:
> Add support for mp5990 device from Monolithic Power Systems, Inc. (MPS)
> vendor. This is a Hot-Swap Controller.
> 
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---
>   Documentation/hwmon/index.rst  |  1 +
>   Documentation/hwmon/mp5990.rst | 84 +++++++++++++++++++++++++++++++++
>   drivers/hwmon/pmbus/Kconfig    |  9 ++++
>   drivers/hwmon/pmbus/Makefile   |  1 +
>   drivers/hwmon/pmbus/mp5990.c   | 86 ++++++++++++++++++++++++++++++++++
>   5 files changed, 181 insertions(+)
>   create mode 100644 Documentation/hwmon/mp5990.rst
>   create mode 100644 drivers/hwmon/pmbus/mp5990.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 042e1cf9501b..8c70e10fc795 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -157,6 +157,7 @@ Hardware Monitoring Kernel Drivers
>      mp2888
>      mp2975
>      mp5023
> +   mp5990
>      nct6683
>      nct6775
>      nct7802
> diff --git a/Documentation/hwmon/mp5990.rst b/Documentation/hwmon/mp5990.rst
> new file mode 100644
> index 000000000000..d2da0f767530
> --- /dev/null
> +++ b/Documentation/hwmon/mp5990.rst
> @@ -0,0 +1,84 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Kernel driver mp5990
> +====================
> +
> +Supported chips:
> +
> +  * MPS MP5990
> +
> +    Prefix: 'mp5990'
> +
> +  * Datasheet
> +
> +    Publicly available at the MPS website : https://www.monolithicpower.com/en/mp5990.html
> +
> +Author:
> +
> +	Peter Yin <peteryin.openbmc@gmail.com>
> +
> +Description
> +-----------
> +
> +This driver implements support for Monolithic Power Systems, Inc. (MPS)
> +MP5990 Hot-Swap Controller.
> +
> +Device compliant with:
> +
> +- PMBus rev 1.3 interface.
> +
> +Device supports direct format for reading input voltage, output voltage,
> +output current, input power and temperature.
> +

The device also supports linear mode according to its datasheet.

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
> +**curr1_alarm**
> +
> +**curr1_max**
> +
> +The driver provides the following attributes for input power:
> +
> +**power1_input**
> +
> +**power1_label**
> +
> +**power1_alarm**
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
> index 270b6336b76d..65a116f7744d 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -326,6 +326,15 @@ config SENSORS_MP5023
>   	  This driver can also be built as a module. If so, the module will
>   	  be called mp5023.
>   
> +config SENSORS_MP5990
> +	tristate "MPS MP5990"
> +	help
> +	  If you say yes here you get hardware monitoring support for MPS
> +	  MP5990.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called mp5990.
> +
>   config SENSORS_MPQ7932_REGULATOR
>   	bool "Regulator support for MPQ7932"
>   	depends on SENSORS_MPQ7932 && REGULATOR
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 84ee960a6c2d..212d9ca0acc9 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
>   obj-$(CONFIG_SENSORS_MP2888)	+= mp2888.o
>   obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
>   obj-$(CONFIG_SENSORS_MP5023)	+= mp5023.o
> +obj-$(CONFIG_SENSORS_MP5990)	+= mp5990.o
>   obj-$(CONFIG_SENSORS_MPQ7932)	+= mpq7932.o
>   obj-$(CONFIG_SENSORS_PLI1209BC)	+= pli1209bc.o
>   obj-$(CONFIG_SENSORS_PM6764TR)	+= pm6764tr.o
> diff --git a/drivers/hwmon/pmbus/mp5990.c b/drivers/hwmon/pmbus/mp5990.c
> new file mode 100644
> index 000000000000..fb3ac9c5d44e
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/mp5990.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Driver for MPS MP5990 Hot-Swap Controller
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/pmbus.h>

Not used in this driver.

> +#include "pmbus.h"
> +
> +static int mp5990_read_byte_data(struct i2c_client *client, int page, int reg)
> +{
> +	switch (reg) {
> +	case PMBUS_VOUT_MODE:
> +		/* The datasheet does not support the VOUT command,

Standard multi-line comments, please. This is not the networking subsystem.

> +		 * but the device responds with a default value of 0x17.
> +		 * In the standard, 0x17 represents linear mode. However,
> +		 * for the MP5990, the VOUT linear mode is linear11, not linear16.
> +		 * Therefore, we should enforce the VOUT in the direct format.
> +		 */
> +		return PB_VOUT_MODE_DIRECT;

This doesn't take into account that the reporting mode is set in
EFUSE_CFG bit 9 (RPT_FORMAT). If the chip is configured to report its data
in linear mode, all readings will be wrong if the exponent is != 0 and
for negative values.

The driver could enforce direct mode by explicitly configuring EFUSE_CFG,
but that is not guaranteed to work because the chip could be write
protected. It would be necessary to disable write protection first,
making this a bit complicated. Alternatively, the reading of VOUT could
be adjusted in linear mode to linear16 if the chip is configured to
report data in linear mode. I would personally prefer this solution.
Either case, this needs to be handled.

Guenter

