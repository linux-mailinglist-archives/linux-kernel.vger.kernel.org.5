Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9675578CF89
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 00:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238520AbjH2Wdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 18:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbjH2WdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 18:33:20 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F53B1B7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 15:33:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7ba833ef2aso21427276.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 15:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693348397; x=1693953197; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f3Uqaf7Xdq87QJbcbsD/JQ7WkpbbghInYeZHjvSLa7c=;
        b=ucz8Flk93EmIe6R8OtTsl/WK6Dsb4/lnIudQnzgHJ/V4ujTnihkBHCvJYy/rCSApVl
         5sG4YYTZZ2HaoxF6v61lLqR3oeqWbLpY4Pdrfm6eoUvs5aw5Y9CEjzbc9STPciXY4sa2
         G4cFVDfXDf6RF+yK/J4FvKjjtLDjntkk8bWvZxY/zppIV90RZnMJY5PI6oIDy9GeiR1K
         iPYaMcmQZFLPEBf7jCsgrCBTgJIArwMUclDs88n7JFvJ8yKWLogjaoPcUzwCbSwFZPPZ
         R4B3ZEVrgqYtzVRhCkwoZSmsz0PXGjGc5/Ft32JhnPcRkz+1jjeCinq+eAM5uOQ6Vh4r
         GBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693348397; x=1693953197;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f3Uqaf7Xdq87QJbcbsD/JQ7WkpbbghInYeZHjvSLa7c=;
        b=jA37lr2sAFeImUNlZjdmrceeJkn48ZMhFNJRQW3iw4Nk3JGp5WkPyr7BmQMqlB02Od
         lZ6elcGvmZSOp+VFGyRIteY5YMnh1l+sOhfGN4Mmbsvd0MSmjK8rrprYf0euWWtlqnOX
         ow0vzg50SyKolNBfImyd5kkytNXvPk/zaqD+sMEHMiqyzb9VYt8s1MqAvxbEFz/Wrufq
         amKrmm4102cTWcUWbZcVEL/fOTBdW1frPoBLs3VDMTQlkMWzTeWAomhbIfwlwTnsEFD5
         vzCMFiNeQYEY3zVAuJaohnQ0ihc/o2LtVwPHdzu/ZDklpRYyuTtZvV9y+bnfC/2MbBdh
         DYfA==
X-Gm-Message-State: AOJu0YyTrdBDQltRxMrZWedr+dI53NvYnNV4CybpSTuarIGAwott26hR
        VkkgJMfP+11qYwfWydRXOd8VSAc1+f3qI3tiTQ==
X-Google-Smtp-Source: AGHT+IEnfzD+T0cSW0V5H/fYq8A8EMdVkEk5E9ar2uRElbuG6NqrXLM/mxkK9EzS5UFAl3pyzFAQF002k+XpiAhb7A==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:d715:0:b0:d78:f45:d7bd with SMTP
 id o21-20020a25d715000000b00d780f45d7bdmr15471ybg.4.1693348396843; Tue, 29
 Aug 2023 15:33:16 -0700 (PDT)
Date:   Tue, 29 Aug 2023 22:33:16 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACty7mQC/x3MQQqAIBBA0avErBNKJaqrRItBpxooC6ckiO6et
 HyL/x8QikwCffFApMTCe8ioywLcgmEmxT4bdKVN1epObSzCYU4YPblV4eX5VLYzZJpJI7YWcnp Emvj+t8P4vh85eJw6ZgAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693348395; l=4211;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=I6F2fIqIlcJQToBelI//6sVIGj+Aum8oPdtHBUFjRxQ=; b=rjOSrqB2U5F2u8lAtMC2Qg2CpVmhLlXSkx6nb9JEFKFF0b45aBQrNBeJPPwIV3pzvKtRreEOw
 GG6MfzJyn/oBouokVCrykZ/PgcUOdXswkEaqTW33dlTU+ihrtbXHhDs
