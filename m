Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14172750FBC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbjGLRey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbjGLRev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:34:51 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369191FE4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:34:44 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fa48b5dc2eso11667850e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689183282; x=1691775282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Kn9GKWzSCL2y3w2iBtXzlaPYZE6roRbs1qwKy/TmHY=;
        b=o6+YFgzBDpsGfJuM/ertNh1ht/TceQDD5URMBDxiTzgooE3nIvHSeo2ebIf1in/J7A
         +F/OptuLwzFhjBxN2yMdo0uxGPfdfmlYgE5duf+IWZZFl4dW+F+tkI1KnIkAXsG5ExNa
         0tRzmewVAtiO7Kch2Ml/5iQwg2aE0ES/KR3tgvYqknmWCG2OZIyGnVtS8hO+/aFOjARf
         U8L72Wzsve03ef41G8okxF49C32zxtmTRMIj6xvdb+AkwLXrLo3B226rTerhSxAu6yAC
         6ENUpGSc5LR0Iem+lN2brhVBBb20EMb7wvfwBXzbDv4BNRg1eATMXMfX/IaJNI5Kjwh+
         0NnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689183282; x=1691775282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Kn9GKWzSCL2y3w2iBtXzlaPYZE6roRbs1qwKy/TmHY=;
        b=RWalHjwRGfF7G+uAm4ssIpIa9qXzZ+uB8VMkQiIuyq+SxqWHPoCgT6Bxiw1z7dWpve
         V9L2LJ43tLw1r/fZ5uArsOFG2gGLmpR/mKxBBPiQjRk1OKSy+TDk44Uwm76uhUHVI52x
         mBO91A0OepChXPvY4h99wwWqPajtd2y+YBoYrw/tqXH36uHco9Dnt1rOAvYCp8fIIvc4
         tCAimKY9mjnSjOBH3RqrQ4qyY4U7vt1wN1HY6zJ97dfZQ0t2uDN9MfFcP9LUPTtLEp2+
         iaMQISVAdHCB7YowbLeBu0v1XGylgki/nz87qs+VoSH62JHyl+EvD1lhZY1mUFYRW9ju
         JR+g==
X-Gm-Message-State: ABy/qLYs4dHWytAWt6U+k0NoRNwm4xtWEsopGM2SuGAOIM22UTHf13SA
        Tssa4n2FmegJ6wyUCzshg9GwqaVAlxSu19qfhzwNRA==
X-Google-Smtp-Source: APBJJlGLe1857hveLUdO5LGGF1AxUUzRt+f/c/dzcQTQoh/f/dXe05qgO01maJoi+rxEnXtAHpOuHL5xkN7wEJ1BXNk=
X-Received: by 2002:a05:6512:114b:b0:4f9:ec5e:d624 with SMTP id
 m11-20020a056512114b00b004f9ec5ed624mr18739314lfg.38.1689183282151; Wed, 12
 Jul 2023 10:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230710-equipment-stained-dd042d66ba5d@wendy> <20230710-banker-visible-4c4cb3685dc1@wendy>
