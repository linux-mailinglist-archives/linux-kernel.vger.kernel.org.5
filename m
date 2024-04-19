Return-Path: <linux-kernel+bounces-151833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B498AB488
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC46D1F2243C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA9413AD28;
	Fri, 19 Apr 2024 17:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XbODikgj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C14713AA49
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 17:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713548838; cv=none; b=mkjUbzVja2nqNhA3S3X+HVgUK/4PAaPNeD9v+rrxjzi/LVjUGLAD+6G1gNO/TlfU8qLvsYCHIRmyh/YI929c6X16QlPcF4syMN0jTer5hDe/aliQ88CkA1VAboDRAU3eD3P2txXFUfObNqluswYUhFFbajPnKSkYYKi2U+Cm94Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713548838; c=relaxed/simple;
	bh=rKdIz8bODpfYXkMRjJX1iea8o8ZfdsGpCLn7v3ZMJc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chQoMyMpEeDIpNyuVYMfu1CBq+Kg5Ow9Xnq1eUZ/wWHt1IXEDwMYAZbyQvbdFrrN81JFuS5EG6reeSMdSCgCZ83na++CnnVs9Gmo0f4xSVUC4VxnHAa2hX5FHfNzJy6pIT4ba+VWDPWG7AwIrMQMJEkpyg9z1oLHEbqalTCdPlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XbODikgj; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713548838; x=1745084838;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rKdIz8bODpfYXkMRjJX1iea8o8ZfdsGpCLn7v3ZMJc0=;
  b=XbODikgjuWQIQcgHWAn2Sfd6vyL4ufHtKaTt5kL1WAx/14QXdAQP1VI2
   H1NZvfRea9EE2YHCPvEKe01oub5T5tWffYh9eTgTpJfSPqs3t9rfRwk9O
   kEgjoPG2Z5zQO31SdkNyHE4biN0sBYhRZj0tZx2eKkT8IPqBVj7/fcGIw
   88FuGVVqhWormUO1G+RFvaeH4DJf6SMzySk3fM8Gh/GZ6DSNI+NYS+dYH
   PHaRDv8U58SWNUHE9FNxr9el4rMs9YoGCWC5nbIqStU+gd+6iN5raeW8R
   feUl0BYUdUa0NYH+a3dPz89v9pSqrDDPfCbXvZgzV7l+cT+vEdLbM4B0V
   Q==;
X-CSE-ConnectionGUID: THck89pvT1mB3lERmLvqQA==
X-CSE-MsgGUID: VlUiKMyZQZe3d2+s1bc3pA==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="9384581"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="9384581"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 10:47:17 -0700
X-CSE-ConnectionGUID: vaTzWpgjQISFo/slmjXcVg==
X-CSE-MsgGUID: EIUKYVtLRBK611TfljtbBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="28048284"
Received: from jncarlic-mobl1.amr.corp.intel.com (HELO desk) ([10.209.73.101])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 10:47:16 -0700
Date: Fri, 19 Apr 2024 10:47:09 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dan.j.williams@intel.com, bernie.keany@intel.com,
	charishma1.gairuboyina@intel.com, chang.seok.bae@intel.com,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	daniel.sneddon@linux.intel.com,
	antonio.gomez.iglesias@linux.intel.com
Subject: [PATCH 15/14] x86/gds: Lock GDS mitigation when keylocker feature is
 present
Message-ID: <20240419-gds-lock-v1-1-adcbef6ce24b@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAK+rImYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDE0ML3fSUYt2c/ORsXSOz1OSk5FQLCxNzAyWg8oKi1LTMCrBR0bG1tQD
 wXRdIWgAAAA==
X-Mailer: b4 0.12.3
References: <20240407230432.912290-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407230432.912290-1-chang.seok.bae@intel.com>

In order to safely enable Intel Keylocker feature, Gather Data Sampling
(GDS) mitigation should be enabled and locked. Hardware provides a way to
lock the mitigation, such that the mitigation cannot be disabled until the
CPU is reset. Currently, GDS mitigation is enabled without the lock.

Below is the recommendation from Intel:

  "Intel recommends that system software does not enable Key Locker (by
  setting CR4.KL) unless the GDS mitigation is enabled (IA32_MCU_OPT_CTRL
  [GDS_MITG_DIS] (bit 4) is 0) and locked (IA32_MCU_OPT_CTRL
  [GDS_MITG_LOCK](bit 5) is 1). This will prevent an adversary that takes
  control of the system from turning off the mitigation in order to infer
  the keys behind Key Locker handles." [1]

When GDS mitigation is enabled, and Keylocker feature is present, also lock
the mitigation.

[1] Gather Data Sampling (ID# 785676)
    https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/gather-data-sampling.html

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
This should ideally go before the patch that enables Keylocker. It is
only compile tested.

 arch/x86/kernel/cpu/bugs.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ca295b0c1eee..2777a58110e0 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -755,8 +755,8 @@ EXPORT_SYMBOL_GPL(gds_ucode_mitigated);
 
 void update_gds_msr(void)
 {
-	u64 mcu_ctrl_after;
-	u64 mcu_ctrl;
+	u64 mcu_ctrl, mcu_ctrl_after;
+	u64 gds_lock = 0;
 
 	switch (gds_mitigation) {
 	case GDS_MITIGATION_OFF:
@@ -769,6 +769,8 @@ void update_gds_msr(void)
 		 * the same state. Make sure the mitigation is enabled on all
 		 * CPUs.
 		 */
+		gds_lock = GDS_MITG_LOCKED;
+		fallthrough;
 	case GDS_MITIGATION_FULL:
 		rdmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
 		mcu_ctrl &= ~GDS_MITG_DIS;
@@ -779,6 +781,7 @@ void update_gds_msr(void)
 		return;
 	}
 
+	mcu_ctrl |= gds_lock;
 	wrmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
 
 	/*
@@ -840,6 +843,11 @@ static void __init gds_select_mitigation(void)
 		gds_mitigation = GDS_MITIGATION_FULL_LOCKED;
 	}
 
+	/* Keylocker can only be enabled when GDS mitigation is locked */
+	if (boot_cpu_has(X86_FEATURE_KEYLOCKER) &&
+	    gds_mitigation == GDS_MITIGATION_FULL)
+		gds_mitigation = GDS_MITIGATION_FULL_LOCKED;
+
 	update_gds_msr();
 out:
 	pr_info("%s\n", gds_strings[gds_mitigation]);

---
base-commit: 0bbac3facb5d6cc0171c45c9873a2dc96bea9680
change-id: 20240418-gds-lock-26ecbce88470

Best regards,
-- 
Thanks,
Pawan


