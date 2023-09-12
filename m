Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7952279CAF5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbjILJCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjILJBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:01:52 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB5310F5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:01:47 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59b5a586da6so72361317b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694509306; x=1695114106; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9nidTUp9SfmxoZ7qPUJb2CvRiTCjXhfgV4NtmpRRUQ=;
        b=uarji8ImEDmaBrRGKkhjPq3cKassS5G5uFX43YzDexl49Ry+a3QZL9MG7ThGHgWlQd
         Y0CWTkRj+MWZEOCeLe9PVNIKUBJwSb/sJLBef++A2a5cHHy0qoG3ctN532ku0/fVEi9V
         x7e+Pvv5Y/1lb8iM9KbgxTzARRZkH8IH+jGbJcwwEmeEU0Jd/OY7vzaM5Npe1d3TNcWe
         G/QEHopfmDgdtVS3e98iSVQ/82XH7iqzqhyks9gqijAMKeZuDciH+60YSUf3Qq0AO0v2
         iXahNWqYYK8lBLrwZsJytN3+a7mXXYdrv5yWNaHAvxppenamUqCvNHl2YPbVlvRFHNdj
         LYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694509306; x=1695114106;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9nidTUp9SfmxoZ7qPUJb2CvRiTCjXhfgV4NtmpRRUQ=;
        b=dRo0MK5YJ///RMXysnitc5cTwbP3xJYXxqhYiABdbFdYoBn6p9GOz2RBAKIppfEevr
         Kota82GGWRqRXiv+L+i2udMF41uDiQPYnM0lziSVjpsrJtTWQEsvVdf65+0nv8Rdo4Hf
         7E7870fs4J2Mx6zMgeujVmB3f1gH18RLLqGla+Mi5vjWw8fKE0OBjLTMSGgeuTlRRguP
         v2f8YRg3Gug0qEfyhfM8/GVg7BCWRhZXTdb8lbshsd55P6poAnlXJcaFFhNVlnQsNvmJ
         TzUYpIVjXlKjaxsgbWdAIU6NSgptN+zdv+DUB1B0+K+KPQ33bnluL85oHbiexQ8sgClU
         WYeA==
X-Gm-Message-State: AOJu0YyR8jcjw8B7wfatORJxuxkdSApNxYYa7GF72fBYCNO4AWH34qTJ
        tS7EBZDg9lxLp9AikX67lTI0t1Qo
X-Google-Smtp-Source: AGHT+IGxmPKB/y+ySrJIyO4enhcQpXIfk+/LW2EPh/2dyfSnawxn6t+nkk06KjcANP24owupAqiZpD4B
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:690c:3109:b0:595:9e93:60c8 with SMTP id
 fb9-20020a05690c310900b005959e9360c8mr50166ywb.1.1694509306757; Tue, 12 Sep
 2023 02:01:46 -0700 (PDT)
Date:   Tue, 12 Sep 2023 09:01:00 +0000
In-Reply-To: <20230912090051.4014114-17-ardb@google.com>
Mime-Version: 1.0
References: <20230912090051.4014114-17-ardb@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3304; i=ardb@kernel.org;
 h=from:subject; bh=+ZvWQ8j9ySgnkiTP3OG0/i2YLZe9tEVF555eZXpiERA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZVB45zQcvU2RcHcHr2P36TEZvVeCnqfGa93ddvZrZbd4
 pMt7sd1lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgImUPWL4Hxtycs/T3DuCZa9D
 6rec2i5qt2rdM2NJrU2tU41aczaW2zIyrLDbcGmSeVlJ0H3vexv/2Wj8/Oa6IrPQz03x4pNDe2Z e5wcA
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912090051.4014114-26-ardb@google.com>
Subject: [PATCH v2 09/15] x86/boot: Set EFI handover offset directly in header asm
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
2.42.0.283.g2d96d420d3-goog

