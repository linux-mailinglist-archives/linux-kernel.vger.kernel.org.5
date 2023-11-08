Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40437E5A6E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjKHPtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjKHPts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:49:48 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8905186;
        Wed,  8 Nov 2023 07:49:46 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6bf03b98b9bso716775b3a.1;
        Wed, 08 Nov 2023 07:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699458586; x=1700063386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KNPumiO8SrzzZ2NXnnNjVFvMbNFpkYhxKAF6ZsKDpB4=;
        b=UibbVEFHk99z6+BwcZke8CZs/Hy7aTudrhmWpFSyj6rGbkXkfN96MD4+4jpoSHJckS
         UitQM3IpYWrZe3Sp6aVVjA+9vrSMi/4sn4L+GyPx5VcXkx84rwKVK2+33KdJKunEf9AE
         DQ9pzlbd9mrK5WCu622J5el2w4pqKvHvEwKdR10pCRSj9Jt0gz/pWaylEM4pvOVpLuPn
         nG1qEHzMpvOfdzBvTIm0KafiYYBUmtoBqd21C/H3hiqQpats1rV5mB0OIJnudXitjAPX
         HAc5lIKPg+qzan6J++8vBoPW1qCQMzDl/daKnF4T2SWzM1+F0TGiz5ewZLCfGY/S3B3R
         Ityg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699458586; x=1700063386;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KNPumiO8SrzzZ2NXnnNjVFvMbNFpkYhxKAF6ZsKDpB4=;
        b=ZMCuhkesdMlhQxdnri2YgLPrJp8yDkOZQTCEWkIiD4webuxqF1LKH7ei/jPUDJrL3m
         NgnGJUxtng0Ba5899GlQZ8h0NRwJtj8BY9UIZ9BSXqt35LCjrBpDys+7Abl0VJfs7pd5
         nihW5T55LFkwxkjzlgUuNSH85OvP1EHXBrTMBK9marGJju48hUXvR6xERKePVzsucaOj
         +dd4PiE68gJy0q+CF80qr93gwzXZ7EsX3fkTNBikhgPCsG2rpbZrNNevjs6R/KKfR1xI
         XNS4YTaY+NJ2RX4SChqc60z0FRAmhlKFevWYCKdf6Xp+lbtO6AYEQLfCZyBfbp5HZnAl
         J6vQ==
X-Gm-Message-State: AOJu0Yy2wZmUW3RmB7kgWxyQ7fHpvXoOaX4ZVFQg24njVH2vGAbCCZpn
        kdXqClAfpNWHcNFQ5OIatJg=
X-Google-Smtp-Source: AGHT+IFhP2PaJgK7kdHesDuCdCcx34nmJNDTaQiaoVyF/HwKLz3Z0AcEAdNBA+vWYe55lvvlNeNLDA==
X-Received: by 2002:a05:6a20:a127:b0:159:c07d:66f0 with SMTP id q39-20020a056a20a12700b00159c07d66f0mr3373680pzk.6.1699458585832;
        Wed, 08 Nov 2023 07:49:45 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f17-20020aa782d1000000b00692cac7a065sm9071839pfn.151.2023.11.08.07.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 07:49:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0e533add-e969-47f7-94d3-e4ec44631c26@roeck-us.net>
Date:   Wed, 8 Nov 2023 07:49:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] hwmon: (pmbus) Add support for MPS Multi-phase
 mp2856/mp2857 controller
Content-Language: en-US
To:     Peter Yin <peteryin.openbmc@gmail.com>, patrick@stwcx.xyz,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Brown <broonie@kernel.org>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        Vincent Tremblay <vincent@vtremblay.dev>,
        Lakshmi Yadlapati <lakshmiy@us.ibm.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
References: <20231108024222.2026546-1-peter.yin@quantatw.com>
 <20231108024222.2026546-3-peter.yin@quantatw.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20231108024222.2026546-3-peter.yin@quantatw.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/23 18:42, Peter Yin wrote:
