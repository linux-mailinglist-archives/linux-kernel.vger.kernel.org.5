Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53113813373
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573500AbjLNOpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjLNOpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:45:51 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E9D136
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:45:36 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cea5548eb2so7522563b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1702565135; x=1703169935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tF4v5FAsSpR40LsU66vSHRRQwz/YE34tpX6gezwc28s=;
        b=jSGj3mnSLnq4/KXy+SKOBW15VZ+4iN2O4vuAHDQPtiLWaRLXmfosK5kGmwNDSQ3YJA
         yiPygQR4xAYWfLsYU49RM6E8W71eybgrt1BiAMcdhM1ui1IT2ggNhuiVlE8gVDZllj9M
         TJhSSxIdh8NlL/y6fnDRaIuWhni3n3jQVhgFySKvHaFRSZtjv+OrLbaUx4WWM2hdrc2w
         +QSPj1lhuM3TG90g0pMxaaMS6/K8x67Ni8MNeDxd88nAELeX4nxHKO45mPO7jxn+6sMV
         K3RyBA4fe+iC9wseXAe3JdFD+3Rmc45zpfbsE13H4G3p2yMUTGPAOqpF081Y0brPiRiD
         wYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702565135; x=1703169935;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tF4v5FAsSpR40LsU66vSHRRQwz/YE34tpX6gezwc28s=;
        b=nMp3J+z0m0OTOykp6+0Xa0AS1aCgro7wWkiFga6J4qYn+Psv0rVXU1HKzqKpx6/DUX
         O0pdBbtlEIQFLZ2FWZG/r6yfnVOM+djkmVe7k0Uq4RNjtrAMwYQ3/Ha+J6+zxcFgTS69
         braIOj9/QnOjqbpSipjiKgwagP5Ivg7p7pq4Io4LHh3lEds8xBjWO3/lIrB6g2ZA6pew
         Y/hJPdcSU0ZBDAKTIFrlGGvt8xyXnZLkVJ5fOY8GJja1FIx03jr5SOD749pt09NZ/UYF
         /VGCZtcqanit6GbtCMMHIy/7HuS44iqa3zN728hph+JCYAEEsfOR30oYx8Gpt7QEbISZ
         O+5A==
X-Gm-Message-State: AOJu0YxlNeUDYwa/8avJsGCaWYfdEhjNQlOI4/IQJ8Vv7Z4j3r97bJSN
        +2JP/qvhLQ6dh55yrBD7pdFchQ==
X-Google-Smtp-Source: AGHT+IHPGLznweQvZPO6iY6H8z31jF5pOMSZk397XcfhsTzBtXxNOM0a4urSaMagtu5X/U43ymPhLQ==
X-Received: by 2002:a05:6a00:27a1:b0:6ce:6f97:3715 with SMTP id bd33-20020a056a0027a100b006ce6f973715mr10959891pfb.64.1702565135434;
        Thu, 14 Dec 2023 06:45:35 -0800 (PST)
Received: from ?IPV6:2409:8a28:e64:34f0:4525:57e4:217e:6e2c? ([2409:8a28:e64:34f0:4525:57e4:217e:6e2c])
        by smtp.gmail.com with ESMTPSA id p25-20020a056a0026d900b006ce3b01cba2sm11022404pfw.108.2023.12.14.06.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 06:45:35 -0800 (PST)
Message-ID: <f04a9857-e3e3-4bf4-853b-b78c06a1990d@bytedance.com>
Date:   Thu, 14 Dec 2023 22:45:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] mm/zswap: refactor out __zswap_load()
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nhat Pham <nphamcs@gmail.com>, Chris Li <chriscli@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com>
 <20231213-zswap-dstmem-v1-3-896763369d04@bytedance.com>
 <CAJD7tkbPPy6Xqy7Xtei24B7CzxdaGwYN7tdbLH_UMVmYkYYJ=g@mail.gmail.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAJD7tkbPPy6Xqy7Xtei24B7CzxdaGwYN7tdbLH_UMVmYkYYJ=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/12/14 08:52, Yosry Ahmed wrote:
> On Tue, Dec 12, 2023 at 8:18 PM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> The zswap_load() and zswap_writeback_entry() have the same part that
>> decompress the data from zswap_entry to page, so refactor out the
>> common part as __zswap_load(entry, page).
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> 
> On a second look, there a few nits here.
> 
> First I think it makes more sense to move this refactoring ahead of
> reusing destmem. Right now, we add the destmem reuse to zswap_load()
> only, then we do the refactor and zswap_writeback_entry() gets it
> automatically, so there is a slight change coming to
> zswap_writeback_entry() hidden in the refactoring patch.
> 
> Let's refactor out __zswap_load() first, then reuse destmem in it.
> 

Ok, will put it first.

>> ---
>>  mm/zswap.c | 107 ++++++++++++++++++++++---------------------------------------
>>  1 file changed, 38 insertions(+), 69 deletions(-)
>>
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index fa186945010d..2f095c919a5c 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -1392,6 +1392,41 @@ static int zswap_enabled_param_set(const char *val,
>>         return ret;
>>  }
>>
>> +static void __zswap_load(struct zswap_entry *entry, struct page *page)
>> +{
>> +       struct scatterlist input, output;
>> +       unsigned int dlen = PAGE_SIZE;
>> +       struct crypto_acomp_ctx *acomp_ctx;
>> +       struct zpool *zpool;
>> +       u8 *src;
>> +       int ret;
>> +
>> +       acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
>> +       mutex_lock(acomp_ctx->mutex);
>> +
>> +       zpool = zswap_find_zpool(entry);
>> +       src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
>> +       if (!zpool_can_sleep_mapped(zpool)) {
>> +               memcpy(acomp_ctx->dstmem, src, entry->length);
>> +               src = acomp_ctx->dstmem;
>> +               zpool_unmap_handle(zpool, entry->handle);
>> +       }
>> +
>> +       sg_init_one(&input, src, entry->length);
>> +       sg_init_table(&output, 1);
>> +       sg_set_page(&output, page, PAGE_SIZE, 0);
>> +       acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, dlen);
> 
> We should pass PAGE_SIZE here directly, BUG_ON(acomp_ctx->req->dlen)
> below, and remove the dlen variable.
> 
>> +       ret = crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait);
> 
> We should just BUG_ON() here directly an remove the ret variable.

Ok, thanks!
