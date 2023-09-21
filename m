Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED95A7A9D27
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjIUT3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjIUT2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:28:38 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9A9ADC63
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:04:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3175e1bb38cso265830f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695319471; x=1695924271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j6Pwn3by93Z9GDq57MINmnt8aTafU+8q1HtF6GDtpyE=;
        b=Jb9QPd6IVKgCbBUOBicLCkKCVJZj47tXIGLaijy3XQgKHZB9CfxCNLzgkgOGKJP4Tt
         CxqJ/DXy/sKT/3hWZtWF/uKZBugbIrPQoAADDAUsYwCZ8oS5yEhzHjaZ6ccHHlaxkjO9
         pzjn+GdPgBGOwgazLcKc0NbHEaemsHh6JVe5l3STfdFEmNn4LXdaryxX4h612dvgdmIS
         bq8TCRL1LLT1L8CpPli8oyP9j6DltmEps99u12MIYv3z/RNjhHGFDpcFq2UMlST4zPp7
         xSo29BKuzxD7nwJZI7sSzeRpsdj8mrfdQlmYoFlxYDer5bwF7+lC4sc6f7r07UF8MhfU
         bUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319471; x=1695924271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j6Pwn3by93Z9GDq57MINmnt8aTafU+8q1HtF6GDtpyE=;
        b=H/6d4g8DosjcvMp/xKDyic9y5UlCfhNWqfXt8ER5FgHq+J+UXPHTgx7Ndk5GsIJTr/
         ejuABhq0HFTDkr1OhW1NVYfsyZq5jK5nvb0VYjLbsjYhAbWGe4fUp07O+Zohpt2NFy1K
         HO9pcQiIi/bq4u/Y0LUv8Dfgkf3mVfCLvCbPyY5mUfrZSf3B9EwBcRY9klHN1WOeo0aY
         2cpkFkGl1F5AIDC3tpGDm1KRf0RvQCypR4uPbSLTh18UUEVH4wPaWZcOfNn7RHDFlKvn
         eqm7KMnEpjFG4fATLJ6ozzhDGi0ANDjLmYW0tbw/iOKKMBvJVqYlqMjX8ujZt4ep/1uB
         FFkQ==
X-Gm-Message-State: AOJu0YxVQtbt2MBhsoTvV1d4aTSMV+6XApYF0crIRwPGuZMbYFBV0Fy1
        f88C56meY22qRmWTta8WJjbmtXkBW2W5sMuSHqNAdw==
X-Google-Smtp-Source: AGHT+IEBIFRPkyDzHQ+D2KJkz18KzRNTaqV/8CZsW2pJNGAvO8T0fP0Rc50Y752EiUbJgZslkUV0uw==
X-Received: by 2002:a05:600c:1c08:b0:3fe:d637:7b25 with SMTP id j8-20020a05600c1c0800b003fed6377b25mr5052674wms.0.1695298059836;
        Thu, 21 Sep 2023 05:07:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:7398:c156:422c:6091? ([2a01:e0a:999:a3a0:7398:c156:422c:6091])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c240c00b003fc02e8ea68sm4642695wmp.13.2023.09.21.05.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 05:07:39 -0700 (PDT)
Message-ID: <4d1102d9-ebea-4cb2-a510-3a40be7a3cb6@rivosinc.com>
Date:   Thu, 21 Sep 2023 14:07:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] modpost: Optimize symbol search from linear to binary
 search
To:     Jack Brennen <jbrennen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, Palmer Dabbelt <palmer@rivosinc.com>
References: <20230918210631.3882376-1-jbrennen@google.com>
Content-Language: en-US
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20230918210631.3882376-1-jbrennen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jack,

On RISC-V builds, we noticed a recent slow down after commit
ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by modpost") was
introduced. We tracked it down to find_nearest_sym() being called a lot
and more specifically since we have a lot of local symbols that are
generated as part of PCREL accesses (even more when building in debug
mode, measured a count of 12964362 symbols in one vmlinux.o).

Without your changes, a typical riscv defconfig build + debug, modpost
took the following amount of time:

$ time scripts/mod/modpost -M -o Module.symvers -T modules.order vmlinux.o
real    4m21,976s
user    4m21,803s
sys     0m0,100s

With your changes:

$ time scripts/mod/modpost -M -o Module.symvers -T modules.order vmlinux.o
real    0m1,077s
user    0m0,980s
sys     0m0,095s

