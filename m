Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFFE7DD197
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345050AbjJaQa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjJaQa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:30:56 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E4CE6;
        Tue, 31 Oct 2023 09:30:52 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6b5af4662b7so5240434b3a.3;
        Tue, 31 Oct 2023 09:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698769851; x=1699374651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/lpDaCfJuPVqQn3wq+j65CPZXraseMu3N51hTvoIQB4=;
        b=OM1dorJwGuPWv6VbFlfsmc7EmBuujMDi9ebVNPyySJwnhm/dzapG0j2eKGVz6al2NP
         miaellwZE6GdHpFszEdSOGAUJFgWFg9GBxKCMphvoCnNBz5aYXB1h8GA4Mx6vwa/apbg
         QkJ4Nd6RKUWl+EuqwPQlylLVkLZKpny/epvXBks64mqVcN/9c5h0ftHnFWjeq0lRUIRQ
         Y0qSa7auLHuD/4huve0aqmJ40O3YqYsx6Qihg1oV7iIGKKVHKvVfCeKLnc8Ne4QgkgCC
         CSz4kSP4V66N61YG7t/gIaHZe2pfjug0O0jQE4PIBwZW+NdmLtlnjilaNIlsM6NDz7wW
         wnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698769851; x=1699374651;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/lpDaCfJuPVqQn3wq+j65CPZXraseMu3N51hTvoIQB4=;
        b=Qgd5icKVnVIC7JfKZSqPSOsj8u+CsvubApsc+licd2xQF7wrJ3kVTlrCxy2Caun3h5
         dUAxYndf0FAN9Z+RCIYuQP1IDzK3jYWsrbyTqoFYHe3s9rM4794uS7KwlBpJJjbNALRj
         rqYyz+Zstc0woJjU034h2Jst37bXhhfiMEhf4olnLzBrOKIT6Z5Mf0/MPKBluUaYQC4M
         bgDFNUAD2YxXHvU/Q175sEZJYQAKW6PTsKMWYto80CYDFT3lixADxa5fRjK9cggH2Vq2
         iZieKfCbm0iGUtqfMVuCexAOMPnpyWyG2O2kUNzP5VeG4ZJs2vbJ/Lnh4YQNJjyHCfLT
         zH5A==
X-Gm-Message-State: AOJu0YzdyTFdPw6olyby7EnC947M1DXKaokNle4tfsonqEI/VOL5MAoi
        zrmHyFEG6Lek5brnKh+CsvU=
X-Google-Smtp-Source: AGHT+IGJPelYgAi+h4+T81nliFrJz0YYD/aiuS1CpxLylneGmbc2JWz0azvxLBp+oSx3DemoFel5XQ==
X-Received: by 2002:a05:6a00:990:b0:6be:35f:631b with SMTP id u16-20020a056a00099000b006be035f631bmr11956910pfg.33.1698769851051;
        Tue, 31 Oct 2023 09:30:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s197-20020a6377ce000000b005b7dd356f75sm1250834pgc.32.2023.10.31.09.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 09:30:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d5076272-ce3c-4a09-92db-f096d78d0706@roeck-us.net>
Date:   Tue, 31 Oct 2023 09:30:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwmon:Add MEC172x Micro Chip driver for Lenovo
 motherboards
Content-Language: en-US
To:     David Ober <dober6023@gmail.com>, linux-hwmon@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, corbet@lwn.net, dober@lenovo.com,
        mpearson-lenovo@squebb.ca
