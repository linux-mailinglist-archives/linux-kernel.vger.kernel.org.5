Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C521979CB00
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbjILJDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbjILJCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:02:05 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610261733
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:02:01 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-31ad607d383so3333920f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694509320; x=1695114120; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ssg+nLt0gRy/t2ju4EBj2ZAdGZIhbt4S+yOnwiWtmPM=;
        b=qxOYee4Gx0SmeMusekrIKEUMss0kBWI+188tJ4zEWbq1mWPRepTA32PkWPYXjTw4Lx
         NSj4K7rMa96Tl18XVJTufrtzAV/TwApOj1E8XuzB1Knabm4hDR/IbjHw3B+bpVJGOcN9
         tDxpe+Ar8hb6/GEk73TYLx0GUvtyNPelaPkz2ROC2GSPsmjssNQIfsCas8pql5Gt84AH
         QrFKAuMCgu1Thw2VdVOHYw3Mxl3MSr0I3WPgur90TK85C9FbsziAk19OS7S7FyB8eLEF
         pF5eNBWynrKLySYiB5OxjjEm9ND8ZZH4N5qcM7/IPVbWuhGz243xnJ8DtziiqArr2s3Y
         EJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694509320; x=1695114120;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ssg+nLt0gRy/t2ju4EBj2ZAdGZIhbt4S+yOnwiWtmPM=;
        b=IoFJ4TPrIRbr/BiR9dxjVFug5hK0FMnAxZyLUxPD3gjklZlIIHinHqomAQxjfG3rDB
         Z3Xc+9h1uGO6A0qQJcujxnfrj4eosJJmWvdzLUeSCgGNOroDqNbLz42n0d/u8LqV7Wms
         sPyOdesg9YZ9oQ9ytKX+LqaEvj+GyrCoZtRL93zrx0LyGIOZwS1UHUVAE4uKbLBf2oc0
         sqrJofdRrm3DhQdkzmo8HcJS/e4yLDnplPaTPEfcokdlwTFZplHA2ornHh3UKbzKEaGv
         vAMndCZ2xwQAu7yruoSm7PcsJWZTsVV+4mpOd+8LPi0jlXYVzgq+3tQUegRCeH1NjEXy
         aaTQ==
X-Gm-Message-State: AOJu0YyddO+tKI05ktQ+R2xi5Bbr8+9zU3zZC+ILVYvQgxjJ6Recsnqt
        NOmYrh/0YrPoHEr2QqbQepBtqhIo
X-Google-Smtp-Source: AGHT+IH4GZ3sSU0TTwD2SSNb1pwQsRhx+ZhfKWjpwhKk+jzbMoWP3PcT0MvX7stFZW/N5LvBBB4D9aKQ
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6000:180b:b0:31d:3669:1c57 with SMTP id
 m11-20020a056000180b00b0031d36691c57mr136860wrh.7.1694509319934; Tue, 12 Sep
 2023 02:01:59 -0700 (PDT)
Date:   Tue, 12 Sep 2023 09:01:05 +0000
In-Reply-To: <20230912090051.4014114-17-ardb@google.com>
Mime-Version: 1.0
References: <20230912090051.4014114-17-ardb@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2782; i=ardb@kernel.org;
 h=from:subject; bh=EUYFfbmK6RQsww/qm0tkKUKTK2BZhCpRAZNS6SgMkh0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZVB48qXp5uPKKccNfsqwR8gz7hrUlrvGdHnKy/Hblfn5
 1p9dMvEjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjARvlqG/+Xlc5m5rmhJy3it
 kbG6sNqyZMUzj5NF70yeNS6OvrPz7FJGhlXdXuVf/FzPLLFTZwjVc/ZUfWb6+azjvLmNT/18dzo z8wIA
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912090051.4014114-31-ardb@google.com>
Subject: [PATCH v2 14/15] x86/boot: Split off PE/COFF .data section
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

Describe the code and data of the decompressor binary using separate
.text and .data PE/COFF sections, so that we will be able to map them
using restricted permissions once we increase the section and file
alignment sufficiently. This avoids the need for memory mappings that
are writable and executable at the same time, which is something that
is best avoided for security reasons.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/Makefile |  2 +-
 arch/x86/boot/header.S | 19 +++++++++++++++----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index cc04917b1ac6..3cece19b7473 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -89,7 +89,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
 
 SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))
 
-sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi.._stub_entry\|efi\(32\)\?_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|_edata\|z_.*\)$$/\#define ZO_\2 0x\1/p'
+sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi.._stub_entry\|efi\(32\)\?_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|_e\?data\|z_.*\)$$/\#define ZO_\2 0x\1/p'
 
 quiet_cmd_zoffset = ZOFFSET $@
       cmd_zoffset = $(NM) $< | sed -n $(sed-zoffset) > $@
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 9e9641e220a7..a1f986105f00 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -75,9 +75,9 @@ optional_header:
 	.byte	0x02				# MajorLinkerVersion
 	.byte	0x14				# MinorLinkerVersion
 
-	.long	setup_size + ZO__end - 0x200	# SizeOfCode
+	.long	ZO__data			# SizeOfCode
 
-	.long	0				# SizeOfInitializedData
+	.long	ZO__end - ZO__data		# SizeOfInitializedData
 	.long	0				# SizeOfUninitializedData
 
 	.long	setup_size + ZO_efi_pe_entry	# AddressOfEntryPoint
@@ -178,9 +178,9 @@ section_table:
 	.byte	0
 	.byte	0
 	.byte	0
-	.long	ZO__end
+	.long	ZO__data
 	.long	setup_size
-	.long	ZO__edata			# Size of initialized data
+	.long	ZO__data			# Size of initialized data
 						# on disk
 	.long	setup_size
 	.long	0				# PointerToRelocations
@@ -191,6 +191,17 @@ section_table:
 		IMAGE_SCN_MEM_READ		| \
 		IMAGE_SCN_MEM_EXECUTE		# Characteristics
 
+	.ascii	".data\0\0\0"
+	.long	ZO__end - ZO__data		# VirtualSize
+	.long	setup_size + ZO__data		# VirtualAddress
+	.long	ZO__edata - ZO__data		# SizeOfRawData
+	.long	setup_size + ZO__data		# PointerToRawData
+
+	.long	0, 0, 0
+	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
+		IMAGE_SCN_MEM_READ		| \
+		IMAGE_SCN_MEM_WRITE		# Characteristics
+
 	.set	section_count, (. - section_table) / 40
 #endif /* CONFIG_EFI_STUB */
 
-- 
2.42.0.283.g2d96d420d3-goog

