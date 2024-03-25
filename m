Return-Path: <linux-kernel+bounces-117544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E66488AC69
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 306CB1C604AB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C299B1474CD;
	Mon, 25 Mar 2024 17:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krO36OZ+"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7047143C47;
	Mon, 25 Mar 2024 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386399; cv=none; b=FgBnQcHaddYb6ogacW0XBtFJrDlZIxAweO1eoxr/10fL16ZUSiNXTaehjhRV/pkLsoorlLUDjPpK+6Z76IWnP5ibj/3WtmAhPYEUJYW1c3F/RJ4jiPXYXeQqy1IPh5QmhEgu9iwvUZmXbBsAiDcBWHKqTH3S0OW+S4JDs3bAWk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386399; c=relaxed/simple;
	bh=t3ot0dRKsro4fOCKaONc7R6jLHZoXDEiJAF7nhV80e8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=t9G8XGC5ihTK0Er0nd18cq0SnDQeC9WvHSl1PyZlq57hMJdZRTbd3SN1+1154B2Nnw4nb3FRRLPWK+O5edKbLfCGMM4dLnsIiMfbLhzOO9njKQQaw0gkj/g6TpCZAdxZ0iJYxuX9ajZMbHJQQr3PdiX/1TuIufe7QU1f81FGLHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krO36OZ+; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e6f69e850bso3936154b3a.0;
        Mon, 25 Mar 2024 10:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711386397; x=1711991197; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=lURQxy/Kj/7mCvaaS4L12WpsGGJsAgAEK7Ux3Z4xfwo=;
        b=krO36OZ+09KZ0aXtV1G+39FL/Ao/eIe7FBq6iX8XaKoBFPdCmGcLTm2zsfwJ/Ynx2q
         bhbinuWH67aBjsiimUMQmkujR3eOaindK5eERaeB62vuSVL7ewGOCEW+RzbcpA2SdhAQ
         oawpdL+o1ZQfUFRan7Rtczkx49rtaDARvH5rMFrK0cY/GLgtcNBnjXm7TMVMYCqu4isC
         XooA4Dl8WbJzZQxSuAP6e+8U3RhnoJ59bGEQbn8aEKGy0ohEDQKpu9KyaKTSX/Ky0+Bg
         4jWQrOzUqxOb48DxaJ3yGOKM8mwwnJZ7UMMByoWdGuyie6S9YrqYprfJj1uyokHcpkuT
         Xyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711386397; x=1711991197;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lURQxy/Kj/7mCvaaS4L12WpsGGJsAgAEK7Ux3Z4xfwo=;
        b=hF/mH4eLnHX8Yw5QLIrJOy9Ymmc8DEIPlG9x+GVdvf5PknII32LuNT3zPLZV1RH6fA
         2yPQTW6RN7i+SsbLiKiYTb5xbggVLAwFm00N+ChKEvWUFEHMyQ6T20zeWHOnTZc0GJxE
         kfOA4/ka7irU9dHJdzvAgRNtauYbgZloPvrMOTaFqPC37qTX2mkMeqZo/Kqf20fz1aRG
         9+aCD2lOPwaT0rBgRv+hTiwm3xR/cSAvyC6xbWS1UcVic6g9bYO06e40sCrj3KyxkiaS
         6Ss13g7mE1KFXkcHFjVigeG3+1rCL53+8iUhmsKbJy+Z/a3xM4KCgKfuODtnnXTQKOLU
         NVDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzVLI8oRmTisESjlWSBjYPRC3oo5LXAyFj1Gx75OyhxfNpSqs6J/Sv0d0aixpuoCU/WXo4s4Moykq4CCX16eAjMgqioQg6z2np88A10vGL0+swiHlUhATaCHcjxoto67RV0gr0sHlDGD+LGmIFXVzHpbE/ss5kzeMzQDeKs3o+pkGmgFzOh2L+
X-Gm-Message-State: AOJu0YzcrYCvgXeZzrtCT0uwbE4e1cHjibfx94bzPaXOIG0iYR315SvB
	gS5ZScXVXEkDleyb3t6p0cQMhfcvAJFsTmakY9rRmccMQrqxa+7f
X-Google-Smtp-Source: AGHT+IFB0Zx5HB4eAeO7TlMCW4Ry9iykhiOD0RLW1hkUlKfz4r0vbUfOrlh7NndtPGPSatDIaOwX/Q==
X-Received: by 2002:a17:902:8218:b0:1e0:7bbf:bef4 with SMTP id x24-20020a170902821800b001e07bbfbef4mr8019922pln.41.1711386396930;
        Mon, 25 Mar 2024 10:06:36 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p16-20020a1709027ed000b001e0b5f9fb02sm2947255plb.26.2024.03.25.10.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 10:06:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c6646c7a-6e80-4dce-a166-2beaf5030387@roeck-us.net>
