Return-Path: <linux-kernel+bounces-44924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAEA84291F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837F828625F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B94E1272D4;
	Tue, 30 Jan 2024 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pMPsn8SW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gCPR+LmA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07811292D9;
	Tue, 30 Jan 2024 16:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631964; cv=none; b=WAZiA9IDcxELRvklLJ8r6rK5tnu3niBtwHMQmk2OAPlWabxClt/B/n/9/cZ7ig6UPvzI7ce9iQ63P7/WLF6vbGcHs3fWd3WZBbRBHBGDFbZwNAKn3Lh6BuQlu+vR7iFH3/zJmgqy7+GD2oKsr+zFXZtIj47K5R9A7dMgjmdl1ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631964; c=relaxed/simple;
	bh=jV+OKSYlKt+uq4G2Z4yn86j/0AP8zKFQ5VxdRau6TTQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hAT+yYWzExojYudxS7BNPNnbJ+IvSri00o17L4hMG6LNCBV1Gony47XOAg390xk5vdps104d2fAxO0bjD0Rew+n4GLbd3nU3fjQDySmqupNAVnXwqqvf2iTamoZPBq5p8GvjEVtLbB/TimPO+dzs7pb5yGXekn+GjOPCQiutIc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pMPsn8SW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gCPR+LmA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jan 2024 16:25:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706631960;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OHou+VM3bwJKOMT8dPSiBhSY0qKJvGj+I9IMfSaJM1w=;
	b=pMPsn8SWW/opwBTCj2leLOXiON1dIJtoQxt8fJwHB/wc7FofiehACGuMKcXkpH9JLcAy6L
	dGbRnHmuJDiIn2kvQ5DOUMzbadEfdZPCMM4uWkxg/VNM5erduUPEgKlYYHKa6uliDVvXkO
	g9/HRNPPAO70sfiUxzJ7NFL2gQPHwd/qnceM318ahar80eOiYRiyFe7/aenm6z0d1bwWtZ
	G+PgZ5Zr4j1C4AJL/9BNdkZ1zIcdkaSPCsOc7aMWYrqbDCLqBXaFsBN/06EN5DwnGyTr19
	lrHqpPjL0dzz6cPy2mm/LiuxeZEvxWKZ1oCxPKos+m7hPOABuANScsgg2RvMHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706631960;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OHou+VM3bwJKOMT8dPSiBhSY0qKJvGj+I9IMfSaJM1w=;
	b=gCPR+LmAzT8zHQVnEx04ClYY0GG1VewZ3YbAx+b9YcVtP6KGxkDkdaRCWvwvKuGerU2JhN
	4ld5VYxrgRRxP1BQ==
From: "tip-bot2 for Ashish Kalra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] crypto: ccp: Add panic notifier for SEV/SNP firmware
 shutdown on kdump
Cc: Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240126041126.1927228-21-michael.roth@amd.com>
References: <20240126041126.1927228-21-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170663195929.398.15152793063246216245.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     8ef979584ea86c247b768f4420148721a842835f
Gitweb:        https://git.kernel.org/tip/8ef979584ea86c247b768f4420148721a842835f
Author:        Ashish Kalra <ashish.kalra@amd.com>
AuthorDate:    Thu, 25 Jan 2024 22:11:20 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Jan 2024 20:34:19 +01:00

crypto: ccp: Add panic notifier for SEV/SNP firmware shutdown on kdump

Add a kdump safe version of sev_firmware_shutdown() and register it as a
crash_kexec_post_notifier so it will be invoked during panic/crash to do
SEV/SNP shutdown. This is required for transitioning all IOMMU pages to
reclaim/hypervisor state, otherwise re-init of IOMMU pages during
crashdump kernel boot fails and panics the crashdump kernel.

