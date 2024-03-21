Return-Path: <linux-kernel+bounces-109910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4388857AE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DDBA1F230E5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244A358226;
	Thu, 21 Mar 2024 10:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rQOfHUrt"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C400C5730C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711018570; cv=none; b=ZHCFFs+9JPZ8nLUr6URMQoYjGSl4pr6xtrqfPBlwD7lvEvrlYMQPh1kC9x4gUNqI7D2KOq3mL/RfhWFq5JZ3xyaDeLFnXxNUQ4a1v9KjBfKjY4O4JhbuhyxhTUL0UdMmskST4NPB/bqfLEkZRWsTwu01bl+sM2d7XUCECECoUtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711018570; c=relaxed/simple;
	bh=heQ08UWxLn7tbd8RbsbtafB7s9ZEhlTjhT6cfeft4ls=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=uu9YS7G2NoXL49MMzemYzQlXmZOixtiluasABOK90AfD9oOohl7G3gr7YRzLI10a+uBi99znvp7cUb6tiyiRnTGNdHLz5u0NL5OdZsB016hWNuj4M5aid8q9Oq9NkOHOcuHQaUfMQstNhqImsiAY+vlAFTKAH70+NBo/TjPwmV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rQOfHUrt; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240321105558euoutp02f530cfef7a9bfd6ba58008133e2488f6~_wlBkCGds0883208832euoutp02e;
	Thu, 21 Mar 2024 10:55:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240321105558euoutp02f530cfef7a9bfd6ba58008133e2488f6~_wlBkCGds0883208832euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1711018559;
	bh=lPu7o6NgNa/JoRTHUUXMfqT5XPevVmyBQ/14nNN4xH4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=rQOfHUrtJNPHRsdCQiyAvroOJXeJUJYCwJeW6VXqeOaFkhgNqcHX4ZcMBkwNv8tLn
	 F6LuvQbAM2jEd5ScgRn4TKXYYoJyi4CLTJi9TO/HIrmv7WvE6+7aIWvCmbxpJF6tlw
	 svdTo4S8eKXZnfOclQeWYS/NcQ0xVbAau80RUi+4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240321105558eucas1p27ffbf6cd2a4b140a9def9ec06c88cdfe~_wlBWbHKX2298322983eucas1p2-;
	Thu, 21 Mar 2024 10:55:58 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 8D.18.09814.E321CF56; Thu, 21
	Mar 2024 10:55:58 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240321105558eucas1p1e0b9b37d2aae8805529af0edad479fb6~_wlA2fFCX1481714817eucas1p1c;
	Thu, 21 Mar 2024 10:55:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240321105558eusmtrp1393c3bebf80bc069b408eef183f4e1b8~_wlA12oKn2741527415eusmtrp1J;
	Thu, 21 Mar 2024 10:55:58 +0000 (GMT)
X-AuditID: cbfec7f4-727ff70000002656-2b-65fc123eca3f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 0A.FE.10702.E321CF56; Thu, 21
	Mar 2024 10:55:58 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240321105557eusmtip2ac74146a0617c6e7f296cd7fbb35b260~_wlAocJ-J1323213232eusmtip2i;
	Thu, 21 Mar 2024 10:55:57 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 21 Mar 2024 10:55:57 +0000
Date: Thu, 21 Mar 2024 11:55:55 +0100
From: Joel Granados <j.granados@samsung.com>
To: Jan Kara <jack@suse.cz>
CC: <wenyang.linux@foxmail.com>, "Eric W . Biederman"
	<ebiederm@xmission.com>, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook
	<keescook@chromium.org>, Christian Brauner <brauner@kernel.org>, Dave Young
	<dyoung@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v2 8/9] fs: inotify: delete these unnecessary
 static variables it_zero and it_int_max
