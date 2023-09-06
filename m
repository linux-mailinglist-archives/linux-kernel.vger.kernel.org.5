Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01FD793605
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjIFHPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjIFHPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:15:20 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E060ACFA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 00:15:15 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52c88a03f99so4394818a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 00:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693984514; x=1694589314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zvYk7hlbdfvGIQ0UNsbh1lqI3GDQsOHgcvyHeWCevbw=;
        b=xUAKlDnAPPCc4iLoGwrma6akLa/8H05TB/FNKjaYlLF0srxsOHKxnnU6eiHCsfuFmW
         UMMWaY/proCEpRZsgrO03b9G/5VxLahWB749y3VK+EDPLGJ9x7MEn6POYjZSz1+19as3
         SonYAb+hRemUb6LhjGiV2auQkAb/X+gDUL2coH1zbIzlWF0rcogBr+HyKHQgeW3xXLIt
         Zk2Sl2pekmCxg/ZYN6oEATLQlOC4b8CcVl3IjtDXfkL6YSajg/r9pxBWfmyQeqVzzx1J
         EM2QeAMhC1gWNQnFBMUqVUyg/zR921S4ks1adFLPkBd988+FPg1RYxEnX7sZRcBZNXcW
         +vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693984514; x=1694589314;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvYk7hlbdfvGIQ0UNsbh1lqI3GDQsOHgcvyHeWCevbw=;
        b=kD16pNN5y6WUfDyytGA+9dG80H3K29g+Nqn3sh6MYjHQOmUuOtEqne2zEF17pMXstx
         pbc/+hb25j+llspvHjinNHH/5eHUgSbbqSqfec0m8WLJk1KP1LBmx658/k5tPl38Qisf
         JCuofZB+rJP9rS2NxIFXeNZKPrFMZVRCcAYhYDgMFEv2xny93bK6bYiLO4P90vEqGEVi
         YNip81eDqWOeI/qMe/rTQAU1LuRFHlGLu9xX5ZYuGrWowGECOQ8MFVtfgtlPdsXKQiAO
         yuNS6REVK4SYfbvwK78qNOs5+mYAIcB5uSRZNh3plPZ0uC5zLHYvXtw70I1PW++0nloS
         RUBw==
X-Gm-Message-State: AOJu0YyNIRdRdP62FV/LLJB5snyk9haxigjWhmrT1y9Vky3V2G7nemj4
        EhsH/E6Q574AKAsCwGFgAev0oA==
X-Google-Smtp-Source: AGHT+IHtNFCR173u9LjNnxCJ8MwOIIla9Ptsuwn6OYk5gXsHEzJAWQqQpBcBnd0dMzsMxi2Jj4CSig==
X-Received: by 2002:a50:ee0b:0:b0:52e:1d58:a6ff with SMTP id g11-20020a50ee0b000000b0052e1d58a6ffmr1444100eds.35.1693984514369;
        Wed, 06 Sep 2023 00:15:14 -0700 (PDT)
Received: from [192.168.0.107] ([79.115.63.137])
        by smtp.gmail.com with ESMTPSA id w16-20020a056402269000b0052e1959db1csm4011232edd.20.2023.09.06.00.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 00:15:13 -0700 (PDT)
Message-ID: <c085d93b-2759-47ac-b21b-aac0b924349b@linaro.org>
Date:   Wed, 6 Sep 2023 08:15:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/41] mtd: spi-nor: move the .id and .id_len into an
 own structure
Content-Language: en-US
To:     Michael Walle <mwalle@kernel.org>
Cc:     Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
 <20230807-mtd-flash-info-db-rework-v2-13-291a0f39f8d8@kernel.org>
 <4cbc9c03-7b47-48e9-8a91-f08c44284579@linaro.org>
 <bbf76bffaa699b2a8f4f9e33809dea06@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <bbf76bffaa699b2a8f4f9e33809dea06@kernel.org>
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



