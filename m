Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6C1766396
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 07:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjG1FTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 01:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjG1FTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 01:19:04 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4694430D4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 22:19:03 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-55e1ae72dceso1217800eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 22:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690521542; x=1691126342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dA4h1wXuO+RqiKn56Fbjhd22WJLs7KDtxnH5lEYDThw=;
        b=rCCGFQOaheftq0HBV0LLW8L+L/v6ll8/foJApxGYX++40jda1h5c0MWTF5uv35NOCF
         yaH9NHb3PZpu3nzpkBd3mt1WnPtZ9z3ydmeagEC8cU1Hfk8th+iT9nfxFuTWfKWNMdq8
         n8wnb1rM3D6J0b3bhLL4G4KA3L8KDqw1kOgvKizfcveQ1uA1cuV2lFWT2zG67WZr6YEU
         ng2su2EY9hqNPdMBPtdMPPSk0j8ev6ZR+5zcP8/HacSMRejTg4ZwLEfDbEunGix1l0YX
         DndlAnMka4ykXJbXYC7WjlDVBN+bD7cZ0CXFDvOTrx37mCops+MAyXcQT3agmOs2Veow
         PzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690521542; x=1691126342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dA4h1wXuO+RqiKn56Fbjhd22WJLs7KDtxnH5lEYDThw=;
        b=SDSHpzj8nF40Qjl3qw4z+f6ECszcTn0vucnAD+lLMMn+d98RpIPg/SiJqDDSWVv5Aa
         pJH/YOT16AEnzIC57U2kwhxH2vhP2dNJxtGerdcO6yFaC7sSlX+dKG2CANiARg8irCW6
         Uk9tNZwrAuzKV2TWWLEm/bGPr9sAp+nJaSzyShSVFcGYUKuK/zFsmkGAX/nlRxXUUEWv
         yPBrttZzIGrmujbj8gzbZ55uQCPxZC0AkOy/twb4nEYrYLDsyP0mKnd3V8K0HBFGYQJO
         UDJhd6taAoIuoZMXplqXCfdWk8kpVpblscVpn27/+IJ37zoCaxtmTUHMZfnq1u/JTauL
         ij4Q==
X-Gm-Message-State: ABy/qLbWcynjHLdXx5x+u98JZqG/mkk/PoMjGKDn+B6cvBJf2AbSpA/B
        8Re/lq1FsQTVYazetprQmbelril1Jrw+oFrVrlX6/pQHyZDfrmp4jDo=
X-Google-Smtp-Source: APBJJlHSydpCNCH72+CyJD9Ih+I/nhI+XXfo842aQixN2GlXK2CsCxImcW2/Puw6DSs7Cz69xxqmvHQF4lkXRvRAEfA=
X-Received: by 2002:a05:6808:f05:b0:3a0:5ee3:ea67 with SMTP id
 m5-20020a0568080f0500b003a05ee3ea67mr2125638oiw.16.1690521542545; Thu, 27 Jul
 2023 22:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <1fd79e5c53d9d6ed2264f60dd4261f293cc00472.1689792825.git.tjeznach@rivosinc.com>
 <5b8fd18e-8dfa-96bf-cdd4-4498b1d15ab9@ics.forth.gr> <CAH2o1u7uAuXsD6+6Dvam4kzQuUj8s98G0sR26_-q31wvSUYZNA@mail.gmail.com>
 <CANXhq0rz1J+0t9M-e5NY015HhDT1Yy024_-Uan9CSJ4rMqtyng@mail.gmail.com>
In-Reply-To: <CANXhq0rz1J+0t9M-e5NY015HhDT1Yy024_-Uan9CSJ4rMqtyng@mail.gmail.com>
From:   Tomasz Jeznach <tjeznach@rivosinc.com>
Date:   Fri, 28 Jul 2023 07:18:51 +0200
Message-ID: <CAH2o1u6TaQ2PLcKRuSpcqh4Q5qUriimSZ1hmmy=37R2378NCUA@mail.gmail.com>
Subject: Re: [PATCH 06/11] RISC-V: drivers/iommu/riscv: Add command, fault,
 page-req queues
To:     Zong Li <zong.li@sifive.com>
Cc:     Nick Kossifidis <mick@ics.forth.gr>,
        Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org, Sebastien Boeuf <seb@rivosinc.com>,
        iommu@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 11:47=E2=80=AFAM Zong Li <zong.li@sifive.com> wrote=