This panic notifier runs in atomic context, hence it ensures not to
acquire any locks/mutexes and polls for PSP command completion instead
of depending on PSP command completion interrupt.

  [ mdr: Remove use of "we" in comments. ]

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240126041126.1927228-21-michael.roth@amd.com
---
 arch/x86/include/asm/sev.h   |   2 +-
 arch/x86/kernel/crash.c      |   3 +-
 arch/x86/kernel/sev.c        |  10 +++-
 arch/x86/virt/svm/sev.c      |   6 ++-
 drivers/crypto/ccp/sev-dev.c | 111 ++++++++++++++++++++++++----------
 5 files changed, 102 insertions(+), 30 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 60de1b4..bed95e1 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -227,6 +227,7 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct sn
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
+void kdump_sev_callback(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -255,6 +256,7 @@ static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *in
 static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
 static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
+static inline void kdump_sev_callback(void) { }
 #endif
 
 #ifdef CONFIG_KVM_AMD_SEV
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index b6b0443..d184c29 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -40,6 +40,7 @@
 #include <asm/intel_pt.h>
 #include <asm/crash.h>
 #include <asm/cmdline.h>
+#include <asm/sev.h>
 
 /* Used while preparing memory map entries for second kernel */
 struct crash_memmap_data {
@@ -59,6 +60,8 @@ static void kdump_nmi_callback(int cpu, struct pt_regs *regs)
 	 */
 	cpu_emergency_stop_pt();
 
+	kdump_sev_callback();
+
 	disable_local_APIC();
 }
 
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 1ec7533..002af6c 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2265,3 +2265,13 @@ static int __init snp_init_platform_device(void)
 	return 0;
 }
 device_initcall(snp_init_platform_device);
+
+void kdump_sev_callback(void)
+{
+	/*
+	 * Do wbinvd() on remote CPUs when SNP is enabled in order to
+	 * safely do SNP_SHUTDOWN on the local CPU.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_SEV_SNP))
+		wbinvd();
+}
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 0dffbf3..cffe115 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -216,6 +216,12 @@ skip_enable:
 
 	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/rmptable_init:online", __snp_enable, NULL);
 
+	/*
+	 * Setting crash_kexec_post_notifiers to 'true' to ensure that SNP panic
+	 * notifier is invoked to do SNP IOMMU shutdown before kdump.
+	 */
+	crash_kexec_post_notifiers = true;
+
 	return 0;
 
 nosnp:
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 605c6bf..504a221 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -21,6 +21,7 @@
 #include <linux/hw_random.h>
 #include <linux/ccp.h>
 #include <linux/firmware.h>
+#include <linux/panic_notifier.h>
 #include <linux/gfp.h>
 #include <linux/cpufeature.h>
 #include <linux/fs.h>
@@ -143,6 +144,25 @@ static int sev_wait_cmd_ioc(struct sev_device *sev,
 {
 	int ret;
 
+	/*
+	 * If invoked during panic handling, local interrupts are disabled,
+	 * so the PSP command completion interrupt can't be used. Poll for
+	 * PSP command completion instead.
+	 */
+	if (irqs_disabled()) {
+		unsigned long timeout_usecs = (timeout * USEC_PER_SEC) / 10;
+
+		/* Poll for SEV command completion: */
+		while (timeout_usecs--) {
+			*reg = ioread32(sev->io_regs + sev->vdata->cmdresp_reg);
+			if (*reg & PSP_CMDRESP_RESP)
+				return 0;
+
+			udelay(10);
+		}
+		return -ETIMEDOUT;
+	}
+
 	ret = wait_event_timeout(sev->int_queue,
 			sev->int_rcvd, timeout * HZ);
 	if (!ret)
@@ -1338,17 +1358,6 @@ static int __sev_platform_shutdown_locked(int *error)
 	return ret;
 }
 
-static int sev_platform_shutdown(int *error)
-{
-	int rc;
-
-	mutex_lock(&sev_cmd_mutex);
-	rc = __sev_platform_shutdown_locked(NULL);
-	mutex_unlock(&sev_cmd_mutex);
-
-	return rc;
-}
-
 static int sev_get_platform_state(int *state, int *error)
 {
 	struct sev_user_data_status data;
@@ -1624,7 +1633,7 @@ fw_err:
 	return ret;
 }
 
-static int __sev_snp_shutdown_locked(int *error)
+static int __sev_snp_shutdown_locked(int *error, bool panic)
 {
 	struct sev_device *sev = psp_master->sev_data;
 	struct sev_data_snp_shutdown_ex data;
@@ -1637,7 +1646,16 @@ static int __sev_snp_shutdown_locked(int *error)
 	data.len = sizeof(data);
 	data.iommu_snp_shutdown = 1;
 
-	wbinvd_on_all_cpus();
+	/*
+	 * If invoked during panic handling, local interrupts are disabled
+	 * and all CPUs are stopped, so wbinvd_on_all_cpus() can't be called.
+	 * In that case, a wbinvd() is done on remote CPUs via the NMI
+	 * callback, so only a local wbinvd() is needed here.
+	 */
+	if (!panic)
+		wbinvd_on_all_cpus();
+	else
+		wbinvd();
 
 	ret = __sev_do_cmd_locked(SEV_CMD_SNP_SHUTDOWN_EX, &data, error);
 	/* SHUTDOWN may require DF_FLUSH */
@@ -1681,17 +1699,6 @@ static int __sev_snp_shutdown_locked(int *error)
 	return ret;
 }
 
-static int sev_snp_shutdown(int *error)
-{
-	int rc;
-
-	mutex_lock(&sev_cmd_mutex);
-	rc = __sev_snp_shutdown_locked(error);
-	mutex_unlock(&sev_cmd_mutex);
-
-	return rc;
-}
-
 static int sev_ioctl_do_pek_import(struct sev_issue_cmd *argp, bool writable)
 {
 	struct sev_device *sev = psp_master->sev_data;
@@ -2139,19 +2146,28 @@ e_err:
 	return ret;
 }
 
-static void sev_firmware_shutdown(struct sev_device *sev)
+static void __sev_firmware_shutdown(struct sev_device *sev, bool panic)
 {
 	int error;
 
-	sev_platform_shutdown(NULL);
+	__sev_platform_shutdown_locked(NULL);
 
 	if (sev_es_tmr) {
-		/* The TMR area was encrypted, flush it from the cache */
-		wbinvd_on_all_cpus();
+		/*
+		 * The TMR area was encrypted, flush it from the cache.
+		 *
+		 * If invoked during panic handling, local interrupts are
+		 * disabled and all CPUs are stopped, so wbinvd_on_all_cpus()
+		 * can't be used. In that case, wbinvd() is done on remote CPUs
+		 * via the NMI callback, and done for this CPU later during
+		 * SNP shutdown, so wbinvd_on_all_cpus() can be skipped.
+		 */
+		if (!panic)
+			wbinvd_on_all_cpus();
 
 		__snp_free_firmware_pages(virt_to_page(sev_es_tmr),
 					  get_order(sev_es_tmr_size),
-					  false);
+					  true);
 		sev_es_tmr = NULL;
 	}
 
@@ -2167,7 +2183,14 @@ static void sev_firmware_shutdown(struct sev_device *sev)
 		snp_range_list = NULL;
 	}
 
-	sev_snp_shutdown(&error);
+	__sev_snp_shutdown_locked(&error, panic);
+}
+
+static void sev_firmware_shutdown(struct sev_device *sev)
+{
+	mutex_lock(&sev_cmd_mutex);
+	__sev_firmware_shutdown(sev, false);
+	mutex_unlock(&sev_cmd_mutex);
 }
 
 void sev_dev_destroy(struct psp_device *psp)
