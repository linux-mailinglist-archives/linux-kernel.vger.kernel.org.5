Return-Path: <linux-kernel+bounces-51679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B237E848E2E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A7091F21A5F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66ED3224E0;
	Sun,  4 Feb 2024 13:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/5+USez"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC098224D5;
	Sun,  4 Feb 2024 13:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707054498; cv=none; b=Ys9/EFZR7g9Eci2KnnPR7zAuG6VOk57NwvuG51n1yRkbDzGIwILOKD/PyqrVw5i3Im8m6v1TFYzYHk5//+H2j6abPGTfHO9azdmizIb0AaECLtPz2k/Ijl4amBKLPsjViOIfilTSD/rQm+e5HJzRWWY2HCixCrynAYDhEszsQnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707054498; c=relaxed/simple;
	bh=pbFol7VNmd3tct1WsWD/tL2wyqtctZ8CFhs3ERzA23g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m61JEi2+E7QfO+NScyLik2mFIz9vLRcJOFg8Q6FSj8583xbNnezAhAyZm6kFVR9vQpHZh5ze9loCUOp6AdwgK2ftdz6WHj58coJrAnvlp43UZG4gH8KMrH6dURhvJ5oJBSrFoTUUzuCXmAoTL+JL5Vh8LZctQFVnfUhIWwmlR6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/5+USez; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49520C433C7;
	Sun,  4 Feb 2024 13:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707054498;
	bh=pbFol7VNmd3tct1WsWD/tL2wyqtctZ8CFhs3ERzA23g=;
	h=From:To:Cc:Subject:Date:From;
	b=f/5+USezgTLyfezcNrR7Cno5IfS3PIOfa7X5zj0cQ6uBFc3JA+11gNxbHfZYgdsNu
	 BECV7hi1JKDdKA6Kjwsb3euBBhhVBuRy6gPRvW3xbxc3fmq9yKNKikKMmWnbk2xrB0
	 MZMOBxUYopvS6VwoImutCcQQ3cgDHKx3C3XyKlIYoHHiG8iPclfktVy1b5HqjUqiJh
	 2EaSj6JFTfjzPzAEmFvcKd4BJyv3voOXvZREnet+5NbvmtUHC/SzWMcAWmh/RXIIfF
	 auChcNFIEvBgp8omb0N4zEg1SCB5aMhcRDTS69h/HgX6WQYbzZAeoBq3Sa07x6rVvl
	 ABY+YfK45SguQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	loongarch@lists.linux.dev
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] loongarch: select ARCH_ENABLE_THP_MIGRATION instead of redefining it
Date: Sun,  4 Feb 2024 22:48:13 +0900
Message-Id: <20240204134813.61884-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ARCH_ENABLE_THP_MIGRATION is supposed to be selected by arch Kconfig.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/loongarch/Kconfig | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 10959e6c3583..64e9a01c7f36 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -12,6 +12,7 @@ config LOONGARCH
 	select ARCH_DISABLE_KASAN_INLINE
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
+	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
 	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_FORTIFY_SOURCE
@@ -667,10 +668,6 @@ config ARCH_SPARSEMEM_ENABLE
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
2.40.1


