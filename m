Return-Path: <linux-kernel+bounces-72228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A444385B0FB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FC05285098
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC41839AFA;
	Tue, 20 Feb 2024 02:54:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E1F2E630
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708397640; cv=none; b=XbAtKVuLz4VoOD1gBhoWDXCLc5q3qkX56lU6GfpAMqRrRQsDn2oweMcuXm1foXcdi5QOhOsxbAaEMDsd0RjZEM1nd04lWmEl6FTqa6dtDNDLaMeUt7tZ+pTERu5Lub8/7kqom+LDlqmv0OJ1P+IL3RGlBZQKuwP52Qrl465Cpzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708397640; c=relaxed/simple;
	bh=gl6rahTJpdk8byVu8tnfqddKIafJt+RcobUSQq1L7pw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WLTm6QexIzT+NVnjKBEJbskZRJbIGZACiFd81UBpC3MF/Vy+zP81AGxDQmrLFn9pKptkXU9ZPWptD1rVpkgAdVkpWXHgA+ZpgY+2JrcRfYfpByddGAYFIAg+6q7LvnjFZ9IeKphSWHuEX3hEgLyc/YMxGiT1PcxYMI6Yko+giCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4332AFEC;
	Mon, 19 Feb 2024 18:54:30 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.42.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CF3C63F766;
	Mon, 19 Feb 2024 18:53:48 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2] arm64/sysreg: Update ID_DFR0_EL1 register fields
Date: Tue, 20 Feb 2024 08:23:43 +0530
Message-Id: <20240220025343.3093955-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This updates ID_DFR0_EL1.PerfMon and ID_DFR0_EL1.CopDbg register fields as
per the definitions based on DDI0601 2023-12.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.8-rc5

Changes in V2:

- Split ID_DFR0_EL1 changes in this patch and updated PerfMon per Mark

Changes in V1:

https://lore.kernel.org/all/20240215055159.2440898-1-anshuman.khandual@arm.com/

 arch/arm64/tools/sysreg | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index dd693f992832..a9cab2b730a3 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -200,6 +200,7 @@ UnsignedEnum	27:24	PerfMon
 	0b0110	PMUv3p5
 	0b0111	PMUv3p7
 	0b1000	PMUv3p8
+	0b1001	PMUv3p9
 	0b1111	IMPDEF
 EndEnum
 Enum	23:20	MProfDbg
@@ -231,6 +232,7 @@ Enum	3:0	CopDbg
 	0b1000	Debugv8p2
 	0b1001	Debugv8p4
 	0b1010	Debugv8p8
+	0b1011	Debugv8p9
 EndEnum
 EndSysreg
 
-- 
2.25.1


