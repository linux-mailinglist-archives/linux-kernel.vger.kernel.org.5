Return-Path: <linux-kernel+bounces-164022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D12BB8B7742
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C6DA1F2192A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85FF171E65;
	Tue, 30 Apr 2024 13:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sjyslyhE"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D609742AA5;
	Tue, 30 Apr 2024 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714484169; cv=none; b=QW+QN4vOXZKo9AZwCd8YaHOKrKz8cKndn48TMewmbt8PhfoHvRBQcoWNrDzhVH4zvR+bp6Q53Yc+LBHfLla/3gKMDWbT75SQNKB9kxPQrGUzMH+eWcIpUOUPIi5dRpdY4uiS63eU0Q9tRPL6/8dsLTU5B8dGJIMRdQ9L1MW5icw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714484169; c=relaxed/simple;
	bh=hIBQmr1iIdGfeAcj6CDd054mPC2lR9TE2NlZkFYMpLg=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=DhZY718ub9mQVCpTyGd9Q6e1EaVY0okRqMYVbkcFFqZmre7AZ8r4JiVhe9Kq1rujG8/kR31rGDMYLb/njrmJ7012dffC90fSCpAB3ezvmB50X/l4iOgc9y9DqhhsSxv5q8NfF+R4VoOA5I37fUmARn6x+AqQMgvQ/u9hPkV6hvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=sjyslyhE; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240430133605euoutp026ca7bbaf49ec4d394fb942e3854e4d32~LEkOthw3u2611726117euoutp02Q;
	Tue, 30 Apr 2024 13:36:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240430133605euoutp026ca7bbaf49ec4d394fb942e3854e4d32~LEkOthw3u2611726117euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714484165;
	bh=hIBQmr1iIdGfeAcj6CDd054mPC2lR9TE2NlZkFYMpLg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=sjyslyhE6JErOwZypmfHWxFal39SQ2HV6OX4nDn/Ajv7tK83ZF93YX0FpOY/bfg87
	 nMtEFHpzCuutuIVFmvx7KrBRDzRPQGpwxPYvMDkfzZgj6u0a+3cUN1FQ1oQ2Nt1Km2
	 GMfsDaTIcnTznIKKZYQPaLRF2HgLXzz8AQPbSgk8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240430133604eucas1p2abd111c18e752e9c9ec180ad5700e6cc~LEkORvPyb0661406614eucas1p2H;
	Tue, 30 Apr 2024 13:36:04 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id A3.F1.09620.4C3F0366; Tue, 30
	Apr 2024 14:36:04 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240430133603eucas1p2b18f143ca1f76b388ee3bc32a2a92394~LEkNvfC5N3071630716eucas1p2E;
	Tue, 30 Apr 2024 13:36:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240430133603eusmtrp13eaaf4735e444dd7cbcf061679831ccb~LEkNun9wb3005630056eusmtrp1V;
	Tue, 30 Apr 2024 13:36:03 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-e3-6630f3c4328e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 62.93.08810.3C3F0366; Tue, 30
	Apr 2024 14:36:03 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240430133603eusmtip115e3012568dcbfaf9672af418502f8e0~LEkNfbXtF0409904099eusmtip1n;
	Tue, 30 Apr 2024 13:36:03 +0000 (GMT)
Received: from localhost (106.210.248.68) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 30 Apr 2024 14:36:02 +0100
Date: Tue, 30 Apr 2024 15:35:58 +0200
From: Joel Granados <j.granados@samsung.com>
To: Alexandre Ghiti <alex@ghiti.fr>
CC: Nam Cao <namcao@linutronix.de>, Mike Rapoport <rppt@kernel.org>,
	"Andreas Dilger" <adilger@dilger.ca>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
	<bjorn@kernel.org>, <linux-riscv@lists.infradead.org>, Thomas Gleixner
	<tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>,
	"ndesaulniers @ google . com" <ndesaulniers@google.com>, Luis Chamberlain
	<mcgrof@kernel.org>, Ingo Molnar <mingo@kernel.org>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Tejun Heo <tj@kernel.org>, Krister Johansen
	<kjlx@templeofstupid.com>, Changbin Du <changbin.du@huawei.com>, "Arnd
 Bergmann" <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] init: fix allocated page overlapping with PTR_ERR
