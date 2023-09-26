Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A627AEDE2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 15:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjIZNTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 09:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjIZNTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 09:19:06 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ED9C9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 06:18:59 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-405505b07dfso40513855e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 06:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695734338; x=1696339138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4PjPtI/KNSgGV2G6UEPfAmxRBmkSix0OyKfO1YcoktM=;
        b=R5gX/pqKHzZxPJ43igBNbhEZL5CwlqOcp2XtQUt4a8K/c7whJEQXOIKj9tm2EpFxfA
         1hm3t36adBjotd5uUQkEBLFjdEhXAEwBXAbwsswJO8VSpFywH1MPFwgDXTgTuDqG5/Py
         eCHHz4S4JQA9n7yFSkd+mnozihnceaJRXlHO9zZwKg4vjNScwt5IAhYB0KFO8vwTcEJN
         JB9cTr2YFQl3qj0X9Gh8ux2Bcp2JnvY2vV0MaQc4JCwA/iqhUP+HhCQ0JuVVE2ypkGlb
         Pr8Rzk9koPFOwAXHd8COMRB9Kjvut5niF9QZSay1glJ07OBEQG/+Ove2fo9zwQhoUnih
         +Lig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695734338; x=1696339138;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4PjPtI/KNSgGV2G6UEPfAmxRBmkSix0OyKfO1YcoktM=;
        b=W9TX3IRooaC5LiTjSRcLNQEeCdrFseoXNzzRNg2QMo7tzkHEsitU9zZWnpmcizPTR9
         IqI0x0V7AejOFyRPn8Dde29n+nJsG7yEyOnQ8gDN5S6PlTAQV7bavdKNCKpnLMkt8evL
         kW/0Q+nH2HkTbxPwhcoCavi2P9oqIfq+7gFybC98ryUXDLv1D4a9CwTF9jzOXgH9v1xa
         XvmmuB3JyQuJkRjyjkNvaP8tM4NxhZuJepwd7C84BDGgR5Db1mwdKkIisC9ANZw0g0gA
         zddKDo9VioCKlP52Wy0/Hv9bcMJ24Po5l4tAFFwsRfR/omicuBZuo5pcbYq14xucHBnG
         FYLw==
X-Gm-Message-State: AOJu0YxSH631Jt27JpIBn3SdK4phewxSGqdGLzgmFvb2uDsbCICYhwvA
        xVicq++BEPcQnswUBwWpL0DaRUOOX6Zs709x+Xc=
X-Google-Smtp-Source: AGHT+IFiMTinsYIoj1BsaQVVf58PkDZPG+2WTFp2DLMqdQLJG1eFlaTsIoD2X/R7rdtOZIXPVcOnkg==
X-Received: by 2002:a5d:5246:0:b0:319:6b56:94d9 with SMTP id k6-20020a5d5246000000b003196b5694d9mr2014087wrc.2.1695734337954;
        Tue, 26 Sep 2023 06:18:57 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.123])
        by smtp.gmail.com with ESMTPSA id d6-20020adff2c6000000b003217af3f530sm14973127wrp.0.2023.09.26.06.18.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 06:18:57 -0700 (PDT)
Message-ID: <125fe1a7-bc52-46a7-93d5-b09caf5ca9f8@linaro.org>
Date:   Tue, 26 Sep 2023 14:18:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: atmel: add at25ff321a entry
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        miquel.raynal@bootlin.com, linux-mtd@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230908151400.164470-1-nicolas.ferre@microchip.com>
 <8d72820d-bbaa-abc8-4448-87f0f054c381@linaro.org>
 <4c9b0dff-6350-376b-60ac-c36f98378a51@microchip.com>
 <306a6aa0-c608-418a-a591-6f8aa95817fb@linaro.org>
 <925723a2-dc2d-9949-5b8f-4351b49d2f4b@microchip.com>
