Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBF57BD32E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 08:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345197AbjJIGNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 02:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345128AbjJIGNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:13:47 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E836F1
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 23:13:35 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so51458371fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 23:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696832013; x=1697436813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LiJrsvnGPRobXrJdTj89DsFn8NcM56fCbscmDol6QNw=;
        b=OZJa1wEfqZEsahmnGmLbwt2LGiyST5voCui7tl6Dt3qN9opG/vCXflmD306BxsgX9w
         Uc3X0GfdlagBglNhRf4EdnpPOwl7LlJHhNDKK6pvbu9ex9IGzoSQDJkA/MW6ChsDM9O/
         E8ajkJn661nohuioRStP3YigTuRuoDT0rr57MaeXuzq3EN3jHa9ckfYETUk+gHLpqPPg
         G6Jfi6sMhwXRXvxrJWlZVuGadBGVZuNjIizdvrFGhyr9mPKlHFAQqdljNNU8iNFd7OQg
         7tnGYDXYooKOFPPAkQglXlvshZK0XbozKN1qq6NVv0pWoHx+ZnOxNkLYjQi2ZulGrlSb
         JUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696832013; x=1697436813;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LiJrsvnGPRobXrJdTj89DsFn8NcM56fCbscmDol6QNw=;
        b=oCI2ExlCs9c6Q1jaafNtsme1ZWR5tCV6lMOXQ0fTklciR0QgxITGMBlo5sj/Qi8STe
         YNTqG/heSgVFNarNQ4v3v8pwRpvbEdXWxRQ7d8QVhB5TRSmdTcsln93pcx99DbcJJTuB
         3IsTDHgEU384ytFQwmdqVKI7lVc9t2BRi3lnmN9wjThoo6mZ8ik+dXi9tArlA/ymnS38
         MvlH5Z+r7g3UbBF0jQ6Im2rqds9oNcMtJw7tdaSUw6qg6oxeiyi6VsIZQvp5SgjDEFMe
         Jf80Zf+0/Nn5NEye5sR44wZPxQU2smjQkZvV1qI+jjZDkACgFVLbNf5a63pf7PwRe4yz
         qCnQ==
X-Gm-Message-State: AOJu0YwnQYvRZ8JQ+Gb8GC7qoyu9V7iX9WlW2by6f3qq3cA8M8KOm3kT
        jDaLAs1cLGtKMluu0Nm6p4eA4Q==
X-Google-Smtp-Source: AGHT+IFdWs4OfmCoxzdj2dCucyWYWCYqIEoYeEeWYDec3XNZFrslG2PBfDbIwzzEUEGgbycu1HUtAQ==
X-Received: by 2002:a05:6512:522:b0:501:bf30:714c with SMTP id o2-20020a056512052200b00501bf30714cmr13379172lfc.24.1696832013002;
        Sun, 08 Oct 2023 23:13:33 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.123])
        by smtp.gmail.com with ESMTPSA id az41-20020a05600c602900b004068495910csm12327762wmb.23.2023.10.08.23.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Oct 2023 23:13:32 -0700 (PDT)
Message-ID: <2e3ce75d-7e2d-4e62-8660-48a41074c20c@linaro.org>
Date:   Mon, 9 Oct 2023 07:13:31 +0100
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
 <a86b93c4-a507-47c7-bdce-4aed8dfcf929@linaro.org>
 <eb2a9138-a76e-4b1e-e001-315149c4dabd@leica-geosystems.com>
 <f0a7acb3-00b5-433d-af5c-724a509fb816@linaro.org>
 <bc76767e-00c1-47ca-9a27-2aa7d2a262f6@linaro.org>
 <b9b7bb93-fe23-34dd-6a30-b1b0d792861f@leica-geosystems.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <b9b7bb93-fe23-34dd-6a30-b1b0d792861f@leica-geosystems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/23 17:09, SHUKLA Mamta Ramendra wrote:
> 
> 
> Hello Tudor,
> 
Hi!

