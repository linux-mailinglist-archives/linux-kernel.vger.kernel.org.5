Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1BB7C8248
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjJMJiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjJMJiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:38:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A1ABE;
        Fri, 13 Oct 2023 02:38:10 -0700 (PDT)
Date:   Fri, 13 Oct 2023 09:38:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697189889;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yiCRTOM5demFgKTmq9X6OyvEhW+xoW8NeDS5lAX1ZC8=;
        b=B4TxUZhFgn3d8R9v0n23nZkl2xHSOF4MBY0JDIerWiZIqfkPoIrgVYgV56REH7dneMb9nD
        H0K3p/aO41YStXqJJlrWgOTovaPh9e0EMkM/elL9Ho9ATmLxPr0L7BpHQu3Uw7cf6ME/Kq
        TqqPcDA4FXZ0ibfT5LD0PayJkIEEFuY0+epISPiaOV/Lt0F1oHal/Ymjpt2OMB/wxJtM5F
        q6KaWQ4qKEGxwBZ+d8a9qLtkPunw3jJgOQyF4RNrc1QYtCYfWmvJ9We9LiSsyJZAe1z8NA
        FDL9zb2wgccAHzBw+qF+xxaMsoFznrorM4rWFUaJjTs4kNkOX8zDfahNkuDEfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697189889;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yiCRTOM5demFgKTmq9X6OyvEhW+xoW8NeDS5lAX1ZC8=;
        b=Ftvag4werfWiJJYLXBUwH2mwr88lQ2ZBPXtZElVVY0w8/yWDu9KT4OoMvdq7iLo1XNhvtM
        tXGr6You9+UQ2DBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cpu: Remove pointless evaluation of x86_coreid_bits
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230814085112.687588373@linutronix.de>
References: <20230814085112.687588373@linutronix.de>
MIME-Version: 1.0
Message-ID: <169718988888.3135.7116915738142139742.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     594957d723a0674ca15bfefb755b3403624b8239
Gitweb:        https://git.kernel.org/tip/594957d723a0674ca15bfefb755b3403624b8239
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 14 Aug 2023 10:18:36 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Oct 2023 14:38:18 +02:00

x86/cpu: Remove pointless evaluation of x86_coreid_bits

cpuinfo_x86::x86_coreid_bits is only used by the AMD numa topology code. No
point in evaluating it on non AMD systems.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Arjan van de Ven <arjan@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230814085112.687588373@linutronix.de

---
 arch/x86/kernel/cpu/intel.c   | 13 -------------
 arch/x86/kernel/cpu/zhaoxin.c | 14 --------------
 2 files changed, 27 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index be40456..55efadb 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -314,19 +314,6 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 		setup_clear_cpu_cap(X86_FEATURE_PGE);
 	}
 
-	if (c->cpuid_level >= 0x00000001) {
-		u32 eax, ebx, ecx, edx;
-
-		cpuid(0x00000001, &eax, &ebx, &ecx, &edx);
-		/*
-		 * If HTT (EDX[28]) is set EBX[16:23] contain the number of
-		 * apicids which are reserved per package. Store the resulting
-		 * shift value for the package management code.
-		 */
-		if (edx & (1U << 28))
-			c->x86_coreid_bits = get_count_order((ebx >> 16) & 0xff);
-	}
-
 	check_memory_type_self_snoop_errata(c);
 
 	/*
diff --git a/arch/x86/kernel/cpu/zhaoxin.c b/arch/x86/kernel/cpu/zhaoxin.c
index 05fa4ef..415564a 100644
--- a/arch/x86/kernel/cpu/zhaoxin.c
+++ b/arch/x86/kernel/cpu/zhaoxin.c
@@ -65,20 +65,6 @@ static void early_init_zhaoxin(struct cpuinfo_x86 *c)
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
 		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
 	}
-
-	if (c->cpuid_level >= 0x00000001) {
-		u32 eax, ebx, ecx, edx;
-
-		cpuid(0x00000001, &eax, &ebx, &ecx, &edx);
-		/*
-		 * If HTT (EDX[28]) is set EBX[16:23] contain the number of
-		 * apicids which are reserved per package. Store the resulting
-		 * shift value for the package management code.
-		 */
-		if (edx & (1U << 28))
-			c->x86_coreid_bits = get_count_order((ebx >> 16) & 0xff);
-	}
-
 }
 
 static void init_zhaoxin(struct cpuinfo_x86 *c)
