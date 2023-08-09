Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE707763E6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbjHIPez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbjHIPeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:34:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D062123;
        Wed,  9 Aug 2023 08:34:19 -0700 (PDT)
Date:   Wed, 09 Aug 2023 15:34:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691595258;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=7WLjK7Yg9wW5u1AyXcR+mCr1djAbYnFeTAfl83mdAAg=;
        b=tM0s10kHRdClLa2hqDylLoGIdkKH6GkQfghA2jIA8O5tnO+3iY7IeHywaj0L5RMTJ3Bq43
        kTTJMjeNpTSFjtA7B3WS2OfbH8hxYGh5CAG3CsqdomRa2rGl3iWhXHAfUwOcDdagmCD03f
        b/SCe4/fHgYj99kVm7vgF3MkYzjKNsqKkatS7tk57OPT4Au5W+I6wNy0XVGUvykrJxlifS
        rW6byhD6Pn7OvmwqYzoGaJcgmFGcmmbFHEP3kQrDFu3ovj4GdlF3p0YoqMVzo+5Alk16aU
        6mMxp5uTFTyonSGxsrBtm7jOwGach5emuXB8TJX+Fppr/vFeZ6HWhUzL6PEMPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691595258;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=7WLjK7Yg9wW5u1AyXcR+mCr1djAbYnFeTAfl83mdAAg=;
        b=kGs80ltmFe2JfnROTNG7GHFe2sSTxwaJyC55qcDrT9CbEInGoR5hBW7G/o5HJaP32XSb3X
        RqVReGUjcuzXdbDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Nuke unused apic::inquire_remote_apic()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169159525741.27769.16927967118711564659.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     66feb6e02108223623fd28307102d5a575e2c036
Gitweb:        https://git.kernel.org/tip/66feb6e02108223623fd28307102d5a575e2c036
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:44 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 08:10:10 -07:00

x86/apic: Nuke unused apic::inquire_remote_apic()

Put it to the other historical leftovers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/apic.h           | 16 +-----------
 arch/x86/kernel/apic/apic_flat_64.c   |  4 +---
 arch/x86/kernel/apic/apic_noop.c      |  2 +-
 arch/x86/kernel/apic/apic_numachip.c  |  2 +-
 arch/x86/kernel/apic/bigsmp_32.c      |  2 +-
 arch/x86/kernel/apic/probe_32.c       |  2 +-
 arch/x86/kernel/apic/x2apic_cluster.c |  2 +-
 arch/x86/kernel/apic/x2apic_phys.c    |  2 +-
 arch/x86/kernel/apic/x2apic_uv_x.c    |  1 +-
 arch/x86/kernel/smpboot.c             | 38 +--------------------------
 arch/x86/xen/apic.c                   |  7 +-----
 11 files changed, 78 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index b591040..47bedb8 100644
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
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index 8f72b43..35cd1cb 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -139,8 +139,6 @@ static struct apic apic_flat __ro_after_init = {
 	.send_IPI_all			= default_send_IPI_all,
 	.send_IPI_self			= default_send_IPI_self,
 
-	.inquire_remote_apic		= default_inquire_remote_apic,
-
 	.read				= native_apic_mem_read,
 	.write				= native_apic_mem_write,
 	.eoi_write			= native_apic_mem_write,
@@ -230,8 +228,6 @@ static struct apic apic_physflat __ro_after_init = {
 	.send_IPI_all			= default_send_IPI_all,
 	.send_IPI_self			= default_send_IPI_self,
 
-	.inquire_remote_apic		= default_inquire_remote_apic,
-
 	.read				= native_apic_mem_read,
 	.write				= native_apic_mem_write,
 	.eoi_write			= native_apic_mem_write,
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index f310dc2..90bf11e 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -125,8 +125,6 @@ struct apic apic_noop __ro_after_init = {
 
 	.wakeup_secondary_cpu		= noop_wakeup_secondary_cpu,
 
-	.inquire_remote_apic		= NULL,
-
 	.read				= noop_apic_read,
 	.write				= noop_apic_write,
 	.eoi_write			= noop_apic_write,
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index a54d817..b6bbd7d 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -273,7 +273,6 @@ static const struct apic apic_numachip1 __refconst = {
 	.send_IPI_self			= numachip_send_IPI_self,
 
 	.wakeup_secondary_cpu		= numachip_wakeup_secondary,
-	.inquire_remote_apic		= NULL, /* REMRD not supported */
 
 	.read				= native_apic_mem_read,
 	.write				= native_apic_mem_write,
@@ -320,7 +319,6 @@ static const struct apic apic_numachip2 __refconst = {
 	.send_IPI_self			= numachip_send_IPI_self,
 
 	.wakeup_secondary_cpu		= numachip_wakeup_secondary,
-	.inquire_remote_apic		= NULL, /* REMRD not supported */
 
 	.read				= native_apic_mem_read,
 	.write				= native_apic_mem_write,
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index 628b008..9e254dc 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -153,8 +153,6 @@ static struct apic apic_bigsmp __ro_after_init = {
 	.send_IPI_all			= bigsmp_send_IPI_all,
 	.send_IPI_self			= default_send_IPI_self,
 
-	.inquire_remote_apic		= default_inquire_remote_apic,
-
 	.read				= native_apic_mem_read,
 	.write				= native_apic_mem_write,
 	.eoi_write			= native_apic_mem_write,
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index a61f642..8d1e456 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -95,8 +95,6 @@ static struct apic apic_default __ro_after_init = {
 	.send_IPI_all			= default_send_IPI_all,
 	.send_IPI_self			= default_send_IPI_self,
 
-	.inquire_remote_apic		= default_inquire_remote_apic,
-
 	.read				= native_apic_mem_read,
 	.write				= native_apic_mem_write,
 	.eoi_write			= native_apic_mem_write,
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index b2b2b7f..ce1021c 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -265,8 +265,6 @@ static struct apic apic_x2apic_cluster __ro_after_init = {
 	.send_IPI_all			= x2apic_send_IPI_all,
 	.send_IPI_self			= x2apic_send_IPI_self,
 
-	.inquire_remote_apic		= NULL,
-
 	.read				= native_apic_msr_read,
 	.write				= native_apic_msr_write,
 	.eoi_write			= native_apic_msr_eoi_write,
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index 896bc41..07bddaa 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -189,8 +189,6 @@ static struct apic apic_x2apic_phys __ro_after_init = {
 	.send_IPI_all			= x2apic_send_IPI_all,
 	.send_IPI_self			= x2apic_send_IPI_self,
 
-	.inquire_remote_apic		= NULL,
-
 	.read				= native_apic_msr_read,
 	.write				= native_apic_msr_write,
 	.eoi_write			= native_apic_msr_eoi_write,
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index d9384d5..0e23e41 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -862,7 +862,6 @@ static struct apic apic_x2apic_uv_x __ro_after_init = {
 	.send_IPI_self			= uv_send_IPI_self,
 
 	.wakeup_secondary_cpu		= uv_wakeup_secondary,
-	.inquire_remote_apic		= NULL,
 
 	.read				= native_apic_msr_read,
 	.write				= native_apic_msr_write,
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 8229f41..a33fc50 100644
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
diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index 62d34b6..a5428d9 100644
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
