Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2291875B0A2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 16:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjGTOAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 10:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjGTOAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:00:43 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C4D1FC8;
        Thu, 20 Jul 2023 07:00:42 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-668711086f4so591401b3a.1;
        Thu, 20 Jul 2023 07:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689861641; x=1690466441;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U2HPdD+d9XvbmzcaBg97eWI4FwW6fi1mZZee8wqO980=;
        b=RF3gXCPxsugEwn/S3iDUy2B27o3bFuAAcPv4PTJdXwnikS2JH3lxZin8WoDMmK55uT
         96DmlLN1NZmkg7cT2HeAMvp3uRXsrtqPNcKSQRPTKEngfyRwrQh6qIkWBPq0f/+/lEvi
         hRDfG7v0Fm3AY4TsmL2RnLd1xZx2K5zJpR91qgXg2BwaAUgMdPY76THyCbbYMjwaeRoC
         pNKdhVS4GywTcByWJmikbM7Ojloy72BIxYboeG22YNo3LJpwQt4OzAAZIcJZh/aZ/WhU
         qsWXpjp4isJ+uxBf3nKSs+8AD/AT2FfLu5sJET6MNWO5n1huWtjwDz2GFrll7vnOPF3O
         EnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689861641; x=1690466441;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2HPdD+d9XvbmzcaBg97eWI4FwW6fi1mZZee8wqO980=;
        b=dzoEzNKDBlQlok1n0ulwND9a3m6bKCwn4HeiUMPdPecLskdGHWy4RjKbcltPtxFVk6
         Z0cnKszQdMyfgys/7xgQkBgC5vYhF5/49830SzWmp83Ot0z//Fl1PmC6LcotKC76yN6I
         mgF6nCQTMihXnED3kxkbRn0EkQ2HqWwGKP8YHmwmN9WfeJNr2/iq0kB22niOz79aaGAe
         /jKJacAKhjfNMHNSgRYNY0RhPvKn7X0PuwmTM1tKe8lHO030EsxrkeTYthn1fLA3K3GU
         eFLt1AEL43ULab1E0LJLtY6kZCoT42r9CRmBlpLDNeM8D1Sgak1W01U64I+ElhQSi2Jv
         XrNA==
X-Gm-Message-State: ABy/qLZAbzzMenEGTg5rtBHDV29owmPyVZt6O2YDh2ZUwBIY6BdmRGQS
        gZT0hp3sC4saf72JwzATPMA=
X-Google-Smtp-Source: APBJJlFv7/5I7AWXqBrqjH99G0yw42Ln/KvWfi8tWAVrdTKQLIl0JKoCcclYyrclOqdTiytefdYlVw==
X-Received: by 2002:a05:6a00:1409:b0:684:bb4a:b86e with SMTP id l9-20020a056a00140900b00684bb4ab86emr6744234pfu.1.1689861640837;
        Thu, 20 Jul 2023 07:00:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ey4-20020a056a0038c400b0065438394fa4sm1237964pfb.90.2023.07.20.07.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 07:00:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b86e19ed-12af-e488-3c21-002be2ad5914@roeck-us.net>
