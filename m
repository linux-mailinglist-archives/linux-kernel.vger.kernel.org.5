Return-Path: <linux-kernel+bounces-62609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCF3852398
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F00B1C234E0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2288E54BFB;
	Tue, 13 Feb 2024 00:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doZ7lpPr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F3454FA5;
	Tue, 13 Feb 2024 00:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783582; cv=none; b=IkYyFem4qRBUthJuAjsd3yUAySpum/hl7TKZRGDsuf4OPRgOEWD1d5xk7FMb+AWsLyryUKqx6Pl7MZtdlmkMp7DOQTRrvo5hIfK+3N078BTk7YU3IJF/hXnDpV+rOunOACLuA+t3kKSjhaSq4xyw4pWZEifCOLDrVJ+JIDg4PXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783582; c=relaxed/simple;
	bh=Xxwz1pmoYy7bWaGo8HTTnGRoRyIGCPp/C14dk+8xnGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHy748lDfjXxVP5s9GYZzWjhZmB2WrHlMkHDWkuczJ7UVlYH/XngBWiYLJwYGJLmLAVF0e50w/LTpFG10pIGV1D9DiOM2vmJpUkiVnt6gacjalxP6xEDk4TzFigdhJu21y52Gw+STxFPj6D1TuTOntDtsFPY37csB3zF6f8QNjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doZ7lpPr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC93C433C7;
	Tue, 13 Feb 2024 00:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783582;
	bh=Xxwz1pmoYy7bWaGo8HTTnGRoRyIGCPp/C14dk+8xnGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=doZ7lpPrL4O2CTTjmWhWDiRzgN2ZBbalCZMCSlGCbfiqpltwA3JL1+6m18uQNaG6l
	 R4rIhwK07KSp0VPg1LaOnX0hbPigHn4fE1GtlaxHWsDYS7zbOU8Mf69TGGL/vEZ9gF
	 hjdiE09kRJaoJWEFwRfYRPItKsEvxG/jidlMl9OqOMsPd2UCatpSBZ1do/iDZXQBP7
	 KZQqSSwGRdwJqVWCe4F15YjFw0h2dVkbBXVEbx1ebf67p7n9TLQD1O438oyVjUgn7Z
	 9+nZVVMmpzSrmwAu2yUfnfJgQqpBXaBFmrKfuayucmn3+JcqGmcrLInvq13JUhjH1a
	 lOyO7vRPBV2gQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.7 40/58] LoongArch: Select HAVE_ARCH_SECCOMP to use the common SECCOMP menu
Date: Mon, 12 Feb 2024 19:17:46 -0500
Message-ID: <20240213001837.668862-40-sashal@kernel.org>
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

[ Upstream commit 6b79ecd084c99b31c8b4d0beda08893716d5558e ]

LoongArch missed the refactoring made by commit 282a181b1a0d ("seccomp:
Move config option SECCOMP to arch/Kconfig") because LoongArch was not
mainlined at that time.

The 'depends on PROC_FS' statement is stale as described in that commit.
Select HAVE_ARCH_SECCOMP, and remove the duplicated config entry.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/Kconfig | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 709af7096acb..205956041d7d 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -98,6 +98,7 @@ config LOONGARCH
 	select HAVE_ARCH_KFENCE
 	select HAVE_ARCH_KGDB if PERF_EVENTS
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
+	select HAVE_ARCH_SECCOMP
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
@@ -609,23 +610,6 @@ config RANDOMIZE_BASE_MAX_OFFSET
 
 	  This is limited by the size of the lower address memory, 256MB.
 
-config SECCOMP
-	bool "Enable seccomp to safely compute untrusted bytecode"
-	depends on PROC_FS
-	default y
-	help
-	  This kernel feature is useful for number crunching applications
-	  that may need to compute untrusted bytecode during their
-	  execution. By using pipes or other transports made available to
-	  the process as file descriptors supporting the read/write
-	  syscalls, it's possible to isolate those applications in
-	  their own address space using seccomp. Once seccomp is
-	  enabled via /proc/<pid>/seccomp, it cannot be disabled
-	  and the task is only allowed to execute a few safe syscalls
-	  defined by each seccomp mode.
-
-	  If unsure, say Y. Only embedded should say N here.
-
 endmenu
 
 config ARCH_SELECT_MEMORY_MODEL
-- 
2.43.0


