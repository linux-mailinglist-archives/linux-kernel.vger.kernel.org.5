Return-Path: <linux-kernel+bounces-112093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BD48875B5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 00:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8EAB285544
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 23:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3765582C60;
	Fri, 22 Mar 2024 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i+VazJd1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6AE82877
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 23:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711149629; cv=none; b=cW7SSNT8cFER/dNKuAIxol/yyhLAegFy2BoTLwx5/ch5OnGFpvHM5SLY5e45CUeL+JbkzHkq+PPxiZSez1EroPNV4LQAXRmoZOJwzb2Szp7oXFUktH/klri0EKLq06gWj1JkTPJeUkSoIbZ7T9dN61fyHNeap+tADXEF7DUefqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711149629; c=relaxed/simple;
	bh=Ms4bz3fWKHV3dSnToflXLh0/u8AUGPKNSasrQEN8kSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u9NLRHWCm7ftRBwk6CCtkBn5JIcF+F2GLo99EUNp0D4g753Ig1IIqbuRtGbOEa4ILbUmwd9LrUwXf89pSPsR7pcjnSVv2yRnZAjoXiHy31o9C79dr4vCgtqqsjRGMe83/UghH7n4o3C0rN83a5SQvOtubV8wx0cQDBcy3dmnedw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i+VazJd1; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711149626; x=1742685626;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ms4bz3fWKHV3dSnToflXLh0/u8AUGPKNSasrQEN8kSs=;
  b=i+VazJd1BGpmVBtVnvdPiXCmOiMm/DcD0YWlZPW/+achLXBZ5yyWVfD0
   hdu3mwZheogYvztnLPxOmD+pFw1sC1DrMNXoR3olmfCS7v6bXafmMzw4T
   0yV/dtqo0YbugUilACMl9AWVNFh+6kv02ZSeT8RabY6fGcjpogeKjKag9
   yNJJbZVGSl+ZwsG5RMfKvuJqXOH2AnUexrdGoWSbp9XLWlT0OpwuXW3YE
   mehEw19Y38AmWUrHAkf8X6uJCuRZVI0+SQwhrnU2dqw/Mk24HRnDYcAgc
   uHH3e67lI0XOphWVFOdE2IHvUDz2DIefgNrGa+7y/mWCIWaG4ZDxf+NVL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11021"; a="6408514"
X-IronPort-AV: E=Sophos;i="6.07,147,1708416000"; 
   d="scan'208";a="6408514"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 16:20:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,147,1708416000"; 
   d="scan'208";a="19748855"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orviesa004.jf.intel.com with ESMTP; 22 Mar 2024 16:20:25 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	tglx@linutronix.de,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	mingo@redhat.com
Cc: attofari@amazon.de,
	chang.seok.bae@intel.com
Subject: [PATCH v4] x86/fpu: Keep xfd_state always in sync with MSR_IA32_XFD
Date: Fri, 22 Mar 2024 16:04:39 -0700
Message-Id: <20240322230439.456571-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519112315.30616-1-attofari@amazon.de>
References: <20230519112315.30616-1-attofari@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adamos Ttofari <attofari@amazon.de>

Commit 672365477ae8 ("x86/fpu: Update XFD state where required") and
commit 8bf26758ca96 ("x86/fpu: Add XFD state to fpstate") introduced a
per CPU variable xfd_state to keep the MSR_IA32_XFD value cached. In
order to avoid unnecessary writes to the MSR.

On CPU hotplug MSR_IA32_XFD is reset to the init_fpstate.xfd, which
wipes out any stale state. But the per CPU cached xfd value is not
reset, which brings them out of sync.

As a consequence a subsequent xfd_update_state() might fail to update
the MSR which in turn can result in XRSTOR raising a #NM in kernel
space, which crashes the kernel.

To address the issue mentioned, initialize xfd_state together with
MSR_IA32_XFD.

Fixes: 672365477ae8 ("x86/fpu: Update XFD state where required")
Closes: https://lore.kernel.org/lkml/20230511152818.13839-1-attofari@amazon.de
Signed-off-by: Adamos Ttofari <attofari@amazon.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V4 <- V3: No code changes, just a minor tweak in the changelog:
* Adjust the patch subject prefix to align with the preferred format for
  'tip' [1], 'x86: fpu:' -> 'x86/fpu:'
* Add a few more commit tags.

It appears that the issue is predominantly exposed during the execution
of synthetic test cases, such as concurrent AMX operations with CPU
hotplug tests (e.g., 'stress-ng --cpu-online' [2]). While this might be
seen as a corner case, it has been a recurring failure during hardware
validation, leading to confusion regarding the source of the problem.

I considered updating the AMX test like this [3]. But, the change
introduced side effects, adding about 2 more seconds to run the test.
Also, running AMX concurrently with aggressively on-/off-lining of CPUs
doesn't seem to align well typical usage scenarios that warrant testing.
Nonetheless, I'm open to add this test if it's deemed necessary.

[1]: https://www.kernel.org/doc/html/next/process/maintainer-tip.html#patch-subject
[2]: https://github.com/ColinIanKing/stress-ng/blob/master/stress-cpu-online.c#L27
[3]: https://lore.kernel.org/lkml/20230603152455.12444-1-chang.seok.bae@intel.com/
---
 arch/x86/kernel/fpu/xstate.c |  5 +++--
 arch/x86/kernel/fpu/xstate.h | 14 ++++++++++----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 117e74c44e75..33a214b1a4ce 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -178,10 +178,11 @@ void fpu__init_cpu_xstate(void)
 	 * Must happen after CR4 setup and before xsetbv() to allow KVM
 	 * lazy passthrough.  Write independent of the dynamic state static
 	 * key as that does not work on the boot CPU. This also ensures
-	 * that any stale state is wiped out from XFD.
+	 * that any stale state is wiped out from XFD. Reset the per CPU
+	 * xfd cache too.
 	 */
 	if (cpu_feature_enabled(X86_FEATURE_XFD))
-		wrmsrl(MSR_IA32_XFD, init_fpstate.xfd);
+		xfd_set_state(init_fpstate.xfd);
 
 	/*
 	 * XCR_XFEATURE_ENABLED_MASK (aka. XCR0) sets user features
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 3518fb26d06b..19ca623ffa2a 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -148,20 +148,26 @@ static inline void xfd_validate_state(struct fpstate *fpstate, u64 mask, bool rs
 #endif
 
 #ifdef CONFIG_X86_64
+static inline void xfd_set_state(u64 xfd)
+{
+	wrmsrl(MSR_IA32_XFD, xfd);
+	__this_cpu_write(xfd_state, xfd);
+}
+
 static inline void xfd_update_state(struct fpstate *fpstate)
 {
 	if (fpu_state_size_dynamic()) {
 		u64 xfd = fpstate->xfd;
 
-		if (__this_cpu_read(xfd_state) != xfd) {
-			wrmsrl(MSR_IA32_XFD, xfd);
-			__this_cpu_write(xfd_state, xfd);
-		}
+		if (__this_cpu_read(xfd_state) != xfd)
+			xfd_set_state(xfd);
 	}
 }
 
 extern int __xfd_enable_feature(u64 which, struct fpu_guest *guest_fpu);
 #else
+static inline void xfd_set_state(u64 xfd) { }
+
 static inline void xfd_update_state(struct fpstate *fpstate) { }
 
 static inline int __xfd_enable_feature(u64 which, struct fpu_guest *guest_fpu) {
-- 
2.40.1


