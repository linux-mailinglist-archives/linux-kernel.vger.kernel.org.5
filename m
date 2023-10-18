Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC437CD976
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbjJRKnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjJRKm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:42:58 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E44995
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:42:55 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9ba1eb73c27so1094957866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697625774; x=1698230574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m9eNFghMxszk3YbHipHRejIdiQf5YgHBf4/5ZaM5L2c=;
        b=MdoEA4W2PncTkrnz1wQ/tGssHnmM8yMp1gUwsHDWFEdYu1pkiZJtaJE0SqrbF6VoXw
         kho17iH43WXmH9xtXA81eQJEnLA8TiWKV137aqVOVVp9jn0MxfZJeXmvY//icYh4UOK4
         mkIH6ZgXkO7/mR77yV6TMjGdqkUdAWaya4lFvdcjRPKDT0uJSrLphyyjQsN+GA/0n1dP
         F2yhdSPmaQ7yE/AENGxsyhflQMe5TXmh/CPW2ckQjvFe2DsuNpKCVolVOE7N/P0pWBNc
         dOth7jYVh0/U4bM35HvuB4u+nUx52KvtN2r7OREtpBrHL/MSFSw3xMGAyKOb07Fps80a
         AprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697625774; x=1698230574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9eNFghMxszk3YbHipHRejIdiQf5YgHBf4/5ZaM5L2c=;
        b=rWJCtRYTkLh1ZhryT66MTIgmQ+AK5F350DoPFNn1/qY4bb705pNerLYf5Q2IeArKiO
         13qcOSwmPd2iWqvW12Ey2Q3uCefFilvBYJlDd5QUzLO4TulKz9D/7DOugfEb3gI2xsDD
         6AQGMcJK2cHo5p+Ed4MOKGKwQ4PW2O+dCY8zU38T5sgd3DzzU7vByT4LhX4Ok+S+C+Xm
         buVGKrRWpJbcQJKMNIucbn3g2QMdxbkH79kIr15gAyBPO08SYNJ4KnIrwZ2yLiZISmhZ
         PZ7qqxdD7u3zNqr7703wQrxT8g3vEIePJht81hVM7lbRLyYtWrNnhKi1YLkP5VnYvdQf
         9TZA==
X-Gm-Message-State: AOJu0Yyd+qf8nazsJXoIX2UM5JK+R6ZNfbAbQy/aGf+3Daeh5cxVutUM
        p/wJ3u2qt9vSJRmayAZegx0=
X-Google-Smtp-Source: AGHT+IFencvTC68TFJimy9AUfJSm5E3bhYTPdwOE5xsVWGzExsslopJsSRaNT2v5UhDBIdUSxz+OZw==
X-Received: by 2002:a17:907:5cc:b0:9b2:9e44:222e with SMTP id wg12-20020a17090705cc00b009b29e44222emr4284728ejb.19.1697625773687;
        Wed, 18 Oct 2023 03:42:53 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id lh22-20020a170906f8d600b009b94c545678sm1397665ejb.153.2023.10.18.03.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 03:42:53 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 18 Oct 2023 12:42:50 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2] x86/mm: Drop 4MB restriction on minimal NUMA node memory
 size
Message-ID: <ZS+2qqjEO5/867br@gmail.com>
References: <20231017062215.171670-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017062215.171670-1-rppt@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mike Rapoport <rppt@kernel.org> wrote:

> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> Qi Zheng reports crashes in a production environment and provides a
> simplified example as a reproducer:
> 
>   For example, if we use qemu to start a two NUMA node kernel,
>   one of the nodes has 2M memory (less than NODE_MIN_SIZE),
>   and the other node has 2G, then we will encounter the
>   following panic:
> 
>   [    0.149844] BUG: kernel NULL pointer dereference, address: 0000000000000000
>   [    0.150783] #PF: supervisor write access in kernel mode
>   [    0.151488] #PF: error_code(0x0002) - not-present page
>   <...>
>   [    0.156056] RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
>   <...>
>   [    0.169781] Call Trace:
>   [    0.170159]  <TASK>
>   [    0.170448]  deactivate_slab+0x187/0x3c0
>   [    0.171031]  ? bootstrap+0x1b/0x10e
>   [    0.171559]  ? preempt_count_sub+0x9/0xa0
>   [    0.172145]  ? kmem_cache_alloc+0x12c/0x440
>   [    0.172735]  ? bootstrap+0x1b/0x10e
>   [    0.173236]  bootstrap+0x6b/0x10e
>   [    0.173720]  kmem_cache_init+0x10a/0x188
>   [    0.174240]  start_kernel+0x415/0x6ac
>   [    0.174738]  secondary_startup_64_no_verify+0xe0/0xeb
>   [    0.175417]  </TASK>
>   [    0.175713] Modules linked in:
>   [    0.176117] CR2: 0000000000000000
> 
> The crashes happen because of inconsistency between nodemask that has
> nodes with less than 4MB as memoryless and the actual memory fed into
> core mm.

