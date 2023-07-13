Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F2F751C0C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbjGMIrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbjGMIqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:46:44 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37975270F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:46:17 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51e56749750so533114a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1689237975; x=1691829975;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4Bi01lq2KkWZPe/Qh/OrifLY185NNlGFBCadJZOYFR4=;
        b=gFTj7ZOsB0RD0K2PNUyKcR7D7WrDcmc+M7tyeFPnJRpMAsT/pL+Kk8p5E8ADfnAKVJ
         6PtysR5xKh8sGZYGmV/K9Vb08QyNIcrv2OTUZJ5IQ0tEn0B9l3dm3s6HxtB9cazuKMuX
         0Yl8gpaqQd5Dt7zaeQDByppt1qS/fFRiaCZ1zlY7M2nwTTPNFeSbHaHA4wolOKNv8Ktk
         9//A0nM5y3w594s9ul8iLyNuzD1/zkvkYEjYTdVIqhhzKKpRv2N7veKSU2VTBWIg615G
         xoRIz9LXRxKYKpzQ3ArQEgS/DHT4r3Y3iW3wtIZ8usHTcDQCQHBwEXzG4vHsubJTOIod
         QXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689237975; x=1691829975;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Bi01lq2KkWZPe/Qh/OrifLY185NNlGFBCadJZOYFR4=;
        b=UeoYjwd5vHzqPq/TqZ5CMYlKtv5xK89npJKewIxUjnzRlgjY1BtswGH8nUc2jugpeS
         b7Xbu09eEUI3lI7t9UGNUjMBNsJkXbtKl4GRBUflZ80Q7O9awYtAo0JuAftS//SH/t+4
         eEylrD8iQGGZtX8C9zXZ8BkQIovZkhbw5BaAY1lleN63OaUJaEbFaNFhmxZnSNSK/In+
         inG2URhmdB9hKxIuj/2l9aqh47jkg8GnPP/SzcJmYwBHQTBn7fqVIERU7ClJ6Zi1B5td
         l/PZLzsUa0RfKzlnaZ2ffjJdy/fIgPFjXMM2ikjuoTEpLzAT8yl8GLzSlHF9EG5nAjE9
         mLJw==
X-Gm-Message-State: ABy/qLZxOrKOSUGBQeZS8J+vrncDDwiFLExp38yh2ahvDHaI59khWYf9
        8ORKo8ZvbZkJpeeZrMVIQFlFqw==
X-Google-Smtp-Source: APBJJlHOWekqqgW/xZ6Ap4hf1OSTxN/F0iHHt23jmaEidbTks7R1xHWavYByzkRAnw5H4jK9LuSbnw==
X-Received: by 2002:a05:6402:74d:b0:51e:2d16:8473 with SMTP id p13-20020a056402074d00b0051e2d168473mr1480904edy.36.1689237975470;
        Thu, 13 Jul 2023 01:46:15 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id s11-20020aa7c54b000000b0050cc4461fc5sm3900763edr.92.2023.07.13.01.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 01:46:15 -0700 (PDT)
Date:   Thu, 13 Jul 2023 10:46:14 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Evan Green <evan@rivosinc.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Samuel Ortiz <sameo@rivosinc.com>,
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
Message-ID: <20230713-3f574332a06678f908cee21e@orel>
References: <20230712084134.1648008-1-sameo@rivosinc.com>
 <20230712084134.1648008-2-sameo@rivosinc.com>
 <20230712-bulldozer-affected-199042dc3afd@wendy>
 <CALs-HsuxxVcwX=mSwktPiEiAFkfK+5qJ6zg1Bzf2t37L=pZWjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALs-HsuxxVcwX=mSwktPiEiAFkfK+5qJ6zg1Bzf2t37L=pZWjw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 10:43:33AM -0700, Evan Green wrote:
