Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214047CB172
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbjJPRgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbjJPRgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:36:21 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9ECFA2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:36:19 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-5815818406dso2849591eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697477779; x=1698082579; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s+UQB+1TQkrpOkRFVThwqlc0oUBJvetOcp6tU9R+gzE=;
        b=jP6In57DdN+H+KW7FhAIPoJ2mEWze3pxQo6rT97yQtrzMdh9Ak4z/+nPaumTonggTA
         gu3NrGU2bDluf5iM7sfl9Nm42IEFCv+g5UHrnaRTMK3vXOAXttTe4BF4uoj4qq8AO2zy
         WCsogxLT7Xpv4lFZ9OBKEZZMap0UbwefRUjIoGT/RkHZduimPP+aB3LdG9o5ePmi9BMi
         G+ttuYBNDSmHrANk+bsxX7kQY45LQ/qsZnUDCHtbRW3P8Bpum938L+FZS+LgqXpO2g+5
         3HhdYrKZrxprU4JtOtkL9e6z/3YsBdq2/rbIPqw8Ci7uLFOp7I+gVbhCJ9pGFeQdkJ9Z
         kMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697477779; x=1698082579;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+UQB+1TQkrpOkRFVThwqlc0oUBJvetOcp6tU9R+gzE=;
        b=Hl/LOCoTWctr0DWVaT9R/GQH9xQHpxlRuC2NblNfMy7gTSxIAz2YO82Lf8Apk/6O0h
         yDJhPkhqyKC/yxbBclcmmKm8DXC8fdeha3a3AftsAw9lmsLd49e5LwprFRpMT3j7SNub
         59BLC9NQ8Vz2LpZvv63wCxlbKbXZfXxxrrb2cCxuD4XXStvl8UGkJwH9GdaD1DkGnhfN
         5NhZ1JCkC7Kc/eY4X+fQycE5dcgsYafGqP9pV9fhKfCXvyrdl3cHOikIRVIRbBSGpgqT
         BRnQctTRjqFFoTGCxZz2auMQM+H8ENsvZXRPjOLBwRuitMRK1ZfXrpmYIm1Pnqv9hp92
         5BCg==
X-Gm-Message-State: AOJu0Yz0TltGQQBlDXAUSSqJseGDa1S+Fkj0M0rw7phj2VfoaZaJBKnz
        EKxXDBQ/3+BqyF8mDmg/HfhwTaXCsPomLx9dq2IEwg==
X-Google-Smtp-Source: AGHT+IFHAB7cxzw0fcHb+ztvf9iVS3XeBivIGBaR4VYJX4/8HGYTW5h45Q9xt8gzKfUAA9A2mguwpA==
X-Received: by 2002:a05:6870:10cf:b0:1e9:b496:ce2d with SMTP id 15-20020a05687010cf00b001e9b496ce2dmr15021007oar.12.1697477778745;
        Mon, 16 Oct 2023 10:36:18 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id lv15-20020a056871318f00b001e0fd4c9b9asm2092936oac.6.2023.10.16.10.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 10:36:18 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Mon, 16 Oct 2023 10:36:09 -0700
Subject: [PATCH v3 1/2] riscv: Add remaining module relocations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231016-module_relocations-v3-1-a667fd6071e9@rivosinc.com>
References: <20231016-module_relocations-v3-0-a667fd6071e9@rivosinc.com>
In-Reply-To: <20231016-module_relocations-v3-0-a667fd6071e9@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add all final module relocations and add error logs explaining the ones
that are not supported.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/uapi/asm/elf.h |   6 +-
 arch/riscv/kernel/module.c        | 207 +++++++++++++++++++++++++++++++++-----
 2 files changed, 187 insertions(+), 26 deletions(-)

diff --git a/arch/riscv/include/uapi/asm/elf.h b/arch/riscv/include/uapi/asm/elf.h
index d696d6610231..a9307a1c9ceb 100644
--- a/arch/riscv/include/uapi/asm/elf.h
+++ b/arch/riscv/include/uapi/asm/elf.h
@@ -49,6 +49,7 @@ typedef union __riscv_fp_state elf_fpregset_t;
 #define R_RISCV_TLS_DTPREL64	9
 #define R_RISCV_TLS_TPREL32	10
 #define R_RISCV_TLS_TPREL64	11
+#define R_RISCV_IRELATIVE	58
 
 /* Relocation types not used by the dynamic linker */
 #define R_RISCV_BRANCH		16
