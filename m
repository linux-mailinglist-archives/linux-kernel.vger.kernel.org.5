Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACB57A896F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbjITQ3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbjITQ3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:29:36 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53A9C6;
        Wed, 20 Sep 2023 09:29:29 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7927952ca67so1530639f.2;
        Wed, 20 Sep 2023 09:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695227369; x=1695832169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AxND+vR1rdBBKvxxon2A0Bm0XzkYEjJpDS7T/xbaKmA=;
        b=ICoCGq7v6erc+8LDnRMyFmeWijXkpP/fkm+p1GDRrnuyjXAsVMwBKo1Lq+jIvFqOw8
         oTaQTpKfWcl2Ub0sx9I97N1eXkd0vLY21J/QwFhkl/VUlZNgkWgGz/R1w3+91HkAOXH1
         /UpVQdoQJ7HTjwr+XZGsgIkfEqSBqYt2/k1hW3PL0fz+3Exqf+tAZfEDUxgma2Nr+HYz
         Z9LWSYTi3+hYBdoArzzpI+IZPMFC87sBgsCK8wR9CKagf5TKn+hDCn5VNPUSCAHr0o4Q
         Q/XWm50riiUJtVFlLOfWDzDkTlVpFXgHuCLZf1BxzXXYo0y8LWmk6iHO4snfDiAuRfaJ
         u+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695227369; x=1695832169;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AxND+vR1rdBBKvxxon2A0Bm0XzkYEjJpDS7T/xbaKmA=;
        b=crV2JCsKv3v0k3eOcEOVn7yDE3soMZtLb3TY0QYENRRrz3FSLYCsC7Va0xTc8ajAvR
         Zb9rHEhz9eD1NR6wU9xGfjFVQSywqSRLrxxbQTe7hY+T3qCHG5OwBynBgHVhlWNhknyy
         maELf8/gaRHN+MlnAsR3gwf2baoNc6zMuOh/pZ1dsx/S/rH43WMYCTgXyORXxdIbJyrS
         /5YKw7+XwCyFrzFUBWtuSnRU86jnhdwR1oV6ZYvstwnZ/awCCKXLQ0LJIGUK+VcoD2eO
         FCEGscNxbGrvuojVjXpmVV63Lx/ZFwwtynZmuJwbM6rvpS01H9Q+DzFLEv0LWhhHU4hD
         jzmw==
X-Gm-Message-State: AOJu0YxH5fqM6ptDi/wbRlYgaAXDv7lfUVhqILl534sVweiun4vm6nM5
        9Amx09SJ9cYCiNDqZ9IQNiQ=
X-Google-Smtp-Source: AGHT+IFOTPJfdmVGGY0In0wMg868tzX/V29husgh/dK49tDkkRR/q4P/ok8BUF5VCiquMs6CdV6Thw==
X-Received: by 2002:a5e:aa18:0:b0:798:2415:1189 with SMTP id s24-20020a5eaa18000000b0079824151189mr3735073ioe.12.1695227368820;
        Wed, 20 Sep 2023 09:29:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t24-20020a02ccb8000000b0042b1dd89b0bsm4074836jap.155.2023.09.20.09.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 09:29:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4a1cb223-448c-3e93-eb38-d86f543659e3@roeck-us.net>
Date:   Wed, 20 Sep 2023 09:29:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz,
        Jean Delvare <jdelvare@suse.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230920054739.1561080-1-Delphine_CC_Chiu@wiwynn.com>
 <20230920054739.1561080-3-Delphine_CC_Chiu@wiwynn.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1 2/2] hwmon: Add support for ina233
In-Reply-To: <20230920054739.1561080-3-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/23 22:47, Delphine CC Chiu wrote:
> The INA233 device is a current, voltage and power monitor
> with an I2C-, SMBus-,and PMBus-compatible interface
> that is compliant with digital bus voltages from 1.8 V to 5.0 V.
> The device monitors and reports values for current, voltage and power.
> The integrated power accumulator can be used for energy
> or average power calculations. Programmable calibration value,
> conversion times and averaging when combined with an internal multiplier
> enable direct readouts of current in amperes and power in watts.
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>

checkpatch says:

WARNING: Missing a blank line after declarations
#181: FILE: drivers/hwmon/pmbus/ina233.c:39:
+	u16 current_lsb;
+	of_property_read_u16(client->dev.of_node, "resistor-calibration", &shunt);