Date:   Thu, 20 Jul 2023 07:00:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     "Marty E. Plummer" <hanetzer@startmail.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>
References: <20230720115805.1510279-1-hanetzer@startmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] hwmon: (pmbus) Add driver fpr Infineon IR35201
In-Reply-To: <20230720115805.1510279-1-hanetzer@startmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/23 04:58, Marty E. Plummer wrote:
> The IR35201 is a dual-loop digital multi-phase buck controller designed for CPU voltage regulation.
> 
> Signed-off-by: Marty E. Plummer <hanetzer@startmail.com>
> ---
>   Documentation/hwmon/index.rst   |  1 +
>   Documentation/hwmon/ir35201.rst | 63 +++++++++++++++++++++++
>   drivers/hwmon/pmbus/Kconfig     |  9 ++++
>   drivers/hwmon/pmbus/Makefile    |  1 +
>   drivers/hwmon/pmbus/ir35201.c   | 89 +++++++++++++++++++++++++++++++++
>   5 files changed, 163 insertions(+)
>   create mode 100644 Documentation/hwmon/ir35201.rst
>   create mode 100644 drivers/hwmon/pmbus/ir35201.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 042e1cf9501b..5b44a268de0d 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -87,6 +87,7 @@ Hardware Monitoring Kernel Drivers
>      ina3221
>      inspur-ipsps1
>      intel-m10-bmc-hwmon
> +   ir35201
>      ir35221
>      ir38064
>      ir36021
> diff --git a/Documentation/hwmon/ir35201.rst b/Documentation/hwmon/ir35201.rst
> new file mode 100644
> index 000000000000..6ca34d4b02a3
> --- /dev/null
> +++ b/Documentation/hwmon/ir35201.rst
> @@ -0,0 +1,63 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Kernel driver ir35201
> +=====================
> +
> +Supported chips:
> +
> +  * Infineon IR35201
> +
> +    Prefix: ir35201
> +    Addresses scanned: -
> +
> +    Datasheet: Publicly available at the Infineon website
> +      https://www.infineon.com/dgdl/Infineon-IR35201MTRPBF-DS-v01_00-EN.pdf?fileId=5546d462576f347501579c95d19772b5
> +
> +Authors:
> +      - Marty E. Plummer <hanetzer@startmail.com>
> +
> +Description
> +-----------
> +
> +The IR35201 is a dual-loop digital multi-phase buck controller designed for
> +CPU voltage regulation.
> +
> +Usage Notes
> +-----------
> +
> +This driver does not probe for PMBus devices. You will have to instantiate
> +devices explicitly.
> +
> +Sysfs attributes
> +----------------
> +
> +======================= ===========================
> +curr1_label             "iin"
> +curr1_input             Measured input current
> +curr1_alarm             Input fault alarm
> +
> +curr2_label             "iout1"
> +curr2_input             Measured output current
> +curr2_alarm             Output over-current alarm
> +
> +in1_label               "vin"
> +in1_input               Measured input voltage
> +in1_alarm               Input under-voltage alarm
> +
> +in2_label               "vout1"
> +in2_input               Measured output voltage
> +in2_alarm               Output over-voltage alarm
> +
> +power1_label            "pin"
> +power1_input            Measured input power
> +power1_alarm            Input under-voltage alarm
> +
> +power2_label            "pout1"
> +power2_input            Measured output power
> +
> +temp1_input             Measured temperature
> +temp1_alarm             Temperature alarm
> +
> +temp2_input             Measured other loop temperature
> +temp2_alarm             Temperature alarm
> +======================= ===========================
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 270b6336b76d..7180823b15bb 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -123,6 +123,15 @@ config SENSORS_INSPUR_IPSPS
>   	  This driver can also be built as a module. If so, the module will
>   	  be called inspur-ipsps.
>   
> +config SENSORS_IR35201
> +	tristate "Infineon IR35201"
> +	help
> +	  If you say yes here you get hardware monitoring support for the
> +	  Infineon IR35201 controller.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called ir35201.
> +
>   config SENSORS_IR35221
>   	tristate "Infineon IR35221"
>   	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 84ee960a6c2d..40729dd14e7a 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_SENSORS_FSP_3Y)	+= fsp-3y.o
>   obj-$(CONFIG_SENSORS_IBM_CFFPS)	+= ibm-cffps.o
>   obj-$(CONFIG_SENSORS_DPS920AB)	+= dps920ab.o
>   obj-$(CONFIG_SENSORS_INSPUR_IPSPS) += inspur-ipsps.o
> +obj-$(CONFIG_SENSORS_IR35201)	+= ir35201.o
>   obj-$(CONFIG_SENSORS_IR35221)	+= ir35221.o
>   obj-$(CONFIG_SENSORS_IR36021)	+= ir36021.o
>   obj-$(CONFIG_SENSORS_IR38064)	+= ir38064.o
> diff --git a/drivers/hwmon/pmbus/ir35201.c b/drivers/hwmon/pmbus/ir35201.c
> new file mode 100644
> index 000000000000..77f77057175a
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/ir35201.c
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Hardware monitoring driver for Infineon IR35201
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include "pmbus.h"
> +
> +static struct pmbus_driver_info ir35201_info = {
> +	.pages = 1,
> +	.format[PSC_VOLTAGE_IN] = linear,
> +	.format[PSC_VOLTAGE_OUT] = linear,
> +	.format[PSC_CURRENT_IN] = linear,
> +	.format[PSC_CURRENT_OUT] = linear,
> +	.format[PSC_POWER] = linear,
> +	.format[PSC_TEMPERATURE] = linear,
> +	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT
> +		| PMBUS_HAVE_IIN | PMBUS_HAVE_IOUT
> +		| PMBUS_HAVE_PIN | PMBUS_HAVE_POUT
> +		| PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2
> +		| PMBUS_HAVE_STATUS_TEMP,

Several supported status registers are missing.

> +};
> +
> +static int ir35201_probe(struct i2c_client *client)
> +{
> +	u8 buf[I2C_SMBUS_BLOCK_MAX];
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_READ_BYTE_DATA
> +					 | I2C_FUNC_SMBUS_READ_WORD_DATA
> +					 | I2C_FUNC_SMBUS_READ_BLOCK_DATA))
> +		return -ENODEV;
> +
> +	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_ID, buf);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Failed to read PMBUS_MFR_ID\n");
> +		return ret;
> +	}
> +	if (ret != 2 || strncmp(buf, "IR", strlen("IR"))) {
> +		dev_err(&client->dev, "MFR_ID unrecognized\n");
> +		return -ENODEV;
> +	}
> +

