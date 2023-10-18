Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2597E7CE0E6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjJRPN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235328AbjJRPNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:13:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A91112
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:13:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206E7C433C7;
        Wed, 18 Oct 2023 15:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697642000;
        bh=QHYsrCWEAf6Rj1WInkAyV5oPIT9y9pWAyNJdsQJykTw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KWZ7cHYL1iMGqg/LhuGkp7vLmErI62GgzuuG0C4bZugDCnj4lVCEIZoOXno70U0Cn
         PmrHCWIT45vm5EHLEtq2ugu9UqRhArbSxMHJ5TBc+4pVxLayeXOlByABPAC/TeyzBA
         Mbo6sIZfpThPICjQ/672UBLGBLlQCLx08OoP8zce+EVHbigSmUkyE06lrNoNOH1kXW
         GynuoJdWfzqu+PQbn4tnCFfgNtRcDmcavco3x+lnJY7BzBul3iARR5XRnfkitF3VA8
         D7grGFgq3ad6PgOhFeHfaKr99Zyhl0hk56dNY2gYu2SjZqesER69LL64JHPo9Z+RAz
         VtQF+LWzOk9Yg==
Date:   Thu, 19 Oct 2023 00:13:14 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc:     "wuqiang.matt" <wuqiang.matt@bytedance.com>,
        linux-trace-kernel@vger.kernel.org, davem@davemloft.net,
        anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
        rostedt@goodmis.org, peterz@infradead.org,
        akpm@linux-foundation.org, sander@svanheule.net,
        ebiggers@google.com, dan.j.williams@intel.com, jpoimboe@kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com
Subject: Re: [PATCH v10 4/5] kprobes: freelist.h removed
Message-Id: <20231019001314.1b27a6cb0429590abf101992@kernel.org>
In-Reply-To: <20231016222314.291e370a53a1f1922f8182c3@kernel.org>
References: <20231015053251.707442-1-wuqiang.matt@bytedance.com>
        <20231015053251.707442-5-wuqiang.matt@bytedance.com>
        <20231016222314.291e370a53a1f1922f8182c3@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 16 Oct 2023 22:23:14 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hi Peter,
> 
> This freelist has been introduced by you, is it OK to remove this because no
> other user exists?

I'll pick this on my probes/for-next branch. If there is any issue reported,
I'll revert it.

Thank you,

