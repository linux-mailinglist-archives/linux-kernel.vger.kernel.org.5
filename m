Return-Path: <linux-kernel+bounces-108674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBA9880E42
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF98A1C221A8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD7039AF2;
	Wed, 20 Mar 2024 09:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="By09qNdT"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89633AC25;
	Wed, 20 Mar 2024 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710925536; cv=none; b=MklJL+F+6kJFYxALti4eC1QfzGnktXpyj+T7jXXCOQkAvqZu0mwTweIIOY06M5kpacPvHYnpANMRX/WY+6/mcTL2W+s7pmYqnkLwYSeRai5WRoc0OCJoxHFnCqsr/nQiIQakrQ8LP9xcYGJIM2QnBFLDmzs9l6vqa2sATuNLNH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710925536; c=relaxed/simple;
	bh=6Qgf/NpiPbzxVmqwhe1v3Rspvjzp2MmQAb5Ad1EHDwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OdzJv82+gc6COrc4/g+2U8I/I2fO14TMUmuourMA5r3iqztbUapZeSrxo3npwgGiOcEuJBWOg4eilNtZNIq7GJssWUNVMTeoEdNhkvKNpCT+atEGv+IXLAWW6DBGXJMsaFoKnNMxHB+EaKL6xZ/v64iIf+8jT3VMcr9Xwleax0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=By09qNdT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dddb160a37so46896475ad.2;
        Wed, 20 Mar 2024 02:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710925534; x=1711530334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q9AnhsV1I63p1VhmH5I/CTh8F8noEyIobCtBN/qPBug=;
        b=By09qNdTJ0L+rjauTKZ/AninSv3YUJhoBsYXtP402u3aeqz79KYhM99qKBCcDBDFWl
         WXRp7kI0A8YkEGEntEWACmAkGg9tv8crK9mYRS/EDfxrwv+n6UCYxkXsqdzvIXWAtWeT
         p4NynY0JUbWdgayv3EeKAPasKyZ2iPaVSs4VXN6XMgv/sA7HiEHi2zq8YaiR9admOA4e
         i7YJhgi91Ukb30AicV3uaV/vyJiPqJr2FPyrl+OrL8jyOkr0St4GsjtWfug+1vOVb8F4
         3gqCqPkrPCgDjnnJZxtbj9rJfMSxB+ltec3BjUfMl4BGZQbcRzKRZ4cIS7CBm24FCGNc
         TK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710925534; x=1711530334;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9AnhsV1I63p1VhmH5I/CTh8F8noEyIobCtBN/qPBug=;
        b=BLhmmFbc9D1JofrJLFYHgwZtgBsxwKprG1YGg+PCMNVIwcWT4DhgnsqZq8sU0Q7TDa
         sNGsmtqRnx48h55/RyOCriNhFhL1gdqHicMILdqiciCZ4gxsbvtXz72GaUSu+7C+jCB4
         fIyCjb5UruZfJtfbBEDaIaaN5nZfzyDrwTjGfXLjNoP4ArmSm2to3yR76SoC1B9D2wAJ
         BencVAR2Zniekx89MKViPNEllKOUnEW02j8lPcqNH5IwI0QUke75Bb2SB17Vsq87J2w0
         iZHOw0BbVmMWNjRaMQY8HGcmHeYa5vtU6PyIcIK560Ooq0vDHtuRiWHzhzeptJzHdLfT
         sdIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEVXDIfZB84+Fa6y8fB/3F6oJsCsntQl+9DnnejF+Tn3jRu6/YHcKENZFKnHmRDfQaQLOJGy0y+BmQBwy1XUpqLUzdqe8adbXMIIBPqB3f28KjvBBLZH3n9Temkb2XW9xxJDC874P3dzeM3/Oy+szSjEoqSrMY0M+z2WFsqLR6Oegl5E+MnPlb
X-Gm-Message-State: AOJu0Yz9e5FK1cBdOVN4SvPBMcQENWIRESUFhf9xfJVyKInzxoV58ZMN
	9/tFNWITjvKm7EIUSXkPkV1lvMwfjL8J8g9Z3RguFHNsBdoZewhB
X-Google-Smtp-Source: AGHT+IGQN51HBV2eG4je+v7GXoz9GezzFu7dyWQoCjgBxUNs4bPN7xeScFwS6s6WwuunnB3tWKBKpA==
X-Received: by 2002:a17:902:ea10:b0:1e0:1496:91ec with SMTP id s16-20020a170902ea1000b001e0149691ecmr6421247plg.20.1710925533894;
        Wed, 20 Mar 2024 02:05:33 -0700 (PDT)
