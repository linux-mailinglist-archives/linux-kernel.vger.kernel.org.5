Return-Path: <linux-kernel+bounces-32860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D851E836105
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC9A1F24D1C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2474B48CC9;
	Mon, 22 Jan 2024 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BFrH9pYr"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9618481DB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921539; cv=none; b=ofCvFD9WapAfL/HtVu0xATmSRVe1sKWmNqHo2DCD9Qoy7H7Cz2JIuukfmaecdl+d3ar0FJ3rplujUc+X7LiwNQQA8UWSk7oIcwnqMORKG7xGzCPVN2dIeR0/w6Lr9nCOlf0WvytZQhBq9/kweuuqNcouaO+UAngPMAyeA2fx16M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921539; c=relaxed/simple;
	bh=wvjwdpqHFmPZh9vpAuGEcnZo/ktwTxoXW3DlASmuDAs=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=HUxV1vgLt/DWhuU9c9hWUDsA5HI6yLHD5MilEqFvKYjT7YCgfrfFJM20uJaOD0vm/uj41YLGbqRPMMm0tor4d4pMS0ZnB1ejH1hJzqUtuEqMg/osMr3Nnn00fc+k2kSypWMPr2IV8c72TP4Snv19lZqrWYwH49HJGkb9pfuIp60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BFrH9pYr; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240122110529euoutp017e4340dab2885bdd132da830d36f12a7~sppe0Rqbf2665826658euoutp01L;
	Mon, 22 Jan 2024 11:05:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240122110529euoutp017e4340dab2885bdd132da830d36f12a7~sppe0Rqbf2665826658euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1705921529;
	bh=wvjwdpqHFmPZh9vpAuGEcnZo/ktwTxoXW3DlASmuDAs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=BFrH9pYrUL4FLEnDmA9qGprTW4lMH5WWPntG9zmS21zBZERs1Eq8dL+lgYCZ7NMJK
	 VPeMM6c2yCrJ1BXEcLN/pEcAmr/cvtPcWhPArojP5HVYcCmq4Aaw9D48wJq4KbhrxW
	 SVyxmx0x6LNMFp6g+p7wYGf3HkT8H33TXO6h27pY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240122110529eucas1p2560a1dacd95a7ce5bec85306c8dae140~sppeqZ5KJ2032920329eucas1p2K;
	Mon, 22 Jan 2024 11:05:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id C9.B5.09539.9FB4EA56; Mon, 22
	Jan 2024 11:05:29 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240122110528eucas1p2503e361d27caba414a2172e7d678653b~sppeKPqrF2033320333eucas1p2N;
	Mon, 22 Jan 2024 11:05:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240122110528eusmtrp155e21cce0e85fd46392f6e88f8b160ac~sppeJnvHe2903029030eusmtrp1_;
	Mon, 22 Jan 2024 11:05:28 +0000 (GMT)
X-AuditID: cbfec7f2-515ff70000002543-0c-65ae4bf946ad
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id D9.70.10702.8FB4EA56; Mon, 22
	Jan 2024 11:05:28 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240122110528eusmtip13d2a7ec5bd59ca10f886b37a9f620537~sppd7_TLH0691806918eusmtip1f;
	Mon, 22 Jan 2024 11:05:28 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 22 Jan 2024 11:05:27 +0000
