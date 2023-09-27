Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57447B0252
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjI0LDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0LDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:03:11 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2034F3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:03:09 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1dd8cf47849so972945fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1695812589; x=1696417389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOPrKJWAl/9/IN/C/sVh2aNItIVXrI/b8dgIww0vJHY=;
        b=iwS7v1TmMSzVKKXPj+ct1z8u+hq2fJG6O/fBv6wPe5qZomSUup8dLVXkJQ6HkDJVXh
         wrN3tf1/Z3u3gIgEiuCmo03/aRRv3R2M03bs55c6kD770LyXJ5mpr+GzHz/qR30IejTV
         mC3COfQLRicNPdyAbwfsjtIPkWGjDuxeVALnbYcyHjxvWgCaVYo+V2gx7FoX4MPJFRzo
         7QO9kIi7ijmeRMStM5e28h3NkGHzw+4WZ69lWTokxXkI5XsFKMueRtD2TjfhIbcUildS
         tXmP70aP+D2c75sWkAYLu7frZNh/QnDcc1q3r5PAHUeHGXl25b+F0kaA44kIci2iyn5E
         1vjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695812589; x=1696417389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOPrKJWAl/9/IN/C/sVh2aNItIVXrI/b8dgIww0vJHY=;
        b=D6LfEEcJ96E/slZylJKBqA8ZKBva5HDI0d+NDvDdk1vZJfjT4AqvNvxGmmRaijzroV
         tKkqz1h4PKPXllYxLSSe2eJ+mqJ4IMky7BlnlppR6S1+vHxsuZO3+Ch4iKXjPYTQVzXj
         13oe9kmY0PQTOrZ4RCaLl7awDMPNr7MZh/bQwbI3LinjRVdVfp+Uwly0wKt9HYX3D/3X
         I0Lo9oOw1QT1Wl94JXcx16kX6zuFIf9tVxV8gjQ/2a7Cqk5fcfNqplxrkPTqeVSwGeuT
         ItPgyYstguV8ZW0K+vro0m1rkcpQE/lY3RMcxrHHBUfAgqUhVmHAIcTzh6jic3D5K81Q
         IYWw==
X-Gm-Message-State: AOJu0YwhCBdneYXdJLWUWv1GKTMSgKxGO6td6m9K7nGWKfVMIifLdRJQ
        Ie1/XN7ooXIrXhFHNEDPOhPEnhchBRcZGx4jve/H0xYqa8KiKV3c
X-Google-Smtp-Source: AGHT+IGdNvwTRHJQglaiviK7YYaztAN7D83/OmQPe0exs6oprKSd5lHX+OCZR4TRSaNrwIIhf9ZOf7kAX6DOkmJV0uo=
X-Received: by 2002:a05:6870:b30e:b0:1ad:2e18:7090 with SMTP id
 a14-20020a056870b30e00b001ad2e187090mr2122393oao.32.1695812589020; Wed, 27
 Sep 2023 04:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230922085701.3164-1-yongxuan.wang@sifive.com>
 <20230922085701.3164-2-yongxuan.wang@sifive.com> <20230927-62fbd3d63f4c6ffada90b7ee@orel>
In-Reply-To: <20230927-62fbd3d63f4c6ffada90b7ee@orel>
From:   Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date:   Wed, 27 Sep 2023 19:02:58 +0800
Message-ID: <CAMWQL2jUPNag5v7hiHqMnemAu6eStd2L9Fh9dCfS9gqi6xK1cw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] RISC-V: Detect and Enable Svadu Extension Support
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
        greentime.hu@sifive.com, vincent.chen@sifive.com, tjytimi@163.com,
        alex@ghiti.fr, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Guo Ren <guoren@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
        wchen <waylingii@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Charlie Jenkins <charlie@rivosinc.com>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>,
        David Hildenbrand <david@redhat.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi drew,

On Wed, Sep 27, 2023 at 3:03=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Fri, Sep 22, 2023 at 08:56:47AM +0000, Yong-Xuan Wang wrote:
> > We detect Svadu extension support from DTB and add arch_has_hw_pte_youn=
g()
> > to enable optimization in MGLRU and __wp_page_copy_user() if Svadu
> > extension is available.
> >
> > Co-developed-by: Jinyu Tang <tjytimi@163.com>
> > Signed-off-by: Jinyu Tang <tjytimi@163.com>
> > Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> > ---
> >  arch/riscv/include/asm/csr.h     | 1 +
> >  arch/riscv/include/asm/hwcap.h   | 1 +
> >  arch/riscv/include/asm/pgtable.h | 6 ++++++
> >  arch/riscv/kernel/cpufeature.c   | 1 +
> >  4 files changed, 9 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.=
h
> > index 777cb8299551..10648b372a2a 100644
> > --- a/arch/riscv/include/asm/csr.h
> > +++ b/arch/riscv/include/asm/csr.h
> > @@ -194,6 +194,7 @@
> >  /* xENVCFG flags */
> >  #define ENVCFG_STCE                  (_AC(1, ULL) << 63)
> >  #define ENVCFG_PBMTE                 (_AC(1, ULL) << 62)
> > +#define ENVCFG_HADE                  (_AC(1, ULL) << 61)
>
> This bit is named 'ADUE' in the spec. Why are we calling it HADE?

This bit was called HADE in v0.1 spec. I will update it to ADUE in
patch v3. Thank you!

Regards,
Yong-Xuan


>
> >  #define ENVCFG_CBZE                  (_AC(1, UL) << 7)
> >  #define ENVCFG_CBCFE                 (_AC(1, UL) << 6)
> >  #define ENVCFG_CBIE_SHIFT            4
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hw=
cap.h
> > index b7b58258f6c7..1013661d6516 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -58,6 +58,7 @@
> >  #define RISCV_ISA_EXT_ZICSR          40
> >  #define RISCV_ISA_EXT_ZIFENCEI               41
> >  #define RISCV_ISA_EXT_ZIHPM          42
> > +#define RISCV_ISA_EXT_SVADU          43
> >
> >  #define RISCV_ISA_EXT_MAX            64
> >
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/=
pgtable.h
> > index b2ba3f79cfe9..028b700cd27b 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -629,6 +629,12 @@ static inline pgprot_t pgprot_writecombine(pgprot_=
t _prot)
> >       return __pgprot(prot);
> >  }
> >
> > +#define arch_has_hw_pte_young arch_has_hw_pte_young
> > +static inline bool arch_has_hw_pte_young(void)
> > +{
> > +     return riscv_has_extension_unlikely(RISCV_ISA_EXT_SVADU);
> > +}
> > +
> >  /*
> >   * THP functions
> >   */
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeat=
ure.c
> > index 1cfbba65d11a..ead378c04991 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -178,6 +178,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D=
 {
> >       __RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
> >       __RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> >       __RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
> > +     __RISCV_ISA_EXT_DATA(svadu, RISCV_ISA_EXT_SVADU),
> >       __RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
> >       __RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
> >       __RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> > --
> > 2.17.1
> >
>
> Thanks,
> drew