Message-ID: <20240321105555.f4qg5g3wbe57mzzx@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="fxwvznmjean77k53"
Content-Disposition: inline
In-Reply-To: <20240320103603.u6uqhk6viu4qkaht@quack3>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7djP87p2Qn9SDeZc1bR4ffgTo8XlJ3wW
	DRMbWCz+b2tht5g9vZnJ4kx3rsXlXXPYLG5MeMpo0bJ6F6sDp8fshossHgt6zjN7bFrVyebx
	ft9VNo8zC46we3zeJOcx5VA7SwB7FJdNSmpOZllqkb5dAlfG8Q/GBWcFKv49+MzSwLiRr4uR
	k0NCwESifeMali5GLg4hgRWMEo9nnmMDSQgJfGGUWNcvCpH4zCixaOZEVpiO/XsnsUEkljNK
	XDpwgBGiA6hq5bxUiMRWRom3Dw+CdbAIqEpMOL6LGcRmE9CROP/mDpgtIiAtMevYSrDdzAJr
	mSTaXj9gAUkICxRJzPmwFKyZV8BBYt3ZdjYIW1Di5MwnYDXMAhUSJ+c/AIpzANnSEsv/cYCE
	OQVMJf5df8oOcamyxPV9i9kg7FqJU1tuMYHskhBYzSkx+24/E0TCRaK3vwOqSFji1fEtUM0y
	Eqcn97BANExmlNj/7wM7VDejxLLGr1Dd1hItV55AdThKzP//nB3kIgkBPokbbwUhDuWTmLRt
	OjNEmFeio00IolpNYvW9NywTGJVnIXltFpLXZiG8BhHWkViw+xOmsLbEsoWvmSFsW4l1696z
	LGBkX8UonlpanJueWmyUl1quV5yYW1yal66XnJ+7iRGY7k7/O/5lB+PyVx/1DjEycTAeYlQB
	an60YfUFRimWvPy8VCURXnbun6lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeVVT5FOFBNITS1Kz
	U1MLUotgskwcnFINTGI3Z5i6PF5vsJadKcZ/3ad13mUz97d6cDkJKF0zruN0dI/2NDpUfbFA
	VeZ41GntN+mxbyaF79tUXmipbmc8L6ju4KJXNV6xkbENOjGp9UIu0wy5Ns5gXVR+ImKmxkOW
	OvZz/hvmiagtmJx4SmJa8AFTmbYHVvvdjnnHb9n2ZeGJtM/angsclrZ9ruJ6r9GovPPyr8N5
	U+N3LvMvY0i3PhnzgMNLZsYa7oSaackfnuhemPitMKa3cpvtyeC3s564KO/bt+ahUfHTxA0N
	5U0XfifprhUxfXWA5e8Ov7oZs7/9jVA1+LbUU2CVcOnnNGdu1T8BZSqLubsV31bu/XnLbN6s
	ybONnojpeNRXrI//pMRSnJFoqMVcVJwIANSNDRLyAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsVy+t/xe7p2Qn9SDXoaWS1eH/7EaHH5CZ9F
	w8QGFov/21rYLWZPb2ayONOda3F51xw2ixsTnjJatKzexerA6TG74SKLx4Ke88wem1Z1snm8
	33eVzePMgiPsHp83yXlMOdTOEsAepWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtl
	ZKqkb2eTkpqTWZZapG+XoJfx4vgCloLTAhWH2trZGhjX83UxcnJICJhI7N87ia2LkYtDSGAp
	o8SEj88ZIRIyEhu/XGWFsIUl/lzrgir6yCjxf/4nKGcrkDN1GjNIFYuAqsSE47vAbDYBHYnz
	b+6A2SIC0hKzjq1kAWlgFljNJHH370EmkISwQJHEnA9LwVbwCjhIrDvbDjV1GpPE/i0z2CAS
	ghInZz5hAbGZBcok2rf/BIpzANnSEsv/cYCEOQVMJf5df8oOcaqyxPV9i9kg7FqJz3+fMU5g
	FJ6FZNIsJJNmIUyCCGtJ3Pj3kglDWFti2cLXzBC2rcS6de9ZFjCyr2IUSS0tzk3PLTbSK07M
	LS7NS9dLzs/dxAiM/G3Hfm7Zwbjy1Ue9Q4xMHIyHGFWAOh9tWH2BUYolLz8vVUmEl537Z6oQ
	b0piZVVqUX58UWlOavEhRlNgME5klhJNzgempLySeEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0
	xJLU7NTUgtQimD4mDk6pBiaF8PrWjaGeRZdk/ZuKs16F+2lPnrFVQ1SUh6Wutbx080T50tB9
	Uh+XZwp1Xf9/aU9rUsPe/fM/rj2Z8mXPZ0XxazM5GF/mCKlfDtpfsG7F5HfnV3UI3FNflf1S
	6hrjrx699oVvU8rXpDCzhU9ru575X4bpVpio1U2JNzO4DMIm2/W0qFWGla6WYO78yLyLM11h
	1syALV9LIvgfuMoozMs+dMgqeidrau4/NQZ365gDjKtfMfUbvJh8z5jdK9JlNlOOcMwy24K+
	7ucuSvOV/2T9qIpmVpK0muvyyUt+ytHowpblpyaem6TCUMJ3LnHtTtv9akvyNpTffpJRLl4q
	P1vJmdnywDn51rnrWlazKLEUZyQaajEXFScCANuD6ciRAwAA
