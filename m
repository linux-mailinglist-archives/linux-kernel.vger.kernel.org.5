Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DAD7E5C58
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 18:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjKHRZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 12:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjKHRZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 12:25:10 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE751BDA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 09:25:07 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c5087d19a6so96362061fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 09:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699464306; x=1700069106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgXbt/tSz6pXr3eMyUOOwY6ppW+qNuHG/V68FJAtKZ8=;
        b=uSu07+PhM+8qNPnikhX09BA2bWurar5ZPn90GXRzaLxARuxNjBglkFVEHBgN1MloiK
         226wECTjzUdwS9pjMomXUFmTiqfLOEhM6t8pt2Cer/u7fjK/ow1DrL88mvzMK0VofP/b
         0AyyiJMPlhfqyiRFeMQvrvmJjGiFXE3fjvqXRB72X0U2NDV5bC1r+oSi9jYpkiY30Mb1
         ikG2nU5YqkbMOMM/n0YnFz5Q6diSmPTbsg0wyfG3uq6X0x0zDqXlmOqXzJ4qW1CtCELJ
         omcGl6pyiZXsBX1uX3LuAZ4kGhNXfLLSgn3BDhOSxN7Fdvhd046jT2HoTz5jxHbKlkmi
         xrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699464306; x=1700069106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgXbt/tSz6pXr3eMyUOOwY6ppW+qNuHG/V68FJAtKZ8=;
        b=D8dAfPcnUAtEOG/3DI3E9L3OtzmypqTDtCXDe28kCWYY0r24h88YVQBM1LqS+yz4fB
         XfIVetnZkY71Trxc/a0gSL0jYdzp+8CdkcDe/fzghJzKP+xjhnPC9lAvmKC1bJsGk7q+
         hXI8Yrau2My7+rlPkjsgexeoPt+MbPbAVuUP/Yz7qA4DPr9ZOVODDWwSZmcxRJYU/Q+o
         cuFB3sFD57/DLj6HGFoQAlWpNldeRbKWnrTmLeASma1c39Qk+D/8X+ZCH16bGNiW4jwt
         dBL7LAzwqbREqmXJXI1USnV9TC5aS1PyNbUJgL91r1tqUbd4fiM3TDz5124wjvSb+Ult
         yvSA==
X-Gm-Message-State: AOJu0YwA0iAIcCBFj3c2yT729e7uuCTE/cj8zLjlNDwlz2s9l8Bl6YOV
        EuaYrh3rXx6YaqdYXqexDKPgHCUqP6m0RA2FKDq9Zg==
X-Google-Smtp-Source: AGHT+IGm43VkRXWESCDlywlhjFOk4zqNOdsRleac97ixErFCfl7hVxzvVKSYewTEgdKSLkWI1Lk3/sGzoUp7lvJShj8=
X-Received: by 2002:a2e:6e0c:0:b0:2c6:ebfb:dd28 with SMTP id
 j12-20020a2e6e0c000000b002c6ebfbdd28mr1918300ljc.0.1699464305900; Wed, 08 Nov
 2023 09:25:05 -0800 (PST)
