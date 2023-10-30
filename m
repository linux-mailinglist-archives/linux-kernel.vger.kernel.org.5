Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936467DBF8C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 19:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjJ3SL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 14:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbjJ3SLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 14:11:23 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2779C4;
        Mon, 30 Oct 2023 11:11:19 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a92782615dso47438517b3.2;
        Mon, 30 Oct 2023 11:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698689479; x=1699294279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=D5K8VtpNXTJmPFNIBQiDPDiYWRNtBsUHwHinvai6CSQ=;
        b=N9YqgwnhLse/FzVSn32XLpEAj6vtGRRKpcWzSGvWgmy3J2il7dvmWt/Zs6wCxBs0+E
         DddMd2kvSbEijnPUSNL71x+MV6NYvArRn4PatTDyiGR+LYHpZU28OjbEBFVL6Cen7fbL
         7qondhcwPGmZrkNsYycupQopjx+z0PbLtpe+1EoCpM3dB1U44K8WU1kc1VAJAuDBnWXT
         FvS9c6dbLRQwhKkXbg93gOSCi/qWO0pMGMVl45IKRMj9wlg227mH2q6IQQDpNMllZa+0
         p1UxapVYIPqiyM0cCNiZBCyJhdV3Pi87pgISvzVPZb4ArLn48ci1hQujBdQ+UaGE8RKI
         3g3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698689479; x=1699294279;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5K8VtpNXTJmPFNIBQiDPDiYWRNtBsUHwHinvai6CSQ=;
        b=FHqbsu45CpA+PR1fBRFFYrKoXOBUQq81hJQsjNIsTNLCEO93uGhp3xZ2+su840lX5g
         79DB8geRl05qCwgONx35rIBrzV66KAomFgy4QbSc1T/illKkvy09MiaKdjIX+6fapGuG
         dfPtz0pi12kTVYQv9JJrQf7vC1f8BQQy3OwWALUuqW9lsv1j8rra/EJ2glb+2R0KX8A4
         qQdw1x7OKkWsPRnSj0+rbqsJMp2Dq5MbUS4jEwyIFdc27XHUgtA+zVx6O0DePjZWxtVH
         AU7BWZ5vtbTScVRxf2k+7dNfI4N/XIjdM3a6ae85+E7iKPEo78yGNQrp6bMeKEHOetgS
         be5w==
X-Gm-Message-State: AOJu0Yzg/H82j/hHVap2ikvE7yBebZPadtQy5PO9klmpiZZXGyw3j8C6
        22PfGcDPcisLePFPpXQZ+SNogX+RPTY=
X-Google-Smtp-Source: AGHT+IEFFOpgVFsW+5cQGVTM47gX31ukYr/jnbIHln4/98GbUjgCVmY9rT3rKX/JwXDVI0YPAFcavw==
X-Received: by 2002:a05:690c:d84:b0:5a8:1d44:256 with SMTP id da4-20020a05690c0d8400b005a81d440256mr5421892ywb.7.1698689478675;
        Mon, 30 Oct 2023 11:11:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r18-20020a81c312000000b00592236855cesm4535803ywk.61.2023.10.30.11.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 11:11:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ce07d951-f492-4137-9588-1d55001e0003@roeck-us.net>
Date:   Mon, 30 Oct 2023 11:11:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drivers: rtc: max31335: initial commit
Content-Language: en-US
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20231030115016.97823-1-antoniu.miclaus@analog.com>
 <20231030115016.97823-3-antoniu.miclaus@analog.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20231030115016.97823-3-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/23 04:50, Antoniu Miclaus wrote:
