Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4537C76D871
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 22:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjHBUPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 16:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjHBUPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 16:15:35 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDDE2689
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 13:15:34 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-53482b44007so100198a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 13:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691007334; x=1691612134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqaiD0oWwblWodb1STkSm+MDiqVpucLuhqfe3hzQhdE=;
        b=yAiX8FxYkc605M0cG+7yI0Nl+xuCcB1+e2VLfkaxupBO4Hj4NNiGpqu1274aRHw/KB
         QFTNVLNa2vGOhhLnixSOScJrplMeRvS6oweKOEiuYnxobjOL980rDlte4j8dvjXY82dL
         JLVEYMK1nPzTZMK1x5bzfn0tY3JhzreMu/znJxGySZrF8hq4I7VWEfjgXn3zWMR3+57H
         IRf+OcXBUUPMf+yycDv7kFDnp4dGE8uJACu/C93f0R/plZXHkX7E/p9Xbcd34jFW3CdN
         pomzxFkfzRUvhRLvj6raPg5WHZI9z56OG97ChW6kAjslaZA72E9OyTlUnZwXw0MB4f9Y
         vZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691007334; x=1691612134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bqaiD0oWwblWodb1STkSm+MDiqVpucLuhqfe3hzQhdE=;
        b=FyStZVnHYdNPST19PQDY0WG+PE/8JGNg39+MmLbLOi9DWHftMXe7uFk9aEbBoSlN1h
         su6JdsrIcPGxXbr6g8j1mxwwFi1FaKyW0Uce8n5b4dmqaMqzjTDRWQLO4YlRJmMISmTN
         Xs5A2Lb/fM0WfvSyk1FTw+H0wXjp8KbRw9nD0MVhlarW86tiaBr81xT9uiPkQeYyRNIz
         jsVlAaF6GDThEpC+g9DlHMaQTy+By748bIvNlYehCgtEljeB6yMho1SYBgtiZcx53gxR
         HSDjNGvc8ahzUm/4EVDI7x79Aq1OemxrwgJIRXDVMPSnk1+fBxV29hsJNr/TFPWG+JxX
         tNIg==
X-Gm-Message-State: AOJu0YzVCKUoAjqhjl55V34ZJDf/DCFWRCtO7LIwR9xrbOcH/+Atzm64
        zVDxu6PTnn3PyshZyhvE/Orjqu3GebN+6aFcTQVHYw==
X-Google-Smtp-Source: AGHT+IEldlUzLdMbLeNZ5QAQ0zR94lcB3YjBYjuINZSrYFnfre7W0+RGSobst9wqQSqSuGXumKZlxDhigTUDgnGM86U=
X-Received: by 2002:a17:90b:110f:b0:268:fb85:3b2 with SMTP id
 gi15-20020a17090b110f00b00268fb8503b2mr3104373pjb.7.1691007333727; Wed, 02
 Aug 2023 13:15:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <c33c24036c06c023947ecb47177da273569b3ac7.1689792825.git.tjeznach@rivosinc.com>
 <CANXhq0qRYvTffMnep-aQyTq2tMxbP-s_Lunc+cZ2Rio+BvAE=g@mail.gmail.com>
In-Reply-To: <CANXhq0qRYvTffMnep-aQyTq2tMxbP-s_Lunc+cZ2Rio+BvAE=g@mail.gmail.com>
From:   Tomasz Jeznach <tjeznach@rivosinc.com>
Date:   Wed, 2 Aug 2023 13:15:22 -0700
Message-ID: <CAH2o1u5Sr0XigUbhna0E-Zk=U76CLZZ4LbM0u4ahPaN5+nOK6A@mail.gmail.com>
Subject: Re: [PATCH 01/11] RISC-V: drivers/iommu: Add RISC-V IOMMU - Ziommu support.
To:     Zong Li <zong.li@sifive.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com,
        linux-kernel@vger.kernel.org, Sebastien Boeuf <seb@rivosinc.com>,
        iommu@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv@lists.infradead.org
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

