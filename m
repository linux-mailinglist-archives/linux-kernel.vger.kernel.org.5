Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCA178AE6C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 13:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjH1LE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 07:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjH1LEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 07:04:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E91FAB;
        Mon, 28 Aug 2023 04:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1693220662; x=1724756662;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ri/l6M8mpTkwkRbAXaHeiv8dKUXmvnnn0gDOniLyOtY=;
  b=hgikfEmXIhbxQd5NLVbqWYFA8SK+JkQ1hKrGFnpFOYZZyRzOhd3MF0tp
   8a62rxnhZHVTG/D3aUSE/+oKszF8Ns/O3Zj/7UjlSfyfNy7gBgaRG7bNT
   ejLhMQd30EConlwJ8lvbWJ5YjAy5qvtaqcZCqELxH4i/Ddoo8ZEFPtD5O
   5TwMKmo2beeQuhUoqB6HqhXnfz8vhzsouI1Tu1bm8JQoMlhLGUvDTEv9H
   SFhkwebxYrL4fcm3BZqMDITa82ySO2KetjYfOxWXfNB0NVj0ynp6beb/c
   umDcI3rEjsKjZNkNZptw7vFaon142B3Zlwd1RBGetctzFnhKO02T3pcip
   g==;
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="asc'?scan'208";a="232063736"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Aug 2023 04:04:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 28 Aug 2023 04:04:11 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 28 Aug 2023 04:04:10 -0700
Date:   Mon, 28 Aug 2023 12:03:28 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Andrei Coardos <aboutphysycs@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <alex@shruggie.ro>,
        <herbert@gondor.apana.org.au>, <olivia@selenic.com>,
        <daire.mcnamara@microchip.com>
Subject: Re: [PATCH] char: hw_random: mpfs-rng: removed unneeded call to
 platform_set_drvdata()
Message-ID: <20230828-citable-superjet-d235f036be99@wendy>
References: <20230828101757.9724-1-aboutphysycs@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ybobh3J4aOaUG3ga"
Content-Disposition: inline
In-Reply-To: <20230828101757.9724-1-aboutphysycs@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ybobh3J4aOaUG3ga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2023 at 01:17:57PM +0300, Andrei Coardos wrote:
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Als=
o,
> the private data is defined in this driver, so there is no risk of it bei=
ng
> accessed outside of this driver file.

I think Greg previously pointed out to you that is it not sufficient to
check for platform_get_drvdata() alone, because the information could be
accessed without going through that helper. That's not the case here,
but it could be true elsewhere.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>=20
> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---
>  drivers/char/hw_random/mpfs-rng.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/char/hw_random/mpfs-rng.c b/drivers/char/hw_random/m=
pfs-rng.c
> index c6972734ae62..0994024daa70 100644
> --- a/drivers/char/hw_random/mpfs-rng.c
> +++ b/drivers/char/hw_random/mpfs-rng.c
> @@ -79,8 +79,6 @@ static int mpfs_rng_probe(struct platform_device *pdev)
>  	rng_priv->rng.read =3D mpfs_rng_read;
>  	rng_priv->rng.name =3D pdev->name;
> =20
> -	platform_set_drvdata(pdev, rng_priv);
> -
>  	ret =3D devm_hwrng_register(&pdev->dev, &rng_priv->rng);
>  	if (ret)
>  		return dev_err_probe(&pdev->dev, ret, "Failed to register MPFS hwrng\n=
");
> --=20
> 2.34.1
>=20

--ybobh3J4aOaUG3ga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOx/AAAKCRB4tDGHoIJi
0phKAQCmLUMIMFTcDFBxCWk4kaHBl9Ujv1n4I9MDnQh4EmQD6AEAj4EuDnlW9UJf
RLVsSRWf8o2NQmLHWByqDCzAnhbTngY=
=ZYKd
-----END PGP SIGNATURE-----

--ybobh3J4aOaUG3ga--