@@ -2185,6 +2208,29 @@ void sev_dev_destroy(struct psp_device *psp)
 	psp_clear_sev_irq_handler(psp);
 }
 
+static int snp_shutdown_on_panic(struct notifier_block *nb,
+				 unsigned long reason, void *arg)
+{
+	struct sev_device *sev = psp_master->sev_data;
+
+	/*
+	 * If sev_cmd_mutex is already acquired, then it's likely
+	 * another PSP command is in flight and issuing a shutdown
+	 * would fail in unexpected ways. Rather than create even
+	 * more confusion during a panic, just bail out here.
+	 */
+	if (mutex_is_locked(&sev_cmd_mutex))
+		return NOTIFY_DONE;
+
+	__sev_firmware_shutdown(sev, true);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block snp_panic_notifier = {
+	.notifier_call = snp_shutdown_on_panic,
+};
+
 int sev_issue_cmd_external_user(struct file *filep, unsigned int cmd,
 				void *data, int *error)
 {
@@ -2222,6 +2268,8 @@ void sev_pci_init(void)
 	dev_info(sev->dev, "SEV%s API:%d.%d build:%d\n", sev->snp_initialized ?
 		"-SNP" : "", sev->api_major, sev->api_minor, sev->build);
 
+	atomic_notifier_chain_register(&panic_notifier_list,
+				       &snp_panic_notifier);
 	return;
 
 err:
@@ -2236,4 +2284,7 @@ void sev_pci_exit(void)
 		return;
 
 	sev_firmware_shutdown(sev);
+
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+					 &snp_panic_notifier);
 }