Content-Language: en-US
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <925723a2-dc2d-9949-5b8f-4351b49d2f4b@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/23 13:59, Nicolas Ferre wrote:
> On 21/09/2023 at 09:14, Tudor Ambarus wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know
>> the content is safe
>>
>> On 9/20/23 17:16, Nicolas Ferre wrote:
>>> On 19/09/2023 at 18:12, Tudor Ambarus wrote:
>>>> On 08.09.2023 18:14, nicolas.ferre@microchip.com wrote:
>>>>> From: Nicolas Ferre <nicolas.ferre@microchip.com>
>>>>>
>>>>> Add the at25ff321a 4MB SPI flash which is able to provide
>>>>> SFDP informations.
>>>>> Datasheet:
>>>>> https://www.renesas.com/us/en/document/dst/at25ff321a-datasheet
>>>>>
>>>>> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>>>>> ---
>>>
>>> [..]
>>>
>>>>>    drivers/mtd/spi-nor/atmel.c | 4 ++++
>>>>>    1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
>>>>> index 58968c1e7d2f..c94d52951481 100644
>>>>> --- a/drivers/mtd/spi-nor/atmel.c
>>>>> +++ b/drivers/mtd/spi-nor/atmel.c
>>>>> @@ -184,6 +184,10 @@ static const struct flash_info atmel_nor_parts[]
>>>>> = {
>>>>>                 FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
>>>>>                 NO_SFDP_FLAGS(SECT_4K)
>>>>>                 .fixups = &atmel_nor_global_protection_fixups },
>>>>> +     { "at25ff321a", INFO(0x1f4708, 0, 64 * 1024,  64)
>>>>> +             FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
>>>>> +             PARSE_SFDP
>>>>> +             .fixups = &atmel_nor_global_protection_fixups },
>>>>
>>>> We have recently changed how the flash entries are defined. Would you
>>>> please try the following changes instead?
>>>>
>>>> diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
>>>> index 95f0e139284e..44218716d81e 100644
>>>> --- a/drivers/mtd/spi-nor/atmel.c
>>>> +++ b/drivers/mtd/spi-nor/atmel.c
>>>> @@ -213,6 +213,12 @@ static const struct flash_info
>>>> atmel_nor_parts[] = {
>>>>                   .flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
>>>>                   .no_sfdp_flags = SECT_4K,
>>>>                   .fixups = &atmel_nor_global_protection_fixups
>>>> +       }, {
>>>> +               .id = SNOR_ID(0x1f, 0x47, 0x08),
>>>> +               .name = "at25ff321a",
>>>> +               .flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
>>>
>>> Here, I added:
>>>
>>>                 .no_sfdp_flags = SECT_4K,
>>>
>>> to match the other devices of the family... I checked on the datasheet,
>>> 4K sectors are okay, but I don't know exactly if this is eligible to the
>>> "no_sfdb_flags" property... forgive me, I didn't check further knowing
>>> that you might have better view on this than me ;-)
>>
>> yeah, no worries. You should not specify 4k here, as it should already
>> be set when parsing SFDP. You can use mtdinfo /dev/mtdx to check what
>> erase size gets set. In the core we set the maximum supported erase size
>> for speed considerations and making ubifs happy, so you'll probably see
>> 64k when checking with mtdinfo. But you can try 4k erases as well by
>> setting MTD_SPI_NOR_USE_4K_SECTORS.
> 
> Absolutely, here is what I'm experiencing:
> # no_sfdp_flags not set / linux-next / sama5d27 wlsom1 ek
> # CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
> root@sama5d27-wlsom1-ek-sd:~# mtdinfo /dev/mtd0
> mtd0
> Name:                           spi0.1
> Type:                           nor
> Eraseblock size:                4096 bytes, 4.0 KiB
> Amount of eraseblocks:          1024 (4194304 bytes, 4.0 MiB)
> Minimum input/output unit size: 1 byte
> Sub-page size:                  1 byte
> Character device major/minor:   90:0
> Bad blocks are allowed:         false
> Device is writable:             true
> 
> # no_sfdp_flags not set / linux-next / sama5d27 wlsom1 ek
> # # CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
> root@sama5d27-wlsom1-ek-sd:~# mtdinfo /dev/mtd0
> mtd0
> Name:                           spi0.1
> Type:                           nor
> Eraseblock size:                65536 bytes, 64.0 KiB
> Amount of eraseblocks:          64 (4194304 bytes, 4.0 MiB)
> Minimum input/output unit size: 1 byte
> Sub-page size:                  1 byte
> Character device major/minor:   90:0
> Bad blocks are allowed:         false
> Device is writable:             true
> 

looks good!

>>>> +               .fixups = &atmel_nor_global_protection_fixups
>>>> +       }, {
>>>>           }, {
>>>>                   .id = SNOR_ID(0x1f, 0x48, 0x00),
>>>>                   .name = "at25df641",
>>>
>>> That works perfectly well (I can re-post the test results as my previous
>>> patch if needed): do you want me to send the updated patch with your
>>> Suggested-by tag or you can send yours, tell me what you prefer.
>>
>> Send a new patch please, it was just a suggestion to speed the things up.
> 
> Sure, I'm on it ;-)
> 
>>> Thanks for the heads-up on this update that I hadn't noticed. Best
>>> regards,
>>>    Nicolas
>>>
>> you're welcome! Cheers!
> 
> Best regards,
>  Nicolas
> 