References: <20231031154930.4908-1-dober6023@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20231031154930.4908-1-dober6023@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/23 08:49, David Ober wrote:
> This addition adds in the ability for the system to scan the
> MEC172x EC chip in Lenovo ThinkStation systems to get the
> current fan RPM speeds and the Maximum speed value for each
> fan also provides the current CPU and DIMM thermal status
> 
> Signed-off-by: David Ober <dober6023@gmail.com>
> 
> v2 fixed mixcased naming
> v2 add mutex protection
> v2 removed references to ACPI as it is not used
> v2 added comment to explain why returning a -1 is needed
> ---
>   drivers/hwmon/Kconfig             |  10 +
>   drivers/hwmon/Makefile            |   1 +
>   drivers/hwmon/lenovo-ec-sensors.c | 484 ++++++++++++++++++++++++++++++
>   3 files changed, 495 insertions(+)
>   create mode 100644 drivers/hwmon/lenovo-ec-sensors.c
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index ec38c8892158..821741ec0d2f 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -862,6 +862,16 @@ config SENSORS_LAN966X
>   	  This driver can also be built as a module. If so, the module
>   	  will be called lan966x-hwmon.
>   
> +config SENSORS_LENOVO_EC
> +        tristate "Microchip MEC172X Chip for Lenovo ThinkStation"
> +        depends on I2C
> +        help
> +          If you say yes here you get support for LENOVO
> +          EC Sensors on newer ThinkStation systems
> +
> +          This driver can also be built as a module. If so, the module
> +          will be called lenovo_ec_sensors.
> +
>   config SENSORS_LINEAGE
>   	tristate "Lineage Compact Power Line Power Entry Module"
>   	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 4ac9452b5430..aa3c2dc390ec 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -104,6 +104,7 @@ obj-$(CONFIG_SENSORS_JC42)	+= jc42.o
>   obj-$(CONFIG_SENSORS_K8TEMP)	+= k8temp.o
>   obj-$(CONFIG_SENSORS_K10TEMP)	+= k10temp.o
>   obj-$(CONFIG_SENSORS_LAN966X)	+= lan966x-hwmon.o
> +obj-$(CONFIG_SENSORS_LENOVO_EC)	+= lenovo-ec-sensors.o
>   obj-$(CONFIG_SENSORS_LINEAGE)	+= lineage-pem.o
>   obj-$(CONFIG_SENSORS_LOCHNAGAR)	+= lochnagar-hwmon.o
>   obj-$(CONFIG_SENSORS_LM63)	+= lm63.o
> diff --git a/drivers/hwmon/lenovo-ec-sensors.c b/drivers/hwmon/lenovo-ec-sensors.c
> new file mode 100644
> index 000000000000..e2b14b3aea08
> --- /dev/null
> +++ b/drivers/hwmon/lenovo-ec-sensors.c
> @@ -0,0 +1,484 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * HWMON driver for MEC172x chip that publishes some sensor values
> + * via the embedded controller registers specific to Lenovo Systems.
> + *
> + * Copyright (C) 2023 David Ober (Lenovo) <dober@lenovo.com>
> + *
> + * EC provides:
> + * - CPU temperature
> + * - DIMM temperature
> + * - Chassis zone temperatures
> + * - CPU fan RPM
> + * - DIMM fan RPM
> + * - Chassis fans RPM
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/delay.h>
> +#include <linux/hwmon.h>
> +#include <linux/ioport.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/units.h>
> +
> +#define MCHP_SING_IDX			0x0000
> +#define MCHP_EMI0_APPLICATION_ID	0x090C
> +#define MCHP_EMI0_EC_ADDRESS_LSB	0x0902
> +#define MCHP_EMI0_EC_ADDRESS_MSB	0x0903
> +#define MCHP_EMI0_EC_DATA_BYTE0		0x0904
> +#define MCHP_EMI0_EC_DATA_BYTE1		0x0905
> +#define MCHP_EMI0_EC_DATA_BYTE2		0x0906
> +#define MCHP_EMI0_EC_DATA_BYTE3		0x0907
> +
> +#define io_write8(a, b)	outb_p(b, a)
> +#define io_read8(a)	inb_p(a)
> +
> +static inline uint8_t
> +get_ec_reg(unsigned char page, unsigned char index)
> +{
> +	u8 onebyte;
> +	unsigned short m_index;
> +	unsigned short phy_index = page * 256 + index;
> +
> +	if (io_read8(MCHP_EMI0_APPLICATION_ID) != 0) /* EMI access locked */
> +		return -1;
> +

Whatever the explanation is, returning -1 from a function declared as
returning uint8_t doesn't make sense. Not checking the return
code in the calling function makes even less sense.

> +	io_write8(MCHP_EMI0_APPLICATION_ID, 0x01);
> +
> +	m_index = phy_index & 0x7FFC;
> +	io_write8(MCHP_EMI0_EC_ADDRESS_LSB, m_index);
> +	io_write8(MCHP_EMI0_EC_ADDRESS_MSB, m_index >> 8);
> +
> +	switch (phy_index & 0x0003) {
> +	case 0:
> +		onebyte = io_read8(MCHP_EMI0_EC_DATA_BYTE0);
> +		break;
> +	case 1:
> +		onebyte = io_read8(MCHP_EMI0_EC_DATA_BYTE1);
> +		break;
> +	case 2:
> +		onebyte = io_read8(MCHP_EMI0_EC_DATA_BYTE2);
> +		break;
> +	case 3:
> +		onebyte = io_read8(MCHP_EMI0_EC_DATA_BYTE3);
> +		break;
> +	}
> +
> +	io_write8(MCHP_EMI0_APPLICATION_ID, 0x01);  /* write same data to clean */
> +	return onebyte;
> +}
> +
> +static const char * const systems[] = {
> +	"Tomcat",
> +	"Hornet",
> +	"Falcon",
> +	"Manta_",
> +};
> +
> +static const char * const lenovo_px_ec_temp_label[] = {
> +	"CPU1",
> +	"CPU2",
> +	"R_DIMM1",
> +	"L_DIMM1",
> +	"R_DIMM2",
> +	"L_DIMM2",
> +	"PCH",
> +	"M2_R",
> +	"M2_Z1R",
> +	"M2_Z2R",
> +	"PCI_Z1",
> +	"PCI_Z2",
> +	"PCI_Z3",
> +	"PCI_Z4",
> +	"AMB",
> +};
> +
> +static const char * const lenovo_gen_ec_temp_label[] = {
> +	"CPU1",
> +	"",
> +	"R_DIMM",
> +	"L_DIMM",
> +	"",
> +	"",
> +	"PCH",
> +	"M2_R",
> +	"M2_Z1R",
> +	"M2_Z2R",
> +	"PCI_Z1",
> +	"PCI_Z2",
> +	"PCI_Z3",
> +	"PCI_Z4",
> +	"AMB",
> +};
> +
> +static const char * const px_ec_fan_label[] = {
> +	"CPU1_Fan",
> +	"CPU2_Fan",
> +	"Front_Fan1-1",
> +	"Front_Fan1-2",
> +	"Front_Fan2",
> +	"Front_Fan3",
> +	"MEM_Fan1",
> +	"MEM_Fan2",
> +	"Rear_Fan1",
> +	"Rear_Fan2",
> +	"Flex_Bay_Fan1",
> +	"Flex_Bay_Fan2",
> +	"Flex_Bay_Fan2",
> +	"PSU_HDD_Fan",
> +	"PSU1_Fan",
> +	"PSU2_Fan",
> +};
> +
> +static const char * const p7_ec_fan_label[] = {
> +	"CPU1_Fan",
> +	"",
> +	"HP_CPU_Fan1",
> +	"HP_CPU_Fan2",
> +	"PCIE1_4_Fan",
> +	"PCIE5_7_Fan",
> +	"MEM_Fan1",
> +	"MEM_Fan2",
> +	"Rear_Fan1",
> +	"",
> +	"BCB_Fan",
> +	"Flex_Bay_Fan",
> +	"",
> +	"",
> +	"PSU_Fan",
> +	"",
> +};
> +
> +static const char * const p5_ec_fan_label[] = {
> +	"CPU_Fan",
> +	"",
> +	"",
> +	"",
> +	"",
> +	"HDD_Fan",
> +	"Duct_Fan1",
> +	"MEM_Fan",
> +	"Rear_Fan",
> +	"",
> +	"Front_Fan",
> +	"Flex_Bay_Fan",
> +	"",
> +	"",
> +	"PSU_Fan",
> +	"",
> +};
> +
> +static const char * const p7_amd_ec_fan_label[] = {
> +	"CPU1_Fan",
> +	"CPU2_Fan",
> +	"HP_CPU_Fan1",
> +	"HP_CPU_Fan2",
> +	"PCIE1_4_Fan",
> +	"PCIE5_7_Fan",
> +	"DIMM1_Fan1",
> +	"DIMM1_Fan2",
> +	"DIMM2_Fan1",
> +	"DIMM2_Fan2",
> +	"Rear_Fan",
> +	"HDD_Bay_Fan",
> +	"Flex_Bay_Fan",
> +	"",
> +	"PSU_Fan",
> +	"",
> +};
> +
> +struct ec_sensors_data {
> +	struct mutex mec_mutex; /* lock for sensors write */
> +	u8 platform_id;
> +	const char *const *fan_labels;
> +	const char *const *temp_labels;
> +};
> +
> +static int
> +lenovo_ec_do_read_temp(struct ec_sensors_data *data, u32 attr, int channel, long *val)
> +{
> +	u8   LSB;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		mutex_lock(&data->mec_mutex);
> +		LSB = get_ec_reg(2, 0x81 + channel);
> +		mutex_unlock(&data->mec_mutex);
> +		if (LSB > 0x40) {
> +			*val = (LSB - 0x40) * 1000;
> +		} else {
> +			*val = 0;
> +			return -1;

No. Return valid Linux error codes. Also, error handling
should come first, and writing 0 into *val when returning
an error is useless.

Also, get_ec_reg() returns 0xff if "EMI access locked",
which is treated as valid here (and elsewhere). This doesn't
make sense to me.

> +		}
> +		return 0;
> +	default:
> +		break;
> +	}
> +	return -EOPNOTSUPP;
> +}
> +
> +static int
> +lenovo_ec_do_read_fan(struct ec_sensors_data *data, u32 attr, int channel, long *val)
> +{
> +	u8    LSB, MSB;
> +
> +	channel *= 2;
> +	switch (attr) {
> +	case hwmon_fan_input:
> +		mutex_lock(&data->mec_mutex);
> +		LSB = get_ec_reg(4, 0x60 + channel);
> +		MSB = get_ec_reg(4, 0x61 + channel);
> +		mutex_unlock(&data->mec_mutex);
> +		if ((MSB << 8) + LSB != 0) {

This is confusing. Why not just "if (MSB || LSB)" ?

> +			mutex_lock(&data->mec_mutex);
> +			LSB = get_ec_reg(4, 0x20 + channel);
> +			MSB = get_ec_reg(4, 0x21 + channel);
> +			mutex_unlock(&data->mec_mutex);
> +			*val = (MSB << 8) + LSB;
> +			return 0;
> +		}
> +		return -1; /* Returning -1 here has the sensors tool mark the FAN speed as N/A */

-1 translates to -EPERM. No, this is unacceptable.
Please return valid Linux error codes. If you _really_ think
that this should return -EPERM, explain in detail (and use -EPERM).
FWIW, there is -ENODATA which is displayed in the "sensors"
command as N/A. Maybe that is what you want.

> +	case hwmon_fan_max:
> +		mutex_lock(&data->mec_mutex);
> +		LSB = get_ec_reg(4, 0x60 + channel);
> +		MSB = get_ec_reg(4, 0x61 + channel);
> +		mutex_unlock(&data->mec_mutex);
> +		if ((MSB << 8) + LSB != 0) {
> +			mutex_lock(&data->mec_mutex);
> +			LSB = get_ec_reg(4, 0x40 + channel);
> +			MSB = get_ec_reg(4, 0x41 + channel);
> +			mutex_unlock(&data->mec_mutex);
> +			*val = (MSB << 8) + LSB;
> +		} else {
> +			*val = 0;
> +		}
> +		return 0;
> +	case hwmon_fan_min:
> +	case hwmon_fan_div:
> +	case hwmon_fan_alarm:
> +		break;
> +	default:
> +		break;
> +	}
> +	return -EOPNOTSUPP;
> +}
> +
> +static int get_platform(struct ec_sensors_data *data)
> +{
> +	char system_type[6];
> +	int ret = -1;
> +	int idx;
> +
> +	for (idx = 0 ; idx < 6 ; idx++)
> +		mutex_lock(&data->mec_mutex);
> +		system_type[idx] = get_ec_reg(0xC, (0x10 + idx));


Please avoid unnecessary ( ).

> +		mutex_unlock(&data->mec_mutex);
> +
> +	for (idx = 0 ; idx < 4 ; idx++) {
> +		if (strcmp(systems[idx], system_type) == 0) {

Use "!strcmp()".

The length of system_type[] is 6, all fields are written,
and the data is not initialized. There is no guarantee that the
value at string[6] is '\0', and either case strcmp() will read
past the end of the array.

> +			ret = idx;
> +			break;
> +		}
> +	}
> +	return ret;
> +}
> +
> +static int
> +lenovo_ec_hwmon_read_string(struct device *dev, enum hwmon_sensor_types type,
> +			    u32 attr, int channel, const char **str)
> +{
> +	struct ec_sensors_data *state = dev_get_drvdata(dev);
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		*str = state->temp_labels[channel];
> +		break;
> +
> +	case hwmon_fan:
> +		*str = state->fan_labels[channel];

Some of those strings are empty. Does that mean the fans don't exist ?
If so, don't instantiate them. If it is simply unknown what the fans
do, don't instantiate the attribute either. Returning an empty
string as "label" is not acceptable.

> +		break;
> +	default:
> +		return -EOPNOTSUPP; /* unreachable */

Kind of inconsistent comment. Please drop.

> +	}
> +	return 0;
> +}
> +
> +static int
> +lenovo_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +		     u32 attr, int channel, long *val)
> +{
> +	struct ec_sensors_data *data = dev_get_drvdata(dev);
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		return lenovo_ec_do_read_temp(data, attr, channel, val);
> +	case hwmon_fan:
> +		return lenovo_ec_do_read_fan(data, attr, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static umode_t
> +lenovo_ec_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
> +			   u32 attr, int channel)
> +{
> +	switch (type) {
> +	case hwmon_temp:
> +		if (attr == hwmon_temp_input || attr == hwmon_temp_label)
> +			return 0444;
> +		break;
> +	case hwmon_fan:
> +		if (attr == hwmon_fan_input || attr == hwmon_fan_max || attr == hwmon_fan_label)
> +			return 0444;
> +		break;
> +	default:
> +		return 0;
> +	}
> +	return 0;
> +}
> +
> +static const struct hwmon_channel_info *lenovo_ec_hwmon_info[] = {
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL),
> +	HWMON_CHANNEL_INFO(fan,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MAX),
> +	NULL
> +};
> +
> +static const struct hwmon_ops lenovo_ec_hwmon_ops = {
> +	.is_visible = lenovo_ec_hwmon_is_visible,
> +	.read = lenovo_ec_hwmon_read,
> +	.read_string = lenovo_ec_hwmon_read_string,
> +};
> +
> +static struct hwmon_chip_info lenovo_ec_chip_info = {
> +	.ops = &lenovo_ec_hwmon_ops,
> +	.info = lenovo_ec_hwmon_info,
> +};
> +
> +static int lenovo_ec_probe(struct platform_device *pdev)
> +{
> +	struct device *hwdev;
> +	struct ec_sensors_data *ec_data;
> +	const struct hwmon_chip_info *chip_info;
> +	struct device *dev = &pdev->dev;
> +
> +	ec_data = devm_kzalloc(dev, sizeof(struct ec_sensors_data), GFP_KERNEL);
> +	if (!ec_data)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, ec_data);
> +
> +	chip_info = &lenovo_ec_chip_info;
> +
> +	mutex_lock(&ec_data->mec_mutex);

