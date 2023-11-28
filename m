Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2BA7FC151
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346691AbjK1PN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345995AbjK1PN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:13:57 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF992D49
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:14:03 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-549070a04baso7553658a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701184442; x=1701789242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=46tcgfy6lnmrLL8kkdcy+Z6fG3y3/u6FFjLbf+5xvvU=;
        b=Jr9jgrzHmYN8ICC6kAR24ShnPSFpJoYruS0tI0qNimKMlW5PDKRHTY68dPd72tfRg/
         y9HQT84+tSdLfjrmGnfC/7da6XHsiK4/8pzNTBEfL6n7YbB5ee7L6IULqpt9VyWKESYN
         uSH85mVOTB2wRL7S8fegLNpdq0nVEc74mrV4S/elt1gaCVKncdi9s4CwYsCST2ZImLEw
         kw0DUNEqvROnOjqUZLnh1desEaCuT2Zb4bnH4ague94T7HapQHYRnD1r97LDnOwp6wW4
         0yyboSV4XSEpivbAXR0bx8Gpsd6zFkztO5auoc4puelux9wI9ApnJ8tZmmuslO2W8tCu
         HXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701184442; x=1701789242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46tcgfy6lnmrLL8kkdcy+Z6fG3y3/u6FFjLbf+5xvvU=;
        b=ONFNUftgFFqz/FB9HiT+0X+xi4ShQt3VS7jHj09pOsORZ32JggB3bLHt9y0u5zINl8
         uzb4UwZXNOuzSe+I5cY/UpYe9xF80fmuxMFbPw0SUHPaTcNlgQH7KYML6KjJ+SA5vKMA
         HxCFXiBqHT3JdzScOtin2YMJYirrNkLHFnS7Vg1bYiGJ22X/WFqAH+TVD3pRVDdFl9VI
         B1lX2fSCimqRR7jIIiUHB9Kbzomv3LCtq0MGWlvDvKc5XFpehtdZzI5aDGLufiO2cb0d
         mOu47ERnbeEMv2t77Awka9sJRu3wTSjzAeTCpYvgdZqitPD3ookGBEXoKjpHSf/268qc
         ZLJQ==
X-Gm-Message-State: AOJu0Yyc76UGqSqUGYONia136Z6h+7iMUyFmAu2sOWkGLowrxQwuT+c3
        OPEtwmkDzx86nNa3TjSPAR4=
X-Google-Smtp-Source: AGHT+IFbUScR/k5tl/U453JuBeHhEOnSud8Dr0NLfnh4zrPWNsGB250PbuA0m/cUFhgT753SiZSsfQ==
X-Received: by 2002:a17:906:7396:b0:a10:f9a8:bfe1 with SMTP id f22-20020a170906739600b00a10f9a8bfe1mr3397704ejl.16.1701184441892;
        Tue, 28 Nov 2023 07:14:01 -0800 (PST)
Received: from andrea ([31.189.63.178])
        by smtp.gmail.com with ESMTPSA id bq23-20020a170906d0d700b00a0d02cfa48bsm3551751ejb.213.2023.11.28.07.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 07:14:01 -0800 (PST)
Date:   Tue, 28 Nov 2023 16:13:56 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     paulmck@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, mmaas@google.com, hboehm@google.com,
        striker@us.ibm.com, charlie@rivosinc.com, rehn@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] membarrier: riscv: Provide core serializing command
Message-ID: <ZWYDtB/otYvTMZWd@andrea>
References: <20231127103235.28442-1-parri.andrea@gmail.com>
 <20231127103235.28442-3-parri.andrea@gmail.com>
 <91ab0210-07f9-42c4-af7f-a98799250cf7@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91ab0210-07f9-42c4-af7f-a98799250cf7@efficios.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I am concerned about the possibility that this change lacks two barriers in the
