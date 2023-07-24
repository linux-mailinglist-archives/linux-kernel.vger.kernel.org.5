Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF6A75F07A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 11:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjGXJv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 05:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjGXJug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:50:36 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91A535A2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:48:14 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-78847bb8940so230797039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1690192068; x=1690796868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8bfGUj6PVSplOllAd2MEpS6lx5ONn993m33c0NCbEw=;
        b=eG+k/0eQ1dVjbqUi+Fgm5PV75urijLYhKsnv1AN21qidWsleaq1GIF1yDsE1SYlpcS
         T1BxyDHhpVghbdpylHZWvEkgNNXNsUhPOhkVR8ztiRuD38F3hfD5yQS0Kq7CCZmCY1wt
         KsRe23hLlzfw1YizGD0LyDsk9NdWHCl6NGAIqVzPI0doFxxf1ycp5HjHdw2u2iKzaIKk
         TiVKYNEmEpfQmhNW9llQU5t5Xriof54H/K3G5MSMVJ9/HCFuo9E32mevzrPPrJJAaXmt
         fOgsXcbEw7RdxuFumYd8xkSO8kzeatorXj3eZK3kKdFo3ZGLz4dbfiLi8cg6wEHOxhYD
         W6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690192068; x=1690796868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8bfGUj6PVSplOllAd2MEpS6lx5ONn993m33c0NCbEw=;
        b=XmxPLw6O/U4i6D7VrVdvSpdmyWlAdnS4DhhPmCS7K5TY1m7JAVbmLJwXH9Nx3nvF6P
         E5rk6vKcec2EuLve9D3OVWV9RXF6MivvF3ztR1xRZkaXRWDSwCb3+3/K9rJ293Y8n3Tq
         YpU4gp1bwElGfrjoptRsRv1fB02BrndGuYmew+pR+PT7u2LMOo9y6+h9TRwLlH/A+ltm
         VIMETzuyJsBaTqknqcFej9GkQ19zWozDz/kZe/KMS5GpulWIoEO2QQhdRoshz/B9DujH
         EqrSU5TKWcwdNN1e9a78nglYpROix+tlOkdzbIxbt5iNXOv4TlQobL1h+fCiMpJjmt4B
         XtDw==
X-Gm-Message-State: ABy/qLaDfyFWi/eJlm2kmXqVZ7OYOsF6x3nGJt4jb+dVlON/i7CsixKc
        aMUY1QojpD1gM/eZ8lSamwYaLCRTM/cliri1CYQyiw==
X-Google-Smtp-Source: APBJJlGfSvBbIxJHAJLERDdIj18GqzcBJdh2D0XeEHGN9JTosZLxsbRqgvszSigLLVQzezIwjDLaussRKBoZe3KwqTw=
X-Received: by 2002:a5d:81d1:0:b0:783:74c0:54ae with SMTP id
 t17-20020a5d81d1000000b0078374c054aemr6940592iol.21.1690192068270; Mon, 24
 Jul 2023 02:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <1fd79e5c53d9d6ed2264f60dd4261f293cc00472.1689792825.git.tjeznach@rivosinc.com>
 <5b8fd18e-8dfa-96bf-cdd4-4498b1d15ab9@ics.forth.gr> <CAH2o1u7uAuXsD6+6Dvam4kzQuUj8s98G0sR26_-q31wvSUYZNA@mail.gmail.com>
In-Reply-To: <CAH2o1u7uAuXsD6+6Dvam4kzQuUj8s98G0sR26_-q31wvSUYZNA@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Mon, 24 Jul 2023 17:47:37 +0800
Message-ID: <CANXhq0rz1J+0t9M-e5NY015HhDT1Yy024_-Uan9CSJ4rMqtyng@mail.gmail.com>
Subject: Re: [PATCH 06/11] RISC-V: drivers/iommu/riscv: Add command, fault,
 page-req queues
To:     Tomasz Jeznach <tjeznach@rivosinc.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 2:00=E2=80=AFAM Tomasz Jeznach <tjeznach@rivosinc.c=
om> wrote:
>
> On Wed, Jul 19, 2023 at 8:12=E2=80=AFPM Nick Kossifidis <mick@ics.forth.g=
r> wrote:
> >
> > Hello Tomasz,
> >
> > On 7/19/23 22:33, Tomasz Jeznach wrote:
> > > Enables message or wire signal interrupts for PCIe and platforms devi=
ces.
> > >
> >
> > The description doesn't match the subject nor the patch content (we
> > don't jus enable interrupts, we also init the queues).
> >
> > > +     /* Parse Queue lengts */
> > > +     ret =3D of_property_read_u32(pdev->dev.of_node, "cmdq_len", &io=
mmu->cmdq_len);
> > > +     if (!ret)
> > > +             dev_info(dev, "command queue length set to %i\n", iommu=
->cmdq_len);
> > > +
> > > +     ret =3D of_property_read_u32(pdev->dev.of_node, "fltq_len", &io=
mmu->fltq_len);
> > > +     if (!ret)
> > > +             dev_info(dev, "fault/event queue length set to %i\n", i=
ommu->fltq_len);
> > > +
> > > +     ret =3D of_property_read_u32(pdev->dev.of_node, "priq_len", &io=
mmu->priq_len);
> > > +     if (!ret)
> > > +             dev_info(dev, "page request queue length set to %i\n", =
iommu->priq_len);
> > > +
> > >       dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> > >
> >
> > We need to add those to the device tree binding doc (or throw them away=
,
> > I thought it would be better to have them as part of the device
> > desciption than a module parameter).
> >
>
> We can add them as an optional fields to DT.
> Alternatively, I've been looking into an option to auto-scale CQ/PQ
> based on number of attached devices, but this gets trickier for
> hot-pluggable systems. I've added module parameters as a bare-minimum,
> but still looking for better solutions.
>
> >
> > > +static irqreturn_t riscv_iommu_priq_irq_check(int irq, void *data);
> > > +static irqreturn_t riscv_iommu_priq_process(int irq, void *data);
> > > +
> >
> > > +     case RISCV_IOMMU_PAGE_REQUEST_QUEUE:
> > > +             q =3D &iommu->priq;
> > > +             q->len =3D sizeof(struct riscv_iommu_pq_record);
> > > +             count =3D iommu->priq_len;
> > > +             irq =3D iommu->irq_priq;
> > > +             irq_check =3D riscv_iommu_priq_irq_check;
> > > +             irq_process =3D riscv_iommu_priq_process;
> > > +             q->qbr =3D RISCV_IOMMU_REG_PQB;
> > > +             q->qcr =3D RISCV_IOMMU_REG_PQCSR;
> > > +             name =3D "priq";
> > > +             break;
> >
> >
> > It makes more sense to add the code for the page request queue in the
> > patch that adds ATS/PRI support IMHO. This comment also applies to its
> > interrupt handlers below.
> >
>
> ack. will do.
>
> >
> > > +static inline void riscv_iommu_cmd_inval_set_addr(struct riscv_iommu=
_command *cmd,
> > > +                                               u64 addr)
> > > +{
> > > +     cmd->dword0 |=3D RISCV_IOMMU_CMD_IOTINVAL_AV;
> > > +     cmd->dword1 =3D addr;
> > > +}
> > > +
> >
> > This needs to be (addr >> 2) to match the spec, same as in the iofence
> > command.
> >
>
> oops. Thanks!
>

I think it should be (addr >> 12) according to the spec.

> > Regards,
> > Nick
> >
>
> regards,
> - Tomasz
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