@@ -81,7 +82,7 @@ typedef union __riscv_fp_state elf_fpregset_t;
 #define R_RISCV_ALIGN		43
 #define R_RISCV_RVC_BRANCH	44
 #define R_RISCV_RVC_JUMP	45
-#define R_RISCV_LUI		46
+#define R_RISCV_RVC_LUI		46
 #define R_RISCV_GPREL_I		47
 #define R_RISCV_GPREL_S		48
 #define R_RISCV_TPREL_I		49
@@ -93,6 +94,9 @@ typedef union __riscv_fp_state elf_fpregset_t;
 #define R_RISCV_SET16		55
 #define R_RISCV_SET32		56
 #define R_RISCV_32_PCREL	57
+#define R_RISCV_PLT32		59
+#define R_RISCV_SET_ULEB128	60
+#define R_RISCV_SUB_ULEB128	61
 
 
 #endif /* _UAPI_ASM_RISCV_ELF_H */
diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 7c651d55fcbd..73f47de538d2 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -7,6 +7,7 @@
 #include <linux/elf.h>
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/kernel.h>
 #include <linux/moduleloader.h>
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
@@ -268,6 +269,12 @@ static int apply_r_riscv_align_rela(struct module *me, u32 *location,
 	return -EINVAL;
 }
 