> On Wed, Jul 12, 2023 at 3:39 AM Conor Dooley <conor.dooley@microchip.com> wrote:
> >
> > Hey Samuel, Evan,
> >
> > On Wed, Jul 12, 2023 at 10:41:17AM +0200, Samuel Ortiz wrote:
> > > From: "Hongren (Zenithal) Zheng" <i@zenithal.me>
> > >
> > > Parse Zb/Zk related string from DT and output them to cpuinfo.
> >
> > One thing that has sprung to mind is that this is not limited to DT
> > anymore, since the information could in theory come from ACPI too.
> > Ditto the title I guess.
> >
> > > It is worth noting that the Scalar Crypto extension defines "zk" as a
> > > shorthand for the Zkn, Zkr and Zkt extensions. Since the Zkn one also
> > > implies the Zbkb, Zbkc and Zbkx extensions, simply passing the valid
> > > "zk" extension name through a DT will enable all of the  Zbkb, Zbkc,
> > > Zbkx, Zkn, Zkr and Zkt extensions.
> > >
> > > Also, since there currently is no mechanism to merge all enabled
> > > extensions, the generated cpuinfo output could be relatively large.
> > > For example, setting the "riscv,isa" DT property to "rv64imafdc_zk_zks"
> > > will generate the following cpuinfo output:
> > > "rv64imafdc_zbkb_zbkc_zbkx_zknd_zkne_zknh_zkr_zksed_zksh_zkt".
> >
> > On that note, I've created another version of what checking for
> > supersets could look like, since it'll be needed either by my series or
> > this one, depending on what gets merged first. I've yet to test the
> > dedicated extensions part of it, but I wanted to get this out before I
> > went looking at other fixes in the area.
> >
> > Evan, since it was you that commented on this stuff last time around,
> > could you take another look? I'm still not keen on the "subset_of"
> > arrays, but they're an improvement on what I had last time around for
> > sure.
> >
> 
> This looks alright to me. At the risk of getting into bikeshedding
> territory, the only awkward bit of it is it composes the extensions in
> sort of the opposite way you'd expect. I tend to think of Zks as being
> comprised of {zbkb, zbkc, zksed, zksh},

This is also the way I think of it, so, FWIW, I prefer the approach below,
where bundles are expanded.

Thanks,
drew

