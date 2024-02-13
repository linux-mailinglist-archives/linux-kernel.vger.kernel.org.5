Return-Path: <linux-kernel+bounces-63528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A770E8530C4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB72F1C262B6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E4B53810;
	Tue, 13 Feb 2024 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OBtFeaYy"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D94253395
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828140; cv=none; b=Ctysf7dIAVoHcsBNaslDqlT0BImhtuLp4Wkq7adQD0Wrpr82Ts0N7H0bxGqQp4MaluLvwZxazqaSQA3HDMb6iHzqMVlFhgcc5wKIFNsJ4IvppfAqbrGnPr3/svoCs9ys6JGh/YoKjvG+a1NhvNPCEZ3I6DC3M/uYm349GW31r8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828140; c=relaxed/simple;
	bh=CEh5RLJcC6IgrEQHXZSi19euYte1lfU4DaXYg20d8/k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cx3hk2vO2qifpWbfKFsiuZwB2L8LPqCWpwWeZCCgMIOxt5I4G1w2YdFIbC8ptbcbIxQVUA4Ahhhhf7kYFFtL4a4c6PWCO4ank2GQrOjJNTS475pF/xwgzNv/JLnH/C8NgPezQyXuGEzERgKuo2rmbWdKYd0iFL6emgnxIl1dMfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OBtFeaYy; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-33ce09c0644so192889f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 04:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707828138; x=1708432938; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tmJq7yGJtig/x243U4iqbWlHcuxPy6IsUUTLst4tAO8=;
        b=OBtFeaYyc/GR1Y7iEWhFsoTNTYn1fgVS6z3vXpcwP3xc0GVxIxWjLg5dOiihfO/mrJ
         S0o0i5Q/XHlFJlILlr2PGigl6d6yDZfdZkzhvZtk+HDbwgXoRxz0XS+PdUw2AXFKIBOM
         cTsqdOHhIrJKAwotz3j8ROlR8IHiThkG9xNGJYog3pcXA6tAZc8IpSraGhmUTD/cTDjL
         l/qG83RCgB+wC7sMP1IoYQ2qNA3vAyX3IfqJ+HnCgfPwlVEHkaAEL7ICENDHtvMW1hY1
         2SExgSE9jcZYLX6iCuArzXWvLnJjgoHFP/RcQ4p+BjEnYx4RVrRcCFAvDmwLOefY6B4v
         Jrig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707828138; x=1708432938;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tmJq7yGJtig/x243U4iqbWlHcuxPy6IsUUTLst4tAO8=;
        b=gkdwZlXnMepM12T83wdGXZWS+hSoBVMZp+HjS/AMmRMUfnuU3CIx63Tw8iMHEUgBzS
         2LCxcu0Oah8ZQAz13njZj44Idbn/GS72jRwYRfWc6tyZnWYvvnfSUUK9UqdWMjpMq4nH
         vIYSZ7y3gLY4qIf9G/yHOBY9UYoIEDPvhKDyASgMcDITPVYBc+bnloRRMyZs5GlcGLTs
         Q1WOW2hQ329AW3G1EJev1AR0XbOsKeb1sZ1WtImxHkEYXLfIwYuDqSy8FJYJQ/1MKQZ6
         aXzOgj/bCrWi10QnaylUq00aB4QC3bE2oYGpUXEQ8Jb9iS/9wSVlfZdUgV5eDTwBEOma
         B2Tw==
X-Gm-Message-State: AOJu0YyF+2RvpeAJANv0TWUkyoiUpON2HocLOjx4Ke6wGNimnAReL54r
	aiICNV7KoNlayUyket9Kak1ZlmYQZcc0Bqt0ogdIjF3i68aaGQZoMAx1Mvw1Q6G4eZimpRr8Alf
	6fzrtQe78OMZldnbZ/UvH88TS5rZTK9ZrfT50CKAyB+8Qj7k6Jv2XWvwPr555a71TntbTTHKMqc
	Lq87v5qUieRf7LNlpZh9t6moDMPaFZFQ==
X-Google-Smtp-Source: AGHT+IGyQVWB+fo+LR59Bx8+rlXEeatDD6WUWmQdXk1EX1AAwc7fU6kdYHiiwnYm8ZP3Z4zYoEQQLvHS
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6000:1e0c:b0:33b:4a51:f0ed with SMTP id
 bj12-20020a0560001e0c00b0033b4a51f0edmr18827wrb.4.1707828137638; Tue, 13 Feb
 2024 04:42:17 -0800 (PST)
Date: Tue, 13 Feb 2024 13:41:51 +0100
In-Reply-To: <20240213124143.1484862-13-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213124143.1484862-13-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2179; i=ardb@kernel.org;
 h=from:subject; bh=SH5BCZpD7eT9rYWqZ8AiKPxoLpu9BlwPcI3lpvrnWyw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfV0cn/7uaRP4tGTt8a01H99Oak74PEDlrXnFvfZ+AsXH
 pF9buLQUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbycw7Df++Drjf+P264pyab
 4jnl+emnm7K3nNr8cPvT223G2e5TkmYxMhw42hws/q71rUN8xDQV3cq5AQunJUxU/O+a+Fn8zG3 +aFYA
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213124143.1484862-20-ardb+git@google.com>
Subject: [PATCH v4 07/11] efi/libstub: Add generic support for parsing mem_encrypt=
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Parse the mem_encrypt= command line parameter from the EFI stub if
CONFIG_ARCH_HAS_MEM_ENCRYPT=y, so that it can be passed to the early
boot code by the arch code in the stub.

This avoids the need for the core kernel to do any string parsing very
early in the boot.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 8 ++++++++
 drivers/firmware/efi/libstub/efistub.h         | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index bfa30625f5d0..3dc2f9aaf08d 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -24,6 +24,8 @@ static bool efi_noinitrd;
 static bool efi_nosoftreserve;
 static bool efi_disable_pci_dma = IS_ENABLED(CONFIG_EFI_DISABLE_PCI_DMA);
 
+int efi_mem_encrypt;
+
 bool __pure __efi_soft_reserve_enabled(void)
 {
 	return !efi_nosoftreserve;
@@ -75,6 +77,12 @@ efi_status_t efi_parse_options(char const *cmdline)
 			efi_noinitrd = true;
 		} else if (IS_ENABLED(CONFIG_X86_64) && !strcmp(param, "no5lvl")) {
 			efi_no5lvl = true;
+		} else if (IS_ENABLED(CONFIG_ARCH_HAS_MEM_ENCRYPT) &&
+			   !strcmp(param, "mem_encrypt") && val) {
+			if (parse_option_str(val, "on"))
+				efi_mem_encrypt = 1;
+			else if (parse_option_str(val, "off"))
+				efi_mem_encrypt = -1;
 		} else if (!strcmp(param, "efi") && val) {
 			efi_nochunk = parse_option_str(val, "nochunk");
 			efi_novamap |= parse_option_str(val, "novamap");
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 212687c30d79..a1c6ab24cd99 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -37,8 +37,8 @@ extern bool efi_no5lvl;
 extern bool efi_nochunk;
 extern bool efi_nokaslr;
 extern int efi_loglevel;
+extern int efi_mem_encrypt;
 extern bool efi_novamap;
-
 extern const efi_system_table_t *efi_system_table;
 
 typedef union efi_dxe_services_table efi_dxe_services_table_t;
-- 
2.43.0.687.g38aa6559b0-goog


