Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C87A7E04CA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 15:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377800AbjKCOgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 10:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbjKCOgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 10:36:00 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8213CCA;
        Fri,  3 Nov 2023 07:35:54 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5a9bc2ec556so2265693a12.0;
        Fri, 03 Nov 2023 07:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699022154; x=1699626954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=761s3ZSOYqOl5OlbDmAC3O99DhhGiHJQ6guQs2cNdZI=;
        b=P5dOTNJHCbWFDzRjj+4ecrnV6oPo1jfBpl3H1pgcr9Sn+S2fWX1T6xfi8BKU+Gu4Po
         1d9+OynI6VGlEf2BQlJaXXOXS50NyEB9qShFU/ZeuA7QRB1Pvx7Tl8PtV8eNQvORc+jw
         QX2l0Fjs0Zb5yO7NJOudROPvSsoCitkN2GzF/+X5tCDFhXDOlXuI/1KYiR4pkRqmly27
         IvYqKKH3PFsY/KrPOoZm//yVP8zhEYFz4dKwOd7uovP6HKm/1adfzWrTKyS4f0dIwbcU
         Z7in1BZstFBE/T9RNCz5P5+a6ZTVGdVt8kjSlegMOWFmvWATfk7HyCly00KS5vucRaUC
         2Jag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699022154; x=1699626954;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=761s3ZSOYqOl5OlbDmAC3O99DhhGiHJQ6guQs2cNdZI=;
        b=SZFt7Hve77Cx2AZoAFnQItMGW+9Ie93r1N+/DVAVMrbWQXSH3P34oCESN05zvxFk7U
         T6YVgpW9jTlY+Vd95mI7F0qVWxAPzasmbppeM+qkYHTu+wPiW7sF3WLwHifTkGpGnbzL
         wkHVmlcFoUsLgBKVEzWdiydqoOkVbfPSK5DgcB2ePBFQbMLPEHAeOMJdljvqgZxdEHMy
         JuDaFQ+tm32USHfYhdLRDTW/pJJs7C79SxAUAnzHEfuk1J0fHRkP5+JJ9YO+EweLeiiE
         IyDL3hb3pCyrDq/AHTAsrkImDuXjOASpRZvR+6j55bLrvqS34p+NYCXUwku4kdDOaVSd
         /ZEg==
X-Gm-Message-State: AOJu0Yw7jabClUMbfgDSVtm7iQ7fKZNF5vl5IKoaDrtPHvW0qThmQkTy
        3wuNv+QuaGE7maZGNWF5whU=
X-Google-Smtp-Source: AGHT+IHUT/dm23d8TBn14uWekihNltgnRe4oE+RQjflOX1AUX56bPQ4u06LltGcVEc4Ow97sparAtA==
X-Received: by 2002:a05:6a21:4983:b0:180:5965:a772 with SMTP id ax3-20020a056a21498300b001805965a772mr2055886pzc.28.1699022153805;
        Fri, 03 Nov 2023 07:35:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n4-20020a056a000d4400b006934a1c69f8sm1532704pfv.24.2023.11.03.07.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Nov 2023 07:35:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c74beccd-26ea-4e63-906b-bd5508465cbc@roeck-us.net>
Date:   Fri, 3 Nov 2023 07:35:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] hwmon: (pmbus) Add support for MPS Multi-phase
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
References: <20231103080128.1204218-1-peteryin.openbmc@gmail.com>
 <20231103080128.1204218-3-peteryin.openbmc@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20231103080128.1204218-3-peteryin.openbmc@gmail.com>
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

On 11/3/23 01:01, Peter Yin wrote:
> Add support for mp5990 device from Monolithic Power Systems, Inc. (MPS)
> vendor. This is a Hot-Swap Controller.
> 
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---
>   Documentation/hwmon/index.rst  |  1 +
>   Documentation/hwmon/mp5990.rst | 84 +++++++++++++++++++++++++++++++
>   drivers/hwmon/pmbus/Kconfig    |  9 ++++
>   drivers/hwmon/pmbus/Makefile   |  1 +
>   drivers/hwmon/pmbus/mp5990.c   | 90 ++++++++++++++++++++++++++++++++++
>   5 files changed, 185 insertions(+)
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
> index 000000000000..8fc4e388ff7b
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
> +Device complaint with:

compliant

