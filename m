Return-Path: <linux-kernel+bounces-134663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A6189B498
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 01:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09A9C1F2139D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 23:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16190446B7;
	Sun,  7 Apr 2024 23:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AVyZdntV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825443FB83;
	Sun,  7 Apr 2024 23:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712532049; cv=none; b=HwkggrxWYD3YGS7OZsSioPmfLZkl0qn4CcpiZmzSD3JL0RKl4h5SJ2+VeWZme/BpSZXX2hlpqKjzrCVRySFq2ICDCrPAmn5I1OYKOib2i3WsIMnW5voNzN8zv+H2DzIqLd93h67QUSxQdx7CrvBm5eTjuw1QJw6YmZFkW2NVnwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712532049; c=relaxed/simple;
	bh=Guz77wGX67222+ZdfWG+k8ArwL5scaBgVJjI+9Ueoug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m70iMptQq8FBwP5nTlKQNPfhZVJ0K50XTRMmJCTp5mfhJI6qw/QmMwL/cgDbQXKPYneMB42G1e93RimPuEAzKezEM+Q+W4UovrXEOsp7LV0/9DRLCrNz1AIVd4Z+V6adguiHSfrV5MMnAE8fLgpxqx/qbDcQiKi5WF76+p0a+xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AVyZdntV; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712532047; x=1744068047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Guz77wGX67222+ZdfWG+k8ArwL5scaBgVJjI+9Ueoug=;
  b=AVyZdntVJAOkH2DfIs5EbmHVVj2WrcJI6qvjIPd/bBFe4+XICUjtSuQe
   XbfJ2MOz1bgFSFyJFS71diSCvvdScNOW9o9/sgl6qaHmLGTV86xYhlKwA
   SSz/a4JggLnnRIIV/WViajdwKXa/v/5P4oNUDCxARFaUMdgbymKRtWHW2
   gg2HSCgUUsSbavMSHrYeqjhPQdFRWEDOOES0P9LrcPOjC5fcYxVYoTAas
   l8shFaBYQgL9V0x4r7Qwx0dWqunEBANUNRDA8FPqypnpF1DtslBhGMJql
   F2+4M+kylDjIPIHoKOXIydX9KlpL4yLxnnUGwjBBds6JvRAzyon/9/Yy1
   g==;
X-CSE-ConnectionGUID: FyJb4sHVTGGPpKFD653Qwg==
X-CSE-MsgGUID: YyTUCWHaQe+V5JlkduEAhg==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="11570832"
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="11570832"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 16:20:47 -0700
X-CSE-ConnectionGUID: TaIMkT2MRMaENMvjVc8q6A==
X-CSE-MsgGUID: MxY1RVtOQjGqnm+dSNpECw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="20269732"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orviesa008.jf.intel.com with ESMTP; 07 Apr 2024 16:20:45 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Cc: ebiggers@kernel.org,
	luto@kernel.org,
	dave.hansen@linux.intel.com,
	tglx@linutronix.de,
	bp@alien8.de,
	mingo@kernel.org,
	x86@kernel.org,
	herbert@gondor.apana.org.au,
	ardb@kernel.org,
	elliott@hpe.com,
	dan.j.williams@intel.com,
	bernie.keany@intel.com,
	charishma1.gairuboyina@intel.com,
	chang.seok.bae@intel.com,
	Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH v9a 07/14] x86/cpu/keylocker: Load a wrapping key at boot time
Date: Sun,  7 Apr 2024 16:04:53 -0700
Message-Id: <20240407230453.912322-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329015346.635933-8-chang.seok.bae@intel.com>
References: <20240329015346.635933-8-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The wrapping key is an entity to encode a clear text key into a key
handle. This key is a pivot in protecting user keys. So the value has
to be randomized before being loaded in the software-invisible CPU
state.

The wrapping key needs to be established before the first user. Given
that the only proposed Linux use case for Key Locker is dm-crypt, the
feature could be lazily enabled before the first dm-crypt user arrives.

But there is no precedent for late enabling of CPU features and it
adds maintenance burden without demonstrative benefit outside of
minimizing the visibility of Key Locker to userspace.