Presumably the core MM got fixed too to not just crash, but provide some 
sort of warning?

> The commit 9391a3f9c7f1 ("[PATCH] x86_64: Clear more state when ignoring
> empty node in SRAT parsing") that introduced minimal size of a NUMA node
> does not explain why a node size cannot be less than 4MB and what boot
> failures this restriction might fix.
> 
> Since then a lot has changed and core mm won't confuse badly about small
> node sizes.

Core MM won't get confused ... other than by the above weird Qemu topology, 
to which it responds with a ... NULL pointer dereference?

Seems quite close to the literal definition of 'get confused badly' to me, 
and doesn't give me the warm fuzzy feeling that giving the core MM even 
*more* weird topologies is super safe ... :-/

> Drop the limitation for the minimal node size.

While I agree with dropping the limitation, and I agree that 9391a3f9c7f1 
should have provided more of a justification, I believe a core MM fix is in 
order as well, for it to not crash. [ If it's fixed upstream already, 
please reference the relevant commit ID. ]

Also, the changelog spelling & general presentation were quite low quality 
- I've fixed it up a bit below, please carry this version going forward. 
Please spell-check your patches before sending out Nth versions of it, 
maybe maintainers are skipping them for a reason!

Thanks,

	Ingo

=================>
From: "Mike Rapoport (IBM)" <rppt@kernel.org>
Date: Tue, 17 Oct 2023 09:22:15 +0300
Subject: [PATCH] x86/mm: Drop 4MB restriction on minimal NUMA node memory size

Qi Zheng reported crashes in a production environment and provided a
simplified example as a reproducer:

 |  For example, if we use qemu to start a two NUMA node kernel,
 |  one of the nodes has 2M memory (less than NODE_MIN_SIZE),
 |  and the other node has 2G, then we will encounter the
 |  following panic:
 |
 |    BUG: kernel NULL pointer dereference, address: 0000000000000000
 |    <...>
 |    RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
 |    <...>
 |    Call Trace:
 |      <TASK>
 |      deactivate_slab()
 |      bootstrap()
 |      kmem_cache_init()
 |      start_kernel()
 |      secondary_startup_64_no_verify()

The crashes happen because of inconsistency between the nodemask that
has nodes with less than 4MB as memoryless, and the actual memory fed
into the core mm.

The commit:

  9391a3f9c7f1 ("[PATCH] x86_64: Clear more state when ignoring empty node in SRAT parsing")

... that introduced minimal size of a NUMA node does not explain why
a node size cannot be less than 4MB and what boot failures this
restriction might fix.

In the 17 years since then a lot has changed and core mm won't get
confused about small node sizes.

Drop the limitation for the minimal node size.

[ mingo: Improved changelog clarity. ]

Reported-by: Qi Zheng <zhengqi.arch@bytedance.com>
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
Not-Yet-Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Link: https://lore.kernel.org/all/20230212110305.93670-1-zhengqi.arch@bytedance.com/
---
 arch/x86/include/asm/numa.h | 7 -------
 arch/x86/mm/numa.c          | 7 -------
 2 files changed, 14 deletions(-)

diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
index e3bae2b60a0d..ef2844d69173 100644
--- a/arch/x86/include/asm/numa.h
+++ b/arch/x86/include/asm/numa.h
@@ -12,13 +12,6 @@
 
 #define NR_NODE_MEMBLKS		(MAX_NUMNODES*2)
 
-/*
- * Too small node sizes may confuse the VM badly. Usually they
- * result from BIOS bugs. So dont recognize nodes as standalone
- * NUMA entities that have less than this amount of RAM listed:
- */
-#define NODE_MIN_SIZE (4*1024*1024)
-
 extern int numa_off;
 
 /*
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index c01c5506fd4a..aa39d678fe81 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -602,13 +602,6 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
 		if (start >= end)
 			continue;
 
-		/*
-		 * Don't confuse VM with a node that doesn't have the
-		 * minimum amount of memory:
-		 */
-		if (end && (end - start) < NODE_MIN_SIZE)
-			continue;
-
 		alloc_node_data(nid);
 	}
 
