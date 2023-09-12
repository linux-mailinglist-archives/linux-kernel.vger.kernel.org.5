Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A3F79DB20
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 23:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjILVte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 17:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjILVtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:49:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E74410CC;
        Tue, 12 Sep 2023 14:49:29 -0700 (PDT)
Received: from mercury (unknown [185.254.75.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 20291660731A;
        Tue, 12 Sep 2023 22:49:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694555368;
        bh=KzHUhPgIk9l5Uaueu48b3+uaUVOCUBluWUvrQPBJO5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V/FhKTWNlzQtct5IgtDQhMjOFgcsXU7oFvaJdLnEbVO1aQtUmI7FUtophTh29Hpqa
         7SIaJSKPRVf2mC+Q69heL4YdEpZgAPyGKqvOqZYHeTgHEl+fmqJPU1h8fwhf4c3kQX
         E/m/KgVPBiR1jwdzv3ol4ZF99eBRasMG2GB5FfZccJ3K3HN7TNKmdLK/qPq19yYI8e
         ubI+LMmy2PNcy3FaQLnI7qXOTwsr11cFFTJA8tyuBqae7PZv/Fz5/WZQUvBuamgpq4
         IbqKbLKZDnyOzAKOyMTmnzTgr5v9E9uRgpkG6V2nBdqSk2QvUT/W/7OpSJMEoKBXG4
         GUO8ONFqmOFjg==
Received: by mercury (Postfix, from userid 1000)
        id BED16106098A; Tue, 12 Sep 2023 23:49:25 +0200 (CEST)
Date:   Tue, 12 Sep 2023 23:49:25 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH 1/2] power: supply: bq24257_charger: Make chip type and
 name in sync
Message-ID: <20230912214925.uukw4lxnopzswqz2@mercury.elektranox.org>
References: <20230902193331.83672-1-biju.das.jz@bp.renesas.com>
 <20230902193331.83672-2-biju.das.jz@bp.renesas.com>
 <ZPWsdjlFvUzeFy45@smile.fi.intel.com>
 <OS0PR01MB592285B86C29C3C1A992C09986F3A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZP7ored2UfXcFUvz@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zewfeowjhf25xdtg"
Content-Disposition: inline
In-Reply-To: <ZP7ored2UfXcFUvz@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zewfeowjhf25xdtg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 11, 2023 at 01:15:09PM +0300, Andy Shevchenko wrote:
> On Sun, Sep 10, 2023 at 07:10:06AM +0000, Biju Das wrote:
> > Hi Andy Shevchenko,
> > > On Sat, Sep 02, 2023 at 08:33:30PM +0100, Biju Das wrote:
>=20
> ...
>=20
> > > > -	if (ACPI_HANDLE(dev)) {
> > > > -		acpi_id =3D acpi_match_device(dev->driver->acpi_match_table,
> > > > -					    &client->dev);
> > > > -		if (!acpi_id) {
> > > > -			dev_err(dev, "Failed to match ACPI device\n");
> > > > -			return -ENODEV;
> > > > -		}
> > > > -		bq->chip =3D (enum bq2425x_chip)acpi_id->driver_data;
> > > > -	} else {
> > > > -		bq->chip =3D (enum bq2425x_chip)id->driver_data;
> > > > -	}
> > >=20
> > > Do we still need acpi.h after this change?
> >=20
> > Yes, it is still needed as it is using=20
> > ACPI_PTR.
>=20
> Can we, please, drop ACPI_PTR() as it's more harmful than useful (same wa=
y as
> you dropped the ifdeffery for OF cases in other patches)?

I will go ahead and merge this series, ACPI_PTR() and
of_match_ptr() should be removed in a separate cleanup patch.

-- Sebastian

--zewfeowjhf25xdtg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUA3OIACgkQ2O7X88g7
+pr71w/+IgYWrC5fD6PTKqgYLZgjLziNKJmHrPKWUaJ8O7JmK/lffOU0ZsFJCW48
EvhmhZDm5Ta447qDYHrNIattg1pGYixLxkExXsFYoy1bb4CDzrDuXtEyBL/DvGK4
U3GQmnHyeSbFWJaEGkDaDaBiJuuJYpTfpLUvTbW45dhlzGNXRoNTaWfm8cvWuc04
W2AYdeUSNrirEXqP/R5XiRXEICmQ3oyRS7YUt+wqi0dnXu2JWQplMiGQgOP23veQ
Om+LykWszUbgJ2CQ181mSshp8dxJqgE3IlSeDqfyTYLQsXuzOb7uiv1mK6tW20Ja
6CuY01qC7CobNWkqMRZfjtt949bQlXKW7clYUm6V4yXwASh9N/WRMS1Oa8qGlqn3
6EvhmOM4yGH8VkOd5P1DpLgjQ2P9QFLbWUyIqswt1do3az/b87LdDm8EAg4JpFTJ
yXo2PJ0DDNXzkCTDQeO/Bw8gdQK9NYiyZpf+2EaVeHLla160TvI+SVB08QMdeoM4
aLYhXlO6dqb2CeriYEoWXAXf4oo/HEKMINiNQqjTv6IzXf92vruKeI7/un2r9s7L
uxCWMNMu7spmsWtLarzxb18Ly8HGVNc0uFrGMcQ5p2onG1NjBfk8LTzzsFTR87dN
aMdvbOYSgncrG1MHzuxyuSRf69nSYhEMFKv2wqNWci01ls3AFZ8=
=djlU
-----END PGP SIGNATURE-----

--zewfeowjhf25xdtg--
