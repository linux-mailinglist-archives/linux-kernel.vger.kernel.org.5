Return-Path: <linux-kernel+bounces-147843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B508A7A6F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F014EB21A89
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FECAD48;
	Wed, 17 Apr 2024 02:18:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD87C6FB6
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 02:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713320289; cv=none; b=CK72TV8ZIG3x1H+Uc08mIN9b652yjuYC9Tda2ivQ53XWK/KHry1SV/cDF+TKlI/uybb2s6RHhW13fQdgkWz6TIZqW0L1ldaZIMAFNqR+V7UbMdmzchvpzhKpNL7sYC17U+bX0i7HNipynph9hBwT2wbpslUmfetgiRqfjUzL5eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713320289; c=relaxed/simple;
	bh=/SO840AEl81tVqOpKLj0LFCellVuUI3o75OIgbzWhSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=maxBd+C3PYsgPkbfHITSPmJxWK5IBjS3NtL/tHUK244A0tBNibLEUzAlA3TBKVWD/Hz6jY0Q27oukkl6qSOraSZCky3rYL1qqAy3Z9CkBPluV3l8m9/GSDT21P2XH54KPQdbmbVjLxp8hWSeUBo9AAq9TwT7sC8QQjikBgfwXwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E958B153B;
	Tue, 16 Apr 2024 19:18:32 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.43.7])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 98E903F64C;
	Tue, 16 Apr 2024 19:18:02 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	catalin.marinas@arm.com
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] arm64/sysreg: Add register fields for HDFGWTR2_EL2
Date: Wed, 17 Apr 2024 07:47:46 +0530
Message-Id: <20240417021747.2361382-4-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240417021747.2361382-1-anshuman.khandual@arm.com>
References: <20240417021747.2361382-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds register fields for HDFGWTR2_EL2 as per the definitions based
on DDI0601 2024-03.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/tools/sysreg | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 9bcd8a0d55c4..c38414352dd8 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2472,6 +2472,33 @@ Field	1 nPMIAR_EL1
 Field	0 nPMECR_EL1
 EndSysreg
 
+Sysreg HDFGWTR2_EL2	3	4	3	1	1
+Res0	63:24
+Field	23 nMDSTEPOP_EL1
+Field	22 nTRBMPAM_EL1
+Field	21 nPMZR_EL0
+Field	20 nTRCITECR_EL1
+Field	19 nPMSDSFR_EL1
+Res0	18:17
+Field	16 nSPMSCR_EL1
+Field	15 nSPMACCESSR_EL1
+Field	14 nSPMCR_EL0
+Field	13 nSPMOVS
+Field	12 nSPMINTEN
+Field	11 nSPMCNTEN
+Field	10 nSPMSELR_EL0
+Field	9 nSPMEVTYPERn_EL0
+Field	8 nSPMEVCNTRn_EL0
+Field	7 nPMSSCR_EL1
+Res0	6
+Field	5 nMDSELR_EL1
+Field	4 nPMUACR_EL1
+Field	3 nPMICFILTR_EL0
+Field	2 nPMICNTR_EL0
+Field	1 nPMIAR_EL1
+Field	0 nPMECR_EL1
+EndSysreg
+
 Sysreg HDFGRTR_EL2	3	4	3	1	4
 Field	63	PMBIDR_EL1
 Field	62	nPMSNEVFR_EL1
-- 
2.25.1


