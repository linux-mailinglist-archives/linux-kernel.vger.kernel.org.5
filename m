Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6273F79CAF2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjILJCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjILJBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:01:47 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD3AE7F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:01:43 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-401d9abf21cso44366275e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694509302; x=1695114102; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I6oBjQenOtE/4uDKT9nylN/cFdaoc/Utptd3H3Y+KEA=;
        b=LuM5LjaU6eIQHDa1cz8hH91+pOQiwJcNTdXFONM91sWOZd8YDHDhO8gow6vv4e/8fY
         iVSap6//WmEXfVfwZUYppK6FJdS8f1a3vlr7uo2Os47zYwoGR2pVH3HPzUkG8yT7fLri
         pEWKA+aTJsJarAR47nR/gvkRorJ/262AyeIkXXvCszH5MG88e23yAHes0oebhN6vKoS/
         INsYdSFuoBMA3uNeaddg2G5p9iKxmW7kSqA3TL15zy1antC6j4H95r7FQSTiPmVXvrHv
         UNqiQl1F7VY/exFIUFYUkPfDCItjU6PZc2HIFfI0hTet3tQ4SyN1yzVJ6DshbHKU9162
         BA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694509302; x=1695114102;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I6oBjQenOtE/4uDKT9nylN/cFdaoc/Utptd3H3Y+KEA=;
        b=qubZR4X0OjbFv/Jq8SZWbK/BETpa70QrAtU2OhQ5slEPrKnFHn9ONdPaszSjbizMyQ
         iTUSxji4PYkxSVmldZkOiotiJ/AYIyXKzsgVRZ7+147KSGgMVYxQ8JFbhHNmj1HbHUol
         jUhR57xA6swPBX4L2E6jArKcykXMoQ8BnJ5v/VDwpG5rUApIR+Ygp+CllaXohF/bjDkA
         RWyjU9NAlJ8BB+2rjzRrxNAyDc9Y91y4HjKlTkrbYr6YsFHNBX2vVxPiOnhFIMoL7QK0
         svlHnkgKVPC9kvgLa6i1ihKU1j+GbN2yOofa+F8o0VOZ/wBgDxWVbyi6rSdh52KtM1Uj
         tBhg==
X-Gm-Message-State: AOJu0YxRt5rmSP0cd11FcxrEp2/UL57ASG78v5u6B8YaxrnyNztw0KiJ
        oYY+mm4WUP3fQwPovMc4TTPEOGU2
X-Google-Smtp-Source: AGHT+IG+dLTcwfi7cfkR1FI3dbH2GjxEs3TcnKT3XpAU3wp8qNxSrJTQ4+LlN7wV8wiWbizXHQnt5bcz
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6000:156b:b0:31f:a664:f871 with SMTP id
 11-20020a056000156b00b0031fa664f871mr73268wrz.9.1694509301896; Tue, 12 Sep
 2023 02:01:41 -0700 (PDT)
Date:   Tue, 12 Sep 2023 09:00:58 +0000
In-Reply-To: <20230912090051.4014114-17-ardb@google.com>
Mime-Version: 1.0
References: <20230912090051.4014114-17-ardb@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2034; i=ardb@kernel.org;
 h=from:subject; bh=XzK2EkTmirgV6LOzzdRtqGuZ3TfS3i76hj8AhmTf3qw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZVB48yb5+LpSi9Li6KfcjB/ubvumVnGBcEflzrr11cH6
 2zZbL2so5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEwkL4bhn3LIqQgWaf4nPNma
 8tdPhvHs3nD9YHxf8pT3G1u4bom/+cLwv/SrcZ1YhcSlM2FtU6RWq/SmVErxG8461jW5Nud7qDY bCwA=
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912090051.4014114-24-ardb@google.com>
Subject: [PATCH v2 07/15] x86/boot: Grab kernel_info offset from zoffset
 header directly
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

Instead of parsing zoffset.h and poking the kernel_info offset value
into the header from the build tool, just grab the value directly in the
asm file that describes this header.

This change has no impact on the resulting bzImage binary.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S      | 2 +-
 arch/x86/boot/tools/build.c | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 6059f87b159d..5575d0f06bab 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -526,7 +526,7 @@ pref_address:		.quad LOAD_PHYSICAL_ADDR	# preferred load addr
 
 init_size:		.long INIT_SIZE		# kernel initialization size
 handover_offset:	.long 0			# Filled in by build.c
-kernel_info_offset:	.long 0			# Filled in by build.c
+kernel_info_offset:	.long ZO_kernel_info
 
 # End of setup header #####################################################
 
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index efa4e9c7d713..660627ea6cbb 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -59,7 +59,6 @@ static unsigned long efi32_stub_entry;
 static unsigned long efi64_stub_entry;
 static unsigned long efi_pe_entry;
 static unsigned long efi32_pe_entry;
-static unsigned long kernel_info;
 static unsigned long startup_64;
 static unsigned long _end;
 
@@ -339,7 +338,6 @@ static void parse_zoffset(char *fname)
 		PARSE_ZOFS(p, efi64_stub_entry);
 		PARSE_ZOFS(p, efi_pe_entry);
 		PARSE_ZOFS(p, efi32_pe_entry);
-		PARSE_ZOFS(p, kernel_info);
 		PARSE_ZOFS(p, startup_64);
 		PARSE_ZOFS(p, _end);
 
@@ -422,8 +420,6 @@ int main(int argc, char ** argv)
 	update_pecoff_text(setup_sectors * 512, i + (sys_size * 16));
 
 	efi_stub_entry_update();
-	/* Update kernel_info offset. */
-	put_unaligned_le32(kernel_info, &buf[0x268]);
 
 	crc = partial_crc32(buf, i, crc);
 	if (fwrite(buf, 1, i, dest) != i)
-- 
2.42.0.283.g2d96d420d3-goog

