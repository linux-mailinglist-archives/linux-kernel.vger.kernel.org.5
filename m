Return-Path: <linux-kernel+bounces-157262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0A08B0F2C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB101F21B82
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E25161913;
	Wed, 24 Apr 2024 15:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w7+erSLg"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206AC16D4D5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974036; cv=none; b=UGjnvDaI94EF/1gLF3XbKIK10TGYhsCDKZcflONGhSLz9E48+Sl8ycveFwa6lDN3KuoIhAtNIZ6RhkXFOFlxZeSU9SPo0KhDYSZnMdjGtf9x2r9l7ypLmZU6jLb4WIivtCAOowvtQHHW7ZQs+Of2lOM4aySYljQwgwekRnxJ3GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974036; c=relaxed/simple;
	bh=E7w2+sQV7AyKgxRHGNpgYBKYXPsPeIQ50+znt3iuNFU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pZNfJ/lJjPRrBYrywF3z51jSVNEkEOzFVoOnMQ1gCb6lDR7kdlOAxeZ1PLdd0rCmK0H1fAGIohKTER8hEayAZsdztpYVHNvRkTQYOQK1E7mtAyoctp5+77eHT/Hpq8A31Uf9aRO+jv18JIfyldL4iuOdSfBRB2uWxsO0tKBKats=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w7+erSLg; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-349fbb7ab16so4788778f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713974033; x=1714578833; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vx6XnSqF1Kz2IsX9yxzKAYxIyEUUs8kiNXLrQoQM9lM=;
        b=w7+erSLgBXKGs8nPCP8NbszmweW/pvuHyKDITZbw4Opzh2TAVQgpJ+YvkQMlWhroye
         I7HJUwKqXWP3bIqLvW5mSYhPZOW32s0fVNI/YRfQ/MaRLuELjCDoEqVJVu78kvFcK9kQ
         FmwFQP18i/8g693tfxtQ9llLJATTVic/qGZa7JLiRH+mhT9hKn3mJw/qzpSQH09IvlIX
         98sXfYba1/IFSoJUk3Fwp7H+i3BcYMYK5rT5gzkJGaO+75/ECoMkRG3PxXW5sEVl7YHx
         vOJdEnaUZGH2/lIFW5LIJFeMNTwq9kkFzEM4shHr4QFHqnhrrKU5LPraqwA8JGZYZVVL
         DT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713974033; x=1714578833;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vx6XnSqF1Kz2IsX9yxzKAYxIyEUUs8kiNXLrQoQM9lM=;
        b=LKNZFcbeo83x0UH54IyBaffSarxF+WkaU3eaDoiAPLu2Cb6wGC28og1Yz6L7nQwiSe
         D2roJrLT6k1MpDeHzBQAj/kOIe+/OFwG+GtbaiyIFKfYDs3bdhMdgYRfeo4mPD2X+K/J
         Gs6d9F30OWVDMKegpiR28n/353VyXKBPYMg8xnJVZyUpQYNaMEVsfJ2vPsjEoshnOD8Z
         4TuGW9loi4WnugDZkxR+xRsojbyCjN6VdZwWsMuQNCxU3CRjedXwCyoIpdwu3p8Q8n6R
         3hegmSGgAOCMQNIUgGMVd4qiI9Gdw2MVRX5nhU3lyL2Hlm9HMyuLRSLZ31+vvQebIDFr
         xicg==
X-Gm-Message-State: AOJu0YxotXnzAaEIogW8ix3YConQ5UTqd91xpFfhz5t7wCMW0dYkov0u
	A5kObpoH+qlnp/eaQw7B5UXohw3uPWtiq/A3E3M/vlsjzcqnuf8gyy4v/hzQ1ZsvboUHf3nXjXl
	NE+6pzPQkZmcsavFHMLRQmCnnHVJ82Eb09XaEPFMs0DCDuCi/btEk1gA6dEvTa7Gpe5cawxbRT7
	stq5eEkp4NwQ3j1enNDct2NIvmFECiwg==
