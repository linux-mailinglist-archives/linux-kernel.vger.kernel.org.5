Return-Path: <linux-kernel+bounces-112578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96652887BA2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 05:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0805C1F215F4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 04:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52658FC1C;
	Sun, 24 Mar 2024 04:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A4HS4Krs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vlHADMfg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B83D502;
	Sun, 24 Mar 2024 04:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711253147; cv=none; b=Nnye8oGtx1Ee+8SQlIV32FYwyCxnwSJlynkPPMoLckt0fKvr79o5wjnyoejzJ5IeeOdKKFwc+cTydaMnIWS6tJnPDIRVtNKz9ongCIlF9A0xs2UTjfSLDRZTn/Erj6Zz+ZyR3Aeo8uVfmvEUnKJfhCWcCSdhdO2zDxTmuXvK1Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711253147; c=relaxed/simple;
	bh=RmnyFGkpD8vTC+UgmndP2tnohutpg7hPGu1sgLq8Yos=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Fulc/qZajjuiV045Xi1MQNnB9j9wqb/kZOpRFp/uljDdEdcwZnT0Uf1z0t9b8JfOAcGszu6GVxT2C8nP+HlftM73iJYZ+BNYEvTCzx2XzJm/g3DmxsNzhJDJUEwOxltZvNd7cUbk1Gu6PbGR65c10PwlSZRWADNgxMRJSRN8q/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A4HS4Krs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vlHADMfg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 24 Mar 2024 04:05:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711253143;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=UPtf1koJU53DcwMEpBDvTKMZqc6f/Zbqhc3pS12IRFk=;
	b=A4HS4KrstWPV7+vwEiEKQrEed9TqjsIDgLwq6gDZeOCj//IZQqGnxHzoV1juoRQSzPs/dJ
	2ajfN8onCboZy9ZLhX+BV2Vi3PzdAfrVX80yPv9IV1cyKz+fqs1fmNAnRNlrxbu/Z39OOS
	cFzL+R4eTs6mkoH7eX53UYaJf7WWt1z/f+cO7FgRNt/MB+9JYO6vp2rwd/uz2AG1Lb5YxW
	J+brQBD4hFJWrli5j1l5bXW5KL6CbM9+OoQmeOThqHtA2DUwjbdHy4U8OU3l18P6L347g3
	tLl6ZepVQy2oGrXfSe+7wgPWolPK1JonC3nuNj7/unsKL9g/Dm9CbsTDjW4MAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711253143;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=UPtf1koJU53DcwMEpBDvTKMZqc6f/Zbqhc3pS12IRFk=;
	b=vlHADMfgdNIYo71yRWxMskMLNZJkkGolbpSTXhgIP9y9oyGqLRyOxSxjBlFLoEcOZmOA3S
	sDiEyPP5QtjBVHCg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/build: Clean up arch/x86/tools/relocs.c a bit
Cc:
 Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171125314276.10875.15250850261642650560.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     17608373cf907afe97654998663cc2ab8070e90b
Gitweb:        https://git.kernel.org/tip/17608373cf907afe97654998663cc2ab8070e90b
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Sun, 24 Mar 2024 04:46:10 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 24 Mar 2024 05:01:35 +01:00

x86/build: Clean up arch/x86/tools/relocs.c a bit

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
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/tools/relocs.c | 362 +++++++++++++++++++--------------------
 1 file changed, 178 insertions(+), 184 deletions(-)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index e7a44a7..c101bed 100644
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