> From: Peter Yin <peteryin.openbmc@gmail.com>
> 
> Add support for mp2856/mp2857 device from Monolithic Power Systems, Inc.
> (MPS) vendor. This is a dual-loop, digital, multi-phase,
> modulation controller.
> 
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---
>   Documentation/hwmon/index.rst  |   1 +
>   Documentation/hwmon/mp2856.rst | 101 ++++++++++
>   drivers/hwmon/pmbus/Kconfig    |   9 +
>   drivers/hwmon/pmbus/Makefile   |   1 +
>   drivers/hwmon/pmbus/mp2856.c   | 327 +++++++++++++++++++++++++++++++++
>   5 files changed, 439 insertions(+)
>   create mode 100644 Documentation/hwmon/mp2856.rst
>   create mode 100644 drivers/hwmon/pmbus/mp2856.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 042e1cf9501b..44183a3382f6 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -154,6 +154,7 @@ Hardware Monitoring Kernel Drivers
>      mcp3021
>      menf21bmc
>      mlxreg-fan
> +   mp2856
>      mp2888
>      mp2975
>      mp5023
> diff --git a/Documentation/hwmon/mp2856.rst b/Documentation/hwmon/mp2856.rst
> new file mode 100644
> index 000000000000..6bd8392f6994
> --- /dev/null
> +++ b/Documentation/hwmon/mp2856.rst
> @@ -0,0 +1,101 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Kernel driver mp2856
> +====================
> +
> +Supported chips:
> +
> +  * MPS MP2856
> +
> +    Prefix: 'mp2856'
> +
> +  * MPS MP2857
> +
> +    Prefix: 'mp2857'
> +
> +Author:
> +
> +	Peter Yin <peter.yin@quantatw.com>
> +
> +Description
> +-----------
> +
> +This driver implements support for Monolithic Power Systems, Inc. (MPS)
> +vendor dual-loop, digital, multi-phase controller MP2856/MP2857
> +
> +This device:
> +
> +- Supports up to two power rail.
> +- Supports two pages 0 and 1 for and also pages 2 for configuration.
> +- Can configured VOUT readout in direct or VID format and allows
> +  setting of different formats on rails 1 and 2. For VID the following
> +  protocols are available: AMD SVI3 mode with 5-mV/LSB.
> +
> +Device supports:
> +
> +- SVID interface.
> +- AVSBus interface.
> +
> +Device complaint with:

compliant

> +
> +- PMBus rev 1.3 interface.
> +
> +Device supports direct format for reading output current, output voltage,
> +input and output power and temperature.
> +Device supports linear format for reading input voltage and input power.
> +Device supports VID and direct formats for reading output voltage.
> +The below VID modes are supported: AMD SVI3.
> +
> +The driver provides the next attributes for the current:
> +The driver exports the following attributes via the 'sysfs' files, where

Please rephrase. Something like

The driver provides the following sysfs attributes for current measurements.

or similar. Same below.

> +
> +- indexes 1  for "iin";
> +- indexes 2, 3 for "iout";
> +
> +**curr[1-3]_alarm**
> +
> +**curr[1-3]_input**
> +
> +**curr[1-3]_label**
> +
> +The driver provides the next attributes for the voltage:
> +The driver exports the following attributes via the 'sysfs' files, where
> +
> +- indexes 1 for "vin";
> +- indexes 2, 3 for "vout";
> +
> +**in[1-3]_crit**
> +
> +**in[1-3]_crit_alarm**
> +
> +**in[1-3]_input**
> +
> +**in[1-3]_label**
> +
> +**in[1-3]_lcrit**
> +
> +**in[1-3]_lcrit_alarm**
> +
> +The driver provides the next attributes for the power:
> +The driver exports the following attributes via the 'sysfs' files, where
> +
> +- indexes 1 for "pin";
> +- indexes 2, 3 for "pout";
> +
> +**power[1-3]_alarm**
> +
> +**power[1-3]_input**
> +
> +**power[1-3]_label**
> +
> +The driver provides the next attributes for the temperature:
> +
> +**temp[1-2]_crit**
> +
> +**temp[1-2]_crit_alarm**
> +
> +**temp[1-2]_input**
> +
> +**temp[1-2]_max**
> +
> +**temp[1-2]_max_alarm**
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 270b6336b76d..40ad02b459de 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -299,6 +299,15 @@ config SENSORS_MAX8688
>   	  This driver can also be built as a module. If so, the module will
>   	  be called max8688.
>   
> +config SENSORS_MP2856
> +	tristate "MPS MP2856"
> +	help
> +	  If you say yes here you get hardware monitoring support for MPS
> +	  MP2856 MP2857 Dual Loop Digital Multi-Phase Controller.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called mp2856.
> +
>   config SENSORS_MP2888
>   	tristate "MPS MP2888"
>   	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 84ee960a6c2d..0f35047b451f 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_SENSORS_MAX20751)	+= max20751.o
>   obj-$(CONFIG_SENSORS_MAX31785)	+= max31785.o
>   obj-$(CONFIG_SENSORS_MAX34440)	+= max34440.o
>   obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
> +obj-$(CONFIG_SENSORS_MP2856)	+= mp2856.o
>   obj-$(CONFIG_SENSORS_MP2888)	+= mp2888.o
>   obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
>   obj-$(CONFIG_SENSORS_MP5023)	+= mp5023.o
> diff --git a/drivers/hwmon/pmbus/mp2856.c b/drivers/hwmon/pmbus/mp2856.c
> new file mode 100644
> index 000000000000..b72a46cb6e9b
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/mp2856.c
> @@ -0,0 +1,327 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Hardware monitoring driver for MPS2856/2857
> + * Monolithic Power Systems VR Controllers
> + *
> + * Copyright (C) 2023 Quanta Computer lnc.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pmbus.h>
> +#include "pmbus.h"
> +
> +/* Vendor specific registers. */
> +#define MP2856_MFR_SLOPE_TRIM3		0x1d
> +#define MP2856_MFR_VR_MULTI_CONFIG_R1	0x0d
> +#define MP2856_MFR_VR_MULTI_CONFIG_R2	0x1d
> +#define MP2856_MUL1_CUR_SCALE_R1	0x0b
> +#define MP2856_MUL1_CUR_SCALE_R2	0x1b
> +#define MP2856_MFR_DC_LOOP_CTRL		0x59
> +#define MP2856_MFR_VR_CONFIG1		0x68
> +#define MP2856_MFR_READ_IOUT_PK		0x90
> +#define MP2856_MFR_READ_POUT_PK		0x91
> +#define MP2856_MFR_PROTECT_SET		0xc5
> +#define MP2856_MFR_RESO_SET		0x5e
> +#define MP2856_MFR_OVP_TH_SET		0xe5
> +#define MP2856_MFR_UVP_SET		0xe6
> +

