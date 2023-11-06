Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAFE7E1BA4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjKFIFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjKFIFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:05:16 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2129B;
        Mon,  6 Nov 2023 00:05:13 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cc2f17ab26so28332825ad.0;
        Mon, 06 Nov 2023 00:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699257912; x=1699862712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N09PcoGLLyn3TXL/ksZQjeaRYWu7Qp2r7aIZDVfbVi0=;
        b=leuYKql707XRTHc7eu1GL0GDX5z9zHI2QPWFPwPnqzJgO6V1z4CN4g5ETXIVBXeoSb
         8gFv8i6xjCSW63oyIx24MCBo0tnAthVtRXqFcffl7nfs/cmeM7n4REhWq3hvmSJ40AhO
         8C/k5j3hxXVwP9Kood8+swU+AYCUPgWDMe9AbFrAYDacrcXSZQqzt+1zmfGzaj7APm3G
         wqbwCu9y+M7i/ATb/LiEZSMtwKtXlIMGhFwQfKyiSPAwohIl78pNMeMEXaPTztguqGez
         CxQcLvEoKWzZ33Rz/ZHWtZwz8SAaW8Og6Ts+ZyTZV4+YQUyw7eFr7UdmRC3xx4flQ1dK
         If+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699257912; x=1699862712;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N09PcoGLLyn3TXL/ksZQjeaRYWu7Qp2r7aIZDVfbVi0=;
        b=gdVgHVQ3URAd502olHioqGr81Cg7qNzZVzChA3OOyRUgJ1qMGXQDQhfWe+xuY0aUfd
         aZ7qHfiOk9nJeomJXwSn7f1t2/olfDhaj8BaLoxK2UI41ga8HyZRbriLOHZNNG/KfJQt
         YysIERZXdckJksz1HUXDEIpAhiSe33TeUxo9+IlvVK27kowcol7BacPXdysMSQjI5uRu
         Je601wbsZI9xy4iCzG5B3LB8Kzw2WzpnEA1OHVBKRhOGTHFY5wToyQh0WnH6FWxzX7gg
         M9Ty/CF0qH9HqSPfOB6wL4PGSd4wHRZmZPa41WMEVXApBhq8RXuMRlW8HMX55mGTevwI
         nZAw==
X-Gm-Message-State: AOJu0YzXCYmyyTtCTyyVO/V8RR7Kx1ZugJ6gI+uV6p2jksi4pC6OiPu5
        G0bphqeJEVS1Im3RNgaJvA1VZuRzjc0=
X-Google-Smtp-Source: AGHT+IFqpeSTFsJKgyrHyqKq/HcJ/QEldOhHc20I7bDjngPTcBCAQwbyj0MUWfRPDtcO27GGRkLooQ==
X-Received: by 2002:a17:902:f093:b0:1cc:2f9d:6e9b with SMTP id p19-20020a170902f09300b001cc2f9d6e9bmr17972691pla.20.1699257912320;
        Mon, 06 Nov 2023 00:05:12 -0800 (PST)
Received: from [10.10.14.80] (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id ji5-20020a170903324500b001cc32261bdfsm5315059plb.38.2023.11.06.00.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 00:05:11 -0800 (PST)
Message-ID: <b635d3b1-8854-443f-ba16-8df1ff8f2019@gmail.com>
Date:   Mon, 6 Nov 2023 16:02:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] hwmon: (pmbus) Add support for MPS Multi-phase
 mp5990
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>, patrick@stwcx.xyz,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20231103080128.1204218-1-peteryin.openbmc@gmail.com>
 <20231103080128.1204218-3-peteryin.openbmc@gmail.com>
 <c74beccd-26ea-4e63-906b-bd5508465cbc@roeck-us.net>
