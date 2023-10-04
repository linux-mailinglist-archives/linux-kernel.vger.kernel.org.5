Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DEA7B7A81
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241762AbjJDIqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241822AbjJDIqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:46:08 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CA4B4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 01:46:01 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-533f193fc8dso3197952a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 01:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696409160; x=1697013960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iwt6yecZwQb9RsRqs87uClcaB8jIHdaxjvckvEuQJXo=;
        b=nRJ0qxoXTurn8d4tvmMIZ13t25YOpBr5ruGzC82VzC8y3r7tknX3W7w/s6JiTvewyI
         //1uAKErgNb0fntnAmAVnzOLwo9BFRct7ff5nT7XEj9DH4hH9tLbdCBQXiynJMDpNw/m
         zgy0AlgpZP7vQGkCfcQRAwYvYaCLdsw6dlVskBqAbJLM3LstqZvKKWSaznIWyb+orW+F
         mStgP/XUAsKpa2lW7g1omToKqXlwz3QchhD/EUTUktLb2eH8XYWvfhvtEMqlISlt0V/k
         NdCQtykKAxIiirniLGWqsB+Yv8hs/sFQ1ocBY2IUiWcdSupPsguHwOshzNSDVinLR2m4
         S+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696409160; x=1697013960;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iwt6yecZwQb9RsRqs87uClcaB8jIHdaxjvckvEuQJXo=;
        b=gf0vf7VU0khkvQJ9wjt0qIXWJSb71hXg90OFF5GTmdrw5UtvU0m0Crez2pzF+kNRzn
         yY7ffHK20tLbXAjTh6TTZesqyOdG25olgn+mzUlbENh8c8G2VzYQkMkr5XZEJAdYYrOz
         ax7OKCMuX+appP6JJK6RnmiQiMLlLZuXyD4Dt6403bvjVqXY9PEqkI+mwa8ll3COAYuY
         La0SdaGeWmJsa7acJy/XSkE5jd1w5oFUREDB33rBMGFjKTZWAjmIrw8z6d4IJCPkeq4d
         xYEgdoAnjogl1li22N7TRsThnGywqooXRYHyxfpS4SBrjzEV4qxaKrZoO22VmMInrYLi
         rbng==
X-Gm-Message-State: AOJu0Yw/kxBzAB2KRgAEbgbOIpikX5f7UGBq7AYaM8kubyvAOE9UJHYJ
        bJLwzJpsQzPWyeumDX+7CC0=
X-Google-Smtp-Source: AGHT+IH1fMjq62Gk6rhHc+iucHf6asMon83lNrjM18EM+difkExI/cC19QvT1Zq7gIYruQC6uZvYFA==
X-Received: by 2002:aa7:db46:0:b0:532:ac24:3081 with SMTP id n6-20020aa7db46000000b00532ac243081mr1398036edt.30.1696409160139;
        Wed, 04 Oct 2023 01:46:00 -0700 (PDT)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id i18-20020aa7dd12000000b0052889d090bfsm2082065edv.79.2023.10.04.01.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 01:45:59 -0700 (PDT)
Message-ID: <691f908e-37ed-4f3a-8c7f-e9615819d3db@gmail.com>
Date:   Wed, 4 Oct 2023 10:45:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "nvmem: add new config option"
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Alban Bedel <albeu@free.fr>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20230718084804.20139-1-zajec5@gmail.com>
 <ba3c419a-6511-480a-b5f2-6c418f9c02e7@gmail.com>
Content-Language: en-US
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <ba3c419a-6511-480a-b5f2-6c418f9c02e7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Srini,

On 26.08.2023 22:15, Rafał Miłecki wrote:
> On 18.07.2023 10:48, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> This reverts commit 517f14d9cf3533d5ab4fded195ab6f80a92e378f.
>>
>> It seems that "no_of_node" config option was added to help mtd's case.
>>
>> DT nodes of MTD partitions (that are also NVMEM devices) may contain
>> subnodes that SHOULD NOT be treated as NVMEM fixed cells. To prevent
>> NVMEM core code from parsing them "no_of_node" was set to true and that
>> made for_each_child_of_node() in NVMEM a no-op.
>>
>> With the introduction of "add_legacy_fixed_of_cells" config option
>> things got more explicit. MTD subsystem simply tells NVMEM when to look
>> for fixed cells and there is no need to hack "of_node" pointer anymore.
>>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
>> Important: this is based on top of the
>> [PATCH V4] nvmem: add explicit config option to read old syntax fixed OF cells
> 
> I see you skipped those two patches for 6.6.
> 
> Can you queue them for 6.7, please?

Did you have a chance to look at this one?

>> ---
>>   drivers/mtd/mtdcore.c          | 1 -
>>   drivers/nvmem/core.c           | 2 +-
>>   include/linux/nvmem-provider.h | 2 --
>>   3 files changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
>> index 9db8d7853639..3d781ffb8c32 100644
>> --- a/drivers/mtd/mtdcore.c
>> +++ b/drivers/mtd/mtdcore.c
>> @@ -554,7 +554,6 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
>>       config.read_only = true;
>>       config.root_only = true;
>>       config.ignore_wp = true;
>> -    config.no_of_node = !of_device_is_compatible(node, "nvmem-cells");
>>       config.priv = mtd;
>>       mtd->nvmem = nvmem_register(&config);
>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>> index 58d8919e6682..a0c9153cda28 100644
>> --- a/drivers/nvmem/core.c
>> +++ b/drivers/nvmem/core.c
>> @@ -1027,7 +1027,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>>       nvmem->nkeepout = config->nkeepout;
>>       if (config->of_node)
>>           nvmem->dev.of_node = config->of_node;
>> -    else if (!config->no_of_node)
>> +    else
>>           nvmem->dev.of_node = config->dev->of_node;
>>       switch (config->id) {
>> diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
>> index 1b81adebdb8b..e3930835235b 100644
>> --- a/include/linux/nvmem-provider.h
>> +++ b/include/linux/nvmem-provider.h
>> @@ -89,7 +89,6 @@ struct nvmem_cell_info {
>>    * @read_only:    Device is read-only.
>>    * @root_only:    Device is accessibly to root only.
>>    * @of_node:    If given, this will be used instead of the parent's of_node.
>> - * @no_of_node:    Device should not use the parent's of_node even if it's !NULL.
>>    * @reg_read:    Callback to read data.
>>    * @reg_write:    Callback to write data.
>>    * @size:    Device size.
>> @@ -122,7 +121,6 @@ struct nvmem_config {
>>       bool            ignore_wp;
>>       struct nvmem_layout    *layout;
>>       struct device_node    *of_node;
>> -    bool            no_of_node;
>>       nvmem_reg_read_t    reg_read;
>>       nvmem_reg_write_t    reg_write;
>>       int    size;
> 

