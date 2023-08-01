Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04E076B22B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjHAKrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbjHAKrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:47:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D411B10EA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:46:52 -0700 (PDT)
Message-ID: <20230801103815.594484824@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=42hY1z4hgQj4e7JMNLbJLEjJil1FgDJ29QawyO0o/c8=;
        b=DGfxz/XwNF1TjVBkm83bQ4JMe+Yrj/tTfWT53I1twvCcdDyyZQxrYS9GnvoJ12+1MSKCKj
        +VkgQvRiyhRUP/CFeQUJ5qPVQK3tCuRieOL3OpA7m/ntQXI0NQT5uzoDG0B5eLDGOOK46L
        6pAswuFO66FFRCFCWM4cWMHbA4BUWHKF8d0jU+18OeiYWDUKltnCrXipCnpMO4RV0Bd8jo
        mvGSlJZjCuIx+FIDQNIpFlDrrA6epyf4L4KMFswyyZqUcgcLfPzjDmJbNSqPOAaQXNGRLv
        hBMETY1k0ceTyS0t9UxWu0C9RjNQ1C/3ohsQPrxkde+okRcPa1chnHvny8Bkwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=42hY1z4hgQj4e7JMNLbJLEjJil1FgDJ29QawyO0o/c8=;
        b=qCCpaewM5kRjpA4xmM/X6nOsm+VFDINc10R/9fcCOhTjFYug7cKgNuWKG0DD/9SXQAvRpQ
        OXhVPvAFUhK8iKAw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V3 08/60] x86/apic: Nuke unused apic::inquire_remote_apic()
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:46:51 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put it to the other historical leftovers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/apic.h           |   16 --------------
 arch/x86/kernel/apic/apic_flat_64.c   |    4 ---
 arch/x86/kernel/apic/apic_noop.c      |    2 -
 arch/x86/kernel/apic/apic_numachip.c  |    2 -
 arch/x86/kernel/apic/bigsmp_32.c      |    2 -
 arch/x86/kernel/apic/probe_32.c       |    2 -
 arch/x86/kernel/apic/x2apic_cluster.c |    2 -
 arch/x86/kernel/apic/x2apic_phys.c    |    2 -
 arch/x86/kernel/apic/x2apic_uv_x.c    |    1 
 arch/x86/kernel/smpboot.c             |   38 ----------------------------------
 arch/x86/xen/apic.c                   |    7 ------
 11 files changed, 78 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -66,20 +66,6 @@ enum apic_intr_mode_id {
 	APIC_SYMMETRIC_IO_NO_ROUTING
 };
 
-#ifdef CONFIG_SMP
-extern void __inquire_remote_apic(int apicid);
-#else /* CONFIG_SMP */
-static inline void __inquire_remote_apic(int apicid)
-{
-}
-#endif /* CONFIG_SMP */
-
-static inline void default_inquire_remote_apic(int apicid)
-{
-	if (apic_verbosity >= APIC_DEBUG)
-		__inquire_remote_apic(apicid);
-}
-
 /*
  * With 82489DX we can't rely on apic feature bit
  * retrieved via cpuid but still have to deal with
@@ -330,8 +316,6 @@ struct apic {
 	/* wakeup secondary CPU using 64-bit wakeup point */
 	int	(*wakeup_secondary_cpu_64)(int apicid, unsigned long start_eip);
 
-	void	(*inquire_remote_apic)(int apicid);
-
 #ifdef CONFIG_X86_32
 	/*
 	 * Called very early during boot from get_smp_config().  It should
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -139,8 +139,6 @@ static struct apic apic_flat __ro_after_
 	.send_IPI_all			= default_send_IPI_all,
 	.send_IPI_self			= default_send_IPI_self,
 
-	.inquire_remote_apic		= default_inquire_remote_apic,
-
 	.read				= native_apic_mem_read,
 	.write				= native_apic_mem_write,
 	.eoi_write			= native_apic_mem_write,
@@ -230,8 +228,6 @@ static struct apic apic_physflat __ro_af
 	.send_IPI_all			= default_send_IPI_all,
 	.send_IPI_self			= default_send_IPI_self,
 
-	.inquire_remote_apic		= default_inquire_remote_apic,
-
 	.read				= native_apic_mem_read,
 	.write				= native_apic_mem_write,
 	.eoi_write			= native_apic_mem_write,
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -125,8 +125,6 @@ struct apic apic_noop __ro_after_init =
 
 	.wakeup_secondary_cpu		= noop_wakeup_secondary_cpu,
 
-	.inquire_remote_apic		= NULL,
-
 	.read				= noop_apic_read,
 	.write				= noop_apic_write,
 	.eoi_write			= noop_apic_write,
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -273,7 +273,6 @@ static const struct apic apic_numachip1
 	.send_IPI_self			= numachip_send_IPI_self,
 
 	.wakeup_secondary_cpu		= numachip_wakeup_secondary,
-	.inquire_remote_apic		= NULL, /* REMRD not supported */
 
 	.read				= native_apic_mem_read,
 	.write				= native_apic_mem_write,
