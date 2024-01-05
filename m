Return-Path: <linux-kernel+bounces-17573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E847F824F89
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7BD1F229C7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECD920DC5;
	Fri,  5 Jan 2024 08:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="isopssAo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7EA20338;
	Fri,  5 Jan 2024 08:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4058CJ4h029074;
	Fri, 5 Jan 2024 02:12:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704442339;
	bh=4oo81setgdnXvo1G15UrQi66PFN+P1vFRVNht1Ndt/8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=isopssAoWLIMKqOpaG9FF5+09glr9g+cdZBS2gc4UOjA0CY3LhVQm3AtELk9sfRNs
	 grZCLx1FsfbuclrTuJ3hxp8VvgGKsr5qp7zuXjk6qzOPZSArT96Wld4nmfOXGMB6WV
	 uYAhmHx6oafE+taFgafaO+9DCzvWkUflx2ft6+SI=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4058CJB0024828
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Jan 2024 02:12:19 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Jan 2024 02:12:18 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Jan 2024 02:12:18 -0600
Received: from localhost ([10.249.131.210])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4058CHcc089216;
	Fri, 5 Jan 2024 02:12:18 -0600
Date: Fri, 5 Jan 2024 13:42:16 +0530
From: Jai Luthra <j-luthra@ti.com>
To: Javier Carrasco <javier.carrasco@wolfvision.net>, <rogerq@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus
	<heikki.krogerus@linux.intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vigneshr@ti.com>, <d-gole@ti.com>, <nm@ti.com>
Subject: Re: [PATCH v2 0/4] usb: typec: tipd: add patch update support for
 tps6598x
Message-ID: <nza4s2kjmcptz6epbyegwy6wh32buyxm5evnk2jultqblgzs4b@6mzuklpqhby7>
References: <20231207-tps6598x_update-v2-0-f3cfcde6d890@wolfvision.net>
 <vmngazj6si7xxss7txenezkcukqje2glhvvs7ipdcx3vjiqvlk@ohmmhhhlryws>
 <2nqiaxakx6setx4tzgddnbjadbh7miegz5p6wamsbbiyrfuq3x@un2uxajbswkg>
 <f463e49d-9e69-4bff-a663-3ce7c1093202@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="57vfqsvif4i6elyg"
Content-Disposition: inline
In-Reply-To: <f463e49d-9e69-4bff-a663-3ce7c1093202@wolfvision.net>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--57vfqsvif4i6elyg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 04, 2024 at 17:25:27 +0100, Javier Carrasco wrote:
> Hi Jai Luthra,
> On 04.01.24 16:47, Jai Luthra wrote>> FYI, this series breaks boot for
> TI SK-AM62A and SK-AM62 which use
> >> TPS6598x as the USB-C PD chip.
> >>
> >> The platforms stopped booting since next-20240103 [1], and reverting=
=20
> >> this series [4] seems to fix the issue [2]
> >>
> >> Is there any change needed in the board device-tree [3] and bindings?
> >>
> >> We don't specify any firmware in the device-tree node, but seems like=
=20
> >> that is an assumption in this series. I tried reverting it (below=20
> >> change) but that did *not* help with the stuck boot.
> >>Thanks a lot for your high-quality feedback. I am glad to see that you
> even found a solution to the issue.
>=20
> The firmware update only happens if the device is in patch mode ('PTCH'
> in the Mode register - 0x03), which is the expected behavior because the
> device waits in that mode until a patch arrives. That is probably the
> reason why your first attempt did not work (no update was triggered).

Understood. Btw your mail client seems to mess up quotes/spacing above.

>=20
> The problem seems to be related to the reset function, as you already
> noticed. That function is only called in suspend/resume, if the probe
> fails and in the remove function.
>=20
> Did the probe function fail and if so, could you see why? The reset
> function is identical for the tps25750 and tps6598x ('GAID' with no
> parameters), so I wonder why that should be the source of the problem.

I added some prints and can see that the probe fails once at=20
fwnode_usb_role_switch_get() because the other endpoint (of USB device)=20
is not yet probed. It then re-probes later where it passes.

The GAID reset being done unconditionally in your series seems to cause=20
the board to get stuck in the boot process when it hits the above error=20
due to probe-order between USB subsystem and this IC. My guess would be=20
SoC stops getting power because we reset the PD chip?