MIME-Version: 1.0
References: <20231107105556.517187-1-cleger@rivosinc.com> <20231107105556.517187-4-cleger@rivosinc.com>
In-Reply-To: <20231107105556.517187-4-cleger@rivosinc.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Wed, 8 Nov 2023 09:24:29 -0800
Message-ID: <CALs-HssQFQWDi=MM0gVaqc7GJg9gpp6oKc4+=G7mV12CFNQs1A@mail.gmail.com>
Subject: Re: [PATCH v3 03/20] riscv: add ISA extension parsing for scalar crypto
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 7, 2023 at 2:56=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@rivo=
sinc.com> wrote:
>
> From: Evan Green <evan@rivosinc.com>
>
> The Scalar Crypto specification defines Zk as a shorthand for the
> Zkn, Zkr and Zkt extensions. The same follows for both Zkn, Zks and Zbk,
> which are all shorthands for various other extensions. The detailed
> breakdown can be found in their dt-binding entries.
>
> Since Zkn also implies the Zbkb, Zbkc and Zbkx extensions, simply passing
> "zk" through a DT should enable all of Zbkb, Zbkc, Zbkx, Zkn, Zkr and Zkt=
.
> For example, setting the "riscv,isa" DT property to "rv64imafdc_zk"
> should generate the following cpuinfo output:
> "rv64imafdc_zicntr_zicsr_zifencei_zihpm_zbkb_zbkc_zbkx_zknd_zkne_zknh_zkr=
_zkt"
>
> riscv_isa_ext_data grows a pair of new members, to permit setting the
> relevant bits for "bundled" extensions, both while parsing the ISA string
> and the new dedicated extension properties.
>
> Co-developed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Evan Green <evan@rivosinc.com>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> ---
>  arch/riscv/include/asm/hwcap.h |  16 ++++-
>  arch/riscv/kernel/cpufeature.c | 115 ++++++++++++++++++++++++++-------
>  2 files changed, 107 insertions(+), 24 deletions(-)
>
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwca=
p.h
> index 6fc51c1b34cf..69cc659cf65e 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -60,8 +60,20 @@
>  #define RISCV_ISA_EXT_ZIHPM            42
>  #define RISCV_ISA_EXT_SMSTATEEN                43
>  #define RISCV_ISA_EXT_ZICOND           44
> +#define RISCV_ISA_EXT_ZBC              45
> +#define RISCV_ISA_EXT_ZBKB             46
> +#define RISCV_ISA_EXT_ZBKC             47
> +#define RISCV_ISA_EXT_ZBKX             48
> +#define RISCV_ISA_EXT_ZKND             49
> +#define RISCV_ISA_EXT_ZKNE             50
> +#define RISCV_ISA_EXT_ZKNH             51
> +#define RISCV_ISA_EXT_ZKR              52
> +#define RISCV_ISA_EXT_ZKSED            53
> +#define RISCV_ISA_EXT_ZKSH             54
> +#define RISCV_ISA_EXT_ZKT              55
>
>  #define RISCV_ISA_EXT_MAX              64
> +#define RISCV_ISA_EXT_INVALID          U32_MAX
>
>  #ifdef CONFIG_RISCV_M_MODE
>  #define RISCV_ISA_EXT_SxAIA            RISCV_ISA_EXT_SMAIA
> @@ -79,6 +91,8 @@ struct riscv_isa_ext_data {
>         const unsigned int id;
>         const char *name;
>         const char *property;
> +       const unsigned int *subset_ext_ids;
> +       const unsigned int subset_ext_size;
>  };
>
>  extern const struct riscv_isa_ext_data riscv_isa_ext[];
> @@ -89,7 +103,7 @@ unsigned long riscv_isa_extension_base(const unsigned =
long *isa_bitmap);
>
>  #define riscv_isa_extension_mask(ext) BIT_MASK(RISCV_ISA_EXT_##ext)
>
> -bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, in=
t bit);
> +bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, un=
signed int bit);
>  #define riscv_isa_extension_available(isa_bitmap, ext) \
>         __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_##ext)
>
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index e3803822ab5a..0d78791288da 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -68,7 +68,7 @@ EXPORT_SYMBOL_GPL(riscv_isa_extension_base);
>   *
>   * NOTE: If isa_bitmap is NULL then Host ISA bitmap will be used.
>   */
> -bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, in=
t bit)
> +bool __riscv_isa_extension_available(const unsigned long *isa_bitmap, un=
signed int bit)
>  {
>         const unsigned long *bmap =3D (isa_bitmap) ? isa_bitmap : riscv_i=
sa;
>
> @@ -100,17 +100,53 @@ static bool riscv_isa_extension_check(int id)
>                         return false;
>                 }
>                 return true;
> +       case RISCV_ISA_EXT_INVALID:
> +               return false;
>         }
>
>         return true;
>  }
>
> -#define __RISCV_ISA_EXT_DATA(_name, _id) {     \
> -       .name =3D #_name,                         \
> -       .property =3D #_name,                     \
> -       .id =3D _id,                              \
> +#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size)=
 {     \
> +       .name =3D #_name,                                                =
         \
> +       .property =3D #_name,                                            =
         \
> +       .id =3D _id,                                                     =
         \
> +       .subset_ext_ids =3D _subset_exts,                                =
         \
> +       .subset_ext_size =3D _subset_exts_size                           =
         \
>  }
>
> +#define __RISCV_ISA_EXT_DATA(_name, _id) _RISCV_ISA_EXT_DATA(_name, _id,=
 NULL, 0)
