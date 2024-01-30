Return-Path: <linux-kernel+bounces-44932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC89842933
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B30EC1C25DCD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC86E12DD82;
	Tue, 30 Jan 2024 16:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kG7yE4tK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3mc94efp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C1B12BF22;
	Tue, 30 Jan 2024 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631970; cv=none; b=WdTJ3OZ1fRaFQXxNR/T+gEfyYzYOtnhRAA5c7TPBNPndpKgRiCMVdyj8z/6FdSPLuDiGTGzTlGZpQTa25vYheuxskNdwxwP1eMvaLWaEdSEp03ezLHkbRtykd2z61zfvmV23xbtbvrt9TeY0cGzoaJHlmCA7cxDl8L+1Sh6opxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631970; c=relaxed/simple;
	bh=MrX1/HU6fOKAp+Vz+CIcjscXNq16H7FdC2rBOmwmFfA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FUgAA71BaAVMqONZI8r6Pjr4bejTdNTzysWMfK5/n1ZfmiB2dkMmCGXLIV6zYkeNW+pMKtd/SJCj8sFBeL1aq1pFXvhgJpS7D8CNre+DAv725/cS3b0bLoOJwCIS/ZNEa7TKVLqNqEUt5fn50kujI0gqqB/2jg53AIunTmp1YPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kG7yE4tK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3mc94efp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jan 2024 16:26:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706631965;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AVT8cozKmsYmC9sMjPrwW5xwd6jOv5xlwyJWtQtyfjg=;
	b=kG7yE4tK71DF0e4wC3vgEpWqALlyg1i044ZyMnwBF/WAZAyAQ0jccCrxIIfzF8CIT5k4S5
	maW6/XFaCEt5qE/vYLHek7iOCXp1WAP6I1uuKfiKPqvNYUKsf/yttMFo73nJTK8NnOLkVi
	KXxbDMMHrVobXHGxHZA9xdvBUQRmNXewt8dFR3/0G//wo1PxZMU/Iele8gAatDETEy7fnm
	U5qvkKg9vCaZkYynCt4MgwJ1QaduqeBAtLDHeFVMaC7M3w2ouNQjp7JGZ6k1WIYASLE4KD
	/I0gsZggLELpa3lcyBsb2530lwYW1tuDQ9vSoPjS2+tkGA0z/PzVINTLYuOuJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706631965;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AVT8cozKmsYmC9sMjPrwW5xwd6jOv5xlwyJWtQtyfjg=;
	b=3mc94efpU+HYmGhKO5xJq0sGF1v5CCn0fL1LcTI3Y15EcyBctgEac1m2kC0KPyN6sJH6Ii
	rmFgwQdSbDTAPvAQ==
From: "tip-bot2 for Brijesh Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/sev] crypto: ccp: Add support to initialize the AMD-SP for SEV-SNP
Cc: Brijesh Singh <brijesh.singh@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Jarkko Sakkinen <jarkko@profian.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240126041126.1927228-14-michael.roth@amd.com>
References: <20240126041126.1927228-14-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170663196515.398.6568795166683557719.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     1ca5614b84eed5904f65f143e0e7aaab0ac4c6b2
Gitweb:        https://git.kernel.org/tip/1ca5614b84eed5904f65f143e0e7aaab0ac4c6b2
Author:        Brijesh Singh <brijesh.singh@amd.com>
AuthorDate:    Thu, 25 Jan 2024 22:11:13 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Jan 2024 20:34:18 +01:00

crypto: ccp: Add support to initialize the AMD-SP for SEV-SNP

Before SNP VMs can be launched, the platform must be appropriately
configured and initialized via the SNP_INIT command.

During the execution of SNP_INIT command, the firmware configures
and enables SNP security policy enforcement in many system components.
Some system components write to regions of memory reserved by early
x86 firmware (e.g. UEFI). Other system components write to regions
provided by the operation system, hypervisor, or x86 firmware.
Such system components can only write to HV-fixed pages or Default
pages. They will error when attempting to write to pages in other page
states after SNP_INIT enables their SNP enforcement.

Starting in SNP firmware v1.52, the SNP_INIT_EX command takes a list of
system physical address ranges to convert into the HV-fixed page states
during the RMP initialization. If INIT_RMP is 1, hypervisors should
provide all system physical address ranges that the hypervisor will
never assign to a guest until the next RMP re-initialization.

For instance, the memory that UEFI reserves should be included in the
range list. This allows system components that occasionally write to
memory (e.g. logging to UEFI reserved regions) to not fail due to
RMP initialization and SNP enablement.