@@ -320,7 +319,6 @@ static const struct apic apic_numachip2
 	.send_IPI_self			= numachip_send_IPI_self,
 
 	.wakeup_secondary_cpu		= numachip_wakeup_secondary,
-	.inquire_remote_apic		= NULL, /* REMRD not supported */
 
 	.read				= native_apic_mem_read,
 	.write				= native_apic_mem_write,
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -153,8 +153,6 @@ static struct apic apic_bigsmp __ro_afte
 	.send_IPI_all			= bigsmp_send_IPI_all,
 	.send_IPI_self			= default_send_IPI_self,
 
-	.inquire_remote_apic		= default_inquire_remote_apic,
-
 	.read				= native_apic_mem_read,
 	.write				= native_apic_mem_write,
 	.eoi_write			= native_apic_mem_write,
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -95,8 +95,6 @@ static struct apic apic_default __ro_aft
 	.send_IPI_all			= default_send_IPI_all,
 	.send_IPI_self			= default_send_IPI_self,
 
-	.inquire_remote_apic		= default_inquire_remote_apic,
-
 	.read				= native_apic_mem_read,
 	.write				= native_apic_mem_write,
 	.eoi_write			= native_apic_mem_write,
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -265,8 +265,6 @@ static struct apic apic_x2apic_cluster _
 	.send_IPI_all			= x2apic_send_IPI_all,
 	.send_IPI_self			= x2apic_send_IPI_self,
 
-	.inquire_remote_apic		= NULL,
-
 	.read				= native_apic_msr_read,
 	.write				= native_apic_msr_write,
 	.eoi_write			= native_apic_msr_eoi_write,
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -189,8 +189,6 @@ static struct apic apic_x2apic_phys __ro
 	.send_IPI_all			= x2apic_send_IPI_all,
 	.send_IPI_self			= x2apic_send_IPI_self,
 
-	.inquire_remote_apic		= NULL,
-
 	.read				= native_apic_msr_read,
 	.write				= native_apic_msr_write,
 	.eoi_write			= native_apic_msr_eoi_write,
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -862,7 +862,6 @@ static struct apic apic_x2apic_uv_x __ro
 	.send_IPI_self			= uv_send_IPI_self,
 
 	.wakeup_secondary_cpu		= uv_wakeup_secondary,
-	.inquire_remote_apic		= NULL,
 
 	.read				= native_apic_msr_read,
 	.write				= native_apic_msr_write,
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -774,44 +774,6 @@ static void impress_friends(void)
 	pr_debug("Before bogocount - setting activated=1\n");
 }
 
-void __inquire_remote_apic(int apicid)
-{
-	unsigned i, regs[] = { APIC_ID >> 4, APIC_LVR >> 4, APIC_SPIV >> 4 };
-	const char * const names[] = { "ID", "VERSION", "SPIV" };
-	int timeout;
-	u32 status;
-
-	pr_info("Inquiring remote APIC 0x%x...\n", apicid);
-
-	for (i = 0; i < ARRAY_SIZE(regs); i++) {
-		pr_info("... APIC 0x%x %s: ", apicid, names[i]);
-
-		/*
-		 * Wait for idle.
-		 */
-		status = safe_apic_wait_icr_idle();
-		if (status)
-			pr_cont("a previous APIC delivery may have failed\n");
-
-		apic_icr_write(APIC_DM_REMRD | regs[i], apicid);
-
-		timeout = 0;
-		do {
-			udelay(100);
-			status = apic_read(APIC_ICR) & APIC_ICR_RR_MASK;
-		} while (status == APIC_ICR_RR_INPROG && timeout++ < 1000);
-
-		switch (status) {
-		case APIC_ICR_RR_VALID:
-			status = apic_read(APIC_RRR);
-			pr_cont("%08x\n", status);
-			break;
-		default:
-			pr_cont("failed\n");
-		}
-	}
-}
-
 /*
  * The Multiprocessor Specification 1.4 (1997) example code suggests
  * that there should be a 10ms delay between the BSP asserting INIT
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -129,10 +129,6 @@ static void xen_noop(void)
 {
 }
 
-static void xen_silent_inquire(int apicid)
-{
-}
-
 static int xen_cpu_present_to_apicid(int cpu)
 {
 	if (cpu_present(cpu))
@@ -173,9 +169,6 @@ static struct apic xen_pv_apic = {
 	.send_IPI_all 			= xen_send_IPI_all,
 	.send_IPI_self 			= xen_send_IPI_self,
 #endif
-	/* .wait_for_init_deassert- used  by AP bootup - smp_callin which we don't use */
-	.inquire_remote_apic		= xen_silent_inquire,
-
 	.read				= xen_apic_read,
 	.write				= xen_apic_write,
 	.eoi_write			= xen_apic_write,

