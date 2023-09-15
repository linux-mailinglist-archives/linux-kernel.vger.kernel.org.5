Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C757A247C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbjIORRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbjIORRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:17:11 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE3B83
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:17:05 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-31fb093a53aso1537096f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694798223; x=1695403023; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=89g8O0FeFLI+vAm3VnFZD9BW/eMlaApKHGhLfa7SlGI=;
        b=sqt3v+Gslbmwnsz9rQ7GnAQ5ScLQDz6UeJXuiKYq9fEQhB7XYS5CRRQhxMRiTAE4Tj
         URORcrpwnusJmj67M0QDuhT7T7kjKkYBKwL8+19vUV/i09vSU3oN/ER9etjRGxCPuEN/
         672CxdpiBJmfQmFYxkwFi6Txy2jYuzc8CL0AVxyJqFhAu/nrfiQo+21MrB9d8tZLY1dK
         yz+AHFi9j1WNeZFu7VS3nEhodnqjFNL5sMFvoX50E53Jxm7qg3BsEIET2Q6R1HA01hCm
         5cECVXPtAFPEPb2ebBgVwHgCo0bxxX1FZ6LbGB19SCZ2T1JlEEdOLE9zdPXpHKcpEZeU
         DNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694798223; x=1695403023;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=89g8O0FeFLI+vAm3VnFZD9BW/eMlaApKHGhLfa7SlGI=;
        b=liF1vg9399qJT/PC1MVSwzUbbDnrxuewNLML2h/+kU186iaezkmM27O5Guk8HXbUzm
         9o5j/aglX6rSOrd5XSiRRH2bU7y37CFGiF+GHPrgIBGTyGMDZVk7Tf39JSDZL/jVVjKQ
         sAp7u+vIT1K5fpjFIVaqHeX89qemaTwd8cDmO+PAiVkUC25sa2BBB9slAB5uM2hPLkZM
         +ZXDFYbEq1Je1Nq2fdHLecgKIVHqdbYo4Zbmi4tNMMbKeEwbu5xYGi6xfIaRV+cRsW/z
         45YyzAhJ3MGYsxk5RqDVbsNnoBo4R8AuHj6fDeYymNprG9zySWkqDj8uqtUc4XVZpDCA
         nDNw==
X-Gm-Message-State: AOJu0YyQBcYO9Xaz+A/Wj3rMv/ci3IQd9wq8g/ZllCAi854n5G1xxwOW
        doa9qDs12PkHT8cPZnfL0tY1cnJq
X-Google-Smtp-Source: AGHT+IFMSui6f+3/+Y4hY8Qz91p3kTgd5GjtcwDQx1xLiE0TLyDco4yn73I+CQFu3f+LXtULspQ/3LFq
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a5d:4152:0:b0:319:6fc6:151 with SMTP id
 c18-20020a5d4152000000b003196fc60151mr26188wrq.10.1694798223502; Fri, 15 Sep
 2023 10:17:03 -0700 (PDT)
Date:   Fri, 15 Sep 2023 17:16:27 +0000
In-Reply-To: <20230915171623.655440-10-ardb@google.com>
Mime-Version: 1.0
References: <20230915171623.655440-10-ardb@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3059; i=ardb@kernel.org;
 h=from:subject; bh=be7iDzl8pMuNbGRQpSLTpnBfKOp7BhO0eZKOBUcXTVM=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZVlYvarrBa1T7tCypYv8zz8v+iMLdPCvVM+nX3w+OanZ
 cFPl3uIdZSyMIhxMMiKKbIIzP77bufpiVK1zrNkYeawMoEMYeDiFICJuDxn+KdeJ977bN5qft94
 28rfTS+DYouehc9+F5q8M2euULvph3mMDJPyd9+YwTAj3815m+mSQ4YOWgvWloc+1rurapWRerX Ngw0A
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915171623.655440-13-ardb@google.com>
Subject: [PATCH v3 3/8] x86/boot: Define setup size in linker script
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

The setup block contains the real mode startup code that is used when
booting from a legacy BIOS, along with the boot_params/setup_data that
is used by legacy x86 bootloaders to pass the command line and initial
ramdisk parameters, among other things.

The setup block also contains the PE/COFF header of the entire combined
image, which includes the compressed kernel image, the decompressor and
the EFI stub.

This PE header describes the layout of the executable image in memory,
and currently, the fact that the setup block precedes it makes it rather
fiddly to get the right values into the right place in the final image.

Let's make things a bit easier by defining the setup_size in the linker
script so it can be referenced from the asm code directly, rather than
having to rely on the build tool to calculate it. For the time being,
add 64 bytes of fixed padding for the .reloc and .compat sections - this
will be removed in a subsequent patch after the PE/COFF header has been
reorganized.

This change has no impact on the resulting bzImage binary when
configured with CONFIG_EFI_MIXED=y.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S      | 2 +-
 arch/x86/boot/setup.ld      | 4 ++++
 arch/x86/boot/tools/build.c | 6 ------
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 72744ba440f6..06bd72a324c1 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -231,7 +231,7 @@ sentinel:	.byte 0xff, 0xff        /* Used to detect broken loaders */
 
 	.globl	hdr
 hdr:
-setup_sects:	.byte 0			/* Filled in by build.c */
+		.byte setup_sects - 1
 root_flags:	.word ROOT_RDONLY
 syssize:	.long 0			/* Filled in by build.c */
 ram_size:	.word 0			/* Obsolete */
diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
index b11c45b9e51e..9bd5c1ada599 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -39,6 +39,10 @@ SECTIONS
 	.signature	: {
 		setup_sig = .;
 		LONG(0x5a5aaa55)
+
+		/* Reserve some extra space for the reloc and compat sections */
+		setup_size = ALIGN(ABSOLUTE(.) + 64, 512);
+		setup_sects = ABSOLUTE(setup_size / 512);
 	}
 
 
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 069497543164..745d64b6d930 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -48,12 +48,7 @@ typedef unsigned int   u32;
 u8 buf[SETUP_SECT_MAX*512];
 
 #define PECOFF_RELOC_RESERVE 0x20
-
-#ifdef CONFIG_EFI_MIXED
 #define PECOFF_COMPAT_RESERVE 0x20
-#else
-#define PECOFF_COMPAT_RESERVE 0x0
-#endif
 
 static unsigned long efi_pe_entry;
 static unsigned long efi32_pe_entry;
@@ -388,7 +383,6 @@ int main(int argc, char ** argv)
 #endif
 
 	/* Patch the setup code with the appropriate size parameters */
-	buf[0x1f1] = setup_sectors-1;
 	put_unaligned_le32(sys_size, &buf[0x1f4]);
 
 	update_pecoff_text(setup_sectors * 512, i + (sys_size * 16));
-- 
2.42.0.459.ge4e396fd5e-goog

