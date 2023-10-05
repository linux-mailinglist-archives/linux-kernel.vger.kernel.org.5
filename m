Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521747BA2A1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjJEPn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbjJEPnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:43:00 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3E039527
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:59:11 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5333fb34be3so1881853a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 07:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696517950; x=1697122750; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9JopC7TYgG/2635OqFhooPaGeIlxqKaTG9SmVPHwND4=;
        b=NPngVu4jDMUxkjKxIM7MuiKOz/Ob8E+VUlsj+KnWR0uTzUmKsaUBzUMZMWtmxyX2ad
         HR6YOr6Br5wAcNjX5hLMZUV4XiVBAXjO0dE/CMR/Vhe0paCKLvU8EHqpDFsXg182gp9u
         C4+LxkvjH4sNZahjHC3mnGbkQmBi0FSaK5FBBMATxcscLm1PblFpfWbAe9kJny0rvexg
         uArOwaJl9JEd6bQYJScOvE0autBDwNJAGz0VwWdy3+JQpFVyX3/JL3Kw30uRXnmxzN2W
         Vpt/CFPLt3/0ffQ5Pjuu5skLxORQE6iaCDTSorWpYKBMN3owBLl5aOw0lZL/0Mq17+A/
         K8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696517950; x=1697122750;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9JopC7TYgG/2635OqFhooPaGeIlxqKaTG9SmVPHwND4=;
        b=fHyhM37q8fld2NeNMb1GDtp3VTPfaqR754DwxIfojq8gCgOAngtlhmFifxkIP5UURF
         117C5ErIjrYBUMlHyJ7okATZW0zTqpbVJ1/aVwJbx0FWhrAduFjNc9Hs/DIgraLShiXM
         V8cZdrrARvstAyt8yk8UbEItZI/FMqFOGFFyrPnyg2SF5Wscm6ffjfXLuhD0ShxQ/roJ
         XCn2zXt9klJAeKVpfKwQEctUFr0zT7IktZgfU3L3hJz2zUKaU7ccALhnRGJSY0odM8CE
         LcuyTVGYHlrjiNrBsIgECl5QvrOiomMq4K7sV430xh2OFH5n3EFDzqKT0Ut8SH2CtWuR
         hSQA==
X-Gm-Message-State: AOJu0YyXXQ/eS1EG7FrtobbjMwSrM0pra4U6YGGZmhumVu/LZrlEo18C
        U/N9Kr1qab2Dr4xz6Ny/DSVjKA==
X-Google-Smtp-Source: AGHT+IG+b38fOmKIDaw6BVPf/3UBHv2rMRe/9KU78PirBUUFV7dv/8OntgO0zC26Ise6h1LdCseR7w==
X-Received: by 2002:a17:907:7787:b0:9ae:7206:963c with SMTP id ky7-20020a170907778700b009ae7206963cmr5870014ejc.15.1696517949880;
        Thu, 05 Oct 2023 07:59:09 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.123])
        by smtp.gmail.com with ESMTPSA id lr5-20020a170906fb8500b009adcb6c0f0esm1299270ejb.193.2023.10.05.07.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 07:59:09 -0700 (PDT)
Message-ID: <a86b93c4-a507-47c7-bdce-4aed8dfcf929@linaro.org>
Date:   Thu, 5 Oct 2023 15:59:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: micron-st: enable lock/unlock for mt25qu512a
Content-Language: en-US
To:     SHUKLA Mamta Ramendra <mamta.shukla@leica-geosystems.com>,
        "pratyush@kernel.org" <pratyush@kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     GEO-CHHER-bsp-development 
        <bsp-development.geo@leica-geosystems.com>