:
>
> On Fri, Jul 21, 2023 at 2:00=E2=80=AFAM Tomasz Jeznach <tjeznach@rivosinc=
.com> wrote:
> >
> > On Wed, Jul 19, 2023 at 8:12=E2=80=AFPM Nick Kossifidis <mick@ics.forth=
.gr> wrote:
> > >
> > > Hello Tomasz,
> > >
> > > On 7/19/23 22:33, Tomasz Jeznach wrote:
> > > > Enables message or wire signal interrupts for PCIe and platforms de=
vices.
> > > >
> > >
> > > The description doesn't match the subject nor the patch content (we
> > > don't jus enable interrupts, we also init the queues).
> > >
> > > > +     /* Parse Queue lengts */
> > > > +     ret =3D of_property_read_u32(pdev->dev.of_node, "cmdq_len", &=
iommu->cmdq_len);
> > > > +     if (!ret)
> > > > +             dev_info(dev, "command queue length set to %i\n", iom=
mu->cmdq_len);
> > > > +
> > > > +     ret =3D of_property_read_u32(pdev->dev.of_node, "fltq_len", &=
iommu->fltq_len);
> > > > +     if (!ret)
> > > > +             dev_info(dev, "fault/event queue length set to %i\n",=
 iommu->fltq_len);
> > > > +
> > > > +     ret =3D of_property_read_u32(pdev->dev.of_node, "priq_len", &=
iommu->priq_len);
> > > > +     if (!ret)
> > > > +             dev_info(dev, "page request queue length set to %i\n"=
, iommu->priq_len);
> > > > +
> > > >       dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> > > >
> > >
> > > We need to add those to the device tree binding doc (or throw them aw=
ay,
> > > I thought it would be better to have them as part of the device
> > > desciption than a module parameter).
> > >
> >
> > We can add them as an optional fields to DT.
> > Alternatively, I've been looking into an option to auto-scale CQ/PQ
> > based on number of attached devices, but this gets trickier for
> > hot-pluggable systems. I've added module parameters as a bare-minimum,
> > but still looking for better solutions.
> >
> > >
> > > > +static irqreturn_t riscv_iommu_priq_irq_check(int irq, void *data)=
;
> > > > +static irqreturn_t riscv_iommu_priq_process(int irq, void *data);
> > > > +
> > >
> > > > +     case RISCV_IOMMU_PAGE_REQUEST_QUEUE:
> > > > +             q =3D &iommu->priq;
> > > > +             q->len =3D sizeof(struct riscv_iommu_pq_record);
> > > > +             count =3D iommu->priq_len;
> > > > +             irq =3D iommu->irq_priq;
> > > > +             irq_check =3D riscv_iommu_priq_irq_check;
> > > > +             irq_process =3D riscv_iommu_priq_process;
> > > > +             q->qbr =3D RISCV_IOMMU_REG_PQB;
> > > > +             q->qcr =3D RISCV_IOMMU_REG_PQCSR;
> > > > +             name =3D "priq";
> > > > +             break;
> > >
> > >
> > > It makes more sense to add the code for the page request queue in the
> > > patch that adds ATS/PRI support IMHO. This comment also applies to it=
s
> > > interrupt handlers below.
> > >
> >
> > ack. will do.
> >
> > >
> > > > +static inline void riscv_iommu_cmd_inval_set_addr(struct riscv_iom=
mu_command *cmd,
> > > > +                                               u64 addr)
> > > > +{
> > > > +     cmd->dword0 |=3D RISCV_IOMMU_CMD_IOTINVAL_AV;
> > > > +     cmd->dword1 =3D addr;
> > > > +}
> > > > +
> > >
> > > This needs to be (addr >> 2) to match the spec, same as in the iofenc=
e
> > > command.
> > >
> >
> > oops. Thanks!
> >
>
> I think it should be (addr >> 12) according to the spec.
>

My reading of the spec '3.1.1. IOMMU Page-Table cache invalidation commands=
'
is that it is a 4k page aligned address packed at dword1[61:10], so
effectively shifted by 2 bits.

regards,
- Tomasz

> > > Regards,
> > > Nick
> > >
> >
> > regards,
> > - Tomasz
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
