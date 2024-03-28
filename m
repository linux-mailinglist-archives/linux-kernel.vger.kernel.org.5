Return-Path: <linux-kernel+bounces-120972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9AA88E11A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5C91F2DDA6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F46154C16;
	Wed, 27 Mar 2024 12:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfHSqVXJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8774D154C01;
	Wed, 27 Mar 2024 12:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541732; cv=none; b=kIEpA27fJfz5Gycn/RXMBUAU1qxO28i6WZbV2EgP246qHp2vlZ4Bb6mZ7MdKt0IH4XoLtXEBTDRunVRjLggNJJgRvjNG11zxRQeaUNBXSSdsNAFwt8JJ0oFImdHPzgMctREAvsFP13q5H7JBQZsfqoAiJkMdJkShUPKWMcNYHTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541732; c=relaxed/simple;
	bh=lNQbdKRflk16maW7ZwdkNbs/gGlJa9QMoMDr0oQoQFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CM+SWA9TCqMY9hHWqaZiJCOGZ2UFuSfwnpXMTJNYrSMEIDlaJct4hYNMr/XcEswezplTY94+ID36mazkNs19WcxzgkIPGKiEniuizxhE8ixgS0YLjPjNB1mPx97zH9kekPMp5xIveFkS72HULbJqfK7KlH+2hpIaOZEZqDzXgRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfHSqVXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F7EC433F1;
	Wed, 27 Mar 2024 12:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541732;
	bh=lNQbdKRflk16maW7ZwdkNbs/gGlJa9QMoMDr0oQoQFo=;
	h=From:To:Cc:Subject:Date:From;
	b=gfHSqVXJzIAkVGeKfcvX/YlvvzZrNlxoVFKqU/R6jI6IUTU6Bc6gpCO6X0yOO0zRn
	 fqys0Kze8PSnpPnIERFnSZncilpGJRCx+5IlnvZfSJPQ7xJpjTYyVMnY9a1ZRtF1mv
	 BJf2lv9zdKTsyR4Q30HVJ1xMciC8EZ+lZDz3yVVPZJQCzICVPHn5pGU3+aKmKZ/4Ci
	 ogpnOP6RtVAm5SfraB4APjrLMFeqNcbHv2/fK3thlBPdZXDcpm4KntBctJleIm1kUB
	 3LFC6o3kJRaQh+VKJrEtDqMH7z/BE0+z76PtW/LMaYh6r5IDJF/a1Udz0lx0tuP24H
	 mHdqVHh8JzbCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ardb@kernel.org
Cc: stable@kernel.org,
	Radek Podgorny <radek@podgorny.cz>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "x86/efistub: Clear decompressor BSS in native EFI entrypoint" failed to apply to 5.15-stable tree
Date: Wed, 27 Mar 2024 08:15:30 -0400
Message-ID: <20240327121530.2831969-1-sashal@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b3810c5a2cc4a6665f7a65bed5393c75ce3f3aa2 Mon Sep 17 00:00:00 2001
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 15 Mar 2024 16:26:16 +0100
Subject: [PATCH] x86/efistub: Clear decompressor BSS in native EFI entrypoint

The EFI stub on x86 no longer invokes the decompressor as a subsequent
boot stage, but calls into the decompression code directly while running
in the context of the EFI boot services.

This means that when using the native EFI entrypoint (as opposed to the
EFI handover protocol, which clears BSS explicitly), the firmware PE
image loader is being relied upon to ensure that BSS is zeroed before
the EFI stub is entered from the firmware.

As Radek's report proves, this is a bad idea. Not all loaders do this
correctly, which means some global variables that should be statically
initialized to 0x0 may have junk in them.

So clear BSS explicitly when entering via efi_pe_entry(). Note that
zeroing BSS from C code is not generally safe, but in this case, the
following assignment and dereference of a global pointer variable
ensures that the memset() cannot be deferred or reordered.

Cc: <stable@kernel.org> # v6.1+
Reported-by: Radek Podgorny <radek@podgorny.cz>
Closes: https://lore.kernel.org/all/a99a831a-8ad5-4cb0-bff9-be637311f771@podgorny.cz
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 35413c8dfc251..2096ae09438e4 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -21,6 +21,8 @@
 #include "efistub.h"
 #include "x86-stub.h"
 
+extern char _bss[], _ebss[];
+
 const efi_system_table_t *efi_system_table;
 const efi_dxe_services_table_t *efi_dxe_table;
 static efi_loaded_image_t *image = NULL;
@@ -474,6 +476,8 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	efi_status_t status;
 	char *cmdline_ptr;
 
+	memset(_bss, 0, _ebss - _bss);
+
 	efi_system_table = sys_table_arg;
 
 	/* Check if we were booted by the EFI firmware */
@@ -967,8 +971,6 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 void efi_handover_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg,
 			struct boot_params *boot_params)
 {
-	extern char _bss[], _ebss[];
-
 	memset(_bss, 0, _ebss - _bss);
 	efi_stub_entry(handle, sys_table_arg, boot_params);
 }
-- 
2.43.0





