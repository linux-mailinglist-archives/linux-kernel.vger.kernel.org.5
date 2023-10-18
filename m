Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC77B7CEB17
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 00:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjJRWTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 18:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjJRWTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 18:19:19 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D23C10F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:19:16 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d9a518d66a1so8558601276.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697667555; x=1698272355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uuqTvkZsLNcN0vKiW9poC4HMQijLLBM+uo+MZO5mhQQ=;
        b=RJWZIzijGamGWQiwXzB5iw71KQE94QVgsOfnxXQxlPZQWt586Vy2DxT8QgngdsUloV
         rHCcqnJsWPZr7EaDEi+g0w0yvLkJpCmfWJggsHPWz7IOM1OLMyhLPKhJqRbr26p21ef7
         Gtn+7ow7qXRSEu/rNJ0iTqYWdJH/EDftWwqZ/DHzThD+q75v7TFPS6Uh9JXm0dPLMt/Y
         Vu/PYnGYzNrC17ZN3QPWjlOy4wNiXaGiyC+X3+/Z/hCgdjMy1DwFbdp2V8YfpuT59ZS+
         ntHGL2PQm1iNCnMNBkN+yW1CVvKc3LdRoe22Gsgc4tfLNUse85dFjNMAHpNKmdSHbEaD
         znWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697667555; x=1698272355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuqTvkZsLNcN0vKiW9poC4HMQijLLBM+uo+MZO5mhQQ=;
        b=bqPMQi+Ux46e5EUCF64z/pGUjSofgtRFrf2XMiwcHLjFuQRtFw94RNCwQnTWr5YDXm
         H648KZKlV4/9RY3yoj0c+/uY/lM1eqi8jTADFAswWkrzKINc8Q6nl8ghSJrx9/0bgvm9
         2im5rvRH+2lkzLwlSyQbBPjM2G6M3HF5E2c1rJZN8ms7nP+HEsDek+iEjzNwDiJzXvaE
         syaiQhHHZlFiQkxqvK4Fz7FMRPA2ZH5LA36C88QpC4F2YX0n1rP5FddD5GGyv3J+B3d4
         Smq1N3re7K+nNHs5+/8G7SClYhdgxuLw0HGPdHuvj4RE6Po3YC0qL+/5EBRUKDp9lPpK
         XzEg==
X-Gm-Message-State: AOJu0YwLkFcoXGQANRstyqYYLojgkfavhdW5zhp1eTqxEVl2XGPWGQ+2
        nwhveFyzf9NzIfeYhoqyH9p/EC6Yu2vUepHy7/k=
X-Google-Smtp-Source: AGHT+IGH8wlsFfSwy2DzfGJ0wHx7SWl+MDQkarJ6/kvkpATpF9Tz7csQMF88Wxn4r1UQ/dZ1DeKpqQ==
X-Received: by 2002:a25:ef48:0:b0:d9b:4f28:4f7a with SMTP id w8-20020a25ef48000000b00d9b4f284f7amr705063ybm.55.1697667555486;
        Wed, 18 Oct 2023 15:19:15 -0700 (PDT)
Received: from ghost ([208.116.208.98])
        by smtp.gmail.com with ESMTPSA id bs40-20020a05620a472800b0077892023fc5sm278376qkb.120.2023.10.18.15.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 15:19:15 -0700 (PDT)
Date:   Wed, 18 Oct 2023 15:19:11 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] riscv: Add remaining module relocations
Message-ID: <ZTBZ3yzbBkYcxmBs@ghost>
References: <20231017-module_relocations-v4-0-937f5ef316f0@rivosinc.com>
 <20231017-module_relocations-v4-1-937f5ef316f0@rivosinc.com>
 <2fea6698-7446-443b-9026-c4b082a9f809@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fea6698-7446-443b-9026-c4b082a9f809@sifive.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 01:28:45PM -0500, Samuel Holland wrote:
