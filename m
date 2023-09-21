Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B40E7A9F8F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjIUUXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjIUUXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:23:21 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63495AE20
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:21:37 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9aa0495f9cfso524919466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695316896; x=1695921696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cGHsvsX08TcwuScXtL9d823K582K+A8pTes6z002G9o=;
        b=rZFjpdMugd0rzrSE+dpOQbMeiSsc5lh3VyVWKCaKpOXKalDssVr4KFOB0HRg4CWn0q
         JZeVQDjEbnVibBZOMujKsiVHIsIncOoPodmqV21CCG115wlgGkUkLDY+dURqSzKzhO03
         58XoK0K6DPGcmnrOsfZ1VsfroGOfZnXbCgaVg4Q4TF+nGVWoqFwVynikm20TZF94Gdin
         hGU0W8MlAX0q3Hfv42tazypFOcieLq0SFkOXdvJU2Za2ALdDdGj8Aci52pXRYQaXefCG
         CZ+0Wa278efS42YWBwVFxTcJLDRlpmzhu/qYSTOEEx8nNyySClxcykKocboQ4aGs3wl5
         qaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316896; x=1695921696;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cGHsvsX08TcwuScXtL9d823K582K+A8pTes6z002G9o=;
        b=eIYejCf2G+9PiRBRzv3kbGgH8d8/Us5pxHFbP/ZctyYNDQp+1A8pLXMnA3WPHH2Vh5
         OmoFLOA9QoHtDFaJ72nvmijJj1owgQ5XQTKL4ZctCLAuh1lyXzu4on8M0O3kBTU9fczy
         bgKbewu7dEmW790nV1KI0sU1P18Pypj6mmWe4SfRNoJrLHiudbIVmw8u+7/4smsM0yxf
         SCnKGZ24qsMOm/o/rpApn4IuCDQ01efael//DrGykZ/kKOOw+X5eLWD//oogK1WgpeFr
         8GwyBgYbDN/VzoS0MEDbHi1uKPf0D29aL/xysxUFjsz/F5l1mFgmmLki/V9yF8hkoh2n
         80+Q==
X-Gm-Message-State: AOJu0Yx00w7n4vmnk3hxN2A06enNhOHone+f8ZLY1v9XmJczta8Vavy8
        x9rrw6RoR0Gak31egaXPl5ImhHm2JUKkXuaO+W22BQ==
X-Google-Smtp-Source: AGHT+IF2TRjwqnLhdXNpxqFt3WvhnwZVkscmmf5f8IQZwt6L4LXUKhzrb6S1Q+KTlxJ6x4jj+3Y72Q==
X-Received: by 2002:a17:907:3f8c:b0:9ad:f17a:c712 with SMTP id hr12-20020a1709073f8c00b009adf17ac712mr12276955ejc.25.1695280455612;
        Thu, 21 Sep 2023 00:14:15 -0700 (PDT)
Received: from [172.20.34.61] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id u12-20020a1709064acc00b009a1e73f2b4bsm598440ejt.48.2023.09.21.00.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 00:14:15 -0700 (PDT)
Message-ID: <306a6aa0-c608-418a-a591-6f8aa95817fb@linaro.org>
Date:   Thu, 21 Sep 2023 08:14:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: atmel: add at25ff321a entry
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        miquel.raynal@bootlin.com, linux-mtd@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230908151400.164470-1-nicolas.ferre@microchip.com>
 <8d72820d-bbaa-abc8-4448-87f0f054c381@linaro.org>
 <4c9b0dff-6350-376b-60ac-c36f98378a51@microchip.com>
Content-Language: en-US
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <4c9b0dff-6350-376b-60ac-c36f98378a51@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/20/23 17:16, Nicolas Ferre wrote:
> On 19/09/2023 at 18:12, Tudor Ambarus wrote:
>> On 08.09.2023 18:14, nicolas.ferre@microchip.com wrote:
>>> From: Nicolas Ferre <nicolas.ferre@microchip.com>
>>>
>>> Add the at25ff321a 4MB SPI flash which is able to provide
>>> SFDP informations.
>>> Datasheet:
>>> https://www.renesas.com/us/en/document/dst/at25ff321a-datasheet
>>>
>>> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>>> ---
> 
> [..]
> 
>>>   drivers/mtd/spi-nor/atmel.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
>>> index 58968c1e7d2f..c94d52951481 100644
>>> --- a/drivers/mtd/spi-nor/atmel.c
>>> +++ b/drivers/mtd/spi-nor/atmel.c
>>> @@ -184,6 +184,10 @@ static const struct flash_info atmel_nor_parts[]
>>> = {
>>>                FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
>>>                NO_SFDP_FLAGS(SECT_4K)
>>>                .fixups = &atmel_nor_global_protection_fixups },
>>> +     { "at25ff321a", INFO(0x1f4708, 0, 64 * 1024,  64)
>>> +             FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
>>> +             PARSE_SFDP
>>> +             .fixups = &atmel_nor_global_protection_fixups },
>>
>> We have recently changed how the flash entries are defined. Would you
>> please try the following changes instead?
>>
>> diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
>> index 95f0e139284e..44218716d81e 100644
>> --- a/drivers/mtd/spi-nor/atmel.c
>> +++ b/drivers/mtd/spi-nor/atmel.c
>> @@ -213,6 +213,12 @@ static const struct flash_info atmel_nor_parts[] = {
>>                  .flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
>>                  .no_sfdp_flags = SECT_4K,
>>                  .fixups = &atmel_nor_global_protection_fixups
>> +       }, {
>> +               .id = SNOR_ID(0x1f, 0x47, 0x08),
>> +               .name = "at25ff321a",
>> +               .flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
> 
> Here, I added:
> 
>                .no_sfdp_flags = SECT_4K,
> 
> to match the other devices of the family... I checked on the datasheet,
> 4K sectors are okay, but I don't know exactly if this is eligible to the
> "no_sfdb_flags" property... forgive me, I didn't check further knowing
> that you might have better view on this than me ;-)

yeah, no worries. You should not specify 4k here, as it should already
be set when parsing SFDP. You can use mtdinfo /dev/mtdx to check what
erase size gets set. In the core we set the maximum supported erase size
for speed considerations and making ubifs happy, so you'll probably see
64k when checking with mtdinfo. But you can try 4k erases as well by
setting MTD_SPI_NOR_USE_4K_SECTORS.

> 
>> +               .fixups = &atmel_nor_global_protection_fixups
>> +       }, {
>>          }, {
>>                  .id = SNOR_ID(0x1f, 0x48, 0x00),
>>                  .name = "at25df641",
> 
> That works perfectly well (I can re-post the test results as my previous
> patch if needed): do you want me to send the updated patch with your
> Suggested-by tag or you can send yours, tell me what you prefer.

Send a new patch please, it was just a suggestion to speed the things up.
> 
> Thanks for the heads-up on this update that I hadn't noticed. Best regards,
>   Nicolas
> 
you're welcome! Cheers!
ta
