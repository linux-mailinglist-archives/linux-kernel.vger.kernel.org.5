Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD667A711D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 05:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjITDuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 23:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjITDt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 23:49:59 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A182AC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 20:49:53 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1d544a4a315so4104172fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 20:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1695181792; x=1695786592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcEmXd6qxRcs3BYgRhvSX8w5LurG2MJXEE/HzYLhdCo=;
        b=BjBG/80lU+Oquv5sCPrpjFBtiAB+1eHTSVzKy2UpAzP3H1PuyAjs6j1VLs08nxgbri
         j208euLUjI8U7jJ29IEsJCn0nl7ztwCKKZDliS/pbsY2jFx1khCA+z/FME22IovLEph3
         EHVEVX5fSEnj4ZEB+HO68jNvCaqb0klCJGwDufmIFcWOvSM+N8//12qSeO2eDRUKdmOi
         m/3ZXVCdHoyt3xHwC0t4DieQxn1a5WlHRHZ6uuf9IFznS7Sm/n/V4SPF5UQ6hvYRpV0u
         Cr7qySrQaAWx+FwHGR8gD8UXqSJ31h3R/ubOjbGrENOsKbeENaZm8VPgV0wQmnVHCtxd
         AtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695181792; x=1695786592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CcEmXd6qxRcs3BYgRhvSX8w5LurG2MJXEE/HzYLhdCo=;
        b=dmcomUnpmyBsu4leAEN06d//7qnmHTQiBSvPuxPi/jowHdjngyPH5gzUIBZoWvGueo
         abXLM1Uz37Oxh0Ul3sT9W0Z0KrVBGX4I8XMpf1kzoyEdzkOHxHmTZhBoOifi69UjHa/l
         yt1wCXyQe3CgUBMA/TTemPEN2WovhEPLqHX1ASWw1RV01vxCVbMiz2yuChdtrji26Phe
         tmGD9RNG06ZI0n/kdXRhu0fth4g2wELkOsTY4HVaIMVVD/cQehAg5HfYKkzcGzV1pI1d
         g7jVkjAmKj++v7w6DMVLZ5LV34QYKa07SXQ2YIKQS+qPOklkmUsVP5xBXXo0Zx9cXa5A
         efVA==
X-Gm-Message-State: AOJu0YyZ0u7pnx/c0/qez5P8GjosLbG9HfBG3mYQmhoMZrNkTkVseOM+
        CyOd6oIz+8wADNL2hEw0/MpOq6Yntp1TJAOGY4FPqQ==
X-Google-Smtp-Source: AGHT+IFC5ykJgzdPO9/UQTCMkpj4OyxzDmF9fA+W3DMpI1p6hqTk51dYch5UuKxCSpy3G5X1DAv0m0wwAcs8ZpjrXNo=
X-Received: by 2002:a05:6870:6122:b0:1d6:ef37:9416 with SMTP id
 s34-20020a056870612200b001d6ef379416mr1495389oae.22.1695181792271; Tue, 19
 Sep 2023 20:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230915082701.3643-1-yongxuan.wang@sifive.com>
 <20230915082701.3643-2-yongxuan.wang@sifive.com> <20230915-triangle-fool-e7032469d3e1@wendy>
In-Reply-To: <20230915-triangle-fool-e7032469d3e1@wendy>
From:   Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date:   Wed, 20 Sep 2023 11:49:41 +0800
Message-ID: <CAMWQL2jTbYDSD3y8R8fFORH2AL+1C25N+fNn7kmfc2jAZJKbeA@mail.gmail.com>
Subject: Re: [PATCH 1/2] RISC-V: Detect and Enable Svadu Extension Support
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
        greentime.hu@sifive.com, vincent.chen@sifive.com, tjytimi@163.com,
        alex@ghiti.fr, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        wchen <waylingii@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        David Hildenbrand <david@redhat.com>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Charlie Jenkins <charlie@rivosinc.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Evan Green <evan@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Fri, Sep 15, 2023 at 4:45=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Fri, Sep 15, 2023 at 08:26:57AM +0000, Yong-Xuan Wang wrote:
> > We detect Svadu extension support from DTB and add arch_has_hw_pte_youn=
g()
> > to enable optimization in MGLRU and __wp_page_copy_user() if Svadu
> > extension is available.
> >
> > Signed-off-by: Jinyu Tang <tjytimi@163.com>
>
> You're either missing a From: or a Co-developed-by: tag here.
>
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
> > index b2ba3f79cfe9..f3d077dff8ac 100644
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
> > +     return riscv_has_extension_likely(RISCV_ISA_EXT_SVADU);
>
> No hardware currently has this, why is it likely?
>
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
>
> This needs to be documented in riscv/extensions.yaml.
>

Thank you! I will update these in v2 patch.

Regards,
Yong-Xuan

> Thanks,
> Conor.
>
> >       __RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
> >       __RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
> >       __RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> > --
> > 2.17.1
> >
