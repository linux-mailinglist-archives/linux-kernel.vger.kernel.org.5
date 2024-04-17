Return-Path: <linux-kernel+bounces-147845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D437A8A7A71
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703431F2225D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93356BE6F;
	Wed, 17 Apr 2024 02:18:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDA48BF3
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 02:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713320290; cv=none; b=Ru9UtCK/W1hKKs/hZNG8jfnSP4FHc3IKAFoL4hR/YzQYmTbW6SDksfzwzZ8nd7CWOTO1vwWm2cbuNbOt0KEEWyGDOpQXuHophpoExkKdr9HnmT1LZsLAV0OcUrceyKTLC88pdp13NbRJji2P+3H6m1wghHJwfhSYkqbYii3n8Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713320290; c=relaxed/simple;
	bh=9/E+zPi7KyfLu81VhWWG/K6z2U9e8vmDNbTaWl0e2gc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N2xrImhiypFUiTN76fxEYS+U19Ltmt0uFcxI+1QqYwKyHajmWWFfwSMP+BX3qagPBpul1UowNCAqtCrjdbMZHmDoI7S6VQjrija11fagIOrcHb7CviJUicXPuqu0XsYs13sISuy/aKmKjz/6dXKhe4waZNAcgLHag2ZjfWgQxNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1E201595;
	Tue, 16 Apr 2024 19:18:35 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.43.7])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 878803F64C;
	Tue, 16 Apr 2024 19:18:05 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	catalin.marinas@arm.com
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64/sysreg: Update ID_AA64MMFR0_EL1 register
Date: Wed, 17 Apr 2024 07:47:47 +0530
Message-Id: <20240417021747.2361382-5-anshuman.khandual@arm.com>
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

This updates ID_AA64MMFR0_EL1.FGT and ID_AA64MMFR0_EL1.PARANGE register
fields as per the definitions based on DDI0601 2024-03.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/tools/sysreg | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index c38414352dd8..7ba4fa99c160 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1567,6 +1567,7 @@ EndEnum
 UnsignedEnum	59:56	FGT
 	0b0000	NI
 	0b0001	IMP
+	0b0010	FGT2
 EndEnum
 Res0	55:48
 UnsignedEnum	47:44	EXS
@@ -1628,6 +1629,7 @@ Enum	3:0	PARANGE
 	0b0100	44
 	0b0101	48
 	0b0110	52
+	0b0111	56
 EndEnum
 EndSysreg
 
-- 
2.25.1


