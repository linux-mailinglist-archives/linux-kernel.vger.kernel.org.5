Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311E27C9E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 06:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjJPEJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 00:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJPEJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 00:09:53 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E77C5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 21:09:50 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-6bd96cfb99cso517502b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 21:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697429390; x=1698034190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wGM0mRZxvBtzql9FwK0jFJh47x4n6KkdzlqXBUfZfHs=;
        b=lqmEvE9T64HUDNRIS8ka06+SHjzROuIprkmBczNwNBf7P/dSnOMVRakU1yTRBeVp4D
         u8x+hJYFTxo/Uo731JZ5GI9/fhGhqLv3dwEiTiV4T3/Bc/V9/XmEWiIx5pmeqXScQ1hV
         xIgUR44ixvZFw6MmQbxg6rW3faBq0oODjq8BmLbHC760xkj8eqT8WB9eW5h7NHHfKof3
         mVT4kEQUekNpJDFnALwJ43CrvDUfNQMipVMhbyDmkUOievMhO6EN0A2X1XtMgPwyJhnL
         A3QYxMUftM3yxil9ncHqBXn8829CW27TsR9BX3egqOg6i6A/3705OUHhFW50UcAwzMTm
         WxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697429390; x=1698034190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wGM0mRZxvBtzql9FwK0jFJh47x4n6KkdzlqXBUfZfHs=;
        b=Um1dA7ihGVKW171KZcGNXRSwWsyfjo/DiXgYuPk76230Dq+XYPfoKIL4Ev9R8xyRNg
         F/aQ0y5ks3bQzfwhpYzDjce0R1dNj1O/4EGjEonaxzZcft6mMsrkmMYCl7f4XGN5HmKA
         rEmGt760oJ2cenfD5Ejd10rlTrj0hcQ6M5+ChO3I2O+h80lb/xvGryr1AUJn5M/uTmAm
         Ybs54nV71nhAO2hb/OAOB/C9eZ1RSQmBjuRaTMalT0eRGt8LmQA/2qD8aNb52C84elAD
         7MPh64/rB4KUB9Mz2QoUjzZWl+C4fTqmyk41SsoH3ohEm3aU3Umygi0c/WH7lLEM1L58
         9XOw==
X-Gm-Message-State: AOJu0Yxaa7blL9obAMSDuQ1xYgHzNtm/HpLyRQScXcz4n8QH20H+51id
        A2EA3zi+6a0aCTD00uRsXJQ=
X-Google-Smtp-Source: AGHT+IHAbPbjF+cqVgpdkO+Soafo+YgWVpt5DgzO/plnHTgAw1Zg8d7wh2s4hvd6jPM2I7y35acBqQ==
X-Received: by 2002:a05:6a00:2e20:b0:68e:42c9:74e0 with SMTP id fc32-20020a056a002e2000b0068e42c974e0mr33993929pfb.3.1697429390290;
        Sun, 15 Oct 2023 21:09:50 -0700 (PDT)
Received: from [10.84.155.153] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id b184-20020a62cfc1000000b0068c006dd5c1sm2605085pfg.115.2023.10.15.21.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Oct 2023 21:09:49 -0700 (PDT)
Message-ID: <8f506561-44f7-a243-f0cc-59543f487e4d@gmail.com>
Date:   Mon, 16 Oct 2023 12:09:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] mm: page_alloc: don't allocate page from memoryless nodes
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Teng Hu <huteng.ht@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <muchun.song@linux.dev>, x86@kernel.org
References: <eefc40e5-a14b-22c5-3480-6786afa1c8f4@redhat.com>
 <Y+tXrK/g1Nrd/q1h@kernel.org>
 <67240e55-af49-f20a-2b4b-b7d574cd910d@gmail.com>
 <22f0e262-982e-ea80-e52a-a3c924b31d58@redhat.com>
 <dbfbd982-27f3-0d72-49e0-d3dd5fe636a8@bytedance.com>
 <4386151c-0328-d207-9a71-933ef61817f9@redhat.com>
 <Y+t0Bhu7BCzH2Dp4@kernel.org>
 <a7f8be91-32c1-bfbe-7e81-5b1e818ba01d@redhat.com>
 <a09bfe3a-87e4-f8ce-89bb-c5fde8cc33c9@redhat.com>
 <Y+uO5IE7boORqsne@dhcp22.suse.cz> <Y+ymKw1eJaRcmDNN@kernel.org>