Many of the above defines are unused. Please only provide defines
if the driver uses them.

Note that MP2856_MFR_READ_IOUT_PK and MP2856_MFR_READ_POUT_PK suggests
support for peak attributes. I would suggest to add support for them.

> +#define MP2856_VID_EN			BIT(11)
> +#define MP2856_DRMOS_KCS		GENMASK(15, 12)
> +#define MP2856_VID_SCALE		5
> +#define MP2856_VIN_UV_LIMIT_UNIT	8
> +#define MP2856_PWR_EXPONENT_BIT		GENMASK(10, 6)

This is a mask, not a bit.

> +
> +#define MP2856_MAX_PHASE_RAIL1		12
> +#define MP2856_MAX_PHASE_RAIL2		6

Above are not used. If the chip provides per-rail attributes, you might consider
supporting them. Otherwise, again, please drop unused defines.

The vendor says "Information about this device cannot be provided publicly",
meaning you'll unfortunately be on your own when deciding what to support and how.

> +#define MP2856_PAGE_NUM			2
> +
> +#define MP2856_RAIL2_FUNC	(PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT | \
> +				 PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT | \
> +				 PMBUS_HAVE_POUT | PMBUS_HAVE_TEMP)
> +
> +#define MP2856_RAIL2_MAX_PHASE		4

This contradicts MP2856_MAX_PHASE_RAIL2.