Anyway, I will send below change as a separate "Fixes:" patch for now,=20
to keep how things as they were before your series.

If you have a better architecture in mind that can reset only when PTCH=20
has been applied and not for other probe defers, feel free to send it on=20
top of it.

> > The following change seems to fix boot on SK-AM62A without reverting=20
> > this whole series:
> >=20
> > ------------------
> >=20
> > diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/cor=
e.c
> > index a956eb976906a5..8ba2aa05db519b 100644
> > --- a/drivers/usb/typec/tipd/core.c
> > +++ b/drivers/usb/typec/tipd/core.c
> > @@ -1223,11 +1223,16 @@ static int cd321x_reset(struct tps6598x *tps)
> >  	return 0;
> >  }
> > =20
> > -static int tps6598x_reset(struct tps6598x *tps)
> > +static int tps25750_reset(struct tps6598x *tps)
> >  {
> >  	return tps6598x_exec_cmd_tmo(tps, "GAID", 0, NULL, 0, NULL, 2000, 0);
> >  }
> > =20
> > +static int tps6598x_reset(struct tps6598x *tps)
> > +{
> > +	return 0;
> > +}
> > +
> >  static int
> >  tps25750_register_port(struct tps6598x *tps, struct fwnode_handle *fwn=
ode)
> >  {
> > @@ -1545,7 +1550,7 @@ static const struct tipd_data tps25750_data =3D {
> >  	.trace_status =3D trace_tps25750_status,
> >  	.apply_patch =3D tps25750_apply_patch,
> >  	.init =3D tps25750_init,
> > -	.reset =3D tps6598x_reset,
> > +	.reset =3D tps25750_reset,
> >  };
> > =20
> >  static const struct of_device_id tps6598x_of_match[] =3D {
> >=20
> > ------------------
> >=20
> > I am not an expert on this, will let you/others decide on what should b=
e=20
> > the correct way to reset TPS6598x for patching without breaking this SK.
> >=20
> >=20
>=20
> The driver did not support cold resets before, but that does not mean
> that they should not happen like it does for the tps25750. Your fix just
> removes the reset function for the tps6598x, and I would like to know
> why the reset happened in the fist place.
>=20
> Thanks and best regards,
> Javier Carrasco

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--57vfqsvif4i6elyg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmWXud8ACgkQQ96R+SSa
cUUU+hAAj1EAQqSGUPQjU14gRTb72SrzCtpQ6q38GXeyW2xvFuebNmL/869JoFhW
MA1RZXtMPUPgYSvrUIhxycHaRbN+SFPBMKnX7QtWDDMHZDk9Juoz54tHw0/EirCC
COfhxz2uSqPMNedd354ZGTZaytU4vjr3NfYAvQUkjfz7Te0tfzuHwhx5eV66kP6E
Pdu+sZi9ipVSZYTQxUSIU1iiXj51sxq4sgXMHZWeSJLj2pE+o+9RebIsLfcgNjsm
qBph4KyNDkrEGWwS7i/1rSqHb/uloN9vrZSAGaB3NE7l3e7T0nLASem2i73MXt4D
c8zuVMeaA0Kg76zYO++OTNBLcSYiWo2HYr9HoCwN634KHMAp2SxyE0cdE5aYkWjY
KnY9ABbpwEO+wQjP+u1sGpNN8E+RiiNVh+eOpTKCNLvK/DBcbw8mHPKxsQoIcZnC
Q/8KxjOFskaoyEjyMl0m0nNHWE86k6OfzVfBHyoC2Lc5O7CrQeDXWc2QfH2ps4Xb
s6ijuI7+Cfrpj/HDl9wNAT+UDDYqCop72HudD+phl6RDiYGCre2NkQ3GnWBnU5Sm
Hudkrlnbl9ZmfMCLeRALUmYcO2MEoUbB2eHtkZU6oM72jkfu4SZOO94n2HcrNB8W
uiB5SZw2RZu0PoC6eIhTf5mrsxPbOZDNHyQhK1q2uCzyJChpdo8=
=qU5w
-----END PGP SIGNATURE-----

--57vfqsvif4i6elyg--

