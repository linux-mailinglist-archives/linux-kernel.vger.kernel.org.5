Return-Path: <linux-kernel+bounces-58106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF92684E15B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079D41C26E48
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7751878696;
	Thu,  8 Feb 2024 13:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DYBW9kB0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MYw7lRvL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7677691F;
	Thu,  8 Feb 2024 13:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707397483; cv=none; b=keBPSVsbQ39cQZfj5bkq7fkSFwM0qQDlIk8SLtSkRc3TWasQr0JDhS6S49YRgevSZYVfGYCiskEaXs6oJbpybXOxmEIm24OXL/wdw7xHy5E7AtddfX0mlDeiuNPWTbj5yo4p82k+VXwCr7GHg9MiA+ZANYt5s9xRA3qSc+eq6aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707397483; c=relaxed/simple;
	bh=r0jE77rdo6Ue1DCrYWr0IcRSr6YcbHSatdaQvJjCqVU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dX1f6i/DZSpDQQRLphv6HFzIbnglb9QcmK5nx6KipVgBK1k56bRm3rroa7IUCFot8UDuqb62muTDDfE3zbd2CZmFxyeaRtNYqZef3vAXE8BKvbWHEuYsjYWk/JX0KG74chEHAFGV6bUORxYZ4tu0A6DqdPWZMZ3lDHCL1EWST8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DYBW9kB0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MYw7lRvL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Feb 2024 13:04:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707397479;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPbC25vg+lLa3ZBFGl4Zq+FRf4XhtPbXYIWS+Q2MVhs=;
	b=DYBW9kB0Pg+Oni4fYFcLTUCbQ/+x1yYFKtEt9OJzNasq0GsNU8UO7rHto3voNch1fSXL8y
	BfAuJY5JXl4kvH1cQ9u2S1vhhj1fbI5cKFs6N/AR9oK/6WSuO9/HhgcNAZ+2gKfSe55NPw
	1r7nHxg92yFTfCQ548O6Trt2LLPslS35jgOKjeLgzaFBYdVd+YoBG+gxxQLiyzEayNjR1x
	m7NbpSkhGfoqBBusA4eekO/cxA8zQQgqGlRlZkrwGQpHJ6KYFS2g0jjBx+EgH9dJef8DTo
	DNG2SjHzHtxcxI1ni2U0WYGvx1WcKiSwYSv2ouUs8PhO4DBirVdbqicBtI0OeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707397479;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPbC25vg+lLa3ZBFGl4Zq+FRf4XhtPbXYIWS+Q2MVhs=;
	b=MYw7lRvLVjLyd9kEbx4+6y1RSwhqJTLW6t4LgogHqFbWBLfRobGd7MvomgGZv+9qoBkF6k
	zKIFD22XSPnXjZAQ==
From: "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/vdso] x86/vdso: Use CONFIG_COMPAT_32 to specify vdso32
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231121235701.239606-5-masahiroy@kernel.org>
References: <20231121235701.239606-5-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170739747901.398.12579593288355831715.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/vdso branch of tip:

Commit-ID:     289d0a475c3e5be42315376d08e0457350fb8e9c
Gitweb:        https://git.kernel.org/tip/289d0a475c3e5be42315376d08e0457350fb8e9c
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Wed, 22 Nov 2023 08:57:01 +09:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 08 Feb 2024 13:23:14 +01:00

x86/vdso: Use CONFIG_COMPAT_32 to specify vdso32

In arch/x86/Kconfig, COMPAT_32 is defined as (IA32_EMULATION || X86_32).
Use it to eliminate redundancy in Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231121235701.239606-5-masahiroy@kernel.org
---
 arch/x86/Makefile            | 3 +--
 arch/x86/entry/vdso/Makefile | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 2264db1..f2260ac 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -296,8 +296,7 @@ install:
 
 vdso-install-$(CONFIG_X86_64)		+= arch/x86/entry/vdso/vdso64.so.dbg
 vdso-install-$(CONFIG_X86_X32_ABI)	+= arch/x86/entry/vdso/vdsox32.so.dbg
-vdso-install-$(CONFIG_X86_32)		+= arch/x86/entry/vdso/vdso32.so.dbg
-vdso-install-$(CONFIG_IA32_EMULATION)	+= arch/x86/entry/vdso/vdso32.so.dbg
+vdso-install-$(CONFIG_COMPAT_32)	+= arch/x86/entry/vdso/vdso32.so.dbg
 
 archprepare: checkbin
 checkbin:
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 439b527..7a97b17 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -35,8 +35,7 @@ OBJECT_FILES_NON_STANDARD_extable.o	:= n
 # vDSO images to build
 obj-$(CONFIG_X86_64)		+= vdso-image-64.o
 obj-$(CONFIG_X86_X32_ABI)	+= vdso-image-x32.o
-obj-$(CONFIG_X86_32)		+= vdso-image-32.o vdso32-setup.o
-obj-$(CONFIG_IA32_EMULATION)	+= vdso-image-32.o vdso32-setup.o
+obj-$(CONFIG_COMPAT_32)		+= vdso-image-32.o vdso32-setup.o
 
 OBJECT_FILES_NON_STANDARD_vdso32-setup.o := n
 