> +
> +struct mp2856_data {
> +	struct pmbus_driver_info info;
> +	int vout_format[MP2856_PAGE_NUM];
> +};
> +
> +#define to_mp2856_data(x)  container_of(x, struct mp2856_data, info)
> +
> +static int
> +mp2856_read_word_helper(struct i2c_client *client, int page, int phase, u8 reg,
> +			u16 mask)
> +{
> +	int ret = pmbus_read_word_data(client, page, phase, reg);
> +
> +	return (ret > 0) ? ret & mask : ret;
> +}
> +
> +static int
> +mp2856_vid2linear(int val)
> +{
> +	return 500 + (val - 1) * 10;

The maximum value returned here is 500 + (254 * 10) = 3040 = 0x0BE0.

In linear11, this is a negative value.

> +}
> +
> +static int mp2856_read_word_data(struct i2c_client *client, int page,
> +				 int phase, int reg)
> +{
> +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> +	struct mp2856_data *data = to_mp2856_data(info);
> +	int ret;
> +
> +	switch (reg) {
> +	case PMBUS_READ_VOUT:
> +		ret = mp2856_read_word_helper(client, page, phase, reg,
> +					      GENMASK(11, 0));

Is masking the returned value really appropriate ? This masks out the exponent
if the data is really provided in linear (linear11) mode. And for vid mode
I would assume that the returned value would be an 8-bit value.

> +		if (ret < 0)
> +			return ret;
> +
> +		/*
> +		 * READ_VOUT can be provided in VID or linear format. This
> +		 * provided in a linear format. In case format is VID - convert
> +		 * to linear.

This provided -> "The PMBus code expects data in linear format" or similar.

> +		 */
> +		if (data->vout_format[page] == vid)
> +			ret = mp2856_vid2linear(ret);
> +		break;
> +	default:
> +		return -ENODATA;
> +	}
> +
> +	return ret;
> +}
> +
> +static int mp2856_identify_multiphase_rail2(struct i2c_client *client)
> +{
> +	int ret;
> +
> +	/*
> +	 * Identify multiphase for rail 2 - could be from 0 to 1.
> +	 * In case phase number is zero – only page zero is supported
> +	 */
> +	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, 2);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Identify multiphase for rail 2 - could be from 0 to 1. */

"could be from 0 to 1" is confusing, and the comment is duplicated.
What does it mean ?

> +	ret = i2c_smbus_read_word_data(client, MP2856_MFR_VR_MULTI_CONFIG_R2);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret &= GENMASK(2, 0);
> +	return (ret >= MP2856_RAIL2_MAX_PHASE) ? MP2856_RAIL2_MAX_PHASE : ret;

This needs explanation, especially since the maximum number of phases for rail 2
is defined as 4 _and_ 6. What is the real maximum, and what does the chip do
if the value is set to a value larger than supported by the chip ?

Also, since the maximum number of phases is 12 for rail 1, is the mask really
a 3-bit value, or is it a 4-bit value ? That is important since, say, 0x1001
would mean something different if the mask is a 4-bit value.

> +}
> +
> +static int
> +mp2856_identify_vid(struct i2c_client *client, struct mp2856_data *data,
> +		    struct pmbus_driver_info *info, u32 reg, int page,
> +		    u32 imvp_bit)
> +{
> +	int ret;
> +
> +	/* Identify VID mode and step selection. */
> +	ret = i2c_smbus_read_word_data(client, reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret & imvp_bit) {
> +		info->vrm_version[page] = vr13;

I don't think this has any value since the value format is set to linear.
With this in mind, the function name and its use are quite misleading:
It does not identify anything-vid, it applies the workaround below.

Also, reading MP2856_MFR_RESO_SET is effectively duplicated here and
in mp2856_identify_vout_format(), where the output format (and thus
vid mode) is _really_ determined. Please rework the code to only read
and analyze MP2856_MFR_RESO_SET once per page.

> +	} else {
> +		//workaround for chip power scale issue

Please no C++ comments. Also, this needs more explanation. What is the issue ?
Describe the problem and its solution.

> +		ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, 2);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = i2c_smbus_read_word_data(client,
> +					       MP2856_MUL1_CUR_SCALE_R1);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret &= ~MP2856_PWR_EXPONENT_BIT;
> +		ret = i2c_smbus_write_word_data(client,
> +						MP2856_MUL1_CUR_SCALE_R1, ret);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = i2c_smbus_read_word_data(client,
> +					       MP2856_MUL1_CUR_SCALE_R2);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret &= ~MP2856_PWR_EXPONENT_BIT;
> +		ret = i2c_smbus_write_word_data(client,
> +						MP2856_MUL1_CUR_SCALE_R2, ret);
> +		if (ret < 0)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
> +static int
> +mp2856_identify_rails_vid(struct i2c_client *client, struct mp2856_data *data,
> +			  struct pmbus_driver_info *info)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, 2);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Identify VID mode for rail 1. */
> +	ret = mp2856_identify_vid(client, data, info,
> +				  MP2856_MFR_RESO_SET, 0,
> +				  MP2856_VID_EN);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Identify VID mode for rail 2, if connected. */
> +	if (info->phases[1])
> +		ret = mp2856_identify_vid(client, data, info,
> +					  MP2856_MFR_RESO_SET, 1,
> +					  MP2856_VID_EN);
> +	return ret;
> +}
> +
> +static int
> +mp2856_identify_vout_format(struct i2c_client *client,
> +			    struct mp2856_data *data, int page)
> +{
> +	int ret;
> +	int val;
> +
> +	ret = i2c_smbus_read_word_data(client, MP2856_MFR_RESO_SET);
> +	if (ret < 0)
> +		return ret;
> +
> +	val = (ret & GENMASK(11, 11)) >> 11;
> +	switch (val) {
> +	case 0:
> +		data->vout_format[page] = vid;
> +		break;
> +	default:
> +		data->vout_format[page] = linear;
> +		break;
> +	}

This is unnecessarily complex.

	if (ret & BIT(11))
		data->vout_format[page] = linear;
	else
		data->vout_format[page] = vid;

would accomplish the same, or even
	data->vout_format[page] = (ret & BIT(11)) ? linear : vid;
	
> +	return 0;
> +}
> +
> +static int
> +mp2856_vout_per_rail_config_get(struct i2c_client *client,
> +				struct mp2856_data *data,
> +				struct pmbus_driver_info *info)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < data->info.pages; i++) {
> +		ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, i);
> +		if (ret < 0)
> +			return ret;
> +
> +		/*
> +		 * Get VOUT format for READ_VOUT command : VID or direct.
> +		 * Pages on same device can be configured with different
> +		 * formats.
> +		 */
> +		ret = mp2856_identify_vout_format(client, data, i);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct pmbus_driver_info mp2856_info = {
> +	.pages = 1,
> +	.format[PSC_VOLTAGE_IN] = linear,
> +	.format[PSC_VOLTAGE_OUT] = linear,
> +	.format[PSC_TEMPERATURE] = linear,
> +	.format[PSC_CURRENT_IN] = linear,
> +	.format[PSC_CURRENT_OUT] = linear,
> +	.format[PSC_POWER] = linear,
> +	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
> +		PMBUS_HAVE_IIN | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
> +		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP | PMBUS_HAVE_POUT |
> +		PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT,

> +	.read_word_data = mp2856_read_word_data,
> +};
> +
> +static int mp2856_probe(struct i2c_client *client)
> +{
> +	struct pmbus_driver_info *info;
> +	struct mp2856_data *data;
> +	int ret;
> +
> +	/*
> +	 * MP2856/MP2857 devices may not stay in page 0 during device
> +	 * probe which leads to probe failure (read status word failed).
> +	 * So let's set the device to page 0 at the beginning.
> +	 */
> +	i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);
> +

