Return-Path: <linux-kernel+bounces-62705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0079A852495
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914451F240F8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0505225D5;
	Tue, 13 Feb 2024 00:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fhg7r6hl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E15980C02;
	Tue, 13 Feb 2024 00:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783787; cv=none; b=A/5bm5UicjXS/9F8VCn8RPBTmuBIuvy4AwQJOjlDKOZ3Z/fHdZgQ69nNzNL1V3obZ766L/tOtq8PK51as20NCPtdvfVjDlx1ZMPJGrTPzjH3veCMJl7v4Mw5uJOA3gk8xfeZRI1HK0Cf1OcQDBauJsKe9jz0AZCGN2s9C/yPl+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783787; c=relaxed/simple;
	bh=c1l0pSe41YUkhs2Tw6L2wnUWVrWtQcjCg6uEUhLP0/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GIJidwcgwiAkL8nxm6bN+tNn9O4ZDTxSTmFfi3RM5dVj3fz5yBZ6BrsxGETU62mhR+xhN3Lf5j7rZoQ+Gx6fDHUrDRdcnHSixlV2sHWu+g9xvsiqiHtLg9uW5Uzjt+Qz7qNWvNIAs5g5fcuL9M8I9sfZzLXiqZ3lfRSxhWoV/gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fhg7r6hl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72753C43390;
	Tue, 13 Feb 2024 00:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783786;
	bh=c1l0pSe41YUkhs2Tw6L2wnUWVrWtQcjCg6uEUhLP0/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fhg7r6hlC1oTIEyC6PBpgKDfpf9thb2ADYMKSaGZ2HDejrctDv+zm4ps3jiScPVl/
	 qMmXoRfc3soMyobx6cD5Gu3jlIR6Uva5a9TuFkrqH7/v2t9GZspOvejbzq8RoR8nvu
	 KRqGH704uqx3jLHFMMqqHreFHdkO8ZDifIrBkyriAEmkmPIRhkQXlqq2BVeMVJ+5hd
	 9vexgk0wPAZZCuDBN1heMTkFMz8ys64ApFPY5qBsQd26f8yDVFFB1BrMy8EaVWDVkh
	 18S7/0u+bMKyYl45T8d2AtdEh36ck/vKKlwilWmEoUZZuxxOtZthJUHErXYvU7z0NE
	 oFqlM4jRvicnA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 21/28] LoongArch: Select HAVE_ARCH_SECCOMP to use the common SECCOMP menu
Date: Mon, 12 Feb 2024 19:22:19 -0500
Message-ID: <20240213002235.671934-21-sashal@kernel.org>
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
index b1b4396dbac6..fa3171f56327 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -81,6 +81,7 @@ config LOONGARCH
 	select GPIOLIB
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
+	select HAVE_ARCH_SECCOMP
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
@@ -462,23 +463,6 @@ config PHYSICAL_START
 	  specified in the "crashkernel=YM@XM" command line boot parameter
 	  passed to the panic-ed kernel).
 
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