> following scenario:
> 
> On a transition from uthread -> uthread on [CPU 0], from a thread belonging to
> another mm to a thread belonging to the mm [!mm -> mm] for which a concurrent
> membarrier sync-core is done on [CPU 1]:
> 
> - [CPU 1] sets all bits in the mm icache_stale_mask [A]. There are no barriers
>   associated with these stores.
> 
> - [CPU 0] store to rq->curr [B] (by the scheduler) vs [CPU 1] loads rq->curr [C]
>   within membarrier to decide if the IPI should be skipped. Let's say CPU 1 observes
>   cpu_rq(0)->curr->mm != mm, so it skips the IPI.
> 
> - This means membarrier relies on switch_mm() to issue the sync-core.
> 
> - [CPU 0] switch_mm() loads [D] the icache_stale_mask. If the bit is zero, switch_mm()
>   may incorrectly skip the sync-core.
> 
> AFAIU, [C] can be reordered before [A] because there is no barrier between those
> operations within membarrier. I suspect it can cause the switch_mm() code to skip
> a needed sync-core.
> 
> AFAIU, [D] can be reordered before [B] because there is no documented barrier
> between those operations within the scheduler, which can also cause switch_mm()
> to skip a needed sync-core.
> 
> We possibly have a similar scenario for uthread->uthread when the scheduler
> switches between mm -> !mm.
> 
> One way to fix this would be to add the following barriers:
> 
> - A smp_mb() between [A] and [C], possibly just after cpumask_setall() in
>   prepare_sync_core_cmd(), with comments detailing the ordering it guarantees,
> - A smp_mb() between [B] and [D], possibly just before cpumask_test_cpu() in
>   flush_icache_deferred(), with appropriate comments.
> 
> Am I missing something ?

Thanks for the detailed analysis.

AFAIU, the following barrier (in membarrier_private_expedited())

	/*
	 * Matches memory barriers around rq->curr modification in
	 * scheduler.
	 */
	smp_mb();	/* system call entry is not a mb. */

can serve the purpose of ordering [A] before [C] (to be documented in v2).

But I agree that [B] and [D] are unordered /missing suitable synchronization.
Worse, RISC-V has currently no full barrier after [B] and before returning to
user-space: I'm thinking (inspired by the PowerPC implementation),

diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 217fd4de61342..f63222513076d 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -323,6 +323,23 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	if (unlikely(prev == next))
 		return;
 
+#if defined(CONFIG_MEMBARRIER) && defined(CONFIG_SMP)
+	/*
+	 * The membarrier system call requires a full memory barrier
+	 * after storing to rq->curr, before going back to user-space.
+	 *
+	 * Only need the full barrier when switching between processes:
+	 * barrier when switching from kernel to userspace is not
+	 * required here, given that it is implied by mmdrop(); barrier
+	 * when switching from userspace to kernel is not needed after
+	 * store to rq->curr.
+	 */
+	if (unlikely(atomic_read(&next->membarrier_state) &
+		     (MEMBARRIER_STATE_PRIVATE_EXPEDITED |
+		      MEMBARRIER_STATE_GLOBAL_EXPEDITED)) && prev)
+		smp_mb();
+#endif
+
 	/*
 	 * Mark the current MM context as inactive, and the next as
 	 * active.  This is at least used by the icache flushing
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a708d225c28e8..a1c749fddd095 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6670,8 +6670,9 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		 *
 		 * Here are the schemes providing that barrier on the
 		 * various architectures:
-		 * - mm ? switch_mm() : mmdrop() for x86, s390, sparc, PowerPC.
-		 *   switch_mm() rely on membarrier_arch_switch_mm() on PowerPC.
+		 * - mm ? switch_mm() : mmdrop() for x86, s390, sparc, PowerPC,
+		 *   RISC-V.  switch_mm() relies on membarrier_arch_switch_mm()
+		 *   on PowerPC.
 		 * - finish_lock_switch() for weakly-ordered
 		 *   architectures where spin_unlock is a full barrier,
 		 * - switch_to() for arm64 (weakly-ordered, spin_unlock

The silver lining is that similar changes (probably as a separate/preliminary
patch) also restore the desired order between [B] and [D] AFAIU; so with them,
2/2 would just need additions to document the above SYNC_CORE scenario.

Thoughts?

  Andrea