mutex_init() missing.

> +	if (io_read8(MCHP_EMI0_APPLICATION_ID) != 0) { /* check EMI Application BIT */
> +		io_write8(0x90C, io_read8(0x90C)); /* set EMI Application BIT to 0 */
> +	}
> +	io_write8(MCHP_EMI0_EC_ADDRESS_LSB, MCHP_SING_IDX);
> +	io_write8(MCHP_EMI0_EC_ADDRESS_MSB, MCHP_SING_IDX >> 8);

This is really unacceptable. It pretty much immediately writes
into i/o registers. I am quite sure this would crash or have
undesirable impact on lots of non-Lenovo systems.

Also, the driver should reserve the register i/o range it uses, not just
use it blindly.

> +	mutex_unlock(&ec_data->mec_mutex);
> +
> +	if ((io_read8(MCHP_EMI0_EC_DATA_BYTE0) == 'M') &&
> +	    (io_read8(MCHP_EMI0_EC_DATA_BYTE1) == 'C') &&
> +	    (io_read8(MCHP_EMI0_EC_DATA_BYTE2) == 'H') &&
> +	    (io_read8(MCHP_EMI0_EC_DATA_BYTE3) == 'P')) {
> +		ec_data->platform_id = get_platform(ec_data);
> +		switch (ec_data->platform_id) {
> +		case 0:
> +			ec_data->fan_labels = px_ec_fan_label;
> +			ec_data->temp_labels = lenovo_px_ec_temp_label;
> +			break;
> +		case 1:
> +			ec_data->fan_labels = p7_ec_fan_label;
> +			ec_data->temp_labels = lenovo_gen_ec_temp_label;
> +			break;
> +		case 2:
> +			ec_data->fan_labels = p5_ec_fan_label;
> +			ec_data->temp_labels = lenovo_gen_ec_temp_label;
> +			break;
> +		case 3:
> +			ec_data->fan_labels = p7_amd_ec_fan_label;
> +			ec_data->temp_labels = lenovo_gen_ec_temp_label;

There is only a single set of temperature labels. ec_data->temp_labels
is therefore unnecessary and lenovo_gen_ec_temp_label can be used directly.

> +			break;
> +		default:
> +			dev_err(dev, "Unknown ThinkStation Model");

Maybe better "Unsupported"

> +			return -EINVAL;

				-ENODEV;

> +		}
> +
> +		hwdev = devm_hwmon_device_register_with_info(dev, "lenovo_ec",
> +							     ec_data,
> +							     chip_info, NULL);
> +
> +		return PTR_ERR_OR_ZERO(hwdev);
> +	}
> +	return -ENODEV;

