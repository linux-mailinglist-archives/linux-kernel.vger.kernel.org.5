Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A7B7C81F7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjJMJ0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjJMJ0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:26:09 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D4CBD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 02:25:41 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-690fe10b6a4so1507359b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 02:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697189141; x=1697793941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7uL2c2uoz0g+eUkstAn7ZYAuxLyOWANac5NGFBMDPk=;
        b=BfCFWcWGjSfEPHbWItI400U2g6Rd96K/O1ZW3JQf+NchJlVF9ZvhvU2LCaoltPNcVG
         7nmHZVFYx4rG+YfwyN2UasYki3SlX3WRPNv0d1EhDQKewMd/qd6GZVH3TQz8LWTzZdRx
         bs0A8XqHsz4o/7QyohiY4Zg7SYD1g/YA5WpgbGLO9faVO3o3+ynq1QB/vnYQylQnjhbj
         qI2mdYqcD+AoWRCCEAu97WkP74BoZNvv4BADaKXNwBH0iV9mxxI3nQ35KKhPsYPBp24H
         /J0pzN7nzpX+sB1TTBpE/0PJugyytnnYjduWyn1CLrT8m6ZRdWkdK0Pb967kbgSmaF+k
         M7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697189141; x=1697793941;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k7uL2c2uoz0g+eUkstAn7ZYAuxLyOWANac5NGFBMDPk=;
        b=Hs0a5+4+mPI796mYhZmVBdabAfUHMf8p/NNqTnsH6iYANZNh46bOwCQK2w5ZkEE610
         Q0VoI8+6fK0FQz5VsnXz/0yLJ3Vz51TVXLkiq5Ff2ZMTtVtvGiPefAPF4TReGJn+npxd
         QtHDvAAgKwyz5Sui3AifrFPh71hx9VMfIv0qm8ITpmQtJ6imdN6Pg22mnbNplbXIYj5/
         U9vi/0T04GfxFc2/LMqhsi6MJT1V5rKLkRxIYLjvytkAtqaDJqer8O66S123lYLs6tA+
         1y8BAGwh/TDPm+pCRT7S/dow43eAiI05E+6CwBsZW8J49gqNra+fpa78XnRzMA45paNR
         4xdg==
X-Gm-Message-State: AOJu0YzWnhSxMa0bHJS84BTM4tI3XZzSWfRLoQ6Iu3NKYK69Px5N0txf
        w8jiLmd6E5kDtkDGJ8mR+VTKfw==
X-Google-Smtp-Source: AGHT+IE0Oxi3r8fhZW+Omg6ORgRTy3zZPPKu5LOsxWJuCa3kuUQ1q9Z+xb3kBJiPOkzmvo6jl0zz1w==
X-Received: by 2002:a05:6a20:d42a:b0:15c:cb69:8e64 with SMTP id il42-20020a056a20d42a00b0015ccb698e64mr23035135pzb.25.1697189141085;
        Fri, 13 Oct 2023 02:25:41 -0700 (PDT)
