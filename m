Return-Path: <linux-kernel+bounces-164434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A068B7DAF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129D81C23E1A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0039C18133E;
	Tue, 30 Apr 2024 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DL/F6gz3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9520E17BB10
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495896; cv=none; b=BhYkMmPWh6Ww33EDJJ3qihK+eCkZiU75P+MQORqqwqihufaMkZk2SxYwwAzugVdgE2bGmR0FTWAP4TVg4ns6JqRIkuKyrB6qDz3B/xjb2sMqB4rda/IufCzzxhb0m7jVWdLkvkt/DyiokOP5eDx6J7ZV8Gd1E7GzX0M1c0+Ws+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495896; c=relaxed/simple;
	bh=DTmj/yYZ5S3zG9s0UR1lWeqfV7XL+xXwEY+aB15HzFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hb04UBKJKwE9IbKnm1t4pyE6Xm/0+uo6egaFitcKGvsuVOc/y2SMvnmT4VrSyq07S5QyKhUpw6Exd7Sk6Na958CthIZPoKFWR/BfXKK2+stebPMSX+bI8xe2Aux2wUBpziZpXkaWxDlIauFsituxn8+OpHb5fcN4zezU8c2FZ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DL/F6gz3; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495895; x=1746031895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DTmj/yYZ5S3zG9s0UR1lWeqfV7XL+xXwEY+aB15HzFA=;
  b=DL/F6gz3oZVlclKVMVCrLMZ4SaivuQ975UGhqVnZJcv6AYWTRDTEKlmv
   gyhSf5sHeFrJS0kFcbjE3+yDO30rSwCnFexEt33UoquqmIz13p8jLwKPj
   uQmolRaE13xoMNvzaapwpG8ObgEB7Nw0pAW7nX2H3NOitzhG+RYrmqoL6
   l6eXbdN98+8Y6CCNN/nMrRBZqCgGGVR69RI4HUWA5trWUlr/jSi9lcPGT
   RWQWu8PRC9b0vQ0jqsYI1uF16KN+4aq4MrNXM/jguEQtyQt4+CE7N9++w
   e7Chf9fZLIYprih1xP2VUMJtG8mYCgxlnJdzwVDtBQXF4JRkVOtMRLn4c
   w==;
X-CSE-ConnectionGUID: VVwmuPpOSHeQ+wjPBXt8DQ==
X-CSE-MsgGUID: xRyVPob8T0OGgh7kanDYNw==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10075624"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10075624"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:21 -0700
X-CSE-ConnectionGUID: anfkp59/Qg6H7QpFiAyMdQ==
X-CSE-MsgGUID: 6BisjhuYQrekitoFHVbG5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26515421"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:12 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH v5 07/47] KVM: VMX: Switch to new Intel CPU model defines
Date: Tue, 30 Apr 2024 09:50:20 -0700
Message-ID: <20240430165100.73491-7-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430165100.73491-1-tony.luck@intel.com>
References: <20240430164913.73473-1-tony.luck@intel.com>
 <20240430165100.73491-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Acked-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index c37a89eda90f..2c747f2642c6 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2518,17 +2518,15 @@ static bool cpu_has_sgx(void)
  */
 static bool cpu_has_perf_global_ctrl_bug(void)
 {
-	if (boot_cpu_data.x86 == 0x6) {
-		switch (boot_cpu_data.x86_model) {
-		case INTEL_FAM6_NEHALEM_EP:	/* AAK155 */
-		case INTEL_FAM6_NEHALEM:	/* AAP115 */
-		case INTEL_FAM6_WESTMERE:	/* AAT100 */
-		case INTEL_FAM6_WESTMERE_EP:	/* BC86,AAY89,BD102 */
-		case INTEL_FAM6_NEHALEM_EX:	/* BA97 */
-			return true;
-		default:
-			break;
-		}
+	switch (boot_cpu_data.x86_vfm) {
+	case INTEL_NEHALEM_EP:	/* AAK155 */
+	case INTEL_NEHALEM:	/* AAP115 */
+	case INTEL_WESTMERE:	/* AAT100 */
+	case INTEL_WESTMERE_EP:	/* BC86,AAY89,BD102 */
+	case INTEL_NEHALEM_EX:	/* BA97 */
+		return true;
+	default:
+		break;
 	}
 
 	return false;
-- 
2.44.0