Message-ID: <20240430133558.bonevzcshxm6xntt@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="2dq6zdwzjqmuy54k"
Content-Disposition: inline
In-Reply-To: <0049995a-07d0-4aaa-abc7-5bfc0dc22ace@ghiti.fr>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WSfUxbZRTG9957e3upK14KyCurzhTZMj4KBmOuEwtTw65myWYyTZh/uDru
	YAEK9q5s1BFByNgWjVCYUGxJ9yFgywqUDstXUCwfBe1YWuLaIZsNzm2wD4aNs7BOust0if/9
	znPO857zJC+Bis7hscQBxUFGqZAXSHAB1jP6tzPZvpS6P9X607NUi8OHULqOdpy6NuPnUQ80
	o3zq/B0jRo0sPEfNaP7gU/qvNYDqsmkRytWnw6mepSqculTzO6BMwQlADQ4NoNTdmocIZe/4
	DqEMXT5AdVtOolSgdQRkRtLLAQ2g/R4nQld1H6Jnx7/i0bU/J9MGi4qust/i0RbjcZy+7XTy
	6fHGZYzuPvspbZxrR+kly/O7hHsE6TlMwYESRpki2yvIc9iug+Jp4WFz7UV+OfA9dQKEEZB8
	GY5f7QQngIAQkW0Ajl68jnPFnwDO10/xuGIJwKn2CvSxRbu6g2u0Aljru8//d8qrs651rADq
	/C1IyIKR8fC4xvjIjpNJ8MLCzCoTRBQZB3vtcaF5lHTw4P0bC3hoJpLMgs1nq7EQC8lM6D32
	C5/jCOjQzj3SUfIwdLVe5oXeQckNsDVIhOQwMh1OGEZx7lIJ/KJRj3BcBiesXiS0C5LfCKC+
	+txanLfg5LfuNUMkvDlm5XMshpN1n2OcoQ7AoeBdPleYAGyp8K89+xqscs/xQ1dAchu89kDN
	YTi8dCuCuzMcanoaUE4WwmNHRZxxEzTNLmA1IK7piWRNTyRr+i8ZJydBQ/89/H9yImw5NY9y
	/Do0m+9gBsA3ghhGxRbmMmyagjkkZeWFrEqRK91XVGgBq794Mjjmt4G2m4vSYYAQYBi8uGr2
	dZqmQCymKFIwkihh/amU/SJhjrxUzSiLPlSqChh2GGwgMEmMMD5nIyMic+UHmXyGKWaUj7sI
	ERZbjuzYGDgjbj4StGS0Sd/ZIz4TlZ7dEFBP+5vPT8sr0dvPOFwvDH+ivnIa221zm/EFWaJ6
	39bw2YS0PLmnckuXa9vgl9szs5wZqiMfmSzsX7xdbf3uGH1+8m9BNq93ZaVhXrTXU+E2rd+x
	or3seW+w/tXSOcXi96ZOusSZNTSpHxj7cWupbZMq/Wim7TPR+0lW37o3y7yvBFJSqo1Pf2BM
	m/HkbN5Zcnqx+12w29sRveUNgcms9ssGSqIv3Kv+oTzB1RhMlVXEZGD5b49Er08srbuimYhY
	7q/UrUOjAsJacV8ZE53fe5Jdfng1Wybd/LFY25fdV9z+a/yN7ZhOaNwZbpdgbJ78pQRUycr/
	AZU+EgJABAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFKsWRmVeSWpSXmKPExsVy+t/xu7qHPxukGTScMrZYdvIRk8Wc9WvY
	LJ7d+cpq8XfSMXaLre9XsVgcfSNrcWfSc3aLubMnMVps3DGTyeLyrjlsFts+t7BZ3JjwlNFi
	9b9TjBZ79+9htvgw4T+TxZH125ksFmx8xGixedNUZotfy48yOgh7/P41idHj681zTB4tm8s9
	7p2Yxuox8ayux4JNpR4tR96yemxa1cnm8e7cOXaPEzN+s3hsXlLvserJGmaPz5vkAnij9GyK
	8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DKu33/JWnCZ
	t+LPlnbWBsYH3F2MnBwSAiYSM4GGdjFycQgJLGWUeN57kAkiISOx8ctVVghbWOLPtS42iKKP
	jBJN99ZCOVsYJRatOMQOUsUioCrROWkVM4jNJqAjcf7NHSCbg0NEQFli5xFlkHpmgZOsEp0T
	14BtEBZwk5i3pJ0FxOYVcJC41XGdHWLoQiaJrXPvQyUEJU7OfAJmMwuUSTzYdAxsKLOAtMTy
	fxwgYU4BG4lTC46xQVyqJNE7Yy7UB7USn/8+Y5zAKDwLyaRZSCbNQpgEEdaSuPHvJROGsLbE
	soWvmSFsW4l1696zLGBkX8UoklpanJueW2yoV5yYW1yal66XnJ+7iRGYkLYd+7l5B+O8Vx/1
	DjEycTAeYlQB6ny0YfUFRimWvPy8VCUR3ikL9dOEeFMSK6tSi/Lji0pzUosPMZoCQ3Eis5Ro
	cj4wVeaVxBuaGZgamphZGphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBKNTAp3Fi3Klu3
	i3XzqYUnfkrOSTJeK3f8Np8dx/57LTPzj6fLat2dsOrJu7LXTKbHXz2xlpb7XR78Iu/6vvgd
	G1bn6j2aaL1vYuvxa7q35131uBNffTXHKWLbkk2LT2/ZPOMDU4xWWTZrenj+jOJOveNRjdvu
	yG7dYJm2lCVKmsXBP+Osvfd9sWUCYptdNSNWlX1PSSgOfvg8ZENUsdqWny7Bfdn5944XvYp7
	9cDj6eqjtUFnhSR5it5X2/BeKj9XK9NZ/CDBjCfu91GGYJ/KDMaE/9dV7hr9/Cb6ZcbGTHuj
	DQsMk7c6fL7knv/h9rN3277ZMpvX801fwfVP8vXNFi53ixK5JusYy4mys6fveFKsxFKckWio
	xVxUnAgA8g+6490DAAA=
