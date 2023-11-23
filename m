Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4D47F570F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 04:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344489AbjKWDdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 22:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjKWDdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 22:33:00 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBB010E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 19:33:06 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-6cb66fbc63dso363965b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 19:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700710386; x=1701315186; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z+9/kRqzLkNKRzwVrj9WmdNAZ3JcQwplUOpQg0pAAow=;
        b=Qwhifr429SwLMPhXcHy48O45dx/TsXV9D2B3nrismfBIkdKx+AGJgXhTHyI9MDcI1V
         oMMeMGzYFSjZLj49dmAZ7SZItL1bcuxzlKWF/2j8d0rASvZjUUPxbIJVJ7KQoR2rxEgM
         6QWZ2xW5ixGTD2Jue4Jz4F/eHLtJjzMjI9y40xe41T7jCFKKClAmmbWL1FMk2T2vbJoH
         8tztvaOpOWHPziRdYgYwgXLXdUk3TgdOeq+wqvnZ/AOZ/d69Py3YNTEkFYKUm2Mot8tm
         iLoodCrzBoruHuQtqmqYRPMi4T7UBNVlQJaFFGNviABA1HQZYCD4i+13pwe0dXlKMs4f
         muXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700710386; x=1701315186;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+9/kRqzLkNKRzwVrj9WmdNAZ3JcQwplUOpQg0pAAow=;
        b=ruBmflZouyvGXTf6AwTRBiASvSgxTCO8K0apG23wQc5AfJm+d7RE2bJPd+JKdwrE+I
         xRYogrFuZvilWRZ0OHmpTvYhmboISVBHv0FvflfT345YSB4nP4wDyLa2CCOej/7rKZMo
         TO/R5bs9BRmLdcfUPtU1QwTIuzjujpu4G4J3C8LkMzhWaqE2W+A+YZ/vV39Xs/0TTa1z
         i02okHNjlIOtTwtrMl6feEXMmr/wBH/xbN24XD/uSLPhpJxRITKWz9GRG6Lp7fVKJILr
         8xsAwqx5ims5YSUSvj9YYUHfKO3YXPs41G/TLINrNBA/G8RPAV6UGpSuB02UMPkT8XZm
         DJUg==
X-Gm-Message-State: AOJu0YwY6PDQu9edeNb6Ita81ieKiRtGQAA79HO/nkSQlOE3cbqYeRbU
        B9JgvrISLkJ4UOeTCmDKrc26O136/xhzMRlZ
X-Google-Smtp-Source: AGHT+IHZW0SifGuNsysVOaOrKzD0LPSi06IM1rOaNU5cXwcTZumlC4ElWnGhwlsOAevDGXK40nqWAg==
X-Received: by 2002:a05:6a20:6a0a:b0:18a:b5c3:55da with SMTP id p10-20020a056a206a0a00b0018ab5c355damr2082478pzk.10.1700710385676;
        Wed, 22 Nov 2023 19:33:05 -0800 (PST)
Received: from [10.84.152.29] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id p3-20020a62ab03000000b0068fb783d0c6sm220644pff.141.2023.11.22.19.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 19:33:05 -0800 (PST)
Message-ID: <deed9bb1-02b9-4e89-895b-38a84e5a9408@gmail.com>
Date:   Thu, 23 Nov 2023 11:32:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] mm: shrinker: Add a .to_text() method for shrinkers
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Dave Chinner <david@fromorbit.com>
References: <20231122232515.177833-1-kent.overstreet@linux.dev>
 <20231122232515.177833-3-kent.overstreet@linux.dev>
From:   Qi Zheng <arch0.zheng@gmail.com>
Content-Language: en-US
In-Reply-To: <20231122232515.177833-3-kent.overstreet@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kent,

On 2023/11/23 07:25, Kent Overstreet wrote:
> This adds a new callback method to shrinkers which they can use to
> describe anything relevant to memory reclaim about their internal state,
> for example object dirtyness.

I have no objection to this proposal, but maybe it would be better to
place this feature under CONFIG_SHRINKER_DEBUG?

Hi Roman, what do you think?

Also +CC Dave.

More comments below.

