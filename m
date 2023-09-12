Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4895179CAF3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbjILJCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbjILJBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:01:49 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F26E7A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:01:45 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58d9e327d3aso58771317b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694509304; x=1695114104; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lY845+S01nhx09ii/MIWXs1MbygWhHKQ2btv9eU9x9A=;
        b=c1fS59INzWg2q3QZsQPFV8Hfvnj8AxYIY2xfAmOW+vmjbyi8LYTEs4hV5MDILPzoqI
         XZX6Ky9yfH9elcr1PIeJiDV2gtYCIlB4abDPc1SrRUsWtVUJ39tJd6Qn6kIKpVWmF+fu
         m7+ZXzN6b4PtdA8UlDzryNga0VDwgvtZxPif0sm2btz+gz978J/F6dFpE1Esjr4QyeVI
         tTaUXVyptsqIoGOx1BaZZkP8UzefWSiYOkzA8OPpxM4AUh9pXDOObeeXVq4rWLWh4W9s
         6l4KZNGFzTHtJXeu/BjHgot8eNW48YjLK94LrPidUfgS6ItJEKZg28QC9K6+Q4FwiBg4
         NpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694509304; x=1695114104;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lY845+S01nhx09ii/MIWXs1MbygWhHKQ2btv9eU9x9A=;
        b=MXrgaNc2Ieq3F6nf4aghIVdt5SHiecVyscEhE+9OGIW4AWnRqn7qyNDnJSavgjsH1h
         80yrAeQRv9gteNEpEG2DnaiZF1DulzlDsJ8dF3GB8y2GgCrqt3dtpKaBoMMNFhWTFeh9
         l9oAL2xbv2YYxzg61kNdWbwogs8pfUbGjsVyLLJyEyg6yGfz5AnBvmHEqy+rUnnUXNpj
         1MSo33Ujx/moc+nwvpZo8rvkVjRguIJylI5Jk4D3zk50HM7GUOnZRd6C4koZHamgceXx
         cJ0z9tDSjhZP/ka9Pc9rioISxzWiUByXd1FziMSkLep31TFA43JcKEbTZD6rFrXF0JwQ
         Y2FA==
X-Gm-Message-State: AOJu0Yy3lAc0EhBvykQxb4fib3wmWPz4adwxX60A2Bo88t+4GJjPcrl5
        QKSGOdoB0mhUuf5cI0jJN2zy+5KJ
X-Google-Smtp-Source: AGHT+IEQP2h+jQPbijxzPKpITToU6a3zTKdU704KIxanL1a5X045x+7UKWz7mY6HIzA+z3zuq8BGg/7/
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a25:320e:0:b0:d79:3b84:9997 with SMTP id
 y14-20020a25320e000000b00d793b849997mr266670yby.7.1694509304400; Tue, 12 Sep
 2023 02:01:44 -0700 (PDT)
Date:   Tue, 12 Sep 2023 09:00:59 +0000
In-Reply-To: <20230912090051.4014114-17-ardb@google.com>
Mime-Version: 1.0
References: <20230912090051.4014114-17-ardb@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2193; i=ardb@kernel.org;
 h=from:subject; bh=ZCOIzJuca8aCKR3/do/fxqf6xpAvtzsZS44F8RCRZaw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZVB4+zjkiM79G67utrwBm3s5u2eJWKkUHEiZRJTLIv0r
 m2+Yps7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwEQmMTD80+iymtmgbON3yvW/
 Ic+ZI8azVA8fiZMQ+sNeqVZzZl+lOMM/a57yBHM/PmHzBaVXZy4vjnDee+fKpaOfl6VeOLuhO+k /EwA=
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912090051.4014114-25-ardb@google.com>
Subject: [PATCH v2 08/15] x86/boot: Drop references to startup_64
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

The x86 boot image generation tool assign a default value to startup_64
and subsequently parses the actual value from zoffset.h but it never
actually uses the value anywhere. So remove this code.

This change has no impact on the resulting bzImage binary.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/Makefile      | 2 +-
 arch/x86/boot/tools/build.c | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index f33e45ed1437..0e98bc503699 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -89,7 +89,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
 
 SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))
 
-sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|efi32_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|z_.*\)$$/\#define ZO_\2 0x\1/p'
+sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|efi32_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|z_.*\)$$/\#define ZO_\2 0x\1/p'
 
 quiet_cmd_zoffset = ZOFFSET $@
       cmd_zoffset = $(NM) $< | sed -n $(sed-zoffset) > $@
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 660627ea6cbb..14ef13fe7ab0 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -59,7 +59,6 @@ static unsigned long efi32_stub_entry;
 static unsigned long efi64_stub_entry;
 static unsigned long efi_pe_entry;
 static unsigned long efi32_pe_entry;
-static unsigned long startup_64;
 static unsigned long _end;
 
 /*----------------------------------------------------------------------*/
@@ -263,7 +262,6 @@ static void efi_stub_defaults(void)
 	efi_pe_entry = 0x10;
 #else
 	efi_pe_entry = 0x210;
-	startup_64 = 0x200;
 #endif
 }
 
@@ -338,7 +336,6 @@ static void parse_zoffset(char *fname)
 		PARSE_ZOFS(p, efi64_stub_entry);
 		PARSE_ZOFS(p, efi_pe_entry);
 		PARSE_ZOFS(p, efi32_pe_entry);
-		PARSE_ZOFS(p, startup_64);
 		PARSE_ZOFS(p, _end);
 
 		p = strchr(p, '\n');
-- 
2.42.0.283.g2d96d420d3-goog