I guess you could further optimize it by allocating a binary tree for
each section since find_nearest_sym() searches for symbols in a specific
section, that would save a few comparisons. Not sure it will be way
faster nor simpler to implement though.

FWIW: Tested-by: Clément Léger <cleger@rivosinc.com>

Thanks,

Clément

On 18/09/2023 23:06, Jack Brennen wrote:
> Modify modpost to use binary search for converting addresses back
> into symbol references.  Previously it used linear search.
> 
> This change saves a few seconds of wall time for defconfig builds,
> but can save several minutes on allyesconfigs.
> 
> Before:
> $ make LLVM=1 -j128 allyesconfig vmlinux -s KCFLAGS="-Wno-error"
>         Elapsed (wall clock) time (h:mm:ss or m:ss): 13:30.31
> 
> After:
> $ make LLVM=1 -j128 allyesconfig vmlinux -s KCFLAGS="-Wno-error"
>         Elapsed (wall clock) time (h:mm:ss or m:ss): 11:43.43
> 
> Signed-off-by: Jack Brennen <jbrennen@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  scripts/mod/Makefile    |   4 +-
>  scripts/mod/modpost.c   |  60 +----------
>  scripts/mod/modpost.h   |  25 +++++
>  scripts/mod/symsearch.c | 233 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 265 insertions(+), 57 deletions(-)
>  create mode 100644 scripts/mod/symsearch.c
> 
> diff --git a/scripts/mod/Makefile b/scripts/mod/Makefile
> index c9e38ad937fd..3c54125eb373 100644
> --- a/scripts/mod/Makefile
> +++ b/scripts/mod/Makefile
> @@ -5,7 +5,7 @@ CFLAGS_REMOVE_empty.o += $(CC_FLAGS_LTO)
>  hostprogs-always-y	+= modpost mk_elfconfig
>  always-y		+= empty.o
>  
> -modpost-objs	:= modpost.o file2alias.o sumversion.o
> +modpost-objs	:= modpost.o file2alias.o sumversion.o symsearch.o
>  
>  devicetable-offsets-file := devicetable-offsets.h
>  
> @@ -16,7 +16,7 @@ targets += $(devicetable-offsets-file) devicetable-offsets.s
>  
>  # dependencies on generated files need to be listed explicitly
>  
> -$(obj)/modpost.o $(obj)/file2alias.o $(obj)/sumversion.o: $(obj)/elfconfig.h
> +$(obj)/modpost.o $(obj)/file2alias.o $(obj)/sumversion.o $(obj)/symsearch.o: $(obj)/elfconfig.h
>  $(obj)/file2alias.o: $(obj)/$(devicetable-offsets-file)
>  
>  quiet_cmd_elfconfig = MKELF   $@
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index de499dce5265..975f235aca2c 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -22,7 +22,6 @@
>  #include <errno.h>
>  #include "modpost.h"
>  #include "../../include/linux/license.h"
> -#include "../../include/linux/module_symbol.h"
>  
>  static bool module_enabled;
>  /* Are we using CONFIG_MODVERSIONS? */
> @@ -577,11 +576,14 @@ static int parse_elf(struct elf_info *info, const char *filename)
>  			*p = TO_NATIVE(*p);
>  	}
>  
> +	symsearch_init(info);
> +
>  	return 1;
>  }
>  
>  static void parse_elf_finish(struct elf_info *info)
>  {
> +	symsearch_finish(info);
>  	release_file(info->hdr, info->size);
>  }
>  
> @@ -1039,65 +1041,13 @@ static int secref_whitelist(const char *fromsec, const char *fromsym,
>  	return 1;
>  }
>  
> -/*
> - * If there's no name there, ignore it; likewise, ignore it if it's
> - * one of the magic symbols emitted used by current tools.
> - *
> - * Otherwise if find_symbols_between() returns those symbols, they'll
> - * fail the whitelist tests and cause lots of false alarms ... fixable
> - * only by merging __exit and __init sections into __text, bloating
> - * the kernel (which is especially evil on embedded platforms).
> - */
> -static inline int is_valid_name(struct elf_info *elf, Elf_Sym *sym)
> -{
> -	const char *name = elf->strtab + sym->st_name;
> -
> -	if (!name || !strlen(name))
> -		return 0;
> -	return !is_mapping_symbol(name);
> -}
> -
>  /* Look up the nearest symbol based on the section and the address */
>  static Elf_Sym *find_nearest_sym(struct elf_info *elf, Elf_Addr addr,
>  				 unsigned int secndx, bool allow_negative,
>  				 Elf_Addr min_distance)
>  {
> -	Elf_Sym *sym;
> -	Elf_Sym *near = NULL;
> -	Elf_Addr sym_addr, distance;
> -	bool is_arm = (elf->hdr->e_machine == EM_ARM);
> -
> -	for (sym = elf->symtab_start; sym < elf->symtab_stop; sym++) {
> -		if (get_secindex(elf, sym) != secndx)
> -			continue;
> -		if (!is_valid_name(elf, sym))
> -			continue;
> -
> -		sym_addr = sym->st_value;
> -
> -		/*
> -		 * For ARM Thumb instruction, the bit 0 of st_value is set
> -		 * if the symbol is STT_FUNC type. Mask it to get the address.
> -		 */
> -		if (is_arm && ELF_ST_TYPE(sym->st_info) == STT_FUNC)
> -			 sym_addr &= ~1;
> -
> -		if (addr >= sym_addr)
> -			distance = addr - sym_addr;
> -		else if (allow_negative)
> -			distance = sym_addr - addr;
> -		else
> -			continue;
> -
> -		if (distance <= min_distance) {
> -			min_distance = distance;
> -			near = sym;
> -		}
> -
> -		if (min_distance == 0)
> -			break;
> -	}
> -	return near;
> +	return symsearch_find_nearest(elf, addr, secndx,
> +				      allow_negative, min_distance);
>  }
>  
>  static Elf_Sym *find_fromsym(struct elf_info *elf, Elf_Addr addr,
> diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
> index 5f94c2c9f2d9..6413f26fcb6b 100644
> --- a/scripts/mod/modpost.h
> +++ b/scripts/mod/modpost.h
> @@ -10,6 +10,7 @@
>  #include <fcntl.h>
>  #include <unistd.h>
>  #include <elf.h>
> +#include "../../include/linux/module_symbol.h"
>  
>  #include "list.h"
>  #include "elfconfig.h"
> @@ -128,6 +129,8 @@ struct elf_info {
>  	 * take shndx from symtab_shndx_start[N] instead */
>  	Elf32_Word   *symtab_shndx_start;
>  	Elf32_Word   *symtab_shndx_stop;
> +
> +	struct symsearch *symsearch;
>  };
>  
>  /* Accessor for sym->st_shndx, hides ugliness of "64k sections" */
> @@ -154,6 +157,28 @@ static inline unsigned int get_secindex(const struct elf_info *info,
>  	return index;
>  }
>  
> +/*
> + * If there's no name there, ignore it; likewise, ignore it if it's
> + * one of the magic symbols emitted used by current tools.
> + *
> + * Internal symbols created by tools should be ignored by modpost.
> + */
> +static inline int is_valid_name(struct elf_info *elf, Elf_Sym *sym)
> +{
> +	const char *name = elf->strtab + sym->st_name;
> +
> +	if (!name || !strlen(name))
> +		return 0;
> +	return !is_mapping_symbol(name);
> +}
> +
> +/* symsearch.c */
> +void symsearch_init(struct elf_info *elf);
> +void symsearch_finish(struct elf_info *elf);
> +Elf_Sym *symsearch_find_nearest(struct elf_info *elf, Elf_Addr addr,
> +				unsigned int secndx, bool allow_negative,
> +				Elf_Addr min_distance);
> +
>  /* file2alias.c */
>  void handle_moddevtable(struct module *mod, struct elf_info *info,
>  			Elf_Sym *sym, const char *symname);
> diff --git a/scripts/mod/symsearch.c b/scripts/mod/symsearch.c
> new file mode 100644
> index 000000000000..aab79262512b
> --- /dev/null
> +++ b/scripts/mod/symsearch.c
> @@ -0,0 +1,233 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/* Helper functions for finding the symbol in an ELF which is "nearest"
> + * to a given address.
> + */
> +
> +#include "modpost.h"
> +
> +/* Struct used for binary search. */
> +struct syminfo {
> +	unsigned int symbol_index;
> +	unsigned int section_index;
> +	Elf_Addr addr;
> +};
> +
> +/* Container used to hold an entire binary search table.
> + * Entries in table are ascending, sorted first by section_index,
> + * then by addr, and last by symbol_index.  The sorting by
> + * symbol_index is used to duplicate the quirks of the prior
> + * find_nearest_sym() function, where exact matches to an address
> + * return the first symtab entry seen, but near misses return the
> + * last symtab entry seen.
> + * The first and last entries of the table are sentinels and their
> + * values only matter in two places:  when we sort the table, and
> + * on lookups, the end sentinel should not have an addr field which
> + * matches its immediate predecessor.  To meet these requirements,
> + * we initialize them to (0,0,0) and (max,max,max), and then after
> + * sorting, we tweak the end sentinel's addr field accordingly.
> + */
> +struct symsearch {
> +	size_t table_size;
> +	struct syminfo table[];
> +};
> +
> +static inline bool is_sym_searchable(struct elf_info *elf, Elf_Sym *sym)
> +{
> +	return is_valid_name(elf, sym) != 0;
> +}
> +
> +static int syminfo_compare(const void *s1, const void *s2)
> +{
> +	const struct syminfo *sym1 = s1;
> +	const struct syminfo *sym2 = s2;
> +
> +	if (sym1->section_index > sym2->section_index)
> +		return 1;
> +	if (sym1->section_index < sym2->section_index)
> +		return -1;
> +	if (sym1->addr > sym2->addr)
> +		return 1;
> +	if (sym1->addr < sym2->addr)
> +		return -1;
> +	if (sym1->symbol_index > sym2->symbol_index)
> +		return 1;
> +	if (sym1->symbol_index < sym2->symbol_index)
> +		return -1;
> +	return 0;
> +}
> +
> +static size_t symbol_count(struct elf_info *elf)
> +{
> +	size_t result = 0;
> +
> +	for (Elf_Sym *sym = elf->symtab_start; sym < elf->symtab_stop; sym++) {
> +		if (is_sym_searchable(elf, sym))
> +			result++;
> +	}
> +	return result;
> +}
> +
> +/* Populate the search array that we just allocated.
> + * Be slightly paranoid here.  If the ELF file changes during processing,
> + * or if the behavior of is_sym_searchable() changes during processing,
> + * we want to catch it; neither of those is acceptable.
> + */
> +static void symsearch_populate(struct elf_info *elf,
> +			       struct syminfo *table,
> +			       size_t table_size)
> +{
> +	bool is_arm = (elf->hdr->e_machine == EM_ARM);
> +
> +	/* Start sentinel */
> +	if (table_size-- == 0)
> +		fatal("%s: size mismatch\n", __func__);
> +	table->symbol_index = 0;
> +	table->section_index = 0;
> +	table->addr = 0;
> +	table++;
> +
> +	for (Elf_Sym *sym = elf->symtab_start; sym < elf->symtab_stop; sym++) {
> +		if (is_sym_searchable(elf, sym)) {
> +			if (table_size-- == 0)
> +				fatal("%s: size mismatch\n", __func__);
> +			table->symbol_index = sym - elf->symtab_start;
> +			table->section_index = get_secindex(elf, sym);
> +			table->addr = sym->st_value;
> +
> +			/*
> +			 * For ARM Thumb instruction, the bit 0 of st_value is
> +			 * set if the symbol is STT_FUNC type. Mask it to get
> +			 * the address.
> +			 */
> +			if (is_arm && ELF_ST_TYPE(sym->st_info) == STT_FUNC)
> +				table->addr &= ~1;
> +
> +			table++;
> +		}
> +	}
> +
> +	/* End sentinel; all values are unsigned so -1 wraps to max */
> +	if (table_size != 1)
> +		fatal("%s: size mismatch\n", __func__);
> +	table->symbol_index = -1;
> +	table->section_index = -1;
> +	table->addr = -1;
> +}
> +
> +void symsearch_init(struct elf_info *elf)
> +{
> +	/* +2 here to allocate space for the start and end sentinels */
> +	size_t table_size = symbol_count(elf) + 2;
> +
> +	elf->symsearch = NOFAIL(malloc(
> +					sizeof(struct symsearch) +
> +					sizeof(struct syminfo) * table_size));
> +	elf->symsearch->table_size = table_size;
> +
> +	symsearch_populate(elf, elf->symsearch->table, table_size);
> +	qsort(elf->symsearch->table, table_size,
> +	      sizeof(struct syminfo), syminfo_compare);
> +
> +	/* A bit of paranoia; make sure that the end sentinel's address is
> +	 * different than its predecessor.  Not doing this could cause
> +	 * possible undefined behavior if anybody ever inserts a symbol
> +	 * with section_index and addr both at their max values.
> +	 * Doing this little bit of defensive programming is more efficient
> +	 * than checking for array overruns later.
> +	 */
> +	elf->symsearch->table[table_size - 1].addr =
> +		elf->symsearch->table[table_size - 2].addr + 1;
> +}
> +
> +void symsearch_finish(struct elf_info *elf)
> +{
> +	free(elf->symsearch);
> +	elf->symsearch = NULL;
> +}
> +
> +/* Find the syminfo which is in secndx and "nearest" to addr.
> + * allow_negative: allow returning a symbol whose address is > addr.
> + * min_distance: ignore symbols which are further away than this.
> + *
> + * Returns a nonzero index into the symsearch table for success.
> + * Returns NULL if no legal symbol is found within the requested range.
> + */
> +static size_t symsearch_find_impl(struct elf_info *elf, Elf_Addr addr,
> +				  unsigned int secndx, bool allow_negative,
> +				  Elf_Addr min_distance)
> +{
> +	/* Find the target in the array; it will lie between two elements.
> +	 * Invariant here: table[lo] < target <= table[hi]
> +	 * For the purposes of search, exact hits in the search array are
> +	 * considered greater than the target.	This means that if we do
> +	 * get an exact hit, then once the search terminates, table[hi]
> +	 * will be the exact match which has the lowest symbol index.
> +	 */
> +	struct syminfo *table = elf->symsearch->table;
> +	size_t hi = elf->symsearch->table_size - 1;
> +	size_t lo = 0;
> +	bool hi_is_usable = false;
> +	bool lo_is_usable = false;
> +	Elf_Addr hi_distance = -1;  // max Elf_Addr
> +	Elf_Addr lo_distance = -1;  // max Elf_Addr
> +	Elf_Addr min_distance_lo = min_distance;
> +	Elf_Addr min_distance_hi = allow_negative ? min_distance : 0;
> +
> +	for (;;) {
> +		size_t mid;
> +
> +		mid = lo + (hi - lo) / 2;
> +		if (mid == lo)
> +			break;
> +		if (secndx > table[mid].section_index) {
> +			lo = mid;
> +		} else if (secndx < table[mid].section_index) {
> +			hi = mid;
> +		} else if (addr > table[mid].addr) {
> +			lo = mid;
> +			lo_distance = addr - table[mid].addr;
> +			lo_is_usable = (lo_distance <= min_distance_lo);
> +		} else {
> +			hi = mid;
> +			hi_distance = table[mid].addr - addr;
> +			hi_is_usable = (hi_distance <= min_distance_hi);
> +		}
> +	}
> +
> +	if (hi_is_usable && lo_is_usable) {
> +		lo_is_usable = (lo_distance <= hi_distance);
> +		hi_is_usable = (hi_distance <= lo_distance);
> +	}
> +
> +	if (!hi_is_usable)
> +		return lo_is_usable ? lo : 0;
> +
> +	if (hi_distance == 0)
> +		return hi;
> +
> +	/* Match quirks of existing behavior.  Advance hi to the last
> +	 * matching entry in the search table.	We don't need to worry
> +	 * about running off the end of the array due to the sentinel.
> +	 */
> +	while (table[hi+1].addr == table[hi].addr &&
> +	       table[hi+1].section_index == table[hi].section_index) {
> +		hi++;
> +	}
> +
> +	return (lo_is_usable &&
> +		table[lo].symbol_index > table[hi].symbol_index) ? lo : hi;
> +}
> +
> +Elf_Sym *symsearch_find_nearest(struct elf_info *elf, Elf_Addr addr,
> +				unsigned int secndx, bool allow_negative,
> +				Elf_Addr min_distance)
> +{
> +	size_t result = symsearch_find_impl(elf, addr, secndx,
> +					    allow_negative, min_distance);
> +
> +	if (result == 0)
> +		return NULL;
> +
> +	return &elf->symtab_start[elf->symsearch->table[result].symbol_index];
> +}
