Return-Path: <linux-kernel+bounces-62665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAA185242A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC471C2344B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F7B1B263;
	Tue, 13 Feb 2024 00:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOD0t7VV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB07629F1;
	Tue, 13 Feb 2024 00:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783702; cv=none; b=WN/9D9dcV3RIicYqew+TmsMOR2+ebU0sBuChxlU8i1Ctbu+qAs/XIjNb1UeinVoXaLyN82e19kFGWItbi+y8gclKwTY7DcaGA9dVrFy27k7uDwsmx15MEXBJkjXY6HE0LXHljOeZXAQL/vE6r8Dk57QiD8u7BfVeIvn3gzjSHZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783702; c=relaxed/simple;
	bh=IAVfEIqCC1DX0pBdkoRi4ZbUxIfmLHz4rd7R3C4mcEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZEW3M8bwNeuxaNOBU+EpK2LlBGxL2W/Q7037HMhEj/GseeQVgbvHhGQGrXO7LW2H0jR/9h9ZVO6TPKf8cZPxeEUXYITEnFhpzC7tvSSucWPgDMdMcDFyanObI7ii2N5xHGa9WMrPie+MYtNFnRo9dbjzQ5K7vKqfvmuOioubm4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOD0t7VV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4314DC433C7;
	Tue, 13 Feb 2024 00:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783702;
	bh=IAVfEIqCC1DX0pBdkoRi4ZbUxIfmLHz4rd7R3C4mcEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FOD0t7VVjCCqZgGNQwOFoQEPaUZppPalSnrrWUkgna+0uUHNq06g8B2I4eWLoP4Zb
	 84VsGl5ncetG1g4igpKkbWGtq+8skvXD3yqG0TOPopjaPKRW6+9TqBxV99riZ5PIIw
	 B9AnfMjZP2lf6V9xQYWNxyWKS/C6xFdSUJ01cmxaGpLekWkzeicqyufeAhmEyknEHV
	 jy0QRo+9U3MwcdS7BpXs5HKa3N7WgDk5myySQicRuqgls9lBWniv4+WDk/a6UfdQai
	 qcNUw6QDmb/SJvD+z4vxGLOIZoU3jhkxyBPtOOsSwR1C3qwECvevMl5GkE2r3yTV3a
	 G3QDxePadT7DQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 34/51] LoongArch: Select HAVE_ARCH_SECCOMP to use the common SECCOMP menu
Date: Mon, 12 Feb 2024 19:20:11 -0500
Message-ID: <20240213002052.670571-34-sashal@kernel.org>
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
index f29a0f2a4f18..9fd8644a9a4c 100644
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
@@ -604,23 +605,6 @@ config RANDOMIZE_BASE_MAX_OFFSET
 
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


