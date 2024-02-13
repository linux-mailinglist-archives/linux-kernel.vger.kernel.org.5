Return-Path: <linux-kernel+bounces-62664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEC4852428
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E0A3B25F90
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278C1629EC;
	Tue, 13 Feb 2024 00:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9qGGCRY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BE26281E;
	Tue, 13 Feb 2024 00:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783701; cv=none; b=VyVGmocutga011iTI5s56EPpR67gJ+jnLEYGRCqDnoCi5g9EMtPLAtDOTfAS7oZDeIeVBU/WBVRrDiab64dqR0lSLtzRbycvCVihizpRoRJ7TAcm01Luxe/XBU7fD33vWUHqD3zBXnkPlJxmq5TGxZo1fa+w57dIpnwxgNAQuDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783701; c=relaxed/simple;
	bh=qtHm9SZn2BVrPWD93skVrVoSblwlibp6SKWVQz7KQ04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZE1x9vYYo4RvNERPs7Ylg5DXO2Mp3flAHyNcBnWvL+AqlBqUnk1Ql10/1aJPhYT+5QYUYqagFSXQFnjpDgXEbdWICNxYCmtQfdtH1r0QFe0oMtk8cCCLTu2p+sf0BMlBU0aeHSO5KXQXylZ7GGhZWNrgG7FZRa1ExMxtSVdPfH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9qGGCRY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF1FC43390;
	Tue, 13 Feb 2024 00:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783700;
	bh=qtHm9SZn2BVrPWD93skVrVoSblwlibp6SKWVQz7KQ04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f9qGGCRYW+cHmDEa/V4cKscuC3v/R4Jg3veHW8N4iZeMOxDWHlX8kWU25Uzjt0WAP
	 aX4e5WMZKFZo9IAhLzP6XugMFYmwwwNh4NXGxwxGkf8FfKLlNlwaiiGQjLikTfUAj3
	 y5N7OJ22mu4c/rM4k5+FI865RlGjh86VUYx+UnYlvwlFwpIIqe3oRYh0tJD7u1+Dzm
	 pj5cWzz7qPNE5ev0rfBdGR3JlAze3qrdb5KmDT2fSAXNZrFHj5t7x8vXE8kITF2Qru
	 zAJnYuAByCDUOrIwFKKqGY6s47g1XHRJlmc0+4F+Zvih5+kuVkkjWkzG4Yq3KwYcjX
	 YHcFENho68jxA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 33/51] LoongArch: Select ARCH_ENABLE_THP_MIGRATION instead of redefining it
Date: Mon, 12 Feb 2024 19:20:10 -0500
Message-ID: <20240213002052.670571-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002052.670571-1-sashal@kernel.org>
References: <20240213002052.670571-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
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
index e14396a2ddcb..f29a0f2a4f18 100644
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
@@ -638,10 +639,6 @@ config ARCH_SPARSEMEM_ENABLE
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