> +
> +/* Used to declare pure "lasso" extension (Zk for instance) */
> +#define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) \
> +       _RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, =
ARRAY_SIZE(_bundled_exts))
> +
> +static const unsigned int riscv_zk_bundled_exts[] =3D {
> +       RISCV_ISA_EXT_ZBKB,
> +       RISCV_ISA_EXT_ZBKC,
> +       RISCV_ISA_EXT_ZBKX,
> +       RISCV_ISA_EXT_ZKND,
> +       RISCV_ISA_EXT_ZKNE,
> +       RISCV_ISA_EXT_ZKR,
> +       RISCV_ISA_EXT_ZKT,
> +};
> +
> +static const unsigned int riscv_zkn_bundled_exts[] =3D {
> +       RISCV_ISA_EXT_ZBKB,
> +       RISCV_ISA_EXT_ZBKC,
> +       RISCV_ISA_EXT_ZBKX,
> +       RISCV_ISA_EXT_ZKND,
> +       RISCV_ISA_EXT_ZKNE,
> +       RISCV_ISA_EXT_ZKNH,
> +};
> +
> +static const unsigned int riscv_zks_bundled_exts[] =3D {
> +       RISCV_ISA_EXT_ZBKB,
> +       RISCV_ISA_EXT_ZBKC,
> +       RISCV_ISA_EXT_ZKSED,
> +       RISCV_ISA_EXT_ZKSH
> +};
> +
>  /*
>   * The canonical order of ISA extension names in the ISA string is defin=
ed in
>   * chapter 27 of the unprivileged specification.
> @@ -174,7 +210,21 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D =
{
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
> +       __RISCV_ISA_EXT_DATA(zkt, RISCV_ISA_EXT_ZKT),
> +       __RISCV_ISA_EXT_DATA(zksed, RISCV_ISA_EXT_ZKSED),
> +       __RISCV_ISA_EXT_DATA(zksh, RISCV_ISA_EXT_ZKSH),
>         __RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
>         __RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
>         __RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
> @@ -187,6 +237,27 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D =
{
>
>  const size_t riscv_isa_ext_count =3D ARRAY_SIZE(riscv_isa_ext);
>
> +static void __init match_isa_ext(const struct riscv_isa_ext_data *ext, c=
onst char *name,
> +                                const char *name_end, struct riscv_isain=
fo *isainfo)
> +{
> +       if ((name_end - name =3D=3D strlen(ext->name)) &&
> +            !strncasecmp(name, ext->name, name_end - name)) {
> +               /*
> +                * If this is a bundle, enable all the ISA extensions tha=
t
> +                * comprise the bundle.
> +                */
> +               if (ext->subset_ext_size) {
> +                       for (int i =3D 0; i < ext->subset_ext_size; i++) =
{
> +                               if (riscv_isa_extension_check(ext->subset=
_ext_ids[i]))
> +                                       set_bit(ext->subset_ext_ids[i], i=
sainfo->isa);
> +                       }
> +               }
> +
> +               if (riscv_isa_extension_check(ext->id))
> +                       set_bit(ext->id, isainfo->isa);
> +       }
> +}
> +
>  static void __init riscv_parse_isa_string(unsigned long *this_hwcap, str=
uct riscv_isainfo *isainfo,
>                                           unsigned long *isa2hwcap, const=
 char *isa)
>  {
> @@ -318,14 +389,6 @@ static void __init riscv_parse_isa_string(unsigned l=
ong *this_hwcap, struct risc
>                 if (*isa =3D=3D '_')
>                         ++isa;
>
> -#define SET_ISA_EXT_MAP(name, bit)                                      =
       \
> -               do {                                                     =
       \
> -                       if ((ext_end - ext =3D=3D strlen(name)) &&       =
           \
> -                            !strncasecmp(ext, name, strlen(name)) &&    =
       \
> -                            riscv_isa_extension_check(bit))             =
       \
> -                               set_bit(bit, isainfo->isa);              =
       \
> -               } while (false)                                          =
       \
> -
>                 if (unlikely(ext_err))
>                         continue;
>                 if (!ext_long) {
> @@ -337,10 +400,8 @@ static void __init riscv_parse_isa_string(unsigned l=
ong *this_hwcap, struct risc
>                         }
>                 } else {
>                         for (int i =3D 0; i < riscv_isa_ext_count; i++)
> -                               SET_ISA_EXT_MAP(riscv_isa_ext[i].name,
> -                                               riscv_isa_ext[i].id);
> +                               match_isa_ext(&riscv_isa_ext[i], ext, ext=
_end, isainfo);
>                 }
> -#undef SET_ISA_EXT_MAP
>         }
>  }
>
> @@ -439,18 +500,26 @@ static int __init riscv_fill_hwcap_from_ext_list(un=
signed long *isa2hwcap)
>                 }
>
>                 for (int i =3D 0; i < riscv_isa_ext_count; i++) {
> +                       const struct riscv_isa_ext_data ext =3D riscv_isa=
_ext[i];

Not a biggie, but a pointer would seem more appropriate to me than
copying the struct into a local.
