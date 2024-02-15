Return-Path: <linux-kernel+bounces-66314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D988855A34
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 06:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03AA928F1F7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 05:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812AAB675;
	Thu, 15 Feb 2024 05:52:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B858D518
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 05:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707976335; cv=none; b=oRRaHgF5TZQfvZdLtrnrt53u/qYh3+R91MrBaUu+WT9kQBb92hiMEN6LVXWA7e6VcDaN7jWi/OW+2TOsCwPni3OGk78f/y+TFbgU8ZY+PODF7wzCiLqKH3uhW5bjlINNd9CVYuTN2Hxw7rs6jHg8WYjLm05+cUBAQLGKRBOYI3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707976335; c=relaxed/simple;
	bh=oWbkys/P/74grTrX/atmi7RV0XWDUXUbrt0myrHT0Hs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VuC9qhJM2Vj9rXRF+9YsBPqUyi2Q7vFvv7rUWYNBes++b3Ke2FuNEewi2I5UzQ22voDHmwDpiHSQ6uNvQ7IGxY1yPEAOU+BLbeCWomN+9q+hBbAuAWk0CC1PqZFemQD25CPkdO6IHE3XkhK4dpN9NIsNY8amG20/j9dgVwjW8HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90D341FB;
	Wed, 14 Feb 2024 21:52:52 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.45.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8B3A63F762;
	Wed, 14 Feb 2024 21:52:09 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/sysreg: Update ID_AA64DFR0_EL1 and ID_DFR0_EL1
Date: Thu, 15 Feb 2024 11:21:59 +0530
Message-Id: <20240215055159.2440898-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This just updates ID_DFR0_EL1.CopDbg and ID_AA64DFR0_EL1.DebugVer register
fields as per the definitions based on DDI0601 2023-12.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/tools/sysreg | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 4c9b67934367..94692abfeeb9 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -231,6 +231,7 @@ Enum	3:0	CopDbg
 	0b1000	Debugv8p2
 	0b1001	Debugv8p4
 	0b1010	Debugv8p8
+	0b1011	Debugv8p9
 EndEnum
 EndSysreg
 
@@ -1247,6 +1248,7 @@ UnsignedEnum	3:0	DebugVer
 	0b1000	V8P2
 	0b1001	V8P4
 	0b1010	V8P8
+	0b1011	V8P9
 EndEnum
 EndSysreg
 
-- 
2.25.1


