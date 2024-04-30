Return-Path: <linux-kernel+bounces-164751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A10E28B8209
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30DB028627A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1411BF6DF;
	Tue, 30 Apr 2024 21:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m2sjxXgD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942AE1BED6D;
	Tue, 30 Apr 2024 21:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714513282; cv=none; b=JuxuP4wiiQzz6kqcPMzz9l+v9GdngqtKNgEoYoOvBmX7cXXmBjDFSGZOZmNFQ2uvEg2fszfeEgKZDzGXNGZeN25fS7JtBFqIW692T/GXI7D9NnYYV6dsBtz8ZMyLnlXVOLYSpRoX2TbZu/XUYbufuYir3TlvO+1aKr/azcWQmec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714513282; c=relaxed/simple;
	bh=PTZpohI08U4VqJLNYyA6wzPE2YPghuHCUzUfnzQcpMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uv95/fIObPkZlN2z9W1on4xcuMc4qPH9IV6wRMc56b+Zsjs8H3wr35UVrfo1GSCS+eJT0BPBDO9LxHzu/eYecNzhMVZF1S2EyDJHmZ+4CqRTEqq6GG8r9KoQpuUYQKFXOAuzsqgPGmrAF84AKvz7HSGeeWrmpUarosYTZ1xQhQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m2sjxXgD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714513280; x=1746049280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PTZpohI08U4VqJLNYyA6wzPE2YPghuHCUzUfnzQcpMc=;
  b=m2sjxXgDOiPIwcNNL5rhVCftthbTgKecq8BACpb+EsMpCHpyzEywzpGo
   SMUni9AERnr10waMIklyuEeGYqkRDgum13FuYi/tA/WYc1buNLYVhLxYC
   DCVU0t2wFE+oo452N56drIaW91e/0uKwl1Q93nKOEWx3eqhpvHqcwAa9w
   kOUX3UGkotqtZ/jFdjQXBeT6M9/NFn3Pn2brOvOF2Y4IvZCbEYetUAT7D
   v0KPHTqmmhe9Mnzn53sKFQ1VAG23HYd9NeNR2OeeMng0+lQDrI5wscqt+
   /FyzYIenqWmIBUvJn1O4jMhvvmi59/CkLX3hLifpWs3UdbG6/CEAluTqd
   g==;
X-CSE-ConnectionGUID: aURfvLmATl2aXBt62+P9Zw==
X-CSE-MsgGUID: Rnrsm3HpSuOWuEQEuKe6Bw==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="14023059"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="14023059"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 14:41:18 -0700
X-CSE-ConnectionGUID: udkPZf87Ssy5uirRfe0Kdg==
X-CSE-MsgGUID: kXfKgquQRsel4DEzkXv9Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="26693371"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmviesa006.fm.intel.com with ESMTP; 30 Apr 2024 14:41:17 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	platform-driver-x86@vger.kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	tony.luck@intel.com,
	ashok.raj@intel.com,
	jithu.joseph@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH 1/2] x86/fpu: Extend kernel_fpu_begin_mask() to initialize AMX state
Date: Tue, 30 Apr 2024 14:25:07 -0700
Message-Id: <20240430212508.105117-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430212508.105117-1-chang.seok.bae@intel.com>
References: <20240430212508.105117-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The In-Field Scan [1] test does not start its operation when the CPU is
unprepared. If the AMX state is uninitialized, the scan test will
immediately terminate. Therefore, a proper initialization of the AMX
state is necessary to run the test.

Although fpu_idle_fpregs() initializes the state, its usage should be
limited to specialized cases, primarily before entering the sleep state.
The restore_fpregs_from_fpstate() function offers a suitable mechanism
for initializing fpstate in general, which remains within the core code.

Extend kernel_fpu_begin_mask() to include AMX state initialization,
providing the in-field scan driver code access to the appropriate
initialization method while maintaining compliance with established FPU
API semantics.

[1] https://docs.kernel.org/arch/x86/ifs.html
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
The necessity for AMX initialization is clarified in the Intel Software
Development Manual as of March 2024, particularly in Section 18.2
RECOMMENDATIONS FOR SYSTEM SOFTWARE of Vol. 1.

Side note: restore_fpregs_from_fpstate() also sets the x87 state to a
fixed value. However, this only applies to AMD CPUs with the FXSAVE_LEAK
quirk.
---
 arch/x86/include/asm/fpu/api.h | 1 +
 arch/x86/kernel/fpu/core.c     | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index a2be3aefff9f..67887fc45c24 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -25,6 +25,7 @@
 /* Kernel FPU states to initialize in kernel_fpu_begin_mask() */
 #define KFPU_387	_BITUL(0)	/* 387 state will be initialized */
 #define KFPU_MXCSR	_BITUL(1)	/* MXCSR will be initialized */
+#define KFPU_AMX	_BITUL(2)	/* AMX will be initialized */
 
 extern void kernel_fpu_begin_mask(unsigned int kfpu_mask);
 extern void kernel_fpu_end(void);
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 520deb411a70..0c0235b4a901 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -440,6 +440,9 @@ void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 
 	if (unlikely(kfpu_mask & KFPU_387) && boot_cpu_has(X86_FEATURE_FPU))
 		asm volatile ("fninit");
+
+	if (unlikely(kfpu_mask & KFPU_AMX) && boot_cpu_has(X86_FEATURE_AMX_TILE))
+		restore_fpregs_from_fpstate(&init_fpstate, XFEATURE_MASK_XTILE);
 }
 EXPORT_SYMBOL_GPL(kernel_fpu_begin_mask);
 
-- 
2.34.1


