Return-Path: <linux-kernel+bounces-6887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E87819EE7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364FA1C22413
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C0D22321;
	Wed, 20 Dec 2023 12:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="i+cYkk9R"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548A022308
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 12:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-35d3846fac9so23479545ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 04:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1703074856; x=1703679656; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lo278K0WzeNhO2XB8OTPVe4wM6zLDvQlgKwUUEsFo2Y=;
        b=i+cYkk9RYSKNnU68wWCSrX0YH2B38cvNnGYHPA7BXk9ajOhQyqKin9pJ/7rYWTKxLo
         oRLUxPhrPuPZ4ksKhXN6OmqhLxU7ulqFItHy0cDXBNvu2VjJ9fKb6Em/yA7CQzj7BLY7
         b9RXewJ1v/RPt7A+f1XiCv/LuHQRoWGykF5TPjLPAIkaS56ElFi/LA1kEoApPvFJuGj7
         iGzOkgDvHSR3Ujrob1CUn6r916kRIKAnVDaYxt7IOxvuhh8eYJj+qCPeuG/UMz15SZNM
         ljvSs/YmcRBGGAhFAZplnbKeLb8klBNvoUGFJMH1wI2X9ltWtLRTvNDUPt8IXPM2czaU
         pRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703074856; x=1703679656;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lo278K0WzeNhO2XB8OTPVe4wM6zLDvQlgKwUUEsFo2Y=;
        b=FFmGp40xNkcuMixnejfvryCScgW012eSfNuAep49ZbN1Z/F5viAN0cWADOr3td63HQ
         Y0HfdIzNxr88dWU3sua2env5VAN40rO96pYHtWWB/9guMuOyJuTKE1KGF7yGrxS9+CnN
         HeJ98mSv4+NKu9f1p6t+p1OJGgL578sqmbMucD8iejqVr6ZewN7dxBe0n/2QJ+9J8zK6
         hIG53xf1Q6/8C4UgSc6z7ZqHvBUNAlQXK308JEpw00ct9pU/Dnny4u7XHIieS5PZUPbL
         gvbb90d9TuDZqyjwXUf9ZL+lvc0bm5gO9bMw1TO3qPsJlPCVWaCQNIpon3Ys6f0/qDDf
         oKJA==
X-Gm-Message-State: AOJu0Yzk2EYUEk5mXELg3++0dRygYtkxeczRF5wromiPNc7XsQnrJIw2
	gDdD4Ft0pvRuoGwWU1lQ2dKGgw==
X-Google-Smtp-Source: AGHT+IGnMvR7ylp1fX7m/paxr1IRwjme5dY/6Uc2RJGRTjvEJLxMjNqHZQav8XEQW3PCKiPsKVCTOw==
X-Received: by 2002:a05:6e02:1c87:b0:35f:bba4:d4ce with SMTP id w7-20020a056e021c8700b0035fbba4d4cemr4603927ill.14.1703074856197;
        Wed, 20 Dec 2023 04:20:56 -0800 (PST)
Received: from [10.254.235.157] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id be9-20020a170902aa0900b001d07d83fdd0sm22807188plb.238.2023.12.20.04.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 04:20:55 -0800 (PST)
Message-ID: <2a22e9b5-dc8c-4c4d-81c2-2f4e1850cf3d@bytedance.com>
Date: Wed, 20 Dec 2023 20:20:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] mm/zswap: directly use percpu mutex and buffer in
 load/store
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
 Chris Li <chrisl@kernel.org>
Cc: Seth Jennings <sjenning@redhat.com>,
 Vitaly Wool <vitaly.wool@konsulko.com>, Dan Streetman <ddstreet@ieee.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20231213-zswap-dstmem-v3-0-4eac09b94ece@bytedance.com>
 <20231213-zswap-dstmem-v3-6-4eac09b94ece@bytedance.com>
 <CAF8kJuOv+k0TcKJhs8wEWi20=B84bomj5BvpUAHvj6k3A+WE5A@mail.gmail.com>
 <CAKEwX=P=frZmEXm26uTBN05gqLXoL-Shgk5P=EsMpYR16dW-sw@mail.gmail.com>
 <CAJD7tkb2gWz1uQ7C6NQ7mAB=QQgaKHSwDFr0XS9ZrGFPOP1tTQ@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAJD7tkb2gWz1uQ7C6NQ7mAB=QQgaKHSwDFr0XS9ZrGFPOP1tTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2023/12/20 05:39, Yosry Ahmed wrote:
