Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1936B7667BA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbjG1Iu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235179AbjG1IuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:50:02 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51ECF4C21
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 01:49:02 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7906614bc90so56968039f.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 01:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1690534124; x=1691138924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csmJdueaYe4TxgWwO4Wd3yP+V9n21yRw5VpjM04yUXk=;
        b=BM2vivVtM0Vi8txgqqrMMVb/gEDggT3Tp7zPzwqBmVjYZjyemJMBl2CnhFcmwoK3VQ
         5stAE9+DdzguzRWN33KZEG+VBG8c7XDe5pfdv5xrw5IJYGmPCGgQ3i5oF9DJDcCmzGwK
         6495KdKqI1WSIrcw87ndvyo3xlljoPnBbM/rPT14u/Z6dR8XWFQNUvHqbIu/pfbppDqW
         +GAyql6/CUacfDF7OnqUqwVrJxdk9Tjl6iSbHXyhbkDoczvCZaoniefnBZ6H5Vh6Akc4
         VhPCu8cG8U2KsJmvs8g94sbhlmpRjxKqR8K17VLffXR/eTxQ2zxDnpHXrf4GgzKOqyBq
         MRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690534124; x=1691138924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csmJdueaYe4TxgWwO4Wd3yP+V9n21yRw5VpjM04yUXk=;
        b=Gp0UUcXvnCoFI/Z7lVt7qavMZ8UXYJTg6/IRvU/ljsx5Ov6r7ajNiecKuZFtUDGgHc
         +79SJwnWrol0qbBJ9BZD9fVeLFnh0J3r/Zb8Qv7/xGVkb74Oi65hINROa+5uoz9MuUY+
         4crNsaRr6gk0MhN7yTqpKq3vbLloMaKp26uYVnLEmbsrs1fbaICXNU1upk3UcHDKdjz9
         7yR3oLznORiiUWwFZohTQB2aYTSmsuGn3LUJqzp9C8QxJzdQ9ig9EKvc1LbpLH+w++iH
         5Ukp2/h7TysH+hXESB7IyxpeTAf98HyIsDrQNL6w6/P1iS1Rx8W8sP7wuR9PVLN0BeOf
         1C0w==
X-Gm-Message-State: ABy/qLYP+YrEqkWQMxvqoMgkwTS7QAvkseg06zOYQiQQd95ml2lyb8Q0
        hXpdlErWkBWJmbmzB9sNdXFqF1rjOQdNDjo4DuXYIw==
X-Google-Smtp-Source: APBJJlHXzbuDXRfZ01YQCScE+IuEs9Tr6or3RH84HjbXeEzCJBbzJyNhFuapVEmPS3Ihqc7dQPiElvgnG37NjgZYaT4=
X-Received: by 2002:a5e:990d:0:b0:785:ff35:f340 with SMTP id
 t13-20020a5e990d000000b00785ff35f340mr2426775ioj.14.1690534124749; Fri, 28
 Jul 2023 01:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <1fd79e5c53d9d6ed2264f60dd4261f293cc00472.1689792825.git.tjeznach@rivosinc.com>
 <5b8fd18e-8dfa-96bf-cdd4-4498b1d15ab9@ics.forth.gr> <CAH2o1u7uAuXsD6+6Dvam4kzQuUj8s98G0sR26_-q31wvSUYZNA@mail.gmail.com>
 <CANXhq0rz1J+0t9M-e5NY015HhDT1Yy024_-Uan9CSJ4rMqtyng@mail.gmail.com> <CAH2o1u6TaQ2PLcKRuSpcqh4Q5qUriimSZ1hmmy=37R2378NCUA@mail.gmail.com>
In-Reply-To: <CAH2o1u6TaQ2PLcKRuSpcqh4Q5qUriimSZ1hmmy=37R2378NCUA@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Fri, 28 Jul 2023 16:48:32 +0800
Message-ID: <CANXhq0o40cFhVzk=eMuEXrjccSjTuTtdyu5L23bFDpzH5iPdkQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 1:19=E2=80=AFPM Tomasz Jeznach <tjeznach@rivosinc.c=
om> wrote:
>
> On Mon, Jul 24, 2023 at 11:47=E2=80=AFAM Zong Li <zong.li@sifive.com> wro=
te:
> >
> > On Fri, Jul 21, 2023 at 2:00=E2=80=AFAM Tomasz Jeznach <tjeznach@rivosi=
nc.com> wrote:
> > >
> > > On Wed, Jul 19, 2023 at 8:12=E2=80=AFPM Nick Kossifidis <mick@ics.for=
th.gr> wrote:
> > > >
> > > > Hello Tomasz,
> > > >
> > > > On 7/19/23 22:33, Tomasz Jeznach wrote:
> > > > > Enables message or wire signal interrupts for PCIe and platforms =
devices.
> > > > >
> > > >
> > > > The description doesn't match the subject nor the patch content (we
> > > > don't jus enable interrupts, we also init the queues).
> > > >
> > > > > +     /* Parse Queue lengts */
> > > > > +     ret =3D of_property_read_u32(pdev->dev.of_node, "cmdq_len",=
 &iommu->cmdq_len);