> RTC driver for MAX31335 ±2ppm Automotive Real-Time Clock with
> Integrated MEMS Resonator.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>   drivers/rtc/Kconfig        |  11 +
>   drivers/rtc/Makefile       |   1 +
>   drivers/rtc/rtc-max31335.c | 759 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 771 insertions(+)
>   create mode 100644 drivers/rtc/rtc-max31335.c
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index d7502433c78a..11c7d7fe1e85 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -373,6 +373,17 @@ config RTC_DRV_MAX8997
>   	  This driver can also be built as a module. If so, the module
>   	  will be called rtc-max8997.
>   
> +config RTC_DRV_MAX31335
> +	tristate "Analog Devices MAX31335"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  If you say yes here you get support for the Analog Devices
> +	  MAX31335.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called rtc-max31335.
> +
>   config RTC_DRV_MAX77686
>   	tristate "Maxim MAX77686"
>   	depends on MFD_MAX77686 || MFD_MAX77620 || MFD_MAX77714 || COMPILE_TEST
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index fd209883ee2e..99e683a48240 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -88,6 +88,7 @@ obj-$(CONFIG_RTC_DRV_M41T94)	+= rtc-m41t94.o
>   obj-$(CONFIG_RTC_DRV_M48T35)	+= rtc-m48t35.o
>   obj-$(CONFIG_RTC_DRV_M48T59)	+= rtc-m48t59.o
>   obj-$(CONFIG_RTC_DRV_M48T86)	+= rtc-m48t86.o
> +obj-$(CONFIG_RTC_DRV_MAX31335)	+= rtc-max31335.o
>   obj-$(CONFIG_RTC_DRV_MAX6900)	+= rtc-max6900.o
>   obj-$(CONFIG_RTC_DRV_MAX6902)	+= rtc-max6902.o
>   obj-$(CONFIG_RTC_DRV_MAX6916)	+= rtc-max6916.o
> diff --git a/drivers/rtc/rtc-max31335.c b/drivers/rtc/rtc-max31335.c
> new file mode 100644
> index 000000000000..159a019524b1
> --- /dev/null
> +++ b/drivers/rtc/rtc-max31335.c
> @@ -0,0 +1,759 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * RTC driver for the MAX31335
> + *
> + * Copyright (C) 2023 Analog Devices
> + *
> + * Antoniu Miclaus <antoniu.miclaus@analog.com>
> + *
> + */
> +
> +#include <asm-generic/unaligned.h>
> +#include <linux/bcd.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/hwmon.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +#include <linux/rtc.h>
> +#include <linux/util_macros.h>
> +
> +/* MAX31335 Register Map */
> +#define MAX31335_STATUS1			0x00
> +#define MAX31335_INT_EN1			0x01
> +#define MAX31335_STATUS2			0x02
> +#define MAX31335_INT_EN2			0x03
> +#define MAX31335_RTC_RESET			0x04
> +#define MAX31335_RTC_CONFIG			0x05
> +#define MAX31335_RTC_CONFIG2			0x06
> +#define MAX31335_TIMESTAMP_CONFIG		0x07
> +#define MAX31335_TIMER_CONFIG			0x08
> +#define MAX31335_SECONDS_1_128			0x09
> +#define MAX31335_SECONDS			0x0A
> +#define MAX31335_MINUTES			0x0B
> +#define MAX31335_HOURS				0x0C
> +#define MAX31335_DAY				0x0D
> +#define MAX31335_DATE				0x0E
> +#define MAX31335_MONTH				0x0F
> +#define MAX31335_YEAR				0x0F
> +#define MAX31335_ALM1_SEC			0x11
> +#define MAX31335_ALM1_MIN			0x12
> +#define MAX31335_ALM1_HRS			0x13
> +#define MAX31335_ALM1_DAY_DATE			0x14
> +#define MAX31335_ALM1_MON			0x15
> +#define MAX31335_ALM1_YEAR			0x16
> +#define MAX31335_ALM2_MIN			0x17
> +#define MAX31335_ALM2_HRS			0x18
> +#define MAX31335_ALM2_DAY_DATE			0x19
> +#define MAX31335_TIMER_COUNT			0x1A
> +#define MAX31335_TIMER_INIT			0x1B
> +#define MAX31335_PWR_MGMT			0x1C
> +#define MAX31335_TRICKLE_REG			0x1D
> +#define MAX31335_AGING_OFFSET			0x1E
> +#define MAX31335_TS_CONFIG			0x30
> +#define MAX31335_TEMP_ALARM_HIGH_MSB		0x31
> +#define MAX31335_TEMP_ALARM_HIGH_LSB		0x32
> +#define MAX31335_TEMP_ALARM_LOW_MSB		0x33
> +#define MAX31335_TEMP_ALARM_LOW_LSB		0x34
> +#define MAX31335_TEMP_DATA_MSB			0x35
> +#define MAX31335_TEMP_DATA_LSB			0x36
> +#define MAX31335_TS0_SEC_1_128			0x40
> +#define MAX31335_TS0_SEC			0x41
> +#define MAX31335_TS0_MIN			0x42
> +#define MAX31335_TS0_HOUR			0x43
> +#define MAX31335_TS0_DATE			0x44
> +#define MAX31335_TS0_MONTH			0x45
> +#define MAX31335_TS0_YEAR			0x46
> +#define MAX31335_TS0_FLAGS			0x47
> +#define MAX31335_TS1_SEC_1_128			0x48
> +#define MAX31335_TS1_SEC			0x49
> +#define MAX31335_TS1_MIN			0x4A
> +#define MAX31335_TS1_HOUR			0x4B
> +#define MAX31335_TS1_DATE			0x4C
> +#define MAX31335_TS1_MONTH			0x4D
> +#define MAX31335_TS1_YEAR			0x4E
> +#define MAX31335_TS1_FLAGS			0x4F
> +#define MAX31335_TS2_SEC_1_128			0x50
> +#define MAX31335_TS2_SEC			0x51
> +#define MAX31335_TS2_MIN			0x52
> +#define MAX31335_TS2_HOUR			0x53
> +#define MAX31335_TS2_DATE			0x54
> +#define MAX31335_TS2_MONTH			0x55
> +#define MAX31335_TS2_YEAR			0x56
> +#define MAX31335_TS2_FLAGS			0x57
> +#define MAX31335_TS3_SEC_1_128			0x58
> +#define MAX31335_TS3_SEC			0x59
> +#define MAX31335_TS3_MIN			0x5A
> +#define MAX31335_TS3_HOUR			0x5B
> +#define MAX31335_TS3_DATE			0x5C
> +#define MAX31335_TS3_MONTH			0x5D
> +#define MAX31335_TS3_YEAR			0x5E
> +#define MAX31335_TS3_FLAGS			0x5F
> +
> +/* MAX31335_STATUS1 Bit Definitions */
> +#define MAX31335_STATUS1_PSDECT			BIT(7)
> +#define MAX31335_STATUS1_OSF			BIT(6)
> +#define MAX31335_STATUS1_PFAIL			BIT(5)
> +#define MAX31335_STATUS1_VBATLOW		BIT(4)
> +#define MAX31335_STATUS1_DIF			BIT(3)
> +#define MAX31335_STATUS1_TIF			BIT(2)
> +#define MAX31335_STATUS1_A2F			BIT(1)
> +#define MAX31335_STATUS1_A1F			BIT(0)
> +
> +/* MAX31335_INT_EN1 Bit Definitions */
> +#define MAX31335_INT_EN1_DOSF			BIT(6)
> +#define MAX31335_INT_EN1_PFAILE			BIT(5)
> +#define MAX31335_INT_EN1_VBATLOWE		BIT(4)
> +#define MAX31335_INT_EN1_DIE			BIT(3)
> +#define MAX31335_INT_EN1_TIE			BIT(2)
> +#define MAX31335_INT_EN1_A2IE			BIT(1)
> +#define MAX31335_INT_EN1_A1IE			BIT(0)
> +
> +/* MAX31335_STATUS2 Bit Definitions */
> +#define MAX31335_STATUS2_TEMP_RDY		BIT(2)
> +#define MAX31335_STATUS2_OTF			BIT(1)
> +#define MAX31335_STATUS2_UTF			BIT(0)
> +
> +/* MAX31335_INT_EN2 Bit Definitions */
> +#define MAX31335_INT_EN2_TEMP_RDY_EN		BIT(2)
> +#define MAX31335_INT_EN2_OTIE			BIT(1)
> +#define MAX31335_INT_EN2_UTIE			BIT(0)
> +
> +/* MAX31335_RTC_RESET Bit Definitions */
> +#define MAX31335_RTC_RESET_SWRST		BIT(0)
> +
> +/* MAX31335_RTC_CONFIG1 Bit Definitions */
> +#define MAX31335_RTC_CONFIG1_EN_IO		BIT(6)
> +#define MAX31335_RTC_CONFIG1_A1AC		GENMASK(5, 4)
> +#define MAX31335_RTC_CONFIG1_DIP		BIT(3)
> +#define MAX31335_RTC_CONFIG1_I2C_TIMEOUT	BIT(1)
> +#define MAX31335_RTC_CONFIG1_EN_OSC		BIT(0)
> +
> +/* MAX31335_RTC_CONFIG2 Bit Definitions */
> +#define MAX31335_RTC_CONFIG2_ENCLKO		BIT(2)
> +#define MAX31335_RTC_CONFIG2_CLKO_HZ		GENMASK(1, 0)
> +
> +/* MAX31335_TIMESTAMP_CONFIG Bit Definitions */
> +#define MAX31335_TIMESTAMP_CONFIG_TSVLOW	BIT(5)
> +#define MAX31335_TIMESTAMP_CONFIG_TSPWM		BIT(4)
> +#define MAX31335_TIMESTAMP_CONFIG_TSDIN		BIT(3)
> +#define MAX31335_TIMESTAMP_CONFIG_TSOW		BIT(2)
> +#define MAX31335_TIMESTAMP_CONFIG_TSR		BIT(1)
> +#define MAX31335_TIMESTAMP_CONFIG_TSE		BIT(0)
> +
> +/* MAX31335_TIMER_CONFIG Bit Definitions */
> +#define MAX31335_TIMER_CONFIG_TE		BIT(4)
> +#define MAX31335_TIMER_CONFIG_TPAUSE		BIT(3)
> +#define MAX31335_TIMER_CONFIG_TRPT		BIT(2)
> +#define MAX31335_TIMER_CONFIG_TFS		GENMASK(1, 0)
> +
> +/* MAX31335_HOURS Bit Definitions */
> +#define MAX31335_HOURS_F_24_12			BIT(6)
> +#define MAX31335_HOURS_HR_20_AM_PM		BIT(5)
> +
> +/* MAX31335_MONTH Bit Definitions */
> +#define MAX31335_MONTH_CENTURY			BIT(7)
> +
> +/* MAX31335_PWR_MGMT Bit Definitions */
> +#define MAX31335_PWR_MGMT_PFVT			BIT(0)
> +
> +/* MAX31335_TRICKLE_REG Bit Definitions */
> +#define MAX31335_TRICKLE_REG_TRICKLE		GENMASK(3, 1)
> +#define MAX31335_TRICKLE_REG_EN_TRICKLE		BIT(0)
> +
> +/* MAX31335_TS_CONFIG Bit Definitions */
> +#define MAX31335_TS_CONFIG_AUTO			BIT(4)
> +#define MAX31335_TS_CONFIG_CONVERT_T		BIT(3)
> +#define MAX31335_TS_CONFIG_TSINT		GENMASK(2, 0)
> +
> +/* MAX31335_TS_FLAGS Bit Definitions */
> +#define MAX31335_TS_FLAGS_VLOWF			BIT(3)
> +#define MAX31335_TS_FLAGS_VBATF			BIT(2)
> +#define MAX31335_TS_FLAGS_VCCF			BIT(1)
> +#define MAX31335_TS_FLAGS_DINF			BIT(0)
> +
> +/* MAX31335 Miscellaneous Definitions */
> +#define MAX31335_STATUS1_DEFAULT		0x40
> +#define MAX31335_RAM_SIZE			32
> +#define MAX31335_TIME_SIZE			0x07
> +
> +#define clk_hw_to_max31335(_hw) container_of(_hw, struct max31335_data, clkout)
> +
> +struct max31335_data {
> +	struct regmap *regmap;
> +	struct rtc_device *rtc;
> +	struct clk_hw clkout;
> +};
> +
> +static const int max31335_clkout_freq[] = { 1, 64, 1024, 32768 };
> +
> +static const u16 max31335_trickle_resistors[] = {3000, 6000, 11000};
> +
> +static bool max31335_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	/* time keeping registers */
> +	if (reg >= MAX31335_SECONDS &&
> +	    reg < MAX31335_SECONDS + MAX31335_TIME_SIZE)
> +		return true;
> +
> +	/* interrupt status register */
> +	if (reg == MAX31335_INT_EN1_A1IE)
> +		return true;
> +
> +	/* temperature registers */
> +	if (reg == MAX31335_TEMP_DATA_MSB || MAX31335_TEMP_DATA_LSB)
> +		return true;
> +}
> +
> +static const struct regmap_config regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = 0x5F,
> +	.volatile_reg = max31335_volatile_reg,
> +};
> +
> +static int max31335_get_hour(u8 hour_reg)
> +{
> +	int hour;
> +
> +	/* 24Hr mode */
> +	if (!FIELD_GET(MAX31335_HOURS_F_24_12, hour_reg))
> +		return bcd2bin(hour_reg & 0x3f);
> +
> +	/* 12Hr mode */
> +	hour = bcd2bin(hour_reg & 0x1f);
> +	if (hour == 12)
> +		hour = 0;
> +
> +	if (FIELD_GET(MAX31335_HOURS_HR_20_AM_PM, hour_reg))
> +		hour += 12;
> +
> +	return hour;
> +}
> +
> +static int max31335_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct max31335_data *max31335 = dev_get_drvdata(dev);
> +	u8 date[7];
> +	int ret;
> +
> +	ret = regmap_bulk_read(max31335->regmap, MAX31335_SECONDS, date,
> +			       sizeof(date));
> +	if (ret)
> +		return ret;
> +
> +	tm->tm_sec  = bcd2bin(date[0] & 0x7f);
> +	tm->tm_min  = bcd2bin(date[1] & 0x7f);
> +	tm->tm_hour = max31335_get_hour(date[2]);
> +	tm->tm_wday = bcd2bin(date[3] & 0x7) - 1;
> +	tm->tm_mday = bcd2bin(date[4] & 0x3f);
> +	tm->tm_mon  = bcd2bin(date[5] & 0x1f) - 1;
> +	tm->tm_year = bcd2bin(date[6]) + 100;
> +
> +	if (FIELD_GET(MAX31335_MONTH_CENTURY, date[5]))
> +		tm->tm_year += 100;
> +
> +	return 0;
> +}
> +
> +static int max31335_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct max31335_data *max31335 = dev_get_drvdata(dev);
> +	u8 date[7];
> +
> +	date[0] = bin2bcd(tm->tm_sec);
> +	date[1] = bin2bcd(tm->tm_min);
> +	date[2] = bin2bcd(tm->tm_hour);
> +	date[3] = bin2bcd(tm->tm_wday + 1);
> +	date[4] = bin2bcd(tm->tm_mday);
> +	date[5] = bin2bcd(tm->tm_mon + 1);
> +	date[6] = bin2bcd(tm->tm_year % 100);
> +
> +	if (tm->tm_year >= 200)
> +		date[5] |= FIELD_PREP(MAX31335_MONTH_CENTURY, 1);
> +
> +	return regmap_bulk_write(max31335->regmap, MAX31335_SECONDS, date,
> +				 sizeof(date));
> +}
> +
> +static int max31335_read_offset(struct device *dev, long *offset)
> +{
> +	struct max31335_data *max31335 = dev_get_drvdata(dev);
> +	u32 value;
> +	int ret;
> +
> +	ret = regmap_read(max31335->regmap, MAX31335_AGING_OFFSET, &value);
> +	if (ret)
> +		return ret;
> +
> +	*offset = value;
> +
> +	return 0;
> +}
> +
> +static int max31335_set_offset(struct device *dev, long offset)
> +{
> +	struct max31335_data *max31335 = dev_get_drvdata(dev);
> +
> +	return regmap_write(max31335->regmap, MAX31335_AGING_OFFSET, offset);
> +}
> +
> +static int max31335_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> +{
> +	struct max31335_data *max31335 = dev_get_drvdata(dev);
> +	struct mutex *lock = &max31335->rtc->ops_lock;
> +	int ret, ctrl, status;
> +	struct rtc_time time;
> +	u8 regs[6];
> +
> +	mutex_lock(lock);
> +
> +	ret = regmap_bulk_read(max31335->regmap, MAX31335_ALM1_SEC, regs,
> +			       sizeof(regs));
> +	if (ret)
> +		goto exit;
> +
> +	alrm->time.tm_sec  = bcd2bin(regs[0] & 0x7f);
> +	alrm->time.tm_min  = bcd2bin(regs[1] & 0x7f);
> +	alrm->time.tm_hour = bcd2bin(regs[2] & 0x3f);
> +	alrm->time.tm_mday = bcd2bin(regs[3] & 0x3f);
> +	alrm->time.tm_mon  = bcd2bin(regs[4] & 0x1f) - 1;
> +	alrm->time.tm_year = bcd2bin(regs[5]) + 100;
> +
> +	ret = max31335_read_time(dev, &time);
> +	if (ret)
> +		goto exit;
> +
> +	if (time.tm_year >= 200)
> +		alrm->time.tm_year += 100;
> +
> +	ret = regmap_read(max31335->regmap, MAX31335_INT_EN1, &ctrl);
> +	if (ret)
> +		goto exit;
> +
> +	ret = regmap_read(max31335->regmap, MAX31335_STATUS1, &status);
> +	if (ret)
> +		goto exit;
> +
> +	alrm->enabled = FIELD_GET(MAX31335_INT_EN1_A1IE, ctrl);
> +	alrm->pending = FIELD_GET(MAX31335_STATUS1_A1F, status);
> +
> +exit:
> +	mutex_unlock(lock);
> +
> +	return ret;
> +}
> +
> +static int max31335_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> +{
> +	struct max31335_data *max31335 = dev_get_drvdata(dev);
> +	struct mutex *lock = &max31335->rtc->ops_lock;
> +	unsigned int reg;
> +	u8 regs[6];
> +	int ret;
> +
> +	regs[0] = bin2bcd(alrm->time.tm_sec);
> +	regs[1] = bin2bcd(alrm->time.tm_min);
> +	regs[2] = bin2bcd(alrm->time.tm_hour);
> +	regs[3] = bin2bcd(alrm->time.tm_mday);
> +	regs[4] = bin2bcd(alrm->time.tm_mon + 1);
> +	regs[5] = bin2bcd(alrm->time.tm_year % 100);
> +
> +	mutex_lock(lock);
> +
> +	ret = regmap_bulk_write(max31335->regmap, MAX31335_ALM1_SEC,
> +				regs, sizeof(regs));
> +	if (ret)
> +		goto exit;
> +
> +	reg = FIELD_PREP(MAX31335_INT_EN1_A1IE, alrm->enabled);
> +	ret = regmap_update_bits(max31335->regmap, MAX31335_INT_EN1,
> +				 MAX31335_INT_EN1_A1IE, reg);
> +	if (ret)
> +		goto exit;
> +
> +	ret = regmap_update_bits(max31335->regmap, MAX31335_STATUS1,
> +				 MAX31335_STATUS1_A1F, 0);
> +
> +exit:
> +	mutex_unlock(lock);
> +
> +	return ret;
> +}
> +
> +static int max31335_alarm_irq_enable(struct device *dev, unsigned int enabled)
> +{
> +	struct max31335_data *max31335 = dev_get_drvdata(dev);
> +
> +	return regmap_update_bits(max31335->regmap, MAX31335_INT_EN1,
> +				  MAX31335_INT_EN1_A1IE, enabled);
> +}
> +
> +static irqreturn_t max31335_handle_irq(int irq, void *dev_id)
> +{
> +	struct max31335_data *max31335 = dev_id;
> +	struct mutex *lock = &max31335->rtc->ops_lock;
> +	int ret, status;
> +
> +	mutex_lock(lock);
> +
> +	ret = regmap_read(max31335->regmap, MAX31335_STATUS1, &status);
> +	if (ret)
> +		goto exit;
> +
> +	if (FIELD_GET(MAX31335_STATUS1_A1F, status)) {
> +		ret = regmap_update_bits(max31335->regmap, MAX31335_STATUS1,
> +					 MAX31335_STATUS1_A1F, 0);
> +		if (ret)
> +			goto exit;
> +
> +		rtc_update_irq(max31335->rtc, 1, RTC_AF | RTC_IRQF);
> +	}
> +
> +exit:
> +	mutex_unlock(lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct rtc_class_ops max31335_rtc_ops = {
> +	.read_time = max31335_read_time,
> +	.set_time = max31335_set_time,
> +	.read_offset = max31335_read_offset,
> +	.set_offset = max31335_set_offset,
> +	.read_alarm = max31335_read_alarm,
> +	.set_alarm = max31335_set_alarm,
> +	.alarm_irq_enable = max31335_alarm_irq_enable,
> +};
> +
> +static int max31335_trickle_charger_setup(struct device *dev,
> +					  struct max31335_data *max31335)
> +{
> +	u32 ohms;
> +	bool diode = false;
> +	int i;
> +
> +	if (device_property_read_u32(dev, "trickle-resistor-ohms", &ohms))
> +		return 0;
> +
> +	if (device_property_read_bool(dev, "trickle-diode-enable"))
> +		diode = true;
> +

	diode = device_property_read_bool(dev, "trickle-diode-enable");

> +	for (i = 0; i < ARRAY_SIZE(max31335_trickle_resistors); i++)
> +		if (ohms == max31335_trickle_resistors[i])
> +			break;
> +
> +	if (i >= ARRAY_SIZE(max31335_trickle_resistors)) {
> +		dev_err_probe(dev, -EINVAL, "invalid trickle resistor value\n");
> +

Should this return a hard error ? After all, it is a devicetree problem
resulting in a failure to enable trickle charging even though tricke
charging is requested.

> +		return 0;
> +	}
> +
> +	if (diode)
> +		i = i + 4;
> +	else
> +		i = i + 1;
> +
> +	return regmap_write(max31335->regmap, MAX31335_TRICKLE_REG,
> +			    FIELD_PREP(MAX31335_TRICKLE_REG_TRICKLE, i) |
> +				       MAX31335_TRICKLE_REG_EN_TRICKLE);
> +}
> +
> +static unsigned long max31335_clkout_recalc_rate(struct clk_hw *hw,
> +						 unsigned long parent_rate)
> +{
> +	struct max31335_data *max31335 = clk_hw_to_max31335(hw);
> +	unsigned int freq_mask;
> +	unsigned int reg;
> +	int ret;
> +
> +	ret = regmap_read(max31335->regmap, MAX31335_RTC_CONFIG2, &reg);
> +	if (ret)
> +		return 0;
> +
> +	freq_mask = __roundup_pow_of_two(ARRAY_SIZE(max31335_clkout_freq)) - 1;
> +
> +	return max31335_clkout_freq[reg & freq_mask];
> +}
> +
> +static long max31335_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
> +				       unsigned long *prate)
> +{
> +	int index;
> +
> +	index = find_closest(rate, max31335_clkout_freq,
> +			     ARRAY_SIZE(max31335_clkout_freq));
> +
> +	return max31335_clkout_freq[index];
> +}
> +
> +static int max31335_clkout_set_rate(struct clk_hw *hw, unsigned long rate,
> +				    unsigned long parent_rate)
> +{
> +	struct max31335_data *max31335 = clk_hw_to_max31335(hw);
> +	unsigned int freq_mask;
> +	int index;
> +
> +	index = find_closest(rate, max31335_clkout_freq,
> +			     ARRAY_SIZE(max31335_clkout_freq));
> +	freq_mask = __roundup_pow_of_two(ARRAY_SIZE(max31335_clkout_freq)) - 1;
> +
> +	return regmap_update_bits(max31335->regmap, MAX31335_RTC_CONFIG2,
> +				  freq_mask, index);
> +}
> +
> +static int max31335_clkout_enable(struct clk_hw *hw)
> +{
> +	struct max31335_data *max31335 = clk_hw_to_max31335(hw);
> +
> +	return regmap_set_bits(max31335->regmap, MAX31335_RTC_CONFIG2,
> +			       MAX31335_RTC_CONFIG2_ENCLKO);
> +}
> +
> +static void max31335_clkout_disable(struct clk_hw *hw)
> +{
> +	struct max31335_data *max31335 = clk_hw_to_max31335(hw);
> +
> +	regmap_clear_bits(max31335->regmap, MAX31335_RTC_CONFIG2,
> +			  MAX31335_RTC_CONFIG2_ENCLKO);
> +}
> +
> +static int max31335_clkout_is_enabled(struct clk_hw *hw)
> +{
> +	struct max31335_data *max31335 = clk_hw_to_max31335(hw);
> +	unsigned int reg;
> +	int ret;
> +
> +	ret = regmap_read(max31335->regmap, MAX31335_RTC_CONFIG2, &reg);
> +	if (ret)
> +		return ret;
> +
> +	return !!(reg & MAX31335_RTC_CONFIG2_ENCLKO);
> +}
> +
> +static const struct clk_ops max31335_clkout_ops = {
> +	.recalc_rate = max31335_clkout_recalc_rate,
> +	.round_rate = max31335_clkout_round_rate,
> +	.set_rate = max31335_clkout_set_rate,
> +	.enable = max31335_clkout_enable,
> +	.disable = max31335_clkout_disable,
> +	.is_enabled = max31335_clkout_is_enabled,
> +};
> +
> +struct clk_init_data max31335_clk_init = {
> +	.name = "max31335-clkout",
> +	.ops = &max31335_clkout_ops,
> +};
> +
> +static int max31335_nvmem_reg_read(void *priv, unsigned int offset,
> +				   void *val, size_t bytes)
> +{
> +	struct max31335_data *max31335 = priv;
> +	unsigned int reg = MAX31335_TS0_SEC_1_128 + offset;
> +
> +	return regmap_bulk_read(max31335->regmap, reg, val, bytes);
> +}
> +
> +static int max31335_nvmem_reg_write(void *priv, unsigned int offset,
> +				    void *val, size_t bytes)
> +{
> +	struct max31335_data *max31335 = priv;
> +	unsigned int reg = MAX31335_TS0_SEC_1_128 + offset;
> +
> +	return regmap_bulk_write(max31335->regmap, reg, val, bytes);
> +}
> +
> +struct nvmem_config max31335_nvmem_cfg = {
> +	.reg_read = max31335_nvmem_reg_read,
> +	.reg_write = max31335_nvmem_reg_write,
> +	.word_size = 8,
> +	.size = MAX31335_RAM_SIZE,
> +};
> +
> +static int max31335_read_temp(struct device *dev, enum hwmon_sensor_types type,
> +			      u32 attr, int channel, long *val)
> +{
> +	struct max31335_data *max31335 = dev_get_drvdata(dev);
> +	u8 reg[2];
> +	s16 temp;
> +	int ret;
> +
> +	if (type != hwmon_temp || attr != hwmon_temp_input)
> +		return -EOPNOTSUPP;
> +
> +	ret = regmap_bulk_read(max31335->regmap, MAX31335_TEMP_DATA_MSB,
> +			       reg, 2);
> +	if (ret)
> +		return ret;
> +
> +	temp = get_unaligned_be16(reg);
> +
> +	*val = (temp / 64) * 250;
> +
> +	return 0;
> +}
> +
> +static umode_t max31335_is_visible(const void *data,
> +				   enum hwmon_sensor_types type,
> +				   u32 attr, int channel)
> +{
> +	if (type == hwmon_temp && attr == hwmon_temp_input)
> +		return 0444;
> +
> +	return 0;
> +}
> +
> +static const struct hwmon_channel_info *max31335_info[] = {
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
> +	NULL
> +};
> +
> +static const struct hwmon_ops max31335_hwmon_ops = {
> +	.is_visible = max31335_is_visible,
> +	.read = max31335_read_temp,
> +};
> +
> +static const struct hwmon_chip_info max31335_chip_info = {
> +	.ops = &max31335_hwmon_ops,
> +	.info = max31335_info,
> +};
> +
> +static int max31335_clkout_register(struct device *dev)
> +{
> +	struct max31335_data *max31335 = dev_get_drvdata(dev);
> +	int ret;
> +
> +	if (!device_property_present(dev, "#clock-cells"))
> +		return 0;
> +
> +	max31335->clkout.init = &max31335_clk_init;
> +
> +	ret = devm_clk_hw_register(dev, &max31335->clkout);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "cannot register clock\n");
> +
> +	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
> +					  &max31335->clkout);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "cannot add hw provider\n");
> +
> +	ret = clk_prepare_enable(max31335->clkout.clk);