Did you actually test this ? Datasheet says it is "ASCII 52 49" which
would make it "RI" like IR35221, not "IR". Problem though is that it
seems like the register is writeable via some USER programming,
making it unreliable.

> +	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, buf);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Failed to read PMBUS_MFR_MODEL\n");
> +		return ret;
> +	}
> +	if (ret != 1 || buf[0] != 0x50) {
> +		dev_err(&client->dev, "MFR_MODEL unrecognized\n");
> +		return -ENODEV;
> +	}
> +

The datasheet suggests that PMBUS_MFR_ID and PMBUS_MFR_MODEL can differ based
on some USER register programming. I would suggest to read IC_DEVICE_ID instead
and compare against that (which s supposed to be 0x4d).

On a higher level, I don't see anything special in this chip. Would it be possible
to just add it to pmbus.c ? Something like

	{"ir35201", (kernel_ulong_t)&pmbus_info_one},

should do.

Thanks,
Guenter

> +	return pmbus_do_probe(client, &ir35201_info);
> +}
> +
> +static const struct i2c_device_id ir35201_id[] = {
> +	{ "ir35201", 0},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, ir35201_id);
> +
> +static const struct of_device_id __maybe_unused ir35201_of_id[] = {
> +	{ .compatible = "infineon,ir35201" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ir35201_of_id);
> +
> +static struct i2c_driver ir35201_driver = {
> +	.class = I2C_CLASS_HWMON,
> +	.driver = {
> +		.name = "ir35201",
> +		.of_match_table = of_match_ptr(ir35201_of_id),
> +	},
> +	.probe_new = ir35201_probe,
> +	.id_table = ir35201_id,
> +};
> +
> +module_i2c_driver(ir35201_driver);
> +
> +MODULE_AUTHOR("Marty E. Plummer <hanetzer@startmail.com>");
> +MODULE_DESCRIPTION("PMBus driver for Infineon IR35201");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(PMBUS);

