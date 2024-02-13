Return-Path: <linux-kernel+bounces-62704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 171CD852491
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7FCD28218C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC2880628;
	Tue, 13 Feb 2024 00:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0z2DTt0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813A68061B;
	Tue, 13 Feb 2024 00:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783785; cv=none; b=kQ4Fsd2bWOt1QC8KNB4dx22pBsOxT8aFqip3TM8JZSEaXPYtohOk/PzoLcuDPad5o18kj7RIj9slLBWlWbEAW9h0FFp9enIovq4sogX3I6CnfPL2/OP5TklGylXxWp4lJoMGMYUky/aL4+Im7Ox4Oo4xdALAPl5RFskE2FTraZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783785; c=relaxed/simple;
	bh=U2gIa04sBLTHzW3iW2xOjULlwobPHjNmK6vAiygan7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZRtiatzK3PVaSYV8rLMI1So/DixrpFwf5sOXWhS/jZtF/jJW9Ibc81S0omx1rH299JHhV3a/OxaSGFlssiEjbnXf/XYYQTq0T2YGxCPpMF0CaXJcgnLxg+X8PuubHCZNsGXHROiZIAP6R2x+77p2id8R03cadHtEEhf8k0zpsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0z2DTt0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C26C433F1;
	Tue, 13 Feb 2024 00:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783785;
	bh=U2gIa04sBLTHzW3iW2xOjULlwobPHjNmK6vAiygan7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j0z2DTt0xImN+QCP4DgUEcyeFjAoZIouTQNiAiUM91LuOEWgOj4zZ5IzV8sx8EEzU
	 2tJUExE+uDCocWGqba3/C8NJiS+0Ol4Iw3PPBivI+COlI6DfzgEPh9pls3DjTGmprP
	 kPk94dGS6S1lxvzjUFzahSEy7ef9JUV0J0BOuaFSM0gng7E3rKcyjBr01GScisVoxL
	 APRfkQsZz1Tzad83WT//sSBiBdmbC/6ia5Vf/Xj7TqsLAX85l3QYq7GjeTq1P5nZxE
	 po1wq7Exr4ph6ztafqOiJvauOvb+RfbrVva+bHXljIuDv9F7+R+F/VfcFevQ9iiONX
	 NUXRPM6g/JcWw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 20/28] LoongArch: Select ARCH_ENABLE_THP_MIGRATION instead of redefining it
Date: Mon, 12 Feb 2024 19:22:18 -0500
Message-ID: <20240213002235.671934-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002235.671934-1-sashal@kernel.org>
References: <20240213002235.671934-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
Content-Transfer-Encoding: 8bit

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit b3ff2d9c3a9c64cd0a011cdd407ffc38a6ea8788 ]

ARCH_ENABLE_THP_MIGRATION is supposed to be selected by arch Kconfig.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/Kconfig | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index e737dc8cd660..b1b4396dbac6 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -9,6 +9,7 @@ config LOONGARCH
 	select ARCH_BINFMT_ELF_STATE
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
+	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_SPECIAL
@@ -495,10 +496,6 @@ config ARCH_SPARSEMEM_ENABLE
 	  or have huge holes in the physical address space for other reasons.
 	  See <file:Documentation/mm/numa.rst> for more.
 
-config ARCH_ENABLE_THP_MIGRATION
-	def_bool y
-	depends on TRANSPARENT_HUGEPAGE
-
 config ARCH_MEMORY_PROBE
 	def_bool y
 	depends on MEMORY_HOTPLUG
-- 
2.43.0


