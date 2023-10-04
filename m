Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D5F7B8E52
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 22:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243881AbjJDUsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 16:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbjJDUsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 16:48:04 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8400BF;
        Wed,  4 Oct 2023 13:48:00 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-49d45964fcaso916735e0c.1;
        Wed, 04 Oct 2023 13:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696452480; x=1697057280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfMc2o3aeaMtgo1tIGkp8mKMdGYs27vkJXRJNkCUQ0A=;
        b=gtaAswo8hQfyNdz0TsBfYA1dZ/cinoQwqTodnlwWfIkqJ/yJZys/YfWKh8hWMRBnRP
         Kk0tAoxPtQEGaSSBWiw1JaF7iXDjjs5A8os5Yoj2LP1yVdBq8YsjXOK764QsiHYPx6Y7
         /CqlfON3kgNETZYRjj4BNkO3IgC8WGauFrjnIrtY5gwoz8aWUTq0TNCN+o+P2BjF14ER
         XovCoSNEZ/BEtRFVqgSKcWVd39htGYGx2i817rhIDQF58LRW6agAOOfxgyD1kpRs5pfs
         bNKAaH7TterUEJHOFeonofRoadxP7YlBITcGhxSoflxVxeAcYdzWkLYizkRSCOD0ISMT
         HPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696452480; x=1697057280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfMc2o3aeaMtgo1tIGkp8mKMdGYs27vkJXRJNkCUQ0A=;
        b=Zy8iHRWu6lSPcDU9DyxmIglgwyhPhtKaPK0r0n1qoSzI2XOyiZyTcUmiwUvFIVV/LI
         NBRAarlIz0W82DD8PS3eaXONSl+Q39+fYiPBdaxMhM1GPswFQsjpaxu2OlZ0MlG40U3Y
         jYaEqdpwwEoAe+tPTLK+q3VIKXKmb0VwbNvkxzeASgZ4fE1J51Juzjy6lQyn/gWx5dmP
         wx4oTD/NFYOyOmInOrmDTuMhjBVCbzStBhbaLdnUhZvZI3cXIOIgvtd7Fn9MCK7yOscq
         vYuUKOoslfUdigCJjff2KiOb16AH5g7id+oPZ5PM79lB/tDyYMw8PoF0SzeQJb7d3VUR
         t8kw==
X-Gm-Message-State: AOJu0YxmRPyknXFtn5JE0u7a0H/gmF2lkT9uWTvtIa+nXuVQHcAC1u7L
        AxGEj40igiiONwimTQf6uPGeap+LkMG+KhrEfuw=
X-Google-Smtp-Source: AGHT+IGz+I4KR7M4OtZmQSMxVqj0EW9sFvCy2VD93W9/vEp7JtwUuQn+RAVp3yVHNE7MpbzIb/Ew4ddKR/ZMgWxfe9A=
X-Received: by 2002:a05:6122:178a:b0:495:f495:bab1 with SMTP id
 o10-20020a056122178a00b00495f495bab1mr442731vkf.0.1696452478361; Wed, 04 Oct
 2023 13:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230921-th1520-mmc-v1-0-49f76c274fb3@baylibre.com>
 <CAOCHtYhnx1EpBM+o3xhdsicx5uqLidojK3f0HQ+VfyVv1ZXnVQ@mail.gmail.com>
 <CAOCHtYi5Ab5ppCmaQV3QuKQcpmJX+sHdAmtuEXhfq8xf5fFCYQ@mail.gmail.com>
 <ZRuamJuShOnvP1pr@x1> <ZR1M3FcdXrDmIGu2@xhacker> <CA+V-a8ugwqkQxnX-wwWCHVtBBtG=aVv=MZTc53LbpxtFA=N1_A@mail.gmail.com>
 <bc2b0b30-ab37-f336-c90e-eab570d393a2@arm.com> <c2ea3f34bb919293b850fab6ed42b61e3517ba35.camel@icenowy.me>
 <a568a9dd-bab2-1e23-c4d5-9f6475bdcc3b@arm.com> <CA+V-a8s1S4yTH19PVNSznAgUFoHRNoye9CfwjW6iy6PbQ9thew@mail.gmail.com>
 <CA+V-a8vbWW6=HTfR+FCPOB0bAa8M3Bbm_k=7+XbjOc3ybo6VNQ@mail.gmail.com>
 <20075b03-e3b0-4f29-9ba1-98eed361a44f@sifive.com> <498ffcef-2ff9-495b-8544-b87c5c2eb6e1@arm.com>
