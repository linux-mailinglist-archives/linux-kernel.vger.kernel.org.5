Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EF87A686B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 17:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbjISP5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 11:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjISP5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 11:57:42 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3655791
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 08:57:36 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9ae22bf33a0so295563166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 08:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695139054; x=1695743854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IKGEdd9joz9wrUZ2JRmffjhMh4fTSLb3Ojl1LyplXW8=;
        b=Bauv3Bj4hc40u9wZ4Qy4kAPUpFbxNQTNKzep4UObxIkMVCdJZEKhYUxCCB59MwghkX
         TISTQ8c9RNu38DbE5clo/pUIb4fVMq9TIuoG6aA9H2SdWGuMdh5eeoqgxLMNJE/m2TAc
         9aXVzu7xkBDvXF29Aoh1R/zZfnMij1Q1+21/vtKBkialSe5sRh06Hx4IuSF7XawtCff7
         ZQXv5WTxu9ga7naNCpM1IoRgtWusLugXO/NMKB+tqQyBTdhp/2k8U7OitvkqcJdXSnHI
         uKhMJrxqtapuewGHCMJWZ/Eih3MTaTEZXQusPTjN1rstWFZhjv/Ti8YwN/EUXQp8qrCs
         wXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695139054; x=1695743854;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IKGEdd9joz9wrUZ2JRmffjhMh4fTSLb3Ojl1LyplXW8=;
        b=TcgMF2qKxfkL3kT5DB2AnKll3J15H/GquGQH9JslNRYdeEmp6BFkIkFwIg8wwzRtbq
         Yl9ENKnAq0hcGXfiiJEuiVu3WYQIk8Yq74d1/oNCevsoJJ6i/2WuW39BvuIVrmqOBKP5
         7/5PFJsDFuNXXDXkG1CtRnm/N9IwPBOW14ZX3EFUc+JW2+cRhBqxhaNrdgrPbRUJ7FoV
         mnN09E3IPA2/URU2L9KGZUKempeqdVh5a/KCDjaFpgh/4RPSaYXdWbljpyFsCfXsdBi2
         8L0lFFJVFKpSPAAP3qlot2+jriwgRwoMmE5GigyRUUPijFigQXVIlhY3vneCvVGczT6L
         /GvA==
X-Gm-Message-State: AOJu0YyEYQFCvaCGVGlMp80zY6ksj/4bDBBU35gUZTc4/lUEiUstYS4a
        pqASMnSo7ch2OSnpS79n8pO4pWZsUToybVNFFKMjDA==
X-Google-Smtp-Source: AGHT+IEdb1FOFYFSHJmx8fdRbtk9F7+CCZLypla3cI36pyOaiY0dieAc0udjJGO081OjUgD/+8RA1g==
X-Received: by 2002:a17:906:73d5:b0:9a1:b144:30f4 with SMTP id n21-20020a17090673d500b009a1b14430f4mr170754ejl.14.1695139054600;
        Tue, 19 Sep 2023 08:57:34 -0700 (PDT)
Received: from [172.20.101.114] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id u26-20020a170906c41a00b00989828a42e8sm8034584ejz.154.2023.09.19.08.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 08:57:34 -0700 (PDT)
Message-ID: <ad085fb3-8c71-2af1-db40-990213e9288d@linaro.org>
Date:   Tue, 19 Sep 2023 18:57:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 20/41] mtd: spi-nor: everspin: convert flash_info to
 new format
To:     Michael Walle <mwalle@kernel.org>
Cc:     Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20230807-mtd-flash-info-db-rework-v3-0-e60548861b10@kernel.org>
 <20230807-mtd-flash-info-db-rework-v3-20-e60548861b10@kernel.org>
 <647d3775-a71d-a880-6d4d-3eb5a89ec9d6@linaro.org>
 <e7a48b040541f783773d9d0039816633@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
Content-Language: en-US
In-Reply-To: <e7a48b040541f783773d9d0039816633@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.09.2023 14:33, Michael Walle wrote:
> Am 2023-09-19 11:24, schrieb Tudor Ambarus:
>> On 08.09.2023 13:16, Michael Walle wrote:
>>> The INFOx() macros are going away. Convert the flash_info database to
>>> the new format.
>>>
>>> Signed-off-by: Michael Walle <mwalle@kernel.org>
>>> ---
>>>  drivers/mtd/spi-nor/everspin.c | 33 +++++++++++++++++++++++++++++----
>>>  1 file changed, 29 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/mtd/spi-nor/everspin.c
>>> b/drivers/mtd/spi-nor/everspin.c
>>> index d02c32f2f7ad..46776bc10b27 100644
>>> --- a/drivers/mtd/spi-nor/everspin.c
>>> +++ b/drivers/mtd/spi-nor/everspin.c
>>> @@ -9,10 +9,35 @@
>>>  #include "core.h"
>>>
>>>  static const struct flash_info everspin_nor_parts[] = {
>>> -    { "mr25h128", CAT25_INFO(16 * 1024, 1, 256, 2) },
>>> -    { "mr25h256", CAT25_INFO(32 * 1024, 1, 256, 2) },
>>> -    { "mr25h10",  CAT25_INFO(128 * 1024, 1, 256, 3) },
>>> -    { "mr25h40",  CAT25_INFO(512 * 1024, 1, 256, 3) },
>>> +    {
>>> +        .name = "mr25h128",
>>> +        .size = SZ_16K,
>>> +        .sector_size = SZ_16K,
>>> +        .page_size = 256,
>>
>> page size defaults to 256, isn't it? Can we get rid of the page_size
>> assignments?
> 
> Yes!
> 
>>
>>> +        .addr_nbytes = 2,
>>> +        .flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
>>> +    }, {
>>> +        .name = "mr25h256",
>>> +        .size = SZ_32K,
>>> +        .sector_size = SZ_32K,
>>> +        .page_size = 256,
>>> +        .addr_nbytes = 2,
>>> +        .flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
>>> +    }, {
>>> +        .name = "mr25h10",
>>> +        .size = SZ_128K,
>>> +        .sector_size = SZ_128K,
>>> +        .page_size = 256,
>>> +        .addr_nbytes = 3,
> 
> also "addr_nbytes = 3" is the default.

ok, updating now.

> 
> -michael
> 
>>> +        .flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
>>> +    }, {
>>> +        .name = "mr25h40",
>>> +        .size = SZ_512K,
>>> +        .sector_size = SZ_512K,
>>> +        .page_size = 256,
>>> +        .addr_nbytes = 3,
>>> +        .flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
>>> +    }
>>>  };
>>>
>>>  const struct spi_nor_manufacturer spi_nor_everspin = {
>>>