X-Mailer: b4 0.12.3
Message-ID: <20230829-missingvardecl-audit-v1-1-34efeb7f3539@google.com>
Subject: [PATCH] x86/audit: fix -Wmissing-variable-declarations warning for ia32_xyz_class
From:   Justin Stitt <justinstitt@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building x86 defconfig with Clang-18 I get the following warnings:
| arch/x86/ia32/audit.c:6:10: warning: no previous extern declaration for non-static variable 'ia32_dir_class' [-Wmissing-variable-declarations]
|     6 | unsigned ia32_dir_class[] = {
| arch/x86/ia32/audit.c:11:10: warning: no previous extern declaration for non-static variable 'ia32_chattr_class' [-Wmissing-variable-declarations]
|    11 | unsigned ia32_chattr_class[] = {
| arch/x86/ia32/audit.c:16:10: warning: no previous extern declaration for non-static variable 'ia32_write_class' [-Wmissing-variable-declarations]
|    16 | unsigned ia32_write_class[] = {
| arch/x86/ia32/audit.c:21:10: warning: no previous extern declaration for non-static variable 'ia32_read_class' [-Wmissing-variable-declarations]
|    21 | unsigned ia32_read_class[] = {
| arch/x86/ia32/audit.c:26:10: warning: no previous extern declaration for non-static variable 'ia32_signal_class' [-Wmissing-variable-declarations]
|    26 | unsigned ia32_signal_class[] = {

These warnings occur due to their respective extern declarations being
scoped inside of audit_classes_init as well as only being enabled with
`CONFIG_IA32_EMULATION=y`:
| static int __init audit_classes_init(void)
| {
| #ifdef CONFIG_IA32_EMULATION
| 	extern __u32 ia32_dir_class[];
| 	extern __u32 ia32_write_class[];
| 	extern __u32 ia32_read_class[];
| 	extern __u32 ia32_chattr_class[];
| 	audit_register_class(AUDIT_CLASS_WRITE_32, ia32_write_class);
| 	audit_register_class(AUDIT_CLASS_READ_32, ia32_read_class);
| 	audit_register_class(AUDIT_CLASS_DIR_WRITE_32, ia32_dir_class);
| 	audit_register_class(AUDIT_CLASS_CHATTR_32, ia32_chattr_class);
| #endif
| 	audit_register_class(AUDIT_CLASS_WRITE, write_class);
| 	audit_register_class(AUDIT_CLASS_READ, read_class);
| 	audit_register_class(AUDIT_CLASS_DIR_WRITE, dir_class);
| 	audit_register_class(AUDIT_CLASS_CHATTR, chattr_class);
| 	return 0;
| }

Lift the extern declarations to their own header and resolve scoping
issues (and thus fix the warnings).

Moreover, change __u32 to unsigned so that we match the definitions:
| unsigned ia32_dir_class[] = {
| #include <asm-generic/audit_dir_write.h>
| ~0U
| };
|
| unsigned ia32_chattr_class[] = {
| #include <asm-generic/audit_change_attr.h>
| ~0U
| };
| ...

This patch is similar to commit:
0e5e3d4461a22d73 ("x86/audit: Fix a -Wmissing-prototypes warning for ia32_classify_syscall()") [1]

Link: https://lore.kernel.org/all/20200516123816.2680-1-b.thiel@posteo.de/ [1]
Link: https://github.com/ClangBuiltLinux/linux/issues/1920
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested.
---
 arch/x86/include/asm/audit.h | 7 +++++++
 arch/x86/kernel/audit_64.c   | 5 -----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/audit.h b/arch/x86/include/asm/audit.h
index 36aec57ea7a3..fa918f01333e 100644
--- a/arch/x86/include/asm/audit.h
+++ b/arch/x86/include/asm/audit.h
@@ -4,4 +4,11 @@
 
 int ia32_classify_syscall(unsigned int syscall);
 
+extern unsigned ia32_dir_class[];
+extern unsigned ia32_write_class[];
+extern unsigned ia32_read_class[];
+extern unsigned ia32_chattr_class[];
+extern unsigned ia32_signal_class[];
+
+
 #endif /* _ASM_X86_AUDIT_H */
diff --git a/arch/x86/kernel/audit_64.c b/arch/x86/kernel/audit_64.c
index 44c3601cfdc4..190c120f4285 100644
--- a/arch/x86/kernel/audit_64.c
+++ b/arch/x86/kernel/audit_64.c
@@ -63,11 +63,6 @@ int audit_classify_syscall(int abi, unsigned syscall)
 static int __init audit_classes_init(void)
 {
 #ifdef CONFIG_IA32_EMULATION
-	extern __u32 ia32_dir_class[];
-	extern __u32 ia32_write_class[];
-	extern __u32 ia32_read_class[];
-	extern __u32 ia32_chattr_class[];
-	extern __u32 ia32_signal_class[];
 	audit_register_class(AUDIT_CLASS_WRITE_32, ia32_write_class);
 	audit_register_class(AUDIT_CLASS_READ_32, ia32_read_class);
 	audit_register_class(AUDIT_CLASS_DIR_WRITE_32, ia32_dir_class);

---
base-commit: 706a741595047797872e669b3101429ab8d378ef
change-id: 20230829-missingvardecl-audit-493e36f2aa84

Best regards,
--
Justin Stitt <justinstitt@google.com>

