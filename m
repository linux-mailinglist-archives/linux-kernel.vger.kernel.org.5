Return-Path: <linux-kernel+bounces-112572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EF1887B97
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 04:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61A3EB212F0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 03:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD5B4691;
	Sun, 24 Mar 2024 03:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cM0n5vpu"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FAA17C8;
	Sun, 24 Mar 2024 03:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711252629; cv=none; b=HuCzue0kIM+rRN6Xnu1V/i9EcWZJshRNCdkQfb9CrcnfIaXK9k+k7aEr7QwRnNIVhAEfURyAYgZzHT3MR3h9BQJWOZ17BIg53DHgKyHk1RcNbYdRA4wq5lb/QjIPH3CI7d1AZUBN3KG/1FKMwRwzxpj24d14F+TIWVRuwt/lT/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711252629; c=relaxed/simple;
	bh=ulthONZyiojypR8cL6psh4puMRBMUCvWbf8otyhZqNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMGUsNpSnSBw4iHMy6kJTgmGN5SBRADmA4/WxiqmN6Rkx+ShsSWeWv6hPFpfIimIxUtMpD1MaQjO3RZzvV64duStt6WshJzkbmWYXvWzIIdATecvl1zjgkQ6OyU4VaS2n++oQoujw/t6pNc9kd4kHNN7Ns7Ah9sLSxlggi5Y964=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cM0n5vpu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4141156f245so23589635e9.2;
        Sat, 23 Mar 2024 20:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711252625; x=1711857425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N+eXxX3IJqvgsJ3Kx4pH+G3t5afdRaMPGbRMs0lWOdQ=;
        b=cM0n5vpuCGXVA6HuMmrSnCfsVu5YbWfAdgltbiWTqQ1M+aC7k6f+jffkZlPxWqCNcT
         QdErWE4TYs9eaiTs24h8DrJ7l9b82sHIf6uyM8Jd3FrnyeUBV4cWKUnvjgqe/Qx9/Z1O
         +8NJG2JtICL37ket7ervvXIqwDeISkAoO8CUYZTHnszflha3FDd2fQL2HcVJpHBHNC2Z
         a4Vib/Eowpmm8lCMgQ7VX2IgOidpjaQZynwC+bITH8kZoqS4TkhEcfrqol08jrM2V811
         +Xpla8nGQfvv+PVmsDRm22speuX24bDPOdOiwLkoDbdy89z7ua1XTkiPbEZEJdBTEyyo
         i3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711252625; x=1711857425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+eXxX3IJqvgsJ3Kx4pH+G3t5afdRaMPGbRMs0lWOdQ=;
        b=L8qjL2/rAp4EDEZCXF9HCc9vj8MTVKRRe568F91nQYm+yDm8xu3bDl5KvL1tV9ioFm
         yxEgA4RkDA1Ak4Pa2iNyHDQZDzhisKi80sVgnYhlovKCV6AMZ3GVTXrD9cYPkCAS6XRd
         V5+TUfz7oBZNQKTA0co/owx7p+0Vd4rxulMymGHYF05wrG0i8BK29VuOoPlxIvXQJxHg
         yqXGUACRvsfXRICgf5HqhfSmE2zSk8OKfBs09lXk/IqedrJdwkEZSaR0pt+AvXdQieG8
         LXJGPxOn4zBY6/j7Q3mGs/HqAZ6v5Po7A2GEgS9q8WrCqxzr0yg00/j0S6RgDZMA50xY
         hlXA==
X-Forwarded-Encrypted: i=1; AJvYcCXzauR8sSlepkepI5H+cYHbm0DZHXv/QAjYVcydhuSYOfReeNj9ahq3DcFUWOm6ATz3hK/RXFVnPfiB0WJSqg+UvbhRVG/ZgnCKbGfm978pY17QZRJjfDiHgI07tKUZJKUSfeP0SORjTACs4X6F
X-Gm-Message-State: AOJu0YxNqXfns1EcWlMCDo0xfweFkIJZyO1xKLU2p3s0G12JdMNo3IET
	7cYHsRpdO2/GdHUpgr450LtXukiCjCPm93D1Q+MpJpBLn7Veg21J
X-Google-Smtp-Source: AGHT+IGk7gT67ASSauZpG1/6UL8gPtEcah+j+40pLL0mNRCIB5TNAKy6Ampu4YItGX0nHErs3FzCHw==
X-Received: by 2002:a05:600c:1f90:b0:414:8065:2d23 with SMTP id je16-20020a05600c1f9000b0041480652d23mr2093235wmb.20.1711252624829;
        Sat, 23 Mar 2024 20:57:04 -0700 (PDT)
