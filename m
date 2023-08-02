Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3D576D8A5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 22:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjHBUZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 16:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjHBUZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 16:25:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB8126A0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 13:25:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF5B361AFE
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 20:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437F4C433C7;
        Wed,  2 Aug 2023 20:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691007921;
        bh=+O8qluPv0JxAbf7ZatxXqZjsT+TjZ01Aqc8qllKD3Z8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fbe01a2wiD0NKAGOOQ+Z/Aldho4ww1deCdZHhsXr7nJ30qKpP8ue9MzYguW3mi0B3
         ccDZtPKQA4X3XAuW/073Bia42VRCrERZCNh3sPbH42uqmNylg2NtaJLpkUHP/9ARO4
         Klxc4MNqHl73nfnxDkySvLRoPAIueWO5qxYOQjOuAhHqyZkOjZRdsJ6j24aSmQ2+Cs
         +EfevmIhMQUsnionoYY/PSvSXO5ySKTPUU1Qpgt7YOGdW/MCAp0vVrfIAWyEcE05x1
         RG60J7zMgS5JxN9PKkL1yxG1ss6JNVZMPABtI+aXCw1RHha1TR/zqTXw4juf9gST4x
         pQeQdORSZr7dw==
Date:   Wed, 2 Aug 2023 21:25:15 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Tomasz Jeznach <tjeznach@rivosinc.com>
Cc:     Zong Li <zong.li@sifive.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com,
        linux-kernel@vger.kernel.org, Sebastien Boeuf <seb@rivosinc.com>,
        iommu@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 01/11] RISC-V: drivers/iommu: Add RISC-V IOMMU - Ziommu
 support.
Message-ID: <20230802-maimed-spotted-5fa1fe4be386@spud>
References: <cover.1689792825.git.tjeznach@rivosinc.com>
 <c33c24036c06c023947ecb47177da273569b3ac7.1689792825.git.tjeznach@rivosinc.com>
 <CANXhq0qRYvTffMnep-aQyTq2tMxbP-s_Lunc+cZ2Rio+BvAE=g@mail.gmail.com>
 <CAH2o1u5Sr0XigUbhna0E-Zk=U76CLZZ4LbM0u4ahPaN5+nOK6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ma68l5vGJ6Lc1SF4"
Content-Disposition: inline
In-Reply-To: <CAH2o1u5Sr0XigUbhna0E-Zk=U76CLZZ4LbM0u4ahPaN5+nOK6A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ma68l5vGJ6Lc1SF4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2023 at 01:15:22PM -0700, Tomasz Jeznach wrote:
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
>=20
> This only to validate DT provided info and driver expected register
> file size. Expectation is that DT will provide right size.

FWIW this check seems needless to me, it's not the kernels job to
validate the devicetree.


--ma68l5vGJ6Lc1SF4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMq7qwAKCRB4tDGHoIJi
0tRtAP9nGZaGgIQrAaYTLppahmjpJ+B4A4f+5TIiS3irhCOhSgD+IoyNLqVkVsKP
MLzN0x3g4i4TUarzD0mHByZ86FQ9eAQ=
=fGg5
-----END PGP SIGNATURE-----

--ma68l5vGJ6Lc1SF4--
