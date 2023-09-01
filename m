Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F4578F88C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 08:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242093AbjIAG0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 02:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237766AbjIAG0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 02:26:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3945510D2;
        Thu, 31 Aug 2023 23:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1693549592; x=1725085592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aAlPFkFFJ0tKP+R+0ojprm+uUm4swQJFKVrG7PiJNPU=;
  b=IdBpHMulkSLlWtH/p3pi1F+a2QOkrBPRsMcw2KRMg69peDEWLblxeSDH
   15Su+QNIAujCKQP6Wgv1mpiS1X5vQXB94z3ErPfABmtrIsXp46q9ajj3d
   NA1994uexK9Yi8YpVvoL45bWVesrQVmuHrSXJSQ8l/Nj5Fpaw3GK0Ftge
   Bv9idi+ky0e55v9p/lkK5abtjVKgraNRBQPQdMMQosyMjlh2u13PE+JPo
   lq/ZsPKz8tTFBcR8fYmWGuqu8kzs/2jwNzFjdt5qtN7ZjNWTqygg4ornh
   o0NeyeViB0G2OvKTesRRwqujpR2vIMRyD3Lu1boms0pSNrVKLgZZykyGY
   g==;
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="asc'?scan'208";a="2394248"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Aug 2023 23:26:32 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 31 Aug 2023 23:26:31 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 31 Aug 2023 23:26:29 -0700
Date:   Fri, 1 Sep 2023 07:25:47 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Alexandru Ardelean <alex@shruggie.ro>
CC:     Andrei Coardos <aboutphysycs@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <herbert@gondor.apana.org.au>,
        <olivia@selenic.com>, <daire.mcnamara@microchip.com>
Subject: Re: [PATCH] char: hw_random: mpfs-rng: removed unneeded call to
 platform_set_drvdata()
Message-ID: <20230901-upper-reenter-9c2fa8bf7a47@wendy>
References: <20230828101757.9724-1-aboutphysycs@gmail.com>
 <20230828-citable-superjet-d235f036be99@wendy>
 <CAH3L5QreWNPgwogL7bCYZgKSuz_HfZuKLtRVqz+UyRtJ1TB-SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rbkSUiqy942IY70F"
Content-Disposition: inline
In-Reply-To: <CAH3L5QreWNPgwogL7bCYZgKSuz_HfZuKLtRVqz+UyRtJ1TB-SA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--rbkSUiqy942IY70F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2023 at 09:07:56AM +0300, Alexandru Ardelean wrote:
> On Mon, Aug 28, 2023 at 2:06=E2=80=AFPM Conor Dooley <conor.dooley@microc=
hip.com> wrote:
> >
> > On Mon, Aug 28, 2023 at 01:17:57PM +0300, Andrei Coardos wrote:
> > > This function call was found to be unnecessary as there is no equival=
ent
> > > platform_get_drvdata() call to access the private data of the driver.=
 Also,
> > > the private data is defined in this driver, so there is no risk of it=
 being
> > > accessed outside of this driver file.
> >
> > I think Greg previously pointed out to you that is it not sufficient to
> > check for platform_get_drvdata() alone, because the information could be
> > accessed without going through that helper. That's not the case here,
> > but it could be true elsewhere.
> >
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >
> > Thanks,
> > Conor.
> >
> > >
> > > Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> > > ---
> > >  drivers/char/hw_random/mpfs-rng.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > >
> > > diff --git a/drivers/char/hw_random/mpfs-rng.c b/drivers/char/hw_rand=
om/mpfs-rng.c
> > > index c6972734ae62..0994024daa70 100644
> > > --- a/drivers/char/hw_random/mpfs-rng.c
> > > +++ b/drivers/char/hw_random/mpfs-rng.c
> > > @@ -79,8 +79,6 @@ static int mpfs_rng_probe(struct platform_device *p=
dev)
> > >       rng_priv->rng.read =3D mpfs_rng_read;
> > >       rng_priv->rng.name =3D pdev->name;
> > >
> > > -     platform_set_drvdata(pdev, rng_priv);
> > > -
> > >       ret =3D devm_hwrng_register(&pdev->dev, &rng_priv->rng);
>=20
> A question would be if there is a desire to keep the prints below, or
> would this be sufficient?
>=20
>           return devm_hwrng_register(&pdev->dev, &rng_priv->rng);
>=20
> If there is the desire to keep the prints, then:

Yeah, I'd like to keep a print in the failing case, thanks.

>=20
> Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
>=20
> > >       if (ret)
> > >               return dev_err_probe(&pdev->dev, ret, "Failed to regist=
er MPFS hwrng\n");
> > > --
> > > 2.34.1
> > >

--rbkSUiqy942IY70F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZPGD6wAKCRB4tDGHoIJi
0qUTAQD0ZDiVMxcLtPt0mgxplAh+moC7mid0YSGHBG9Ni1um5QEA/E2z+UWdQSGw
Yw88TOcd4HWPZN8oMlkVEjAmi8MA4gs=
=3NaB
-----END PGP SIGNATURE-----

--rbkSUiqy942IY70F--