> 
> This patch also adds shrinkers_to_text(), which reports on the top 10
> shrinkers - by object count - in sorted order, to be used in OOM
> reporting.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Qi Zheng <zhengqi.arch@bytedance.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: linux-mm@kvack.org
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>   include/linux/shrinker.h |  6 +++-
>   mm/shrinker.c            | 73 +++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 77 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> index 1a00be90d93a..968c55474e78 100644
> --- a/include/linux/shrinker.h
> +++ b/include/linux/shrinker.h
> @@ -24,6 +24,8 @@ struct shrinker_info {
>   	struct shrinker_info_unit *unit[];
>   };
>   
> +struct seq_buf;
> +
>   /*
>    * This struct is used to pass information from page reclaim to the shrinkers.
>    * We consolidate the values for easier extension later.
> @@ -80,10 +82,12 @@ struct shrink_control {
>    * @flags determine the shrinker abilities, like numa awareness
>    */
>   struct shrinker {
> +	const char *name;
>   	unsigned long (*count_objects)(struct shrinker *,
>   				       struct shrink_control *sc);
>   	unsigned long (*scan_objects)(struct shrinker *,
>   				      struct shrink_control *sc);
> +	void (*to_text)(struct seq_buf *, struct shrinker *);

The "to_text" looks a little strange, how about naming it
"stat_objects"?

>   
>   	long batch;	/* reclaim batch size, 0 = default */
>   	int seeks;	/* seeks to recreate an obj */
> @@ -110,7 +114,6 @@ struct shrinker {
>   #endif
>   #ifdef CONFIG_SHRINKER_DEBUG
>   	int debugfs_id;
> -	const char *name;

The name will only be allocated memory when the CONFIG_SHRINKER_DEBUG is
enabled, otherwise its value is NULL. So you can't move it out and use
it while CONFIG_SHRINKER_DEBUG is disabled.

>   	struct dentry *debugfs_entry;
>   #endif
>   	/* objs pending delete, per node */
> @@ -135,6 +138,7 @@ __printf(2, 3)
>   struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, ...);
>   void shrinker_register(struct shrinker *shrinker);
>   void shrinker_free(struct shrinker *shrinker);
> +void shrinkers_to_text(struct seq_buf *);
>   
>   static inline bool shrinker_try_get(struct shrinker *shrinker)
>   {
> diff --git a/mm/shrinker.c b/mm/shrinker.c
> index dd91eab43ed3..4976dbac4c83 100644
> --- a/mm/shrinker.c
> +++ b/mm/shrinker.c
> @@ -1,8 +1,9 @@
>   // SPDX-License-Identifier: GPL-2.0
>   #include <linux/memcontrol.h>
> +#include <linux/rculist.h>
>   #include <linux/rwsem.h>
> +#include <linux/seq_buf.h>
>   #include <linux/shrinker.h>
> -#include <linux/rculist.h>
>   #include <trace/events/vmscan.h>
>   
>   #include "internal.h"
> @@ -807,3 +808,73 @@ void shrinker_free(struct shrinker *shrinker)
>   	call_rcu(&shrinker->rcu, shrinker_free_rcu_cb);
>   }
>   EXPORT_SYMBOL_GPL(shrinker_free);
> +
> +void shrinker_to_text(struct seq_buf *out, struct shrinker *shrinker)
> +{
> +	struct shrink_control sc = { .gfp_mask = GFP_KERNEL, };
> +
> +	seq_buf_puts(out, shrinker->name);
> +	seq_buf_printf(out, " objects: %lu\n", shrinker->count_objects(shrinker, &sc));
> +
> +	if (shrinker->to_text) {
> +		shrinker->to_text(out, shrinker);
> +		seq_buf_puts(out, "\n");
> +	}
> +}
> +
> +/**
> + * shrinkers_to_text - Report on shrinkers with highest usage
> + *
> + * This reports on the top 10 shrinkers, by object counts, in sorted order:
> + * intended to be used for OOM reporting.
> + */
> +void shrinkers_to_text(struct seq_buf *out)
> +{
> +	struct shrinker *shrinker;
> +	struct shrinker_by_mem {
> +		struct shrinker	*shrinker;
> +		unsigned long	mem;

The "mem" also looks a little strange, how about naming it
"freeable"?

> +	} shrinkers_by_mem[10];
> +	int i, nr = 0;
> +
> +	if (!mutex_trylock(&shrinker_mutex)) {
> +		seq_buf_puts(out, "(couldn't take shrinker lock)");
> +		return;
> +	}

We now have lockless method (RCU + refcount) to iterate shrinker_list,
please refer to shrink_slab().

Thanks,
Qi

> +
> +	list_for_each_entry(shrinker, &shrinker_list, list) {
> +		struct shrink_control sc = { .gfp_mask = GFP_KERNEL, };
> +		unsigned long mem = shrinker->count_objects(shrinker, &sc);
> +
> +		if (!mem || mem == SHRINK_STOP || mem == SHRINK_EMPTY)
> +			continue;
> +
> +		for (i = 0; i < nr; i++)
> +			if (mem < shrinkers_by_mem[i].mem)
> +				break;
> +
> +		if (nr < ARRAY_SIZE(shrinkers_by_mem)) {
> +			memmove(&shrinkers_by_mem[i + 1],
> +				&shrinkers_by_mem[i],
> +				sizeof(shrinkers_by_mem[0]) * (nr - i));
> +			nr++;
> +		} else if (i) {
> +			i--;
> +			memmove(&shrinkers_by_mem[0],
> +				&shrinkers_by_mem[1],
> +				sizeof(shrinkers_by_mem[0]) * i);
> +		} else {
> +			continue;
> +		}
> +
> +		shrinkers_by_mem[i] = (struct shrinker_by_mem) {
> +			.shrinker = shrinker,
> +			.mem = mem,
> +		};
> +	}
> +
> +	for (i = nr - 1; i >= 0; --i)
> +		shrinker_to_text(out, shrinkers_by_mem[i].shrinker);
> +
> +	mutex_unlock(&shrinker_mutex);
> +}