This is quite pointless here since it is overwritten by the various
identify functions which explicitly set the page.

> +	data = devm_kzalloc(&client->dev, sizeof(struct mp2856_data),
> +			    GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	memcpy(&data->info, &mp2856_info, sizeof(*info));
> +	info = &data->info;
> +
> +	/* Identify multiphase configuration for rail 2. */

Why only for rail 2 and not for rail 1 ?

> +	ret = mp2856_identify_multiphase_rail2(client);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret) {
> +		/* Two rails are connected. */
> +		data->info.pages = MP2856_PAGE_NUM;
> +		data->info.phases[1] = ret;
> +		data->info.func[1] = MP2856_RAIL2_FUNC;

This can be set in mp2856_info and does not have to be assigned.

> +	}
> +
> +	ret = mp2856_identify_rails_vid(client, data, info);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Obtain offsets, maximum and format for vout. */

Did you copy this from some other driver ? The function below
does not obtain any offset or maximum values.

> +	ret = mp2856_vout_per_rail_config_get(client, data, info);
> +	if (ret)
> +		return ret;
> +

At this point, in multi-rail configurations, the page will be set to page 1.

> +	return pmbus_do_probe(client, info);
> +}
> +
> +static const struct i2c_device_id mp2856_id[] = {
> +	{"mp2856", 0},
> +	{"mp2857", 0},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, mp2856_id);
> +
> +static const struct of_device_id __maybe_unused mp2856_of_match[] = {
> +	{.compatible = "mps,mp2856"},
> +	{.compatible = "mps,mp2857"},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, mp2856_of_match);
> +
> +static struct i2c_driver mp2856_driver = {
> +	.driver = {
> +		.name = "mp2856",
> +		.of_match_table = mp2856_of_match,
> +	},
> +	.probe = mp2856_probe,
> +	.id_table = mp2856_id,
> +};
> +
> +module_i2c_driver(mp2856_driver);
> +
> +MODULE_AUTHOR("Peter Yin <peter.yin@quantatw.com>");
> +MODULE_DESCRIPTION("PMBus driver for MPS MP2856/MP2857 device");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(PMBUS);