Received: from [10.84.144.104] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902cf4600b001c726147a46sm3406804plg.234.2023.10.13.02.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 02:25:40 -0700 (PDT)
Message-ID: <e3aed8bd-75e4-4f8e-9e71-d2ade5f5d762@bytedance.com>
Date:   Fri, 13 Oct 2023 17:25:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] maple_tree: Add GFP_KERNEL to allocations in
 mas_expected_entries()
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        jason.sim@samsung.com, Peng Zhang <zhangpeng.00@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20231012155233.2272446-1-Liam.Howlett@oracle.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20231012155233.2272446-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/10/12 23:52, Liam R. Howlett 写道:
> Users complained about OOM errors during fork without triggering
> compaction.  This can be fixed by modifying the flags used in
> mas_expected_entries() so that the compaction will be triggered in low
> memory situations.  Since mas_expected_entries() is only used during
> fork, the extra argument does not need to be passed through.
> 
> Additionally, the two test_maple_tree test cases and one benchmark test
> were altered to use the correct locking type so that allocations would
> not trigger sleeping and thus fail.  Testing was completed with lockdep
> atomic sleep detection.
> 
> The additional locking change requires rwsem support additions to the
> tools/ directory through the use of pthreads pthread_rwlock_t.  With
> this change test_maple_tree works in userspace, as a module, and
> in-kernel.
> 
> Users may notice that the system gave up early on attempting to start
> new processes instead of attempting to reclaim memory.
> 
> Link: https://lkml.kernel.org/r/20230915093243epcms1p46fa00bbac1ab7b7dca94acb66c44c456@epcms1p4
> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> Cc: <stable@vger.kernel.org>
> Cc: jason.sim@samsung.com
> Cc: Peng Zhang <zhangpeng.00@bytedance.com>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
> 
> v1: https://lore.kernel.org/linux-mm/20231010141737.1592866-1-Liam.Howlett@oracle.com/
> 
> Changes in v2:
>   - Updated benchmarking to use the rw_semaphore lock (not strictly necessary)
>   - Updated check_forking() to use the rw_semaphore lock.
>   - Testing now completed with lockdep atomic sleep checking.
> 
>   lib/maple_tree.c            |  2 +-
>   lib/test_maple_tree.c       | 35 ++++++++++++++++++++++----------
>   tools/include/linux/rwsem.h | 40 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 65 insertions(+), 12 deletions(-)
>   create mode 100644 tools/include/linux/rwsem.h
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 0e00a84e8e8f..bb24d84a4922 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5627,7 +5627,7 @@ int mas_expected_entries(struct ma_state *mas, unsigned long nr_entries)
>   	/* Internal nodes */
>   	nr_nodes += DIV_ROUND_UP(nr_nodes, nonleaf_cap);
>   	/* Add working room for split (2 nodes) + new parents */
> -	mas_node_count(mas, nr_nodes + 3);
> +	mas_node_count_gfp(mas, nr_nodes + 3, GFP_KERNEL);
>   
>   	/* Detect if allocations run out */
>   	mas->mas_flags |= MA_STATE_PREALLOC;
> diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
> index 06959165e2f9..464eeb90d5ad 100644
> --- a/lib/test_maple_tree.c
> +++ b/lib/test_maple_tree.c
> @@ -9,6 +9,7 @@
>   
>   #include <linux/maple_tree.h>
>   #include <linux/module.h>
> +#include <linux/rwsem.h>
>   
>   #define MTREE_ALLOC_MAX 0x2000000000000Ul
>   #define CONFIG_MAPLE_SEARCH
> @@ -1841,17 +1842,21 @@ static noinline void __init check_forking(struct maple_tree *mt)
>   	void *val;
>   	MA_STATE(mas, mt, 0, 0);
>   	MA_STATE(newmas, mt, 0, 0);
> +	struct rw_semaphore newmt_lock;
> +
> +	init_rwsem(&newmt_lock);
>   
>   	for (i = 0; i <= nr_entries; i++)
>   		mtree_store_range(mt, i*10, i*10 + 5,
>   				  xa_mk_value(i), GFP_KERNEL);
>   
>   	mt_set_non_kernel(99999);
> -	mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE);
> +	mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN);
> +	mt_set_external_lock(&newmt, &newmt_lock);
>   	newmas.tree = &newmt;
>   	mas_reset(&newmas);
>   	mas_reset(&mas);
> -	mas_lock(&newmas);
> +	down_write(&newmt_lock);
>   	mas.index = 0;
>   	mas.last = 0;
>   	if (mas_expected_entries(&newmas, nr_entries)) {
> @@ -1866,10 +1871,10 @@ static noinline void __init check_forking(struct maple_tree *mt)
>   	}
>   	rcu_read_unlock();
>   	mas_destroy(&newmas);
> -	mas_unlock(&newmas);
>   	mt_validate(&newmt);
>   	mt_set_non_kernel(0);
> -	mtree_destroy(&newmt);
> +	__mt_destroy(&newmt);
> +	up_write(&newmt_lock);
>   }
>   
>   static noinline void __init check_iteration(struct maple_tree *mt)
> @@ -1980,6 +1985,10 @@ static noinline void __init bench_forking(struct maple_tree *mt)
>   	void *val;
>   	MA_STATE(mas, mt, 0, 0);
>   	MA_STATE(newmas, mt, 0, 0);
> +	struct rw_semaphore newmt_lock;
> +
> +	init_rwsem(&newmt_lock);
> +	mt_set_external_lock(&newmt, &newmt_lock);
>   
>   	for (i = 0; i <= nr_entries; i++)
>   		mtree_store_range(mt, i*10, i*10 + 5,
> @@ -1994,7 +2003,7 @@ static noinline void __init bench_forking(struct maple_tree *mt)
>   		mas.index = 0;
>   		mas.last = 0;
>   		rcu_read_lock();
> -		mas_lock(&newmas);
> +		down_write(&newmt_lock);
>   		if (mas_expected_entries(&newmas, nr_entries)) {
>   			printk("OOM!");
>   			BUG_ON(1);
> @@ -2005,11 +2014,11 @@ static noinline void __init bench_forking(struct maple_tree *mt)
>   			mas_store(&newmas, val);
>   		}
>   		mas_destroy(&newmas);
> -		mas_unlock(&newmas);
>   		rcu_read_unlock();
>   		mt_validate(&newmt);
>   		mt_set_non_kernel(0);
> -		mtree_destroy(&newmt);
> +		__mt_destroy(&newmt);
> +		up_write(&newmt_lock);
>   	}
>   }
>   #endif
> @@ -2616,6 +2625,10 @@ static noinline void __init check_dup_gaps(struct maple_tree *mt,
>   	void *tmp;
>   	MA_STATE(mas, mt, 0, 0);
>   	MA_STATE(newmas, &newmt, 0, 0);
> +	struct rw_semaphore newmt_lock;
> +
> +	init_rwsem(&newmt_lock);
> +	mt_set_external_lock(&newmt, &newmt_lock);
>   
>   	if (!zero_start)
>   		i = 1;
> @@ -2625,9 +2638,9 @@ static noinline void __init check_dup_gaps(struct maple_tree *mt,
>   		mtree_store_range(mt, i*10, (i+1)*10 - gap,
>   				  xa_mk_value(i), GFP_KERNEL);
>   
> -	mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE);
> +	mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN);
>   	mt_set_non_kernel(99999);
> -	mas_lock(&newmas);
> +	down_write(&newmt_lock);
>   	ret = mas_expected_entries(&newmas, nr_entries);
>   	mt_set_non_kernel(0);
>   	MT_BUG_ON(mt, ret != 0);
> @@ -2640,9 +2653,9 @@ static noinline void __init check_dup_gaps(struct maple_tree *mt,
>   	}
>   	rcu_read_unlock();
>   	mas_destroy(&newmas);
> -	mas_unlock(&newmas);
>   
> -	mtree_destroy(&newmt);
> +	__mt_destroy(&newmt);
> +	up_write(&newmt_lock);
>   }
>   
>   /* Duplicate many sizes of trees.  Mainly to test expected entry values */
> diff --git a/tools/include/linux/rwsem.h b/tools/include/linux/rwsem.h
> new file mode 100644
> index 000000000000..83971b3cbfce
> --- /dev/null
> +++ b/tools/include/linux/rwsem.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +#ifndef _TOOLS__RWSEM_H
> +#define _TOOLS__RWSEM_H
> +
> +#include <pthread.h>
> +
> +struct rw_semaphore {
> +	pthread_rwlock_t lock;
> +};
> +
> +static inline int init_rwsem(struct rw_semaphore *sem)
> +{
> +	return pthread_rwlock_init(&sem->lock, NULL);
> +}
> +
> +static inline int exit_rwsem(struct rw_semaphore *sem)
> +{
> +	return pthread_rwlock_destroy(&sem->lock);
> +}
> +
> +static inline int down_read(struct rw_semaphore *sem)
> +{
> +	return pthread_rwlock_rdlock(&sem->lock);
> +}
> +
> +static inline int up_read(struct rw_semaphore *sem)
> +{
> +	return pthread_rwlock_unlock(&sem->lock);
> +}
> +
> +static inline int down_write(struct rw_semaphore *sem)
> +{
> +	return pthread_rwlock_wrlock(&sem->lock);
> +}
> +
> +static inline int up_write(struct rw_semaphore *sem)
> +{
> +	return pthread_rwlock_unlock(&sem->lock);
> +}
> +#endif /* _TOOLS_RWSEM_H */
