Return-Path: <linux-kernel+bounces-157260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A855B8B0F29
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35DA81F225CE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E7916D32A;
	Wed, 24 Apr 2024 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KPm9t+k5"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B2416D32E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974033; cv=none; b=LZsAlNzmPIfe3EqFVyZbx0+mJLhQ7yUkJYLVBpVww60eySfmNXJNcKvWs8bhGMm2/31h+WgOR6FRq00kyCTYsw689YO7s2daiqJOvhNSnGVWtRz2rlDzOB5o8O35GshlWVEhlcWbmkpMjkNAqPNWl/xZXRqrlS2qWGz2ul7XElI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974033; c=relaxed/simple;
	bh=qbVPadcUMUngKSnbMdR5u0aZQpbUxvucEmX1GSbh/rc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U5wDWWgYGy2Wrb+UkAmrXHByKd+KTYoRSgCjeFUFvcQssiCy9kQG0pJqt5ztfle0hIV2zbGA1hVlLSgHDsE2I5sOxJtDClMyV/MkFGhUjgZDSjC0A+MVBF7/rd1xPpI7HKC/MTlcvY9Ovah28B9ClKbZsahkk1oJppv78aUeDmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KPm9t+k5; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-41a074e2d69so16376985e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713974029; x=1714578829; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qa45zJF/AbMRvdTbOV/4UEGhBCAI225hQ2s7T3i+Ooo=;
        b=KPm9t+k5ky0MUnI6eZ2R/qhEISR3QhTGES+0JsafFUYgj9nz/GvbbJk4o0SYbBzHbE
         doyPF0OUp3R60/bc5H7CYi9EfZtQLzPOrT9sBiZzVwoD7qbQPG99FZCUuYg51jFJdIPh
         Yk49kINuvhDmTJ1Nyo0PJYwvgfU3RfT/C8WjfWPAKFGEGpMoxvaN/AkBqHpvTZ+H0Gn/
         5MejDYlVtlex2B/tPb5roo9qidr6BIw2cwv/nyoXd0nN+oTq4TdgwgmHvnV10B/ngQQM
         f6jY52ZF9bk2R58bh06al+NsLPuz2DH7layAa+YlR/aNPnWDsGHudeadllGWK3Cy95Cs
         DOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713974029; x=1714578829;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qa45zJF/AbMRvdTbOV/4UEGhBCAI225hQ2s7T3i+Ooo=;
        b=cpZPlDGXmkfQHJBmmHkJCPW1+n4f4R3EHJ4L/2Bo4ew7vePYRjt7pP+w7PHaumqoGw
         01I6TZuPEeky+aolr3ia1QpPYvj3G0uCOt2a96VvU7CPC9yk6GGYbvZUJzYV+0uWyV27
         vAbQyp6kC4/PROzphn2fW9eqlnSs/l8GL5jQz6bnB9H2FUAvL7Qs5wMbmHVh12hiUreg
         dhp2TIVek2CTNOBy7h1Fx1gAXcJ+HJMIuJmtlhPEVNfx1vOfYdgNpQWqfk8iWWv97pwF
         SqaAN2tRbb5+Mg/IedYeg/smLqatgwHtWUq6h6tq3Cw7F17rCOK7tqxMAdxWIn/RlfJy
         dH5A==
X-Gm-Message-State: AOJu0YzVFWtlHnn49P1S8gf/i+XBrzbKrOArAD+65QUydIMogkbDN4xn
	U6/v8vuOu5x5/QdjY1+EcdDtRx/qqdissBl+3vVlnleZDKOdpTylTch1Ze+GYYGU2QpMjjfn0eo
	2a5uzgB0Nf9GEbd/Y1iZUutT4Plb7UeYHJUNkAcCs7ghaDHZRUpfk1dOTUcIMMI2X7NkMKZ19CD
	8sWjLHWu2MSf3a7UfHx4WSJy0n5bURqg==
X-Google-Smtp-Source: AGHT+IGPDbNhL5NFJULZL4U66kpbV99fqZ3v34KTMJNmsTCednnzv3CzTgv4ww9xbt+KXw0b9m9aqo3Y
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:adf:dd8a:0:b0:33e:75e5:693b with SMTP id
 x10-20020adfdd8a000000b0033e75e5693bmr8108wrl.9.1713974029215; Wed, 24 Apr
 2024 08:53:49 -0700 (PDT)
