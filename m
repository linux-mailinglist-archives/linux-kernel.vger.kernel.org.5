Return-Path: <linux-kernel+bounces-121037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A932688E1BC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61CFD297FCD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CD713A403;
	Wed, 27 Mar 2024 12:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMg+uvUJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B162915B98C;
	Wed, 27 Mar 2024 12:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541907; cv=none; b=L82geUf+wfoP1q0mWKvLfkwrz4J4c/pJJErftD5TVVolsR9phS8EP65Qzf6DQtQD0dttC6TivCTW0+0yEaznfXHvtQ+7CTHGOu4sw3kEbEU45UMjBfrxuK7Ful3kkHmwPOlNS8+/PgW2ApxfjECBzeb/Ptqm9qHA6gH/1J5a2lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541907; c=relaxed/simple;
	bh=8kAo9X35ou+dCAuhcNkswmC8d86OSZMXjHh6pNPGnTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N9pkanh6S0rXjFQmFtA7/FScmTGoiY3feNTlAHrJ2EYM2/+Xrvv7bBGFBCoTVwAzlR802x86gtOee+ouA8tA3EfzAaRNl/HePwr2njeF+njXVOCTyoczwyrppmQZvMe787ftwGQJhv6lKatf14wBeQneEFOFw/oAOM8YG5qTCAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMg+uvUJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA41C433F1;
	Wed, 27 Mar 2024 12:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541907;
	bh=8kAo9X35ou+dCAuhcNkswmC8d86OSZMXjHh6pNPGnTw=;
	h=From:To:Cc:Subject:Date:From;
	b=gMg+uvUJIakha4hro0oBRors6yoL9OckTWu/n4YL3cGHeIMAEDLFPl71oWgC278YK
	 a1cuaNGRyF1MhrH5OQC+MR2hOaMRWq7pn+xDDNqYyS6odE3DKPbnWSxjIbT9uBO8Xg
	 nlYz0gOJiVwxS9T4PNka8eqZfdaTykQLPUVH2BXA+lwjgW1LtCcypSqexeFInFH3Tv
	 CoXByyGN6yNi3LHfsrfsuyXLQ/MaOW+CHHqTkdM/E2nyMPe4mVcdFUEOAB3uXAt9OA
	 +0Mfbe+fG5JmWxlh0flHobC45FeZuHpogJxsAvcX0zfav1nfH1tJQ0huqsDVCu1223
	 PY2/2HukUOm6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ardb@kernel.org
Cc: stable@kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "x86/efistub: Call mixed mode boot services on the firmware's stack" failed to apply to 5.10-stable tree
Date: Wed, 27 Mar 2024 08:18:25 -0400
Message-ID: <20240327121825.2834340-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From cefcd4fe2e3aaf792c14c9e56dab89e3d7a65d02 Mon Sep 17 00:00:00 2001
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 22 Mar 2024 17:03:58 +0200
Subject: [PATCH] x86/efistub: Call mixed mode boot services on the firmware's
 stack

Normally, the EFI stub calls into the EFI boot services using the stack
that was live when the stub was entered. According to the UEFI spec,
this stack needs to be at least 128k in size - this might seem large but
all asynchronous processing and event handling in EFI runs from the same
stack and so quite a lot of space may be used in practice.

In mixed mode, the situation is a bit different: the bootloader calls
the 32-bit EFI stub entry point, which calls the decompressor's 32-bit
entry point, where the boot stack is set up, using a fixed allocation
of 16k. This stack is still in use when the EFI stub is started in
64-bit mode, and so all calls back into the EFI firmware will be using
the decompressor's limited boot stack.

Due to the placement of the boot stack right after the boot heap, any
stack overruns have gone unnoticed. However, commit

  5c4feadb0011983b ("x86/decompressor: Move global symbol references to C code")

moved the definition of the boot heap into C code, and now the boot
stack is placed right at the base of BSS, where any overruns will
corrupt the end of the .data section.

While it would be possible to work around this by increasing the size of
the boot stack, doing so would affect all x86 systems, and mixed mode
systems are a tiny (and shrinking) fraction of the x86 installed base.

So instead, record the firmware stack pointer value when entering from
the 32-bit firmware, and switch to this stack every time a EFI boot
service call is made.

Cc: <stable@kernel.org> # v6.1+
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/efi_mixed.S | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index f4e22ef774ab6..719e939050cbf 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -49,6 +49,11 @@ SYM_FUNC_START(startup_64_mixed_mode)
 	lea	efi32_boot_args(%rip), %rdx
 	mov	0(%rdx), %edi
 	mov	4(%rdx), %esi
+
+	/* Switch to the firmware's stack */
+	movl	efi32_boot_sp(%rip), %esp
+	andl	$~7, %esp
+
 #ifdef CONFIG_EFI_HANDOVER_PROTOCOL
 	mov	8(%rdx), %edx		// saved bootparams pointer
 	test	%edx, %edx
@@ -254,6 +259,9 @@ SYM_FUNC_START_LOCAL(efi32_entry)
 	/* Store firmware IDT descriptor */
 	sidtl	(efi32_boot_idt - 1b)(%ebx)
 
+	/* Store firmware stack pointer */
+	movl	%esp, (efi32_boot_sp - 1b)(%ebx)
+
 	/* Store boot arguments */
 	leal	(efi32_boot_args - 1b)(%ebx), %ebx
 	movl	%ecx, 0(%ebx)
@@ -318,5 +326,6 @@ SYM_DATA_END(efi32_boot_idt)
 
 SYM_DATA_LOCAL(efi32_boot_cs, .word 0)
 SYM_DATA_LOCAL(efi32_boot_ds, .word 0)
+SYM_DATA_LOCAL(efi32_boot_sp, .long 0)
 SYM_DATA_LOCAL(efi32_boot_args, .long 0, 0, 0)
 SYM_DATA(efi_is64, .byte 1)
-- 
2.43.0





