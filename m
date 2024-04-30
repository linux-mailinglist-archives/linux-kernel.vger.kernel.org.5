Return-Path: <linux-kernel+bounces-164749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CF18B8205
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0959FB21280
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168D41BED74;
	Tue, 30 Apr 2024 21:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZBBbcPhV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B782B1E52C;
	Tue, 30 Apr 2024 21:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714513279; cv=none; b=As7W+g85etL3pjbzVQuNV8xoAAa8BMTPsYClcKN1LrHdUM9Ft6zlCpMRant4g0Oa2i7dN6tSHpF7X27BzBvuh5dFKjoDd1qsiuEoxZK5Eq2FefBPiojAVUHPy7kZIrN5axEhKA+F4nXQ266U+paoldTLsol6nv0m/tspN1Br2wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714513279; c=relaxed/simple;
	bh=9/DOjDzMqqIpe1Cr5IpxE30sH9jmN38JRgc2UZCcRY4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZUvnTqOLqNuAGkfUW9QBYfGcG7z+nmvT66KAN4UdbHIE4Qz3WrpioDIPP0jKy/OyCydSiE8uD7+nI4IwP5lo8uveIqxdsymOCHI40RFm4XM/qxQcyONWFSsfSNERkiY5EbPUKOhpebPfPEzWvE1VTYSpCMDXgmQeRL6EMYV9YX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZBBbcPhV; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714513278; x=1746049278;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9/DOjDzMqqIpe1Cr5IpxE30sH9jmN38JRgc2UZCcRY4=;
  b=ZBBbcPhVltPj7begrFMCcJ4Urnu/JjGWAJKfCqmDDs1cxPEx4XcK+1wx
   YHTn4FDmNgV4jxV/81KiYDD1uAsPAXEwhhK7DvpZ9vCHkaEB5lw+woEZg
   1+PNp8OA0taz4o/RfAFfMkPDmeR3zSV33qK5t8eZXLBMcsEQoBcZf7g20
   w+Uzu3LOMbgUnfuFNRJrXY4/0hIgF80wZ/8txfdwO0WcGmNZiO5xwNhRL
   7ix0getK9FVGwx9BYlxkJpVrn4zb0kYrlR357RRAaD1tq8Ad4WFFwv2Fr
   rhIAvBTnKcbPbbD/q+uGdtW7fLX40jQiOaIHcuON5EPH5p089l+sjDaW9
   g==;
X-CSE-ConnectionGUID: PW5ojW1QTvu6gmapnjZ93A==
X-CSE-MsgGUID: au6V1T2pRSaXsqq2WXX8bw==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="14023056"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="14023056"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 14:41:17 -0700
X-CSE-ConnectionGUID: jyIqOWrdSd6haZJlHP9tDQ==
X-CSE-MsgGUID: 8vyoVP9ORxifald+d/axjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="26693363"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmviesa006.fm.intel.com with ESMTP; 30 Apr 2024 14:41:16 -0700
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
Subject: [PATCH 0/2] x86/fpu: Extend kernel_fpu_begin_mask() for the In-Field Scan driver
Date: Tue, 30 Apr 2024 14:25:06 -0700
Message-Id: <20240430212508.105117-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recent update [1] in the SDM highlights the requirement of
initializing the AMX state for executing the scan test:
    "... maintaining AMX state in a non-initialized state ... will
     prevent the execution of In-Field Scan tests."
which is one of CPU state conditions required for the test's execution.

In situations where AMX workloads are running, the switched-away active
user AMX state remains due to the optimization to reduce the state
switching cost. A user state reload is fully completed right before
returning to userspace. Consequently, if the switched-in kernel task is
executing the scan test, this non-initialized AMX state causes the test
to be unable to start.

Given the benefit of the scan test in detecting hardware faults, ensuring
its seamless execution is not negligible. This necessitates a proper API
for the driver code to initialize AMX states. Although fpu_idle_fpregs()
may initialize the AMX state, its primary usage should be limited to
sleep state handling, making it unsuitable for the scan test.

The across-architecture FPU API, kernel_fpu_begin()/kernel_fpu_end(), is
universally established for floating-point SIMD code in the kernel. On
x86, kernel_fpu_begin_mask() is available, with kernel_fpu_begin()
serving as a wrapper to it for initializing legacy states by default.

The proposed solution extends kernel_fpu_begin_mask() to accept a new
option for initializing the AMX state. Additionally, it introduces custom
FPU handling wrappers for the In-Field Scan driver, which are variants of
kernel_fpu_begin()/kernel_fpu_end(). This approach is considerably
compliant with established semantics, following the EFI case with
efi_fpu_begin/efi_fpu_end().

Thanks,
Chang

[1] Intel Software Development Manual as of March 2024, Section 18.2
    RECOMMENDATIONS FOR SYSTEM SOFTWARE of Vol. 1.
    https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html

Chang S. Bae (2):
  x86/fpu: Extend kernel_fpu_begin_mask() to initialize AMX state
  platform/x86/intel/ifs: Initialize AMX state for the scan test

 arch/x86/include/asm/fpu/api.h           |  1 +
 arch/x86/kernel/fpu/core.c               |  3 +++
 drivers/platform/x86/intel/ifs/ifs.h     | 14 ++++++++++++++
 drivers/platform/x86/intel/ifs/runtest.c |  6 ++++++
 4 files changed, 24 insertions(+)


base-commit: e67572cd2204894179d89bd7b984072f19313b03
-- 
2.34.1


