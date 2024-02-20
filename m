Return-Path: <linux-kernel+bounces-72287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C25C885B1A1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 770F21F22518
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A129E54BC4;
	Tue, 20 Feb 2024 03:48:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCE642A88
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 03:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708400926; cv=none; b=mnC5IAx8SB4t7B3+gOidLXPeMAn6DHOO/PXt/nRB3aBBrWRfGpMQmNAA3UUyhveSxccyDyIuAXPD4P7Ea8k1PjTPZg1E8hPTEKpjPGUUe7tuRq7/G5zVt6yVISy77dbr0YaXbdKTSzAFUIfRXwWPsif6E0INJXimx6bNSkoMXz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708400926; c=relaxed/simple;
	bh=b8LjkXT84906NkK5/yZUBGhJ7xE6H1O9jZlRmt6wdII=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p3/SwXLpCRDItja6eTxVfJytldh2Si/w28pdZoBbJsDvkHzqYPAPvwlqfy5qXW0jV1ZzejkapJoE/aEYZtfREhQiV88/HO8TQem0WypLjOFQjCKY8WJDoKYaWCQe8APvq9wlB/6vMOFIpe0BmS+ZFrAHhFGd51BhB1Pxr7HlGqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 310B5FEC;
	Mon, 19 Feb 2024 19:49:22 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.42.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C350A3F762;
	Mon, 19 Feb 2024 19:48:40 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2] arm64/sysreg: Update ID_AA64DFR0_EL1 register
Date: Tue, 20 Feb 2024 09:18:29 +0530
Message-Id: <20240220034829.3098373-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This updates ID_AA64DFR0_EL1.PMSVer and ID_AA64DFR0_EL1.DebugVer register
fields as per the definitions based on DDI0601 2023-12.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.8-rc5

Changes in V2:

- Split ID_AA64DFR0_EL1 changes in this patch and updated PMSVer per Mark

Changes in V1:

https://lore.kernel.org/all/20240215055159.2440898-1-anshuman.khandual@arm.com/

 arch/arm64/tools/sysreg | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index a9cab2b730a3..508224a0e078 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1223,6 +1223,7 @@ UnsignedEnum	35:32	PMSVer
 	0b0010	V1P1
 	0b0011	V1P2
 	0b0100	V1P3
+	0b0101	V1P4
 EndEnum
 Field	31:28	CTX_CMPs
 Res0	27:24
@@ -1249,6 +1250,7 @@ UnsignedEnum	3:0	DebugVer
 	0b1000	V8P2
 	0b1001	V8P4
 	0b1010	V8P8
+	0b1011	V8P9
 EndEnum
 EndSysreg
 
-- 
2.25.1