> +
> +- PMBus rev 1.3 interface.
> +
> +Device supports direct format for reading input voltage, output voltage,
> +output current, input power and temperature.
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
> index 000000000000..c3b31af9f750
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/mp5990.c
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Driver for MPS MP5990 Hot-Swap Controller
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/pmbus.h>
> +#include "pmbus.h"
> +
> +static int mp5990_read_byte_data(struct i2c_client *client, int page, int reg)
> +{
> +	switch (reg) {
> +	case PMBUS_VOUT_MODE:
> +		/*
> +		  Enforce VOUT direct format, C4h reg BIT9
> +		  default val is not match vout format
> +		 */

/*
  * Please use proper multi-line comments. Also, the problem here is that the
  * chip does not support the VOUT_MODE command, which should be mentioned.
  *
  * On top of that, overwriting PMBUS_VOUT_MODE result from the chip is only
  * necessary if the chip does not return an error when reading the value.
  * If that is the case, it should be mentioned in the comment. The above
  * does not explain why this would be needed, even if the command is not
  * (officially) supported by the chip. What does it return that requires
  * an overwrite ?
  */

> +		return PB_VOUT_MODE_DIRECT;
> +	default:
> +		return -ENODATA;
> +	}
> +}
> +
> +static struct pmbus_driver_info mp5990_info = {
> +	.pages = 1,
> +	.format[PSC_VOLTAGE_IN] = direct,
> +	.format[PSC_VOLTAGE_OUT] = direct,
> +	.format[PSC_CURRENT_OUT] = direct,
> +	.format[PSC_POWER] = direct,
> +	.format[PSC_TEMPERATURE] = direct,
> +	.m[PSC_VOLTAGE_IN] = 32,
> +	.b[PSC_VOLTAGE_IN] = 0,
> +	.R[PSC_VOLTAGE_IN] = 0,
> +	.m[PSC_VOLTAGE_OUT] = 32,
> +	.b[PSC_VOLTAGE_OUT] = 0,
> +	.R[PSC_VOLTAGE_OUT] = 0,
> +	.m[PSC_CURRENT_OUT] = 16,
> +	.b[PSC_CURRENT_OUT] = 0,
> +	.R[PSC_CURRENT_OUT] = 0,
> +	.m[PSC_POWER] = 1,
> +	.b[PSC_POWER] = 0,
> +	.R[PSC_POWER] = 0,
> +	.m[PSC_TEMPERATURE] = 1,
> +	.b[PSC_TEMPERATURE] = 0,
> +	.R[PSC_TEMPERATURE] = 0,
> +	.func[0] =
> +		PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_PIN |
> +		PMBUS_HAVE_TEMP | PMBUS_HAVE_IOUT |
> +		PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP,
> +	.read_byte_data = mp5990_read_byte_data,
> +};
> +
> +static int mp5990_probe(struct i2c_client *client)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(client, PMBUS_VOUT_MODE,
> +					PB_VOUT_MODE_DIRECT);

According to the datasheet, the chip does not support the VOUT_MODE
command. Supposedly, direct vs. linear mode is selected with bit 9
of EFUSE_CFG. Even if the chip happens to "silently" support the command,
the official command should be used to select the chip mode.

Next question: Why use direct mode ? Linear mode is supported and would
be much more flexible.

> +	if (ret < 0)
> +		return ret;
> +	return pmbus_do_probe(client, &mp5990_info);
> +}
> +
> +static const struct of_device_id mp5990_of_match[] = {
> +	{ .compatible = "mps,mp5990" },
> +	{}
> +};
> +
> +static const struct i2c_device_id mp5990_id[] = {
> +	{"mp5990", 0},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, mp5990_id);
> +
> +static struct i2c_driver mp5990_driver = {
> +	.driver = {
> +		   .name = "mp5990",
> +		   .of_match_table = of_match_ptr(mp5990_of_match),

Using of_match_ptr() will result in a build failure if CONFIG_OF=n.

> +	},
> +	.probe = mp5990_probe,
> +	.id_table = mp5990_id,
> +};
> +module_i2c_driver(mp5990_driver);
> +
> +MODULE_AUTHOR("Peter Yin <peter.yin@quantatw.com>");
> +MODULE_DESCRIPTION("PMBus driver for MP5990 HSC");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(PMBUS);