Date: Mon, 25 Mar 2024 10:06:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers: watchdog: ast2600 support bootstatus
Content-Language: en-US
To: PeterYin <peteryin.openbmc@gmail.com>, patrick@stwcx.xyz,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20240318055219.3460121-1-peteryin.openbmc@gmail.com>
 <13640a07-7395-4521-9c5d-748599202361@roeck-us.net>
 <924c4402-af14-4b7a-9a4e-4317c50482cd@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <924c4402-af14-4b7a-9a4e-4317c50482cd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/20/24 02:05, PeterYin wrote:
> 
> 
> Guenter Roeck 於 3/19/24 08:46 寫道:
>> On 3/17/24 22:52, Peter Yin wrote:
>>> Add WDIOF_EXTERN1 and WDIOF_CARDRESET bootstatus in ast2600
>>>
>>> Regarding the AST2600 specification, the WDTn Timeout Status Register
>>> (WDT10) has bit 1 reserved. To verify the second boot source,
>>> we need to check SEC14 bit 12 and bit 13.
>>> The bits 8-23 in the WDTn Timeout Status Register are the Watchdog
>>> Event Count, which we can use to verify WDIOF_EXTERN1.
>>>
>>> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
>>
>> You'll have to separate dts and yaml file changes from driver changes.
>>
>>> ---
>>> Change log:
>>>
>>> v1 -> v2
>>>    - Add comment and support WDIOF_CARDRESET in ast2600
>>>
>>> v1
>>>    - Patch 0001 - Add WDIOF_EXTERN1 bootstatus
>>> ---
>>>   arch/arm/boot/dts/aspeed/aspeed-g6.dtsi |  8 ++---
>>>   drivers/watchdog/aspeed_wdt.c           | 45 ++++++++++++++++++++++---
>>>   2 files changed, 44 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
>>> index e0b44498269f..23ae7f0430e9 100644
>>> --- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
>>> +++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
>>> @@ -556,24 +556,24 @@ uart5: serial@1e784000 {
>>>               wdt1: watchdog@1e785000 {
>>>                   compatible = "aspeed,ast2600-wdt";
>>> -                reg = <0x1e785000 0x40>;
>>> +                reg = <0x1e785000 0x40>, <0x1e6f2000 0x20>;
>>>               };
>>>               wdt2: watchdog@1e785040 {
>>>                   compatible = "aspeed,ast2600-wdt";
>>> -                reg = <0x1e785040 0x40>;
>>> +                reg = <0x1e785040 0x40>, <0x1e6f2000 0x020>;
>>>                   status = "disabled";
>>>               };
>>>               wdt3: watchdog@1e785080 {
>>>                   compatible = "aspeed,ast2600-wdt";
>>> -                reg = <0x1e785080 0x40>;
>>> +                reg = <0x1e785080 0x40>, <0x1e6f2000 0x020>;
>>>                   status = "disabled";
>>>               };
>>>               wdt4: watchdog@1e7850c0 {
>>>                   compatible = "aspeed,ast2600-wdt";
>>> -                reg = <0x1e7850C0 0x40>;
>>> +                reg = <0x1e7850C0 0x40>, <0x1e6f2000 0x020>;
>>>                   status = "disabled";
>>>               };
>>> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
>>> index b4773a6aaf8c..65118e461130 100644
>>> --- a/drivers/watchdog/aspeed_wdt.c
>>> +++ b/drivers/watchdog/aspeed_wdt.c
>>> @@ -33,6 +33,7 @@ struct aspeed_wdt {
>>>       void __iomem        *base;
>>>       u32            ctrl;
>>>       const struct aspeed_wdt_config *cfg;
>>> +    void __iomem        *sec_base;
>>>   };
>>>   static const struct aspeed_wdt_config ast2400_config = {
>>> @@ -82,6 +83,15 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
>>>   #define WDT_RESET_MASK1        0x1c
>>>   #define WDT_RESET_MASK2        0x20
>>> +/*
>>> + * Only Ast2600 support
>>> + */
>>> +#define   WDT_EVENT_COUNTER_MASK    (0xFFF << 8)
>>> +#define   WDT_SECURE_ENGINE_STATUS    (0x14)
>>> +#define   ABR_IMAGE_SOURCE        BIT(12)
>>> +#define   ABR_IMAGE_SOURCE_SPI        BIT(13)
>>> +#define   SECOND_BOOT_ENABLE        BIT(14)
>>> +
>>>   /*
>>>    * WDT_RESET_WIDTH controls the characteristics of the external pulse (if
>>>    * enabled), specifically:
>>> @@ -313,6 +323,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>>>       const char *reset_type;
>>>       u32 duration;
>>>       u32 status;
>>> +    u32 sec_st;
>>>       int ret;
>>>       wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
>>> @@ -330,6 +341,12 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>>>       if (IS_ERR(wdt->base))
>>>           return PTR_ERR(wdt->base);
>>> +    if (of_device_is_compatible(np, "aspeed,ast2600-wdt")) {
>>> +        wdt->sec_base = devm_platform_ioremap_resource(pdev, 1);
>>> +        if (IS_ERR(wdt->sec_base))
>>> +            return PTR_ERR(wdt->sec_base);
>>> +    }
>>> +
>>>       wdt->wdd.info = &aspeed_wdt_info;
>>>       if (wdt->cfg->irq_mask) {
>>> @@ -459,12 +476,30 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>>>       }
>>>       status = readl(wdt->base + WDT_TIMEOUT_STATUS);
>>> -    if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY) {
>>> -        wdt->wdd.bootstatus = WDIOF_CARDRESET;
>>> -        if (of_device_is_compatible(np, "aspeed,ast2400-wdt") ||
>>> -            of_device_is_compatible(np, "aspeed,ast2500-wdt"))
>>> -            wdt->wdd.groups = bswitch_groups;
>>> +    if (of_device_is_compatible(np, "aspeed,ast2600-wdt")) {
>>> +        /*
>>> +         * The WDTn Timeout Status Register bit 1 is reserved.
>>> +         * To verify the second boot source,
>>> +         * we need to check SEC14 bit 12 and bit 13.
>>> +         */
>>> +        sec_st = readl(wdt->sec_base + WDT_SECURE_ENGINE_STATUS);
>>> +        if( sec_st & SECOND_BOOT_ENABLE)
>>> +            if (sec_st & ABR_IMAGE_SOURCE ||
>>> +                sec_st & ABR_IMAGE_SOURCE_SPI)
>>
>> I am sure that checkpatch as something to say here. Either case, I would very
>> much prefer a single if() statement such as
>>
>>          if (sec_st & SECOND_BOOT_ENABLE &&
>>              sec_st & (ABR_IMAGE_SOURCE | ABR_IMAGE_SOURCE_SPI))
>>
>>> +                wdt->wdd.bootstatus |= WDIOF_CARDRESET;
>>> +
>>> +        /*
>>> +         * To check Watchdog Event Count for WDIOF_EXTERN1
>>> +         */
>>> +        if (status & WDT_EVENT_COUNTER_MASK) {
>>> +            wdt->wdd.bootstatus |= WDIOF_EXTERN1;
>>> +        }
>>
>> Unnecessary { }
>>
>> ... but does this really indicate that there was a reset due to some event ?
>> This reads three 8-bit counters. Wouldn't it make more sense to check bit 0
>> instead ?
>>
>> I am also not sure if reading the watchdog status from WDT_SECURE_ENGINE_STATUS
>> adds any value over the status reported in the watchdog status register.
>> You'll have to explain why the added complexity is necessary or even adds
>> value.
>>
>> Never mind, though ...
>>
>> Looking into the datasheets, the current code is quite completely wrong anyway.
>> Bit 1 of the status register indicates on ast2500 if the boot was from the second
>> boot source. It does not indicate that the most recent reset was triggered by
>> the watchdog. The code should just be changed to set WDIOF_CARDRESET if bit 0
>> of the status register is set. The boot source is out of scope for the watchdog
>> status bits.
>>
>> Thanks,
>> Guenter
>>
> Ast2600 has external reset flag on scu74 bit 1
> Can I modify the code like this?
> 
> To set WDIOF_EXTERN1 if EXTERN_RESET_FLAG is set,
> To set WDIOF_CARDRESET if WDT_TIMEOUT_STATUS_EVENT(bit0) is set
> 
> 
> #define   WDT_TIMEOUT_STATUS_EVENT    BIT(0)
> #define   EXTERN_RESET_FLAG        BIT(1)
> #define   ASPEED_SYSTEM_RESET_EVENT    (0x74)
> 
>      status = readl(wdt->base + WDT_TIMEOUT_STATUS);
>      if (status & WDT_TIMEOUT_STATUS_EVENT)
>          wdt->wdd.bootstatus = WDIOF_CARDRESET;
> 
>      if (of_device_is_compatible(np, "aspeed,ast2600-wdt")) {
>          status = readl(wdt->scu_base + ASPEED_SYSTEM_RESET_EVENT);

ASPEED_SYSTEM_RESET_EVENT is at offset 0x74, but the devicetree nodes
for "aspeed,ast2600-wdt" only request 0x20 bytes for scu. I don't really
understand, though, how this is supposed to work in the first place, since
the entire SCU address range is also requested by "aspeed,ast2600-sbc".
Granted, I don't see actual code in the upstream kernel listing itself
as compatible with "aspeed,ast2600-sbc" (it looks like attempts to upstream
that code were unsuccessful), but it seems wrong to use that memory space
for the watchdog driver.

Also, ast2500 has the "external reset" flag in SCU register 1e6e2000:0x3c.
That should be addressed at the same time, if at all.

Thanks,
Guenter


