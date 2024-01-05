Return-Path: <linux-kernel+bounces-17707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D6D825167
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5C891F22DEB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EC524B41;
	Fri,  5 Jan 2024 10:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XqnxykQc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5846524B2A;
	Fri,  5 Jan 2024 10:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 405A18ju018273;
	Fri, 5 Jan 2024 04:01:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704448868;
	bh=197ER86cpXaHwKlmpOfg8emzQLPy/43sB+DYTl5MeVE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=XqnxykQcI31I1xDknMB6ESG6G8LS/d6XttBRqNACyWqEVI5KeKT1zrpM/aYXStXGc
	 /XjvBo2788B7zVmesXCURKKLzGuh22KKOgHXUcAoRZrFpio7FVEPrTnkp0XAwI1jvH
	 HN9Ho/nSwIdXQ6PepF5KinrWOlhU7vuezIoz+eRk=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 405A18kK109291
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Jan 2024 04:01:08 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Jan 2024 04:01:08 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Jan 2024 04:01:08 -0600
Received: from localhost ([10.249.131.210])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 405A16Em108338;
	Fri, 5 Jan 2024 04:01:07 -0600
Date: Fri, 5 Jan 2024 15:31:06 +0530
From: Jai Luthra <j-luthra@ti.com>
To: Sergey Shtylyov <s.shtylyov@omp.ru>
CC: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Javier Carrasco
	<javier.carrasco@wolfvision.net>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rogerq@kernel.org>, <r-gunasekaran@ti.com>, <vigneshr@ti.com>,
        <d-gole@ti.com>
Subject: Re: [PATCH] usb: typec: tipd: Separate reset for TPS6598x
Message-ID: <oonjlgz7fghlmxss6untb2u5hru35t27fbamlfqrolqdeteeyx@nkggaacpjeo3>
References: <20240105-next-tps-fix-v1-1-158cabaec168@ti.com>
 <78925337-0bba-ca7d-aeb1-2d5c53c565ea@omp.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2mg3go7nhbzyckmm"
Content-Disposition: inline
In-Reply-To: <78925337-0bba-ca7d-aeb1-2d5c53c565ea@omp.ru>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--2mg3go7nhbzyckmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 05, 2024 at 12:15:36 +0300, Sergey Shtylyov wrote:
> Hello!
>=20
> On 1/5/24 12:06 PM, Jai Luthra wrote:
>=20
> > Some platforms like SK-AM62, SK-AM62A cannot boot up to prompt if
> > TPS6598x is cold-reset during unconditionally on probe failures by
>=20
>    Hm, I can't parse this. During what?

My bad

s/cold-reset during unconditionally/cold-reset unconditionally/

>=20
> > sending "GAID" sequence.
> >=20
> > The probe can fail initially because USB0 remote-endpoint may not be
> > probed yet, which defines the usb-role-switch property.
> >=20
> > Fixes: d49f90822015 ("usb: typec: tipd: add init and reset functions to=
 tipd_data")
> > Closes: https://lore.kernel.org/linux-usb/vmngazj6si7xxss7txenezkcukqje=
2glhvvs7ipdcx3vjiqvlk@ohmmhhhlryws/
> > Signed-off-by: Jai Luthra <j-luthra@ti.com>
> [...]
>=20
> MBR, Sergey
>=20

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--2mg3go7nhbzyckmm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmWX02EACgkQQ96R+SSa
cUVGghAAsRfotuvarAUj38Gw/3p/0JOBRzQ/P866LOdUynLgU5JlOxwwCKyo1gon
z6yPC1cRUuyzJAvyMYHxY+Je736aVioxr77mhj8rNwVoUbhFapmJIbjY+Jn4QLSa
5NxaXOPJVINNp65sgMTSOyXb9MKGEXHErPPWGRFXP8E4gD4DFQAEC8Gngxea7j4U
JVB+j8ZSGqLLbLTxclL0DH2LIbRD48qLNl61w+Q2s47Sstbqyj8byIj7ILOK+Ps6
975RKXXSBlB51C8Y3K1jhPACckzt+Qj5Ja+TFUIUkjvKXA5lovUwm7D1mTtQNI0u
/3dWPPTMQ1Qa0fjsRY2FD7WpV2Mv8QLLyLHtp1G2s8NTJEIRM1t4oe2EKz/lfKZr
mJmnwrK3zDcqN8rpAB7ZdvaXmku/i9d1uYtvmKpSatdFHCV9Zx/dKM8nUIHZb0Fw
4bcThCGXIY560QUYoCdfeNROpEnR8QSu97gDZEKBAzywy4OcuXwQUBo7H3WXyh9R
iF1kbEd8gbOfTaKUb+sSzsYfx3z7fvtErOFQ6jFZnZSFVBxUQJIFkDZj62Nxi/aA
5UO3cWQN9Am/Nu5mMZ+nDCaliVXb2hM0YIMKEqYpKXOpwPxIWuR8eEeZE2yYtzOD
oTEkK5IHNI/tr/2jiICFGiFigCKaICsNcDbCor9mmrf8s9YZGLg=
=fVsS
-----END PGP SIGNATURE-----

--2mg3go7nhbzyckmm--

