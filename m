Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF6E7A247B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbjIORRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbjIORRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:17:07 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D06186
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:17:01 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59c081a44afso15785557b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694798220; x=1695403020; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E9eWcbH+X5RovGSPuQxChs9MvgHe0ps0mCUAD008mTw=;
        b=XH4eTEjXWhSQmEhHMHHZYXCQLXMyqB9TLK33pjqdElp0xlkujB0YLJ8bazM465IyWF
         f9KGdslZnpIRC5jfIyiXguM4HbTAeRFK0mMXU0jS6Ui3JmdHj4wEDvqew6E+P0Z4PV0b
         lyFPkFMInVQkfPfZEjAxl7gi4Z1bNvaUNXr+rKQSEcbFPXMv1MIaTpUWcH4xMXSfxXHe
         TgcSf8bsfLu+NlEVjUked5w/nzugYIFUKXa9C/i6iOM29Cq3AC6UliFgvFtPxHBU7OOR
         LvdTv/3orZDTc7msw9U1S/p49Pu/K+nN0Z+3uL5O8EnId0eLhfpJ5yMYikfiJGaTgeek
         /E5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694798221; x=1695403021;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E9eWcbH+X5RovGSPuQxChs9MvgHe0ps0mCUAD008mTw=;
        b=iDSTQzKeqaOsJee34FbQ4cQ9T7WgUvsuMXwtM/ywr3lawp6yoEvU2F2rysq0VGZOm4
         saP10pcIUCA3u5Zie4FsFUrPPAhDKtPH/ecEGCkDisWdY4zGI7OtqyERX/eitLZ9V1dp
         DXmeGJBk7r8jpSxeznOfH5k0rqYKJxJ3P4IInqCAkxI6wi3/nh6kKCbsF7QERKS/3T2u
         DgMY704VoVryfF9C9NeIxv64jo3FMl93R4lz6hDExBxXyGU2lrAYPBmHQZFx6jb8+kcp
         AgC0AzHli84RMZDC5OJAyzeiDzUxxkBc3Jq1ad0LfCuopOsea/9SGHAvWOHQOA6PFKAt
         qfqw==
X-Gm-Message-State: AOJu0Yw/9Q6kTtyf8E6Xp2kxeQVOYpCEU3HgQAUekoGeF2NPsq+stHVa
        xK6z1ijsMVJ4yjsP/WHR0cupS1yT
X-Google-Smtp-Source: AGHT+IFtQXI11txgKs/647s9qdsCl7yLhMru8nI1binF3h1LHoJBEeCf/lDSyWZL5m4sNqFHFYeFg4jr
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a25:ad4b:0:b0:d7e:b82a:ef68 with SMTP id
 l11-20020a25ad4b000000b00d7eb82aef68mr47501ybe.3.1694798220818; Fri, 15 Sep
 2023 10:17:00 -0700 (PDT)
Date:   Fri, 15 Sep 2023 17:16:26 +0000
In-Reply-To: <20230915171623.655440-10-ardb@google.com>
Mime-Version: 1.0
References: <20230915171623.655440-10-ardb@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3304; i=ardb@kernel.org;
 h=from:subject; bh=OUd8E2aciVCnJVkSx3yx1dxd9pxNed9z5i4jS/GHCYk=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZVlYhaTwk2vRL0Z514lbzwsMa1y/Z9da0OK1umvYV5g3
 q2e17auo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExE6xojwzS5awVtJ1R2lvzk
 7P6bH2N5Tr3NccqNz/kPX2Y9TLwpK8nI8Kx0Zb5A+k1pLRv+D7euxd/8ljdhetPnlBy/7OXiFx4 6swAA
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915171623.655440-12-ardb@google.com>
Subject: [PATCH v3 2/8] x86/boot: Set EFI handover offset directly in header asm
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

The offsets of the EFI handover entrypoints are available to the
assembler when constructing the header, so there is no need to set them
from the build tool afterwards.

This change has no impact on the resulting bzImage binary.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S      | 18 ++++++++++++++-
 arch/x86/boot/tools/build.c | 24 --------------------
 2 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 5575d0f06bab..72744ba440f6 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -524,8 +524,24 @@ pref_address:		.quad LOAD_PHYSICAL_ADDR	# preferred load addr
 # define INIT_SIZE VO_INIT_SIZE
 #endif
 
+	.macro		__handover_offset
+#ifndef CONFIG_EFI_HANDOVER_PROTOCOL
+	.long		0
+#elif !defined(CONFIG_X86_64)
+	.long		ZO_efi32_stub_entry
+#else
+	/* Yes, this is really how we defined it :( */
+	.long		ZO_efi64_stub_entry - 0x200
+#ifdef CONFIG_EFI_MIXED
+	.if		ZO_efi32_stub_entry != ZO_efi64_stub_entry - 0x200
+	.error		"32-bit and 64-bit EFI entry points do not match"
+	.endif
+#endif
+#endif
+	.endm
+
 init_size:		.long INIT_SIZE		# kernel initialization size
-handover_offset:	.long 0			# Filled in by build.c
+handover_offset:	__handover_offset
 kernel_info_offset:	.long ZO_kernel_info
 
 # End of setup header #####################################################
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 14ef13fe7ab0..069497543164 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -55,8 +55,6 @@ u8 buf[SETUP_SECT_MAX*512];
 #define PECOFF_COMPAT_RESERVE 0x0
 #endif
 
-static unsigned long efi32_stub_entry;
-static unsigned long efi64_stub_entry;
 static unsigned long efi_pe_entry;
 static unsigned long efi32_pe_entry;
 static unsigned long _end;
@@ -265,31 +263,12 @@ static void efi_stub_defaults(void)
 #endif
 }
 
-static void efi_stub_entry_update(void)
-{
-	unsigned long addr = efi32_stub_entry;
-
-#ifdef CONFIG_EFI_HANDOVER_PROTOCOL
-#ifdef CONFIG_X86_64
-	/* Yes, this is really how we defined it :( */
-	addr = efi64_stub_entry - 0x200;
-#endif
-
-#ifdef CONFIG_EFI_MIXED
-	if (efi32_stub_entry != addr)
-		die("32-bit and 64-bit EFI entry points do not match\n");
-#endif
-#endif
-	put_unaligned_le32(addr, &buf[0x264]);
-}
-
 #else
 
 static inline void update_pecoff_setup_and_reloc(unsigned int size) {}
 static inline void update_pecoff_text(unsigned int text_start,
 				      unsigned int file_sz) {}
 static inline void efi_stub_defaults(void) {}
-static inline void efi_stub_entry_update(void) {}
 
 static inline int reserve_pecoff_reloc_section(int c)
 {
@@ -332,8 +311,6 @@ static void parse_zoffset(char *fname)
 	p = (char *)buf;
 
 	while (p && *p) {
-		PARSE_ZOFS(p, efi32_stub_entry);
-		PARSE_ZOFS(p, efi64_stub_entry);
 		PARSE_ZOFS(p, efi_pe_entry);
 		PARSE_ZOFS(p, efi32_pe_entry);
 		PARSE_ZOFS(p, _end);
@@ -416,7 +393,6 @@ int main(int argc, char ** argv)
 
 	update_pecoff_text(setup_sectors * 512, i + (sys_size * 16));
 
-	efi_stub_entry_update();
 
 	crc = partial_crc32(buf, i, crc);
 	if (fwrite(buf, 1, i, dest) != i)
-- 
2.42.0.459.ge4e396fd5e-goog