> > > > > +     if (!ret)
> > > > > +             dev_info(dev, "command queue length set to %i\n", i=
ommu->cmdq_len);
> > > > > +
> > > > > +     ret =3D of_property_read_u32(pdev->dev.of_node, "fltq_len",=
 &iommu->fltq_len);
> > > > > +     if (!ret)
> > > > > +             dev_info(dev, "fault/event queue length set to %i\n=
", iommu->fltq_len);
> > > > > +
> > > > > +     ret =3D of_property_read_u32(pdev->dev.of_node, "priq_len",=
 &iommu->priq_len);
> > > > > +     if (!ret)
> > > > > +             dev_info(dev, "page request queue length set to %i\=
n", iommu->priq_len);
> > > > > +
> > > > >       dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> > > > >
> > > >
> > > > We need to add those to the device tree binding doc (or throw them =
away,
> > > > I thought it would be better to have them as part of the device
> > > > desciption than a module parameter).
> > > >
> > >
> > > We can add them as an optional fields to DT.
> > > Alternatively, I've been looking into an option to auto-scale CQ/PQ
> > > based on number of attached devices, but this gets trickier for
> > > hot-pluggable systems. I've added module parameters as a bare-minimum=
,
> > > but still looking for better solutions.
> > >
> > > >
> > > > > +static irqreturn_t riscv_iommu_priq_irq_check(int irq, void *dat=
a);
> > > > > +static irqreturn_t riscv_iommu_priq_process(int irq, void *data)=
;
> > > > > +
> > > >
> > > > > +     case RISCV_IOMMU_PAGE_REQUEST_QUEUE:
> > > > > +             q =3D &iommu->priq;
> > > > > +             q->len =3D sizeof(struct riscv_iommu_pq_record);
> > > > > +             count =3D iommu->priq_len;
> > > > > +             irq =3D iommu->irq_priq;
> > > > > +             irq_check =3D riscv_iommu_priq_irq_check;
> > > > > +             irq_process =3D riscv_iommu_priq_process;
> > > > > +             q->qbr =3D RISCV_IOMMU_REG_PQB;
> > > > > +             q->qcr =3D RISCV_IOMMU_REG_PQCSR;
> > > > > +             name =3D "priq";
> > > > > +             break;
> > > >
> > > >
> > > > It makes more sense to add the code for the page request queue in t=
he
> > > > patch that adds ATS/PRI support IMHO. This comment also applies to =
its
> > > > interrupt handlers below.
> > > >
> > >
> > > ack. will do.
> > >
> > > >
> > > > > +static inline void riscv_iommu_cmd_inval_set_addr(struct riscv_i=
ommu_command *cmd,
> > > > > +                                               u64 addr)
> > > > > +{
> > > > > +     cmd->dword0 |=3D RISCV_IOMMU_CMD_IOTINVAL_AV;
> > > > > +     cmd->dword1 =3D addr;
> > > > > +}
> > > > > +
> > > >
> > > > This needs to be (addr >> 2) to match the spec, same as in the iofe=
nce
> > > > command.
> > > >
> > >
> > > oops. Thanks!
> > >
> >
> > I think it should be (addr >> 12) according to the spec.
> >
>
> My reading of the spec '3.1.1. IOMMU Page-Table cache invalidation comman=
ds'
> is that it is a 4k page aligned address packed at dword1[61:10], so
> effectively shifted by 2 bits.

Thanks for your clarifying. Just an opinion, perhaps you can use
'FIELD_PREP()' on it as well, it might be clearer.

>
> regards,
> - Tomasz
>
> > > > Regards,
> > > > Nick
> > > >
> > >
> > > regards,
> > > - Tomasz
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
