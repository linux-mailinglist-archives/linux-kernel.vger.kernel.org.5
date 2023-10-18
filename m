Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBF17CE8EB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjJRU34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbjJRU3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:29:36 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D30413D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:29:03 -0700 (PDT)
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 73C643F697
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 20:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697660940;
        bh=Yk6MXkIPUgxpsJ5kIJxp6djW0jucI4oJfrO+nT8SMO4=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=iD56LVus6zu0v5OVZVVQvaSQGI/6e3hYPXPonpGWH4yAWdSNu5Pucr6C5IjxjOr2s
         caGnbxAg8ecskfqWMW0anBE/x0IvEH6pw1imFwqsWiQ0hquh/EgeVaHfPaOFgCCITH
         cun6UE06T8FvdIhe1xMr9SzERNYbZZmV8McHVdxli//x9JYGhQ9hL5TjYW3kB67OEb
         60bbgzjeJNKElcINkIFL8nNQMd1Uzd5N8ldH391YQenNpHtGCkDFdmljK/JbcyRabK
         24sBUujj+9RhZUImHiXKeGbKgXyB7G+/Pocmg4GGaIqgV0wcWPvEc1YsDO3m/wkJx9
         WGTu5DI6xt72w==
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-41b83b8dbe1so23983081cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697660939; x=1698265739;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yk6MXkIPUgxpsJ5kIJxp6djW0jucI4oJfrO+nT8SMO4=;
        b=ElUvdRDqUeqXjCNpxVdVZyz+0WzDIzgVnyUy2wopMOUcs7Ypja+keqIhnuT95KwWdk
         jOZ2P9JLcUSBdhTd2YWAkST0T1daqIVFQISJkMrurQkuPdDlzM+Uy8JdGxU9mVrrqzi8
         I65jncOXWzMVD1LjmLfDOxaa0myXjqymWhaisLcjgSmWldPvN4nBnw6PHwQ3Swz/Smhi
         ZAxSQ0tMlX8e5X3vF9skuMdjOkylgpAvG2COrkH6dxZy7HapqfY8KEOCw8TGJhHU+fNx
         8wt7Y8rkgS2I+xXe9eY8M0y1ClKaHdknhA2assHfY3dS/YXpdQ3QDMJHyu0gQsQoTQny
         a4+A==
X-Gm-Message-State: AOJu0Yy0yHSGnc3MyAJkcOIZWshHDmBO15mw//QdDjQBFmYgXDzWuMsT
        uu9hiK/h66xQcYmNOdzmLH0PPNeO+Rm3w1tKBocgUOxuOklLxhYsBbWpT3/l9FDaPLEEwA0pd+u
        zt/lzT3R4uyMr7fToWkRL89jaSLp2Dl9fDdscmIAgNkgVGvvzkOrGPXKZgw==
X-Received: by 2002:ac8:5c91:0:b0:418:1a99:3918 with SMTP id r17-20020ac85c91000000b004181a993918mr453760qta.6.1697660939411;
        Wed, 18 Oct 2023 13:28:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa9lkBDDI7SVR+Bl3OqPuNw6QMUQszI0XhfSaacQVkvysEVz0YUjgDwP4eZawXQ7MRpIZZYDJyVjlUQ8N9HxU=
X-Received: by 2002:ac8:5c91:0:b0:418:1a99:3918 with SMTP id
 r17-20020ac85c91000000b004181a993918mr453740qta.6.1697660939077; Wed, 18 Oct
 2023 13:28:59 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 18 Oct 2023 13:28:58 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <ZTA948rCoTQ2aNx6@ghost>
References: <20231017-module_relocations-v4-0-937f5ef316f0@rivosinc.com>
 <20231017-module_relocations-v4-1-937f5ef316f0@rivosinc.com>
 <CAJM55Z9xgyJoCX83hgwerF6SRo6yit8=0rmLzhF8Ju4TmZq3BA@mail.gmail.com>
 <ZTAkZAm21O3gtA7i@ghost> <CAJM55Z_Myd-ifrmQebO3V+GXTU70e105O7D7+hu4T7CazpdJsg@mail.gmail.com>
 <ZTA948rCoTQ2aNx6@ghost>
