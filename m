Return-Path: <linux-kernel+bounces-132621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B045899764
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16269283DA6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAE61448DD;
	Fri,  5 Apr 2024 08:00:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16A91442FB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 08:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712304035; cv=none; b=kpwt7tGzepxtFNm2wdu9mdGVtybA1BGhkdLZz+y15jpsVPJfGFUQ+/TpG4tg9J0KM4SnSLkw1Pj6mCQm4OQ3oy5kTgCt6PqXznu41dEcxiqg0Y/Tu+MPI4ZR6nfXLxdl4JOMYdyA2iuBOitY4P96sdWNXvV6dUZTqEev2/QJVXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712304035; c=relaxed/simple;
	bh=ppheZXl6aBi7L/wsNMkQtMkZzKI6NHrhQoAZ3CNxhSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KfPbk2s30ZUguqcaVFSlmtx/kROaFcdqSySH9wVSoC89bK3uapHoozOBfAi/oEWX5Bq4uKi7rXARC8r0559OPXDIUf4XPzqPgSy1P+NwT2jI2Z1tP1G/MkgrQ1t+ElOStv/PfV1T+n7CbxE5Cm/AXs7a4iz9kF1juLe2kx4iMQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E00681007;
	Fri,  5 Apr 2024 01:01:03 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.41.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C1A103F64C;
	Fri,  5 Apr 2024 01:00:28 -0700 (PDT)
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
Subject: [RFC 3/8] arm64/sysreg: Add register fields for HDFGWTR2_EL2
Date: Fri,  5 Apr 2024 13:30:03 +0530
Message-Id: <20240405080008.1225223-4-anshuman.khandual@arm.com>
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

This adds register fields for HDFGWTR2_EL2 as per the definitions based
on DDI0601 2023-12.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
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