X-CMS-MailID: 20240321105558eucas1p1e0b9b37d2aae8805529af0edad479fb6
X-Msg-Generator: CA
X-RootMTR: 20240320103608eucas1p235f843330beda0c826ab3cc1709c65e6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240320103608eucas1p235f843330beda0c826ab3cc1709c65e6
References: <26c450f6467b4cbaf94cdb10f047abc6ab0c2a5d.1710863674.git.wenyang.linux@foxmail.com>
	<tencent_3066A7AB308FF9F53E3B5639514306914D0A@qq.com>
	<CGME20240320103608eucas1p235f843330beda0c826ab3cc1709c65e6@eucas1p2.samsung.com>
	<20240320103603.u6uqhk6viu4qkaht@quack3>

--fxwvznmjean77k53
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 11:36:03AM +0100, Jan Kara wrote:
> On Tue 19-03-24 23:57:49, wenyang.linux@foxmail.com wrote:
> > From: Wen Yang <wenyang.linux@foxmail.com>
> >=20
> > Delete unnecessary static variables (it_zero and it_int_max)
> > and encode them directly in the table entry.
> >=20
> > Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
> > Cc: Eric W. Biederman <ebiederm@xmission.com>
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Joel Granados <j.granados@samsung.com>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: "Darrick J. Wong" <djwong@kernel.org>
> > Cc: linux-kernel@vger.kernel.org
>=20
> This looks as a sensible cleanup but I don't see the first patch in the
> series (and neither it is archived at lore.kernel.org) so I cannot really
> verify whether your conversion is correct...
This was my original comment. If you want to see the cover letter
look for this mail ID tencent_06797E65CFC655DCD4F0414B9380E95ECC08@qq.com

Not sure why it separates the cover letter from the rest of the patches.

Best
>=20
> 								Honza
>=20

--=20

Joel Granados

--fxwvznmjean77k53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmX8EjoACgkQupfNUreW
QU/v+wv/ekDoDEuZcS5oVjLYGPtvESSFVw4WsAgqOUz3g4FD776q0TW0f3UVWfp5
/hgeE+usbvT9QIjcb53qGfhOAaYeRnZR0peUGyNqg5UtYU7S84WRNd/kHoFjEQsN
NhqC+Q8jBOMBhQ05/PpkF4rqKQ0Wqn1VTPyFU7qNpc0WPYcq2q+nEh+vOV0BdphF
Fe2cMqyH6X6TcFMgD5vYwWBWckAv3MvanBJ/R+LnX3hylZpbT1DL0L9lndYWCTLe
87gUrKCNmfqTPzQOMdYGca6sRBsQ+o5ckAYSRuwTXL2pomN0zS40sh6Vc+EE6FGi
OHdcYprQGuQRCJfTeDZ+PkUvozXhDazwaNg9aepHL37LD3U0dKqa2rzKBj66XQI0
V4lLrLECrGrupu9jd/X8iH9loaQEdpFAdJKXYvNdeiqRS/aTj7nEjTd+5vUNIqU+
04hdAChKLDIggOtqtvElZlRkGCWhiCOVTYh0GhwO5KjEdYTRSJeyzDzpiVUc07uG
QybbYv+o
=vd8Y
-----END PGP SIGNATURE-----

--fxwvznmjean77k53--

