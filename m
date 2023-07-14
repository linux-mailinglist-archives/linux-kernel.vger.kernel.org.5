Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A704575364B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbjGNJUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGNJUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:20:44 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D931FC9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:20:43 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8B4295C014B;
        Fri, 14 Jul 2023 05:20:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 14 Jul 2023 05:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689326442; x=1689412842; bh=C
        UU0jwNG9bxZhQYjqoco/N3UYanNTl9IfLoCIygLPCE=; b=xRK0MFSg0Tfd+UPh3
        4sIYWeLJseBMTisLDxwbOuuZQ/noP2ZL4gDS2XV1fRf1lwRSqOwWLgAaA2BcO96J
        QGUHo0liV2TsPNY0eQBM7q2kKCxvldR/vwYXoIUJek3CmJ1ZIOdV7FBwpAL+pmua
        i4HAAMw8jyGLoF9UJXt/QdWPTaaM0kDiEAORz/maOoGfnlmdf7MhCk25CSoJ1NoX
        XXj1uXhmBqXsGaFfGqK/Pmgmq2AMiTtZ+BNa/WUfyuyfa7eAgdOPuOdpOyA/GBS+
        NooZYXQ4TDmp1x8g8V9GJydBZMCWG4FqSwUcyc7ITUlyI56G5j64OQXs+cA4t3pZ
        zrv8g==
X-ME-Sender: <xms:aROxZHHvnklftP8I_ct3rlmHfO8RXJbxdXpvPJz4F67mh1sXuR_XHA>
    <xme:aROxZEWV7SU9M7ZEaxfSRv9zj2M0LFs00o7WxknaiVYu0Wdq6khvcPQW3tlA6IFzr
    3eSfM_ujld8jW3w98o>
X-ME-Received: <xmr:aROxZJLkQAMauiR5nLoLp2LLMvxVaLHbhbnFB5euTLtRGjHGlVSkPG4cyMFqiqW2cOhjGdkJ80XsSdCqAOlkHZvK0tZCl4fLUhU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeeigddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefvvefkhffuffestddtredttddttdenucfhrhhomhephfhinhhnucfvhhgrihhn
    uceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvghrnh
    epheffgfegfeevgeevtdeiffefveeutdeghfeuheeiteffjeefgfegveefuedvudelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgrih
    hnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:aROxZFHqd0c0Co27g9g4n8QIhJXa4lVMkCl69gggIUC6Ob8rW9xOaw>
    <xmx:aROxZNVOg6eS98FSeo2KCtJRgSyxcspxQPXOZLCwRmgi1sQBrFVWXA>
    <xmx:aROxZAOL_i7NYYfeVUCvW-EJDE8VEkMGHFsDAIjoMsMY1vZyXzua8w>
    <xmx:ahOxZGNA37d1u9YkjuMBA_VY_FteU5NdAaLtfuN5AI2kaUQmLL1qTw>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jul 2023 05:20:38 -0400 (EDT)
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
Message-Id: <44ad7a7afa1b8b1383426971402d2901361db1c5.1689326311.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] sched: Optimize in_task() and in_interrupt() a bit
Date:   Fri, 14 Jul 2023 19:18:31 +1000
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
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
perhaps because the compiler is free to perform similar optimizations.

Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 15115830c887 ("preempt: Cleanup the macro maze a bit")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
This patch was tested on m68k and x86. I was expecting no changes
to object code for x86 and mostly that's what I saw. However, there
were a few places where code generation was perturbed for some reason.
---
 include/linux/preempt.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 0df425bf9bd7..953358e40291 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -102,10 +102,11 @@ static __always_inline unsigned char interrupt_context_level(void)
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
@@ -118,7 +119,11 @@ static __always_inline unsigned char interrupt_context_level(void)
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

