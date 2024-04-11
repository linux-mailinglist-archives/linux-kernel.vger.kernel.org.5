Return-Path: <linux-kernel+bounces-140560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D388E8A162F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89302282E7C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E4C152E0A;
	Thu, 11 Apr 2024 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="38175VCW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5Li35KZY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E12A152DF9;
	Thu, 11 Apr 2024 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842998; cv=none; b=jXQnJWv/xmh+ZN/oZCmSqGHrI3YnRf7dLPoQ/kmKEKf/M3C+/6RoG3PfeViODX/7SBEQYwsMVqX7YfNrixvaF+inDUHYnvGIXBzPzG7x3y9yLIBVfIMOC5dmcxQ1FJud4ZRv41zlxblGmLlBxPCdz4+FmC+ku7ecqmlfJI+PiJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842998; c=relaxed/simple;
	bh=PncWNEnZtKaUNkGvlC9SddqmzNx550XBT30/UkN+7P8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DNkgNH7CngRGtn1g3lz94rNNpwWQu5qgH3VTY+SmD6empkXcUjuiWhsxUJqpB7H6ZFFFYq1N0pe+9QYDpAHs0sRMwBjOCjWNjDeg+GOadNVSE+m45Jcl6i3yNtMvEIg3RsUiHtWeagNude7q7rdE+a/vPxx+gksYgin2/Ydxy/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=38175VCW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5Li35KZY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Apr 2024 13:43:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712842995;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XYlTX7TG189xFRlgCXMUjuXPhP96p/OAZRlbZkfS0VI=;
	b=38175VCWynhDxXdpk44fxRe4VJU2EcyQSoOwc9735aVwfuqBXg/hqA3bBk99+SqAlPgUCQ
	s0wCvB8sUWD39oWuZtUBA9OYeGIF2OlB8Rum0+x+TE55qpeArfpXobxXyuvNd/CHbelViA
	vvYO98QwwsKoznrG31VrqGmmD8wEN3KgcXiqjEWBJx/4xG/unlAy9WCt71LFircze0NDk6
	aoCR4sr5BIfV0leV4jDeBz9wYFkPP/jfz0yCAVMpZMSiwt/F6EmkxyDqHKtHqMaW58aRdU
	WcQvVubHQN53Gj3S3dKSnr+W2NgrvapGIIQW0O6vF7BEVfH0o6Su/Kd3qmjlRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712842995;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XYlTX7TG189xFRlgCXMUjuXPhP96p/OAZRlbZkfS0VI=;
	b=5Li35KZY1T5y+z56ArCt84uDevLhgKwewSgjMiOoHZyrlu70zGTZzxy+RCwMvZZqf9qfPl
	+zc1+tUucjObXLBA==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/64: Clear most of CR4 in startup_64(),
 except PAE, MCE and LA57
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240410151354.506098-2-ardb+git@google.com>
References: <20240410151354.506098-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171284299468.10875.10397658917698489480.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     a0025f587c685e5ff842fb0194036f2ca0b6eaf4
Gitweb:        https://git.kernel.org/tip/a0025f587c685e5ff842fb0194036f2ca0b6eaf4
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Wed, 10 Apr 2024 17:13:55 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 11 Apr 2024 15:37:17 +02:00

x86/boot/64: Clear most of CR4 in startup_64(), except PAE, MCE and LA57

The early 64-bit boot code must be entered with a 1:1 mapping of the
bootable image, but it cannot operate without a 1:1 mapping of all the
assets in memory that it accesses, and therefore, it creates such
mappings for all known assets upfront, and additional ones on demand
when a page fault happens on a memory address.

These mappings are created with the global bit G set, as the flags used
to create page table descriptors are based on __PAGE_KERNEL_LARGE_EXEC
defined by the core kernel, even though the context where these mappings
are used is very different.

This means that the TLB maintenance carried out by the decompressor is
not sufficient if it is entered with CR4.PGE enabled, which has been
observed to happen with the stage0 bootloader of project Oak. While this
is a dubious practice if no global mappings are being used to begin
with, the decompressor is clearly at fault here for creating global
mappings and not performing the appropriate TLB maintenance.

Since commit:

  f97b67a773cd84b ("x86/decompressor: Only call the trampoline when changing paging levels")

CR4 is no longer modified by the decompressor if no change in the number
of paging levels is needed. Before that, CR4 would always be set to a
consistent value with PGE cleared.

So let's reinstate a simplified version of the original logic to put CR4
into a known state, and preserve the PAE, MCE and LA57 bits, none of
which can be modified freely at this point (PAE and LA57 cannot be
changed while running in long mode, and MCE cannot be cleared when
running under some hypervisors).

This effectively clears PGE and works around the project Oak bug.

Fixes: f97b67a773cd84b ("x86/decompressor: Only call the trampoline when ...")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20240410151354.506098-2-ardb+git@google.com
---
 arch/x86/boot/compressed/head_64.S | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index bf4a10a..1dcb794 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -398,6 +398,11 @@ SYM_CODE_START(startup_64)
 	call	sev_enable
 #endif
 
+	/* Preserve only the CR4 bits that must be preserved, and clear the rest */
+	movq	%cr4, %rax
+	andl	$(X86_CR4_PAE | X86_CR4_MCE | X86_CR4_LA57), %eax
+	movq	%rax, %cr4
+
 	/*
 	 * configure_5level_paging() updates the number of paging levels using
 	 * a trampoline in 32-bit addressable memory if the current number does

