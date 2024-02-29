Return-Path: <linux-kernel+bounces-86883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F2A86CC36
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 837891C217B4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FC013776D;
	Thu, 29 Feb 2024 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juszkiewicz.com.pl header.i=@juszkiewicz.com.pl header.b="B1sMq+m0";
	dkim=pass (2048-bit key) header.d=juszkiewicz.com.pl header.i=@juszkiewicz.com.pl header.b="cSZ8FUGG"
Received: from muminek.juszkiewicz.com.pl (muminek.juszkiewicz.com.pl [213.251.184.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8546D1353F8
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.251.184.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709218700; cv=none; b=MYwlUqz1GDRPfkLSWFRpurjq1pnxULVfv4uqWdK+9d/W8W5BrLx/tbyoN1LjKS6uBf8f1VayErnpRVzqk1Flfg7OXn0IrGyiCBw8FGxcOGFri2P+74G/n496/wbqt/q8kIdSW4FNTIs8TXlYJ4L0o5f7Fm+ptCEe5baLF5zOcy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709218700; c=relaxed/simple;
	bh=FfQX8T2OKycP5tIHDJMSdxNJ4eZiVZCwuwsyExBR/J0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HVdeNlGUKkh7jz9HgZ6DN4/FbdoG09/LudgEeETh10oeeZKiB6ONuCwjrOylP3IJDqEqogGxnnUyTOdIznM99nccLkdOOBI4VSimqQwi5dWFAXeIJON9NcZl60sLHejQszJrODPnPVBmc85qbGR63lr7sBNZKo1u3oy+Ma2wbJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juszkiewicz.com.pl; spf=pass smtp.mailfrom=juszkiewicz.com.pl; dkim=pass (2048-bit key) header.d=juszkiewicz.com.pl header.i=@juszkiewicz.com.pl header.b=B1sMq+m0; dkim=pass (2048-bit key) header.d=juszkiewicz.com.pl header.i=@juszkiewicz.com.pl header.b=cSZ8FUGG; arc=none smtp.client-ip=213.251.184.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juszkiewicz.com.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juszkiewicz.com.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=juszkiewicz.com.pl;
	s=mail; t=1709218275;
	bh=FfQX8T2OKycP5tIHDJMSdxNJ4eZiVZCwuwsyExBR/J0=;
	h=From:To:Cc:Subject:Date:From;
	b=B1sMq+m0NI0vtn2jMBr3xiUcuCY6XdfxUQQzwjG4F+2Aznt0WUfzqLnnbCUfOMKIv
	 e17++AaOTFsLFqvFxnkp+8FEXc6MOgu+byQTH2gA6PLdAfdrxAZX5dj6AuiQCdiz0a
	 rtU2vHtBpSGHbpiq+56BTr7q9qzGszIfkyPgCTyFwdtkSvgp8WU5WN1jfhJtOx3W1M
	 qEP8n7skO2b0ipDrXToUjVx5eeW9byA/Zrv+h9sHu5ipIMDywNQrncfTgNFnFN4YMf
	 XmrkRABWVxD1GlvCR0IEicoQGDk6CaVEHzkE6OIfkhgzZo8JO+awMdFYGtkbUh68SI
	 CegaNQw7m/EgQ==
Received: from localhost (localhost [127.0.0.1])
	by muminek.juszkiewicz.com.pl (Postfix) with ESMTP id 7243226084A;
	Thu, 29 Feb 2024 15:51:15 +0100 (CET)
X-Virus-Scanned: Debian amavis at juszkiewicz.com.pl
Received: from muminek.juszkiewicz.com.pl ([127.0.0.1])
 by localhost (muminek.juszkiewicz.com.pl [127.0.0.1]) (amavis, port 10024)
 with ESMTP id x9xZT7CxWXDO; Thu, 29 Feb 2024 15:51:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=juszkiewicz.com.pl;
	s=mail; t=1709218273;
	bh=FfQX8T2OKycP5tIHDJMSdxNJ4eZiVZCwuwsyExBR/J0=;
	h=From:To:Cc:Subject:Date:From;
	b=cSZ8FUGGAjpiAILumLpcM+cBaLcDWBMCx2y2ubp9W2mDYRj7I1/IdmbNmfCytpoB0
	 H7M5ralpNm+k00qTT2k2fCDW9KMdbWUkth2EbyZKiPlm3vW2wtkkyKLwIAuXUcLcE5
	 NVPtKAx4STu1tdH8oDmWh5G/CAGzP9m9dNjDqEPgPUaZiS8jCX6J3JH6RVY73FOiRN
	 lEW+T3Oq4ptCX7zkge85Gj/OrmSZ4uaHF0uGVGsrZ56Q+hdOb2Rqi7t1kkNMthO4nu
	 3AMjpipt6t6BANybSJh1d0WDsXrmY5M9DkEczeg4BoPnjWq54VDNK0FxsxTcFYYLZD
	 y1aKGWeExu3Jw==
Received: from puchatek.lan (83.11.22.169.ipv4.supernova.orange.pl [83.11.22.169])
	by muminek.juszkiewicz.com.pl (Postfix) with ESMTPSA id 942C2260080;
	Thu, 29 Feb 2024 15:51:12 +0100 (CET)
From: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
To: linux-kernel@vger.kernel.org
Cc: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>,
	Russell King <linux@armlinux.org.uk>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] x86, arm: add missing license tag into syscall tables
Date: Thu, 29 Feb 2024 15:51:00 +0100
Message-ID: <20240229145101.553998-1-marcin@juszkiewicz.com.pl>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syscall*.tbl files were added to make it easier to check which system
calls are supported on each architecture and to check for their numbers.

Arm and x86 files lack Linux-syscall-note license exception present in
files for all other architectures.

Signed-off-by: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
---
 arch/arm/tools/syscall.tbl             | 1 +
 arch/x86/entry/syscalls/syscall_32.tbl | 1 +
 arch/x86/entry/syscalls/syscall_64.tbl | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index b6c9e01e14f5..a65fae9af312 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
 #
 # Linux system call numbers and entry vectors
 #
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 5f8591ce7f25..f532adc9ebca 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
 #
 # 32-bit system call numbers and entry vectors
 #
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 7e8d46f4147f..a5eee53d39bc 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
 #
 # 64-bit system call numbers and entry vectors
 #
-- 
2.43.2