+static int apply_r_riscv_add8_rela(struct module *me, u32 *location, Elf_Addr v)
+{
+	*(u8 *)location += (u8)v;
+	return 0;
+}
+
 static int apply_r_riscv_add16_rela(struct module *me, u32 *location,
 				    Elf_Addr v)
 {
@@ -289,6 +296,12 @@ static int apply_r_riscv_add64_rela(struct module *me, u32 *location,
 	return 0;
 }
 
+static int apply_r_riscv_sub8_rela(struct module *me, u32 *location, Elf_Addr v)
+{
+	*(u8 *)location -= (u8)v;
+	return 0;
+}
+
 static int apply_r_riscv_sub16_rela(struct module *me, u32 *location,
 				    Elf_Addr v)
 {
@@ -310,31 +323,149 @@ static int apply_r_riscv_sub64_rela(struct module *me, u32 *location,
 	return 0;
 }
 
-static int (*reloc_handlers_rela[]) (struct module *me, u32 *location,
-				Elf_Addr v) = {
-	[R_RISCV_32]			= apply_r_riscv_32_rela,
-	[R_RISCV_64]			= apply_r_riscv_64_rela,
-	[R_RISCV_BRANCH]		= apply_r_riscv_branch_rela,
-	[R_RISCV_JAL]			= apply_r_riscv_jal_rela,
-	[R_RISCV_RVC_BRANCH]		= apply_r_riscv_rvc_branch_rela,
-	[R_RISCV_RVC_JUMP]		= apply_r_riscv_rvc_jump_rela,
-	[R_RISCV_PCREL_HI20]		= apply_r_riscv_pcrel_hi20_rela,
-	[R_RISCV_PCREL_LO12_I]		= apply_r_riscv_pcrel_lo12_i_rela,
-	[R_RISCV_PCREL_LO12_S]		= apply_r_riscv_pcrel_lo12_s_rela,
-	[R_RISCV_HI20]			= apply_r_riscv_hi20_rela,
-	[R_RISCV_LO12_I]		= apply_r_riscv_lo12_i_rela,
-	[R_RISCV_LO12_S]		= apply_r_riscv_lo12_s_rela,
-	[R_RISCV_GOT_HI20]		= apply_r_riscv_got_hi20_rela,
-	[R_RISCV_CALL_PLT]		= apply_r_riscv_call_plt_rela,
-	[R_RISCV_CALL]			= apply_r_riscv_call_rela,
-	[R_RISCV_RELAX]			= apply_r_riscv_relax_rela,
-	[R_RISCV_ALIGN]			= apply_r_riscv_align_rela,
-	[R_RISCV_ADD16]			= apply_r_riscv_add16_rela,
-	[R_RISCV_ADD32]			= apply_r_riscv_add32_rela,
-	[R_RISCV_ADD64]			= apply_r_riscv_add64_rela,
-	[R_RISCV_SUB16]			= apply_r_riscv_sub16_rela,
-	[R_RISCV_SUB32]			= apply_r_riscv_sub32_rela,
-	[R_RISCV_SUB64]			= apply_r_riscv_sub64_rela,
+static int dynamic_linking_not_supported(struct module *me, u32 *location,
+					 Elf_Addr v)
+{
+	pr_err("%s: Dynamic linking not supported in kernel modules PC = %p\n",
+	       me->name, location);
+	return -EINVAL;
+}
+
+static int tls_not_supported(struct module *me, u32 *location, Elf_Addr v)
+{
+	pr_err("%s: Thread local storage not supported in kernel modules PC = %p\n",
+	       me->name, location);
+	return -EINVAL;
+}
+
+static int apply_r_riscv_sub6_rela(struct module *me, u32 *location, Elf_Addr v)
+{
+	*(u8 *)location -= (u8)v & 0x3F;
+	return 0;
+}
+
+static int apply_r_riscv_set6_rela(struct module *me, u32 *location, Elf_Addr v)
+{
+	*(u8 *)location = (*(u8 *)location & 0xc0) | ((u8)v & 0x3F);
+	return 0;
+}
+
+static int apply_r_riscv_set8_rela(struct module *me, u32 *location, Elf_Addr v)
+{
+	*(u8 *)location = (u8)v;
+	return 0;
+}
+
+static int apply_r_riscv_set16_rela(struct module *me, u32 *location,
+				    Elf_Addr v)
+{
+	*(u16 *)location = (u16)v;
+	return 0;
+}
+
+static int apply_r_riscv_set32_rela(struct module *me, u32 *location,
+				    Elf_Addr v)
+{
+	*(u32 *)location = (u32)v;
+	return 0;
+}
+
+static int apply_r_riscv_32_pcrel_rela(struct module *me, u32 *location,
+				       Elf_Addr v)
+{
+	*(u32 *)location = (u32)v;
+	return 0;
+}
+
+static int apply_r_riscv_plt32_rela(struct module *me, u32 *location,
+				    Elf_Addr v)
+{
+	*(u32 *)location = (u32)v;
+	return 0;
+}
+
+static int apply_r_riscv_set_uleb128(struct module *me, u32 *location, Elf_Addr v)
+{
+	/*
+	 * Relocation is only performed if R_RISCV_SET_ULEB128 is followed by
+	 * R_RISCV_SUB_ULEB128 so do computation there
+	 */
+	return 0;
+}
+
+static int apply_r_riscv_sub_uleb128(struct module *me, u32 *location, Elf_Addr v)
+{
+	if (v >= 128) {
+		pr_err("%s: uleb128 must be in [0, 127] (not %ld) at PC = %p\n",
+		       me->name, (unsigned long)v, location);
+		return -EINVAL;
+	}
+
+	*location = v;
+	return 0;
+}
+
+/*
+ * Relocations defined in the riscv-elf-psabi-doc.
+ * This handles static linking only.
+ */
+static int (*reloc_handlers_rela[])(struct module *me, u32 *location,
+				    Elf_Addr v) = {
+	[R_RISCV_32] =			apply_r_riscv_32_rela,
+	[R_RISCV_64] =			apply_r_riscv_64_rela,
+	[R_RISCV_RELATIVE] =		dynamic_linking_not_supported,
+	[R_RISCV_COPY] =		dynamic_linking_not_supported,
+	[R_RISCV_JUMP_SLOT] =		dynamic_linking_not_supported,
+	[R_RISCV_TLS_DTPMOD32] =	dynamic_linking_not_supported,
+	[R_RISCV_TLS_DTPMOD64] =	dynamic_linking_not_supported,
+	[R_RISCV_TLS_DTPREL32] =	dynamic_linking_not_supported,
+	[R_RISCV_TLS_DTPREL64] =	dynamic_linking_not_supported,
+	[R_RISCV_TLS_TPREL32] =		dynamic_linking_not_supported,
+	[R_RISCV_TLS_TPREL64] =		dynamic_linking_not_supported,
+	/* 12-15 undefined */
+	[R_RISCV_BRANCH] =		apply_r_riscv_branch_rela,
+	[R_RISCV_JAL] =			apply_r_riscv_jal_rela,
+	[R_RISCV_CALL] =		apply_r_riscv_call_rela,
+	[R_RISCV_CALL_PLT] =		apply_r_riscv_call_plt_rela,
+	[R_RISCV_GOT_HI20] =		apply_r_riscv_got_hi20_rela,
+	[R_RISCV_TLS_GOT_HI20] =	tls_not_supported,
+	[R_RISCV_TLS_GD_HI20] =		tls_not_supported,
+	[R_RISCV_PCREL_HI20] =		apply_r_riscv_pcrel_hi20_rela,
+	[R_RISCV_PCREL_LO12_I] =	apply_r_riscv_pcrel_lo12_i_rela,
+	[R_RISCV_PCREL_LO12_S] =	apply_r_riscv_pcrel_lo12_s_rela,
+	[R_RISCV_HI20] =		apply_r_riscv_hi20_rela,
+	[R_RISCV_LO12_I] =		apply_r_riscv_lo12_i_rela,
+	[R_RISCV_LO12_S] =		apply_r_riscv_lo12_s_rela,
+	[R_RISCV_TPREL_HI20] =		tls_not_supported,
+	[R_RISCV_TPREL_LO12_I] =	tls_not_supported,
+	[R_RISCV_TPREL_LO12_S] =	tls_not_supported,
+	[R_RISCV_TPREL_ADD] =		tls_not_supported,
+	[R_RISCV_ADD8] =		apply_r_riscv_add8_rela,
+	[R_RISCV_ADD16] =		apply_r_riscv_add16_rela,
+	[R_RISCV_ADD32] =		apply_r_riscv_add32_rela,
+	[R_RISCV_ADD64] =		apply_r_riscv_add64_rela,
+	[R_RISCV_SUB8] =		apply_r_riscv_sub8_rela,
+	[R_RISCV_SUB16] =		apply_r_riscv_sub16_rela,
+	[R_RISCV_SUB32] =		apply_r_riscv_sub32_rela,
+	[R_RISCV_SUB64] =		apply_r_riscv_sub64_rela,
+	/* 41-42 reserved for future standard use */
+	[R_RISCV_ALIGN] =		apply_r_riscv_align_rela,
+	[R_RISCV_RVC_BRANCH] =		apply_r_riscv_rvc_branch_rela,
+	[R_RISCV_RVC_JUMP] =		apply_r_riscv_rvc_jump_rela,
+	/* 46-50 reserved for future standard use */
+	[R_RISCV_RELAX] =		apply_r_riscv_relax_rela,
+	[R_RISCV_SUB6] =		apply_r_riscv_sub6_rela,
+	[R_RISCV_SET6] =		apply_r_riscv_set6_rela,
+	[R_RISCV_SET8] =		apply_r_riscv_set8_rela,
+	[R_RISCV_SET16] =		apply_r_riscv_set16_rela,
+	[R_RISCV_SET32] =		apply_r_riscv_set32_rela,
+	[R_RISCV_32_PCREL] =		apply_r_riscv_32_pcrel_rela,
+	[R_RISCV_IRELATIVE] =		dynamic_linking_not_supported,
+	[R_RISCV_PLT32] =		apply_r_riscv_plt32_rela,
+	[R_RISCV_SET_ULEB128] =		apply_r_riscv_set_uleb128,
+	[R_RISCV_SUB_ULEB128] =		apply_r_riscv_sub_uleb128,
+	/* 62-191 reserved for future standard use */
+	/* 192-255 nonstandard ABI extensions  */
 };
 
 int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
@@ -348,6 +479,10 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 	unsigned int i, type;
 	Elf_Addr v;
 	int res;
+	bool uleb128_set_exists = false;
+	u32 *uleb128_set_loc;
+	unsigned long uleb128_set_sym_val;
+
 
 	pr_debug("Applying relocate section %u to %u\n", relsec,
 	       sechdrs[relsec].sh_info);
@@ -425,6 +560,28 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 				  me->name);
 				return -EINVAL;
 			}
+		} else if (type == R_RISCV_SET_ULEB128) {
+			if (uleb128_set_exists) {
+				pr_err("%s: riscv psABI requires the next ULEB128 relocation to come after a R_RISCV_SET_ULEB128 is an R_RISCV_SUB_ULEB128, not another R_RISCV_SET_ULEB128.\n",
+				       me->name);
+				return -EINVAL;
+			}
+			uleb128_set_exists = true;
+			uleb128_set_loc = location;
+			uleb128_set_sym_val =
+				((Elf_Sym *)sechdrs[symindex].sh_addr +
+					ELF_RISCV_R_SYM(rel[i].r_info))
+					->st_value +
+				rel[i].r_addend;
+		} else if (type == R_RISCV_SUB_ULEB128) {
+			if (uleb128_set_exists && uleb128_set_loc == location) {
+				/* Calculate set and subtraction */
+				v = uleb128_set_sym_val - v;
+			} else {
+				pr_err("%s: R_RISCV_SUB_ULEB128 must always be paired with the first R_RISCV_SET_ULEB128 that comes before it. PC = %p\n",
+				       me->name, location);
+				return -EINVAL;
+			}
 		}
 
 		res = handler(me, location, v);

-- 
2.42.0