Mime-Version: 1.0
Date:   Wed, 18 Oct 2023 13:28:58 -0700
Message-ID: <CAJM55Z9zb_pOQyJcj=GcamyU3V-iqxMmOkOGRpD7a6mqszLpuQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] riscv: Add remaining module relocations
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Charlie Jenkins wrote:
> On Wed, Oct 18, 2023 at 11:38:39AM -0700, Emil Renner Berthing wrote:
> > Charlie Jenkins wrote:
> > > On Wed, Oct 18, 2023 at 05:17:44AM -0700, Emil Renner Berthing wrote:
> > > > Charlie Jenkins wrote:
> > > > > Add all final module relocations and add error logs explaining the ones
> > > > > that are not supported.
> > > > >
> > > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > > > ---
> > > > >  arch/riscv/include/uapi/asm/elf.h |   5 +-
> > > > >  arch/riscv/kernel/module.c        | 207 +++++++++++++++++++++++++++++++++-----
> > > > >  2 files changed, 186 insertions(+), 26 deletions(-)
> > > > >
> > > > > diff --git a/arch/riscv/include/uapi/asm/elf.h b/arch/riscv/include/uapi/asm/elf.h
> > > > > index d696d6610231..11a71b8533d5 100644
> > > > > --- a/arch/riscv/include/uapi/asm/elf.h
> > > > > +++ b/arch/riscv/include/uapi/asm/elf.h
> > > > > @@ -49,6 +49,7 @@ typedef union __riscv_fp_state elf_fpregset_t;
> > > > >  #define R_RISCV_TLS_DTPREL64	9
> > > > >  #define R_RISCV_TLS_TPREL32	10
> > > > >  #define R_RISCV_TLS_TPREL64	11
> > > > > +#define R_RISCV_IRELATIVE	58
> > > > >
> > > > >  /* Relocation types not used by the dynamic linker */
> > > > >  #define R_RISCV_BRANCH		16
> > > > > @@ -81,7 +82,6 @@ typedef union __riscv_fp_state elf_fpregset_t;
> > > > >  #define R_RISCV_ALIGN		43
> > > > >  #define R_RISCV_RVC_BRANCH	44
> > > > >  #define R_RISCV_RVC_JUMP	45
> > > > > -#define R_RISCV_LUI		46
> > > > >  #define R_RISCV_GPREL_I		47
> > > > >  #define R_RISCV_GPREL_S		48
> > > > >  #define R_RISCV_TPREL_I		49
> > > > > @@ -93,6 +93,9 @@ typedef union __riscv_fp_state elf_fpregset_t;
> > > > >  #define R_RISCV_SET16		55
> > > > >  #define R_RISCV_SET32		56
> > > > >  #define R_RISCV_32_PCREL	57
> > > > > +#define R_RISCV_PLT32		59
> > > > > +#define R_RISCV_SET_ULEB128	60
> > > > > +#define R_RISCV_SUB_ULEB128	61
> > > > >
> > > > >
> > > > >  #endif /* _UAPI_ASM_RISCV_ELF_H */
> > > > > diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> > > > > index 7c651d55fcbd..e860726352ac 100644
> > > > > --- a/arch/riscv/kernel/module.c
> > > > > +++ b/arch/riscv/kernel/module.c
> > > > > @@ -7,6 +7,7 @@
> > > > >  #include <linux/elf.h>
> > > > >  #include <linux/err.h>
> > > > >  #include <linux/errno.h>
> > > > > +#include <linux/kernel.h>
> > > > >  #include <linux/moduleloader.h>
> > > > >  #include <linux/vmalloc.h>
> > > > >  #include <linux/sizes.h>
> > > > > @@ -268,6 +269,12 @@ static int apply_r_riscv_align_rela(struct module *me, u32 *location,
> > > > >  	return -EINVAL;
> > > > >  }
> > > > >
> > > > > +static int apply_r_riscv_add8_rela(struct module *me, u32 *location, Elf_Addr v)
> > > > > +{
> > > > > +	*(u8 *)location += (u8)v;
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > >  static int apply_r_riscv_add16_rela(struct module *me, u32 *location,
> > > > >  				    Elf_Addr v)
> > > > >  {
> > > > > @@ -289,6 +296,12 @@ static int apply_r_riscv_add64_rela(struct module *me, u32 *location,
> > > > >  	return 0;
> > > > >  }
> > > > >
> > > > > +static int apply_r_riscv_sub8_rela(struct module *me, u32 *location, Elf_Addr v)
> > > > > +{
> > > > > +	*(u8 *)location -= (u8)v;
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > >  static int apply_r_riscv_sub16_rela(struct module *me, u32 *location,
> > > > >  				    Elf_Addr v)
> > > > >  {
> > > > > @@ -310,31 +323,149 @@ static int apply_r_riscv_sub64_rela(struct module *me, u32 *location,
> > > > >  	return 0;
> > > > >  }
> > > > >
> > > > > -static int (*reloc_handlers_rela[]) (struct module *me, u32 *location,
> > > > > -				Elf_Addr v) = {
> > > > > -	[R_RISCV_32]			= apply_r_riscv_32_rela,
> > > > > -	[R_RISCV_64]			= apply_r_riscv_64_rela,
> > > > > -	[R_RISCV_BRANCH]		= apply_r_riscv_branch_rela,
> > > > > -	[R_RISCV_JAL]			= apply_r_riscv_jal_rela,
> > > > > -	[R_RISCV_RVC_BRANCH]		= apply_r_riscv_rvc_branch_rela,
> > > > > -	[R_RISCV_RVC_JUMP]		= apply_r_riscv_rvc_jump_rela,
> > > > > -	[R_RISCV_PCREL_HI20]		= apply_r_riscv_pcrel_hi20_rela,
> > > > > -	[R_RISCV_PCREL_LO12_I]		= apply_r_riscv_pcrel_lo12_i_rela,
> > > > > -	[R_RISCV_PCREL_LO12_S]		= apply_r_riscv_pcrel_lo12_s_rela,
> > > > > -	[R_RISCV_HI20]			= apply_r_riscv_hi20_rela,
> > > > > -	[R_RISCV_LO12_I]		= apply_r_riscv_lo12_i_rela,
> > > > > -	[R_RISCV_LO12_S]		= apply_r_riscv_lo12_s_rela,
> > > > > -	[R_RISCV_GOT_HI20]		= apply_r_riscv_got_hi20_rela,
> > > > > -	[R_RISCV_CALL_PLT]		= apply_r_riscv_call_plt_rela,
> > > > > -	[R_RISCV_CALL]			= apply_r_riscv_call_rela,
> > > > > -	[R_RISCV_RELAX]			= apply_r_riscv_relax_rela,
> > > > > -	[R_RISCV_ALIGN]			= apply_r_riscv_align_rela,
> > > > > -	[R_RISCV_ADD16]			= apply_r_riscv_add16_rela,
> > > > > -	[R_RISCV_ADD32]			= apply_r_riscv_add32_rela,
> > > > > -	[R_RISCV_ADD64]			= apply_r_riscv_add64_rela,
> > > > > -	[R_RISCV_SUB16]			= apply_r_riscv_sub16_rela,
> > > > > -	[R_RISCV_SUB32]			= apply_r_riscv_sub32_rela,
> > > > > -	[R_RISCV_SUB64]			= apply_r_riscv_sub64_rela,
> > > > > +static int dynamic_linking_not_supported(struct module *me, u32 *location,
> > > > > +					 Elf_Addr v)
> > > > > +{
> > > > > +	pr_err("%s: Dynamic linking not supported in kernel modules PC = %p\n",
> > > > > +	       me->name, location);
> > > > > +	return -EINVAL;
> > > > > +}
> > > > > +
> > > > > +static int tls_not_supported(struct module *me, u32 *location, Elf_Addr v)
> > > > > +{
> > > > > +	pr_err("%s: Thread local storage not supported in kernel modules PC = %p\n",
> > > > > +	       me->name, location);
> > > > > +	return -EINVAL;
> > > > > +}
> > > > > +
> > > > > +static int apply_r_riscv_sub6_rela(struct module *me, u32 *location, Elf_Addr v)
> > > > > +{
> > > > > +	*(u8 *)location = (*location - ((u8)v & 0x3F)) & 0x3F;
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int apply_r_riscv_set6_rela(struct module *me, u32 *location, Elf_Addr v)
> > > > > +{
> > > > > +	*(u8 *)location = (*(u8 *)location & 0xc0) | ((u8)v & 0x3F);
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int apply_r_riscv_set8_rela(struct module *me, u32 *location, Elf_Addr v)
> > > > > +{
> > > > > +	*(u8 *)location = (u8)v;
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int apply_r_riscv_set16_rela(struct module *me, u32 *location,
> > > > > +				    Elf_Addr v)
> > > > > +{
> > > > > +	*(u16 *)location = (u16)v;
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int apply_r_riscv_set32_rela(struct module *me, u32 *location,
> > > > > +				    Elf_Addr v)
> > > > > +{
> > > > > +	*(u32 *)location = (u32)v;
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int apply_r_riscv_32_pcrel_rela(struct module *me, u32 *location,
> > > > > +				       Elf_Addr v)
> > > > > +{
> > > > > +	*(u32 *)location = (u32)v;
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int apply_r_riscv_plt32_rela(struct module *me, u32 *location,
> > > > > +				    Elf_Addr v)
> > > > > +{
> > > > > +	*(u32 *)location = (u32)v;
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int apply_r_riscv_set_uleb128(struct module *me, u32 *location, Elf_Addr v)
> > > > > +{
> > > > > +	/*
> > > > > +	 * Relocation is only performed if R_RISCV_SET_ULEB128 is followed by
> > > > > +	 * R_RISCV_SUB_ULEB128 so do computation there
> > > > > +	 */
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int apply_r_riscv_sub_uleb128(struct module *me, u32 *location, Elf_Addr v)
> > > > > +{
> > > > > +	if (v >= 128) {
> > > > > +		pr_err("%s: uleb128 must be in [0, 127] (not %ld) at PC = %p\n",
> > > > > +		       me->name, (unsigned long)v, location);
> > > > > +		return -EINVAL;
> > > > > +	}
> > > > > +
> > > > > +	*location = v;
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +/*
> > > > > + * Relocations defined in the riscv-elf-psabi-doc.
> > > > > + * This handles static linking only.
> > > > > + */
> > > > > +static int (*reloc_handlers_rela[])(struct module *me, u32 *location,
> > > > > +				    Elf_Addr v) = {
> > > > > +	[R_RISCV_32] =			apply_r_riscv_32_rela,
> > > > > +	[R_RISCV_64] =			apply_r_riscv_64_rela,
> > > > > +	[R_RISCV_RELATIVE] =		dynamic_linking_not_supported,
> > > > > +	[R_RISCV_COPY] =		dynamic_linking_not_supported,
> > > > > +	[R_RISCV_JUMP_SLOT] =		dynamic_linking_not_supported,
> > > > > +	[R_RISCV_TLS_DTPMOD32] =	dynamic_linking_not_supported,
> > > > > +	[R_RISCV_TLS_DTPMOD64] =	dynamic_linking_not_supported,
> > > > > +	[R_RISCV_TLS_DTPREL32] =	dynamic_linking_not_supported,
> > > > > +	[R_RISCV_TLS_DTPREL64] =	dynamic_linking_not_supported,
> > > > > +	[R_RISCV_TLS_TPREL32] =		dynamic_linking_not_supported,
> > > > > +	[R_RISCV_TLS_TPREL64] =		dynamic_linking_not_supported,
> > > > > +	/* 12-15 undefined */
> > > > > +	[R_RISCV_BRANCH] =		apply_r_riscv_branch_rela,
> > > > > +	[R_RISCV_JAL] =			apply_r_riscv_jal_rela,
> > > > > +	[R_RISCV_CALL] =		apply_r_riscv_call_rela,
> > > > > +	[R_RISCV_CALL_PLT] =		apply_r_riscv_call_plt_rela,
> > > > > +	[R_RISCV_GOT_HI20] =		apply_r_riscv_got_hi20_rela,
> > > > > +	[R_RISCV_TLS_GOT_HI20] =	tls_not_supported,
> > > > > +	[R_RISCV_TLS_GD_HI20] =		tls_not_supported,
> > > > > +	[R_RISCV_PCREL_HI20] =		apply_r_riscv_pcrel_hi20_rela,
> > > > > +	[R_RISCV_PCREL_LO12_I] =	apply_r_riscv_pcrel_lo12_i_rela,
> > > > > +	[R_RISCV_PCREL_LO12_S] =	apply_r_riscv_pcrel_lo12_s_rela,
> > > > > +	[R_RISCV_HI20] =		apply_r_riscv_hi20_rela,
> > > > > +	[R_RISCV_LO12_I] =		apply_r_riscv_lo12_i_rela,
> > > > > +	[R_RISCV_LO12_S] =		apply_r_riscv_lo12_s_rela,
> > > > > +	[R_RISCV_TPREL_HI20] =		tls_not_supported,
> > > > > +	[R_RISCV_TPREL_LO12_I] =	tls_not_supported,
> > > > > +	[R_RISCV_TPREL_LO12_S] =	tls_not_supported,
> > > > > +	[R_RISCV_TPREL_ADD] =		tls_not_supported,
> > > > > +	[R_RISCV_ADD8] =		apply_r_riscv_add8_rela,
> > > > > +	[R_RISCV_ADD16] =		apply_r_riscv_add16_rela,
> > > > > +	[R_RISCV_ADD32] =		apply_r_riscv_add32_rela,
> > > > > +	[R_RISCV_ADD64] =		apply_r_riscv_add64_rela,
> > > > > +	[R_RISCV_SUB8] =		apply_r_riscv_sub8_rela,
> > > > > +	[R_RISCV_SUB16] =		apply_r_riscv_sub16_rela,
> > > > > +	[R_RISCV_SUB32] =		apply_r_riscv_sub32_rela,
> > > > > +	[R_RISCV_SUB64] =		apply_r_riscv_sub64_rela,
> > > > > +	/* 41-42 reserved for future standard use */
> > > > > +	[R_RISCV_ALIGN] =		apply_r_riscv_align_rela,
> > > > > +	[R_RISCV_RVC_BRANCH] =		apply_r_riscv_rvc_branch_rela,
> > > > > +	[R_RISCV_RVC_JUMP] =		apply_r_riscv_rvc_jump_rela,
> > > > > +	/* 46-50 reserved for future standard use */
> > > > > +	[R_RISCV_RELAX] =		apply_r_riscv_relax_rela,
> > > > > +	[R_RISCV_SUB6] =		apply_r_riscv_sub6_rela,
> > > > > +	[R_RISCV_SET6] =		apply_r_riscv_set6_rela,
> > > > > +	[R_RISCV_SET8] =		apply_r_riscv_set8_rela,
> > > > > +	[R_RISCV_SET16] =		apply_r_riscv_set16_rela,
> > > > > +	[R_RISCV_SET32] =		apply_r_riscv_set32_rela,
> > > > > +	[R_RISCV_32_PCREL] =		apply_r_riscv_32_pcrel_rela,
> > > > > +	[R_RISCV_IRELATIVE] =		dynamic_linking_not_supported,
> > > > > +	[R_RISCV_PLT32] =		apply_r_riscv_plt32_rela,
> > > > > +	[R_RISCV_SET_ULEB128] =		apply_r_riscv_set_uleb128,
> > > > > +	[R_RISCV_SUB_ULEB128] =		apply_r_riscv_sub_uleb128,
> > > > > +	/* 62-191 reserved for future standard use */
> > > > > +	/* 192-255 nonstandard ABI extensions  */
> > > > >  };
> > > >
> > > > Hi Charlie,
> > > >
> > > > This is not a critique of this patch, but all these callbacks take a
> > > > u32 *location and
> > > > because of the compressed instructions this pointer may not be
> > > > aligned, so a lot of
> > > > the callbacks end up doing unaligned access which may fault to an
> > > > M-mode handler on
> > > > some platforms.
> > > >
> > > > I once sent a patch to fix this:
> > > > https://lore.kernel.org/linux-riscv/20220224152456.493365-2-kernel@esmil.dk/
> > > >
> > > > Maybe that's something you want to look into while touching this code anyway.
> > > >
> > > > /Emil
> > >
> > > Oh nice, I will pick up that patch and change the "native-endian"
> > > wording to be "little-endian" in the commit.
> >
> > Great, thanks. You'll probably also want the reads to be wrapped in
> > le16_to_cpu() and similar when writing now that it's decided that the parcels
> > are always in little-endian byteorder.
> >
> > /Emil
>
> I believe that le16_to_cpu() is only needed when instructions are being modified, and
> the relocations that only touch data can be left alone. Is this correct?

Yes, that sounds right to me. I only meant in the riscv_insn_rmw() function of
my patch and the callbacks modifying a compressed instruction, but I haven't
gone through all the other reloc types to check if they have a set endianess.

/Emil
