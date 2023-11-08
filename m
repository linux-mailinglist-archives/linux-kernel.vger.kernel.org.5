Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90D57E5255
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbjKHJDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 04:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbjKHJDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:03:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F6C10A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 01:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ckGypnwi80MyxU18wHr89u6t2atgr47NVJClcRkTyPY=; b=i/NNDAE0uKEPYCVQXGIrRvQwdn
        TuptosTcXKhEmXv3B93+BQ/GvNj8Dbbm2xdIfG1JKPRDGXl8pREUK/Dcpu67RyBMMKw0i8E5+waDL
        GQCVZ4YCiyH1N/JsEOnSZBaa2A0KVMdJyokcQd0QxokWUC696ru8IURSSY3bnbGxC/8GrI+ffynxc
        0aVj7xlx/FWF3lXfE2BC7U/OpiBH20HnTsLnk5+RsDPUBoG/7OSZ5qShIFSqWwDZAnOsi0aVyPMdA
        R3lwivBupGPGrkh8o2IZtVViB3ccfjugIGQyE8bS0+ndnhA4tG7ImzfGsBRuLx+FDWCH5JOJzGgU4
        IMSne5gA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r0eSY-0005Dw-Hb; Wed, 08 Nov 2023 09:02:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id DC5ED30049D; Wed,  8 Nov 2023 10:02:50 +0100 (CET)
Date:   Wed, 8 Nov 2023 10:02:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 37/86] sched: make test_*_tsk_thread_flag() return
 bool
Message-ID: <20231108090250.GH8262@noisy.programming.kicks-ass.net>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-38-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107215742.363031-38-ankur.a.arora@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 01:57:23PM -0800, Ankur Arora wrote:
> All users of test_*_tsk_thread_flag() treat the result value
> as boolean. This is also true for the underlying test_and_*_bit()
> operations.
> 
> Change the return type to bool.
> 
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

You're sending 86 patches, I'm thinking you should do everything humanly
possible to reduce this patch count, so perhaps keep these in a separate
series.

This is irrelevant to the issue at hand. So send it as a separate
cleanup or whatever.

> ---
>  include/linux/sched.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 5f0d7341cb88..12d0626601a0 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2045,17 +2045,17 @@ static inline void update_tsk_thread_flag(struct task_struct *tsk, int flag,
>  	update_ti_thread_flag(task_thread_info(tsk), flag, value);
>  }
>  
> -static inline int test_and_set_tsk_thread_flag(struct task_struct *tsk, int flag)
> +static inline bool test_and_set_tsk_thread_flag(struct task_struct *tsk, int flag)
>  {
>  	return test_and_set_ti_thread_flag(task_thread_info(tsk), flag);
>  }
>  
> -static inline int test_and_clear_tsk_thread_flag(struct task_struct *tsk, int flag)
> +static inline bool test_and_clear_tsk_thread_flag(struct task_struct *tsk, int flag)
>  {
>  	return test_and_clear_ti_thread_flag(task_thread_info(tsk), flag);
>  }
>  
> -static inline int test_tsk_thread_flag(struct task_struct *tsk, int flag)
> +static inline bool test_tsk_thread_flag(struct task_struct *tsk, int flag)
>  {
>  	return test_ti_thread_flag(task_thread_info(tsk), flag);
>  }
> @@ -2070,7 +2070,7 @@ static inline void clear_tsk_need_resched(struct task_struct *tsk)
>  	clear_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
>  }
>  
> -static inline int test_tsk_need_resched(struct task_struct *tsk)
> +static inline bool test_tsk_need_resched(struct task_struct *tsk)
>  {
>  	return unlikely(test_tsk_thread_flag(tsk,TIF_NEED_RESCHED));
>  }
> -- 
> 2.31.1
> 