Note that SNP_INIT(_EX) must not be executed while non-SEV guests are
executing, otherwise it is possible that the system could reset or hang.
The psp_init_on_probe module parameter was added for SEV/SEV-ES support
and the init_ex_path module parameter to allow for time for the
necessary file system to be mounted/available.

SNP_INIT(_EX) does not use the file associated with init_ex_path. So, to
avoid running into issues where SNP_INIT(_EX) is called while there are
other running guests, issue it during module probe regardless of the
psp_init_on_probe setting, but maintain the previous deferrable handling
for SEV/SEV-ES initialization.

  [ mdr: Squash in psp_init_on_probe changes from Tom, reduce
    proliferation of 'probe' function parameter where possible.
    bp: Fix 32-bit allmodconfig build. ]

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Co-developed-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Co-developed-by: Jarkko Sakkinen <jarkko@profian.com>
Signed-off-by: Jarkko Sakkinen <jarkko@profian.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240126041126.1927228-14-michael.roth@amd.com
---
 arch/x86/kvm/svm/sev.c       |   5 +-
 drivers/crypto/ccp/sev-dev.c | 280 +++++++++++++++++++++++++++++++---
 drivers/crypto/ccp/sev-dev.h |   2 +-
 include/linux/psp-sev.h      |  19 +-
 4 files changed, 282 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index f760106..564091f 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -246,6 +246,7 @@ static void sev_unbind_asid(struct kvm *kvm, unsigned int handle)
 static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
 {
 	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
+	struct sev_platform_init_args init_args = {0};
 	int asid, ret;
 
 	if (kvm->created_vcpus)
@@ -262,7 +263,8 @@ static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
 		goto e_no_asid;
 	sev->asid = asid;
 
-	ret = sev_platform_init(&argp->error);
+	init_args.probe = false;
+	ret = sev_platform_init(&init_args);
 	if (ret)
 		goto e_free;
 
@@ -274,6 +276,7 @@ static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	return 0;
 
 e_free:
+	argp->error = init_args.error;
 	sev_asid_free(sev);
 	sev->asid = 0;
 e_no_asid:
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index e38986d..7129644 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -29,6 +29,7 @@
 
 #include <asm/smp.h>
 #include <asm/cacheflush.h>
+#include <asm/e820/types.h>
 
 #include "psp-dev.h"
 #include "sev-dev.h"
@@ -37,6 +38,10 @@
 #define SEV_FW_FILE		"amd/sev.fw"
 #define SEV_FW_NAME_SIZE	64
 
+/* Minimum firmware version required for the SEV-SNP support */
+#define SNP_MIN_API_MAJOR	1
+#define SNP_MIN_API_MINOR	51
+
 static DEFINE_MUTEX(sev_cmd_mutex);
 static struct sev_misc_dev *misc_dev;
 
@@ -80,6 +85,13 @@ static void *sev_es_tmr;
 #define NV_LENGTH (32 * 1024)
 static void *sev_init_ex_buffer;
 
+/*
+ * SEV_DATA_RANGE_LIST:
+ *   Array containing range of pages that firmware transitions to HV-fixed
+ *   page state.
+ */
+struct sev_data_range_list *snp_range_list;
+
 static inline bool sev_version_greater_or_equal(u8 maj, u8 min)
 {
 	struct sev_device *sev = psp_master->sev_data;
@@ -480,20 +492,163 @@ static inline int __sev_do_init_locked(int *psp_ret)
 		return __sev_init_locked(psp_ret);
 }
 
-static int __sev_platform_init_locked(int *error)
+static void snp_set_hsave_pa(void *arg)
+{
+	wrmsrl(MSR_VM_HSAVE_PA, 0);
+}
+
+static int snp_filter_reserved_mem_regions(struct resource *rs, void *arg)
+{
+	struct sev_data_range_list *range_list = arg;
+	struct sev_data_range *range = &range_list->ranges[range_list->num_elements];
+	size_t size;
+
+	/*
+	 * Ensure the list of HV_FIXED pages that will be passed to firmware
+	 * do not exceed the page-sized argument buffer.
+	 */
+	if ((range_list->num_elements * sizeof(struct sev_data_range) +
+	     sizeof(struct sev_data_range_list)) > PAGE_SIZE)
+		return -E2BIG;
+
+	switch (rs->desc) {
+	case E820_TYPE_RESERVED:
+	case E820_TYPE_PMEM:
+	case E820_TYPE_ACPI:
+		range->base = rs->start & PAGE_MASK;
+		size = PAGE_ALIGN((rs->end + 1) - rs->start);
+		range->page_count = size >> PAGE_SHIFT;
+		range_list->num_elements++;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int __sev_snp_init_locked(int *error)
 {
-	int rc = 0, psp_ret = SEV_RET_NO_FW_CALL;
 	struct psp_device *psp = psp_master;
+	struct sev_data_snp_init_ex data;
 	struct sev_device *sev;
+	void *arg = &data;
+	int cmd, rc = 0;
 
-	if (!psp || !psp->sev_data)
+	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
 		return -ENODEV;
 
 	sev = psp->sev_data;
 
+	if (sev->snp_initialized)
+		return 0;
+
+	if (!sev_version_greater_or_equal(SNP_MIN_API_MAJOR, SNP_MIN_API_MINOR)) {
+		dev_dbg(sev->dev, "SEV-SNP support requires firmware version >= %d:%d\n",
+			SNP_MIN_API_MAJOR, SNP_MIN_API_MINOR);
+		return 0;
+	}
+
+	/* SNP_INIT requires MSR_VM_HSAVE_PA to be cleared on all CPUs. */
+	on_each_cpu(snp_set_hsave_pa, NULL, 1);
+
+	/*
+	 * Starting in SNP firmware v1.52, the SNP_INIT_EX command takes a list
+	 * of system physical address ranges to convert into HV-fixed page
+	 * states during the RMP initialization.  For instance, the memory that
+	 * UEFI reserves should be included in the that list. This allows system
+	 * components that occasionally write to memory (e.g. logging to UEFI
+	 * reserved regions) to not fail due to RMP initialization and SNP
+	 * enablement.
+	 *
+	 */
+	if (sev_version_greater_or_equal(SNP_MIN_API_MAJOR, 52)) {
+		/*
+		 * Firmware checks that the pages containing the ranges enumerated
+		 * in the RANGES structure are either in the default page state or in the
+		 * firmware page state.
+		 */
+		snp_range_list = kzalloc(PAGE_SIZE, GFP_KERNEL);
+		if (!snp_range_list) {
+			dev_err(sev->dev,
+				"SEV: SNP_INIT_EX range list memory allocation failed\n");
+			return -ENOMEM;
+		}
+
+		/*
+		 * Retrieve all reserved memory regions from the e820 memory map
+		 * to be setup as HV-fixed pages.
+		 */
+		rc = walk_iomem_res_desc(IORES_DESC_NONE, IORESOURCE_MEM, 0, ~0,
+					 snp_range_list, snp_filter_reserved_mem_regions);
+		if (rc) {
+			dev_err(sev->dev,
+				"SEV: SNP_INIT_EX walk_iomem_res_desc failed rc = %d\n", rc);
+			return rc;
+		}
+
+		memset(&data, 0, sizeof(data));
+		data.init_rmp = 1;
+		data.list_paddr_en = 1;
+		data.list_paddr = __psp_pa(snp_range_list);
+		cmd = SEV_CMD_SNP_INIT_EX;
+	} else {
+		cmd = SEV_CMD_SNP_INIT;
+		arg = NULL;
+	}
+
+	/*
+	 * The following sequence must be issued before launching the first SNP
+	 * guest to ensure all dirty cache lines are flushed, including from
+	 * updates to the RMP table itself via the RMPUPDATE instruction:
+	 *
+	 * - WBINVD on all running CPUs
+	 * - SEV_CMD_SNP_INIT[_EX] firmware command
+	 * - WBINVD on all running CPUs
+	 * - SEV_CMD_SNP_DF_FLUSH firmware command
+	 */
+	wbinvd_on_all_cpus();
+
+	rc = __sev_do_cmd_locked(cmd, arg, error);
+	if (rc)
+		return rc;
+
+	/* Prepare for first SNP guest launch after INIT. */
+	wbinvd_on_all_cpus();
+	rc = __sev_do_cmd_locked(SEV_CMD_SNP_DF_FLUSH, NULL, error);
+	if (rc)
+		return rc;
+
+	sev->snp_initialized = true;
+	dev_dbg(sev->dev, "SEV-SNP firmware initialized\n");
+
+	return rc;
+}
+
+static int __sev_platform_init_locked(int *error)
+{
+	int rc, psp_ret = SEV_RET_NO_FW_CALL;
+	struct sev_device *sev;
+
+	if (!psp_master || !psp_master->sev_data)
+		return -ENODEV;
+
+	sev = psp_master->sev_data;
+
 	if (sev->state == SEV_STATE_INIT)
 		return 0;
 
+	if (!sev_es_tmr) {
+		/* Obtain the TMR memory area for SEV-ES use */
+		sev_es_tmr = sev_fw_alloc(SEV_ES_TMR_SIZE);
+		if (sev_es_tmr)
+			/* Must flush the cache before giving it to the firmware */
+			clflush_cache_range(sev_es_tmr, SEV_ES_TMR_SIZE);
+		else
+			dev_warn(sev->dev,
+				 "SEV: TMR allocation failed, SEV-ES support unavailable\n");
+		}
+
 	if (sev_init_ex_buffer) {
 		rc = sev_read_init_ex_file();
 		if (rc)
@@ -536,12 +691,46 @@ static int __sev_platform_init_locked(int *error)
 	return 0;
 }
 
-int sev_platform_init(int *error)
+static int _sev_platform_init_locked(struct sev_platform_init_args *args)
+{
+	struct sev_device *sev;
+	int rc;
+
+	if (!psp_master || !psp_master->sev_data)
+		return -ENODEV;
+
+	sev = psp_master->sev_data;
+
+	if (sev->state == SEV_STATE_INIT)
+		return 0;
+
+	/*
+	 * Legacy guests cannot be running while SNP_INIT(_EX) is executing,
+	 * so perform SEV-SNP initialization at probe time.
+	 */
+	rc = __sev_snp_init_locked(&args->error);
+	if (rc && rc != -ENODEV) {
+		/*
+		 * Don't abort the probe if SNP INIT failed,
+		 * continue to initialize the legacy SEV firmware.
+		 */
+		dev_err(sev->dev, "SEV-SNP: failed to INIT rc %d, error %#x\n",
+			rc, args->error);
+	}
+
+	/* Defer legacy SEV/SEV-ES support if allowed by caller/module. */
+	if (args->probe && !psp_init_on_probe)
+		return 0;
+
+	return __sev_platform_init_locked(&args->error);
+}
+
+int sev_platform_init(struct sev_platform_init_args *args)
 {
 	int rc;
 
 	mutex_lock(&sev_cmd_mutex);
-	rc = __sev_platform_init_locked(error);
+	rc = _sev_platform_init_locked(args);
 	mutex_unlock(&sev_cmd_mutex);
 
 	return rc;
@@ -852,6 +1041,55 @@ fw_err:
 	return ret;
 }
 
+static int __sev_snp_shutdown_locked(int *error)
+{
+	struct sev_device *sev = psp_master->sev_data;
+	struct sev_data_snp_shutdown_ex data;
+	int ret;
+
+	if (!sev->snp_initialized)
+		return 0;
+
+	memset(&data, 0, sizeof(data));
+	data.len = sizeof(data);
+	data.iommu_snp_shutdown = 1;
+
+	wbinvd_on_all_cpus();
+
+	ret = __sev_do_cmd_locked(SEV_CMD_SNP_SHUTDOWN_EX, &data, error);
+	/* SHUTDOWN may require DF_FLUSH */
+	if (*error == SEV_RET_DFFLUSH_REQUIRED) {
+		ret = __sev_do_cmd_locked(SEV_CMD_SNP_DF_FLUSH, NULL, NULL);
+		if (ret) {
+			dev_err(sev->dev, "SEV-SNP DF_FLUSH failed\n");
+			return ret;
+		}
+		/* reissue the shutdown command */
+		ret = __sev_do_cmd_locked(SEV_CMD_SNP_SHUTDOWN_EX, &data,
+					  error);
+	}
+	if (ret) {
+		dev_err(sev->dev, "SEV-SNP firmware shutdown failed\n");
+		return ret;
+	}
+
+	sev->snp_initialized = false;
+	dev_dbg(sev->dev, "SEV-SNP firmware shutdown\n");
+
+	return ret;
+}
+
+static int sev_snp_shutdown(int *error)
+{
+	int rc;
+
+	mutex_lock(&sev_cmd_mutex);
+	rc = __sev_snp_shutdown_locked(error);
+	mutex_unlock(&sev_cmd_mutex);
+
+	return rc;
+}
+
 static int sev_ioctl_do_pek_import(struct sev_issue_cmd *argp, bool writable)
 {
 	struct sev_device *sev = psp_master->sev_data;
@@ -1299,6 +1537,8 @@ e_err:
 
 static void sev_firmware_shutdown(struct sev_device *sev)
 {
+	int error;
+
 	sev_platform_shutdown(NULL);
 
 	if (sev_es_tmr) {
@@ -1315,6 +1555,13 @@ static void sev_firmware_shutdown(struct sev_device *sev)
 			   get_order(NV_LENGTH));
 		sev_init_ex_buffer = NULL;
 	}
+
+	if (snp_range_list) {
+		kfree(snp_range_list);
+		snp_range_list = NULL;
+	}
+
+	sev_snp_shutdown(&error);
 }
 
 void sev_dev_destroy(struct psp_device *psp)
@@ -1345,7 +1592,8 @@ EXPORT_SYMBOL_GPL(sev_issue_cmd_external_user);
 void sev_pci_init(void)
 {
 	struct sev_device *sev = psp_master->sev_data;
-	int error, rc;
+	struct sev_platform_init_args args = {0};
+	int rc;
 
 	if (!sev)
 		return;
@@ -1370,23 +1618,15 @@ void sev_pci_init(void)
 		}
 	}
 
-	/* Obtain the TMR memory area for SEV-ES use */
-	sev_es_tmr = sev_fw_alloc(SEV_ES_TMR_SIZE);
-	if (sev_es_tmr)
-		/* Must flush the cache before giving it to the firmware */
-		clflush_cache_range(sev_es_tmr, SEV_ES_TMR_SIZE);
-	else
-		dev_warn(sev->dev,
-			 "SEV: TMR allocation failed, SEV-ES support unavailable\n");
-
-	if (!psp_init_on_probe)
-		return;
-
 	/* Initialize the platform */
-	rc = sev_platform_init(&error);
+	args.probe = true;
+	rc = sev_platform_init(&args);
 	if (rc)
 		dev_err(sev->dev, "SEV: failed to INIT error %#x, rc %d\n",
-			error, rc);
+			args.error, rc);
+
+	dev_info(sev->dev, "SEV%s API:%d.%d build:%d\n", sev->snp_initialized ?
+		"-SNP" : "", sev->api_major, sev->api_minor, sev->build);
 
 	return;
 
diff --git a/drivers/crypto/ccp/sev-dev.h b/drivers/crypto/ccp/sev-dev.h
index 778c951..8550632 100644
--- a/drivers/crypto/ccp/sev-dev.h
+++ b/drivers/crypto/ccp/sev-dev.h
@@ -52,6 +52,8 @@ struct sev_device {
 	u8 build;
 
 	void *cmd_buf;
+
+	bool snp_initialized;
 };
 
 int sev_dev_init(struct psp_device *psp);
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index 006e4cd..ef3b917 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -788,12 +788,25 @@ struct sev_data_snp_shutdown_ex {
 	u32 rsvd1:31;
 } __packed;
 
+/**
+ * struct sev_platform_init_args
+ *
+ * @error: SEV firmware error code
+ * @probe: True if this is being called as part of CCP module probe, which
+ *  will defer SEV_INIT/SEV_INIT_EX firmware initialization until needed
+ *  unless psp_init_on_probe module param is set
+ */
+struct sev_platform_init_args {
+	int error;
+	bool probe;
+};
+
 #ifdef CONFIG_CRYPTO_DEV_SP_PSP
 
 /**
  * sev_platform_init - perform SEV INIT command
  *
- * @error: SEV command return code
+ * @args: struct sev_platform_init_args to pass in arguments
  *
  * Returns:
  * 0 if the SEV successfully processed the command
@@ -802,7 +815,7 @@ struct sev_data_snp_shutdown_ex {
  * -%ETIMEDOUT if the SEV command timed out
  * -%EIO       if the SEV returned a non-zero return code
  */
-int sev_platform_init(int *error);
+int sev_platform_init(struct sev_platform_init_args *args);
 
 /**
  * sev_platform_status - perform SEV PLATFORM_STATUS command
@@ -909,7 +922,7 @@ void *psp_copy_user_blob(u64 uaddr, u32 len);
 static inline int
 sev_platform_status(struct sev_user_data_status *status, int *error) { return -ENODEV; }
 
-static inline int sev_platform_init(int *error) { return -ENODEV; }
+static inline int sev_platform_init(struct sev_platform_init_args *args) { return -ENODEV; }
 
 static inline int
 sev_guest_deactivate(struct sev_data_deactivate *data, int *error) { return -ENODEV; }