X-Google-Smtp-Source: AGHT+IEAw+x687kZdSsqQxNNZ4oSNk26SZm4X/GaIroPEpe6v9Zhf+oDF0wkctwNqpKcENKbKDTRHVrO
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a5d:44c8:0:b0:346:aee6:d2a6 with SMTP id
 z8-20020a5d44c8000000b00346aee6d2a6mr9419wrr.12.1713974033489; Wed, 24 Apr
 2024 08:53:53 -0700 (PDT)
Date: Wed, 24 Apr 2024 17:53:19 +0200
In-Reply-To: <20240424155309.1719454-11-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240424155309.1719454-11-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=9229; i=ardb@kernel.org;
 h=from:subject; bh=wGoJfBQak6AeMag7lP1HCofCwaJfihP0rQ/I/VLLrnA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1T6/3kbMFIkdytJRcLLnhwKgmJRLhvjv6xOEXKvPFu7
 m5H1p8dpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCL9qQz/fdY6Xk4zZ8s+E5Gv
 uZIpRtH/uO/cxuP8y56UiHZFhsw7xchwSnCKeMZt8XMRBhKenxY+nleZP6Vl31HVuZF/Tky6v9m HGQA=
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240424155309.1719454-20-ardb+git@google.com>
Subject: [RFC PATCH 9/9] kexec: Drop support for partially linked purgatory executables
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Remove the handling of purgatories that are allocated, loaded and
relocated as individual ELF sections, which requires a lot of
post-processing on the part of the kexec loader. This has been
superseded by the use of fully linked PIE executables, which do not
require such post-processing.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 kernel/kexec_file.c | 271 +-------------------
 1 file changed, 14 insertions(+), 257 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 6379f8dfc29f..782a1247558c 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -808,228 +808,31 @@ static int kexec_calculate_store_digests(struct kimage *image)
 
 #ifdef CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY
 /*
- * kexec_purgatory_setup_kbuf - prepare buffer to load purgatory.
- * @pi:		Purgatory to be loaded.
- * @kbuf:	Buffer to setup.
- *
- * Allocates the memory needed for the buffer. Caller is responsible to free
- * the memory after use.
- *
- * Return: 0 on success, negative errno on error.
- */
-static int kexec_purgatory_setup_kbuf(struct purgatory_info *pi,
-				      struct kexec_buf *kbuf)
-{
-	const Elf_Shdr *sechdrs;
-	unsigned long bss_align;
-	unsigned long bss_sz;
-	unsigned long align;
-	int i, ret;
-
-	sechdrs = (void *)pi->ehdr + pi->ehdr->e_shoff;
-	kbuf->buf_align = bss_align = 1;
-	kbuf->bufsz = bss_sz = 0;
-
-	for (i = 0; i < pi->ehdr->e_shnum; i++) {
-		if (!(sechdrs[i].sh_flags & SHF_ALLOC))
-			continue;
-
-		align = sechdrs[i].sh_addralign;
-		if (sechdrs[i].sh_type != SHT_NOBITS) {
-			if (kbuf->buf_align < align)
-				kbuf->buf_align = align;
-			kbuf->bufsz = ALIGN(kbuf->bufsz, align);
-			kbuf->bufsz += sechdrs[i].sh_size;
-		} else {
-			if (bss_align < align)
-				bss_align = align;
-			bss_sz = ALIGN(bss_sz, align);
-			bss_sz += sechdrs[i].sh_size;
-		}
-	}
-	kbuf->bufsz = ALIGN(kbuf->bufsz, bss_align);
-	kbuf->memsz = kbuf->bufsz + bss_sz;
-	if (kbuf->buf_align < bss_align)
-		kbuf->buf_align = bss_align;
-
-	kbuf->buffer = vzalloc(kbuf->bufsz);
-	if (!kbuf->buffer)
-		return -ENOMEM;
-	pi->purgatory_buf = kbuf->buffer;
-
-	ret = kexec_add_buffer(kbuf);
-	if (ret)
-		goto out;
-
-	return 0;
-out:
-	vfree(pi->purgatory_buf);
-	pi->purgatory_buf = NULL;
-	return ret;
-}
-
-/*
- * kexec_purgatory_setup_sechdrs - prepares the pi->sechdrs buffer.
- * @pi:		Purgatory to be loaded.
- * @kbuf:	Buffer prepared to store purgatory.
- *
- * Allocates the memory needed for the buffer. Caller is responsible to free
- * the memory after use.
- *
- * Return: 0 on success, negative errno on error.
- */
-static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
-					 struct kexec_buf *kbuf)
-{
-	unsigned long bss_addr;
-	unsigned long offset;
-	size_t sechdrs_size;
-	Elf_Shdr *sechdrs;
-	int i;
-
-	/*
-	 * The section headers in kexec_purgatory are read-only. In order to
-	 * have them modifiable make a temporary copy.
-	 */
-	sechdrs_size = array_size(sizeof(Elf_Shdr), pi->ehdr->e_shnum);
-	sechdrs = vzalloc(sechdrs_size);
-	if (!sechdrs)
-		return -ENOMEM;
-	memcpy(sechdrs, (void *)pi->ehdr + pi->ehdr->e_shoff, sechdrs_size);
-	pi->sechdrs = sechdrs;
-
-	offset = 0;
-	bss_addr = kbuf->mem + kbuf->bufsz;
-	kbuf->image->start = pi->ehdr->e_entry;
-
-	for (i = 0; i < pi->ehdr->e_shnum; i++) {
-		unsigned long align;
-		void *src, *dst;
-
-		if (!(sechdrs[i].sh_flags & SHF_ALLOC))
-			continue;
-
-		align = sechdrs[i].sh_addralign;
-		if (sechdrs[i].sh_type == SHT_NOBITS) {
-			bss_addr = ALIGN(bss_addr, align);
-			sechdrs[i].sh_addr = bss_addr;
-			bss_addr += sechdrs[i].sh_size;
-			continue;
-		}
-
-		offset = ALIGN(offset, align);
-
-		/*
-		 * Check if the segment contains the entry point, if so,
-		 * calculate the value of image->start based on it.
-		 * If the compiler has produced more than one .text section
-		 * (Eg: .text.hot), they are generally after the main .text
-		 * section, and they shall not be used to calculate
-		 * image->start. So do not re-calculate image->start if it
-		 * is not set to the initial value, and warn the user so they
-		 * have a chance to fix their purgatory's linker script.
-		 */
-		if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
-		    pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
-		    pi->ehdr->e_entry < (sechdrs[i].sh_addr
-					 + sechdrs[i].sh_size) &&
-		    !WARN_ON(kbuf->image->start != pi->ehdr->e_entry)) {
-			kbuf->image->start -= sechdrs[i].sh_addr;
-			kbuf->image->start += kbuf->mem + offset;
-		}
-
-		src = (void *)pi->ehdr + sechdrs[i].sh_offset;
-		dst = pi->purgatory_buf + offset;
-		memcpy(dst, src, sechdrs[i].sh_size);
-
-		sechdrs[i].sh_addr = kbuf->mem + offset;
-		sechdrs[i].sh_offset = offset;
-		offset += sechdrs[i].sh_size;
-	}
-
-	return 0;
-}
-
-static int kexec_apply_relocations(struct kimage *image)
-{
-	int i, ret;
-	struct purgatory_info *pi = &image->purgatory_info;
-	const Elf_Shdr *sechdrs;
-
-	sechdrs = (void *)pi->ehdr + pi->ehdr->e_shoff;
-
-	for (i = 0; i < pi->ehdr->e_shnum; i++) {
-		const Elf_Shdr *relsec;
-		const Elf_Shdr *symtab;
-		Elf_Shdr *section;
-
-		relsec = sechdrs + i;
-
-		if (relsec->sh_type != SHT_RELA &&
-		    relsec->sh_type != SHT_REL)
-			continue;
-
-		/*
-		 * For section of type SHT_RELA/SHT_REL,
-		 * ->sh_link contains section header index of associated
-		 * symbol table. And ->sh_info contains section header
-		 * index of section to which relocations apply.
-		 */
-		if (relsec->sh_info >= pi->ehdr->e_shnum ||
-		    relsec->sh_link >= pi->ehdr->e_shnum)
-			return -ENOEXEC;
-
-		section = pi->sechdrs + relsec->sh_info;
-		symtab = sechdrs + relsec->sh_link;
-
-		if (!(section->sh_flags & SHF_ALLOC))
-			continue;
-
-		/*
-		 * symtab->sh_link contain section header index of associated
-		 * string table.
-		 */
-		if (symtab->sh_link >= pi->ehdr->e_shnum)
-			/* Invalid section number? */
-			continue;
-
-		/*
-		 * Respective architecture needs to provide support for applying
-		 * relocations of type SHT_RELA/SHT_REL.
-		 */
-		if (relsec->sh_type == SHT_RELA)
-			ret = arch_kexec_apply_relocations_add(pi, section,
-							       relsec, symtab);
-		else if (relsec->sh_type == SHT_REL)
-			ret = arch_kexec_apply_relocations(pi, section,
-							   relsec, symtab);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-/*
- * kexec_load_purgatory_pie - Load the position independent purgatory object.
- * @pi:		Purgatory info struct.
+ * kexec_load_purgatory - Load and relocate the purgatory object.
+ * @image:	Image to add the purgatory to.
  * @kbuf:	Memory parameters to use.
  *
- * Load a purgatory PIE executable. This is a fully linked executable
- * consisting of a single PT_LOAD segment that does not require any relocation
- * processing.
+ * Allocates the memory needed for image->purgatory_info.sechdrs and
+ * image->purgatory_info.purgatory_buf/kbuf->buffer. Caller is responsible
+ * to free the memory after use.
  *
  * Return: 0 on success, negative errno on error.
  */
-static int kexec_load_purgatory_pie(struct purgatory_info *pi,
-				    struct kexec_buf *kbuf)
+int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf)
 {
-	const Elf_Phdr *phdr = (void *)pi->ehdr + pi->ehdr->e_phoff;
+	struct purgatory_info *pi = &image->purgatory_info;
+	const Elf_Phdr *phdr;
 	int ret;
 
+	if (kexec_purgatory_size <= 0)
+		return -EINVAL;
+
+	pi->ehdr = (const Elf_Ehdr *)kexec_purgatory;
 	if (pi->ehdr->e_phnum != 1)
 		return -EINVAL;
 
+	phdr = (void *)pi->ehdr + pi->ehdr->e_phoff;
+
 	kbuf->bufsz = phdr->p_filesz;
 	kbuf->memsz = phdr->p_memsz;
 	kbuf->buf_align = phdr->p_align;
@@ -1066,52 +869,6 @@ static int kexec_load_purgatory_pie(struct purgatory_info *pi,
 	return ret;
 }
 
-/*
- * kexec_load_purgatory - Load and relocate the purgatory object.
- * @image:	Image to add the purgatory to.
- * @kbuf:	Memory parameters to use.
- *
- * Allocates the memory needed for image->purgatory_info.sechdrs and
- * image->purgatory_info.purgatory_buf/kbuf->buffer. Caller is responsible
- * to free the memory after use.
- *
- * Return: 0 on success, negative errno on error.
- */
-int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf)
-{
-	struct purgatory_info *pi = &image->purgatory_info;
-	int ret;
-
-	if (kexec_purgatory_size <= 0)
-		return -EINVAL;
-
-	pi->ehdr = (const Elf_Ehdr *)kexec_purgatory;
-
-	if (pi->ehdr->e_type != ET_REL)
-		return kexec_load_purgatory_pie(pi, kbuf);
-
-	ret = kexec_purgatory_setup_kbuf(pi, kbuf);
-	if (ret)
-		return ret;
-
-	ret = kexec_purgatory_setup_sechdrs(pi, kbuf);
-	if (ret)
-		goto out_free_kbuf;
-
-	ret = kexec_apply_relocations(image);
-	if (ret)
-		goto out;
-
-	return 0;
-out:
-	vfree(pi->sechdrs);
-	pi->sechdrs = NULL;
-out_free_kbuf:
-	vfree(pi->purgatory_buf);
-	pi->purgatory_buf = NULL;
-	return ret;
-}
-
 /*
  * kexec_purgatory_find_symbol - find a symbol in the purgatory
  * @pi:		Purgatory to search in.
-- 
2.44.0.769.g3c40516874-goog


