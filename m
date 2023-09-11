Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38F779B38F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345849AbjIKVWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbjIKJkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:40:13 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D316FEE;
        Mon, 11 Sep 2023 02:40:08 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id AA45A1C0006; Mon, 11 Sep 2023 11:40:07 +0200 (CEST)
Date:   Mon, 11 Sep 2023 11:40:07 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 8/8] Bluetooth: btusb: Fix quirks table
 naming
Message-ID: <ZP7gd93uo1qdKOTd@duo.ucw.cz>
References: <20230908182127.3461199-1-sashal@kernel.org>
 <20230908182127.3461199-8-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="dbHrQaOD3hXSySS7"
Content-Disposition: inline
In-Reply-To: <20230908182127.3461199-8-sashal@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dbHrQaOD3hXSySS7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Bastien Nocera <hadess@hadess.net>
>=20
> [ Upstream commit d831e3612111d385e8629104af5429808ef26e25 ]
>=20
> The quirks table was named "blacklist_table" which isn't a good
> description for that table as devices detected using it weren't ignored
> by the driver.
>=20
> Rename the table to match what it actually does.

Cleanup, not a bugfix. Don't need it in stable.

Best regards,
							Pavel

> +++ b/drivers/bluetooth/btusb.c
> @@ -186,7 +186,7 @@ static const struct usb_device_id btusb_table[] =3D {
> =20
>  MODULE_DEVICE_TABLE(usb, btusb_table);
> =20
> -static const struct usb_device_id blacklist_table[] =3D {
> +static const struct usb_device_id quirks_table[] =3D {
>  	/* CSR BlueCore devices */
>  	{ USB_DEVICE(0x0a12, 0x0001), .driver_info =3D BTUSB_CSR },
> =20
> @@ -2963,7 +2963,7 @@ static int btusb_probe(struct usb_interface *intf,
>  	if (!id->driver_info) {
>  		const struct usb_device_id *match;
> =20
> -		match =3D usb_match_id(intf, blacklist_table);
> +		match =3D usb_match_id(intf, quirks_table);
>  		if (match)
>  			id =3D match;
>  	}

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--dbHrQaOD3hXSySS7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZP7gdwAKCRAw5/Bqldv6
8tpGAJ47uP9P3kpy6tTPxQC7wlj9dTUhXwCeILqELhtTFssT21DUwGP9JpGVpmg=
=Quiv
-----END PGP SIGNATURE-----

--dbHrQaOD3hXSySS7--
