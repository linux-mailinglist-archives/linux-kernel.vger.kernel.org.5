Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2962479CAEC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjILJC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbjILJBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:01:37 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C3410E4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:01:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d801e758765so3723593276.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694509292; x=1695114092; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X4mVpRsNe9aWzvwEZ2aPnnughuGbOcmpaMee8nlOmnA=;
        b=ci2DmF61mRG/5CWESY30nW+a9651p6Dyf4WtPBLA4JTa/akx/cC9fslxnE8AOXW9M9
         YA/pTXxrP7ArTTqoSg/dXakaW0BBhpFZd5cyTsHcerrwcYvft5zecUTc2RHZVOM/2OWL
         u+5/kDXadBjp6Yoi6NC1sbzJCkTByNzhLja/1pZzIDQHe1eFFMwHYd01GhaAnsomR3BD
         lADZ3H5dhxm/uWmT9MYnyuBbQGgQeGpE3pUiwKyTs8V7TGKvLNu4PxFoYxza0ZLViusv
         kYpAmFmbe7+fryNnIvI0TgisNPkNKDlcjy4VCNCaB1FqQnG7tEV4e+s75APB1nbadTUK
         NvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694509292; x=1695114092;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X4mVpRsNe9aWzvwEZ2aPnnughuGbOcmpaMee8nlOmnA=;
        b=FYMiDB1rqEjT7LHo/0VZwp7NR3XXsFTB1dHu7mtHimsGCl88AqjcDHyyw9RTMU0Rfc
         9gIv0Uc9dxW6mKEGsh9rJDQKY4Sfne8U1MeObV+bUtUNioabegNNprU+qccUlMSDMj/Z
         Kzr5cSFsteNrwxWyJCkvsNnBhpxKEYEZauCMRrZSb/A5J/KAY2Rv8Fr4PwjUyDzPW5bv
         62DCK28Y0D6FRlTWnNjc5qW1bgFRTV+zF1zEl2ZCNyCiLScfruabcGMM//yj702933bY
         Psfa0z9DJONaPK+L4HO2jSOHhnTmblKd80o2EsV/O0cFcDN5NSNZcGKZwDdUAWYAUZyM
         V4XQ==
X-Gm-Message-State: AOJu0YwMSvqzTlRw9te0KYH2iRRlakXK8Y/e6poFeEGSlIuKD4sy7pFN
        FyG3W426w7fw2gl+76F7HCeqNG97
X-Google-Smtp-Source: AGHT+IGU1A2dC31+7FrMlSd9tXXvjyTt96UJFER92xlD1LA7ozB4sKFQYVzE4uZWk+CN1L5v9nsR4/kB
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1707:b0:d7b:9830:c172 with SMTP id
 by7-20020a056902170700b00d7b9830c172mr288048ybb.0.1694509292432; Tue, 12 Sep
 2023 02:01:32 -0700 (PDT)
Date:   Tue, 12 Sep 2023 09:00:54 +0000
In-Reply-To: <20230912090051.4014114-17-ardb@google.com>
Mime-Version: 1.0
References: <20230912090051.4014114-17-ardb@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1817; i=ardb@kernel.org;
 h=from:subject; bh=PiT71nrSXObiT6OYjT5b5wm9wzGup7NyFurX3NaL+Pk=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZVB4/ipm95hny5ITd8V7DThWqlqs/q+1yet7j9sF7R8q
 LviVP/pjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjARMR1Ghn873sQ1zP/Ew/rN
 RfHqTd+LIr2Py0Nz3nivywlVZa8Ksmf47+dzZpll4qofZxcdt5wm/FGyUpHteaL2mwNvcyZxvOR 8wQIA
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912090051.4014114-20-ardb@google.com>
Subject: [PATCH v2 03/15] x86/efi: Drop alignment flags from PE section headers
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

The section header flags for alignment are documented in the PE/COFF
spec as being applicable to PE object files only, not to PE executables
such as the Linux bzImage, so let's drop them from the PE header.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index b04ca8e2b213..8c8148d751c6 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -209,8 +209,7 @@ section_table:
 	.word	0				# NumberOfLineNumbers
 	.long	IMAGE_SCN_CNT_CODE		| \
 		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_EXECUTE		| \
-		IMAGE_SCN_ALIGN_16BYTES		# Characteristics
+		IMAGE_SCN_MEM_EXECUTE		# Characteristics
 
 	#
 	# The EFI application loader requires a relocation section
@@ -230,8 +229,7 @@ section_table:
 	.word	0				# NumberOfLineNumbers
 	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
 		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_DISCARDABLE	| \
-		IMAGE_SCN_ALIGN_1BYTES		# Characteristics
+		IMAGE_SCN_MEM_DISCARDABLE	# Characteristics
 
 #ifdef CONFIG_EFI_MIXED
 	#
@@ -249,8 +247,7 @@ section_table:
 	.word	0				# NumberOfLineNumbers
 	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
 		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_DISCARDABLE	| \
-		IMAGE_SCN_ALIGN_1BYTES		# Characteristics
+		IMAGE_SCN_MEM_DISCARDABLE	# Characteristics
 #endif
 
 	#
@@ -271,8 +268,7 @@ section_table:
 	.word	0				# NumberOfLineNumbers
 	.long	IMAGE_SCN_CNT_CODE		| \
 		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_EXECUTE		| \
-		IMAGE_SCN_ALIGN_16BYTES		# Characteristics
+		IMAGE_SCN_MEM_EXECUTE		# Characteristics
 
 	.set	section_count, (. - section_table) / 40
 #endif /* CONFIG_EFI_STUB */
-- 
2.42.0.283.g2d96d420d3-goog