On 9/6/23 08:13, Michael Walle wrote:
> Am 2023-09-06 08:12, schrieb Tudor Ambarus:
>> On 8/22/23 08:09, Michael Walle wrote:
>>> Create a new structure to hold a flash ID and its length. The goal is to
>>> have a new macro SNOR_ID() which can have a flexible id length. This way
>>> we can get rid of all the individual INFOx() macros.
>>>
>>> Signed-off-by: Michael Walle <mwalle@kernel.org>
>>> ---
>>>  drivers/mtd/spi-nor/core.c      |  6 +++---
>>>  drivers/mtd/spi-nor/core.h      | 33 ++++++++++++++++++++++++---------
>>>  drivers/mtd/spi-nor/micron-st.c |  4 ++--
>>>  drivers/mtd/spi-nor/spansion.c  |  4 ++--
>>>  drivers/mtd/spi-nor/sysfs.c     |  6 +++---
>>>  drivers/mtd/spi-nor/winbond.c   |  1 -
>>>  6 files changed, 34 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>>> index 4ba1778eda4b..80c340c7863a 100644
>>> --- a/drivers/mtd/spi-nor/core.c
>>> +++ b/drivers/mtd/spi-nor/core.c
>>> @@ -2028,8 +2028,8 @@ static const struct flash_info
>>> *spi_nor_match_id(struct spi_nor *nor,
>>>      for (i = 0; i < ARRAY_SIZE(manufacturers); i++) {
>>>          for (j = 0; j < manufacturers[i]->nparts; j++) {
>>>              part = &manufacturers[i]->parts[j];
>>> -            if (part->id_len &&
>>> -                !memcmp(part->id, id, part->id_len)) {
>>> +            if (part->id &&
>>> +                !memcmp(part->id->bytes, id, part->id->len)) {
>>>                  nor->manufacturer = manufacturers[i];
>>>                  return part;
>>>              }
>>> @@ -3370,7 +3370,7 @@ static const struct flash_info
>>> *spi_nor_get_flash_info(struct spi_nor *nor,
>>>       * If caller has specified name of flash model that can normally be
>>>       * detected using JEDEC, let's verify it.
>>>       */
>>> -    if (name && info->id_len) {
>>> +    if (name && info->id) {
>>>          const struct flash_info *jinfo;
>>>
>>>          jinfo = spi_nor_detect(nor);
>>> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
>>> index c42b65623da7..81535f31907f 100644
>>> --- a/drivers/mtd/spi-nor/core.h
>>> +++ b/drivers/mtd/spi-nor/core.h
>>> @@ -446,12 +446,22 @@ struct spi_nor_fixups {
>>>      int (*late_init)(struct spi_nor *nor);
>>>  };
>>>
>>> +/**
>>> + * struct spi_nor_id - SPI NOR flash ID.
>>> + *
>>> + * @bytes: the flash's ID bytes. The first three bytes are the JEDIC
>>> ID.
>>
>> typo, JEDIC. But are there 3 bytes of ID specified by JEDEC? I remeber
>> there's only the MFR ID specified, the rest are flash specific, which
>> are not mentioned by JEDEC.
> 
> I just moved the description from flash_info :p
> 
> As far as I know, this isn't really specified at all, is it? I couldn't
> even find that the "read jedec id" command 9F is specified anywhere. Do
> you know more?

it's not part of jesd215 as far as I remember, indeed.
> 
> Also the first three bytes is also wrong. It might be more or less. I'd
> treat it as opaque - the SNOR_ID() can now have an arbitrary length -
> but I would mention that this *typically* has the form of
> <1 byte mfr id> <2 byte flash part id>
> 
> I.e.
> @bytes: the bytes returned by the flash when issuing command 9F.
>         Typically, the first byte is the manufacturer ID code (see
>         JEP106) and the next two bytes are a flash part specific ID.
> 

sounds good
