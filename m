Return-Path: <linux-kernel+bounces-164750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6AF8B8207
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC761F232A7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001BC1BED8B;
	Tue, 30 Apr 2024 21:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X3PZEtef"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C2F1BED72;
	Tue, 30 Apr 2024 21:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714513281; cv=none; b=tKhl29IidyCP+0D+T+YKCiGRoEJcbhrZTIFJeNniI5e+7P2G1q4FQIdxH3xVTkKK7FJfvKS3TOeHkxnVwZwyznf1l2p4Xse2LQ0rm0lvEmPHGOAWcZbdCySNU0wEpDoP7AqeFF5rZfiRJ7T/xfZ8jIuH2ehhhyERQJtp0EV5cjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714513281; c=relaxed/simple;
	bh=x7Ol+/+g8MWI3KkMdPC4Pmi13hhCIxwJQ+316xO7RcI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qUlnFqOIYjbycesd+C6FKmvBEYVW7oJCOZ6cVBV9+Olz3MWKw+7w1Ih8XAsH/iuFFxNkImHf4jT+JB0mWd34H3TIjJ5Obuo4bWtxef0anzUblPSBU8ujzfIhoYGHF7n1cIqnLsIV/sRdUaBbS03X/P5vBh4DCopkasXgTSanwtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X3PZEtef; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714513280; x=1746049280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x7Ol+/+g8MWI3KkMdPC4Pmi13hhCIxwJQ+316xO7RcI=;
  b=X3PZEtefjIB5pZ4D/cGC0wdKUaLQD4fvCRwGYjkv6+HGcIQQyQ6pRyGn
   a3q0MIRgD9QU3UoCOktyku13K/nJSm2e/3LZfTyEXm1ZnIx7An8FUqaaI
   J8oWC9txNVkTodXfpP0TKLGmZzkIGw0LjcRN5T3xoUSuMbexLYgnUVkRi
   pY/DeG3eDpYWIVX1fno2Kd3nxyr8bx8LY4DHpowfiDqLgyGtChnw+ELiK
   byXdAfQZdWlg9rdMxQjdO+wbPcNlw+Y5zrq5A8U9w5w887tPCudaZ5T+j
   U72PScvvVCSM0QihcyuOG3DWoairr6470AIcvrZFHPhQ8CxhxpNDNt+Jh
   A==;
X-CSE-ConnectionGUID: Gl+b9rkJTPaYUzPpwwvRJw==
X-CSE-MsgGUID: OTOfVkqESimO5Mp6vyBkNw==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="14023068"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="14023068"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 14:41:19 -0700
X-CSE-ConnectionGUID: BcMoaQbpRk2UsSYVt72q+Q==
X-CSE-MsgGUID: ey6uZY7xQGm4lU/ZlAi9mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="26693375"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmviesa006.fm.intel.com with ESMTP; 30 Apr 2024 14:41:19 -0700
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
Subject: [PATCH 2/2] platform/x86/intel/ifs: Initialize AMX state for the scan test
Date: Tue, 30 Apr 2024 14:25:08 -0700
Message-Id: <20240430212508.105117-3-chang.seok.bae@intel.com>
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

The scan test does not start when the AMX state remains active and is not
re-initialized. With the extension of kernel_fpu_begin_mask(), the driver
code can now initialize the state properly.

Introduce custom FPU handling wrappers to ensure compliant with the
established FPU API semantics, as kernel_fpu_begin() exclusively sets
legacy states. This follows the EFI case from commit b0dc553cfc9d
("x86/fpu: Make the EFI FPU calling convention explicit").

Then, use these wrappers to surround the MSR_ACTIVATE_SCAN write to
minimize the critical section. To prevent unnecessary delays, invoke
ifs_fpu_begin() before entering the rendezvous loop.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Jithu Joseph <jithu.joseph@intel.com>
Tested-by: Jithu Joseph <jithu.joseph@intel.com>
---
 drivers/platform/x86/intel/ifs/ifs.h     | 14 ++++++++++++++
 drivers/platform/x86/intel/ifs/runtest.c |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 56b9f3e3cf76..71d8b50854b2 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -325,4 +325,18 @@ int do_core_test(int cpu, struct device *dev);
 extern struct attribute *plat_ifs_attrs[];
 extern struct attribute *plat_ifs_array_attrs[];
 
+static inline void ifs_fpu_begin(void)
+{
+	/*
+	 * The AMX state must be initialized prior to executing In-Field
+	 * Scan tests, according to Intel SDM.
+	 */
+	kernel_fpu_begin_mask(KFPU_AMX);
+}
+
+static inline void ifs_fpu_end(void)
+{
+	kernel_fpu_end();
+}
+
 #endif
diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
index 95b4b71fab53..a35eac7c0b44 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -188,6 +188,9 @@ static int doscan(void *data)
 	/* Only the first logical CPU on a core reports result */
 	first = cpumask_first(cpu_smt_mask(cpu));
 
+	/* Prepare FPU state before entering the rendezvous loop*/
+	ifs_fpu_begin();
+
 	wait_for_sibling_cpu(&scan_cpus_in, NSEC_PER_SEC);
 
 	/*
@@ -199,6 +202,9 @@ static int doscan(void *data)
 	 * are processed in a single pass) before it retires.
 	 */
 	wrmsrl(MSR_ACTIVATE_SCAN, params->activate->data);
+
+	ifs_fpu_end();
+
 	rdmsrl(MSR_SCAN_STATUS, status.data);
 
 	trace_ifs_status(ifsd->cur_batch, start, stop, status.data);
-- 
2.34.1