Received: from ?IPV6:2001:b400:e38c:634d:c9ce:74d1:b790:4f66? (2001-b400-e38c-634d-c9ce-74d1-b790-4f66.emome-ip6.hinet.net. [2001:b400:e38c:634d:c9ce:74d1:b790:4f66])
        by smtp.gmail.com with ESMTPSA id j11-20020a17090276cb00b001dd88a5dc47sm3261282plt.290.2024.03.20.02.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 02:05:33 -0700 (PDT)
Message-ID: <924c4402-af14-4b7a-9a4e-4317c50482cd@gmail.com>
Date: Wed, 20 Mar 2024 17:05:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers: watchdog: ast2600 support bootstatus
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>, patrick@stwcx.xyz,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20240318055219.3460121-1-peteryin.openbmc@gmail.com>
 <13640a07-7395-4521-9c5d-748599202361@roeck-us.net>
From: PeterYin <peteryin.openbmc@gmail.com>
In-Reply-To: <13640a07-7395-4521-9c5d-748599202361@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Guenter Roeck 於 3/19/24 08:46 寫道:
> On 3/17/24 22:52, Peter Yin wrote:
>> Add WDIOF_EXTERN1 and WDIOF_CARDRESET bootstatus in ast2600
>>
>> Regarding the AST2600 specification, the WDTn Timeout Status Register
>> (WDT10) has bit 1 reserved. To verify the second boot source,
>> we need to check SEC14 bit 12 and bit 13.
>> The bits 8-23 in the WDTn Timeout Status Register are the Watchdog
>> Event Count, which we can use to verify WDIOF_EXTERN1.
>>
>> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> 
> You'll have to separate dts and yaml file changes from driver changes.
> 
>> ---
>> Change log:
>>
>> v1 -> v2
>>    - Add comment and support WDIOF_CARDRESET in ast2600
>>
>> v1
>>    - Patch 0001 - Add WDIOF_EXTERN1 bootstatus
>> ---
>>   arch/arm/boot/dts/aspeed/aspeed-g6.dtsi |  8 ++---
>>   drivers/watchdog/aspeed_wdt.c           | 45 ++++++++++++++++++++++---
>>   2 files changed, 44 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi 
>> b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
>> index e0b44498269f..23ae7f0430e9 100644
>> --- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
>> +++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
>> @@ -556,24 +556,24 @@ uart5: serial@1e784000 {
>>               wdt1: watchdog@1e785000 {
>>                   compatible = "aspeed,ast2600-wdt";
>> -                reg = <0x1e785000 0x40>;
>> +                reg = <0x1e785000 0x40>, <0x1e6f2000 0x20>;
>>               };
>>               wdt2: watchdog@1e785040 {
>>                   compatible = "aspeed,ast2600-wdt";
>> -                reg = <0x1e785040 0x40>;
>> +                reg = <0x1e785040 0x40>, <0x1e6f2000 0x020>;
>>                   status = "disabled";
>>               };
>>               wdt3: watchdog@1e785080 {
>>                   compatible = "aspeed,ast2600-wdt";
>> -                reg = <0x1e785080 0x40>;
>> +                reg = <0x1e785080 0x40>, <0x1e6f2000 0x020>;
>>                   status = "disabled";
>>               };
>>               wdt4: watchdog@1e7850c0 {
>>                   compatible = "aspeed,ast2600-wdt";
>> -                reg = <0x1e7850C0 0x40>;
>> +                reg = <0x1e7850C0 0x40>, <0x1e6f2000 0x020>;
>>                   status = "disabled";
>>               };
>> diff --git a/drivers/watchdog/aspeed_wdt.c 
>> b/drivers/watchdog/aspeed_wdt.c
>> index b4773a6aaf8c..65118e461130 100644
>> --- a/drivers/watchdog/aspeed_wdt.c
>> +++ b/drivers/watchdog/aspeed_wdt.c
>> @@ -33,6 +33,7 @@ struct aspeed_wdt {
>>       void __iomem        *base;
>>       u32            ctrl;
>>       const struct aspeed_wdt_config *cfg;
>> +    void __iomem        *sec_base;
>>   };
>>   static const struct aspeed_wdt_config ast2400_config = {
>> @@ -82,6 +83,15 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
>>   #define WDT_RESET_MASK1        0x1c
>>   #define WDT_RESET_MASK2        0x20
>> +/*
>> + * Only Ast2600 support
>> + */
>> +#define   WDT_EVENT_COUNTER_MASK    (0xFFF << 8)
>> +#define   WDT_SECURE_ENGINE_STATUS    (0x14)
>> +#define   ABR_IMAGE_SOURCE        BIT(12)
>> +#define   ABR_IMAGE_SOURCE_SPI        BIT(13)
>> +#define   SECOND_BOOT_ENABLE        BIT(14)
>> +
>>   /*
>>    * WDT_RESET_WIDTH controls the characteristics of the external 
>> pulse (if
>>    * enabled), specifically:
>> @@ -313,6 +323,7 @@ static int aspeed_wdt_probe(struct platform_device 
>> *pdev)
>>       const char *reset_type;
>>       u32 duration;
>>       u32 status;
>> +    u32 sec_st;
>>       int ret;
>>       wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
>> @@ -330,6 +341,12 @@ static int aspeed_wdt_probe(struct 
>> platform_device *pdev)
>>       if (IS_ERR(wdt->base))
>>           return PTR_ERR(wdt->base);
>> +    if (of_device_is_compatible(np, "aspeed,ast2600-wdt")) {
>> +        wdt->sec_base = devm_platform_ioremap_resource(pdev, 1);
>> +        if (IS_ERR(wdt->sec_base))
>> +            return PTR_ERR(wdt->sec_base);
>> +    }
>> +
>>       wdt->wdd.info = &aspeed_wdt_info;
>>       if (wdt->cfg->irq_mask) {
>> @@ -459,12 +476,30 @@ static int aspeed_wdt_probe(struct 
>> platform_device *pdev)
>>       }
>>       status = readl(wdt->base + WDT_TIMEOUT_STATUS);
>> -    if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY) {
>> -        wdt->wdd.bootstatus = WDIOF_CARDRESET;
>> -        if (of_device_is_compatible(np, "aspeed,ast2400-wdt") ||
>> -            of_device_is_compatible(np, "aspeed,ast2500-wdt"))
>> -            wdt->wdd.groups = bswitch_groups;
>> +    if (of_device_is_compatible(np, "aspeed,ast2600-wdt")) {
>> +        /*
>> +         * The WDTn Timeout Status Register bit 1 is reserved.
>> +         * To verify the second boot source,
>> +         * we need to check SEC14 bit 12 and bit 13.
>> +         */
>> +        sec_st = readl(wdt->sec_base + WDT_SECURE_ENGINE_STATUS);
>> +        if( sec_st & SECOND_BOOT_ENABLE)
>> +            if (sec_st & ABR_IMAGE_SOURCE ||
>> +                sec_st & ABR_IMAGE_SOURCE_SPI)
> 
> I am sure that checkpatch as something to say here. Either case, I would 
> very
> much prefer a single if() statement such as
> 
>          if (sec_st & SECOND_BOOT_ENABLE &&
>              sec_st & (ABR_IMAGE_SOURCE | ABR_IMAGE_SOURCE_SPI))
> 
>> +                wdt->wdd.bootstatus |= WDIOF_CARDRESET;
>> +
>> +        /*
>> +         * To check Watchdog Event Count for WDIOF_EXTERN1
>> +         */
>> +        if (status & WDT_EVENT_COUNTER_MASK) {
>> +            wdt->wdd.bootstatus |= WDIOF_EXTERN1;
>> +        }
> 
> Unnecessary { }
> 
> ... but does this really indicate that there was a reset due to some 
> event ?
> This reads three 8-bit counters. Wouldn't it make more sense to check bit 0
> instead ?
> 
> I am also not sure if reading the watchdog status from 
> WDT_SECURE_ENGINE_STATUS
> adds any value over the status reported in the watchdog status register.
> You'll have to explain why the added complexity is necessary or even adds
> value.
> 
> Never mind, though ...
> 
> Looking into the datasheets, the current code is quite completely wrong 
> anyway.
> Bit 1 of the status register indicates on ast2500 if the boot was from 
> the second
> boot source. It does not indicate that the most recent reset was 
> triggered by
> the watchdog. The code should just be changed to set WDIOF_CARDRESET if 
> bit 0
> of the status register is set. The boot source is out of scope for the 
> watchdog
> status bits.
> 
> Thanks,
> Guenter
> 
Ast2600 has external reset flag on scu74 bit 1
Can I modify the code like this?

To set WDIOF_EXTERN1 if EXTERN_RESET_FLAG is set,
To set WDIOF_CARDRESET if WDT_TIMEOUT_STATUS_EVENT(bit0) is set


#define   WDT_TIMEOUT_STATUS_EVENT	BIT(0)
#define   EXTERN_RESET_FLAG		BIT(1)
#define   ASPEED_SYSTEM_RESET_EVENT	(0x74)

	status = readl(wdt->base + WDT_TIMEOUT_STATUS);
	if (status & WDT_TIMEOUT_STATUS_EVENT)
		wdt->wdd.bootstatus = WDIOF_CARDRESET;

	if (of_device_is_compatible(np, "aspeed,ast2600-wdt")) {
		status = readl(wdt->scu_base + ASPEED_SYSTEM_RESET_EVENT);
		if (status & EXTERN_RESET_FLAG)
			/*
			 * Reset cause by Extern Reset
			 */
			wdt->wdd.bootstatus |= WDIOF_EXTERN1;
	} else {
			wdt->wdd.groups = bswitch_groups;
	}
Thanks,
Peter.

