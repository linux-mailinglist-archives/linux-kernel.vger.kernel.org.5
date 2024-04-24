Return-Path: <linux-kernel+bounces-157493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BEE8B121F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240311F21362
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F2A1A0B1F;
	Wed, 24 Apr 2024 18:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SndRomky"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F9C190671
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 18:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982529; cv=none; b=nTOvpom/Vt6LhWXqdatf8ztowQIHhzzhUbsih9dqMkblVuwx/qLcItcfiRV2YSTXQLlqZDxjctgl/eNZVkScT7hZfzIA2fcEyhfHgRruU7KgPp0E6HF+Z62xpqXJuxe5jYK729hKSzvBK2UdJ/g30T+KYs7TVkc7C55LFMbI/tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982529; c=relaxed/simple;
	bh=MGAFX/pQ0txb1l1dIq0DhSgBPKYTlahDlBrDWyImM3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWWW9YWl/CE5VqJphfEyMFjbG5wuaH0HcwaxTQ3rq/YudN8h7s145lsLxyrQ8GGt+eV6P9tzfM4HKKo6IR0zVerBEvOpFMYNA1LLYsTIBT+9t5xZj5eT4XZhvEbjnmpSdLqVFjXSR6P3t2u9xk0sw0vaQz7yota2L8gSmNNfeEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SndRomky; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982528; x=1745518528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MGAFX/pQ0txb1l1dIq0DhSgBPKYTlahDlBrDWyImM3Q=;
  b=SndRomkyrpBN3cZ/8nH4LrDKGL8eMttq+r0hann2iCb3yXfSLNraC4j6
   Eb1IJ+CpKtmLN2Ep1LrIltUQbkV/opXC2FMx91nzZwjvCeslO7jZxLP6g
   lCUV/lDnDcpkuOM2u8Y8y1z5pt0NHDUS9TeRWFVn8pWyK6TYJFuF0NO9p
   jJz/uYhlYvT4rh9w9s5Zst0UaZpc3aL/90N/yLFX4FXS5HiVz+4ueyxZu
   MilWzs8jkmXCeBOuf3MDOiu1PJPOm9T6tisDRChiPwoIlmoALnxioNy0V
   p3QNYmgGS08prtnzdYswst19U1H2LAyKWuDoDy2EQChcsklwwqzDUflQF
   A==;
X-CSE-ConnectionGUID: hA5Fd0OYR1GRi1kJwbpktw==
X-CSE-MsgGUID: qGbu+TWNSRqFuSbfWjaROg==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9482049"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9482049"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:16 -0700
X-CSE-ConnectionGUID: 6+UXyGROQ1+HXtAw5ajgGA==
X-CSE-MsgGUID: 8mzt6r6xRDSmxfuTjnF+oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29262780"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:16 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 38/71] x86/cpu/: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:16 -0700
Message-ID: <20240424181516.41887-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424181245.41141-1-tony.luck@intel.com>
References: <20240424181245.41141-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/smpboot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index a58109583c47..8dc83b16845b 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -438,9 +438,9 @@ static bool match_pkg(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
  */
 
 static const struct x86_cpu_id intel_cod_cpu[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X, 0),	/* COD */
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X, 0),	/* COD */
-	X86_MATCH_INTEL_FAM6_MODEL(ANY, 1),		/* SNC */
+	X86_MATCH_VFM(INTEL_HASWELL_X, 0),	/* COD */
+	X86_MATCH_VFM(INTEL_BROADWELL_X, 0),	/* COD */
+	X86_MATCH_VFM(INTEL_ANY, 1),		/* SNC */
 	{}
 };
 
-- 
2.44.0