> On Tue, Dec 19, 2023 at 10:43 AM Nhat Pham <nphamcs@gmail.com> wrote:
>>
>> On Tue, Dec 19, 2023 at 5:29 AM Chris Li <chrisl@kernel.org> wrote:
>>>
>>> Hi Chengming and Yosry,
>>>
>>> On Mon, Dec 18, 2023 at 3:50 AM Chengming Zhou
>>> <zhouchengming@bytedance.com> wrote:
>>>>
>>>> Since the introduce of reusing the dstmem in the load path, it seems
>>>> confusing that we are now using acomp_ctx->dstmem and acomp_ctx->mutex
>>>> now for purposes other than what the naming suggests.
>>>>
>>>> Yosry suggested removing these two fields from acomp_ctx, and directly
>>>> using zswap_dstmem and zswap_mutex in both the load and store paths,
>>>> rename them, and add proper comments above their definitions that they
>>>> are for generic percpu buffering on the load and store paths.
>>>>
>>>> So this patch remove dstmem and mutex from acomp_ctx, and rename the
>>>> zswap_dstmem to zswap_buffer, using the percpu mutex and buffer on
>>>> the load and store paths.
>>>
>>> Sorry joining this discussion late.
>>>
>>> I get the rename of "dstmem" to "buffer". Because the buffer is used
>>> for both load and store as well. What I don't get is that, why do we
>>> move it out of the acomp_ctx struct. Now we have 3 per cpu entry:
>>> buffer, mutex and acomp_ctx. I think we should do the reverse, fold
>>> this three per cpu entry into one struct the acomp_ctx. Each per_cpu
>>> load() has a sequence of dance around the cpu id and disable preempt
>>> etc, while each of the struct member load is just a plan memory load.
>>> It seems to me it would be more optimal to combine this three per cpu
>>> entry into acomp_ctx. Just do the per cpu for the acomp_ctx once.
>>
>> I agree with Chris. From a practicality POV, what Chris says here
>> makes sense. From a semantic POV, this buffer is only used in
>> (de)compression contexts - be it in store, load, or writeback - so it
>> belonging to the orignal struct still makes sense to me. Why separate
>> it out, without any benefits. Just rename the old field buffer or
>> zswap_buffer and call it a day? It will be a smaller patch too!
>>
> 
> My main concern is that the struct name is specific for the crypto
> acomp stuff, but that buffer and mutex are not.
> How about we keep it in the struct, but refactor the struct as follows:
> 
> struct zswap_ctx {
>     struct {
>         struct crypto_acomp *acomp;
>         struct acomp_req *req;
>         struct crypto_wait wait;
>     }  acomp_ctx;
>     u8 *dstmem;
>     struct mutex *mutex;
> };
> 
> , and then rename zswap_pool.acomp_ctx to zswap_pool.ctx?

I think there are two viewpoints here, both works ok to me.

The first is from ownship or lifetime, these percpu mutex and dstmem
are shared between all pools, so no one pool own the mutex and dstmem,
nor does the percpu acomp_ctx in each pool.

The second is from usage, these percpu mutex and dstmem are used by
the percpu acomp_ctx in each pool, so it's easy to use to put pointers
to them in the percpu acomp_ctx.

Actually I think it's simpler to let the percpu acomp_ctx has its own
mutex and dstmem, which in fact are the necessary parts when it use
the acomp interfaces.

This way, we could delete the percpu mutex and dstmem, and its hotplugs,
and not shared anymore between all pools. Maybe we would have many pools
at the same time in the future, like different compression algorithm or
different zpool for different memcg workloads. Who knows? :-)

So how about this patch below? Just RFC.

