Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D1D807F15
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 04:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjLGDO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 22:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLGDO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 22:14:26 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32EBE9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 19:14:04 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1d0c93b1173so3233025ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 19:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701918844; x=1702523644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4jWLmrpybeqwQXulQHn+kV9Rl8J+HEDg7gz9uCXQvKY=;
        b=QYN2/j++mV0PrksiQQwRS+Y3sRNf8uhcqrVsGmPpVjwt5yM0LHZYURA+WM8bGVU2hq
         pss1V6/I2r+9hQb7hmZ7fHbB0ic9XdFUoZoQh6mnxkezeN3BeXNogMoA1Xdzb9tjm7kT
         OswZJk1avtRylF7rnw1tM86/ZmHaENpTCTOiHy+/evkRMazUqCeTEksIONWeSwV3j+pZ
         zw+kLIewGid14uueRApFlmrwt5knVb7uqMeRB6RaUGD+pG8LF3ya88ypL8QWaICVGErR
         266zDAxQ/VoKhNXNWRD9pESd/6OOIX2+3p8sVSAP1gK8Xu9fKun4g9WU4+7tr+16933q
         1i7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701918844; x=1702523644;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4jWLmrpybeqwQXulQHn+kV9Rl8J+HEDg7gz9uCXQvKY=;
        b=EJMevDfQkftJ76M1VtZoQVkZNIebDDrAb6yq9ZbrOHhu1HhKn2axaKRFI3M7W6YwCo
         8bM55rmJtDqaddrKs5jjI8Jp5soikLSvGS7+Z8xJt3hff4dhWkvghQTuupKpoeuUTOjz
         udCx6fNjz9qaJmSzH/VOI9OGdR9DjRtEyymO2IsAiM+HD+sPQiu1VFOC2FXh1SdEU8CX
         7pB2vGEG3AOgLkp/4fdeQF0AlDDMOmnNVQwLbGGvFxR/YZnSeJ1UeLv/ym7r0QTv1yS/
         11izC6s4V+DwYX+528oBUaFy1fVMFf8JlYvaWZqtHV164NhnmpItiDcDIsKMbxZIlxnc
         M4qQ==
X-Gm-Message-State: AOJu0YzKToTuiZrH21CdQCpdXo6a1nUaFh17yrALFJRISDn336ITg+Yh
        9s/bYolYYr02rQMiPDJ42AliEA==
X-Google-Smtp-Source: AGHT+IHS5yThiFMoIMpIc7By/2dy/CVXAV9XmkehJ+2WWLLkCLXi1/AK/aUDpVr+tPeM9c79GAe4cQ==
X-Received: by 2002:a17:903:2791:b0:1d0:6ffd:f21a with SMTP id jw17-20020a170903279100b001d06ffdf21amr1645819plb.112.1701918844238;
        Wed, 06 Dec 2023 19:14:04 -0800 (PST)
Received: from [10.255.200.168] ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id d14-20020a170903230e00b001cfc4d8ede5sm177346plh.301.2023.12.06.19.14.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 19:14:03 -0800 (PST)
Message-ID: <ee7631a5-b167-43d9-af19-a5a12dcac03a@bytedance.com>
Date:   Thu, 7 Dec 2023 11:13:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] mm/zswap: optimize the scalability of zswap rb-tree
Content-Language: en-US
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231206-zswap-lock-optimize-v1-0-e25b059f9c3a@bytedance.com>
 <CAKEwX=OqMK881u3kPB99KX_9UWreddz-cUT5ArzdwpHwQjQ6yA@mail.gmail.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAKEwX=OqMK881u3kPB99KX_9UWreddz-cUT5ArzdwpHwQjQ6yA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/12/7 04:08, Nhat Pham wrote:
> On Wed, Dec 6, 2023 at 1:46 AM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>> When testing the zswap performance by using kernel build -j32 in a tmpfs
>> directory, I found the scalability of zswap rb-tree is not good, which
>> is protected by the only spinlock. That would cause heavy lock contention
>> if multiple tasks zswap_store/load concurrently.
>>
>> So a simple solution is to split the only one zswap rb-tree into multiple
>> rb-trees, each corresponds to SWAP_ADDRESS_SPACE_PAGES (64M). This idea is
>> from the commit 4b3ef9daa4fc ("mm/swap: split swap cache into 64MB trunks").
>>
>> Although this method can't solve the spinlock contention completely, it
>> can mitigate much of that contention.
> 
> By how much? Do you have any stats to estimate the amount of
> contention and the reduction by this patch?

Actually, I did some test using the linux-next 20231205 yesterday.

Testcase: memory.max = 2G, zswap enabled, make -j32 in tmpfs.

			20231205	+patchset
1. !shrinker_enabled:   156s		126s
2.  shrinker_enabled:   79s		70s

I think your zswap shrinker fix patch can solve !shrinker_enabled case.

So will test again today using the new mm-unstable branch.

> 
> I do think lock contention could be a problem here, and it will be
> even worse with the zswap shrinker enabled (which introduces an
> theoretically unbounded number of concurrent reclaimers hammering on
> the zswap rbtree and its lock). I am generally a bit weary about
> architectural change though, especially if it is just a bandaid. We
> have tried to reduce the lock contention somewhere else (multiple
> zpools), and as predicted it just shifts the contention point
> elsewhere. Maybe we need a deeper architectural re-think.
> 
> Not an outright NACK of course - just food for thought.
> 

Right, I think xarray is good for lockless reading side, and
multiple trees is also complementary, which can reduce the lock
contention on the writing sides too.

>>
>> Another problem when testing the zswap using our default zsmalloc is that
>> zswap_load() and zswap_writeback_entry() have to malloc a temporary memory
>> to support !zpool_can_sleep_mapped().
>>
>> Optimize it by reusing the percpu crypto_acomp_ctx->dstmem, which is also
>> used by zswap_store() and protected by the same percpu crypto_acomp_ctx->mutex.
> 
> It'd be nice to reduce the (temporary) memory allocation on these
> paths, but would this introduce contention on the per-cpu dstmem and
> the mutex that protects it, if there are too many concurrent
> store/load/writeback requests?

I think the mutex holding time is not changed, right? So the contention
on the per-cpu mutex should be the same. We just reuse percpu dstmem more.

Thanks!
