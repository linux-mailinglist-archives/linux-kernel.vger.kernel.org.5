Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD360752184
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbjGMMqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbjGMMqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:46:10 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99942700
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:46:00 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99364ae9596so102734066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1689252359; x=1691844359;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+EZO6Jnw8j7zUQccmE0/fnfg5lwRrVGqsp9XYuFgm/U=;
        b=WFOKjESB8wdmjdbQ3HT5s60YvJMKkHvvaPuSExmdAbUSdwCstnV2psygDqhPrGK4a2
         WlaRowldu4HLZQSwQJF2sdisBOBEFVb6eqCrihudNsNnn+6yKpemGby+Xr56/TZo9WuU
         kMTqSYvYvtWlSLni8JoMcfg/d6sytcKu0UQ9V2ecoH5/9RQEaKSGMeIZYM7rkTcL1FxI
         AAyim2RFVNryCtnViKEYqZxkQzCm2duu1MCrwJxEQq3XxwP79dR/1X2utWB1qABHVWmy
         UjaLkkixIVH2aN1CJ139PF76D+MjOju/7Zt2WeKIIAtS+vy8R6OafOiBgxyufrsEcwEO
         8p6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689252359; x=1691844359;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+EZO6Jnw8j7zUQccmE0/fnfg5lwRrVGqsp9XYuFgm/U=;
        b=A2u11pIZG1KqbX3Y6aUGbPGnFCmIk1MkLECbuxTZ9FeQOHv8eESgDc2Le7DdmSwOUX
         jfouT1Z8lHDxrBcUNwSMWlz5ciL9DykZhM/hQoFJDxbK+CSVHevZO+Wolq6XgXd6bEfQ
         uSsy10qLNPcE7H5kJiV7EjsIK4bh7eRuVtUPzX3Xgjaz77pFufC4a3KVhO7SqZaDVZRd
         liH/eZQGrxfTHtnxE++nrFytHCQD91ExcrI2vlse/xSdITPDsn/f5E+dkNfIsOPOIGjP
         oWoGxDX7qHMZcTdJBeXVLb3uFWSJwguqMVSRm3OB9DkJThp9mhepeGSCotfl1p5ksJW7
         SRBg==
X-Gm-Message-State: ABy/qLbcvcN5wdPNleFi1Yvc/g8DweQv9NJGDCXAzTrt49HJNpj+AwiI
        IrOrRZJZhFBa0WdUDchUFIvhig==
X-Google-Smtp-Source: APBJJlGXPJIZX4/ksP8kKyrFld9z9m00hbugQ86EU54ijoO2HHRlSthfP5YF32pkB7b6uLMpycQ/Lg==
X-Received: by 2002:a17:906:cf8e:b0:992:566b:7d57 with SMTP id um14-20020a170906cf8e00b00992566b7d57mr1188523ejb.61.1689252358542;
        Thu, 13 Jul 2023 05:45:58 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id rl6-20020a170907216600b009937dbabbdasm3900308ejb.217.2023.07.13.05.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 05:45:58 -0700 (PDT)
Date:   Thu, 13 Jul 2023 14:45:57 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Evan Green <evan@rivosinc.com>, Samuel Ortiz <sameo@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        "Hongren (Zenithal) Zheng" <i@zenithal.me>, linux@rivosinc.com,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        devicetree@vger.kernel.org, sorear@fastmail.com,
        Jiatai He <jiatai2021@iscas.ac.cn>
Subject: Re: [PATCH v4 1/4] RISC-V: Add Bitmanip/Scalar Crypto parsing from DT
Message-ID: <20230713-692c967c7a08c15dacbcab10@orel>
References: <20230712084134.1648008-1-sameo@rivosinc.com>
 <20230712084134.1648008-2-sameo@rivosinc.com>
 <20230712-bulldozer-affected-199042dc3afd@wendy>
 <CALs-HsuxxVcwX=mSwktPiEiAFkfK+5qJ6zg1Bzf2t37L=pZWjw@mail.gmail.com>
 <20230713-3f574332a06678f908cee21e@orel>
 <20230713-aggregate-uncut-e16ee9270b14@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230713-aggregate-uncut-e16ee9270b14@wendy>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 12:27:24PM +0100, Conor Dooley wrote:
