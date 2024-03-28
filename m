Return-Path: <linux-kernel+bounces-121045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5729588E293
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0266B30626
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBBE15E5A0;
	Wed, 27 Mar 2024 12:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbL1IpoU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8A415E20E;
	Wed, 27 Mar 2024 12:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541928; cv=none; b=LW+zwQmxLhniIKZus1d045plkFKwDpdsSws3VzmsbTWxSC7S+MOXYswAPVok3Ryt1SajsGkzpufVLCxYcfkJiTCfjbgnISHkB2s8N7k9R6n2b7AC0p3S0qbkHtK0t9Es1NDnmlqpUH5sVghhVMY30it1jBfuI88IZ/QeErwqhKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541928; c=relaxed/simple;
	bh=68O6XXYr0IlJya/H/GKuxkbgcuiBxpanA02NM+THtis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KYmpzS28bdAQYZarSkXyfJdFypiQkhSXxz/X/xOTG9j4EEQabmBM7dXcXzVh4YC+YVUBWWarATqaWc3J4UgOWIzI/Zm9qfxpx9i/p44RtJBnilMs7ZppNpsBOKf0518EQhaRS9d+njJCrykF8OpGwGpJ0Yg71G33c55SfFCPw4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbL1IpoU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C22C433F1;
	Wed, 27 Mar 2024 12:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541928;
	bh=68O6XXYr0IlJya/H/GKuxkbgcuiBxpanA02NM+THtis=;
	h=From:To:Cc:Subject:Date:From;
	b=GbL1IpoUyuRbDHgMqbAMzNNCnGzuyXDao85iy1W/2BNSBCJ+XfW5Ih7qbsqghiMlZ
	 ccYcXmGrmCxX0XBfoydcgp+1vAzft45KAm1q5UCvLMtgSg5XhvRF934fMcSGFMoeEl
	 qgqrMzamqVYgrFQghTLkoOK7iTR5LErifepbZ8i9nfZeINO4GUhRS1yOJx7uw6+psC
	 uBT8uS5IKwHs0sPUGVLEjdg6rHgRqDvp9JfQqxIVnCRRuAmhxLyN9jdhkEaLdvfXSo
	 XjMMZACU/T4qwzWWMokAzrgXc75zkXDSTRkoMRbpeBTxN8olstogSaJRmw2Ytu1PtV
	 f4OVsDca811Pw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ardb@kernel.org
Cc: stable@kernel.org,
	Radek Podgorny <radek@podgorny.cz>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "x86/efistub: Clear decompressor BSS in native EFI entrypoint" failed to apply to 5.10-stable tree
Date: Wed, 27 Mar 2024 08:18:46 -0400
Message-ID: <20240327121846.2834664-1-sashal@kernel.org>
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





