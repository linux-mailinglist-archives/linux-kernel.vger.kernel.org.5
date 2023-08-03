Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E8476DF0C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 05:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjHCDha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 23:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjHCDh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 23:37:29 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E51626B2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 20:37:28 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-34941081235so1892655ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 20:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1691033847; x=1691638647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XezimV1as/cKuTMyLJfYIpzABwFXYSrbRVNfnuICdU=;
        b=giOWK51Dhn9vReA6OJfd8zvKnuve/uokt8ax23zbCVAwmmR36s9yVrixUyaVE4JA7D
         oWS+jn9gNn+g8OAAVMQNVW+gzShA5OHjUhoJhM7ZkkoKfPI8kT643pso7Dn7dXLQ0fD8
         MtD+unY09yWthQYKv4JKiELGU9AbHbs7CIQJUeYXurtQyg3KeSegehAPAiIjicbya9Wu
         btmRsfa0OtDeg99VO+jVo3Cp2FbYCph1ACEm7RB+66jKoVJzhqe0itR5GEp/LrE9Vqzy
         ccuMlaOKScPTnpuspxvUA/6DSzjmypFuCndoiTNyhItlnwGtVoz7lisoyGaokTQLk79b
         PaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691033847; x=1691638647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XezimV1as/cKuTMyLJfYIpzABwFXYSrbRVNfnuICdU=;
        b=kf/3de8eKnF+ud2ZGRIAF074zqRjEcv+FL61BEHIJEoSgPGPXxVD3eTFaFwuQ+twBM
         NAwq+psw1NZ632DMN6eB5FFiLdAtMLw1PpjlRH/OvwYLYg/cB8kXVaWtRgAW/owqlG3t
         jMS2QFswqEOEczQgdXpdTNvqRztcsUB4orK1MsING5OTIHueZtqrIFOVlgYyrwS9H9Ec
         Si2RORviBCtpdkIJ9pp0dX8YaL+r4mIPnsDaFRGqJKrH4dM+xMetuYz6gYvXdkGlDRLR
         LbQ21DXLDGQcbPJ8Mv/RzYzMcal4OIR2yn+DTslwe1wUNshomXqoWh/k7eTKk6zmqaaH
         7yVw==
X-Gm-Message-State: ABy/qLZ/2cGTFNGxXrcxPUndFf/w/VMHkc+oQIH5SkrDuARyVCqBsxZR
        vCZxh+66G5mBafRbKg+oMaU7Tc04Z2SvLstQgZmPVg==
X-Google-Smtp-Source: APBJJlE6OdMliq0SpqBmWgqkyB7p9epCcw1sbOElJJhGiT0YKv5ld0XCAhfkil/SqKM9pPRldnE9PG5yRhHEvF45DOI=
X-Received: by 2002:a05:6e02:2163:b0:345:dcc1:a1c4 with SMTP id
 s3-20020a056e02216300b00345dcc1a1c4mr18872255ilv.4.1691033847682; Wed, 02 Aug
 2023 20:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <c33c24036c06c023947ecb47177da273569b3ac7.1689792825.git.tjeznach@rivosinc.com>
 <CANXhq0qRYvTffMnep-aQyTq2tMxbP-s_Lunc+cZ2Rio+BvAE=g@mail.gmail.com> <CAH2o1u5Sr0XigUbhna0E-Zk=U76CLZZ4LbM0u4ahPaN5+nOK6A@mail.gmail.com>
