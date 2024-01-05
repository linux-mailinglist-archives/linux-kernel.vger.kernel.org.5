Return-Path: <linux-kernel+bounces-17716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F40F825184
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D216B21868
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DECE24B53;
	Fri,  5 Jan 2024 10:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fu6+F5yl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D594824B42;
	Fri,  5 Jan 2024 10:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 405AAvqw060097;
	Fri, 5 Jan 2024 04:10:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704449457;
	bh=zgPbm5yoRPogHRwkmQDQezlAr5UfQ2gMpkkB4jBkXt8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=fu6+F5yl3LlsNf94BxW6rpdWq3h8OZxWaOGkT/Ha4zKQaAm3bZ3/+U70Wkv3zGTfS
	 79LaTsLuQSloYwGX+3fPW1M3ZPUdbGaWG1mVxUgHWPnYsCw76r7QeKO/1ydLdzavqE
	 ROHm0vizODl290/TOPvz3Cf9ij+v0vXf0j1QdhK8=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 405AAv1x015209
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Jan 2024 04:10:57 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Jan 2024 04:10:56 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Jan 2024 04:10:56 -0600
Received: from localhost ([10.249.131.210])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 405AAtVY119550;
	Fri, 5 Jan 2024 04:10:56 -0600
Date: Fri, 5 Jan 2024 15:40:54 +0530
From: Jai Luthra <j-luthra@ti.com>
To: Javier Carrasco <javier.carrasco@wolfvision.net>,
        Abdel Alkuor
	<abdelalkuor@geotab.com>
CC: <rogerq@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vigneshr@ti.com>, <d-gole@ti.com>, <nm@ti.com>
Subject: Re: [PATCH v2 0/4] usb: typec: tipd: add patch update support for
 tps6598x
Message-ID: <4erwnvyyammnsdihwpvqcmm4v4fcyxozltocklsbnbfdhacoye@le7x2giuxrwv>
References: <20231207-tps6598x_update-v2-0-f3cfcde6d890@wolfvision.net>
 <vmngazj6si7xxss7txenezkcukqje2glhvvs7ipdcx3vjiqvlk@ohmmhhhlryws>
 <2nqiaxakx6setx4tzgddnbjadbh7miegz5p6wamsbbiyrfuq3x@un2uxajbswkg>
 <f463e49d-9e69-4bff-a663-3ce7c1093202@wolfvision.net>
 <nza4s2kjmcptz6epbyegwy6wh32buyxm5evnk2jultqblgzs4b@6mzuklpqhby7>
 <6e63a1f0-8ed6-41cf-b1bc-34b49099eedf@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cnaquinfjqktv7bx"
Content-Disposition: inline
In-Reply-To: <6e63a1f0-8ed6-41cf-b1bc-34b49099eedf@wolfvision.net>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--cnaquinfjqktv7bx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Javier, Abdel,

On Jan 05, 2024 at 10:49:22 +0100, Javier Carrasco wrote:
> On 05.01.24 09:12, Jai Luthra wrote:
> > I added some prints and can see that the probe fails once at=20
> > fwnode_usb_role_switch_get() because the other endpoint (of USB device)=
=20
> > is not yet probed. It then re-probes later where it passes.
> >=20
> > The GAID reset being done unconditionally in your series seems to cause=
=20
> > the board to get stuck in the boot process when it hits the above error=
=20
> > due to probe-order between USB subsystem and this IC. My guess would be=
=20
> > SoC stops getting power because we reset the PD chip?
> >=20
> > Anyway, I will send below change as a separate "Fixes:" patch for now,=
=20
> > to keep how things as they were before your series.
> >=20
>=20
> My biggest concern is that we are sending GAID for the tps25750 under
> the same circumstances. Could we not have the same problem with that
> device? We would be resetting the PD controller and the SoC would stop
> getting power as well, right? Or is there anything device-specific that
> would avoid that?
>=20

Yes I would guess same problem can happen depending on probe order of=20
the remote-endpoint node, but I don't see any upstream platform using=20
ti,tps25750 compatible, so I have no way to confirm.

Maybe Abdel can comment on how it works, as he added the GAID reset for=20
tps25750.

> > If you have a better architecture in mind that can reset only when PTCH=
=20
> > has been applied and not for other probe defers, feel free to send it o=
n=20
> > top of it.
> >=20
>=20
> I added the cold reset to have the same behavior upon probe failures for
> both devices, given that they use the same command. But if that can
> cause problems, let's leave the reset alone...
>=20
> Best regards,
> Javier Carrasco

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--cnaquinfjqktv7bx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmWX1a0ACgkQQ96R+SSa
cUWwMw/+OLopIG3GmS4qRykSsenaaI9RZeBk3+FPDPbzycE+Wt+7YsZJBcUhoDFm
Bkm9mLKpWi2HvVTyCv7l5R0un38kceErcPj5c8warAMXbAI5vvd8/M+YE60j1dr+
Gbm98I2O/hXDYrtGjhmJajmvchzlc3CUGTfA+CULx9h7zp0zP/ro57HgQwhO/3pA
NjnoGA9TVh5spheY7Aw7hBO+GZAi/iXqEcQY1TNCvSiARN0OW1bMlqWZJOZYoLk7
CsGWPq1AkTxW2n1tUjm86pFVuV3l6rRN6E5IW7lQt/UkWoe8d33o0z5DFHwY7TK8
KtAfE3NHGn+Ancmp3wt3+Y2W0++mB1RtPfnn3QRRIvmlY6Et7EuvVErZPfA0NRj1
o3FiJNr1Uew6P9pAeer7RvuEBT0NKarZo11uPfAjHhUVEE9tEH/LGFWFt8qwMHiU
Zl3bhrYhgobnxUJO/6fZQRZCO/P1Ia3B4KTHlo2xhsEBzyGpGUATJktKWXLlf9S5
3pfTBPOrquiYxZxSo3sQSWVOzGCzrE2FeaWg/o+E1nXTuvVvFCjpHnsNRQJsOO6h
ydPgQvnn2uOLQJu391xkc90egQRzFvsLihI9rPp7bkQ6I2VPf3nl6yTTCtXaOUeg
jlSN4urFqi8r4kxKRXSEI4XmSfsJK5pQUpcshaBzkJWXMWlRD0c=
=T0Ts
-----END PGP SIGNATURE-----

--cnaquinfjqktv7bx--