> 
> Thank you,
> 
> On Sun, 15 Oct 2023 13:32:50 +0800
> "wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:
> 
> > This patch will remove freelist.h from kernel source tree, since the
> > only use cases (kretprobe and rethook) are converted to objpool.
> > 
> > Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
> > ---
> >  include/linux/freelist.h | 129 ---------------------------------------
> >  1 file changed, 129 deletions(-)
> >  delete mode 100644 include/linux/freelist.h
> > 
> > diff --git a/include/linux/freelist.h b/include/linux/freelist.h
> > deleted file mode 100644
> > index fc1842b96469..000000000000
> > --- a/include/linux/freelist.h
> > +++ /dev/null
> > @@ -1,129 +0,0 @@
> > -/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> > -#ifndef FREELIST_H
> > -#define FREELIST_H
> > -
> > -#include <linux/atomic.h>
> > -
> > -/*
> > - * Copyright: cameron@moodycamel.com
> > - *
> > - * A simple CAS-based lock-free free list. Not the fastest thing in the world
> > - * under heavy contention, but simple and correct (assuming nodes are never
> > - * freed until after the free list is destroyed), and fairly speedy under low
> > - * contention.
> > - *
> > - * Adapted from: https://moodycamel.com/blog/2014/solving-the-aba-problem-for-lock-free-free-lists
> > - */
> > -
> > -struct freelist_node {
> > -	atomic_t		refs;
> > -	struct freelist_node	*next;
> > -};
> > -
> > -struct freelist_head {
> > -	struct freelist_node	*head;
> > -};
> > -
> > -#define REFS_ON_FREELIST 0x80000000
> > -#define REFS_MASK	 0x7FFFFFFF
> > -
> > -static inline void __freelist_add(struct freelist_node *node, struct freelist_head *list)
> > -{
> > -	/*
> > -	 * Since the refcount is zero, and nobody can increase it once it's
> > -	 * zero (except us, and we run only one copy of this method per node at
> > -	 * a time, i.e. the single thread case), then we know we can safely
> > -	 * change the next pointer of the node; however, once the refcount is
> > -	 * back above zero, then other threads could increase it (happens under
> > -	 * heavy contention, when the refcount goes to zero in between a load
> > -	 * and a refcount increment of a node in try_get, then back up to
> > -	 * something non-zero, then the refcount increment is done by the other
> > -	 * thread) -- so if the CAS to add the node to the actual list fails,
> > -	 * decrese the refcount and leave the add operation to the next thread
> > -	 * who puts the refcount back to zero (which could be us, hence the
> > -	 * loop).
> > -	 */
> > -	struct freelist_node *head = READ_ONCE(list->head);
> > -
> > -	for (;;) {
> > -		WRITE_ONCE(node->next, head);
> > -		atomic_set_release(&node->refs, 1);
> > -
> > -		if (!try_cmpxchg_release(&list->head, &head, node)) {
> > -			/*
> > -			 * Hmm, the add failed, but we can only try again when
> > -			 * the refcount goes back to zero.
> > -			 */
> > -			if (atomic_fetch_add_release(REFS_ON_FREELIST - 1, &node->refs) == 1)
> > -				continue;
> > -		}
> > -		return;
> > -	}
> > -}
> > -
> > -static inline void freelist_add(struct freelist_node *node, struct freelist_head *list)
> > -{
> > -	/*
> > -	 * We know that the should-be-on-freelist bit is 0 at this point, so
> > -	 * it's safe to set it using a fetch_add.
> > -	 */
> > -	if (!atomic_fetch_add_release(REFS_ON_FREELIST, &node->refs)) {
> > -		/*
> > -		 * Oh look! We were the last ones referencing this node, and we
> > -		 * know we want to add it to the free list, so let's do it!
> > -		 */
> > -		__freelist_add(node, list);
> > -	}
> > -}
> > -
> > -static inline struct freelist_node *freelist_try_get(struct freelist_head *list)
> > -{
> > -	struct freelist_node *prev, *next, *head = smp_load_acquire(&list->head);
> > -	unsigned int refs;
> > -
> > -	while (head) {
> > -		prev = head;
> > -		refs = atomic_read(&head->refs);
> > -		if ((refs & REFS_MASK) == 0 ||
> > -		    !atomic_try_cmpxchg_acquire(&head->refs, &refs, refs+1)) {
> > -			head = smp_load_acquire(&list->head);
> > -			continue;
> > -		}
> > -
> > -		/*
> > -		 * Good, reference count has been incremented (it wasn't at
> > -		 * zero), which means we can read the next and not worry about
> > -		 * it changing between now and the time we do the CAS.
> > -		 */
> > -		next = READ_ONCE(head->next);
> > -		if (try_cmpxchg_acquire(&list->head, &head, next)) {
> > -			/*
> > -			 * Yay, got the node. This means it was on the list,
> > -			 * which means should-be-on-freelist must be false no
> > -			 * matter the refcount (because nobody else knows it's
> > -			 * been taken off yet, it can't have been put back on).
> > -			 */
> > -			WARN_ON_ONCE(atomic_read(&head->refs) & REFS_ON_FREELIST);
> > -
> > -			/*
> > -			 * Decrease refcount twice, once for our ref, and once
> > -			 * for the list's ref.
> > -			 */
> > -			atomic_fetch_add(-2, &head->refs);
> > -
> > -			return head;
> > -		}
> > -
> > -		/*
> > -		 * OK, the head must have changed on us, but we still need to decrement
> > -		 * the refcount we increased.
> > -		 */
> > -		refs = atomic_fetch_add(-1, &prev->refs);
> > -		if (refs == REFS_ON_FREELIST + 1)
> > -			__freelist_add(prev, list);
> > -	}
> > -
> > -	return NULL;
> > -}
> > -
> > -#endif /* FREELIST_H */
> > -- 
> > 2.40.1
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