Should this call devm_clk_get_enabled() ?

> +	if (ret)
> +		return dev_err_probe(dev, ret, "cannot enable clkout\n");
> +
> +	return 0;
> +}
> +
> +static int max31335_probe(struct i2c_client *client)
> +{
> +	struct max31335_data *max31335;
> +	struct device *hwmon;
> +	int ret, status;
> +
> +	max31335 = devm_kzalloc(&client->dev, sizeof(struct max31335_data),
> +				GFP_KERNEL);
> +	if (!max31335)
> +		return -ENOMEM;
> +
> +	max31335->regmap = devm_regmap_init_i2c(client, &regmap_config);
> +	if (IS_ERR(max31335->regmap))
> +		return PTR_ERR(max31335->regmap);
> +
> +	i2c_set_clientdata(client, max31335);
> +
> +	ret = regmap_write(max31335->regmap, MAX31335_RTC_RESET, 1);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(max31335->regmap, MAX31335_RTC_RESET, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(max31335->regmap, MAX31335_STATUS1, &status);
> +	if (ret)
> +		return ret;
> +
> +	if (status != MAX31335_STATUS1_DEFAULT)
> +		dev_err_probe(&client->dev, -EINVAL,
> +			      "Unable to read from device.\n");
> +

That is misleading. The device returned an unexpected status.
I don't know if this really reflects a problem, but it is not
"Unable to read from device".


> +	max31335->rtc = devm_rtc_allocate_device(&client->dev);
> +	if (IS_ERR(max31335->rtc))
> +		return PTR_ERR(max31335->rtc);
> +
> +	max31335->rtc->ops = &max31335_rtc_ops;
> +	max31335->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
> +	max31335->rtc->range_max = RTC_TIMESTAMP_END_2199;
> +
> +	ret = devm_rtc_register_device(max31335->rtc);
> +	if (ret)
> +		return ret;
> +
> +	ret = max31335_clkout_register(&client->dev);
> +	if (ret)
> +		return ret;
> +
> +	if (client->irq > 0) {
> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +						NULL, max31335_handle_irq,
> +						IRQF_ONESHOT,
> +						"max31335", max31335);
> +		if (ret) {
> +			dev_warn(&client->dev,
> +				 "unable to request IRQ, alarm max31335 disabled\n");
> +			client->irq = 0;
> +		}
> +	}
> +
> +	if (!client->irq)
> +		clear_bit(RTC_FEATURE_ALARM, max31335->rtc->features);
> +
> +	max31335_nvmem_cfg.priv = max31335;
> +	ret = devm_rtc_nvmem_register(max31335->rtc, &max31335_nvmem_cfg);
> +	if (ret)
> +		dev_err_probe(&client->dev, ret, "cannot register rtc nvmem\n");
> +
> +	hwmon = devm_hwmon_device_register_with_info(&client->dev, client->name,
> +						     max31335,
> +						     &max31335_chip_info,
> +						     NULL);
> +	if (IS_ERR(hwmon))
> +		dev_err_probe(&client->dev, PTR_ERR(hwmon),
> +			      "cannot register hwmon device\n");
> +
> +	return max31335_trickle_charger_setup(&client->dev, max31335);
> +}
> +
> +static const struct i2c_device_id max31335_id[] = {
> +	{ "max31335", 0 },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, max31335_id);
> +
> +static const struct of_device_id max31335_of_match[] = {
> +	{ .compatible = "adi,max31335" },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, max31335_of_match);
> +
> +static struct i2c_driver max31335_driver = {
> +	.driver = {
> +		.name = "rtc-max31335",
> +		.of_match_table = max31335_of_match,
> +	},
> +	.probe = max31335_probe,
> +	.id_table = max31335_id,
> +};
> +module_i2c_driver(max31335_driver);
> +
> +MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
> +MODULE_DESCRIPTION("MAX31335 RTC driver");
> +MODULE_LICENSE("GPL");

