Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170BC7A15BB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 07:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjIOFuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 01:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjIOFus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 01:50:48 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720DFE6E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 22:50:42 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 848D0320090A;
        Fri, 15 Sep 2023 01:50:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 15 Sep 2023 01:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1694757039; x=1694843439; bh=f
        nt/1tGrYIgmAtZpbfYmp72DSY85xbo7uKz4JIoG494=; b=qP/ND55O2ZecjYJ+c
        oKrpXHwsafuUjtxX4PyCv4Kvr8mm9Zilv7M/hvwbNH0vTnWLT+hgvf7FGec91Q0j
        1XonXEpRany07WDdEobTX6TN6LXK0yyUS3TkSSrG+HOn71cu9H9u68dPBiQvZc7y
        SDifra8rcCiiwTwNcbAJFYTneBFWWHn9YWrNzxzBkbzHUEQ6GsXF7sl+q2XQExJU
        klxoBMXKbu6mcnEoTEeJy5zsswi5q5OT9JOrP8h0PEt/JkEz/6S1X2rIZv+J03J9
        hGyhpX/5H6mrpEgY9U+JZqFb5JiXjzhnSP9jD5PceCD4JiTpS6zb/BPQTT9KrWrv
        0bAkA==
X-ME-Sender: <xms:r_ADZby_DwQOIpx4LnnxXRB0oHAQUjP13yVdd1krUZ6oKSNmHrA_uQ>
    <xme:r_ADZTSnPfJfDUrHirGPJk6YPhw_znxUxGZn2Z39TDig5wVudFCWBQcVVQ2ZC9Ht-
    RhtwPOMhWhw7_pkHJ4>
X-ME-Received: <xmr:r_ADZVVBybsiOZk_y9e6Hx40gGzMAR4xipxC9mxIvWPZcALvrnhZWU_YMphH-sZbol4KAyaQxNA8AFLbadSoSOIVNWwc11_sufQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejuddgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvfevkffhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghi
    nhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrh
    hnpeehfffggeefveegvedtiefffeevuedtgefhueehieetffejfefggeevfeeuvdduleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrg
    hinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:r_ADZVibovp8npQQdpoHn_1syD0bS_WL8q7RBBGNvjTDn2prVe5-Dw>
    <xmx:r_ADZdD4MJBniEolXMP2m8YFj-jHsgkuEjglBdQxbMCN7bRyxoNO9Q>
    <xmx:r_ADZeJsC6UA1p8coihUUyzhWysbWzwji3WfETK79PhmbJ1Ie6oL5Q>
    <xmx:r_ADZR5fB0129KZ0zynGwndWrmDR3m2WO8LVALhgLu20UxyC5ac-hA>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Sep 2023 01:50:36 -0400 (EDT)
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Message-Id: <0a403120a682a525e6db2d81d1a3ffcc137c3742.1694756831.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] sched: Optimize in_task() and in_interrupt() a bit
Date:   Fri, 15 Sep 2023 15:47:11 +1000
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Except on x86, preempt_count is always accessed with READ_ONCE.
Repeated invocations in macros like irq_count() produce repeated loads.
These redundant instructions appear in various fast paths. In the one
shown below, for example, irq_count() is evaluated during kernel entry
if !tick_nohz_full_cpu(smp_processor_id()).

0001ed0a <irq_enter_rcu>:
   1ed0a:       4e56 0000       linkw %fp,#0
   1ed0e:       200f            movel %sp,%d0
   1ed10:       0280 ffff e000  andil #-8192,%d0
   1ed16:       2040            moveal %d0,%a0
   1ed18:       2028 0008       movel %a0@(8),%d0
   1ed1c:       0680 0001 0000  addil #65536,%d0
   1ed22:       2140 0008       movel %d0,%a0@(8)
   1ed26:       082a 0001 000f  btst #1,%a2@(15)
   1ed2c:       670c            beqs 1ed3a <irq_enter_rcu+0x30>
   1ed2e:       2028 0008       movel %a0@(8),%d0
   1ed32:       2028 0008       movel %a0@(8),%d0
   1ed36:       2028 0008       movel %a0@(8),%d0
   1ed3a:       4e5e            unlk %fp
   1ed3c:       4e75            rts

This patch doesn't prevent the pointless btst and beqs instructions
above, but it does eliminate 2 of the 3 pointless move instructions
here and elsewhere.

On x86, preempt_count is per-cpu data and the problem does not arise
presumably because the compiler is free to optimize more effectively.

Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 15115830c887 ("preempt: Cleanup the macro maze a bit")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
This patch was tested on m68k and x86. I was expecting no changes
to object code for x86 and mostly that's what I saw. However, there
were a few places where code generation was perturbed for some reason.

The performance issue addressed here is minor on uniprocessor m68k. I
got a 0.01% improvement from this patch for a simple "find /sys -false"
benchmark. For architectures and workloads susceptible to cache line bounce
the improvement is expected to be larger. The only SMP architecture I have
is x86, and as x86 unaffected I have not done any further measurements.

Changed since v2:
 - Clarify the comment about macros.

Changed since v1:
 - Added a comment that was requested by Frederic.
---
 include/linux/preempt.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 1424670df161..9aa6358a1a16 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -99,14 +99,21 @@ static __always_inline unsigned char interrupt_context_level(void)
 	return level;
 }
 
+/*
+ * These macro definitions avoid redundant invocations of preempt_count()
+ * because such invocations would result in redundant loads given that
+ * preempt_count() is commonly implemented with READ_ONCE().
+ */
+
 #define nmi_count()	(preempt_count() & NMI_MASK)
 #define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
 #ifdef CONFIG_PREEMPT_RT
 # define softirq_count()	(current->softirq_disable_cnt & SOFTIRQ_MASK)
+# define irq_count()		((preempt_count() & (NMI_MASK | HARDIRQ_MASK)) | softirq_count())
 #else
 # define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
+# define irq_count()		(preempt_count() & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_MASK))
 #endif
-#define irq_count()	(nmi_count() | hardirq_count() | softirq_count())
 
 /*
  * Macros to retrieve the current execution context:
@@ -119,7 +126,11 @@ static __always_inline unsigned char interrupt_context_level(void)
 #define in_nmi()		(nmi_count())
 #define in_hardirq()		(hardirq_count())
 #define in_serving_softirq()	(softirq_count() & SOFTIRQ_OFFSET)
-#define in_task()		(!(in_nmi() | in_hardirq() | in_serving_softirq()))
+#ifdef CONFIG_PREEMPT_RT
+# define in_task()		(!((preempt_count() & (NMI_MASK | HARDIRQ_MASK)) | in_serving_softirq()))
+#else
+# define in_task()		(!(preempt_count() & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
+#endif
 
 /*
  * The following macros are deprecated and should not be used in new code:
-- 
2.39.3