Therefore, generate random bytes and load them at boot time, involving
clobbering XMM registers. Perform this process under arch_initcall(),
ensuring that it occurs after FPU initialization. Finally, flush out
random bytes after loading.

Given that the Linux Key Locker support is only intended for bare
metal dm-crypt use, and that switching wrapping key per virtual machine
is impractical, explicitly skip this setup in the X86_FEATURE_HYPERVISOR
case.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---
Changes from v9:
* Include 'tlbflush.h' back, which was once removed by mistake.
---
 arch/x86/kernel/Makefile    |  1 +
 arch/x86/kernel/keylocker.c | 78 +++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100644 arch/x86/kernel/keylocker.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 74077694da7d..d105e5785b90 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -137,6 +137,7 @@ obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o
 obj-$(CONFIG_TRACING)			+= tracepoint.o
 obj-$(CONFIG_SCHED_MC_PRIO)		+= itmt.o
 obj-$(CONFIG_X86_UMIP)			+= umip.o
+obj-$(CONFIG_X86_KEYLOCKER)		+= keylocker.o
 
 obj-$(CONFIG_UNWINDER_ORC)		+= unwind_orc.o
 obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+= unwind_frame.o
diff --git a/arch/x86/kernel/keylocker.c b/arch/x86/kernel/keylocker.c
new file mode 100644
index 000000000000..8569b92971da
--- /dev/null
+++ b/arch/x86/kernel/keylocker.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Setup Key Locker feature and support the wrapping key management.
+ */
+
+#include <linux/random.h>
+#include <linux/string.h>
+
+#include <asm/fpu/api.h>
+#include <asm/keylocker.h>
+#include <asm/processor.h>
+#include <asm/tlbflush.h>
+
+static struct iwkey wrapping_key __initdata;
+
+static void __init generate_keylocker_data(void)
+{
+	get_random_bytes(&wrapping_key.integrity_key, sizeof(wrapping_key.integrity_key));
+	get_random_bytes(&wrapping_key.encryption_key, sizeof(wrapping_key.encryption_key));
+}
+
+static void __init destroy_keylocker_data(void)
+{
+	memzero_explicit(&wrapping_key, sizeof(wrapping_key));
+}
+
+/*
+ * For loading the wrapping key into each CPU, the feature bit is set
+ * in the control register and FPU context management is performed.
+ */
+static void __init load_keylocker(struct work_struct *unused)
+{
+	cr4_set_bits(X86_CR4_KEYLOCKER);
+
+	kernel_fpu_begin();
+	load_xmm_iwkey(&wrapping_key);
+	kernel_fpu_end();
+}
+
+static int __init init_keylocker(void)
+{
+	u32 eax, ebx, ecx, edx;
+
+	if (!cpu_feature_enabled(X86_FEATURE_KEYLOCKER))
+		goto disable;
+
+	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR)) {
+		pr_debug("x86/keylocker: Not compatible with a hypervisor.\n");
+		goto clear_cap;
+	}
+
+	cr4_set_bits(X86_CR4_KEYLOCKER);
+
+	/* AESKLE depends on CR4.KEYLOCKER */
+	cpuid_count(KEYLOCKER_CPUID, 0, &eax, &ebx, &ecx, &edx);
+	if (!(ebx & KEYLOCKER_CPUID_EBX_AESKLE) ||
+	    !(eax & KEYLOCKER_CPUID_EAX_SUPERVISOR)) {
+		pr_debug("x86/keylocker: Not fully supported.\n");
+		goto clear_cap;
+	}
+
+	generate_keylocker_data();
+	schedule_on_each_cpu(load_keylocker);
+	destroy_keylocker_data();
+
+	pr_info_once("x86/keylocker: Enabled.\n");
+	return 0;
+
+clear_cap:
+	setup_clear_cpu_cap(X86_FEATURE_KEYLOCKER);
+	pr_info_once("x86/keylocker: Disabled.\n");
+disable:
+	cr4_clear_bits(X86_CR4_KEYLOCKER);
+	return -ENODEV;
+}
+
+arch_initcall(init_keylocker);
-- 
2.40.1


