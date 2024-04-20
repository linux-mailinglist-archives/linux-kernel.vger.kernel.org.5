Return-Path: <linux-kernel+bounces-152363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6C88ABCF4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 21:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3788B1F2119E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 19:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372A64174A;
	Sat, 20 Apr 2024 19:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F9WIT10x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8rrwF8uF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0A21EF12;
	Sat, 20 Apr 2024 19:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713643130; cv=none; b=eD7fCtdgtaybITwblI5VAho4dmDOeFcPqm4dS0pNqZ36AA4+FbTR8LSkGilrfh/oMe+um8cGW+gWpwNwe40yw1FYbeLwQDytCARfQgAbezJKHdXfBo9EVG+aWQYWUiwTJQAn1uXCB8bnrN1OFivIto6+/VH7UOxYdsNYg9xgRdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713643130; c=relaxed/simple;
	bh=+pJ3ZjjdzfG4bRtg73TS98Q88tWOqo7q3i+ekveFXGE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=EmmgE/XUtjZQtuh7VlLwU9rwx97/bOdJOD9HDB4r464gD3+cEMfmFZdvuKUIgIYotV1Vi6Bca9nTNnSovRkvDFdSQcKeulkDLo0YL0zVopr3zP38eAF4KFeLJLYooQ4l3EAXwNpyEqZIH1BhqWGvjRH60A9l2vKtWWlmsEJcSB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F9WIT10x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8rrwF8uF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 20 Apr 2024 19:58:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713643120;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=4yooGRnRDsGOCu082DXz0onM/RU0c72WN+A94Y1Oglc=;
	b=F9WIT10xZ3Rbau1sQigU/ZRflO+WaAksrQzNjcqtbeC07FJHb4IQy/nOQuHUn9myRv4NLc
	sKNoGIJ1cXrIcSiI0IRSmiM2JK64Yr0xC6W+joAFwRZ5Sam09fulXywVfQZe2IZGp1i/qW
	nxlDvm02EBOGZ+m76VUOBjtSdkB2B+f74v+hGUz8OkDr9irT+MIk5sUppC0uyPkp7ZHr4R
	ilbnhuI26VCoal8RLmz0dqaKwBEtO/YUuj+9XmmxRqwtp31rJ5EZeaf9OeIaQGgevhhLaX
	rSNNY9xepZIx/HP3xtnXd4tdwQ0L04Cq5nSW/Fu7l7ymkrY04L6MKtWdgcr8YQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713643120;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=4yooGRnRDsGOCu082DXz0onM/RU0c72WN+A94Y1Oglc=;
	b=8rrwF8uFBotYHyKndBTj/zcvUCRmdVAz/b+BsuTsa78PF+SosaP4GD6p+PcqmUScKE5MOa
	4ibYeu5xYtBGaUBw==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/purgatory: Switch to the position-independent
 small code model
Cc: Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Nathan Chancellor <nathan@kernel.org>, Fangrui Song <maskray@google.com>,
 Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171364311971.10875.13314057334060473132.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     cba786af84a0f9716204e09f518ce3b7ada8555e
Gitweb:        https://git.kernel.org/tip/cba786af84a0f9716204e09f518ce3b7ada8555e
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 18 Apr 2024 22:17:06 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 20 Apr 2024 18:54:59 +02:00

x86/purgatory: Switch to the position-independent small code model

On x86, the ordinary, position dependent small and kernel code models
only support placement of the executable in 32-bit addressable memory,
due to the use of 32-bit signed immediates to generate references to
global variables. For the kernel, this implies that all global variables
must reside in the top 2 GiB of the kernel virtual address space, where
the implicit address bits 63:32 are equal to sign bit 31.

This means the kernel code model is not suitable for other bare metal
executables such as the kexec purgatory, which can be placed arbitrarily
in the physical address space, where its address may no longer be
representable as a sign extended 32-bit quantity. For this reason,
commit

  e16c2983fba0 ("x86/purgatory: Change compiler flags from -mcmodel=kernel to -mcmodel=large to fix kexec relocation errors")

switched to the large code model, which uses 64-bit immediates for all
symbol references, including function calls, in order to avoid relying
on any assumptions regarding proximity of symbols in the final
executable.

The large code model is rarely used, clunky and the least likely to
operate in a similar fashion when comparing GCC and Clang, so it is best
avoided. This is especially true now that Clang 18 has started to emit
executable code in two separate sections (.text and .ltext), which
triggers an issue in the kexec loading code at runtime.

The SUSE bugzilla fixes tag points to gcc 13 having issues with the
large model too and that perhaps the large model should simply not be
used at all.

Instead, use the position independent small code model, which makes no
assumptions about placement but only about proximity, where all
referenced symbols must be within -/+ 2 GiB, i.e., in range for a
RIP-relative reference. Use hidden visibility to suppress the use of a
GOT, which carries absolute addresses that are not covered by static ELF
relocations, and is therefore incompatible with the kexec loader's
relocation logic.

  [ bp: Massage commit message. ]

Fixes: e16c2983fba0 ("x86/purgatory: Change compiler flags from -mcmodel=kernel to -mcmodel=large to fix kexec relocation errors")
Fixes: https://bugzilla.suse.com/show_bug.cgi?id=1211853
Closes: https://github.com/ClangBuiltLinux/linux/issues/2016
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Fangrui Song <maskray@google.com>
Acked-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/all/20240417-x86-fix-kexec-with-llvm-18-v1-0-5383121e8fb7@kernel.org/
---
 arch/x86/purgatory/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index bc31863..a18591f 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -42,7 +42,8 @@ KCOV_INSTRUMENT := n
 # make up the standalone purgatory.ro
 
 PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
-PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss -g0
+PURGATORY_CFLAGS := -mcmodel=small -ffreestanding -fno-zero-initialized-in-bss -g0
+PURGATORY_CFLAGS += -fpic -fvisibility=hidden
 PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
 PURGATORY_CFLAGS += -fno-stack-protector
 

