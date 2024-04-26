Return-Path: <linux-kernel+bounces-159389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7968B2E08
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E6D5B2437C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A768B79C2;
	Fri, 26 Apr 2024 00:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OtX4pLh2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38F1EBB;
	Fri, 26 Apr 2024 00:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714091281; cv=none; b=MtrIj+I1iXzsXsh1qIeun3t/j49eTmd4eYiyEgFzrqnCbbZ8bmMLraMNxaxXKStkQOXQmHD8CfuZ6qbFOKCqZ99tIRwFVp1KhkfG8rfVZ/bI/x1nXnj90y7uqqMkwyV4w1lI/kpoPP7GqnaO5VQWa+P17vg6rDN9Q6qhEX4knNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714091281; c=relaxed/simple;
	bh=fNSQUKajkY14dXOulMQolDzKLN020Rd/6riFy5IqAHQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NU0artQheyUlRm6KJWY/JV2OmbCvkKfTdQyU6OWPeUKEYTef3CUMnFUznpupdFntJWe3pDjW+32TLVFV/3xkMqwy9GWQooLnZpT55NYR5SZMD6xk+dodKTn0agTz+eeumngpvMWs45R1vQoEav9rSciB8AoIrVSBOwWuBzbSUCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OtX4pLh2; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714091279; x=1745627279;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=fNSQUKajkY14dXOulMQolDzKLN020Rd/6riFy5IqAHQ=;
  b=OtX4pLh218VzKhWPHVvFAwwe/8YhXFG2qWivNV5b4YykuIK6anIskI1R
   YNL1K/kdVlDNLwDiDq+suQ0avRHd5HWo1VxaAWjsd/Ue3/RlCMaJlMit1
   s2KyBkcfGI5M/docCW/UGFgTSWYi37oVX3T6Xnvf5SvxDFE8pLNHAv5vA
   YUHnUV+N7JZW3cyfnC0qIP5UNzvovtYfL67uc/tkmtPIBFy3Rzfk9gQB4
   TyvvS9LqB0xs3LuxMB4a9sj9ZwlRZktEG1VMBun511L85pQYwyFJpYmOr
   IDbA1LG/DHfXrU0Yc6hEtcChKNz03ntmA4AWt6iIiaS7yF0B/igEx+Xq0
   A==;
X-CSE-ConnectionGUID: hfbLy9sAR/+A8prp0WvDTg==
X-CSE-MsgGUID: 6l2biA+0SZm/fEsnm06cXQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="9650250"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="9650250"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 17:27:56 -0700
X-CSE-ConnectionGUID: ZYRiFEyMSVSBjPqemX7WrQ==
X-CSE-MsgGUID: 4xnSy4oySIa2a5m/s4UJEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="25329117"
Received: from breannah-mobl.amr.corp.intel.com (HELO xpardee-test1.hsd1.or.comcast.net) ([10.209.32.125])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 17:27:56 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] platform/x86:intel/pmc: Enable S0ix blocker show in Lunar Lake
Date: Thu, 25 Apr 2024 17:27:52 -0700
Message-Id: <20240426002752.2504282-4-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426002752.2504282-1-xi.pardee@linux.intel.com>
References: <20240426002752.2504282-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Xi Pardee <xi.pardee@intel.com>

Update Lunar Lake lpm maps to include S0ix blocker information.
Add Lunar Lake blocker maps to enable S0ix blocker show in pmc
core debugfs.