From:   Qi Zheng <arch0.zheng@gmail.com>
In-Reply-To: <Y+ymKw1eJaRcmDNN@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 2023/2/15 17:30, Mike Rapoport wrote:
[...]
> 
> How about we try this:
> 
>  From b670120bcacd3fe34a40d7179c70ca2ab69279e0 Mon Sep 17 00:00:00 2001
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> Date: Wed, 15 Feb 2023 11:12:18 +0200
> Subject: [PATCH] x86/mm: drop 4MB restriction on minimal NUMA node size
> 
> Qi Zheng reports crashes in a production environment and provides a
> simplified example as a reproducer:
> 
>    For example, if we use qemu to start a two NUMA node kernel,
>    one of the nodes has 2M memory (less than NODE_MIN_SIZE),
>    and the other node has 2G, then we will encounter the
>    following panic:
> 
>    [    0.149844] BUG: kernel NULL pointer dereference, address: 0000000000000000
>    [    0.150783] #PF: supervisor write access in kernel mode
>    [    0.151488] #PF: error_code(0x0002) - not-present page
>    <...>
>    [    0.156056] RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
>    <...>
>    [    0.169781] Call Trace:
>    [    0.170159]  <TASK>
>    [    0.170448]  deactivate_slab+0x187/0x3c0
>    [    0.171031]  ? bootstrap+0x1b/0x10e
>    [    0.171559]  ? preempt_count_sub+0x9/0xa0
>    [    0.172145]  ? kmem_cache_alloc+0x12c/0x440
>    [    0.172735]  ? bootstrap+0x1b/0x10e
>    [    0.173236]  bootstrap+0x6b/0x10e
>    [    0.173720]  kmem_cache_init+0x10a/0x188
>    [    0.174240]  start_kernel+0x415/0x6ac
>    [    0.174738]  secondary_startup_64_no_verify+0xe0/0xeb
>    [    0.175417]  </TASK>
>    [    0.175713] Modules linked in:
>    [    0.176117] CR2: 0000000000000000
> 
> The crashes happen because of inconsistency between nodemask that has
> nodes with less than 4MB as memoryless and the actual memory fed into
> core mm.
> 
> The commit 9391a3f9c7f1 ("[PATCH] x86_64: Clear more state when ignoring
> empty node in SRAT parsing") that introduced minimal size of a NUMA node
> does not explain why a node size cannot be less than 4MB and what boot
> failures this restriction might fix.
> 
> Since then a lot has changed and core mm won't confuse badly about small
> node sizes.
> 
> Drop the limitation for the minimal node size.
> 
> Link: https://lore.kernel.org/all/20230212110305.93670-1-zhengqi.arch@bytedance.com/
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>   arch/x86/include/asm/numa.h | 7 -------
>   arch/x86/mm/numa.c          | 7 -------
>   2 files changed, 14 deletions(-)

What's the current progress on this patch? This patch doesn't seem to be
merged into any trees. Did I miss something?

Thanks,
Qi

> 
> diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
> index e3bae2b60a0d..ef2844d69173 100644
> --- a/arch/x86/include/asm/numa.h
> +++ b/arch/x86/include/asm/numa.h
> @@ -12,13 +12,6 @@
>   
>   #define NR_NODE_MEMBLKS		(MAX_NUMNODES*2)
>   
> -/*
> - * Too small node sizes may confuse the VM badly. Usually they
> - * result from BIOS bugs. So dont recognize nodes as standalone
> - * NUMA entities that have less than this amount of RAM listed:
> - */
> -#define NODE_MIN_SIZE (4*1024*1024)
> -
>   extern int numa_off;
>   
>   /*
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 2aadb2019b4f..55e3d895f15c 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -601,13 +601,6 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
>   		if (start >= end)
>   			continue;
>   
> -		/*
> -		 * Don't confuse VM with a node that doesn't have the
> -		 * minimum amount of memory:
> -		 */
> -		if (end && (end - start) < NODE_MIN_SIZE)
> -			continue;
> -
>   		alloc_node_data(nid);
>   	}
>   
