Return-Path: <linux-kernel+bounces-62608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE428852395
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B2532825E2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCB254F9A;
	Tue, 13 Feb 2024 00:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wjk+MFSp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1190954BFD;
	Tue, 13 Feb 2024 00:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783581; cv=none; b=LCReMO6eiK9YIIjtb9Gnihpq9q379rlFA12mqNPYeKisyCMq3KsF5pmM1QMCSkSUS+QKoYV3TnkwiMwp3KpW9xsIa0weT3sZwHBfvPYWDxykqH0k7kbG5gWAijFPxeJBMV6XNFUB8rAuoHakGhO6oWRLyuT/mVi9JH/RGNts7DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783581; c=relaxed/simple;
	bh=ZMnZk4FJawzyXVIxmEfV0kt8EySVmx3C69W8qzGNdmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvoMxE+gumxgMtULv5zo6iyCNaoDphhGgnfkQbXp0UJiyYUQ3uXMk/c7iYh3vEbJalXyGWFHGTynmmVQI1fUJ7fzBFc39ams6LlTINc8RCOMQ7Yj0uUMIz7f8/PiVzFWuntWJx9lWqzXXbnhmr1ceiQgB+E4s05a0jPZ7VZZP2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wjk+MFSp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05431C433B2;
	Tue, 13 Feb 2024 00:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783580;
	bh=ZMnZk4FJawzyXVIxmEfV0kt8EySVmx3C69W8qzGNdmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wjk+MFSp7WyLYbOZoYoqheqKxtGXsMQR+aVpxV5Qr9klpP6s7Np+MuaoNo7c3f9kl
	 vJmcIPLY/FmVcjZnwyNz5Hw3rv/ObFqUOqdCMEPMgM9VrL0wrZw+Scc5KAwdgEtbY7
	 AnRlSnFoo5Jxal4udi8EMGIJX9y4hUxVvEPadC9PkO5FWumpkTWGNmz/AJZduCwSBc
	 XHJK4ZcbV/7xViHEkCo16vTEGr/b+h80epkTAMqW6hYNd9+64b5H5GgVZcPC/z7xFj
	 Vlhp/YD6O4EjlRCV+GtE9ue7me323H+s5B3U4xFdD6Ye3DMyp+SHKl+SX5y5+++nwc
	 P6XS2A/T/6Q7g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.7 39/58] LoongArch: Select ARCH_ENABLE_THP_MIGRATION instead of redefining it
Date: Mon, 12 Feb 2024 19:17:45 -0500
Message-ID: <20240213001837.668862-39-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213001837.668862-1-sashal@kernel.org>
References: <20240213001837.668862-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
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
index ee123820a476..709af7096acb 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -11,6 +11,7 @@ config LOONGARCH
 	select ARCH_DISABLE_KASAN_INLINE
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
+	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
 	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_FORTIFY_SOURCE
@@ -643,10 +644,6 @@ config ARCH_SPARSEMEM_ENABLE
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