> 
>> On 10/6/23 14:33, Tudor Ambarus wrote:
>>>
>>> Hi,
>>>
>>> Thanks for the debugging info.
>>>
>>> On 10/6/23 11:30, SHUKLA Mamta Ramendra wrote:
>>>
>>> cut
>>>
>>>> --------------------------------------------------------
>>>>
>>>> IMO, HAS_16BIT_SR flag is causing lock/unlock failure,
>>>> since BP bits are calculated wrong then.
>>>>
>>>> I tested also for a case where I don't parse SFDP and
>>>> reverted the condition in  micron_st_nor_default_init()
>>>> for 16BIT Status Register Flag. And lock/unlock fails with
>>>> same log as Non-working case.
>>>>
>>>> And this mt25qu512 has 8-BIT SR as typical micron-st flash.
>>>>
>>>
>>> Indeed, the problem is that HAS_16BIT_SR gets set when it shouldn't have
>>> to. This means that the BFPT table of the flash is wrong and we should
>>> fix the parsed settings via a post_bfpt hook.
>>>
>>> Does the following fix your problem?
>>>
>>
>> here it is again, this time compile tested:
>>
>> diff --git a/drivers/mtd/spi-nor/micron-st.c
>> b/drivers/mtd/spi-nor/micron-st.c
>> index 4afcfc57c896..20f76e278095 100644
>> --- a/drivers/mtd/spi-nor/micron-st.c
>> +++ b/drivers/mtd/spi-nor/micron-st.c
>> @@ -180,6 +180,18 @@ static const struct flash_info micron_nor_parts[] = {
>>          },
>>   };
>>
>> +static int mt25qu512a_post_bfpt_fixup(struct spi_nor *nor,
>> +                               const struct sfdp_parameter_header
>> *bfpt_header,
>> +                               const struct sfdp_bfpt *bfpt)
>> +{
>> +       nor->flags &= ~SNOR_F_HAS_16BIT_SR;
>> +       return 0;
>> +}
>> +
>> +static struct spi_nor_fixups mt25qu512a_fixups = {
>> +       .post_bfpt = mt25qu512a_post_bfpt_fixup,
>> +};
>> +
>>   static const struct flash_info st_nor_parts[] = {
>>          {
>>                  .name = "m25p05-nonjedec",
>> @@ -405,10 +417,10 @@ static const struct flash_info st_nor_parts[] = {
>>          }, {
>>                  .id = SNOR_ID(0x20, 0xbb, 0x20, 0x10, 0x44, 0x00),
>>                  .name = "mt25qu512a",
>> -               .size = SZ_64M,
>> -               .no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ |
>> SPI_NOR_QUAD_READ,
>> -               .fixup_flags = SPI_NOR_4B_OPCODES,
>> +               .flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB |
>> SPI_NOR_4BIT_BP |
>> +                        SPI_NOR_BP3_SR_BIT6,
>>                  .mfr_flags = USE_FSR,
>> +               .fixups = &mt25qu512a_fixups,
>>          }, {
>>                  .id = SNOR_ID(0x20, 0xbb, 0x20),
>>                  .name = "n25q512a",
>>
>> cut
> 
> 
> Thanks. Yes, this post  BFPT fixup resolves lock/unlock issue and
> I don't see HAS_16BIT_SR flag in params.

Good. Please send some patches addressing all that we discussed until now.
> 
> 
> Datasheet is public: 
> https://media-www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25q/die-rev-b/mt25q_qlkt_u_512_abb_0.pdf?rev=b259aadc3bea49ea8210a41c9ad58211 
> 
I'll take a look later today.

Cheers,
ta
> 
>>> If yes, please add some prints in sfdp.c to determine where it's set,
>>> either in BFPT_DWORD15_QER_SR2_BIT1 or BFPT_DWORD15_QER_SR2_BIT1_NO_RD
>>> Is the datasheet for this flash public? Would you send me a link to it
>>> please?
>>>
>>> Cheers,
>>> ta