Error handling should come first.

> +}
> +
> +static struct platform_driver lenovo_ec_sensors_platform_driver = {
> +	.driver = {
> +		.name	= "lenovo-ec-sensors",
> +	},
> +	.probe = lenovo_ec_probe,
> +};
> +
> +static struct platform_device *lenovo_ec_sensors_platform_device;
> +
> +static int __init lenovo_ec_init(void)
> +{
> +	lenovo_ec_sensors_platform_device =
> +		platform_create_bundle(&lenovo_ec_sensors_platform_driver,
> +				       lenovo_ec_probe, NULL, 0, NULL, 0);
> +
> +	if (IS_ERR(lenovo_ec_sensors_platform_device))
> +		return PTR_ERR(lenovo_ec_sensors_platform_device);
> +
> +	return 0;
> +}

Isn't there a means to determine if this is a supported Lenovo system
prior to calling the probe function ? DMI data, maybe ?

> +
> +static void __exit lenovo_ec_exit(void)
> +{
> +	platform_device_unregister(lenovo_ec_sensors_platform_device);
> +	platform_driver_unregister(&lenovo_ec_sensors_platform_driver);
> +}
> +
> +module_init(lenovo_ec_init);
> +module_exit(lenovo_ec_exit);
> +
> +MODULE_AUTHOR("David Ober <dober@lenovo.com>");
> +MODULE_DESCRIPTION("HWMON driver for MEC172x EC sensors on LENOVO motherboards");
> +MODULE_LICENSE("GPL");