From:   PeterYin <peteryin.openbmc@gmail.com>
In-Reply-To: <c74beccd-26ea-4e63-906b-bd5508465cbc@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Guenter Roeck 於 11/3/23 22:35 寫道:
> On 11/3/23 01:01, Peter Yin wrote:
>> Add support for mp5990 device from Monolithic Power Systems, Inc. (MPS)
>> vendor. This is a Hot-Swap Controller.
>>
>> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
>> ---
>>   Documentation/hwmon/index.rst  |  1 +
>>   Documentation/hwmon/mp5990.rst | 84 +++++++++++++++++++++++++++++++
>>   drivers/hwmon/pmbus/Kconfig    |  9 ++++
>>   drivers/hwmon/pmbus/Makefile   |  1 +
>>   drivers/hwmon/pmbus/mp5990.c   | 90 ++++++++++++++++++++++++++++++++++
>>   5 files changed, 185 insertions(+)
>>   create mode 100644 Documentation/hwmon/mp5990.rst
>>   create mode 100644 drivers/hwmon/pmbus/mp5990.c
>>
>> diff --git a/Documentation/hwmon/index.rst 
>> b/Documentation/hwmon/index.rst
>> index 042e1cf9501b..8c70e10fc795 100644
>> --- a/Documentation/hwmon/index.rst
>> +++ b/Documentation/hwmon/index.rst
>> @@ -157,6 +157,7 @@ Hardware Monitoring Kernel Drivers
>>      mp2888
>>      mp2975
>>      mp5023
>> +   mp5990
>>      nct6683
>>      nct6775
>>      nct7802
>> diff --git a/Documentation/hwmon/mp5990.rst 
>> b/Documentation/hwmon/mp5990.rst
>> new file mode 100644
>> index 000000000000..8fc4e388ff7b
>> --- /dev/null
>> +++ b/Documentation/hwmon/mp5990.rst
>> @@ -0,0 +1,84 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +Kernel driver mp5990
>> +====================
>> +
>> +Supported chips:
>> +
>> +  * MPS MP5990
>> +
>> +    Prefix: 'mp5990'
>> +
>> +  * Datasheet
>> +
>> +    Publicly available at the MPS website : 
>> https://www.monolithicpower.com/en/mp5990.html
>> +
>> +Author:
>> +
>> +    Peter Yin <peteryin.openbmc@gmail.com>
>> +
>> +Description
>> +-----------
>> +
>> +This driver implements support for Monolithic Power Systems, Inc. (MPS)
>> +MP5990 Hot-Swap Controller.
>> +
>> +Device complaint with:
> 
> compliant
> 
Thanks, I will fix it.
>> +
>> +- PMBus rev 1.3 interface.
>> +
>> +Device supports direct format for reading input voltage, output voltage,
>> +output current, input power and temperature.
>> +
>> +The driver exports the following attributes via the 'sysfs' files
>> +for input voltage:
>> +
>> +**in1_input**
>> +
>> +**in1_label**
>> +
>> +**in1_max**
>> +
>> +**in1_max_alarm**
>> +
>> +**in1_min**
>> +
>> +**in1_min_alarm**
>> +
>> +The driver provides the following attributes for output voltage:
>> +
>> +**in2_input**
>> +
>> +**in2_label**
>> +
>> +**in2_alarm**
>> +
>> +The driver provides the following attributes for output current:
>> +
>> +**curr1_input**
>> +
>> +**curr1_label**
>> +
>> +**curr1_alarm**
>> +
>> +**curr1_max**
>> +
>> +The driver provides the following attributes for input power:
>> +
>> +**power1_input**
>> +
>> +**power1_label**
>> +
>> +**power1_alarm**
>> +
>> +The driver provides the following attributes for temperature:
>> +
>> +**temp1_input**
>> +
>> +**temp1_max**
>> +
>> +**temp1_max_alarm**
>> +
>> +**temp1_crit**
>> +
>> +**temp1_crit_alarm**
>> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
>> index 270b6336b76d..65a116f7744d 100644
>> --- a/drivers/hwmon/pmbus/Kconfig
>> +++ b/drivers/hwmon/pmbus/Kconfig
>> @@ -326,6 +326,15 @@ config SENSORS_MP5023
>>         This driver can also be built as a module. If so, the module will
>>         be called mp5023.
>> +config SENSORS_MP5990
>> +    tristate "MPS MP5990"
>> +    help
>> +      If you say yes here you get hardware monitoring support for MPS
>> +      MP5990.
>> +
>> +      This driver can also be built as a module. If so, the module will
>> +      be called mp5990.
>> +
>>   config SENSORS_MPQ7932_REGULATOR
>>       bool "Regulator support for MPQ7932"
>>       depends on SENSORS_MPQ7932 && REGULATOR
>> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
>> index 84ee960a6c2d..212d9ca0acc9 100644
>> --- a/drivers/hwmon/pmbus/Makefile
>> +++ b/drivers/hwmon/pmbus/Makefile
>> @@ -35,6 +35,7 @@ obj-$(CONFIG_SENSORS_MAX8688)    += max8688.o
>>   obj-$(CONFIG_SENSORS_MP2888)    += mp2888.o
>>   obj-$(CONFIG_SENSORS_MP2975)    += mp2975.o
>>   obj-$(CONFIG_SENSORS_MP5023)    += mp5023.o
>> +obj-$(CONFIG_SENSORS_MP5990)    += mp5990.o
>>   obj-$(CONFIG_SENSORS_MPQ7932)    += mpq7932.o
>>   obj-$(CONFIG_SENSORS_PLI1209BC)    += pli1209bc.o
>>   obj-$(CONFIG_SENSORS_PM6764TR)    += pm6764tr.o
>> diff --git a/drivers/hwmon/pmbus/mp5990.c b/drivers/hwmon/pmbus/mp5990.c
>> new file mode 100644
>> index 000000000000..c3b31af9f750
>> --- /dev/null
>> +++ b/drivers/hwmon/pmbus/mp5990.c
>> @@ -0,0 +1,90 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Driver for MPS MP5990 Hot-Swap Controller
>> + */
>> +
>> +#include <linux/i2c.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/pmbus.h>
>> +#include "pmbus.h"
>> +
>> +static int mp5990_read_byte_data(struct i2c_client *client, int page, 
>> int reg)
>> +{
>> +    switch (reg) {
>> +    case PMBUS_VOUT_MODE:
>> +        /*
>> +          Enforce VOUT direct format, C4h reg BIT9
>> +          default val is not match vout format
>> +         */
> 
> /*
>   * Please use proper multi-line comments. Also, the problem here is 
> that the
>   * chip does not support the VOUT_MODE command, which should be mentioned.
>   *
>   * On top of that, overwriting PMBUS_VOUT_MODE result from the chip is 
> only
>   * necessary if the chip does not return an error when reading the value.
>   * If that is the case, it should be mentioned in the comment. The above
>   * does not explain why this would be needed, even if the command is not
>   * (officially) supported by the chip. What does it return that requires
>   * an overwrite ?
>   */
>
The datasheet does not support the VOUT command, but the device responds 
with a default value of 0x17. In the standard, 0x17 represents linear mode.
>> +        return PB_VOUT_MODE_DIRECT;
>> +    default:
>> +        return -ENODATA;
>> +    }
>> +}
>> +
>> +static struct pmbus_driver_info mp5990_info = {
>> +    .pages = 1,
>> +    .format[PSC_VOLTAGE_IN] = direct,
>> +    .format[PSC_VOLTAGE_OUT] = direct,
>> +    .format[PSC_CURRENT_OUT] = direct,
>> +    .format[PSC_POWER] = direct,
>> +    .format[PSC_TEMPERATURE] = direct,
>> +    .m[PSC_VOLTAGE_IN] = 32,
>> +    .b[PSC_VOLTAGE_IN] = 0,
>> +    .R[PSC_VOLTAGE_IN] = 0,
>> +    .m[PSC_VOLTAGE_OUT] = 32,
>> +    .b[PSC_VOLTAGE_OUT] = 0,
>> +    .R[PSC_VOLTAGE_OUT] = 0,
>> +    .m[PSC_CURRENT_OUT] = 16,
>> +    .b[PSC_CURRENT_OUT] = 0,
>> +    .R[PSC_CURRENT_OUT] = 0,
>> +    .m[PSC_POWER] = 1,
>> +    .b[PSC_POWER] = 0,
>> +    .R[PSC_POWER] = 0,
>> +    .m[PSC_TEMPERATURE] = 1,
>> +    .b[PSC_TEMPERATURE] = 0,
>> +    .R[PSC_TEMPERATURE] = 0,
>> +    .func[0] =
>> +        PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_PIN |
>> +        PMBUS_HAVE_TEMP | PMBUS_HAVE_IOUT |
>> +        PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP,
>> +    .read_byte_data = mp5990_read_byte_data,
>> +};
>> +
>> +static int mp5990_probe(struct i2c_client *client)
>> +{
>> +    int ret;
>> +
>> +    ret = i2c_smbus_write_byte_data(client, PMBUS_VOUT_MODE,
>> +                    PB_VOUT_MODE_DIRECT);
> 
> According to the datasheet, the chip does not support the VOUT_MODE
> command. Supposedly, direct vs. linear mode is selected with bit 9
> of EFUSE_CFG. Even if the chip happens to "silently" support the command,
> the official command should be used to select the chip mode.
> 
> Next question: Why use direct mode ? Linear mode is supported and would
> be much more flexible.
>
The MP5990, the VOUT linear mode is linear11, not linear16. Therefore, 
we should enforce the VOUT in the direct format.

>> +    if (ret < 0)
>> +        return ret;
>> +    return pmbus_do_probe(client, &mp5990_info);
>> +}
>> +
>> +static const struct of_device_id mp5990_of_match[] = {
>> +    { .compatible = "mps,mp5990" },
>> +    {}
>> +};
>> +
>> +static const struct i2c_device_id mp5990_id[] = {
>> +    {"mp5990", 0},
>> +    { }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, mp5990_id);
>> +
>> +static struct i2c_driver mp5990_driver = {
>> +    .driver = {
>> +           .name = "mp5990",
>> +           .of_match_table = of_match_ptr(mp5990_of_match),
> 
> Using of_match_ptr() will result in a build failure if CONFIG_OF=n.
>
Should I use .of_match_table = mp5990_of_match, ?

>> +    },
>> +    .probe = mp5990_probe,
>> +    .id_table = mp5990_id,
>> +};
>> +module_i2c_driver(mp5990_driver);
>> +
>> +MODULE_AUTHOR("Peter Yin <peter.yin@quantatw.com>");
>> +MODULE_DESCRIPTION("PMBus driver for MP5990 HSC");
>> +MODULE_LICENSE("GPL");
>> +MODULE_IMPORT_NS(PMBUS);
> 