Date: Wed, 24 Apr 2024 17:53:17 +0200
In-Reply-To: <20240424155309.1719454-11-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240424155309.1719454-11-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=6976; i=ardb@kernel.org;
 h=from:subject; bh=Xy7s/2+HI2gRh+BhIpznzNQEEi4VjcSVENS8njd99EU=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1T663HrbUJ9971T9u6b+OFpYuP+EVa5DmaaBhkcJe79
 Xo2LtnSUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbiUsTIMH3l6Wvn90mZr1gt
 Lrvn5uqsM8sYLnx/WcRY5FS5neMlVwEjwyzJDIYTC4Ks2+67zf1ooX/kIN8M3/IQtym8aoUxxm+ 8mQA=
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240424155309.1719454-18-ardb+git@google.com>
Subject: [RFC PATCH 7/9] x86/purgatory: Use fully linked PIE ELF executable
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Now that the generic support is in place, switch to a fully linked PIE
ELF executable for the purgatory, so that it can be loaded as a single,
fully relocated image. This allows a lot of ugly post-processing logic
to simply be dropped.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/kexec.h       |   7 --
 arch/x86/kernel/machine_kexec_64.c | 127 --------------------
 arch/x86/purgatory/Makefile        |  14 +--
 3 files changed, 5 insertions(+), 143 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index ee7b32565e5f..c7cacc2e9dfb 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -191,13 +191,6 @@ void arch_kexec_unprotect_crashkres(void);
 #define arch_kexec_unprotect_crashkres arch_kexec_unprotect_crashkres
 
 #ifdef CONFIG_KEXEC_FILE
-struct purgatory_info;
-int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
-				     Elf_Shdr *section,
-				     const Elf_Shdr *relsec,
-				     const Elf_Shdr *symtab);
-#define arch_kexec_apply_relocations_add arch_kexec_apply_relocations_add
-
 int arch_kimage_file_post_load_cleanup(struct kimage *image);
 #define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
 #endif
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index bc0a5348b4a6..ded924423e50 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -371,133 +371,6 @@ void machine_kexec(struct kimage *image)
 /* arch-dependent functionality related to kexec file-based syscall */
 
 #ifdef CONFIG_KEXEC_FILE
