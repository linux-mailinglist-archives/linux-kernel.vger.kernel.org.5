Return-Path: <linux-kernel+bounces-58108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 207BC84E15E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43311F25205
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9D6763EE;
	Thu,  8 Feb 2024 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jHScf9Ve";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GErOvgzU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686E976C87;
	Thu,  8 Feb 2024 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707397485; cv=none; b=ozEjUJFFGoKIKFkuopJnLrbiazaWcxmS+7/7O4+1xVylzzfJLHfZMSdDHZfqe6WjBC8v0l3aoWLGKNW4gvKDHnn8gN43tLNeoL0f0jo0Fevl/JzQvTCRa5wGFdcZENCKcS4l3PyFqFKBJC7iqssqvKBzR7F/mHeuWkVjmTyiEFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707397485; c=relaxed/simple;
	bh=B+w7aNQugDPoBUEOgxPkpeE7tQiDkf18i7WYmTm9isI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Me23GD76Ezfq9b7GYgT2jZuz3JfBrtZtW08Iaf/PAFh013p6aEoe3XRtooISvI3PQaYMH5t2UxfsNN/EGD74kgEYRW5nm/o/GCs7mCJvgqkxB7PtGG119Rajs4Yrw1rGQ3MuQp5JVeOPCATDpvkvQLWho0zTOudety5Q4PWdYe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jHScf9Ve; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GErOvgzU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Feb 2024 13:04:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707397481;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l0TixTHR3L7AdCqfYOr9ORNx2AzW4b97QsrEVOJPAZU=;
	b=jHScf9VeAA1AG8ePLHQ6WjRty64q0TBkn2sVMGiNIOzsP8rRAM8Kd4xiovb6QkhQ7c/0zO
	2pg+WeH4HGc2fyOdTOz8DC5fAF093m6NAHKMy4hLOQ3jV1jA6iJ8V1uEpf6AO6gIJHo+PS
	b+11jfhjFTHgamP8k9ZZG/Nbr7Gq4O51Ok121b+CbfY62e1m6pgfe9ojOO1+7XvTZ4Iw4B
	FoZnbP64ziREgdBkNo6p+BXfU/f44MJXN8dR1oE2s+Juhc6a7AjLcP048nQIz5PKM0GYhI
	expAvRkwTWgKgdLI1zeERO6cV1ot4FZeNOVpG2qxocYIToL374+pIurkKZiQGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707397481;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l0TixTHR3L7AdCqfYOr9ORNx2AzW4b97QsrEVOJPAZU=;
	b=GErOvgzUQWvNYMyUAVhlWQUUWT4WBp1/X26k6VL6w2ke91JDFsR3CjcuBzjYTV/xEICsCa
	xlfeDRVr0GQy0qCw==
From: "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/vdso] x86/vdso: Simplify obj-y addition
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231121235701.239606-3-masahiroy@kernel.org>
References: <20231121235701.239606-3-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170739748071.398.15183510010318290284.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/vdso branch of tip:

Commit-ID:     329b77b59f83440e98d792800501e5a398806860
Gitweb:        https://git.kernel.org/tip/329b77b59f83440e98d792800501e5a398806860
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Wed, 22 Nov 2023 08:56:59 +09:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 08 Feb 2024 13:22:08 +01:00

x86/vdso: Simplify obj-y addition

Add objects to obj-y in a more straightforward way.

CONFIG_X86_32 and CONFIG_IA32_EMULATION are not enabled simultaneously,
but even if they are, Kbuild graciously deduplicates obj-y entries.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231121235701.239606-3-masahiroy@kernel.org
---
 arch/x86/entry/vdso/Makefile | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 2038d9c..cbfb5aa 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -18,11 +18,6 @@ OBJECT_FILES_NON_STANDARD	:= y
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
 KCOV_INSTRUMENT		:= n
 
-VDSO64-$(CONFIG_X86_64)		:= y
-VDSOX32-$(CONFIG_X86_X32_ABI)	:= y
-VDSO32-$(CONFIG_X86_32)		:= y
-VDSO32-$(CONFIG_IA32_EMULATION)	:= y
-
 # files to link into the vdso
 vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o
 vobjs32-y := vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
@@ -38,11 +33,11 @@ OBJECT_FILES_NON_STANDARD_vma.o		:= n
 OBJECT_FILES_NON_STANDARD_extable.o	:= n
 
 # vDSO images to build
-vdso_img-$(VDSO64-y)		+= 64
-vdso_img-$(VDSOX32-y)		+= x32
-vdso_img-$(VDSO32-y)		+= 32
+obj-$(CONFIG_X86_64)		+= vdso-image-64.o
+obj-$(CONFIG_X86_X32_ABI)	+= vdso-image-x32.o
+obj-$(CONFIG_X86_32)		+= vdso-image-32.o vdso32-setup.o
+obj-$(CONFIG_IA32_EMULATION)	+= vdso-image-32.o vdso32-setup.o
 
-obj-$(VDSO32-y)				 += vdso32-setup.o
 OBJECT_FILES_NON_STANDARD_vdso32-setup.o := n
 
 vobjs := $(foreach F,$(vobjs-y),$(obj)/$F)
@@ -53,9 +48,6 @@ $(obj)/vdso.o: $(obj)/vdso.so
 targets += vdso.lds $(vobjs-y)
 targets += vdso32/vdso32.lds $(vobjs32-y)
 
-# Build the vDSO image C files and link them in.
-vdso_img_objs := $(vdso_img-y:%=vdso-image-%.o)
-obj-y += $(vdso_img_objs)
 targets += $(foreach x, 64 x32 32, vdso-image-$(x).c vdso$(x).so vdso$(x).so.dbg)
 
 CPPFLAGS_vdso.lds += -P -C