WARNING: else is not generally useful after a break or return
#192: FILE: drivers/hwmon/pmbus/ina233.c:50:
+		return ret;
+	} else {

I should not have to say this, but please run your patches through checkpatch.

> ---
>   drivers/hwmon/pmbus/Kconfig  |  9 ++++
>   drivers/hwmon/pmbus/Makefile |  1 +
>   drivers/hwmon/pmbus/ina233.c | 89 ++++++++++++++++++++++++++++++++++++

Documentation missing.

>   3 files changed, 99 insertions(+)
>   create mode 100644 drivers/hwmon/pmbus/ina233.c
> 
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index b4e93bd5835e..0abc1fd20bbb 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -509,4 +509,13 @@ config SENSORS_ZL6100
>   	  This driver can also be built as a module. If so, the module will
>   	  be called zl6100.
>   
> +config SENSORS_INA233
> +        tristate "Texas Instruments INA233 and compatibles"
> +        help
> +          If you say yes here you get hardware monitoring support for Texas
> +          Instruments INA233.
> +
> +          This driver can also be built as a module. If so, the module will
> +          be called ina233.
> +
>   endif # PMBUS
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 84ee960a6c2d..c8888e7ac94f 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -51,3 +51,4 @@ obj-$(CONFIG_SENSORS_XDPE122)	+= xdpe12284.o
>   obj-$(CONFIG_SENSORS_XDPE152)	+= xdpe152c4.o
>   obj-$(CONFIG_SENSORS_ZL6100)	+= zl6100.o
>   obj-$(CONFIG_SENSORS_PIM4328)	+= pim4328.o
> +obj-$(CONFIG_SENSORS_INA233) 	+= ina233.o
> diff --git a/drivers/hwmon/pmbus/ina233.c b/drivers/hwmon/pmbus/ina233.c
> new file mode 100644
> index 000000000000..393b595344c5
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/ina233.c
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Hardware monitoring driver for Texas Instruments INA233
> + *
> + * Copyright (c) 2017 Google Inc

That doesn't make sense.

> + *
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include "pmbus.h"
> +
> +#define MFR_CALIBRATION	0xd4
> +
> +struct pmbus_driver_info ina233_info = {
> +	.pages = 1,
> +	.format[PSC_VOLTAGE_IN] = direct,
> +	.format[PSC_VOLTAGE_OUT] = direct,
> +	.format[PSC_CURRENT_IN] = direct,
> +	.format[PSC_CURRENT_OUT] = direct,
> +	.format[PSC_POWER] = direct,
> +	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
> +	    | PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT
> +		| PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_POUT,
> +	.m[PSC_VOLTAGE_IN] = 8,
> +	.m[PSC_VOLTAGE_OUT] = 8,
> +	.R[PSC_VOLTAGE_IN] = 2,
> +	.R[PSC_VOLTAGE_OUT] = 2,
> +};
> +
> +static int ina233_probe(struct i2c_client *client)
> +{
> +	int ret;
> +	u16 shunt;
> +	u16 current_lsb;
> +	of_property_read_u16(client->dev.of_node, "resistor-calibration", &shunt);
> +

If of_property_read_u16() fails, this will result in writing a random value
into MFR_CALIBRATION. Also, the lack of a range check seems questionable.

Also, as mentioned in my comments to the bindings, the value to write
into MFR_CALIBRATION should be calculated and not be provided as raw value
in the devicetree properties.


> +	ret = i2c_smbus_write_word_data(client, MFR_CALIBRATION, shunt);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Failed to set calibration\n");
> +		return ret;
> +	}
> +	ret = of_property_read_u16(client->dev.of_node, "current-lsb", &current_lsb);

This accepts a current-lsb of 0, which would result in a divide by 0
error below.

> +	if (ret < 0) {
> +		dev_err(&client->dev, "Failed to set current_lsb\n");
> +		return ret;
> +	} else {
> +		// Referenced by table of Telemetryand WarningConversionCoefficients in datasheet

Please no C++ comments in hwmon drivers.

> +		ina233_info.m[PSC_CURRENT_IN] = 1000 / current_lsb;
> +		ina233_info.m[PSC_CURRENT_OUT] = 1000 / current_lsb;
> +		ina233_info.m[PSC_POWER] = 40 / current_lsb;

The lack of units makes it all but impossible to validate those equations.

The datasheet says that R must also be calculated. The datasheet specifically says
"Moving the decimal point to maximize the value of m is critical to minimize rounding
errors" and "Care must be taken to adjust the exponent coefficient, R, such that the
value of m remains within the range of –32768 to 32767". If you think that is not
necessary, please explain.

Actually, the values for m will never exceed the range but be _much_ less based on
above equations, which must result in significant loss of precision. "40 / current_lsb"
means the m value for power will never be above 40 and quite likely 0. I really
don't see why this would make sense.

> +	}
> +
> +	return pmbus_do_probe(client, &ina233_info);
> +}
> +
> +static const struct i2c_device_id ina233_id[] = {
> +	{"ina233", 0},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, ina233_id);
> +
> +static const struct of_device_id __maybe_unused ina233_of_match[] = {
> +	{ .compatible = "ti,ina233" },
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(of, ina233_of_match);
> +
> +static struct i2c_driver ina233_driver = {
> +	.driver = {
> +		   .name = "ina233",
> +		   .of_match_table = of_match_ptr(ina233_of_match),
> +		   },
> +	.probe_new = ina233_probe,
> +	.id_table = ina233_id,
> +};
> +
> +module_i2c_driver(ina233_driver);
> +
> +MODULE_AUTHOR("Eli Huang <eli_huang@wiwynn.com>");
> +MODULE_DESCRIPTION("PMBus driver for Texas Instruments INA233 and compatible chips");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(PMBUS);
> +