On Thu, Jul 27, 2023 at 7:42=E2=80=AFPM Zong Li <zong.li@sifive.com> wrote:
>
> On Thu, Jul 20, 2023 at 3:34=E2=80=AFAM Tomasz Jeznach <tjeznach@rivosinc=
.com> wrote:
> >
> > +static int riscv_iommu_platform_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev =3D &pdev->dev;
> > +       struct riscv_iommu_device *iommu =3D NULL;
> > +       struct resource *res =3D NULL;
> > +       int ret =3D 0;
> > +
> > +       iommu =3D devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
> > +       if (!iommu)
> > +               return -ENOMEM;
> > +
> > +       iommu->dev =3D dev;
> > +       dev_set_drvdata(dev, iommu);
> > +
> > +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       if (!res) {
> > +               dev_err(dev, "could not find resource for register regi=
on\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       iommu->reg =3D devm_platform_get_and_ioremap_resource(pdev, 0, =
&res);
> > +       if (IS_ERR(iommu->reg)) {
> > +               ret =3D dev_err_probe(dev, PTR_ERR(iommu->reg),
> > +                                   "could not map register region\n");
> > +               goto fail;
> > +       };
> > +
> > +       iommu->reg_phys =3D res->start;
> > +
> > +       ret =3D -ENODEV;
> > +
> > +       /* Sanity check: Did we get the whole register space ? */
> > +       if ((res->end - res->start + 1) < RISCV_IOMMU_REG_SIZE) {
> > +               dev_err(dev, "device region smaller than register file =
(0x%llx)\n",
> > +                       res->end - res->start);
> > +               goto fail;
> > +       }
>
> Could we assume that DT should be responsible for specifying the right si=
ze?
>

This only to validate DT provided info and driver expected register
file size. Expectation is that DT will provide right size.


> > +static struct iommu_domain *riscv_iommu_domain_alloc(unsigned type)
> > +{
> > +       struct riscv_iommu_domain *domain;
> > +
> > +       if (type !=3D IOMMU_DOMAIN_IDENTITY &&
> > +           type !=3D IOMMU_DOMAIN_BLOCKED)
> > +               return NULL;
> > +
> > +       domain =3D kzalloc(sizeof(*domain), GFP_KERNEL);
> > +       if (!domain)
> > +               return NULL;
> > +
> > +       mutex_init(&domain->lock);
> > +       INIT_LIST_HEAD(&domain->endpoints);
> > +
> > +       domain->domain.ops =3D &riscv_iommu_domain_ops;
> > +       domain->mode =3D RISCV_IOMMU_DC_FSC_MODE_BARE;
> > +       domain->pscid =3D ida_alloc_range(&riscv_iommu_pscids, 1,
> > +                                       RISCV_IOMMU_MAX_PSCID, GFP_KERN=
EL);
> > +
> > +       printk("domain type %x alloc %u\n", type, domain->pscid);
> > +
>
> Could it uses pr_xxx instead of printk?
>

Absolutely, fixed here and elsewhere. Also, used dev_dbg wherever applicabl=
e.

> > +
> > +static int riscv_iommu_enable(struct riscv_iommu_device *iommu, unsign=
ed requested_mode)
> > +{
> > +       struct device *dev =3D iommu->dev;
> > +       u64 ddtp =3D 0;
> > +       u64 ddtp_paddr =3D 0;
> > +       unsigned mode =3D requested_mode;
> > +       unsigned mode_readback =3D 0;
> > +
> > +       ddtp =3D riscv_iommu_get_ddtp(iommu);
> > +       if (ddtp & RISCV_IOMMU_DDTP_BUSY)
> > +               return -EBUSY;
> > +
> > +       /* Disallow state transtion from xLVL to xLVL. */
> > +       switch (FIELD_GET(RISCV_IOMMU_DDTP_MODE, ddtp)) {
> > +       case RISCV_IOMMU_DDTP_MODE_BARE:
> > +       case RISCV_IOMMU_DDTP_MODE_OFF:
> > +               break;
> > +       default:
> > +               if ((mode !=3D RISCV_IOMMU_DDTP_MODE_BARE)
> > +                   && (mode !=3D RISCV_IOMMU_DDTP_MODE_OFF))
> > +                       return -EINVAL;
> > +               break;
> > +       }
> > +
> > + retry:
>
> We need to consider the `iommu.passthrough` before we set up the mode
> in switch case, something like
>

This function is only to execute configuration and set device directory mod=
e.
Handling global iommu.passthrough policy is implemented in
riscv_iommu_init() call (patch #7).

Best,
- Tomasz