> rather than zbkb being a part
> of {zks, zkn, zk}, though both are of course correct. Here's an
> untested version of the other way. You can decide if you like it
> better or worse than what you've got, and I'm fine either way. Sorry
> gmail mangles it, if you want the patch for real I can get it to you:
> 
> From e201c34c05cd82812b5b3f47ccdd7d5909259f07 Mon Sep 17 00:00:00 2001
> From: Evan Green <evan@rivosinc.com>
> Date: Wed, 12 Jul 2023 10:36:15 -0700
> Subject: [PATCH] WIP: RISC-V: Allow support for bundled extensions, and add Zk*
> 
> ---
>  arch/riscv/include/asm/hwcap.h | 13 ++++++
>  arch/riscv/kernel/cpufeature.c | 82 +++++++++++++++++++++++++++++-----
>  2 files changed, 84 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index b7b58258f6c7..7d2d10b42cf3 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -58,6 +58,17 @@
>  #define RISCV_ISA_EXT_ZICSR            40
>  #define RISCV_ISA_EXT_ZIFENCEI         41
>  #define RISCV_ISA_EXT_ZIHPM            42
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
>  #define RISCV_ISA_EXT_MAX              64
> 
> @@ -77,6 +88,8 @@ struct riscv_isa_ext_data {
>         const unsigned int id;
>         const char *name;
>         const char *property;
> +       const unsigned int *bundled_exts;
> +       const unsigned int bundle_size;
>  };
> 
>  extern const struct riscv_isa_ext_data riscv_isa_ext[];
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 5945dfc5f806..2a1f958c1777 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -105,6 +105,39 @@ static bool riscv_isa_extension_check(int id)
>         .id = _id,                              \
>  }
> 
> +#define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) { \
> +       .name = #_name,                         \
> +       .property = #_name,                     \
> +       .bundled_exts = _bundled_exts,          \
> +       .bundle_size = ARRAY_SIZE(_bundled_exts)        \
> +}
> +
> +static const unsigned int riscv_zk_bundled_exts[] = {
> +       RISCV_ISA_EXT_ZBKB,
> +       RISCV_ISA_EXT_ZBKC,
> +       RISCV_ISA_EXT_ZBKX,
> +       RISCV_ISA_EXT_ZKND,
> +       RISCV_ISA_EXT_ZKNE,
> +       RISCV_ISA_EXT_ZKR,
> +       RISCV_ISA_EXT_ZKT,
> +};
> +
> +static const unsigned int riscv_zkn_bundled_exts[] = {
> +       RISCV_ISA_EXT_ZBKB,
> +       RISCV_ISA_EXT_ZBKC,
> +       RISCV_ISA_EXT_ZBKX,
> +       RISCV_ISA_EXT_ZKND,
> +       RISCV_ISA_EXT_ZKNE,
> +       RISCV_ISA_EXT_ZKNH,
> +};
> +
> +static const unsigned int riscv_zks_bundled_exts[] = {
> +       RISCV_ISA_EXT_ZBKB,
> +       RISCV_ISA_EXT_ZBKC,
> +       RISCV_ISA_EXT_ZKSED,
> +       RISCV_ISA_EXT_ZKSH
> +};
> +
>  /*
>   * The canonical order of ISA extension names in the ISA string is defined in
>   * chapter 27 of the unprivileged specification.
> @@ -167,7 +200,20 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>         __RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
>         __RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
>         __RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
> +       __RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
> +       __RISCV_ISA_EXT_DATA(zbkb, RISCV_ISA_EXT_ZBKB),
> +       __RISCV_ISA_EXT_DATA(zbkc, RISCV_ISA_EXT_ZBKC),
> +       __RISCV_ISA_EXT_DATA(zbkx, RISCV_ISA_EXT_ZBKX),
>         __RISCV_ISA_EXT_DATA(zbs, RISCV_ISA_EXT_ZBS),
> +       __RISCV_ISA_EXT_BUNDLE(zk, riscv_zk_bundled_exts),
> +       __RISCV_ISA_EXT_BUNDLE(zkn, riscv_zkn_bundled_exts),
> +       __RISCV_ISA_EXT_DATA(zknd, RISCV_ISA_EXT_ZKND),
> +       __RISCV_ISA_EXT_DATA(zkne, RISCV_ISA_EXT_ZKNE),
> +       __RISCV_ISA_EXT_DATA(zknh, RISCV_ISA_EXT_ZKNH),
> +       __RISCV_ISA_EXT_DATA(zkr, RISCV_ISA_EXT_ZKR),
> +       __RISCV_ISA_EXT_BUNDLE(zks, riscv_zks_bundled_exts),
> +       __RISCV_ISA_EXT_DATA(zksed, RISCV_ISA_EXT_ZKSED),
> +       __RISCV_ISA_EXT_DATA(zksh, RISCV_ISA_EXT_ZKSH),
>         __RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
>         __RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
>         __RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> @@ -179,6 +225,30 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
> 
>  const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
> 
> +static void match_isa_ext(const struct riscv_isa_ext_data *ext, const
> char *name,
> +                         const char *name_end, struct riscv_isainfo *isainfo)
> +{
> +       if ((name_end - name == strlen(ext->name)) &&
> +            !strncasecmp(name, ext->name, name_end - name)) {
> +
> +               /*
> +                * If this is a bundle, enable all the ISA extensions that
> +                * comprise the bundle.
> +                */
> +               if (ext->bundle_size) {
> +                       unsigned int i;
> +                       for (i = 0; i < ext->bundle_size; i++) {
> +                               if
> (riscv_isa_extension_check(ext->bundled_exts[i]))
> +                                       set_bit(ext->bundled_exts[i],
> isainfo->isa);
> +                       }
> +
> +
> +               } else if (riscv_isa_extension_check(ext->id)) {
> +                       set_bit(ext->id, isainfo->isa);
> +               }
> +       }
> +}
> +
>  static void __init riscv_parse_isa_string(unsigned long *this_hwcap,
> struct riscv_isainfo *isainfo,
>                                           unsigned long *isa2hwcap,
> const char *isa)
>  {
> @@ -310,14 +380,6 @@ static void __init
> riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
>                 if (*isa == '_')
>                         ++isa;
> 
> -#define SET_ISA_EXT_MAP(name, bit)
>          \
> -               do {
>          \
> -                       if ((ext_end - ext == sizeof(name) - 1) &&
>          \
> -                            !strncasecmp(ext, name, sizeof(name) - 1)
> &&       \
> -                            riscv_isa_extension_check(bit))
>          \
> -                               set_bit(bit, isainfo->isa);
>          \
> -               } while (false)
>          \
> -
>                 if (unlikely(ext_err))
>                         continue;
>                 if (!ext_long) {
> @@ -329,10 +391,8 @@ static void __init
> riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
>                         }
>                 } else {
>                         for (int i = 0; i < riscv_isa_ext_count; i++)
> -                               SET_ISA_EXT_MAP(riscv_isa_ext[i].name,
> -                                               riscv_isa_ext[i].id);
> +                               match_isa_ext(&riscv_isa_ext[i], ext,
> ext_end, isainfo);
>                 }
> -#undef SET_ISA_EXT_MAP
>         }
>  }
