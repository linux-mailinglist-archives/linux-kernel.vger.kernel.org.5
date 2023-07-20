Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA2475B608
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjGTSA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 14:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjGTSAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:00:25 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15712733
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:00:21 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-38c35975545so784177b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689876021; x=1690480821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbYc3nOyz3w0g5N21KHrIHLBOSDWflXwjWJQLgw2CWk=;
        b=ZTcWs0IsdaJVr+puZZx6YFyGQGkpYLbfH6SJWfFTUCXLhR665GcAL8lMLKOKXPPAv5
         Y/+03uQ3B2pMx1HBNXQq6JdI0nexaVwAEyWoz/3PYY+Jq8p1tok1DbVd02FVSaQbEdup
         Zn+BQdURIvNu/YUHsDIR2PbCYn2M+KK/R3KrKracp43QGkgPOTzpZbPrvCvA/Pylp+r8
         rYxcjm18i1UK/m4Lv3FUmeKmYI0hACI1kcFneRYjQfq+DqluC4XlLZWF3PhHC3iaSddF
         adjD9CanElVSXbIofcTmQriFiEUwHJbCW1ZkPL5bGWNUTT/vllerVdN0nCw1m1BH3Sad
         gtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689876021; x=1690480821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbYc3nOyz3w0g5N21KHrIHLBOSDWflXwjWJQLgw2CWk=;
        b=DA5XRQpYFAqWAF/phtgP9ugCMavyUNXv8JgVo3ZS66/7SnRvSxr26lg9RQgRUSdFcC
         lXzD62w+2gZg7IjGTn7YpPMrG7PfmYlfVcid/2k2DzsAm7B40BXoUXbDVTNU/rcLg0+D
         EI7kDqLfojA3sh2WqH9mnXONUmEQkifp3pbmT4GB9sDngHc6QAtkE83J+8hyjTApmkd0
         GmYPxwLXoYZAcQGhfSPXZObFXXhVkhFErk6HO2GL4lZAuu9g2Ttc0e364H8axUsMiuzq
         398aHatsCqRE/jZvF8R+33PNRnSCRkopvKMCkx3VP+NNfkpGYQhWhj5t1bV/B+xfUqjk
         EgbQ==
X-Gm-Message-State: ABy/qLZZOJ/rB1kuKg8LhOE043vMKkLY37CKGM+iDvOqhrnAtWWRydgc
        xZ6XchQqt3Sun4GdZ9eTSvZRJRUdmRiVZiSnRqbriQ==
X-Google-Smtp-Source: APBJJlG52Rb02KkBG7WCWyzJeoWISmJNBOh4rKJA34OBgfty1aWkRdipEyXQi+tR07GSAKJXWo2n35OGLa+TciKgCEM=
X-Received: by 2002:a05:6808:11c9:b0:3a3:7248:252a with SMTP id
 p9-20020a05680811c900b003a37248252amr222247oiv.0.1689876021113; Thu, 20 Jul
 2023 11:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <1fd79e5c53d9d6ed2264f60dd4261f293cc00472.1689792825.git.tjeznach@rivosinc.com>
 <5b8fd18e-8dfa-96bf-cdd4-4498b1d15ab9@ics.forth.gr>
In-Reply-To: <5b8fd18e-8dfa-96bf-cdd4-4498b1d15ab9@ics.forth.gr>
From:   Tomasz Jeznach <tjeznach@rivosinc.com>
Date:   Thu, 20 Jul 2023 11:00:10 -0700
Message-ID: <CAH2o1u7uAuXsD6+6Dvam4kzQuUj8s98G0sR26_-q31wvSUYZNA@mail.gmail.com>
Subject: Re: [PATCH 06/11] RISC-V: drivers/iommu/riscv: Add command, fault,
 page-req queues
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 8:12=E2=80=AFPM Nick Kossifidis <mick@ics.forth.gr>=
 wrote:
>
> Hello Tomasz,
>
> On 7/19/23 22:33, Tomasz Jeznach wrote:
> > Enables message or wire signal interrupts for PCIe and platforms device=
s.
> >
>
> The description doesn't match the subject nor the patch content (we
> don't jus enable interrupts, we also init the queues).
>
> > +     /* Parse Queue lengts */
> > +     ret =3D of_property_read_u32(pdev->dev.of_node, "cmdq_len", &iomm=
u->cmdq_len);
> > +     if (!ret)
> > +             dev_info(dev, "command queue length set to %i\n", iommu->=
cmdq_len);
> > +
> > +     ret =3D of_property_read_u32(pdev->dev.of_node, "fltq_len", &iomm=
u->fltq_len);
> > +     if (!ret)
> > +             dev_info(dev, "fault/event queue length set to %i\n", iom=
mu->fltq_len);
> > +
> > +     ret =3D of_property_read_u32(pdev->dev.of_node, "priq_len", &iomm=
u->priq_len);
> > +     if (!ret)
> > +             dev_info(dev, "page request queue length set to %i\n", io=
mmu->priq_len);
> > +
> >       dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> >
>
> We need to add those to the device tree binding doc (or throw them away,
> I thought it would be better to have them as part of the device
> desciption than a module parameter).
>

We can add them as an optional fields to DT.
Alternatively, I've been looking into an option to auto-scale CQ/PQ
based on number of attached devices, but this gets trickier for
hot-pluggable systems. I've added module parameters as a bare-minimum,
but still looking for better solutions.

>
> > +static irqreturn_t riscv_iommu_priq_irq_check(int irq, void *data);
> > +static irqreturn_t riscv_iommu_priq_process(int irq, void *data);
> > +
>
> > +     case RISCV_IOMMU_PAGE_REQUEST_QUEUE:
> > +             q =3D &iommu->priq;
> > +             q->len =3D sizeof(struct riscv_iommu_pq_record);
> > +             count =3D iommu->priq_len;
> > +             irq =3D iommu->irq_priq;
> > +             irq_check =3D riscv_iommu_priq_irq_check;
> > +             irq_process =3D riscv_iommu_priq_process;
> > +             q->qbr =3D RISCV_IOMMU_REG_PQB;
> > +             q->qcr =3D RISCV_IOMMU_REG_PQCSR;
> > +             name =3D "priq";
> > +             break;
>
>
> It makes more sense to add the code for the page request queue in the
> patch that adds ATS/PRI support IMHO. This comment also applies to its
> interrupt handlers below.
>

ack. will do.

>
> > +static inline void riscv_iommu_cmd_inval_set_addr(struct riscv_iommu_c=
ommand *cmd,
> > +                                               u64 addr)
> > +{
> > +     cmd->dword0 |=3D RISCV_IOMMU_CMD_IOTINVAL_AV;
> > +     cmd->dword1 =3D addr;
> > +}
> > +
>
> This needs to be (addr >> 2) to match the spec, same as in the iofence
> command.
>

oops. Thanks!

> Regards,
> Nick
>

regards,
- Tomasz
