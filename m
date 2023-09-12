Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC9479CAEB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjILJCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbjILJBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:01:35 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FB910E2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:01:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d77fa2e7771so4849120276.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694509289; x=1695114089; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2tvI11no6ZvQpwOGtD7SmPhcRm3cJFuX6Xc9ZqA56hw=;
        b=x0DkT4QfoP1z0fPoCBH2KFSNVvBheW33Yju0Mz2+wy8Gdh1dEHLhFrcWHCQtCClRUb
         OK6zV3DqDX+8dWGbE1kJIZJa97oDuCeAC767M7hDEyFHeV6BOygUTW+lrBnIpNr5Y9AS
         FNo/279FW12sihan9pLiU4Achifn/Qq847JYj3NqGPwsZBcF5LltxYN6sDf2ddUX2+Da
         py9CZRxDWiQ+Gg23roewjWzciM+H5WaX9onOTRfSs9nXg2XUsK3tj0rVq0RYLCuDLiD6
         hDP1GJlHIyCa2FZVHIS1rNOgXl3Q1r5dK7HBwwrJWPIWIMVnAnlXfl5GMsjwoBZpw7rH
         7PJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694509289; x=1695114089;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2tvI11no6ZvQpwOGtD7SmPhcRm3cJFuX6Xc9ZqA56hw=;
        b=vBpCXT0ukdEGDxr8h6V6eKjqv6lfo4KpgjD1irRV/8sQBNzuATxgBHwNUr7nZmIm1Y
         hHwwxAt9XI4NHxk3cCRg/VrrG3VhHrkVXgkvOhWFBJ+m4O27Q7os7LxDEg6a7kMzaYs9
         uNFix31m/qSOenHJhMyviq0bAeLAZRJ+F1Qgy03BeWlCIKj+OkU4cy3PL6z9jn5v6Xq8
         ym4lM5y2/Z8qmS5QxO8IFaAfgR1hgxg0o3xUH6676kb/qGKoAtRdKnW+ydfTKlFwUMJs
         OVOXcwj0Y54bM98Ueji3B7MOWMROVryYkEQKSGhSUXEjvbGPT5wsg85I+qF4vmsuxYX6
         8pmQ==
X-Gm-Message-State: AOJu0YwLAX87XubkOvOdc4hdc+rE+Vs8rfYVv2+r3Iup+BEUQXX5ocAD
        iQya80beWy4MsswIR23Q4SWuIeUU
X-Google-Smtp-Source: AGHT+IGFlBfEsGa7oWurzDLl/SbOLYcvdinALugrqVeiiQbXKMzAzAWym2jp1tk5FdY/S7niWkYNKUl9
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1707:b0:d7b:9830:c172 with SMTP id
 by7-20020a056902170700b00d7b9830c172mr288041ybb.0.1694509289690; Tue, 12 Sep
 2023 02:01:29 -0700 (PDT)
Date:   Tue, 12 Sep 2023 09:00:53 +0000
In-Reply-To: <20230912090051.4014114-17-ardb@google.com>
Mime-Version: 1.0
References: <20230912090051.4014114-17-ardb@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3785; i=ardb@kernel.org;
 h=from:subject; bh=nvt548TxMzPAfrcolR6Dxu6IZrj/XUbhhxX9pY3970g=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZVB49j5KR1frtj1n1wYllN3piW9b0/FzQSf7qBt+x9ly
 ixa9P5ERykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhIdAYjw4XPli+nl82Vb1n5
 //HJSUe0l0ue+sazYl15m7Ojx56gb0wM/ytbVl75yJ9y/9vtur971Kx5c5QqAjaoVRxvMppfG2a gyAQA
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912090051.4014114-19-ardb@google.com>
Subject: [PATCH v2 02/15] x86/efi: Disregard setup header of loaded image
From:   Ard Biesheuvel <ardb@google.com>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

The native EFI entrypoint does not take a struct boot_params from the
loader, but instead, it constructs one from scratch, using the setup
header data placed at the start of the image.

This setup header is placed in a way that permits legacy loaders to
manipulate the contents (i.e., to pass the kernel command line or the
address and size of an initial ramdisk), but EFI boot does not use it in
that way - it only copies the contents that were placed there at build
time, but EFI loaders will not (and should not) manipulate the setup
header to configure the boot. (Commit 63bf28ceb3ebbe76 "efi: x86: Wipe
setup_data on pure EFI boot" deals with some of the fallout of using
setup_data in a way that breaks EFI boot.)

Given that none of the non-zero values that are copied from the setup
header into the EFI stub's struct boot_params are relevant to the boot
now that the EFI stub no longer enters via the legacy decompressor, the
copy can be omitted altogether.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 46 +++-----------------
 1 file changed, 6 insertions(+), 40 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 2fee52ed335d..d76a9f7c35d0 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -449,9 +449,8 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 				   efi_system_table_t *sys_table_arg)
 {
-	struct boot_params *boot_params;
-	struct setup_header *hdr;
-	void *image_base;
+	static struct boot_params boot_params __page_aligned_bss;
+	struct setup_header *hdr = &boot_params.hdr;
 	efi_guid_t proto = LOADED_IMAGE_PROTOCOL_GUID;
 	int options_size = 0;
 	efi_status_t status;
@@ -469,30 +468,9 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 		efi_exit(handle, status);
 	}
 
-	image_base = efi_table_attr(image, image_base);
-
-	status = efi_allocate_pages(sizeof(struct boot_params),
-				    (unsigned long *)&boot_params, ULONG_MAX);
-	if (status != EFI_SUCCESS) {
-		efi_err("Failed to allocate lowmem for boot params\n");
-		efi_exit(handle, status);
-	}
-
-	memset(boot_params, 0x0, sizeof(struct boot_params));
-
-	hdr = &boot_params->hdr;
-
-	/* Copy the setup header from the second sector to boot_params */
-	memcpy(&hdr->jump, image_base + 512,
-	       sizeof(struct setup_header) - offsetof(struct setup_header, jump));
-
-	/*
-	 * Fill out some of the header fields ourselves because the
-	 * EFI firmware loader doesn't load the first sector.
-	 */
+	/* assign the setup_header fields that the kernel actually cares about */
 	hdr->root_flags	= 1;
 	hdr->vid_mode	= 0xffff;
-	hdr->boot_flag	= 0xAA55;
 
 	hdr->type_of_loader = 0x21;
 
@@ -501,25 +479,13 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	if (!cmdline_ptr)
 		goto fail;
 
-	efi_set_u64_split((unsigned long)cmdline_ptr,
-			  &hdr->cmd_line_ptr, &boot_params->ext_cmd_line_ptr);
-
-	hdr->ramdisk_image = 0;
-	hdr->ramdisk_size = 0;
-
-	/*
-	 * Disregard any setup data that was provided by the bootloader:
-	 * setup_data could be pointing anywhere, and we have no way of
-	 * authenticating or validating the payload.
-	 */
-	hdr->setup_data = 0;
+	efi_set_u64_split((unsigned long)cmdline_ptr, &hdr->cmd_line_ptr,
+			  &boot_params.ext_cmd_line_ptr);
 
-	efi_stub_entry(handle, sys_table_arg, boot_params);
+	efi_stub_entry(handle, sys_table_arg, &boot_params);
 	/* not reached */
 
 fail:
-	efi_free(sizeof(struct boot_params), (unsigned long)boot_params);
-
 	efi_exit(handle, status);
 }
 
-- 
2.42.0.283.g2d96d420d3-goog