In-Reply-To: <498ffcef-2ff9-495b-8544-b87c5c2eb6e1@arm.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 4 Oct 2023 21:47:03 +0100
Message-ID: <CA+V-a8u3+k3c6RQsmSVH+iQkFo3s_iwAZS_OFBvGpxzx_i_Ftw@mail.gmail.com>
Subject: Re: [PATCH 0/6] RISC-V: Add eMMC support for TH1520 boards
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Samuel Holland <samuel.holland@sifive.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Drew Fustini <dfustini@baylibre.com>,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Guo Ren <guoren@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-riscv@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>, Han Gao <gaohan@iscas.ac.cn>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Robert Nelson <robertcnelson@gmail.com>,
        linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Conor Dooley <conor@kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Xi Ruoyao <xry111@xry111.site>, Fu Wei <wefu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 8:38=E2=80=AFPM Robin Murphy <robin.murphy@arm.com> =
wrote:
>
> On 2023-10-04 19:49, Samuel Holland wrote:
> > On 2023-10-04 12:16 PM, Lad, Prabhakar wrote:
> >> On Wed, Oct 4, 2023 at 5:03=E2=80=AFPM Lad, Prabhakar
> >> <prabhakar.csengg@gmail.com> wrote:
> >>>
> >>> On Wed, Oct 4, 2023 at 3:18=E2=80=AFPM Robin Murphy <robin.murphy@arm=
.com> wrote:
> >>>>
> >>>> On 04/10/2023 3:02 pm, Icenowy Zheng wrote:
> >>>> [...]
> >>>>>>>> I believe commit 484861e09f3e ("soc: renesas: Kconfig: Select th=
e
> >>>>>>>> required configs for RZ/Five SoC") can cause regression on all
> >>>>>>>> non-dma-coherent riscv platforms with generic defconfig. This is
> >>>>>>>> a common issue. The logic here is: generic riscv defconfig
> >>>>>>>> selects
> >>>>>>>> ARCH_R9A07G043 which selects DMA_GLOBAL_POOL, which assumes all
> >>>>>>>> non-dma-coherent riscv platforms have a dma global pool, this
> >>>>>>>> assumption
> >>>>>>>> seems not correct. And I believe DMA_GLOBAL_POOL should not be
> >>>>>>>> selected by ARCH_SOCFAMILIY, instead, only ARCH under some
> >>>>>>>> specific
> >>>>>>>> conditions can select it globaly, for example NOMMU ARM and so
> >>>>>>>> on.
> >>>>>>>>
> >>>>>>>> Since this is a regression, what's proper fix? any suggestion is
> >>>>>>>> appreciated.
> >>>>>>
> >>>>>> I think the answer is to not select DMA_GLOBAL_POOL, since that is
> >>>>>> only
> >>>>>
> >>>>> Well I think for RISC-V, it's not NOMMU only but applicable for eve=
ry
> >>>>> core that does not support Svpbmt or vendor-specific alternatives,
> >>>>> because the original RISC-V priv spec does not define memory attrib=
utes
> >>>>> in page table entries.
> >>>>>
> >>>>> For the Renesas/Andes case I think a pool is set by OpenSBI with
> >>>>> vendor-specific M-mode facility and then passed in DT, and the S-mo=
de
> >>>>> (which MMU is enabled in) just sees fixed memory attributes, in thi=
s
> >>>>> case I think DMA_GLOBAL_POOL is needed.
> >>>>
> >>>> Oh wow, is that really a thing? In that case, either you just can't
> >>>> support this platform in a multi-platform kernel, or someone needs t=
o do
> >>>> some fiddly work in dma-direct to a) introduce the notion of an opti=
onal
> >>>> global pool,
> >>> Looking at the code [0] we do have compile time check for
> >>> CONFIG_DMA_GLOBAL_POOL irrespective of this being present in DT or
> >>> not, instead if we make it compile time and runtime check ie either
> >>> check for DT node or see if pool is available and only then proceed
> >>> for allocation form this pool.
> >>>
> >>> What are your thoughts on this?
> >>>
> >> Something like the below:
> >>
> >> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> >> index f2fc203fb8a1..7bf41a4634a4 100644
> >> --- a/include/linux/dma-map-ops.h
> >> +++ b/include/linux/dma-map-ops.h
> >> @@ -198,6 +198,7 @@ int dma_release_from_global_coherent(int order,
> >> void *vaddr);
> >>   int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *=
cpu_addr,
> >>                  size_t size, int *ret);
> >>   int dma_init_global_coherent(phys_addr_t phys_addr, size_t size);
> >> +bool dma_global_pool_available(void);
> >>   #else
> >>   static inline void *dma_alloc_from_global_coherent(struct device *de=
v,
> >>                  ssize_t size, dma_addr_t *dma_handle)
> >> @@ -213,6 +214,10 @@ static inline int
> >> dma_mmap_from_global_coherent(struct vm_area_struct *vma,
> >>   {
> >>          return 0;
> >>   }
> >> +static inline bool dma_global_pool_available(void)
> >> +{
> >> +       return false;
> >> +}
> >>   #endif /* CONFIG_DMA_GLOBAL_POOL */
> >>
> >>   /*
> >> diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
> >> index c21abc77c53e..605f243b8262 100644
> >> --- a/kernel/dma/coherent.c
> >> +++ b/kernel/dma/coherent.c
> >> @@ -277,6 +277,14 @@ int dma_mmap_from_dev_coherent(struct device
> >> *dev, struct vm_area_struct *vma,
> >>   #ifdef CONFIG_DMA_GLOBAL_POOL
> >>   static struct dma_coherent_mem *dma_coherent_default_memory __ro_aft=
er_init;
> >>
> >> +bool dma_global_pool_available(void)
> >> +{
> >> +       if (!dma_coherent_default_memory)
> >> +               return false;
> >> +
> >> +       return true;
> >> +}
> >> +
> >>   void *dma_alloc_from_global_coherent(struct device *dev, ssize_t siz=
e,
> >>                                       dma_addr_t *dma_handle)
> >>   {
> >> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> >> index 9596ae1aa0da..a599bb731ceb 100644
> >> --- a/kernel/dma/direct.c
> >> +++ b/kernel/dma/direct.c
> >> @@ -235,7 +235,7 @@ void *dma_direct_alloc(struct device *dev, size_t =
size,
> >>                   * If there is a global pool, always allocate from it=
 for
> >>                   * non-coherent devices.
> >>                   */
> >> -               if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL))
> >> +               if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
> >> dma_global_pool_available())
> >>                          return dma_alloc_from_global_coherent(dev, si=
ze,
> >>                                          dma_handle);
> >
> > dma_alloc_from_global_coherent() already checks dma_coherent_default_me=
mory, so
> > the solution could be even simpler:
> >
> > --- a/kernel/dma/direct.c
> > +++ b/kernel/dma/direct.c
> > @@ -232,12 +232,12 @@ void *dma_direct_alloc(struct device *dev, size_t=
 size,
> >                                             attrs);
> >
> >               /*
> > -              * If there is a global pool, always allocate from it for
> > +              * If there is a global pool, always try to allocate from=
 it for
> >                * non-coherent devices.
> >                */
> > -             if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL))
> > -                     return dma_alloc_from_global_coherent(dev, size,
> > -                                     dma_handle);
> > +             ret =3D dma_alloc_from_global_coherent(dev, size, dma_han=
dle);
> > +             if (ret)
> > +                     return ret;
>
> So if allocation fails because the pool is full, we should go ahead and
> remap something that can't work? ;)
>
> The dma_global_pool_available() idea sort of works, but I'm still
> concerned about the case where it *should* have been available but the
> platform has been misconfigured, so again we fall through to
>
If the platform is misconfigured it is bound to fail anyway so should
we consider that as a valid case?

> DMA_DIRECT_REMAP "successfully" returning a coherent buffer that isn't,
> and the user's filesystem gets corrupted. Or at best, they get confused
> by weird errors from random devices going wrong. That's why I said it
> would be fiddly - the current state of DMA_GLOBAL_POOL as a binary
> arch-wide thing is relatively robust and easy to reason about, but
> attempting to generalise it further is... less so.
>
> Thanks,
> Robin.
>

Cheers,
Prabhakar