Received: from gmail.com (195-38-112-2.pool.digikabel.hu. [195.38.112.2])
        by smtp.gmail.com with ESMTPSA id m15-20020a05600c4f4f00b004146bce65f4sm4104025wmq.13.2024.03.23.20.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 20:57:04 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 24 Mar 2024 04:57:02 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: tglx@linutronix.de, Guixiong Wei <weiguixiong@bytedance.com>,
	jgross@suse.com, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	peterz@infradead.org, gregkh@linuxfoundation.org,
	tony.luck@intel.com, adobriyan@gmail.com,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] x86/build: Clean up arch/x86/tools/relocs.c a bit
Message-ID: <Zf+kjv4gkMKbaRhj@gmail.com>
References: <20240317150547.24910-1-weiguixiong@bytedance.com>
 <171079804927.224083.15609364452504732018.b4-ty@chromium.org>
 <Zf1FGI6E3wStJSQT@gmail.com>
 <202403221640.27DC5CB09@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202403221640.27DC5CB09@keescook>


* Kees Cook <keescook@chromium.org> wrote:

> On Fri, Mar 22, 2024 at 09:45:12AM +0100, Ingo Molnar wrote:
> > 
> > * Kees Cook <keescook@chromium.org> wrote:
> > 
> > > On Sun, 17 Mar 2024 23:05:47 +0800, Guixiong Wei wrote:
> > > > The commit aaa8736370db ("x86, relocs: Ignore relocations in
> > > > .notes section") only ignore .note section on print_absolute_relocs,
> > > > but it also need to add on walk_relocs to avoid relocations in .note
> > > > section.
> > > > 
> > > > 
> > > 
> > > Applied to for-next/hardening, thanks!
> > > 
> > > [1/1] x86, relocs: Ignore relocations in .notes section on walk_relocs
> > >       https://git.kernel.org/kees/c/6ba438a29b5d
> > 
> > Please don't - these are x86 patches, plus it contains an eyesore - see 
> > below ...
> 
> Dropped.
> 
> > 
> > Thanks,
> > 
> > 	Ingo
> > 
> >  relocs.c |    3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > Index: tip/arch/x86/tools/relocs.c
> > ===================================================================
> > --- tip.orig/arch/x86/tools/relocs.c
> > +++ tip/arch/x86/tools/relocs.c
> > @@ -752,9 +752,8 @@ static void walk_relocs(int (*process)(s
> >  		 * values there are meant for pre-boot consumption (e.g.
> >  		 * startup_xen).
> >  		 */
> > -		if (sec_applies->shdr.sh_type == SHT_NOTE) {
> > +		if (sec_applies->shdr.sh_type == SHT_NOTE)
> >  			continue;
> > -		}
> 
> I think the patch was trying to follow the existing code style in the
> file. See line 733, for example:
> 
>  		if (sec->shdr.sh_type != SHT_REL_TYPE) {
>  			continue;
>  		}

The 'existing code style' is a hodgepodge of CodingStyle compliant and 
non-compliant bits - and our preference is to not propagate crap ...

Anyway, I cleaned it all up a bit in tip:x86/boot with the patch below.

Thanks,

	Ingo

================>
From: Ingo Molnar <mingo@kernel.org>
Date: Sun, 24 Mar 2024 04:46:10 +0100
Subject: [PATCH] x86/build: Clean up arch/x86/tools/relocs.c a bit

So:

 - Follow Documentation/CodingStyle for:
    - curly braces
    - variable definitions
    - return statements
    - etc.
    - Fix unnecessary linebreaks
    - Don't split user-visible error strings over multiple lines ...

 - It's fine to use vertical alignment to make code more readable,
   but it should be internally consistent for definitions visible
   on a single page ...

 - There's 40+ die() statements that are basically asserts and
   never trigger. Make them single-line, to move them out of
   sight as much as possible.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/tools/relocs.c | 362 ++++++++++++++++++++++++------------------------
 1 file changed, 178 insertions(+), 184 deletions(-)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index e7a44a7f617f..c101bed61940 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -11,41 +11,42 @@
 #define Elf_Shdr		ElfW(Shdr)
 #define Elf_Sym			ElfW(Sym)
 
-static Elf_Ehdr		ehdr;
-static unsigned long	shnum;
-static unsigned int	shstrndx;
-static unsigned int	shsymtabndx;
-static unsigned int	shxsymtabndx;
+static Elf_Ehdr			ehdr;
+static unsigned long		shnum;
+static unsigned int		shstrndx;
+static unsigned int		shsymtabndx;
+static unsigned int		shxsymtabndx;
 
 static int sym_index(Elf_Sym *sym);
 
 struct relocs {
-	uint32_t	*offset;
-	unsigned long	count;
-	unsigned long	size;
+				uint32_t	*offset;
+				unsigned long	count;
+				unsigned long	size;
 };
 
-static struct relocs relocs16;
-static struct relocs relocs32;
+static struct relocs		relocs16;
+static struct relocs		relocs32;
+
 #if ELF_BITS == 64
-static struct relocs relocs32neg;
-static struct relocs relocs64;
-#define FMT PRIu64
+static struct relocs		relocs32neg;
+static struct relocs		relocs64;
+# define FMT PRIu64
 #else
-#define FMT PRIu32
+# define FMT PRIu32
 #endif
 
 struct section {
-	Elf_Shdr       shdr;
-	struct section *link;
-	Elf_Sym        *symtab;
-	Elf32_Word     *xsymtab;
-	Elf_Rel        *reltab;
-	char           *strtab;
+				Elf_Shdr       shdr;
+				struct section *link;
+				Elf_Sym        *symtab;
+				Elf32_Word     *xsymtab;
+				Elf_Rel        *reltab;
+				char           *strtab;
 };
-static struct section *secs;
+static struct section		*secs;
 
-static const char * const sym_regex_kernel[S_NSYMTYPES] = {
+static const char * const	sym_regex_kernel[S_NSYMTYPES] = {
 /*
  * Following symbols have been audited. There values are constant and do
  * not change if bzImage is loaded at a different physical address than
@@ -115,13 +116,13 @@ static const char * const sym_regex_realmode[S_NSYMTYPES] = {
 	"^pa_",
 };
 
-static const char * const *sym_regex;
+static const char * const	*sym_regex;
+
+static regex_t			sym_regex_c[S_NSYMTYPES];
 
-static regex_t sym_regex_c[S_NSYMTYPES];
 static int is_reloc(enum symtype type, const char *sym_name)
 {
-	return sym_regex[type] &&
-		!regexec(&sym_regex_c[type], sym_name, 0, NULL, 0);
+	return sym_regex[type] && !regexec(&sym_regex_c[type], sym_name, 0, NULL, 0);
 }
 
 static void regex_init(int use_real_mode)
@@ -139,8 +140,7 @@ static void regex_init(int use_real_mode)
 		if (!sym_regex[i])
 			continue;
 
-		err = regcomp(&sym_regex_c[i], sym_regex[i],
-			      REG_EXTENDED|REG_NOSUB);
+		err = regcomp(&sym_regex_c[i], sym_regex[i], REG_EXTENDED|REG_NOSUB);
 
 		if (err) {
 			regerror(err, &sym_regex_c[i], errbuf, sizeof(errbuf));
@@ -163,9 +163,10 @@ static const char *sym_type(unsigned type)
 #undef SYM_TYPE
 	};
 	const char *name = "unknown sym type name";
-	if (type < ARRAY_SIZE(type_name)) {
+
+	if (type < ARRAY_SIZE(type_name))
 		name = type_name[type];
-	}
+
 	return name;
 }
 
@@ -179,9 +180,10 @@ static const char *sym_bind(unsigned bind)
 #undef SYM_BIND
 	};
 	const char *name = "unknown sym bind name";
-	if (bind < ARRAY_SIZE(bind_name)) {
+
+	if (bind < ARRAY_SIZE(bind_name))
 		name = bind_name[bind];
-	}
+
 	return name;
 }
 
@@ -196,9 +198,10 @@ static const char *sym_visibility(unsigned visibility)
 #undef SYM_VISIBILITY
 	};
 	const char *name = "unknown sym visibility name";
-	if (visibility < ARRAY_SIZE(visibility_name)) {
+
+	if (visibility < ARRAY_SIZE(visibility_name))
 		name = visibility_name[visibility];
-	}
+
 	return name;
 }
 
@@ -244,9 +247,10 @@ static const char *rel_type(unsigned type)
 #undef REL_TYPE
 	};
 	const char *name = "unknown type rel type name";
-	if (type < ARRAY_SIZE(type_name) && type_name[type]) {
+
+	if (type < ARRAY_SIZE(type_name) && type_name[type])
 		name = type_name[type];
-	}
+
 	return name;
 }
 
@@ -256,15 +260,14 @@ static const char *sec_name(unsigned shndx)
 	const char *name;
 	sec_strtab = secs[shstrndx].strtab;
 	name = "<noname>";
-	if (shndx < shnum) {
+
+	if (shndx < shnum)
 		name = sec_strtab + secs[shndx].shdr.sh_name;
-	}
-	else if (shndx == SHN_ABS) {
+	else if (shndx == SHN_ABS)
 		name = "ABSOLUTE";
-	}
-	else if (shndx == SHN_COMMON) {
+	else if (shndx == SHN_COMMON)
 		name = "COMMON";
-	}
+
 	return name;
 }
 
@@ -272,18 +275,19 @@ static const char *sym_name(const char *sym_strtab, Elf_Sym *sym)
 {
 	const char *name;
 	name = "<noname>";
-	if (sym->st_name) {
+
+	if (sym->st_name)
 		name = sym_strtab + sym->st_name;
-	}
-	else {
+	else
 		name = sec_name(sym_index(sym));
-	}
+
 	return name;
 }
 
 static Elf_Sym *sym_lookup(const char *symname)
 {
 	int i;
+
 	for (i = 0; i < shnum; i++) {
 		struct section *sec = &secs[i];
 		long nsyms;
@@ -309,14 +313,15 @@ static Elf_Sym *sym_lookup(const char *symname)
 }
 
 #if BYTE_ORDER == LITTLE_ENDIAN
-#define le16_to_cpu(val) (val)
-#define le32_to_cpu(val) (val)
-#define le64_to_cpu(val) (val)
+# define le16_to_cpu(val)	(val)
+# define le32_to_cpu(val)	(val)
+# define le64_to_cpu(val)	(val)
 #endif
+
 #if BYTE_ORDER == BIG_ENDIAN
-#define le16_to_cpu(val) bswap_16(val)
-#define le32_to_cpu(val) bswap_32(val)
-#define le64_to_cpu(val) bswap_64(val)
+# define le16_to_cpu(val)	bswap_16(val)
+# define le32_to_cpu(val)	bswap_32(val)
+# define le64_to_cpu(val)	bswap_64(val)
 #endif
 
 static uint16_t elf16_to_cpu(uint16_t val)
@@ -337,13 +342,13 @@ static uint64_t elf64_to_cpu(uint64_t val)
 {
         return le64_to_cpu(val);
 }
-#define elf_addr_to_cpu(x)	elf64_to_cpu(x)
-#define elf_off_to_cpu(x)	elf64_to_cpu(x)
-#define elf_xword_to_cpu(x)	elf64_to_cpu(x)
+# define elf_addr_to_cpu(x)	elf64_to_cpu(x)
+# define elf_off_to_cpu(x)	elf64_to_cpu(x)
+# define elf_xword_to_cpu(x)	elf64_to_cpu(x)
 #else
-#define elf_addr_to_cpu(x)	elf32_to_cpu(x)
-#define elf_off_to_cpu(x)	elf32_to_cpu(x)
-#define elf_xword_to_cpu(x)	elf32_to_cpu(x)
+# define elf_addr_to_cpu(x)	elf32_to_cpu(x)
+# define elf_off_to_cpu(x)	elf32_to_cpu(x)
+# define elf_xword_to_cpu(x)	elf32_to_cpu(x)
 #endif
 
 static int sym_index(Elf_Sym *sym)
@@ -365,22 +370,17 @@ static int sym_index(Elf_Sym *sym)
 
 static void read_ehdr(FILE *fp)
 {
-	if (fread(&ehdr, sizeof(ehdr), 1, fp) != 1) {
-		die("Cannot read ELF header: %s\n",
-			strerror(errno));
-	}
-	if (memcmp(ehdr.e_ident, ELFMAG, SELFMAG) != 0) {
+	if (fread(&ehdr, sizeof(ehdr), 1, fp) != 1)
+		die("Cannot read ELF header: %s\n", strerror(errno));
+	if (memcmp(ehdr.e_ident, ELFMAG, SELFMAG) != 0)
 		die("No ELF magic\n");
-	}
-	if (ehdr.e_ident[EI_CLASS] != ELF_CLASS) {
+	if (ehdr.e_ident[EI_CLASS] != ELF_CLASS)
 		die("Not a %d bit executable\n", ELF_BITS);
-	}
-	if (ehdr.e_ident[EI_DATA] != ELFDATA2LSB) {
+	if (ehdr.e_ident[EI_DATA] != ELFDATA2LSB)
 		die("Not a LSB ELF executable\n");
-	}
-	if (ehdr.e_ident[EI_VERSION] != EV_CURRENT) {
+	if (ehdr.e_ident[EI_VERSION] != EV_CURRENT)
 		die("Unknown ELF version\n");
-	}
+
 	/* Convert the fields to native endian */
 	ehdr.e_type      = elf_half_to_cpu(ehdr.e_type);
 	ehdr.e_machine   = elf_half_to_cpu(ehdr.e_machine);
@@ -439,19 +439,18 @@ static void read_shdrs(FILE *fp)
 	Elf_Shdr shdr;
 
 	secs = calloc(shnum, sizeof(struct section));
-	if (!secs) {
-		die("Unable to allocate %ld section headers\n",
-		    shnum);
-	}
-	if (fseek(fp, ehdr.e_shoff, SEEK_SET) < 0) {
-		die("Seek to %" FMT " failed: %s\n",
-		    ehdr.e_shoff, strerror(errno));
-	}
+	if (!secs)
+		die("Unable to allocate %ld section headers\n", shnum);
+
+	if (fseek(fp, ehdr.e_shoff, SEEK_SET) < 0)
+		die("Seek to %" FMT " failed: %s\n", ehdr.e_shoff, strerror(errno));
+
 	for (i = 0; i < shnum; i++) {
 		struct section *sec = &secs[i];
+
 		if (fread(&shdr, sizeof(shdr), 1, fp) != 1)
-			die("Cannot read ELF section headers %d/%ld: %s\n",
-			    i, shnum, strerror(errno));
+			die("Cannot read ELF section headers %d/%ld: %s\n", i, shnum, strerror(errno));
+
 		sec->shdr.sh_name      = elf_word_to_cpu(shdr.sh_name);
 		sec->shdr.sh_type      = elf_word_to_cpu(shdr.sh_type);
 		sec->shdr.sh_flags     = elf_xword_to_cpu(shdr.sh_flags);
@@ -471,31 +470,28 @@ static void read_shdrs(FILE *fp)
 static void read_strtabs(FILE *fp)
 {
 	int i;
+
 	for (i = 0; i < shnum; i++) {
 		struct section *sec = &secs[i];
-		if (sec->shdr.sh_type != SHT_STRTAB) {
+
+		if (sec->shdr.sh_type != SHT_STRTAB)
 			continue;
-		}
+
 		sec->strtab = malloc(sec->shdr.sh_size);
-		if (!sec->strtab) {
-			die("malloc of %" FMT " bytes for strtab failed\n",
-			    sec->shdr.sh_size);
-		}
-		if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0) {
-			die("Seek to %" FMT " failed: %s\n",
-			    sec->shdr.sh_offset, strerror(errno));
-		}
-		if (fread(sec->strtab, 1, sec->shdr.sh_size, fp)
-		    != sec->shdr.sh_size) {
-			die("Cannot read symbol table: %s\n",
-				strerror(errno));
-		}
+		if (!sec->strtab)
+			die("malloc of %" FMT " bytes for strtab failed\n", sec->shdr.sh_size);
+
+		if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0)
+			die("Seek to %" FMT " failed: %s\n", sec->shdr.sh_offset, strerror(errno));
+
+		if (fread(sec->strtab, 1, sec->shdr.sh_size, fp) != sec->shdr.sh_size)
+			die("Cannot read symbol table: %s\n", strerror(errno));
 	}
 }
 
 static void read_symtabs(FILE *fp)
 {
-	int i,j;
+	int i, j;
 
 	for (i = 0; i < shnum; i++) {
 		struct section *sec = &secs[i];
@@ -504,19 +500,15 @@ static void read_symtabs(FILE *fp)
 		switch (sec->shdr.sh_type) {
 		case SHT_SYMTAB_SHNDX:
 			sec->xsymtab = malloc(sec->shdr.sh_size);
-			if (!sec->xsymtab) {
-				die("malloc of %" FMT " bytes for xsymtab failed\n",
-				    sec->shdr.sh_size);
-			}
-			if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0) {
-				die("Seek to %" FMT " failed: %s\n",
-				    sec->shdr.sh_offset, strerror(errno));
-			}
-			if (fread(sec->xsymtab, 1, sec->shdr.sh_size, fp)
-			    != sec->shdr.sh_size) {
-				die("Cannot read extended symbol table: %s\n",
-				    strerror(errno));
-			}
+			if (!sec->xsymtab)
+				die("malloc of %" FMT " bytes for xsymtab failed\n", sec->shdr.sh_size);
+
+			if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0)
+				die("Seek to %" FMT " failed: %s\n", sec->shdr.sh_offset, strerror(errno));
+
+			if (fread(sec->xsymtab, 1, sec->shdr.sh_size, fp) != sec->shdr.sh_size)
+				die("Cannot read extended symbol table: %s\n", strerror(errno));
+
 			shxsymtabndx = i;
 			continue;
 
@@ -524,19 +516,15 @@ static void read_symtabs(FILE *fp)
 			num_syms = sec->shdr.sh_size / sizeof(Elf_Sym);
 
 			sec->symtab = malloc(sec->shdr.sh_size);
-			if (!sec->symtab) {
-				die("malloc of %" FMT " bytes for symtab failed\n",
-				    sec->shdr.sh_size);
-			}
-			if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0) {
-				die("Seek to %" FMT " failed: %s\n",
-				    sec->shdr.sh_offset, strerror(errno));
-			}
-			if (fread(sec->symtab, 1, sec->shdr.sh_size, fp)
-			    != sec->shdr.sh_size) {
-				die("Cannot read symbol table: %s\n",
-				    strerror(errno));
-			}
+			if (!sec->symtab)
+				die("malloc of %" FMT " bytes for symtab failed\n", sec->shdr.sh_size);
+
+			if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0)
+				die("Seek to %" FMT " failed: %s\n", sec->shdr.sh_offset, strerror(errno));
+
+			if (fread(sec->symtab, 1, sec->shdr.sh_size, fp) != sec->shdr.sh_size)
+				die("Cannot read symbol table: %s\n", strerror(errno));
+
 			for (j = 0; j < num_syms; j++) {
 				Elf_Sym *sym = &sec->symtab[j];
 
@@ -557,28 +545,27 @@ static void read_symtabs(FILE *fp)
 
 static void read_relocs(FILE *fp)
 {
-	int i,j;
+	int i, j;
+
 	for (i = 0; i < shnum; i++) {
 		struct section *sec = &secs[i];
-		if (sec->shdr.sh_type != SHT_REL_TYPE) {
+
+		if (sec->shdr.sh_type != SHT_REL_TYPE)
 			continue;
-		}
+
 		sec->reltab = malloc(sec->shdr.sh_size);
-		if (!sec->reltab) {
-			die("malloc of %" FMT " bytes for relocs failed\n",
-			    sec->shdr.sh_size);
-		}
-		if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0) {
-			die("Seek to %" FMT " failed: %s\n",
-			    sec->shdr.sh_offset, strerror(errno));
-		}
-		if (fread(sec->reltab, 1, sec->shdr.sh_size, fp)
-		    != sec->shdr.sh_size) {
-			die("Cannot read symbol table: %s\n",
-				strerror(errno));
-		}
+		if (!sec->reltab)
+			die("malloc of %" FMT " bytes for relocs failed\n", sec->shdr.sh_size);
+
+		if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0)
+			die("Seek to %" FMT " failed: %s\n", sec->shdr.sh_offset, strerror(errno));
+
+		if (fread(sec->reltab, 1, sec->shdr.sh_size, fp) != sec->shdr.sh_size)
+			die("Cannot read symbol table: %s\n", strerror(errno));
+
 		for (j = 0; j < sec->shdr.sh_size/sizeof(Elf_Rel); j++) {
 			Elf_Rel *rel = &sec->reltab[j];
+
 			rel->r_offset = elf_addr_to_cpu(rel->r_offset);
 			rel->r_info   = elf_xword_to_cpu(rel->r_info);
 #if (SHT_REL_TYPE == SHT_RELA)
@@ -601,23 +588,27 @@ static void print_absolute_symbols(void)
 
 	printf("Absolute symbols\n");
 	printf(" Num:    Value Size  Type       Bind        Visibility  Name\n");
+
 	for (i = 0; i < shnum; i++) {
 		struct section *sec = &secs[i];
 		char *sym_strtab;
 		int j;
 
-		if (sec->shdr.sh_type != SHT_SYMTAB) {
+		if (sec->shdr.sh_type != SHT_SYMTAB)
 			continue;
-		}
+
 		sym_strtab = sec->link->strtab;
+
 		for (j = 0; j < sec->shdr.sh_size/sizeof(Elf_Sym); j++) {
 			Elf_Sym *sym;
 			const char *name;
+
 			sym = &sec->symtab[j];
 			name = sym_name(sym_strtab, sym);
-			if (sym->st_shndx != SHN_ABS) {
+
+			if (sym->st_shndx != SHN_ABS)
 				continue;
-			}
+
 			printf(format,
 				j, sym->st_value, sym->st_size,
 				sym_type(ELF_ST_TYPE(sym->st_info)),
@@ -645,34 +636,37 @@ static void print_absolute_relocs(void)
 		char *sym_strtab;
 		Elf_Sym *sh_symtab;
 		int j;
-		if (sec->shdr.sh_type != SHT_REL_TYPE) {
+
+		if (sec->shdr.sh_type != SHT_REL_TYPE)
 			continue;
-		}
+
 		sec_symtab  = sec->link;
 		sec_applies = &secs[sec->shdr.sh_info];
-		if (!(sec_applies->shdr.sh_flags & SHF_ALLOC)) {
+		if (!(sec_applies->shdr.sh_flags & SHF_ALLOC))
 			continue;
-		}
+
 		/*
 		 * Do not perform relocations in .notes section; any
 		 * values there are meant for pre-boot consumption (e.g.
 		 * startup_xen).
 		 */
-		if (sec_applies->shdr.sh_type == SHT_NOTE) {
+		if (sec_applies->shdr.sh_type == SHT_NOTE)
 			continue;
-		}
+
 		sh_symtab  = sec_symtab->symtab;
 		sym_strtab = sec_symtab->link->strtab;
+
 		for (j = 0; j < sec->shdr.sh_size/sizeof(Elf_Rel); j++) {
 			Elf_Rel *rel;
 			Elf_Sym *sym;
 			const char *name;
+
 			rel = &sec->reltab[j];
 			sym = &sh_symtab[ELF_R_SYM(rel->r_info)];
 			name = sym_name(sym_strtab, sym);
-			if (sym->st_shndx != SHN_ABS) {
+
+			if (sym->st_shndx != SHN_ABS)
 				continue;
-			}
 
 			/* Absolute symbols are not relocated if bzImage is
 			 * loaded at a non-compiled address. Display a warning
@@ -691,10 +685,8 @@ static void print_absolute_relocs(void)
 				continue;
 
 			if (!printed) {
-				printf("WARNING: Absolute relocations"
-					" present\n");
-				printf("Offset     Info     Type     Sym.Value "
-					"Sym.Name\n");
+				printf("WARNING: Absolute relocations present\n");
+				printf("Offset     Info     Type     Sym.Value Sym.Name\n");
 				printed = 1;
 			}
 
@@ -718,8 +710,8 @@ static void add_reloc(struct relocs *r, uint32_t offset)
 		void *mem = realloc(r->offset, newsize * sizeof(r->offset[0]));
 
 		if (!mem)
-			die("realloc of %ld entries for relocs failed\n",
-                                newsize);
+			die("realloc of %ld entries for relocs failed\n", newsize);
+
 		r->offset = mem;
 		r->size = newsize;
 	}
@@ -730,6 +722,7 @@ static void walk_relocs(int (*process)(struct section *sec, Elf_Rel *rel,
 			Elf_Sym *sym, const char *symname))
 {
 	int i;
+
 	/* Walk through the relocations */
 	for (i = 0; i < shnum; i++) {
 		char *sym_strtab;
@@ -738,14 +731,13 @@ static void walk_relocs(int (*process)(struct section *sec, Elf_Rel *rel,
 		int j;
 		struct section *sec = &secs[i];
 
-		if (sec->shdr.sh_type != SHT_REL_TYPE) {
+		if (sec->shdr.sh_type != SHT_REL_TYPE)
 			continue;
-		}
+
 		sec_symtab  = sec->link;
 		sec_applies = &secs[sec->shdr.sh_info];
-		if (!(sec_applies->shdr.sh_flags & SHF_ALLOC)) {
+		if (!(sec_applies->shdr.sh_flags & SHF_ALLOC))
 			continue;
-		}
 
 		/*
 		 * Do not perform relocations in .notes sections; any
@@ -757,6 +749,7 @@ static void walk_relocs(int (*process)(struct section *sec, Elf_Rel *rel,
 
 		sh_symtab = sec_symtab->symtab;
 		sym_strtab = sec_symtab->link->strtab;
+
 		for (j = 0; j < sec->shdr.sh_size/sizeof(Elf_Rel); j++) {
 			Elf_Rel *rel = &sec->reltab[j];
 			Elf_Sym *sym = &sh_symtab[ELF_R_SYM(rel->r_info)];
@@ -790,14 +783,16 @@ static void walk_relocs(int (*process)(struct section *sec, Elf_Rel *rel,
  * kernel data and does not require special treatment.
  *
  */
-static int per_cpu_shndx	= -1;
+static int per_cpu_shndx = -1;
 static Elf_Addr per_cpu_load_addr;
 
 static void percpu_init(void)
 {
 	int i;
+
 	for (i = 0; i < shnum; i++) {
 		ElfW(Sym) *sym;
+
 		if (strcmp(sec_name(i), ".data..percpu"))
 			continue;
 
@@ -810,6 +805,7 @@ static void percpu_init(void)
 
 		per_cpu_shndx = i;
 		per_cpu_load_addr = sym->st_value;
+
 		return;
 	}
 }
@@ -880,8 +876,7 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 		 * Only used by jump labels
 		 */
 		if (is_percpu_sym(sym, symname))
-			die("Invalid R_X86_64_PC64 relocation against per-CPU symbol %s\n",
-			    symname);
+			die("Invalid R_X86_64_PC64 relocation against per-CPU symbol %s\n", symname);
 		break;
 
 	case R_X86_64_32:
@@ -901,8 +896,7 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 			if (is_reloc(S_ABS, symname))
 				break;
 
-			die("Invalid absolute %s relocation: %s\n",
-			    rel_type(r_type), symname);
+			die("Invalid absolute %s relocation: %s\n", rel_type(r_type), symname);
 			break;
 		}
 
@@ -922,8 +916,7 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 		break;
 
 	default:
-		die("Unsupported relocation type: %s (%d)\n",
-		    rel_type(r_type), r_type);
+		die("Unsupported relocation type: %s (%d)\n", rel_type(r_type), r_type);
 		break;
 	}
 
@@ -960,8 +953,7 @@ static int do_reloc32(struct section *sec, Elf_Rel *rel, Elf_Sym *sym,
 			if (is_reloc(S_ABS, symname))
 				break;
 
-			die("Invalid absolute %s relocation: %s\n",
-			    rel_type(r_type), symname);
+			die("Invalid absolute %s relocation: %s\n", rel_type(r_type), symname);
 			break;
 		}
 
@@ -969,16 +961,14 @@ static int do_reloc32(struct section *sec, Elf_Rel *rel, Elf_Sym *sym,
 		break;
 
 	default:
-		die("Unsupported relocation type: %s (%d)\n",
-		    rel_type(r_type), r_type);
+		die("Unsupported relocation type: %s (%d)\n", rel_type(r_type), r_type);
 		break;
 	}
 
 	return 0;
 }
 
-static int do_reloc_real(struct section *sec, Elf_Rel *rel, Elf_Sym *sym,
-			 const char *symname)
+static int do_reloc_real(struct section *sec, Elf_Rel *rel, Elf_Sym *sym, const char *symname)
 {
 	unsigned r_type = ELF32_R_TYPE(rel->r_info);
 	int shn_abs = (sym->st_shndx == SHN_ABS) && !is_reloc(S_REL, symname);
@@ -1013,9 +1003,7 @@ static int do_reloc_real(struct section *sec, Elf_Rel *rel, Elf_Sym *sym,
 			if (!is_reloc(S_LIN, symname))
 				break;
 		}
-		die("Invalid %s %s relocation: %s\n",
-		    shn_abs ? "absolute" : "relative",
-		    rel_type(r_type), symname);
+		die("Invalid %s %s relocation: %s\n", shn_abs ? "absolute" : "relative", rel_type(r_type), symname);
 		break;
 
 	case R_386_32:
@@ -1036,14 +1024,11 @@ static int do_reloc_real(struct section *sec, Elf_Rel *rel, Elf_Sym *sym,
 				add_reloc(&relocs32, rel->r_offset);
 			break;
 		}
-		die("Invalid %s %s relocation: %s\n",
-		    shn_abs ? "absolute" : "relative",
-		    rel_type(r_type), symname);
+		die("Invalid %s %s relocation: %s\n", shn_abs ? "absolute" : "relative", rel_type(r_type), symname);
 		break;
 
 	default:
-		die("Unsupported relocation type: %s (%d)\n",
-		    rel_type(r_type), r_type);
+		die("Unsupported relocation type: %s (%d)\n", rel_type(r_type), r_type);
 		break;
 	}
 
@@ -1055,7 +1040,10 @@ static int do_reloc_real(struct section *sec, Elf_Rel *rel, Elf_Sym *sym,
 static int cmp_relocs(const void *va, const void *vb)
 {
 	const uint32_t *a, *b;
-	a = va; b = vb;
+
+	a = va;
+	b = vb;
+
 	return (*a == *b)? 0 : (*a > *b)? 1 : -1;
 }
 
@@ -1069,6 +1057,7 @@ static int write32(uint32_t v, FILE *f)
 	unsigned char buf[4];
 
 	put_unaligned_le32(v, buf);
+
 	return fwrite(buf, 1, 4, f) == 4 ? 0 : -1;
 }
 
@@ -1081,8 +1070,7 @@ static void emit_relocs(int as_text, int use_real_mode)
 {
 	int i;
 	int (*write_reloc)(uint32_t, FILE *) = write32;
-	int (*do_reloc)(struct section *sec, Elf_Rel *rel, Elf_Sym *sym,
-			const char *symname);
+	int (*do_reloc)(struct section *sec, Elf_Rel *rel, Elf_Sym *sym, const char *symname);
 
 #if ELF_BITS == 64
 	if (!use_real_mode)
@@ -1169,6 +1157,7 @@ static int do_reloc_info(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 		rel_type(ELF_R_TYPE(rel->r_info)),
 		symname,
 		sec_name(sym_index(sym)));
+
 	return 0;
 }
 
@@ -1194,19 +1183,24 @@ void process(FILE *fp, int use_real_mode, int as_text,
 	read_strtabs(fp);
 	read_symtabs(fp);
 	read_relocs(fp);
+
 	if (ELF_BITS == 64)
 		percpu_init();
+
 	if (show_absolute_syms) {
 		print_absolute_symbols();
 		return;
 	}
+
 	if (show_absolute_relocs) {
 		print_absolute_relocs();
 		return;
 	}
+
 	if (show_reloc_info) {
 		print_reloc_info();
 		return;
 	}
+
 	emit_relocs(as_text, use_real_mode);
 }