X-CMS-MailID: 20240430133603eucas1p2b18f143ca1f76b388ee3bc32a2a92394
X-Msg-Generator: CA
X-RootMTR: 20240429125236eucas1p24219f2d332e0267794a2f87dea9f39c4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240429125236eucas1p24219f2d332e0267794a2f87dea9f39c4
References: <20240418102943.180510-1-namcao@linutronix.de>
	<CGME20240429125236eucas1p24219f2d332e0267794a2f87dea9f39c4@eucas1p2.samsung.com>
	<20240429125230.s5pbeye24iw5aurz@joelS2.panther.com>
	<20240430073056.bEG4-yk8@linutronix.de>
	<0049995a-07d0-4aaa-abc7-5bfc0dc22ace@ghiti.fr>

--2dq6zdwzjqmuy54k
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 10:37:59AM +0200, Alexandre Ghiti wrote:
=2E..
> > the issue is about overlapping sections during linking (maybe something
> > wrong with riscv linker script?)
> >
> > Also, FWIW, this patch is not going to be in mainline because of a
> > regression.
> >
> > Nonetheless, I will have a look at this later.
>=20
>=20
> The config shows that it is a XIP kernel that comes with its own=20
> limitations (text is limited to 32MB for example), so I'm not surprised=
=20
> to see those overlaps.
>=20
> We already discussed the removal of randconfig builds on XIP configs,=20
> but IIRC it is not possible.
Have you had them in public? Do you have a link to the discussions.
Maybe there is something there that will tell me what to with this
report.

Best

--=20

Joel Granados

--2dq6zdwzjqmuy54k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmYw874ACgkQupfNUreW
QU/5KAwAhUAnVr1eR0wkyaXz0NCNO59yT7pgKDv2O2EJwhiivZ+CQpbg1qbMlKKa
ZOy+tIb7ffsxJ9hY6SEaKOMX3tEfzcu2hLWrqrXEEQ/p3JlRYFaueqvWQRaPZRFE
xsmFm0ed/iAxtjruRBm5+pkfd3W15HcS1cqoyTqS4pjsHWSE8GW50ks56xbGYXh7
Aq+55Ebar9pHQ1s7mUtE/OOtKrM4WhFKSfFiKprMkhhrTLRWd0duPomISBdG/ftY
zF/7zLSALU8E7UwB9O/Ve7PEdpmWFleiKRKkdbJAksw7hcOVjtdAbb/maEK3yqQ+
N2K2IKGN3EmNdRaf+wYVNMe7ocIKmsGRc/yoTxDKcZwUUyVMshZkbO0/uRd5MUeI
ItHonlqZJsQ7q0OZ7uYTP2SdfRyqn47TxVCNRqWiPeLdI8wx4U63/i+82+LHaNHu
fY2GWYy2HE75UA5WhUze1RTISUqCw2+WakCh2ts7MoucuXFTRVzd8ZrX63w5Xgce
wvjI7ToS
=zGuC
-----END PGP SIGNATURE-----

--2dq6zdwzjqmuy54k--