Date: Sun, 21 Jan 2024 20:40:26 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] scripts: check-sysctl-docs: adapt to new API
Message-ID: <20240121194026.y7i4arsltm3fdxfm@localhost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="ch4xq5a6yqqpzhv6"
Content-Disposition: inline
In-Reply-To: <3fd9a074-88cf-45eb-9f04-f8de7314b0a7@t-8ch.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7djPc7o/vdelGpxr57C4vGsOm8XvH8+Y
	LG5MeMrowOyxaVUnm8fnTXIe/d3H2AOYo7hsUlJzMstSi/TtErgytq4UKPjHXdGx7w5LA+MR
	ri5GTg4JAROJd0uuMnUxcnEICaxglLi7ZB2U84VRYknDTnaQKiGBz4wSe584wXR8friEHaJo
	OaPE67nHWCAcoKKvZ75DZbYwSrRcX84M0sIioCpx7ugjRhCbTUBH4vybO2BxEQEbiZXfPgM1
	cHAwC3hI7J0QChIWFnCRWH1/Alg5r4C5xIMr01kgbEGJkzOfsECUV0gc2yEJYUpLLP/HAVLB
	CTRw++8ZzBB3Kkl8fdPLCmHXSpzacgvsMQmBFxwSj2/3QBW5SFzqWw9VJCzx6vgWdghbRuL0
	5B4WiIbJjBL7/31gh3BWM0osa/zKBFFlLdFy5QlUh6PEp7s9rCAXSQjwSdx4KwgSZgYyJ22b
	zgwR5pXoaBOCqFaTWH3vDcsERuVZSD6bhfDZLITPZoHN0ZO4MXUKG4awtsSyha+ZIWxbiXXr
	3rMsYGRfxSieWlqcm55abJiXWq5XnJhbXJqXrpecn7uJEZiITv87/mkH49xXH/UOMTJxMB5i
	VAFqfrRh9QVGKZa8/LxUJRHeG5LrUoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzqqbIpwoJpCeW
	pGanphakFsFkmTg4pRqY5q59eUD05IJct/OP/p2ZVbQsrU58g0dS+bxPt2RLLHhOMG17uMX2
	1OWzMzQj3+U8tgt8uVPf097SauWvBncrxVN2p0S4FSbE6E0JCJY13HVMP1dh+pbPdtrdKZ16
	L7+1xqiXXj/p/9VO+fOOw4u+ev/yW/XWUu1Z5ly+t39XpatxVT+0jviVU3qi1/1/3rZphh5+
	3tYlP1hi1iu2p3G/9nqmnRHvVZWUIMj3MsBZYo1k++mLrxWWnSyLufBY/OlqrXXnTl7Kf3Hv
	dNMVq0Ub961QZ50ubP3bXLhPQUt3P6exct2m3bnZB/h0V+e5vgSm8Dscv9zMC6SzJk3NzxKQ
	ZX45JSJHgulRoe/Cw1OUWIozEg21mIuKEwFKukqQvwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xu7o/vNelGrzvU7G4vGsOm8XvH8+Y
	LG5MeMrowOyxaVUnm8fnTXIe/d3H2AOYo/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyN
	zWOtjEyV9O1sUlJzMstSi/TtEvQyZn06xljwh7tizXrxBsZDXF2MnBwSAiYSnx8uYe9i5OIQ
	EljKKLF1+Sw2iISMxMYvV1khbGGJP9e62CCKPjJK7NmyhhXC2cIo8W/WPSaQKhYBVYlzRx8x
	gthsAjoS59/cYQaxRQRsJFZ++wy0goODWcBDYu+EUJCwsICLxOr7E8DKeQXMJR5cmc4CMfMH
	o8TanadYIRKCEidnPmEBsZkFyiSO9/SyQsyRllj+jwMkzAk0fvvvGcwQhypJfH3TC3V0rcTn
	v88YJzAKz0IyaRaSSbMQJkGEdSR2br3DhiGsLbFs4WtmCNtWYt269ywLGNlXMYqklhbnpucW
	G+kVJ+YWl+al6yXn525iBMbktmM/t+xgXPnqo94hRiYOxkOMKkCdjzasvsAoxZKXn5eqJMJ7
	Q3JdqhBvSmJlVWpRfnxRaU5q8SFGU2AgTmSWEk3OByaLvJJ4QzMDU0MTM0sDU0szYyVxXs+C
	jkQhgfTEktTs1NSC1CKYPiYOTqkGJtMi++ObWfTmfgkx+twnnsO73f2e27vF3zjjXqxsc9tw
	RD3iQ/hKkdsVkavtwnh/+Pi0dAT4nvX4PC80cqVrcue2W3fD1Wr/7GeZmLr55t7DgrKH9f+n
	tzl1fX3AuCU8LVA1bXqmQNiiYr8ZOqbigk6pZqfZ599563F1wyuW5seNIpfm+dTpXT4mHOtq
	KRB5S7AycsXuwFY5I4nq5UUfmOaw73R9EthZelqMI0LkxImbp2IuPTf97cietOH60Q7Bi9o3
	Is9MEFpQ5fHyl8AJSymuLe87l4ckr2pe9/fCJ+3uGK8A+zfzzhY0TRHwnvzEyKQk5KLC5vzX
	mhp1k8T3he2U2L5F6Y+92x91D/ZuJZbijERDLeai4kQA60cmol4DAAA=
X-CMS-MailID: 20240122110528eucas1p2503e361d27caba414a2172e7d678653b
X-Msg-Generator: CA
X-RootMTR: 20231226113448eucas1p2790755bc45518304822dc9b24c93c2a3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231226113448eucas1p2790755bc45518304822dc9b24c93c2a3
References: <CGME20231226113448eucas1p2790755bc45518304822dc9b24c93c2a3@eucas1p2.samsung.com>
	<20231226-sysctl-check-v2-1-2d4f50b30d34@weissschuh.net>
	<20240115154907.ubr4admknmousjbz@localhost>
	<3fd9a074-88cf-45eb-9f04-f8de7314b0a7@t-8ch.de>

--ch4xq5a6yqqpzhv6
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 10:20:37PM +0100, Thomas Wei=DFschuh wrote:
> Hey Joel,
>=20
> On 2024-01-15 16:49:07+0100, Joel Granados wrote:
> > Hey Thomas
> >=20
> > I lost track of the thread here. Did you get my latest answer to your V=
1?
> > https://lore.kernel.org/all/20231231143455.tvwb464awfzv5uti@localhost/
>=20
> I got your last anwer.
>=20
> Unfortunately I didn't find much time to work on my sysctl patches
> recently. It should improve in the near future, though.
Understood.

Looking forward to your next versions, when you get back to it :)

Best

--=20

Joel Granados

--ch4xq5a6yqqpzhv6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmWtcyMACgkQupfNUreW
QU/E6Av/Us+bPESv2fKLn7v2X0aCxbZ4bO70UP0N5SG6grOjAK3D3oIKXoZp1KLf
5vdDtX7qel91wKUfeu1bkmlSAnvBZQareAJKQi5qektHi2b3qxo8a6ujyl/y/XPl
Ha21dnxyNYeW+CwgWTdqLdDeCJ27CaUfSOUajomP5cJ9uUFtnMSov3eXm646hMol
2gPHLzlarvWvfRgCUpdx72XuBTLZZY1wCPpd+4/cqejc4xo/TI/bQQPjkz0wCHKv
t+aFbjGaWuWFIgnYIy078IPTP21woUsQMXdEvbey9pgUXlcn/iV6adiSrDr1gvRY
yT7nWosTWl/eQ/nW+EBtBVQCZ1gO+H17M07XkZcxKuWPKTJWS+pLT0cjnUa3VTBK
i8jVV0bzaIBDEvKMtQJJFHTVOoIkjM7cpmkPiRVhKmzC0mYJXH0/DT9+nYuI4T7w
TenLODqLX9feqVVZg5kgMHOESCaLnxNthd0i+WCDIU2cLPpSM2IB/ztFaIY2Yx1m
Elp8+bZX
=7sjs
-----END PGP SIGNATURE-----

--ch4xq5a6yqqpzhv6--