Signed-off-by: Xi Pardee <xi.pardee@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.h |   2 +
 drivers/platform/x86/intel/pmc/lnl.c  | 485 ++++++++++++++------------
 2 files changed, 261 insertions(+), 226 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 88acfa801b5a..ea04de7eb9e8 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -283,6 +283,7 @@ enum ppfear_regs {
 #define LNL_PMC_LTR_OSSE			0x1B88
 #define LNL_NUM_IP_IGN_ALLOWED			27
 #define LNL_PPFEAR_NUM_ENTRIES			12
+#define LNL_S0IX_BLOCKER_OFFSET			0x2004
 
 extern const char *pmc_lpm_modes[];
 
@@ -541,6 +542,7 @@ extern const struct pmc_bit_map lnl_vnn_req_status_2_map[];
 extern const struct pmc_bit_map lnl_vnn_req_status_3_map[];
 extern const struct pmc_bit_map lnl_vnn_misc_status_map[];
 extern const struct pmc_bit_map *lnl_lpm_maps[];
+extern const struct pmc_bit_map *lnl_blk_maps[];
 extern const struct pmc_bit_map lnl_pfear_map[];
 extern const struct pmc_bit_map *ext_lnl_pfear_map[];
 extern const struct pmc_bit_map lnl_signal_status_map[];
diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
index 82c881653f86..e7a8077d1a3e 100644
--- a/drivers/platform/x86/intel/pmc/lnl.c
+++ b/drivers/platform/x86/intel/pmc/lnl.c
@@ -56,284 +56,296 @@ const struct pmc_bit_map lnl_ltr_show_map[] = {
 };
 
 const struct pmc_bit_map lnl_power_gating_status_0_map[] = {
-	{"PMC_PGD0_PG_STS",			BIT(0)},
-	{"FUSE_OSSE_PGD0_PG_STS",		BIT(1)},
-	{"ESPISPI_PGD0_PG_STS",			BIT(2)},
-	{"XHCI_PGD0_PG_STS",			BIT(3)},
-	{"SPA_PGD0_PG_STS",			BIT(4)},
-	{"SPB_PGD0_PG_STS",			BIT(5)},
-	{"SPR16B0_PGD0_PG_STS",			BIT(6)},
-	{"GBE_PGD0_PG_STS",			BIT(7)},
-	{"SBR8B7_PGD0_PG_STS",			BIT(8)},
-	{"SBR8B6_PGD0_PG_STS",			BIT(9)},
-	{"SBR16B1_PGD0_PG_STS",			BIT(10)},
-	{"SBR8B8_PGD0_PG_STS",			BIT(11)},
-	{"ESE_PGD3_PG_STS",			BIT(12)},
-	{"D2D_DISP_PGD0_PG_STS",		BIT(13)},
-	{"LPSS_PGD0_PG_STS",			BIT(14)},
-	{"LPC_PGD0_PG_STS",			BIT(15)},
-	{"SMB_PGD0_PG_STS",			BIT(16)},
-	{"ISH_PGD0_PG_STS",			BIT(17)},
-	{"SBR8B2_PGD0_PG_STS",			BIT(18)},
-	{"NPK_PGD0_PG_STS",			BIT(19)},
-	{"D2D_NOC_PGD0_PG_STS",			BIT(20)},
-	{"SAFSS_PGD0_PG_STS",			BIT(21)},
-	{"FUSE_PGD0_PG_STS",			BIT(22)},
-	{"D2D_DISP_PGD1_PG_STS",		BIT(23)},
-	{"MPFPW1_PGD0_PG_STS",			BIT(24)},
-	{"XDCI_PGD0_PG_STS",			BIT(25)},
-	{"EXI_PGD0_PG_STS",			BIT(26)},
-	{"CSE_PGD0_PG_STS",			BIT(27)},
-	{"KVMCC_PGD0_PG_STS",			BIT(28)},
-	{"PMT_PGD0_PG_STS",			BIT(29)},
-	{"CLINK_PGD0_PG_STS",			BIT(30)},
-	{"PTIO_PGD0_PG_STS",			BIT(31)},
+	{"PMC_PGD0_PG_STS",			BIT(0),		0},
+	{"FUSE_OSSE_PGD0_PG_STS",		BIT(1),		0},
+	{"ESPISPI_PGD0_PG_STS",			BIT(2),		0},
+	{"XHCI_PGD0_PG_STS",			BIT(3),		1},
+	{"SPA_PGD0_PG_STS",			BIT(4),		1},
+	{"SPB_PGD0_PG_STS",			BIT(5),		1},
+	{"SPR16B0_PGD0_PG_STS",			BIT(6),		0},
+	{"GBE_PGD0_PG_STS",			BIT(7),		1},
+	{"SBR8B7_PGD0_PG_STS",			BIT(8),		0},
+	{"SBR8B6_PGD0_PG_STS",			BIT(9),		0},
+	{"SBR16B1_PGD0_PG_STS",			BIT(10),	0},
+	{"SBR8B8_PGD0_PG_STS",			BIT(11),	0},
+	{"ESE_PGD3_PG_STS",			BIT(12),	1},
+	{"D2D_DISP_PGD0_PG_STS",		BIT(13),	1},
+	{"LPSS_PGD0_PG_STS",			BIT(14),	1},
+	{"LPC_PGD0_PG_STS",			BIT(15),	0},
+	{"SMB_PGD0_PG_STS",			BIT(16),	0},
+	{"ISH_PGD0_PG_STS",			BIT(17),	0},
+	{"SBR8B2_PGD0_PG_STS",			BIT(18),	0},
+	{"NPK_PGD0_PG_STS",			BIT(19),	0},
+	{"D2D_NOC_PGD0_PG_STS",			BIT(20),	0},
+	{"SAFSS_PGD0_PG_STS",			BIT(21),	0},
+	{"FUSE_PGD0_PG_STS",			BIT(22),	0},
+	{"D2D_DISP_PGD1_PG_STS",		BIT(23),	1},
+	{"MPFPW1_PGD0_PG_STS",			BIT(24),	0},
+	{"XDCI_PGD0_PG_STS",			BIT(25),	1},
+	{"EXI_PGD0_PG_STS",			BIT(26),	0},
+	{"CSE_PGD0_PG_STS",			BIT(27),	1},
+	{"KVMCC_PGD0_PG_STS",			BIT(28),	1},
+	{"PMT_PGD0_PG_STS",			BIT(29),	1},
+	{"CLINK_PGD0_PG_STS",			BIT(30),	1},
+	{"PTIO_PGD0_PG_STS",			BIT(31),	1},
 	{}
 };
 
 const struct pmc_bit_map lnl_power_gating_status_1_map[] = {
-	{"USBR0_PGD0_PG_STS",			BIT(0)},
-	{"SUSRAM_PGD0_PG_STS",			BIT(1)},
-	{"SMT1_PGD0_PG_STS",			BIT(2)},
-	{"U3FPW1_PGD0_PG_STS",			BIT(3)},
-	{"SMS2_PGD0_PG_STS",			BIT(4)},
-	{"SMS1_PGD0_PG_STS",			BIT(5)},
-	{"CSMERTC_PGD0_PG_STS",			BIT(6)},
-	{"CSMEPSF_PGD0_PG_STS",			BIT(7)},
-	{"FIA_PG_PGD0_PG_STS",			BIT(8)},
-	{"SBR16B4_PGD0_PG_STS",			BIT(9)},
-	{"P2SB8B_PGD0_PG_STS",			BIT(10)},
-	{"DBG_SBR_PGD0_PG_STS",			BIT(11)},
-	{"SBR8B9_PGD0_PG_STS",			BIT(12)},
-	{"OSSE_SMT1_PGD0_PG_STS",		BIT(13)},
-	{"SBR8B10_PGD0_PG_STS",			BIT(14)},
-	{"SBR16B3_PGD0_PG_STS",			BIT(15)},
-	{"G5FPW1_PGD0_PG_STS",			BIT(16)},
-	{"SBRG_PGD0_PG_STS",			BIT(17)},
-	{"PSF4_PGD0_PG_STS",			BIT(18)},
-	{"CNVI_PGD0_PG_STS",			BIT(19)},
-	{"USFX2_PGD0_PG_STS",			BIT(20)},
-	{"ENDBG_PGD0_PG_STS",			BIT(21)},
-	{"FIACPCB_P5X4_PGD0_PG_STS",		BIT(22)},
-	{"SBR8B3_PGD0_PG_STS",			BIT(23)},
-	{"SBR8B0_PGD0_PG_STS",			BIT(24)},
-	{"NPK_PGD1_PG_STS",			BIT(25)},
-	{"OSSE_HOTHAM_PGD0_PG_STS",		BIT(26)},
-	{"D2D_NOC_PGD2_PG_STS",			BIT(27)},
-	{"SBR8B1_PGD0_PG_STS",			BIT(28)},
-	{"PSF6_PGD0_PG_STS",			BIT(29)},
-	{"PSF7_PGD0_PG_STS",			BIT(30)},
-	{"FIA_U_PGD0_PG_STS",			BIT(31)},
+	{"USBR0_PGD0_PG_STS",			BIT(0),		1},
+	{"SUSRAM_PGD0_PG_STS",			BIT(1),		1},
+	{"SMT1_PGD0_PG_STS",			BIT(2),		1},
+	{"U3FPW1_PGD0_PG_STS",			BIT(3),		0},
+	{"SMS2_PGD0_PG_STS",			BIT(4),		1},
+	{"SMS1_PGD0_PG_STS",			BIT(5),		1},
+	{"CSMERTC_PGD0_PG_STS",			BIT(6),		0},
+	{"CSMEPSF_PGD0_PG_STS",			BIT(7),		0},
+	{"FIA_PG_PGD0_PG_STS",			BIT(8),		0},
+	{"SBR16B4_PGD0_PG_STS",			BIT(9),		0},
+	{"P2SB8B_PGD0_PG_STS",			BIT(10),	1},
+	{"DBG_SBR_PGD0_PG_STS",			BIT(11),	0},
+	{"SBR8B9_PGD0_PG_STS",			BIT(12),	0},
+	{"OSSE_SMT1_PGD0_PG_STS",		BIT(13),	1},
+	{"SBR8B10_PGD0_PG_STS",			BIT(14),	0},
+	{"SBR16B3_PGD0_PG_STS",			BIT(15),	0},
+	{"G5FPW1_PGD0_PG_STS",			BIT(16),	0},
+	{"SBRG_PGD0_PG_STS",			BIT(17),	0},
+	{"PSF4_PGD0_PG_STS",			BIT(18),	0},
+	{"CNVI_PGD0_PG_STS",			BIT(19),	0},
+	{"USFX2_PGD0_PG_STS",			BIT(20),	1},
+	{"ENDBG_PGD0_PG_STS",			BIT(21),	0},
+	{"FIACPCB_P5X4_PGD0_PG_STS",		BIT(22),	0},
+	{"SBR8B3_PGD0_PG_STS",			BIT(23),	0},
+	{"SBR8B0_PGD0_PG_STS",			BIT(24),	0},
+	{"NPK_PGD1_PG_STS",			BIT(25),	0},
+	{"OSSE_HOTHAM_PGD0_PG_STS",		BIT(26),	1},
+	{"D2D_NOC_PGD2_PG_STS",			BIT(27),	1},
+	{"SBR8B1_PGD0_PG_STS",			BIT(28),	0},
+	{"PSF6_PGD0_PG_STS",			BIT(29),	0},
+	{"PSF7_PGD0_PG_STS",			BIT(30),	0},
+	{"FIA_U_PGD0_PG_STS",			BIT(31),	0},
 	{}
 };
 
 const struct pmc_bit_map lnl_power_gating_status_2_map[] = {
-	{"PSF8_PGD0_PG_STS",			BIT(0)},
-	{"SBR16B2_PGD0_PG_STS",			BIT(1)},
-	{"D2D_IPU_PGD0_PG_STS",			BIT(2)},
-	{"FIACPCB_U_PGD0_PG_STS",		BIT(3)},
-	{"TAM_PGD0_PG_STS",			BIT(4)},
-	{"D2D_NOC_PGD1_PG_STS",			BIT(5)},
-	{"TBTLSX_PGD0_PG_STS",			BIT(6)},
-	{"THC0_PGD0_PG_STS",			BIT(7)},
-	{"THC1_PGD0_PG_STS",			BIT(8)},
-	{"PMC_PGD0_PG_STS",			BIT(9)},
-	{"SBR8B5_PGD0_PG_STS",			BIT(10)},
-	{"UFSPW1_PGD0_PG_STS",			BIT(11)},
-	{"DBC_PGD0_PG_STS",			BIT(12)},
-	{"TCSS_PGD0_PG_STS",			BIT(13)},
-	{"FIA_P5X4_PGD0_PG_STS",		BIT(14)},
-	{"DISP_PGA_PGD0_PG_STS",		BIT(15)},
-	{"DISP_PSF_PGD0_PG_STS",		BIT(16)},
-	{"PSF0_PGD0_PG_STS",			BIT(17)},
-	{"P2SB16B_PGD0_PG_STS",			BIT(18)},
-	{"ACE_PGD0_PG_STS",			BIT(19)},
-	{"ACE_PGD1_PG_STS",			BIT(20)},
-	{"ACE_PGD2_PG_STS",			BIT(21)},
-	{"ACE_PGD3_PG_STS",			BIT(22)},
-	{"ACE_PGD4_PG_STS",			BIT(23)},
-	{"ACE_PGD5_PG_STS",			BIT(24)},
-	{"ACE_PGD6_PG_STS",			BIT(25)},
-	{"ACE_PGD7_PG_STS",			BIT(26)},
-	{"ACE_PGD8_PG_STS",			BIT(27)},
-	{"ACE_PGD9_PG_STS",			BIT(28)},
-	{"ACE_PGD10_PG_STS",			BIT(29)},
-	{"FIACPCB_PG_PGD0_PG_STS",		BIT(30)},
-	{"OSSE_PGD0_PG_STS",			BIT(31)},
+	{"PSF8_PGD0_PG_STS",			BIT(0),		0},
+	{"SBR16B2_PGD0_PG_STS",			BIT(1),		0},
+	{"D2D_IPU_PGD0_PG_STS",			BIT(2),		1},
+	{"FIACPCB_U_PGD0_PG_STS",		BIT(3),		0},
+	{"TAM_PGD0_PG_STS",			BIT(4),		1},
+	{"D2D_NOC_PGD1_PG_STS",			BIT(5),		1},
+	{"TBTLSX_PGD0_PG_STS",			BIT(6),		1},
+	{"THC0_PGD0_PG_STS",			BIT(7),		1},
+	{"THC1_PGD0_PG_STS",			BIT(8),		1},
+	{"PMC_PGD0_PG_STS",			BIT(9),		0},
+	{"SBR8B5_PGD0_PG_STS",			BIT(10),	0},
+	{"UFSPW1_PGD0_PG_STS",			BIT(11),	0},
+	{"DBC_PGD0_PG_STS",			BIT(12),	0},
+	{"TCSS_PGD0_PG_STS",			BIT(13),	0},
+	{"FIA_P5X4_PGD0_PG_STS",		BIT(14),	0},
+	{"DISP_PGA_PGD0_PG_STS",		BIT(15),	0},
+	{"DISP_PSF_PGD0_PG_STS",		BIT(16),	0},
+	{"PSF0_PGD0_PG_STS",			BIT(17),	0},
+	{"P2SB16B_PGD0_PG_STS",			BIT(18),	1},
+	{"ACE_PGD0_PG_STS",			BIT(19),	0},
+	{"ACE_PGD1_PG_STS",			BIT(20),	0},
+	{"ACE_PGD2_PG_STS",			BIT(21),	0},
+	{"ACE_PGD3_PG_STS",			BIT(22),	0},
+	{"ACE_PGD4_PG_STS",			BIT(23),	0},
+	{"ACE_PGD5_PG_STS",			BIT(24),	0},
+	{"ACE_PGD6_PG_STS",			BIT(25),	0},
+	{"ACE_PGD7_PG_STS",			BIT(26),	0},
+	{"ACE_PGD8_PG_STS",			BIT(27),	0},
+	{"ACE_PGD9_PG_STS",			BIT(28),	0},
+	{"ACE_PGD10_PG_STS",			BIT(29),	0},
+	{"FIACPCB_PG_PGD0_PG_STS",		BIT(30),	0},
+	{"OSSE_PGD0_PG_STS",			BIT(31),	1},
 	{}
 };
 
 const struct pmc_bit_map lnl_d3_status_0_map[] = {
-	{"LPSS_D3_STS",				BIT(3)},
-	{"XDCI_D3_STS",				BIT(4)},
-	{"XHCI_D3_STS",				BIT(5)},
-	{"SPA_D3_STS",				BIT(12)},
-	{"SPB_D3_STS",				BIT(13)},
-	{"OSSE_D3_STS",				BIT(15)},
-	{"ESPISPI_D3_STS",			BIT(18)},
-	{"PSTH_D3_STS",				BIT(21)},
+	{"LPSS_D3_STS",				BIT(3),		1},
+	{"XDCI_D3_STS",				BIT(4),		1},
+	{"XHCI_D3_STS",				BIT(5),		1},
+	{"SPA_D3_STS",				BIT(12),	0},
+	{"SPB_D3_STS",				BIT(13),	0},
+	{"OSSE_D3_STS",				BIT(15),	0},
+	{"ESPISPI_D3_STS",			BIT(18),	0},
+	{"PSTH_D3_STS",				BIT(21),	0},
 	{}
 };
 
 const struct pmc_bit_map lnl_d3_status_1_map[] = {
-	{"OSSE_SMT1_D3_STS",			BIT(7)},
-	{"GBE_D3_STS",				BIT(19)},
-	{"ITSS_D3_STS",				BIT(23)},
-	{"CNVI_D3_STS",				BIT(27)},
-	{"UFSX2_D3_STS",			BIT(28)},
-	{"OSSE_HOTHAM_D3_STS",			BIT(31)},
+	{"OSSE_SMT1_D3_STS",			BIT(7),		0},
+	{"GBE_D3_STS",				BIT(19),	0},
+	{"ITSS_D3_STS",				BIT(23),	0},
+	{"CNVI_D3_STS",				BIT(27),	0},
+	{"UFSX2_D3_STS",			BIT(28),	1},
+	{"OSSE_HOTHAM_D3_STS",			BIT(31),	0},
 	{}
 };
 
 const struct pmc_bit_map lnl_d3_status_2_map[] = {
-	{"ESE_D3_STS",				BIT(0)},
-	{"CSMERTC_D3_STS",			BIT(1)},
-	{"SUSRAM_D3_STS",			BIT(2)},
-	{"CSE_D3_STS",				BIT(4)},
-	{"KVMCC_D3_STS",			BIT(5)},
-	{"USBR0_D3_STS",			BIT(6)},
-	{"ISH_D3_STS",				BIT(7)},
-	{"SMT1_D3_STS",				BIT(8)},
-	{"SMT2_D3_STS",				BIT(9)},
-	{"SMT3_D3_STS",				BIT(10)},
-	{"OSSE_SMT2_D3_STS",			BIT(13)},
-	{"CLINK_D3_STS",			BIT(14)},
-	{"PTIO_D3_STS",				BIT(16)},
-	{"PMT_D3_STS",				BIT(17)},
-	{"SMS1_D3_STS",				BIT(18)},
-	{"SMS2_D3_STS",				BIT(19)},
+	{"ESE_D3_STS",				BIT(0),		0},
+	{"CSMERTC_D3_STS",			BIT(1),		0},
+	{"SUSRAM_D3_STS",			BIT(2),		0},
+	{"CSE_D3_STS",				BIT(4),		0},
+	{"KVMCC_D3_STS",			BIT(5),		0},
+	{"USBR0_D3_STS",			BIT(6),		0},
+	{"ISH_D3_STS",				BIT(7),		0},
+	{"SMT1_D3_STS",				BIT(8),		0},
+	{"SMT2_D3_STS",				BIT(9),		0},
+	{"SMT3_D3_STS",				BIT(10),	0},
+	{"OSSE_SMT2_D3_STS",			BIT(13),	0},
+	{"CLINK_D3_STS",			BIT(14),	0},
+	{"PTIO_D3_STS",				BIT(16),	0},
+	{"PMT_D3_STS",				BIT(17),	0},
+	{"SMS1_D3_STS",				BIT(18),	0},
+	{"SMS2_D3_STS",				BIT(19),	0},
 	{}
 };
 
 const struct pmc_bit_map lnl_d3_status_3_map[] = {
-	{"THC0_D3_STS",				BIT(14)},
-	{"THC1_D3_STS",				BIT(15)},
-	{"OSSE_SMT3_D3_STS",			BIT(21)},
-	{"ACE_D3_STS",				BIT(23)},
+	{"THC0_D3_STS",				BIT(14),	1},
+	{"THC1_D3_STS",				BIT(15),	1},
+	{"OSSE_SMT3_D3_STS",			BIT(21),	0},
+	{"ACE_D3_STS",				BIT(23),	0},
 	{}
 };
 
 const struct pmc_bit_map lnl_vnn_req_status_0_map[] = {
-	{"LPSS_VNN_REQ_STS",			BIT(3)},
-	{"OSSE_VNN_REQ_STS",			BIT(15)},
-	{"ESPISPI_VNN_REQ_STS",			BIT(18)},
+	{"LPSS_VNN_REQ_STS",			BIT(3),		1},
+	{"OSSE_VNN_REQ_STS",			BIT(15),	1},
+	{"ESPISPI_VNN_REQ_STS",			BIT(18),	1},
 	{}
 };
 
 const struct pmc_bit_map lnl_vnn_req_status_1_map[] = {
-	{"NPK_VNN_REQ_STS",			BIT(4)},
-	{"OSSE_SMT1_VNN_REQ_STS",		BIT(7)},
-	{"DFXAGG_VNN_REQ_STS",			BIT(8)},
-	{"EXI_VNN_REQ_STS",			BIT(9)},
-	{"P2D_VNN_REQ_STS",			BIT(18)},
-	{"GBE_VNN_REQ_STS",			BIT(19)},
-	{"SMB_VNN_REQ_STS",			BIT(25)},
-	{"LPC_VNN_REQ_STS",			BIT(26)},
+	{"NPK_VNN_REQ_STS",			BIT(4),		1},
+	{"OSSE_SMT1_VNN_REQ_STS",		BIT(7),		1},
+	{"DFXAGG_VNN_REQ_STS",			BIT(8),		0},
+	{"EXI_VNN_REQ_STS",			BIT(9),		1},
+	{"P2D_VNN_REQ_STS",			BIT(18),	1},
+	{"GBE_VNN_REQ_STS",			BIT(19),	1},
+	{"SMB_VNN_REQ_STS",			BIT(25),	1},
+	{"LPC_VNN_REQ_STS",			BIT(26),	0},
 	{}
 };
 
 const struct pmc_bit_map lnl_vnn_req_status_2_map[] = {
-	{"eSE_VNN_REQ_STS",			BIT(0)},
-	{"CSMERTC_VNN_REQ_STS",			BIT(1)},
-	{"CSE_VNN_REQ_STS",			BIT(4)},
-	{"ISH_VNN_REQ_STS",			BIT(7)},
-	{"SMT1_VNN_REQ_STS",			BIT(8)},
-	{"CLINK_VNN_REQ_STS",			BIT(14)},
-	{"SMS1_VNN_REQ_STS",			BIT(18)},
-	{"SMS2_VNN_REQ_STS",			BIT(19)},
-	{"GPIOCOM4_VNN_REQ_STS",		BIT(20)},
-	{"GPIOCOM3_VNN_REQ_STS",		BIT(21)},
-	{"GPIOCOM2_VNN_REQ_STS",		BIT(22)},
-	{"GPIOCOM1_VNN_REQ_STS",		BIT(23)},
-	{"GPIOCOM0_VNN_REQ_STS",		BIT(24)},
+	{"eSE_VNN_REQ_STS",			BIT(0),		1},
+	{"CSMERTC_VNN_REQ_STS",			BIT(1),		1},
+	{"CSE_VNN_REQ_STS",			BIT(4),		1},
+	{"ISH_VNN_REQ_STS",			BIT(7),		1},
+	{"SMT1_VNN_REQ_STS",			BIT(8),		1},
+	{"CLINK_VNN_REQ_STS",			BIT(14),	1},
+	{"SMS1_VNN_REQ_STS",			BIT(18),	1},
+	{"SMS2_VNN_REQ_STS",			BIT(19),	1},
+	{"GPIOCOM4_VNN_REQ_STS",		BIT(20),	1},
+	{"GPIOCOM3_VNN_REQ_STS",		BIT(21),	1},
+	{"GPIOCOM2_VNN_REQ_STS",		BIT(22),	0},
+	{"GPIOCOM1_VNN_REQ_STS",		BIT(23),	1},
+	{"GPIOCOM0_VNN_REQ_STS",		BIT(24),	1},
 	{}
 };
 
 const struct pmc_bit_map lnl_vnn_req_status_3_map[] = {
-	{"DISP_SHIM_VNN_REQ_STS",		BIT(2)},
-	{"DTS0_VNN_REQ_STS",			BIT(7)},
-	{"GPIOCOM5_VNN_REQ_STS",		BIT(11)},
+	{"DISP_SHIM_VNN_REQ_STS",		BIT(2),		0},
+	{"DTS0_VNN_REQ_STS",			BIT(7),		0},
+	{"GPIOCOM5_VNN_REQ_STS",		BIT(11),	2},
 	{}
 };
 
 const struct pmc_bit_map lnl_vnn_misc_status_map[] = {
-	{"CPU_C10_REQ_STS",			BIT(0)},
-	{"TS_OFF_REQ_STS",			BIT(1)},
-	{"PNDE_MET_REQ_STS",			BIT(2)},
-	{"PCIE_DEEP_PM_REQ_STS",		BIT(3)},
-	{"PMC_CLK_THROTTLE_EN_REQ_STS",		BIT(4)},
-	{"NPK_VNNAON_REQ_STS",			BIT(5)},
-	{"VNN_SOC_REQ_STS",			BIT(6)},
-	{"ISH_VNNAON_REQ_STS",			BIT(7)},
-	{"D2D_NOC_CFI_QACTIVE_REQ_STS",		BIT(8)},
-	{"D2D_NOC_GPSB_QACTIVE_REQ_STS",	BIT(9)},
-	{"D2D_NOC_IPU_QACTIVE_REQ_STS",		BIT(10)},
-	{"PLT_GREATER_REQ_STS",			BIT(11)},
-	{"PCIE_CLKREQ_REQ_STS",			BIT(12)},
-	{"PMC_IDLE_FB_OCP_REQ_STS",		BIT(13)},
-	{"PM_SYNC_STATES_REQ_STS",		BIT(14)},
-	{"EA_REQ_STS",				BIT(15)},
-	{"MPHY_CORE_OFF_REQ_STS",		BIT(16)},
-	{"BRK_EV_EN_REQ_STS",			BIT(17)},
-	{"AUTO_DEMO_EN_REQ_STS",		BIT(18)},
-	{"ITSS_CLK_SRC_REQ_STS",		BIT(19)},
-	{"LPC_CLK_SRC_REQ_STS",			BIT(20)},
-	{"ARC_IDLE_REQ_STS",			BIT(21)},
-	{"MPHY_SUS_REQ_STS",			BIT(22)},
-	{"FIA_DEEP_PM_REQ_STS",			BIT(23)},
-	{"UXD_CONNECTED_REQ_STS",		BIT(24)},
-	{"ARC_INTERRUPT_WAKE_REQ_STS",	BIT(25)},
-	{"D2D_NOC_DISP_DDI_QACTIVE_REQ_STS",	BIT(26)},
-	{"PRE_WAKE0_REQ_STS",			BIT(27)},
-	{"PRE_WAKE1_REQ_STS",			BIT(28)},
-	{"PRE_WAKE2_EN_REQ_STS",		BIT(29)},
-	{"WOV_REQ_STS",				BIT(30)},
-	{"D2D_NOC_DISP_EDP_QACTIVE_REQ_STS_31",	BIT(31)},
+	{"CPU_C10_REQ_STS",			BIT(0),		0},
+	{"TS_OFF_REQ_STS",			BIT(1),		0},
+	{"PNDE_MET_REQ_STS",			BIT(2),		1},
+	{"PCIE_DEEP_PM_REQ_STS",		BIT(3),		0},
+	{"PMC_CLK_THROTTLE_EN_REQ_STS",		BIT(4),		0},
+	{"NPK_VNNAON_REQ_STS",			BIT(5),		0},
+	{"VNN_SOC_REQ_STS",			BIT(6),		1},
+	{"ISH_VNNAON_REQ_STS",			BIT(7),		0},
+	{"D2D_NOC_CFI_QACTIVE_REQ_STS",		BIT(8),		1},
+	{"D2D_NOC_GPSB_QACTIVE_REQ_STS",	BIT(9),		1},
+	{"D2D_NOC_IPU_QACTIVE_REQ_STS",		BIT(10),	1},
+	{"PLT_GREATER_REQ_STS",			BIT(11),	1},
+	{"PCIE_CLKREQ_REQ_STS",			BIT(12),	0},
+	{"PMC_IDLE_FB_OCP_REQ_STS",		BIT(13),	0},
+	{"PM_SYNC_STATES_REQ_STS",		BIT(14),	0},
+	{"EA_REQ_STS",				BIT(15),	0},
+	{"MPHY_CORE_OFF_REQ_STS",		BIT(16),	0},
+	{"BRK_EV_EN_REQ_STS",			BIT(17),	0},
+	{"AUTO_DEMO_EN_REQ_STS",		BIT(18),	0},
+	{"ITSS_CLK_SRC_REQ_STS",		BIT(19),	1},
+	{"LPC_CLK_SRC_REQ_STS",			BIT(20),	0},
+	{"ARC_IDLE_REQ_STS",			BIT(21),	0},
+	{"MPHY_SUS_REQ_STS",			BIT(22),	0},
+	{"FIA_DEEP_PM_REQ_STS",			BIT(23),	0},
+	{"UXD_CONNECTED_REQ_STS",		BIT(24),	1},
+	{"ARC_INTERRUPT_WAKE_REQ_STS",		BIT(25),	0},
+	{"D2D_NOC_DISP_DDI_QACTIVE_REQ_STS",	BIT(26),	1},
+	{"PRE_WAKE0_REQ_STS",			BIT(27),	1},
+	{"PRE_WAKE1_REQ_STS",			BIT(28),	1},
+	{"PRE_WAKE2_EN_REQ_STS",		BIT(29),	1},
+	{"WOV_REQ_STS",				BIT(30),	0},
+	{"D2D_NOC_DISP_EDP_QACTIVE_REQ_STS_31",	BIT(31),	1},
 	{}
 };
 
 const struct pmc_bit_map lnl_clocksource_status_map[] = {
-	{"AON2_OFF_STS",			BIT(0)},
-	{"AON3_OFF_STS",			BIT(1)},
-	{"AON4_OFF_STS",			BIT(2)},
-	{"AON5_OFF_STS",			BIT(3)},
-	{"AON1_OFF_STS",			BIT(4)},
-	{"MPFPW1_0_PLL_OFF_STS",		BIT(6)},
-	{"USB3_PLL_OFF_STS",			BIT(8)},
-	{"AON3_SPL_OFF_STS",			BIT(9)},
-	{"G5FPW1_PLL_OFF_STS",			BIT(15)},
-	{"XTAL_AGGR_OFF_STS",			BIT(17)},
-	{"USB2_PLL_OFF_STS",			BIT(18)},
-	{"SAF_PLL_OFF_STS",			BIT(19)},
-	{"SE_TCSS_PLL_OFF_STS",			BIT(20)},
-	{"DDI_PLL_OFF_STS",			BIT(21)},
-	{"FILTER_PLL_OFF_STS",			BIT(22)},
-	{"ACE_PLL_OFF_STS",			BIT(24)},
-	{"FABRIC_PLL_OFF_STS",			BIT(25)},
-	{"SOC_PLL_OFF_STS",			BIT(26)},
-	{"REF_OFF_STS",				BIT(28)},
-	{"IMG_OFF_STS",				BIT(29)},
-	{"RTC_PLL_OFF_STS",			BIT(31)},
+	{"AON2_OFF_STS",			BIT(0),		0},
+	{"AON3_OFF_STS",			BIT(1),		1},
+	{"AON4_OFF_STS",			BIT(2),		1},
+	{"AON5_OFF_STS",			BIT(3),		1},
+	{"AON1_OFF_STS",			BIT(4),		0},
+	{"MPFPW1_0_PLL_OFF_STS",		BIT(6),		1},
+	{"USB3_PLL_OFF_STS",			BIT(8),		1},
+	{"AON3_SPL_OFF_STS",			BIT(9),		1},
+	{"G5FPW1_PLL_OFF_STS",			BIT(15),	1},
+	{"XTAL_AGGR_OFF_STS",			BIT(17),	1},
+	{"USB2_PLL_OFF_STS",			BIT(18),	0},
+	{"SAF_PLL_OFF_STS",			BIT(19),	1},
+	{"SE_TCSS_PLL_OFF_STS",			BIT(20),	1},
+	{"DDI_PLL_OFF_STS",			BIT(21),	1},
+	{"FILTER_PLL_OFF_STS",			BIT(22),	1},
+	{"ACE_PLL_OFF_STS",			BIT(24),	0},
+	{"FABRIC_PLL_OFF_STS",			BIT(25),	1},
+	{"SOC_PLL_OFF_STS",			BIT(26),	1},
+	{"REF_OFF_STS",				BIT(28),	1},
+	{"IMG_OFF_STS",				BIT(29),	1},
+	{"RTC_PLL_OFF_STS",			BIT(31),	0},
 	{}
 };
 
 const struct pmc_bit_map lnl_signal_status_map[] = {
-	{"LSX_Wake0_STS",                BIT(0)},
-	{"LSX_Wake1_STS",                BIT(1)},
-	{"LSX_Wake2_STS",                BIT(2)},
-	{"LSX_Wake3_STS",                BIT(3)},
-	{"LSX_Wake4_STS",                BIT(4)},
-	{"LSX_Wake5_STS",                BIT(5)},
-	{"LSX_Wake6_STS",                BIT(6)},
-	{"LSX_Wake7_STS",                BIT(7)},
-	{"LPSS_Wake0_STS",               BIT(8)},
-	{"LPSS_Wake1_STS",               BIT(9)},
-	{"Int_Timer_SS_Wake0_STS",       BIT(10)},
-	{"Int_Timer_SS_Wake1_STS",       BIT(11)},
-	{"Int_Timer_SS_Wake2_STS",       BIT(12)},
-	{"Int_Timer_SS_Wake3_STS",       BIT(13)},
-	{"Int_Timer_SS_Wake4_STS",       BIT(14)},
-	{"Int_Timer_SS_Wake5_STS",       BIT(15)},
+	{"LSX_Wake0_STS",			BIT(0),		0},
+	{"LSX_Wake1_STS",			BIT(1),		0},
+	{"LSX_Wake2_STS",			BIT(2),		0},
+	{"LSX_Wake3_STS",			BIT(3),		0},
+	{"LSX_Wake4_STS",			BIT(4),		0},
+	{"LSX_Wake5_STS",			BIT(5),		0},
+	{"LSX_Wake6_STS",			BIT(6),		0},
+	{"LSX_Wake7_STS",			BIT(7),		0},
+	{"LPSS_Wake0_STS",			BIT(8),		1},
+	{"LPSS_Wake1_STS",			BIT(9),		1},
+	{"Int_Timer_SS_Wake0_STS",		BIT(10),	1},
+	{"Int_Timer_SS_Wake1_STS",		BIT(11),	1},
+	{"Int_Timer_SS_Wake2_STS",		BIT(12),	1},
+	{"Int_Timer_SS_Wake3_STS",		BIT(13),	1},
+	{"Int_Timer_SS_Wake4_STS",		BIT(14),	1},
+	{"Int_Timer_SS_Wake5_STS",		BIT(15),	1},
+	{}
+};
+
+const struct pmc_bit_map lnl_rsc_status_map[] = {
+	{"Memory",				0,		1},
+	{"PSF0",				0,		1},
+	{"PSF4",				0,		1},
+	{"PSF6",				0,		1},
+	{"PSF7",				0,		1},
+	{"PSF8",				0,		1},
+	{"SAF_CFI_LINK",			0,		1},
+	{"SBR",					0,		1},
 	{}
 };
 
@@ -355,6 +367,25 @@ const struct pmc_bit_map *lnl_lpm_maps[] = {
 	NULL
 };
 
+const struct pmc_bit_map *lnl_blk_maps[] = {
+	lnl_power_gating_status_0_map,
+	lnl_power_gating_status_1_map,
+	lnl_power_gating_status_2_map,
+	lnl_rsc_status_map,
+	lnl_vnn_req_status_0_map,
+	lnl_vnn_req_status_1_map,
+	lnl_vnn_req_status_2_map,
+	lnl_vnn_req_status_3_map,
+	lnl_d3_status_0_map,
+	lnl_d3_status_1_map,
+	lnl_d3_status_2_map,
+	lnl_d3_status_3_map,
+	lnl_clocksource_status_map,
+	lnl_vnn_misc_status_map,
+	lnl_signal_status_map,
+	NULL
+};
+
 const struct pmc_bit_map lnl_pfear_map[] = {
 	{"PMC_0",			BIT(0)},
 	{"FUSE_OSSE",			BIT(1)},
@@ -495,6 +526,8 @@ const struct pmc_reg_map lnl_socm_reg_map = {
 	.lpm_sts = lnl_lpm_maps,
 	.lpm_status_offset = MTL_LPM_STATUS_OFFSET,
 	.lpm_live_status_offset = MTL_LPM_LIVE_STATUS_OFFSET,
+	.s0ix_blocker_maps = lnl_blk_maps,
+	.s0ix_blocker_offset = LNL_S0IX_BLOCKER_OFFSET,
 };
 
 #define LNL_NPU_PCI_DEV		0x643e
-- 
2.34.1