Subject: [PATCH] mm/zswap: make each acomp_ctx has its own mutex and dstmem

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 include/linux/cpuhotplug.h |  1 -
 mm/zswap.c                 | 86 ++++++++++++--------------------------
 2 files changed, 26 insertions(+), 61 deletions(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index efc0c0b07efb..c3e06e21766a 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -124,7 +124,6 @@ enum cpuhp_state {
 	CPUHP_ARM_BL_PREPARE,
 	CPUHP_TRACE_RB_PREPARE,
 	CPUHP_MM_ZS_PREPARE,
-	CPUHP_MM_ZSWP_MEM_PREPARE,
 	CPUHP_MM_ZSWP_POOL_PREPARE,
 	CPUHP_KVM_PPC_BOOK3S_PREPARE,
 	CPUHP_ZCOMP_PREPARE,
diff --git a/mm/zswap.c b/mm/zswap.c
index 2c349fd88904..37301f1a80a9 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -694,63 +694,31 @@ static void zswap_alloc_shrinker(struct zswap_pool *pool)
 /*********************************
 * per-cpu code
 **********************************/
-static DEFINE_PER_CPU(u8 *, zswap_dstmem);
-/*
- * If users dynamically change the zpool type and compressor at runtime, i.e.
- * zswap is running, zswap can have more than one zpool on one cpu, but they
- * are sharing dtsmem. So we need this mutex to be per-cpu.
- */
-static DEFINE_PER_CPU(struct mutex *, zswap_mutex);
-
-static int zswap_dstmem_prepare(unsigned int cpu)
-{
-	struct mutex *mutex;
-	u8 *dst;
-
-	dst = kmalloc_node(PAGE_SIZE, GFP_KERNEL, cpu_to_node(cpu));
-	if (!dst)
-		return -ENOMEM;
-
-	mutex = kmalloc_node(sizeof(*mutex), GFP_KERNEL, cpu_to_node(cpu));
-	if (!mutex) {
-		kfree(dst);
-		return -ENOMEM;
-	}
-
-	mutex_init(mutex);
-	per_cpu(zswap_dstmem, cpu) = dst;
-	per_cpu(zswap_mutex, cpu) = mutex;
-	return 0;
-}
-
-static int zswap_dstmem_dead(unsigned int cpu)
-{
-	struct mutex *mutex;
-	u8 *dst;
-
-	mutex = per_cpu(zswap_mutex, cpu);
-	kfree(mutex);
-	per_cpu(zswap_mutex, cpu) = NULL;
-
-	dst = per_cpu(zswap_dstmem, cpu);
-	kfree(dst);
-	per_cpu(zswap_dstmem, cpu) = NULL;
-
-	return 0;
-}
-
 static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 {
 	struct zswap_pool *pool = hlist_entry(node, struct zswap_pool, node);
 	struct crypto_acomp_ctx *acomp_ctx = per_cpu_ptr(pool->acomp_ctx, cpu);
 	struct crypto_acomp *acomp;
 	struct acomp_req *req;
+	int ret = 0;
+
+	acomp_ctx->dstmem = kmalloc_node(PAGE_SIZE, GFP_KERNEL, cpu_to_node(cpu));
+	if (!acomp_ctx->dstmem)
+		return -ENOMEM;
+
+	acomp_ctx->mutex = kmalloc_node(sizeof(struct mutex), GFP_KERNEL, cpu_to_node(cpu));
+	if (!acomp_ctx->mutex) {
+		ret = -ENOMEM;
+		goto mutex_fail;
+	}
+	mutex_init(acomp_ctx->mutex);

 	acomp = crypto_alloc_acomp_node(pool->tfm_name, 0, 0, cpu_to_node(cpu));
 	if (IS_ERR(acomp)) {
 		pr_err("could not alloc crypto acomp %s : %ld\n",
 				pool->tfm_name, PTR_ERR(acomp));
-		return PTR_ERR(acomp);
+		ret = PTR_ERR(acomp);
+		goto acomp_fail;
 	}
 	acomp_ctx->acomp = acomp;

@@ -758,8 +726,8 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 	if (!req) {
 		pr_err("could not alloc crypto acomp_request %s\n",
 		       pool->tfm_name);
-		crypto_free_acomp(acomp_ctx->acomp);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto req_fail;
 	}
 	acomp_ctx->req = req;

@@ -772,10 +740,15 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 	acomp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
 				   crypto_req_done, &acomp_ctx->wait);

-	acomp_ctx->mutex = per_cpu(zswap_mutex, cpu);
-	acomp_ctx->dstmem = per_cpu(zswap_dstmem, cpu);
-
 	return 0;
+req_fail:
+	crypto_free_acomp(acomp_ctx->acomp);
+acomp_fail:
+	kfree(acomp_ctx->mutex);
+mutex_fail:
+	kfree(acomp_ctx->dstmem);
+
+	return ret;
 }

 static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node *node)
@@ -788,6 +761,8 @@ static int zswap_cpu_comp_dead(unsigned int cpu, struct hlist_node *node)
 			acomp_request_free(acomp_ctx->req);
 		if (!IS_ERR_OR_NULL(acomp_ctx->acomp))
 			crypto_free_acomp(acomp_ctx->acomp);
+		kfree(acomp_ctx->mutex);
+		kfree(acomp_ctx->dstmem);
 	}

 	return 0;
@@ -1901,13 +1876,6 @@ static int zswap_setup(void)
 		goto cache_fail;
 	}

-	ret = cpuhp_setup_state(CPUHP_MM_ZSWP_MEM_PREPARE, "mm/zswap:prepare",
-				zswap_dstmem_prepare, zswap_dstmem_dead);
-	if (ret) {
-		pr_err("dstmem alloc failed\n");
-		goto dstmem_fail;
-	}
-
 	ret = cpuhp_setup_state_multi(CPUHP_MM_ZSWP_POOL_PREPARE,
 				      "mm/zswap_pool:prepare",
 				      zswap_cpu_comp_prepare,
@@ -1939,8 +1907,6 @@ static int zswap_setup(void)
 	if (pool)
 		zswap_pool_destroy(pool);
 hp_fail:
-	cpuhp_remove_state(CPUHP_MM_ZSWP_MEM_PREPARE);
-dstmem_fail:
 	kmem_cache_destroy(zswap_entry_cache);
 cache_fail:
 	/* if built-in, we aren't unloaded on failure; don't allow use */
--
2.20.1