In-Reply-To: <20230710-banker-visible-4c4cb3685dc1@wendy>
From:   Evan Green <evan@rivosinc.com>
Date:   Wed, 12 Jul 2023 10:34:06 -0700
Message-ID: <CALs-HsstyS+qFJZjb7Lv_2LmygfhA_EAeEdoCSRhtaXnYfhw0w@mail.gmail.com>
Subject: Re: [PATCH v4 05/11] RISC-V: repurpose riscv_isa_ext array in riscv_fill_hwcap()
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     palmer@dabbelt.com, conor@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 2:36=E2=80=AFAM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> In riscv_fill_hwcap() riscv_isa_ext array can be looped over, rather
> than duplicating the list of extensions with individual
> SET_ISA_EXT_MAP() usage. While at it, drop the statement-of-the-obvious
> comments from the struct, rename uprop to something more suitable for
> its new use & constify the members.
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Changes in v2:
> - Delete the now unused definition
> ---
>  arch/riscv/include/asm/hwcap.h |  7 ++-----
>  arch/riscv/kernel/cpu.c        |  5 +++--
>  arch/riscv/kernel/cpufeature.c | 26 +++++++-------------------
>  3 files changed, 12 insertions(+), 26 deletions(-)
>
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwca=
p.h
> index 7a57e6109aef..2460ac2fc7ed 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -55,7 +55,6 @@
>  #define RISCV_ISA_EXT_ZIHPM            42
>
>  #define RISCV_ISA_EXT_MAX              64
> -#define RISCV_ISA_EXT_NAME_LEN_MAX     32
>
>  #ifdef CONFIG_RISCV_M_MODE
>  #define RISCV_ISA_EXT_SxAIA            RISCV_ISA_EXT_SMAIA
> @@ -70,10 +69,8 @@
>  unsigned long riscv_get_elf_hwcap(void);
>
>  struct riscv_isa_ext_data {
> -       /* Name of the extension displayed to userspace via /proc/cpuinfo=
 */
> -       char uprop[RISCV_ISA_EXT_NAME_LEN_MAX];
> -       /* The logical ISA extension ID */
> -       unsigned int isa_ext_id;
> +       const unsigned int id;
> +       const char *name;
>  };
>
>  extern const struct riscv_isa_ext_data riscv_isa_ext[];
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index bf93293d51f3..aa17eeb0ec9a 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -168,9 +168,10 @@ static void print_isa_ext(struct seq_file *f)
>  {
>         for (int i =3D 0; i < riscv_isa_ext_count; i++) {
>                 const struct riscv_isa_ext_data *edata =3D &riscv_isa_ext=
[i];
> -               if (!__riscv_isa_extension_available(NULL, edata->isa_ext=
_id))
> +               if (!__riscv_isa_extension_available(NULL, edata->id))
>                         continue;
> -               seq_printf(f, "_%s", edata->uprop);
> +
> +               seq_printf(f, "_%s", edata->name);
>         }
>  }
>
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index fb476153fffc..6d8cd45af723 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -99,11 +99,10 @@ static bool riscv_isa_extension_check(int id)
>         return true;
>  }
>
> -#define __RISCV_ISA_EXT_DATA(UPROP, EXTID) \
> -       {                                                       \
> -               .uprop =3D #UPROP,                                \
> -               .isa_ext_id =3D EXTID,                            \
> -       }
> +#define __RISCV_ISA_EXT_DATA(_name, _id) {     \
> +       .name =3D #_name,                         \
> +       .id =3D _id,                              \
> +}
>
>  /*
>   * The canonical order of ISA extension names in the ISA string is defin=
ed in
> @@ -366,20 +365,9 @@ void __init riscv_fill_hwcap(void)
>                                         set_bit(nr, isainfo->isa);
>                                 }
>                         } else {
> -                               /* sorted alphabetically */
> -                               SET_ISA_EXT_MAP("smaia", RISCV_ISA_EXT_SM=
AIA);
> -                               SET_ISA_EXT_MAP("ssaia", RISCV_ISA_EXT_SS=
AIA);
> -                               SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT=
_SSCOFPMF);
> -                               SET_ISA_EXT_MAP("sstc", RISCV_ISA_EXT_SST=
C);
> -                               SET_ISA_EXT_MAP("svinval", RISCV_ISA_EXT_=
SVINVAL);
> -                               SET_ISA_EXT_MAP("svnapot", RISCV_ISA_EXT_=
SVNAPOT);
> -                               SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_S=
VPBMT);
> -                               SET_ISA_EXT_MAP("zba", RISCV_ISA_EXT_ZBA)=
;
> -                               SET_ISA_EXT_MAP("zbb", RISCV_ISA_EXT_ZBB)=
;
> -                               SET_ISA_EXT_MAP("zbs", RISCV_ISA_EXT_ZBS)=
;
> -                               SET_ISA_EXT_MAP("zicbom", RISCV_ISA_EXT_Z=
ICBOM);
> -                               SET_ISA_EXT_MAP("zicboz", RISCV_ISA_EXT_Z=
ICBOZ);
> -                               SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_=
EXT_ZIHINTPAUSE);
> +                               for (int i =3D 0; i < riscv_isa_ext_count=
; i++)
> +                                       SET_ISA_EXT_MAP(riscv_isa_ext[i].=
name,

Does this still work, given that SET_ISA_EXT_MAP() does sizeof(name)
to get the string length? I worry that line of the macro is now
evaluating to a constant sizeof(pointer), and the macro needs to
change to use strlen().

-Evan
