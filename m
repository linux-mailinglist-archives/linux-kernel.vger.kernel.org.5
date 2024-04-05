Return-Path: <linux-kernel+bounces-132620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E29899763
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2954CB21CD1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7041A1442F7;
	Fri,  5 Apr 2024 08:00:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96420143C49
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712304030; cv=none; b=oUgEV8luPcaK728FIkAwKkKhX229qtX8wPPRIJwgjrWsGzchEewmh/085YiUU8xgzUIHX8qrz0rv3xONjKbf4tYa+yF7AzQtg/j5NFLw3llnpjh4kUKNc4sH2gf5lHBMUYCHlRNXDxwKsoCk9k0FdPES42YqWRlZq9cy9KbMwj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712304030; c=relaxed/simple;
	bh=Wb6PwvvB2mHY46JfKwKq+HwPzHPME4H5fqXIPpiBc60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rqSBSol7SIl8PptopfCSPCA4G5RUci9zX0CnLj9GzoZtUZAfaRVfUXoMQ1zNxk2FK5fiG668Rqi21JCBniijEmGGH4ywvWTdgp+PL6TwXKZzN04NXJpQwA75Lf45YeWperSK1+QI5tWvlStu9V8w5C1aHAuuBcHWWyfByQpKil0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAAB5FEC;
	Fri,  5 Apr 2024 01:00:58 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.41.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BCAEF3F64C;
	Fri,  5 Apr 2024 01:00:23 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC 2/8] arm64/sysreg: Add register fields for HDFGRTR2_EL2
Date: Fri,  5 Apr 2024 13:30:02 +0530
Message-Id: <20240405080008.1225223-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240405080008.1225223-1-anshuman.khandual@arm.com>
References: <20240405080008.1225223-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds register fields for HDFGRTR2_EL2 as per the definitions based
on DDI0601 2023-12.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/tools/sysreg | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 4c58fd7a70e6..9bcd8a0d55c4 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2444,6 +2444,34 @@ Field	1	ICIALLU
 Field	0	ICIALLUIS
 EndSysreg
 
+Sysreg HDFGRTR2_EL2	3	4	3	1	0
+Res0	63:24
+Field	23 nMDSTEPOP_EL1
+Field	22 nTRBMPAM_EL1
+Res0	21
+Field	20 nTRCITECR_EL1
+Field	19 nPMSDSFR_EL1
+Field	18 nSPMDEVAFF_EL1
+Field	17 nSPMID
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
+Field	6 nPMSSDATA
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