> On Thu, Jul 13, 2023 at 10:46:14AM +0200, Andrew Jones wrote:
> > On Wed, Jul 12, 2023 at 10:43:33AM -0700, Evan Green wrote:
> > > On Wed, Jul 12, 2023 at 3:39 AM Conor Dooley <conor.dooley@microchip.com> wrote:
> > > > On Wed, Jul 12, 2023 at 10:41:17AM +0200, Samuel Ortiz wrote:
> > > > > From: "Hongren (Zenithal) Zheng" <i@zenithal.me>
> > > > >
> > > > > Parse Zb/Zk related string from DT and output them to cpuinfo.
> > > >
> > > > One thing that has sprung to mind is that this is not limited to DT
> > > > anymore, since the information could in theory come from ACPI too.
> > > > Ditto the title I guess.
> > > >
> > > > > It is worth noting that the Scalar Crypto extension defines "zk" as a
> > > > > shorthand for the Zkn, Zkr and Zkt extensions. Since the Zkn one also
> > > > > implies the Zbkb, Zbkc and Zbkx extensions, simply passing the valid
> > > > > "zk" extension name through a DT will enable all of the  Zbkb, Zbkc,
> > > > > Zbkx, Zkn, Zkr and Zkt extensions.
> > > > >
> > > > > Also, since there currently is no mechanism to merge all enabled
> > > > > extensions, the generated cpuinfo output could be relatively large.
> > > > > For example, setting the "riscv,isa" DT property to "rv64imafdc_zk_zks"
> > > > > will generate the following cpuinfo output:
> > > > > "rv64imafdc_zbkb_zbkc_zbkx_zknd_zkne_zknh_zkr_zksed_zksh_zkt".
> > > >
> > > > On that note, I've created another version of what checking for
> > > > supersets could look like, since it'll be needed either by my series or
> > > > this one, depending on what gets merged first. I've yet to test the
> > > > dedicated extensions part of it, but I wanted to get this out before I
> > > > went looking at other fixes in the area.
> > > >
> > > > Evan, since it was you that commented on this stuff last time around,
> > > > could you take another look? I'm still not keen on the "subset_of"
> > > > arrays, but they're an improvement on what I had last time around for
> > > > sure.
> > > >
> > > 
> > > This looks alright to me. At the risk of getting into bikeshedding
> > > territory, the only awkward bit of it is it composes the extensions in
> > > sort of the opposite way you'd expect. I tend to think of Zks as being
> > > comprised of {zbkb, zbkc, zksed, zksh},
> > 
> > This is also the way I think of it, so, FWIW, I prefer the approach below,
> > where bundles are expanded.
> 
> I took the patch Evan sent me off-list & have spun it into a "real"
> patch. I did some minor changes (c99 loop, __init marking) to match what
> the code was already doing and expanded it to work for the new property
> stuff.
> I'm not sure that match_isa_ext() needs to be a function, given the
> single user - it might be better refactored to drop the outer if & return
> whether a match was found.
> If done that would allow sharing the same function between isa string and
> dedicated property parsing. I left it intact for now. Might also be
> worth adding kerneldoc for that struct.
> 
> -- >8 --
> From 8300b98e487e57d192bc9581c6a3639c40c52623 Mon Sep 17 00:00:00 2001
> From: Evan Green <evan@rivosinc.com>
> Date: Wed, 12 Jul 2023 10:36:15 -0700
> Subject: [PATCH] RISC-V: Add support Scalar Crypto using "bundled extensions"
> 
> The Scalar Crypto specification defines Zk as a shorthand for the
> Zkn, Zkr and Zkt extensions. The same follows for both Zkn, Zks and Zbk,
> which are all shorthands for various other extensions. The detailed
> breakdown can be found in their dt-binding entries.
> 
> Since Zkn also implies the Zbkb, Zbkc and Zbkx extensions, simply passing
> "zk" through a DT should enable all of Zbkb, Zbkc, Zbkx, Zkn, Zkr and Zkt.
> For example, setting the "riscv,isa" DT property to "rv64imafdc_zk"
> should generate the following cpuinfo output:
> "rv64imafdc_zicntr_zicsr_zifencei_zihpm_zbkb_zbkc_zbkx_zknd_zkne_zknh_zkr_zkt"
> 
> riscv_isa_ext_data grows a pair of new members, to permit setting the
> relevant bits for "bundled" extensions, both while parsing the ISA string
> and the new dedicated extension properties
> 
> Co-developed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> There's basically none of the original patch left, so I have dropped the
> co-developed-bys and signed-off-bys from before. It does need one from
> you now though Evan!
> ---
>  arch/riscv/include/asm/hwcap.h | 13 +++++
>  arch/riscv/kernel/cpufeature.c | 94 ++++++++++++++++++++++++++++------
>  2 files changed, 92 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index b7b58258f6c7..f74308633e45 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -58,6 +58,17 @@
>  #define RISCV_ISA_EXT_ZICSR		40
>  #define RISCV_ISA_EXT_ZIFENCEI		41
>  #define RISCV_ISA_EXT_ZIHPM		42
> +#define RISCV_ISA_EXT_ZBC              43
> +#define RISCV_ISA_EXT_ZBKB             44
> +#define RISCV_ISA_EXT_ZBKC             45
> +#define RISCV_ISA_EXT_ZBKX             46
> +#define RISCV_ISA_EXT_ZKND             47
> +#define RISCV_ISA_EXT_ZKNE             48
> +#define RISCV_ISA_EXT_ZKNH             49
> +#define RISCV_ISA_EXT_ZKR              50
> +#define RISCV_ISA_EXT_ZKSED            51
> +#define RISCV_ISA_EXT_ZKSH             52
> +#define RISCV_ISA_EXT_ZKT              53
>  
>  #define RISCV_ISA_EXT_MAX		64
>  
> @@ -77,6 +88,8 @@ struct riscv_isa_ext_data {
>  	const unsigned int id;
>  	const char *name;
>  	const char *property;
> +	const unsigned int *bundle_ids;
> +	const unsigned int bundle_size;
>  };
>  
>  extern const struct riscv_isa_ext_data riscv_isa_ext[];
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index ccbe27b3060b..d999d73554f0 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -105,6 +105,39 @@ static bool riscv_isa_extension_check(int id)
>  	.id = _id,				\
>  }
>  
> +#define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) {	\
> +	.name = #_name,					\
> +	.property = #_name,				\
> +	.bundle_ids = _bundled_exts,			\
> +	.bundle_size = ARRAY_SIZE(_bundled_exts)	\
> +}
> +
> +static const unsigned int riscv_zk_bundled_exts[] = {
> +	RISCV_ISA_EXT_ZBKB,
> +	RISCV_ISA_EXT_ZBKC,
> +	RISCV_ISA_EXT_ZBKX,
> +	RISCV_ISA_EXT_ZKND,
> +	RISCV_ISA_EXT_ZKNE,
> +	RISCV_ISA_EXT_ZKR,
> +	RISCV_ISA_EXT_ZKT,

I think RISCV_ISA_EXT_ZKNH also belongs in this bundle,
since the spec says zk is the zkn bundle plus zkr and zkt.

> +};
> +
> +static const unsigned int riscv_zkn_bundled_exts[] = {
> +	RISCV_ISA_EXT_ZBKB,
> +	RISCV_ISA_EXT_ZBKC,
> +	RISCV_ISA_EXT_ZBKX,
> +	RISCV_ISA_EXT_ZKND,
> +	RISCV_ISA_EXT_ZKNE,
> +	RISCV_ISA_EXT_ZKNH,
> +};
> +
> +static const unsigned int riscv_zks_bundled_exts[] = {
> +	RISCV_ISA_EXT_ZBKB,
> +	RISCV_ISA_EXT_ZBKC,
> +	RISCV_ISA_EXT_ZKSED,
> +	RISCV_ISA_EXT_ZKSH

And, per the spec, this one appears to be missing RISCV_ISA_EXT_ZBKX.

I found [1] which calls these shorthands "group names", so maybe we should
use the term "group" instead of "bundle"? I'm tempted to try to directly
code that graphic in [1] with something like...

#define Zks_group1 \
	RISCV_ISA_EXT_ZKSED, \
	RISCV_ISA_EXT_ZKSH

#define Zks_group2 \
	RISCV_ISA_EXT_ZBKB, \
	RISCV_ISA_EXT_ZBKC, \
	RISCV_ISA_EXT_ZBKX

#define Zks_group \
	Zks_group1, \
	Zks_group2

#define Zkn_group1 \
	RISCV_ISA_EXT_ZKND, \
	RISCV_ISA_EXT_ZKNE, \
	RISCV_ISA_EXT_ZKNH

#define Zkn_group2 \
	Zks_group2

#define Zkn_group \
	Zkn_group1, \
	Zkn_group2

static const unsigned int riscv_zks_group[] = {
	Zks_group,
};

static const unsigned int riscv_zkn_group[] = {
	Zkn_group,
};

static const unsigned int riscv_zk_group[] = {
	Zks_group,
	Zkn_group,
	RISCV_ISA_EXT_ZKR,
	RISCV_ISA_EXT_ZKT,
};

...but now that I have, I'm not sure I like the looks of it...

[1] https://wiki.riscv.org/display/HOME/Scalar+Cryptography+Instruction+Set+Extension+Group+Names+Diagram

Thanks,
drew

> +};
> +
>  /*
>   * The canonical order of ISA extension names in the ISA string is defined in
>   * chapter 27 of the unprivileged specification.
> @@ -167,7 +200,20 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>  	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
>  	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
>  	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
> +	__RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
> +	__RISCV_ISA_EXT_DATA(zbkb, RISCV_ISA_EXT_ZBKB),
> +	__RISCV_ISA_EXT_DATA(zbkc, RISCV_ISA_EXT_ZBKC),
> +	__RISCV_ISA_EXT_DATA(zbkx, RISCV_ISA_EXT_ZBKX),
>  	__RISCV_ISA_EXT_DATA(zbs, RISCV_ISA_EXT_ZBS),
> +	__RISCV_ISA_EXT_BUNDLE(zk, riscv_zk_bundled_exts),
> +	__RISCV_ISA_EXT_BUNDLE(zkn, riscv_zkn_bundled_exts),
> +	__RISCV_ISA_EXT_DATA(zknd, RISCV_ISA_EXT_ZKND),
> +	__RISCV_ISA_EXT_DATA(zkne, RISCV_ISA_EXT_ZKNE),
> +	__RISCV_ISA_EXT_DATA(zknh, RISCV_ISA_EXT_ZKNH),
> +	__RISCV_ISA_EXT_DATA(zkr, RISCV_ISA_EXT_ZKR),
> +	__RISCV_ISA_EXT_BUNDLE(zks, riscv_zks_bundled_exts),
> +	__RISCV_ISA_EXT_DATA(zksed, RISCV_ISA_EXT_ZKSED),
> +	__RISCV_ISA_EXT_DATA(zksh, RISCV_ISA_EXT_ZKSH),
>  	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
>  	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
>  	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> @@ -179,6 +225,26 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>  
>  const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
>  
> +static void inline __init match_isa_ext(const struct riscv_isa_ext_data *ext, const char *name,
> +					const char *name_end, struct riscv_isainfo *isainfo)
> +{
> +	if ((name_end - name == strlen(ext->name)) &&
> +	     !strncasecmp(name, ext->name, name_end - name)) {
> +		/*
> +		 * If this is a bundle, enable all the ISA extensions that
> +		 * comprise the bundle.
> +		 */
> +		if (ext->bundle_size) {
> +			for (int i = 0; i < ext->bundle_size; i++) {
> +				if (riscv_isa_extension_check(ext->bundle_ids[i]))
> +					set_bit(ext->bundle_ids[i], isainfo->isa);
> +			}
> +		} else if (riscv_isa_extension_check(ext->id)) {
> +			set_bit(ext->id, isainfo->isa);
> +		}
> +	}
> +}
> +
>  static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct riscv_isainfo *isainfo,
>  					  unsigned long *isa2hwcap, const char *isa)
>  {
> @@ -310,14 +376,6 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
>  		if (*isa == '_')
>  			++isa;
>  
> -#define SET_ISA_EXT_MAP(name, bit)						\
> -		do {								\
> -			if ((ext_end - ext == strlen(name)) &&			\
> -			     !strncasecmp(ext, name, strlen(name)) &&		\
> -			     riscv_isa_extension_check(bit))			\
> -				set_bit(bit, isainfo->isa);			\
> -		} while (false)							\
> -
>  		if (unlikely(ext_err))
>  			continue;
>  		if (!ext_long) {
> @@ -329,10 +387,8 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
>  			}
>  		} else {
>  			for (int i = 0; i < riscv_isa_ext_count; i++)
> -				SET_ISA_EXT_MAP(riscv_isa_ext[i].name,
> -						riscv_isa_ext[i].id);
> +				match_isa_ext(&riscv_isa_ext[i], ext, ext_end, isainfo);
>  		}
> -#undef SET_ISA_EXT_MAP
>  	}
>  }
>  
> @@ -436,18 +492,26 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
>  		}
>  
>  		for (int i = 0; i < riscv_isa_ext_count; i++) {
> +			const struct riscv_isa_ext_data ext = riscv_isa_ext[i];
> +
>  			if (of_property_match_string(cpu_node, "riscv,isa-extensions",
> -						     riscv_isa_ext[i].property) < 0)
> +						     ext.property) < 0)
>  				continue;
>  
> -			if (!riscv_isa_extension_check(riscv_isa_ext[i].id))
> +			if (ext.bundle_size) {
> +				for (int j = 0; j < ext.bundle_size; j++) {
> +					if (riscv_isa_extension_check(ext.bundle_ids[i]))
> +						set_bit(ext.bundle_ids[j], this_isa);
> +				}
> +			} else if (riscv_isa_extension_check(ext.id)) {
> +				set_bit(ext.id, this_isa);
> +			} else {
>  				continue;
> +			}
>  
>  			/* Only single letter extensions get set in hwcap */
>  			if (strnlen(riscv_isa_ext[i].name, 2) == 1)
>  				this_hwcap |= isa2hwcap[riscv_isa_ext[i].id];
> -
> -			set_bit(riscv_isa_ext[i].id, this_isa);
>  		}
>  
>  		of_node_put(cpu_node);
> -- 
> 2.40.1
> 
> 


