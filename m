Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33DF79CAEA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjILJCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbjILJBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:01:34 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24D810DB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:01:27 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id 5b1f17b1804b1-401d9abf21cso44364805e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694509286; x=1695114086; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nleEiUxtWQK05LpNdDZIQqSdfG3IcCEvn9DBHrWFfWI=;
        b=saKcnHbFY9shMLG65l6MVR8jcL7FYnrbiIJ2xDQUR+msXSk3EGjcDabbucnlwtR8nX
         N/m0QWQZnukfrxl7/h9LmR30P1YYX8SblnyzuRMtcsiCqfD8H5eqP85sJEOmyO7MjYWG
         oqOADQ2T87Z5KQTRmBVIDsjRSQv3wYYrlt5+s8PQ1gFAYbjMmIbRsueS4dQ7yZ9MShWS
         bhA7lk6O1m5l0HrbEmLoXtyTbkwDNAGTwWf7DWAIJ4drR5CFLRsf37GBBKY3wvAbq3s7
         RX96wHBQeBo+cP4xdg3GyXUHq51nihyODFtTmeurKgeVoSUU/2isyIqGXn+BqVkxGdz4
         LthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694509286; x=1695114086;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nleEiUxtWQK05LpNdDZIQqSdfG3IcCEvn9DBHrWFfWI=;
        b=oazeLtfJbB8vW3Ayg1J+avz0dna3/ijjbJ6PeHp0uf6djS8H+rb3YFz2utakJZYQvV
         B0ma2wCWswIDVzaGyciI/rHvEJKKSNFpE0Rb+YIDxnMeXQDNapzFDkCc14P/X9BCRDg8
         4W7JQrpxCQBOVBb67+D9/lvia6OCYzoDMSCXSJ+WPrshty0bN3i6jQITUSUP3dw1Fzak
         xnwCMedA17NC/NNJFKZXr2hR85rzpcFfzXAxv5qV3vcrP8qd18cSU6Xg/knUd3cRrdn8
         1mIDdNpvKWSYNgprwQtVhP2IqO2536LmdoAX+hKXbJiGY7A9phhH6Xu15RlUCiBrL7yd
         Rdfw==
X-Gm-Message-State: AOJu0YwE0lnIC/rs2PbcYBUQi2msa3nWfhUhyFYjCJm3ZDAenLHOAASb
        VVwmrHX1nrqF0n/1MnnBOim0BpfR
X-Google-Smtp-Source: AGHT+IFvOelpLd+x36Cli/GAQtzEJhHtlopkn1hBzlB+JfAAdxI79BgDIoLsCn+1lAhp/JziSq19ahct
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:adf:e74c:0:b0:31d:da34:ab29 with SMTP id
 c12-20020adfe74c000000b0031dda34ab29mr126792wrn.4.1694509286433; Tue, 12 Sep
 2023 02:01:26 -0700 (PDT)
Date:   Tue, 12 Sep 2023 09:00:52 +0000
In-Reply-To: <20230912090051.4014114-17-ardb@google.com>
Mime-Version: 1.0
References: <20230912090051.4014114-17-ardb@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1663; i=ardb@kernel.org;
 h=from:subject; bh=gNIz7ZxXkHY+pNuQ2qtskD6P4vNCT8lDOlsSsxZxFs4=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZVB46juNIefTPeTHzgGbf7VcjRyRvYHm+b9MWWN1mFTn
 EwmNzV1lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIlIqTAyPOW9vPOO65q+vgTm
 DcuVBE+fDOE8xVp9/fW3w5de2jOt/cDwP5HxU/uPY7IzzyX1yJ2Z2JnvlFy8urro8MuAKyvmtj4 sZgUA
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912090051.4014114-18-ardb@google.com>
Subject: [PATCH v2 01/15] x86/efi: Drop EFI stub .bss from .data section
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

Now that the EFI stub always zero inits its BSS section upon entry,
there is no longer a need to place the BSS symbols carried by the stub
into the .data section.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/vmlinux.lds.S | 1 -
 drivers/firmware/efi/libstub/Makefile  | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index b22f34b8684a..4ff6ab1b67d9 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -47,7 +47,6 @@ SECTIONS
 		_data = . ;
 		*(.data)
 		*(.data.*)
-		*(.bss.efistub)
 		_edata = . ;
 	}
 	. = ALIGN(L1_CACHE_BYTES);
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index a1157c2a7170..ef4c12f0877b 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -108,13 +108,6 @@ lib-y				:= $(patsubst %.o,%.stub.o,$(lib-y))
 # https://bugs.llvm.org/show_bug.cgi?id=46480
 STUBCOPY_FLAGS-y		+= --remove-section=.note.gnu.property
 
-#
-# For x86, bootloaders like systemd-boot or grub-efi do not zero-initialize the
-# .bss section, so the .bss section of the EFI stub needs to be included in the
-# .data section of the compressed kernel to ensure initialization. Rename the
-# .bss section here so it's easy to pick out in the linker script.
-#
-STUBCOPY_FLAGS-$(CONFIG_X86)	+= --rename-section .bss=.bss.efistub,load,alloc
 STUBCOPY_RELOC-$(CONFIG_X86_32)	:= R_386_32
 STUBCOPY_RELOC-$(CONFIG_X86_64)	:= R_X86_64_64
 
-- 
2.42.0.283.g2d96d420d3-goog