> On 2023-10-18 12:34 AM, Charlie Jenkins wrote:
> > Add all final module relocations and add error logs explaining the ones
> > that are not supported.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/include/uapi/asm/elf.h |   5 +-
> >  arch/riscv/kernel/module.c        | 207 +++++++++++++++++++++++++++++++++-----
> >  2 files changed, 186 insertions(+), 26 deletions(-)
> > 
> > diff --git a/arch/riscv/include/uapi/asm/elf.h b/arch/riscv/include/uapi/asm/elf.h
> > index d696d6610231..11a71b8533d5 100644
> > --- a/arch/riscv/include/uapi/asm/elf.h
> > +++ b/arch/riscv/include/uapi/asm/elf.h
> > @@ -49,6 +49,7 @@ typedef union __riscv_fp_state elf_fpregset_t;
> >  #define R_RISCV_TLS_DTPREL64	9
> >  #define R_RISCV_TLS_TPREL32	10
> >  #define R_RISCV_TLS_TPREL64	11
> > +#define R_RISCV_IRELATIVE	58
> >  
> >  /* Relocation types not used by the dynamic linker */
> >  #define R_RISCV_BRANCH		16
> > @@ -81,7 +82,6 @@ typedef union __riscv_fp_state elf_fpregset_t;
> >  #define R_RISCV_ALIGN		43
> >  #define R_RISCV_RVC_BRANCH	44
> >  #define R_RISCV_RVC_JUMP	45
> > -#define R_RISCV_LUI		46
> >  #define R_RISCV_GPREL_I		47
> >  #define R_RISCV_GPREL_S		48
> >  #define R_RISCV_TPREL_I		49
> > @@ -93,6 +93,9 @@ typedef union __riscv_fp_state elf_fpregset_t;
> >  #define R_RISCV_SET16		55
> >  #define R_RISCV_SET32		56
> >  #define R_RISCV_32_PCREL	57
> > +#define R_RISCV_PLT32		59
> > +#define R_RISCV_SET_ULEB128	60
> > +#define R_RISCV_SUB_ULEB128	61
> >  
> >  
> >  #endif /* _UAPI_ASM_RISCV_ELF_H */
> > diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> > index 7c651d55fcbd..e860726352ac 100644
> > --- a/arch/riscv/kernel/module.c
> > +++ b/arch/riscv/kernel/module.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/elf.h>
> >  #include <linux/err.h>
> >  #include <linux/errno.h>
> > +#include <linux/kernel.h>
> >  #include <linux/moduleloader.h>
> >  #include <linux/vmalloc.h>
> >  #include <linux/sizes.h>
> > @@ -268,6 +269,12 @@ static int apply_r_riscv_align_rela(struct module *me, u32 *location,
> >  	return -EINVAL;
> >  }
> >  
> > +static int apply_r_riscv_add8_rela(struct module *me, u32 *location, Elf_Addr v)
> > +{
> > +	*(u8 *)location += (u8)v;
> > +	return 0;
> > +}
> > +
> >  static int apply_r_riscv_add16_rela(struct module *me, u32 *location,
> >  				    Elf_Addr v)
> >  {
> > @@ -289,6 +296,12 @@ static int apply_r_riscv_add64_rela(struct module *me, u32 *location,
> >  	return 0;
> >  }
> >  
> > +static int apply_r_riscv_sub8_rela(struct module *me, u32 *location, Elf_Addr v)
> > +{
> > +	*(u8 *)location -= (u8)v;
> > +	return 0;
> > +}
> > +
> >  static int apply_r_riscv_sub16_rela(struct module *me, u32 *location,
> >  				    Elf_Addr v)
> >  {
> > @@ -310,31 +323,149 @@ static int apply_r_riscv_sub64_rela(struct module *me, u32 *location,
> >  	return 0;
> >  }
> >  
> > -static int (*reloc_handlers_rela[]) (struct module *me, u32 *location,
> > -				Elf_Addr v) = {
> > -	[R_RISCV_32]			= apply_r_riscv_32_rela,
> > -	[R_RISCV_64]			= apply_r_riscv_64_rela,
> > -	[R_RISCV_BRANCH]		= apply_r_riscv_branch_rela,
> > -	[R_RISCV_JAL]			= apply_r_riscv_jal_rela,
> > -	[R_RISCV_RVC_BRANCH]		= apply_r_riscv_rvc_branch_rela,
> > -	[R_RISCV_RVC_JUMP]		= apply_r_riscv_rvc_jump_rela,
> > -	[R_RISCV_PCREL_HI20]		= apply_r_riscv_pcrel_hi20_rela,
> > -	[R_RISCV_PCREL_LO12_I]		= apply_r_riscv_pcrel_lo12_i_rela,
> > -	[R_RISCV_PCREL_LO12_S]		= apply_r_riscv_pcrel_lo12_s_rela,
> > -	[R_RISCV_HI20]			= apply_r_riscv_hi20_rela,
> > -	[R_RISCV_LO12_I]		= apply_r_riscv_lo12_i_rela,
> > -	[R_RISCV_LO12_S]		= apply_r_riscv_lo12_s_rela,
> > -	[R_RISCV_GOT_HI20]		= apply_r_riscv_got_hi20_rela,
> > -	[R_RISCV_CALL_PLT]		= apply_r_riscv_call_plt_rela,
> > -	[R_RISCV_CALL]			= apply_r_riscv_call_rela,
> > -	[R_RISCV_RELAX]			= apply_r_riscv_relax_rela,
> > -	[R_RISCV_ALIGN]			= apply_r_riscv_align_rela,
> > -	[R_RISCV_ADD16]			= apply_r_riscv_add16_rela,
> > -	[R_RISCV_ADD32]			= apply_r_riscv_add32_rela,
> > -	[R_RISCV_ADD64]			= apply_r_riscv_add64_rela,
> > -	[R_RISCV_SUB16]			= apply_r_riscv_sub16_rela,
> > -	[R_RISCV_SUB32]			= apply_r_riscv_sub32_rela,
> > -	[R_RISCV_SUB64]			= apply_r_riscv_sub64_rela,
> > +static int dynamic_linking_not_supported(struct module *me, u32 *location,
> > +					 Elf_Addr v)
> > +{
> > +	pr_err("%s: Dynamic linking not supported in kernel modules PC = %p\n",
> > +	       me->name, location);
> > +	return -EINVAL;
> > +}
> > +
> > +static int tls_not_supported(struct module *me, u32 *location, Elf_Addr v)
> > +{
> > +	pr_err("%s: Thread local storage not supported in kernel modules PC = %p\n",
> > +	       me->name, location);
> > +	return -EINVAL;
> > +}
> > +
> > +static int apply_r_riscv_sub6_rela(struct module *me, u32 *location, Elf_Addr v)
> > +{
> > +	*(u8 *)location = (*location - ((u8)v & 0x3F)) & 0x3F;
> > +	return 0;
> > +}
> > +
> > +static int apply_r_riscv_set6_rela(struct module *me, u32 *location, Elf_Addr v)
> > +{
> > +	*(u8 *)location = (*(u8 *)location & 0xc0) | ((u8)v & 0x3F);
> > +	return 0;
> > +}
> > +
> > +static int apply_r_riscv_set8_rela(struct module *me, u32 *location, Elf_Addr v)
> > +{
> > +	*(u8 *)location = (u8)v;
> > +	return 0;
> > +}
> > +
> > +static int apply_r_riscv_set16_rela(struct module *me, u32 *location,
> > +				    Elf_Addr v)
> > +{
> > +	*(u16 *)location = (u16)v;
> > +	return 0;
> > +}
> > +
> > +static int apply_r_riscv_set32_rela(struct module *me, u32 *location,
> > +				    Elf_Addr v)
> > +{
> > +	*(u32 *)location = (u32)v;
> 
> You don't need to cast the pointer, since it's already a `u32 *`.
> 
> > +	return 0;
> > +}
> > +
> > +static int apply_r_riscv_32_pcrel_rela(struct module *me, u32 *location,
> > +				       Elf_Addr v)
> > +{
> > +	*(u32 *)location = (u32)v;
> 
> This expression should be:
> 
>     *location = v - location;
> 
> matching the other PC-relative relocations.
> 
> (BTW, recent clang generates these relocations for module alternatives.)
> 
> > +	return 0;
> > +}
> > +
> > +static int apply_r_riscv_plt32_rela(struct module *me, u32 *location,
> > +				    Elf_Addr v)
> > +{
> > +	*(u32 *)location = (u32)v;
> 
> This should look like apply_r_riscv_32_pcrel_rela(), but with the PLT entry
> emission code from apply_r_riscv_call_plt_rela(). See the psABI commit[1].
> 
> [1]:
> https://github.com/riscv-non-isa/riscv-elf-psabi-doc/commit/c3f8269c56d8a2f56c2602f2a44175362024ef9c
> 

Thank you for pointing out these issues.

> > +	return 0;
> > +}
> > +
> > +static int apply_r_riscv_set_uleb128(struct module *me, u32 *location, Elf_Addr v)
> > +{
> > +	/*
> > +	 * Relocation is only performed if R_RISCV_SET_ULEB128 is followed by
> > +	 * R_RISCV_SUB_ULEB128 so do computation there
> > +	 */
> > +	return 0;
> > +}
> > +
> > +static int apply_r_riscv_sub_uleb128(struct module *me, u32 *location, Elf_Addr v)
> > +{
> > +	if (v >= 128) {
> > +		pr_err("%s: uleb128 must be in [0, 127] (not %ld) at PC = %p\n",
> > +		       me->name, (unsigned long)v, location);
> > +		return -EINVAL;
> > +	}
> > +
> > +	*location = v;
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Relocations defined in the riscv-elf-psabi-doc.
> > + * This handles static linking only.
> > + */
> > +static int (*reloc_handlers_rela[])(struct module *me, u32 *location,
> > +				    Elf_Addr v) = {
> > +	[R_RISCV_32] =			apply_r_riscv_32_rela,
> > +	[R_RISCV_64] =			apply_r_riscv_64_rela,
> > +	[R_RISCV_RELATIVE] =		dynamic_linking_not_supported,
> > +	[R_RISCV_COPY] =		dynamic_linking_not_supported,
> > +	[R_RISCV_JUMP_SLOT] =		dynamic_linking_not_supported,
> > +	[R_RISCV_TLS_DTPMOD32] =	dynamic_linking_not_supported,
> > +	[R_RISCV_TLS_DTPMOD64] =	dynamic_linking_not_supported,
> > +	[R_RISCV_TLS_DTPREL32] =	dynamic_linking_not_supported,
> > +	[R_RISCV_TLS_DTPREL64] =	dynamic_linking_not_supported,
> > +	[R_RISCV_TLS_TPREL32] =		dynamic_linking_not_supported,
> > +	[R_RISCV_TLS_TPREL64] =		dynamic_linking_not_supported,
> > +	/* 12-15 undefined */
> > +	[R_RISCV_BRANCH] =		apply_r_riscv_branch_rela,
> > +	[R_RISCV_JAL] =			apply_r_riscv_jal_rela,
> > +	[R_RISCV_CALL] =		apply_r_riscv_call_rela,
> > +	[R_RISCV_CALL_PLT] =		apply_r_riscv_call_plt_rela,
> > +	[R_RISCV_GOT_HI20] =		apply_r_riscv_got_hi20_rela,
> > +	[R_RISCV_TLS_GOT_HI20] =	tls_not_supported,
> > +	[R_RISCV_TLS_GD_HI20] =		tls_not_supported,
> > +	[R_RISCV_PCREL_HI20] =		apply_r_riscv_pcrel_hi20_rela,
> > +	[R_RISCV_PCREL_LO12_I] =	apply_r_riscv_pcrel_lo12_i_rela,
> > +	[R_RISCV_PCREL_LO12_S] =	apply_r_riscv_pcrel_lo12_s_rela,
> > +	[R_RISCV_HI20] =		apply_r_riscv_hi20_rela,
> > +	[R_RISCV_LO12_I] =		apply_r_riscv_lo12_i_rela,
> > +	[R_RISCV_LO12_S] =		apply_r_riscv_lo12_s_rela,
> > +	[R_RISCV_TPREL_HI20] =		tls_not_supported,
> > +	[R_RISCV_TPREL_LO12_I] =	tls_not_supported,
> > +	[R_RISCV_TPREL_LO12_S] =	tls_not_supported,
> > +	[R_RISCV_TPREL_ADD] =		tls_not_supported,
> > +	[R_RISCV_ADD8] =		apply_r_riscv_add8_rela,
> > +	[R_RISCV_ADD16] =		apply_r_riscv_add16_rela,
> > +	[R_RISCV_ADD32] =		apply_r_riscv_add32_rela,
> > +	[R_RISCV_ADD64] =		apply_r_riscv_add64_rela,
> > +	[R_RISCV_SUB8] =		apply_r_riscv_sub8_rela,
> > +	[R_RISCV_SUB16] =		apply_r_riscv_sub16_rela,
> > +	[R_RISCV_SUB32] =		apply_r_riscv_sub32_rela,
> > +	[R_RISCV_SUB64] =		apply_r_riscv_sub64_rela,
> > +	/* 41-42 reserved for future standard use */
> > +	[R_RISCV_ALIGN] =		apply_r_riscv_align_rela,
> > +	[R_RISCV_RVC_BRANCH] =		apply_r_riscv_rvc_branch_rela,
> > +	[R_RISCV_RVC_JUMP] =		apply_r_riscv_rvc_jump_rela,
> > +	/* 46-50 reserved for future standard use */
> > +	[R_RISCV_RELAX] =		apply_r_riscv_relax_rela,
> > +	[R_RISCV_SUB6] =		apply_r_riscv_sub6_rela,
> > +	[R_RISCV_SET6] =		apply_r_riscv_set6_rela,
> > +	[R_RISCV_SET8] =		apply_r_riscv_set8_rela,
> > +	[R_RISCV_SET16] =		apply_r_riscv_set16_rela,
> > +	[R_RISCV_SET32] =		apply_r_riscv_set32_rela,
> > +	[R_RISCV_32_PCREL] =		apply_r_riscv_32_pcrel_rela,
> > +	[R_RISCV_IRELATIVE] =		dynamic_linking_not_supported,
> > +	[R_RISCV_PLT32] =		apply_r_riscv_plt32_rela,
> > +	[R_RISCV_SET_ULEB128] =		apply_r_riscv_set_uleb128,
> > +	[R_RISCV_SUB_ULEB128] =		apply_r_riscv_sub_uleb128,
> > +	/* 62-191 reserved for future standard use */
> > +	/* 192-255 nonstandard ABI extensions  */
> >  };
> >  
> >  int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
> > @@ -348,6 +479,10 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
> >  	unsigned int i, type;
> >  	Elf_Addr v;
> >  	int res;
> > +	bool uleb128_set_exists = false;
> > +	u32 *uleb128_set_loc;
> > +	unsigned long uleb128_set_sym_val;
> > +
> 
> Extra blank line.
> 
> >  
> >  	pr_debug("Applying relocate section %u to %u\n", relsec,
> >  	       sechdrs[relsec].sh_info);
> > @@ -425,6 +560,28 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
> >  				  me->name);
> >  				return -EINVAL;
> >  			}
> > +		} else if (type == R_RISCV_SET_ULEB128) {
> > +			if (uleb128_set_exists) {
> > +				pr_err("%s: riscv psABI requires the next ULEB128 relocation to come after a R_RISCV_SET_ULEB128 is an R_RISCV_SUB_ULEB128, not another R_RISCV_SET_ULEB128.\n",
> > +				       me->name);
> > +				return -EINVAL;
> > +			}
> > +			uleb128_set_exists = true;
> > +			uleb128_set_loc = location;
> > +			uleb128_set_sym_val =
> > +				((Elf_Sym *)sechdrs[symindex].sh_addr +
> > +					ELF_RISCV_R_SYM(rel[i].r_info))
> > +					->st_value +
> > +				rel[i].r_addend;
> > +		} else if (type == R_RISCV_SUB_ULEB128) {
> > +			if (uleb128_set_exists && uleb128_set_loc == location) {
> > +				/* Calculate set and subtraction */
> > +				v = uleb128_set_sym_val - v;
> 
> You need to set uleb128_set_exists back to false somewhere, or you can only
> handle one R_RISCV_SET_ULEB128 relocation per module.
> 

I guess that never made it out of my thoughts and into the code...

- Charlie

> Regards,
> Samuel
> 
> > +			} else {
> > +				pr_err("%s: R_RISCV_SUB_ULEB128 must always be paired with the first R_RISCV_SET_ULEB128 that comes before it. PC = %p\n",
> > +				       me->name, location);
> > +				return -EINVAL;
> > +			}
> >  		}
> >  
> >  		res = handler(me, location, v);
> > 
> 