In-Reply-To: <CAH2o1u5Sr0XigUbhna0E-Zk=U76CLZZ4LbM0u4ahPaN5+nOK6A@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Thu, 3 Aug 2023 11:37:16 +0800
Message-ID: <CANXhq0o5898J=U5XmKbmO4wLq5VkKHVaSwzzcixUqGkkFddhWw@mail.gmail.com>
Subject: Re: [PATCH 01/11] RISC-V: drivers/iommu: Add RISC-V IOMMU - Ziommu support.
To:     Tomasz Jeznach <tjeznach@rivosinc.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 4:15=E2=80=AFAM Tomasz Jeznach <tjeznach@rivosinc.co=
m> wrote:
>
> On Thu, Jul 27, 2023 at 7:42=E2=80=AFPM Zong Li <zong.li@sifive.com> wrot=
e:
> >
> > On Thu, Jul 20, 2023 at 3:34=E2=80=AFAM Tomasz Jeznach <tjeznach@rivosi=
nc.com> wrote:
> > >
> > > +static int riscv_iommu_platform_probe(struct platform_device *pdev)
> > > +{
> > > +       struct device *dev =3D &pdev->dev;
> > > +       struct riscv_iommu_device *iommu =3D NULL;
> > > +       struct resource *res =3D NULL;
> > > +       int ret =3D 0;
> > > +
> > > +       iommu =3D devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
> > > +       if (!iommu)
> > > +               return -ENOMEM;
> > > +
> > > +       iommu->dev =3D dev;
> > > +       dev_set_drvdata(dev, iommu);
> > > +
> > > +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +       if (!res) {
> > > +               dev_err(dev, "could not find resource for register re=
gion\n");
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       iommu->reg =3D devm_platform_get_and_ioremap_resource(pdev, 0=
, &res);
> > > +       if (IS_ERR(iommu->reg)) {
> > > +               ret =3D dev_err_probe(dev, PTR_ERR(iommu->reg),
> > > +                                   "could not map register region\n"=
);
> > > +               goto fail;
> > > +       };
> > > +
> > > +       iommu->reg_phys =3D res->start;
> > > +
> > > +       ret =3D -ENODEV;
> > > +
> > > +       /* Sanity check: Did we get the whole register space ? */
> > > +       if ((res->end - res->start + 1) < RISCV_IOMMU_REG_SIZE) {
> > > +               dev_err(dev, "device region smaller than register fil=
e (0x%llx)\n",
> > > +                       res->end - res->start);
> > > +               goto fail;
> > > +       }
> >
> > Could we assume that DT should be responsible for specifying the right =
size?
> >
>
> This only to validate DT provided info and driver expected register
> file size. Expectation is that DT will provide right size.
>
>
> > > +static struct iommu_domain *riscv_iommu_domain_alloc(unsigned type)
> > > +{
> > > +       struct riscv_iommu_domain *domain;
> > > +
> > > +       if (type !=3D IOMMU_DOMAIN_IDENTITY &&
> > > +           type !=3D IOMMU_DOMAIN_BLOCKED)
> > > +               return NULL;
> > > +
> > > +       domain =3D kzalloc(sizeof(*domain), GFP_KERNEL);
> > > +       if (!domain)
> > > +               return NULL;
> > > +
> > > +       mutex_init(&domain->lock);
> > > +       INIT_LIST_HEAD(&domain->endpoints);
> > > +
> > > +       domain->domain.ops =3D &riscv_iommu_domain_ops;
> > > +       domain->mode =3D RISCV_IOMMU_DC_FSC_MODE_BARE;
> > > +       domain->pscid =3D ida_alloc_range(&riscv_iommu_pscids, 1,
> > > +                                       RISCV_IOMMU_MAX_PSCID, GFP_KE=
RNEL);
> > > +
> > > +       printk("domain type %x alloc %u\n", type, domain->pscid);
> > > +
> >
> > Could it uses pr_xxx instead of printk?
> >
>
> Absolutely, fixed here and elsewhere. Also, used dev_dbg wherever applica=
ble.
>
> > > +
> > > +static int riscv_iommu_enable(struct riscv_iommu_device *iommu, unsi=
gned requested_mode)
> > > +{
> > > +       struct device *dev =3D iommu->dev;
> > > +       u64 ddtp =3D 0;
> > > +       u64 ddtp_paddr =3D 0;
> > > +       unsigned mode =3D requested_mode;
> > > +       unsigned mode_readback =3D 0;
> > > +
> > > +       ddtp =3D riscv_iommu_get_ddtp(iommu);
> > > +       if (ddtp & RISCV_IOMMU_DDTP_BUSY)
> > > +               return -EBUSY;
> > > +
> > > +       /* Disallow state transtion from xLVL to xLVL. */
> > > +       switch (FIELD_GET(RISCV_IOMMU_DDTP_MODE, ddtp)) {
> > > +       case RISCV_IOMMU_DDTP_MODE_BARE:
> > > +       case RISCV_IOMMU_DDTP_MODE_OFF:
> > > +               break;
> > > +       default:
> > > +               if ((mode !=3D RISCV_IOMMU_DDTP_MODE_BARE)
> > > +                   && (mode !=3D RISCV_IOMMU_DDTP_MODE_OFF))
> > > +                       return -EINVAL;
> > > +               break;
> > > +       }
> > > +
> > > + retry:
> >
> > We need to consider the `iommu.passthrough` before we set up the mode
> > in switch case, something like
> >
>
> This function is only to execute configuration and set device directory m=
ode.
> Handling global iommu.passthrough policy is implemented in
> riscv_iommu_init() call (patch #7).

Thanks. I saw that in patch #7.

>
> Best,
> - Tomasz
