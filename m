Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B6775712F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 03:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjGRBDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 21:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjGRBDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 21:03:34 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E405695
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 18:03:32 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id A64F15C019B;
        Mon, 17 Jul 2023 21:03:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 17 Jul 2023 21:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689642208; x=1689728608; bh=k
        MkiwW1YZ5sB+UDs0gfnkYhphzsmIRLkHogP74cDU/o=; b=Rg+K0GO9qaEKmeh7v
        aK1WZg3Um0FfuBs7apkhzLcGjA588KOI/5/1kjCvqjpclz2T0DWFSsz+xjSOXCHd
        yXT/tPg0ctjyFpF+GAc0dqDYaBdPHStMFYE4Bel1H2r6tsEP3RCWnOuPlQer9ZsP
        bkKbBs9SZ/fPUsXp8V7nsEz3OGn2Hiq5DBalCVr5TxKXMMgMQRHPT4TIZnoWAqMy
        uLLhZbM4ms7+dtnwzwZ+NAj/k0/leabtvTVMU3lKFNspw0ybCEHDanuW0xBhzq9i
        A5RyuSBH4NiRdGb3kdO74AANr4FWmYVxUp+yNza0/Cq6tQEV8ip4sMlW7Dt9ubia
        +mzCg==
X-ME-Sender: <xms:4OS1ZCWExhPcjsWFbI2b3x_OxJO_1gnDPtQ18k6_iAkyOqGIMLVfOA>
    <xme:4OS1ZOmdUfY93MPs7xkfsJl1bd_GCl3LD1LsZRj4eNpw36P6WI_EMxdwqL0pPaDQ0
    f5ONmUbCeKa8zchAco>
X-ME-Received: <xmr:4OS1ZGbqy8wUs_alxVr97hRazzTX_Jb-jw0dIUQGbwzzJTfm-xtRWQzVtADAA5duljCSOaf1FUJ7AF6BBgzZJ8L9a-JioaBPpWo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgeefgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefvvefkhffuffestddtredttddttdenucfhrhhomhephfhinhhnucfvhhgrihhn
    uceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvghrnh
    epheffgfegfeevgeevtdeiffefveeutdeghfeuheeiteffjeefgfegveefuedvudelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgrih
    hnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:4OS1ZJXdVTZB1sHZmOh4TSxtS16svpBu0TOBnaIEHY5pctgF4R5sPw>
    <xmx:4OS1ZMn6Qv8W3bLMTulrm-LF1n65n6Tn56AGmrK_kO7cBEAX_oZdCw>
    <xmx:4OS1ZOf5B92jvieoNUBf9x54y6thgtJOrLdqygu_2Rt6CxPvMEszhw>
    <xmx:4OS1ZFfRcekH-pFD7iaGHrjuRs8jpqpncT0Mq1-HYCgNaSwIQ-3p9w>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jul 2023 21:03:25 -0400 (EDT)
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
Message-Id: <453f675efb082e08068736bf69293d48ff3129a7.1689641959.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2] sched: Optimize in_task() and in_interrupt() a bit
Date:   Tue, 18 Jul 2023 10:59:19 +1000
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Changed since v1:
 - Added a comment that was requested by Frederic.
---
 include/linux/preempt.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 1424670df161..d2ac07abf225 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -99,14 +99,21 @@ static __always_inline unsigned char interrupt_context_level(void)
 	return level;
 }
 
+/*
+ * Redundant invocations of preempt_count() are to be avoided because that
+ * function is commonly implemented using READ_ONCE. Hence, the optimal
+ * definition of irq_count() or in_task() depends on CONFIG_PREEMPT_RT.
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

