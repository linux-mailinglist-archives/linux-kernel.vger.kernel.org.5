Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D67781319D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573323AbjLNN35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573296AbjLNN3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:29:55 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E744114
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:29:40 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cea5548eb2so7443026b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1702560580; x=1703165380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6x52DBZpfua9cxAmENqISqp3cMd8G5vLCGCNrNchwyg=;
        b=baCATLixr70Tom9GPKY8UzJ7kPgXKf6Qfnuy+uz9ILNsKKx63iDlvqJQxHo112MWsa
         mbzwYobqNZzVJPQwU9qD1yfhUUeezNe4cvWRN9ti9WjCeeLCK5zcCy32Y1+uyDiLYVCM
         EE3Fu13DI4d2Y2TDfDkgljeryUNWoCwOd6AhZjEsH/JWiIPgwO+ZVsjiOyM8/txoHaqZ
         EKUwygkFGXBavFgPKXTw8Cb00eUZDnYr5fIOXpHXa2V34gz4l2xYsErFDZw6LHLez61/
         7IbVQRzdXdYQERi7d1B9pfFN3KQGlcGR088nw1GnoIJ27HsOQj2jYAeWlBKYxZCk8eZG
         O4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702560580; x=1703165380;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6x52DBZpfua9cxAmENqISqp3cMd8G5vLCGCNrNchwyg=;
        b=F73qjyh/dRYz9rdhHDmXsuJSbGiYT0fpJ6hl9XDxJtdYpb280hG0QVGcVH3m5yH8Mo
         PvzlKYM7HyR998vPboNvkkNH9OugC49n4Lzgqt+pgwH+mtEeaPESI73IEpIqwSuqK3NF
         L9GSk8c4sLXrrm7obz1DschGiyyzXm02JGwaAr9eJhx0weC23sDkwo5cMmO88ov6DdfE
         fIYZPYApmvfSpk9abaEl8PM2tycUXF9o6r0Stf9ttZxWN0URktwu4CNHIFBStD6fVDJe
         aRQITJPjGVblNcyVbjLmnE9YLo05u4anRRSCMLE80CGSvSgWdZmiZZcbYofOcRPA9w01
         fOjA==
X-Gm-Message-State: AOJu0YwEjkvWBe7OU9EOZjNJycZzb+KUsTe9TeeZ2WgBfZDu8VE0iTns
        Z05d+yE11BZgPf7GxdsJGALL7g==
X-Google-Smtp-Source: AGHT+IFR+jXAVVpINTFZCnPAKlqaUXI3xF8Yt0Os1F7FhAaO8Z078X/Nlb3YDFposQNF/Dg47kqkOQ==
X-Received: by 2002:a05:6a00:b53:b0:6ce:6c54:24a7 with SMTP id p19-20020a056a000b5300b006ce6c5424a7mr11444443pfo.1.1702560579661;
        Thu, 14 Dec 2023 05:29:39 -0800 (PST)
Received: from ?IPV6:2409:8a28:e64:34f0:4525:57e4:217e:6e2c? ([2409:8a28:e64:34f0:4525:57e4:217e:6e2c])
        by smtp.gmail.com with ESMTPSA id y33-20020a056a00182100b006cc02a6d18asm11820379pfa.61.2023.12.14.05.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 05:29:39 -0800 (PST)
Message-ID: <8f80fe3e-a8c7-463d-896b-99575c362839@bytedance.com>
Date:   Thu, 14 Dec 2023 21:29:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] mm/zswap: reuse dstmem when decompress
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nhat Pham <nphamcs@gmail.com>, Chris Li <chriscli@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com>
 <20231213-zswap-dstmem-v1-1-896763369d04@bytedance.com>
 <CAJD7tkbicqevYuJbTUZBQUo2n_k-HKTixG5TbXGtdbtFJgFmfg@mail.gmail.com>
Content-Language: en-US
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAJD7tkbicqevYuJbTUZBQUo2n_k-HKTixG5TbXGtdbtFJgFmfg@mail.gmail.com>
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

On 2023/12/14 07:24, Yosry Ahmed wrote:
> On Tue, Dec 12, 2023 at 8:18 PM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> In the !zpool_can_sleep_mapped() case such as zsmalloc, we need to first
>> copy the entry->handle memory to a temporary memory, which is allocated
>> using kmalloc.
>>
>> Obviously we can reuse the per-compressor dstmem to avoid allocating
>> every time, since it's percpu-compressor and protected in mutex.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
>> ---
>>  mm/zswap.c | 29 +++++++++--------------------
>>  1 file changed, 9 insertions(+), 20 deletions(-)
>>
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index 7ee54a3d8281..edb8b45ed5a1 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -1772,9 +1772,9 @@ bool zswap_load(struct folio *folio)
>>         struct zswap_entry *entry;
>>         struct scatterlist input, output;
>>         struct crypto_acomp_ctx *acomp_ctx;
>> -       u8 *src, *dst, *tmp;
>> +       unsigned int dlen = PAGE_SIZE;
>> +       u8 *src, *dst;
>>         struct zpool *zpool;
>> -       unsigned int dlen;
>>         bool ret;
>>
>>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
>> @@ -1796,27 +1796,18 @@ bool zswap_load(struct folio *folio)
>>                 goto stats;
>>         }
>>
>> -       zpool = zswap_find_zpool(entry);
>> -       if (!zpool_can_sleep_mapped(zpool)) {
>> -               tmp = kmalloc(entry->length, GFP_KERNEL);
>> -               if (!tmp) {
>> -                       ret = false;
>> -                       goto freeentry;
>> -               }
>> -       }
>> -
>>         /* decompress */
>> -       dlen = PAGE_SIZE;
>> -       src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
>> +       acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
>> +       mutex_lock(acomp_ctx->mutex);
>>
>> +       zpool = zswap_find_zpool(entry);
>> +       src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
>>         if (!zpool_can_sleep_mapped(zpool)) {
>> -               memcpy(tmp, src, entry->length);
>> -               src = tmp;
>> +               memcpy(acomp_ctx->dstmem, src, entry->length);
>> +               src = acomp_ctx->dstmem;
> 
> I don't like that we are now using acomp_ctx->dstmem and
> acomp_ctx->mutex now for purposes other than what the naming suggests.

The "mutex" name is coherent, "dstmem" depends on how we use IMHO.
Change to just "mem"? Or do you have a better name to replace?

> 
> How about removing these two fields from acomp_ctx, and directly using
> zswap_dstmem and zswap_mutex in both the load and store paths, rename
> them, and add proper comments above their definitions that they are
> for generic percpu buffering on the load and store paths?

Yes, they are percpu memory and lock, but they are used by per acomp_ctx,
and the cpu maybe changing in the middle, so maybe better to keep them.

Thanks!