-/*
- * Apply purgatory relocations.
- *
- * @pi:		Purgatory to be relocated.
- * @section:	Section relocations applying to.
- * @relsec:	Section containing RELAs.
- * @symtabsec:	Corresponding symtab.
- *
- * TODO: Some of the code belongs to generic code. Move that in kexec.c.
- */
-int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
-				     Elf_Shdr *section, const Elf_Shdr *relsec,
-				     const Elf_Shdr *symtabsec)
-{
-	unsigned int i;
-	Elf64_Rela *rel;
-	Elf64_Sym *sym;
-	void *location;
-	unsigned long address, sec_base, value;
-	const char *strtab, *name, *shstrtab;
-	const Elf_Shdr *sechdrs;
-
-	/* String & section header string table */
-	sechdrs = (void *)pi->ehdr + pi->ehdr->e_shoff;
-	strtab = (char *)pi->ehdr + sechdrs[symtabsec->sh_link].sh_offset;
-	shstrtab = (char *)pi->ehdr + sechdrs[pi->ehdr->e_shstrndx].sh_offset;
-
-	rel = (void *)pi->ehdr + relsec->sh_offset;
-
-	pr_debug("Applying relocate section %s to %u\n",
-		 shstrtab + relsec->sh_name, relsec->sh_info);
-
-	for (i = 0; i < relsec->sh_size / sizeof(*rel); i++) {
-
-		/*
-		 * rel[i].r_offset contains byte offset from beginning
-		 * of section to the storage unit affected.
-		 *
-		 * This is location to update. This is temporary buffer
-		 * where section is currently loaded. This will finally be
-		 * loaded to a different address later, pointed to by
-		 * ->sh_addr. kexec takes care of moving it
-		 *  (kexec_load_segment()).
-		 */
-		location = pi->purgatory_buf;
-		location += section->sh_offset;
-		location += rel[i].r_offset;
-
-		/* Final address of the location */
-		address = section->sh_addr + rel[i].r_offset;
-
-		/*
-		 * rel[i].r_info contains information about symbol table index
-		 * w.r.t which relocation must be made and type of relocation
-		 * to apply. ELF64_R_SYM() and ELF64_R_TYPE() macros get
-		 * these respectively.
-		 */
-		sym = (void *)pi->ehdr + symtabsec->sh_offset;
-		sym += ELF64_R_SYM(rel[i].r_info);
-
-		if (sym->st_name)
-			name = strtab + sym->st_name;
-		else
-			name = shstrtab + sechdrs[sym->st_shndx].sh_name;
-
-		pr_debug("Symbol: %s info: %02x shndx: %02x value=%llx size: %llx\n",
-			 name, sym->st_info, sym->st_shndx, sym->st_value,
-			 sym->st_size);
-
-		if (sym->st_shndx == SHN_UNDEF) {
-			pr_err("Undefined symbol: %s\n", name);
-			return -ENOEXEC;
-		}
-
-		if (sym->st_shndx == SHN_COMMON) {
-			pr_err("symbol '%s' in common section\n", name);
-			return -ENOEXEC;
-		}
-
-		if (sym->st_shndx == SHN_ABS)
-			sec_base = 0;
-		else if (sym->st_shndx >= pi->ehdr->e_shnum) {
-			pr_err("Invalid section %d for symbol %s\n",
-			       sym->st_shndx, name);
-			return -ENOEXEC;
-		} else
-			sec_base = pi->sechdrs[sym->st_shndx].sh_addr;
-
-		value = sym->st_value;
-		value += sec_base;
-		value += rel[i].r_addend;
-
-		switch (ELF64_R_TYPE(rel[i].r_info)) {
-		case R_X86_64_NONE:
-			break;
-		case R_X86_64_64:
-			*(u64 *)location = value;
-			break;
-		case R_X86_64_32:
-			*(u32 *)location = value;
-			if (value != *(u32 *)location)
-				goto overflow;
-			break;
-		case R_X86_64_32S:
-			*(s32 *)location = value;
-			if ((s64)value != *(s32 *)location)
-				goto overflow;
-			break;
-		case R_X86_64_PC32:
-		case R_X86_64_PLT32:
-			value -= (u64)address;
-			*(u32 *)location = value;
-			break;
-		default:
-			pr_err("Unknown rela relocation: %llu\n",
-			       ELF64_R_TYPE(rel[i].r_info));
-			return -ENOEXEC;
-		}
-	}
-	return 0;
-
-overflow:
-	pr_err("Overflow in relocation type %d value 0x%lx\n",
-	       (int)ELF64_R_TYPE(rel[i].r_info), value);
-	return -ENOEXEC;
-}
-
 int arch_kimage_file_post_load_cleanup(struct kimage *image)
 {
 	vfree(image->elf_headers);
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 2df4a4b70ff5..acc09799af2a 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -26,12 +26,11 @@ KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS))
 # Drop the function entry padding, which is not needed here
 KBUILD_CFLAGS := $(filter-out $(PADDING_CFLAGS),$(KBUILD_CFLAGS))
 
-# When linking purgatory.ro with -r unresolved symbols are not checked,
-# also link a purgatory.chk binary without -r to check for unresolved symbols.
 PURGATORY_LDFLAGS := -e purgatory_start -z nodefaultlib
-LDFLAGS_purgatory.ro := -r $(PURGATORY_LDFLAGS)
-LDFLAGS_purgatory.chk := $(PURGATORY_LDFLAGS)
-targets += purgatory.ro purgatory.chk
+PURGATORY_LDFLAGS += -T $(srctree)/include/asm-generic/purgatory.lds -pie
+PURGATORY_LDFLAGS += --orphan-handling=$(CONFIG_LD_ORPHAN_WARN_LEVEL)
+LDFLAGS_purgatory.ro := $(PURGATORY_LDFLAGS)
+targets += purgatory.ro
 
 # Sanitizer, etc. runtimes are unavailable and cannot be linked here.
 GCOV_PROFILE	:= n
@@ -87,9 +86,6 @@ asflags-remove-y		+= $(foreach x, -g -gdwarf-4 -gdwarf-5, $(x) -Wa,$(x))
 $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
 		$(call if_changed,ld)
 
-$(obj)/purgatory.chk: $(obj)/purgatory.ro FORCE
-		$(call if_changed,ld)
-
-$(obj)/kexec-purgatory.o: $(obj)/purgatory.ro $(obj)/purgatory.chk
+$(obj)/kexec-purgatory.o: $(obj)/purgatory.ro
 
 obj-y += kexec-purgatory.o
-- 
2.44.0.769.g3c40516874-goog