References: <20230705154942.3936658-1-mamta.shukla@leica-geosystems.com>
 <19800e51-a871-be9f-9eb5-5829237e2613@linaro.org>
 <a8271289-0611-4e37-cf37-0be19a85656b@leica-geosystems.com>
 <084ed945-7674-280f-5866-9238473a294d@leica-geosystems.com>
 <17989610-d069-40e2-9b4d-7ca6bdf2497e@linaro.org>
 <a24d7b3b-4077-9dbe-49ae-96f595b42223@leica-geosystems.com>
 <2d7271b3-dd60-44bb-9700-f6a5295ea873@linaro.org>
 <372046cb-9135-9a6c-fdb7-307a42f55b30@leica-geosystems.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <372046cb-9135-9a6c-fdb7-307a42f55b30@leica-geosystems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/5/23 15:21, SHUKLA Mamta Ramendra wrote:
> 
> 
> On 05.10.23 15:51, Tudor Ambarus wrote:
>> [Some people who received this message don't often get email from tudor.ambarus@linaro.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> This email is not from Hexagon’s Office 365 instance. Please be careful while clicking links, opening attachments, or replying to this email.
>>
>>
>> On 10/5/23 10:21, SHUKLA Mamta Ramendra wrote:
>>
>> cut
>>
>>>>
>>>> and the second one will add just the BP support, something like:
>>>> diff --git a/drivers/mtd/spi-nor/micron-st.c
>>>> b/drivers/mtd/spi-nor/micron-st.c
>>>> index a8da1f18e335..fdafbfa0f936 100644
>>>> --- a/drivers/mtd/spi-nor/micron-st.c
>>>> +++ b/drivers/mtd/spi-nor/micron-st.c
>>>> @@ -405,6 +405,8 @@ static const struct flash_info st_nor_parts[] = {
>>>>           }, {
>>>>                   .id = SNOR_ID(0x20, 0xbb, 0x20, 0x10, 0x44, 0x00),
>>>>                   .name = "mt25qu512a",
>>>> +               .flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB |
>>>> SPI_NOR_4BIT_BP |
>>>> +                        SPI_NOR_BP3_SR_BIT6,
>>>>                   .mfr_flags = USE_FSR,
>>>>           }, {
>>>>                   .id = SNOR_ID(0x20, 0xbb, 0x20),
>>>>
>>>> Of course, I expect you to run again the mtd_debug tests and also verify
>>>> the locking. Thanks!
>>>
>>> I applied both changes as mentioned above i.e
>>> 1] Switch to SFDP and 2] Using BP Flags.
>>>
>>> Case 1: Use BP Flags and Switch to SFDP
>>> With both these changes, the lock/unlock doesn't work.
>>>
>>> ## x86-64-smarc-evk-uwd0j0007 # uname -r
>>> 6.6.0-rc2
>>>
>>> # flash_lock -i /dev/mtd0
>>> Device: /dev/mtd0
>>> Start: 0
>>> Len: 0x4000000
>>> Lock status: unlocked
>>> Return code: 0
>>> # flash_lock -l /dev/mtd0
>>> flash_lock: error!: could not lock device: /dev/mtd0
>>>
>>>               error 5 (Input/output error)
>>>
>>>
>>> I suspected this is because of miscalculation of BP bits, like the
>>> possibility mentioned here:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/commit/?h=spi-nor/next&id=3ea3f0ac242c86c0275d347ab8c92bf1eb854b49 
>>>
>>>
>>> But further checked size, it is correct:
>>>
>>>    # mtd_debug info /dev/mtd0
>>> mtd.type = MTD_NORFLASH
>>> mtd.flags = MTD_CAP_NORFLASH
>>> mtd.size = 67108864 (64M)
>>> mtd.erasesize = 4096 (4K)
>>> mtd.writesize = 1
>>> mtd.oobsize = 0
>>> regions = 0
>>>
>>> And rest of read/write functions work as expected.
>>>
>>> Any suggestions about this?
>>>
>>> Case 2: Just added BP flags, rest of the size, mfr_flags, fixup flags
>>> kept as it is.
>>
>> would you please detail what exact definitions you used in case 2? Send
>> us the diff please.
> Case 2: Adding Flags for BP
> 
> diff --git a/drivers/mtd/spi-nor/micron-st.c 
> b/drivers/mtd/spi-nor/micron-st.c
> index 4afcfc57c896..6c8cabbead2e 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -405,6 +405,8 @@ static const struct flash_info st_nor_parts[] = {
>          }, {
>                  .id = SNOR_ID(0x20, 0xbb, 0x20, 0x10, 0x44, 0x00),
>                  .name = "mt25qu512a",
> +               .flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | 
> SPI_NOR_4BIT_BP |
> +                       SPI_NOR_BP3_SR_BIT6,
>                  .size = SZ_64M,
>                  .no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | 
> SPI_NOR_QUAD_READ,
>                  .fixup_flags = SPI_NOR_4B_OPCODES,
> 
> 

Thanks. Nothing obvious on a first look. I looked at the sfdp dump, it
looks like 4BAIT table is missing, so you'll probably need:
	.fixup_flags = SPI_NOR_4B_OPCODES,

I don't see how this could affect BP, but it is worth to test
incremental changes and find out what misses.

After you test the above, I'd like you to extend the patch with:
	.size = SZ_64M,
Check if it works and send us the output of mtd_debug info /dev/mtd0 here.

Also you could enable dev_dbg to see where you get -EIO. Probably when
reading the SR back. Also you can use debugfs to check what is set in
the working scenario and what params are different in the non-working
case. See drivers/mtd/spi-nor/debugfs.c

Cheers,
ta


> -----------------------------------------------------------------
> Case 1: BP Flags and removed size, and no_sfdp so by default expecting 
> to read SFDP
> 
> diff --git a/drivers/mtd/spi-nor/micron-st.c 
> b/drivers/mtd/spi-nor/micron-st.c
> index 6c8cabbead2e..4feb03ee2d13 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -407,9 +407,6 @@ static const struct flash_info st_nor_parts[] = {
>                  .name = "mt25qu512a",
>                  .flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | 
> SPI_NOR_4BIT_BP |
>                          SPI_NOR_BP3_SR_BIT6,
> -               .size = SZ_64M,
> -               .no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | 
> SPI_NOR_QUAD_READ,
> -               .fixup_flags = SPI_NOR_4B_OPCODES,
>                  .mfr_flags = USE_FSR,
>          }, {
> 
> 
> 
>>
>> Cheers,
>> ta
>>
>>> Lock/unlock works.
>>>
>>> ## x86-64-smarc-evk-uwd0j0007 # uname -r
>>> 6.6.0-rc2
>>>
>>> # flash_lock -i /dev/mtd0
>>> Start: 0
>>> Len: 0x4000000
>>> Lock status: unlocked
>>> Return code: 0
>>>
>>> # flash_lock -l /dev/mtd0
>>> # flash_lock -i /dev/mtd0
>>> Device: /dev/mtd0
>>> Start: 0
>>> Len: 0x4000000
>>> Lock status: locked
>>> Return code: 1
>>>
>>> ## x86-64-smarc-evk-uwd0j0007 # mtd_debug erase /dev/mtd0 0 1048576
>>> [  413.472411] spi-nor spi-PRP0001:00: Erase operation failed.
>>> [  413.478084] spi-nor spi-PRP0001:00: Attempted to modify a protected
>>> sector.
>>> MEMERASE: Input/output error
>>>
>>> # flash_lock -u /dev/mtd0
>>> # flash_lock -i /dev/mtd0
>>> Device: /dev/mtd0
>>> Start: 0
>>> Len: 0x4000000
>>> Lock status: unlocked
>>> Return code: 0
>>>
>>> ## x86-64-smarc-evk-uwd0j0007 #  mtd_debug erase /dev/mtd0 0 1048576
>>> Erased 1048576 bytes from address 0x00000000 in flash
>>>
>>>
>>> Further I tested on stable 6.5.5 Kernel with old way of Flash Info
>>> Format and which has forced PARSE_SFDP Flag, no issues with lock/unlock.
>>>
>>>
> 
> ---
> Mamta
