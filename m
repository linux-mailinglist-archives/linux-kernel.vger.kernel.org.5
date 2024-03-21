Return-Path: <linux-kernel+bounces-110344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD156885D7C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 686721F2516D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B18179D2;
	Thu, 21 Mar 2024 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mDo19HkU"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80456FC1E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711038754; cv=none; b=dvfiNYKmT7PbMnUG3H8XdINp7TisCgSBrYDwF5sb4mmT+buFC0/4ZTs6xbbYLR8aJ2TL+1qPRzUPG/aIctd1WwLL+NF0pPjX4fE6V0xgKQMzPvaZnwiZ94/9O9zxVEAieci867h/w9Q+US5iF07lfUvcXqQuV58yFWWanLZbGSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711038754; c=relaxed/simple;
	bh=izDmSTAEzxgez9G2LtYpkaBBGYy5uBgvzTbClLXStsE=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=TAFxy8LvZEE3rg1cD+aeBV3CCOiMOvfms1knR16YuZkWEjDBHdCvg1zGjDBGcS7ToyDk3Ub35XmnVIMOArOmKL1OlWVdfEJAF53ObD9BvgJDzTM1SxdkqKKAE/kZvChN0/I88y/Bg8/84xdXw6hu0B7YDLSMcbRpn3PM1ifbTsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mDo19HkU; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240321163221euoutp013d6c2fb5e2864c750010536e1c495593~_1KuLpGRo2455924559euoutp013;
	Thu, 21 Mar 2024 16:32:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240321163221euoutp013d6c2fb5e2864c750010536e1c495593~_1KuLpGRo2455924559euoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1711038741;
	bh=/M1ihNd6/r7wE0Hhk+6dFT6VDuvp2XVA1Kb2HTFBRSg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=mDo19HkUObjbRMwsKoPROqPvaXmr8rtZZusCoWeIrGZinvnZeIqelGFapWAFQG0yZ
	 noLRoD1M9e4urb2F+d17wzfMqFlURt2YPEbk0r/lcLIXj1NoqqLuQQ8/avW7u/d2a6
	 r87J7qBjoyVR9Qv1qbRxYU2QvMveT1wuvVR76FnI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240321163221eucas1p1a8da296c1e7e58c2b386c228480486bb~_1KuDEVFj1900319003eucas1p1C;
	Thu, 21 Mar 2024 16:32:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 8C.C0.09552.5116CF56; Thu, 21
	Mar 2024 16:32:21 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240321163220eucas1p1d95bba582d728afbe8b013eb977d8b87~_1KthoKV02405724057eucas1p1i;
	Thu, 21 Mar 2024 16:32:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240321163220eusmtrp2d423eca30c5ee8337813a16915a21130~_1KthCYF11910719107eusmtrp2F;
	Thu, 21 Mar 2024 16:32:20 +0000 (GMT)
X-AuditID: cbfec7f5-853ff70000002550-38-65fc611574a5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 56.2D.09146.4116CF56; Thu, 21
	Mar 2024 16:32:20 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240321163220eusmtip2b1323ede647f52563dd834fdb4b29de5~_1KtViWjh1146011460eusmtip2n;
	Thu, 21 Mar 2024 16:32:20 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 21 Mar 2024 16:32:20 +0000
Date: Thu, 21 Mar 2024 17:32:18 +0100
From: Joel Granados <j.granados@samsung.com>
To: Wen Yang <wenyang.linux@foxmail.com>
CC: Jan Kara <jack@suse.cz>, "Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	Christian Brauner <brauner@kernel.org>, Dave Young <dyoung@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v2 8/9] fs: inotify: delete these unnecessary
 static variables it_zero and it_int_max
Message-ID: <20240321163218.6bqvs2f2ick7lltg@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="kwjstpfzr53dfx5y"
Content-Disposition: inline
In-Reply-To: <tencent_5C3A21886D522B5D9DF9CAAFF499AB6A9805@qq.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7djP87qiiX9SDY4fk7V4ffgTo8XlJ3wW
	DRMbWCz+b2tht5g9vZnJ4kx3rsXlXXPYLG5MeMpo0bJ6F6sDp8fshossHgt6zjN7bFrVyebx
	ft9VNo8zC46we3zeJOcx5VA7SwB7FJdNSmpOZllqkb5dAlfG6keHGQseiVdc+hrdwDhFpIuR
	k0NCwETi8OYvrF2MXBxCAisYJR4+3sAG4XxhlNh7/SAzhPOZUeLMrhvsMC13d05hhEgsZ5Ro
	PrSMCa7q8NHlUMO2AvV/u8sE0sIioCrxueUHM4jNJqAjcf7NHTBbREBD4tzVbrAGZoHlTBJf
	DxxjBUkICxRJzPmwFMjm4OAVcJBY2m8JEuYVEJQ4OfMJC4jNLFAhMXdWN1gJs4C0xPJ/HCBh
	TgEnibafh5ggLlWWuL5vMRuEXStxasstqPhmTomDr+0hbBeJR9N/MULYwhKvjm+B+lJG4v/O
	+WCPSQhMZpTY/+8DO4SzmlFiWeNXqEnWEi1XnkB1OErM//+cHeQgCQE+iRtvBSHu5JOYtG06
	M0SYV6KjTQiiWk1i9b03LBMYlWch+WwWks9mIXwGEdaRWLD7ExuGsLbEsoWvmSFsW4l1696z
	LGBkX8UonlpanJueWmycl1quV5yYW1yal66XnJ+7iRGY7k7/O/51B+OKVx/1DjEycTAeYlQB
	an60YfUFRimWvPy8VCURXnbun6lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeVVT5FOFBNITS1Kz
	U1MLUotgskwcnFINTEn3L1l/1bZ4Zdq2J+by0byg726/l1e1Htf7pTRNbt37I3d+PggoPM54
	cq/nd0X7fZEve9gMmn82FxlFrhWect31P9fFFvPH5rqtAWusXfUqZWonPhY+ejE0j1HuWkef
	Dqu9x/U9PPP+3os4/ub4DrG2pRu2TP3bXP1965sD37alHZos9096VwLDvSzNmwHhW10U7xax
	LDb41vDt9EmDL21FZn/PL7ULCbyo4iZ59eDW9tW3NpV8XFCX9bwkp/nLb06DOzlLX3zqu7i3
	YF+jWKCGBwPzLLHrJo7p829uOjj97uugnCAvieDAj+6zjJ4dn9UkOsvu1rn+rZxCehrrc6dX
	mt6Zr918tvOZ+Z3jnKxKLMUZiYZazEXFiQCwXWIP8gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsVy+t/xe7oiiX9SDb59MrN4ffgTo8XlJ3wW
	DRMbWCz+b2tht5g9vZnJ4kx3rsXlXXPYLG5MeMpo0bJ6F6sDp8fshossHgt6zjN7bFrVyebx
	ft9VNo8zC46we3zeJOcx5VA7SwB7lJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayV
	kamSvp1NSmpOZllqkb5dgl7G0turmQseiFe83DmFqYFxkkgXIyeHhICJxN2dUxi7GLk4hASW
	Mkp0zN7PApGQkdj45SorhC0s8edaFxtE0UdGieb5LVAdW4E6ti4G62ARUJX43PKDGcRmE9CR
	OP/mDpgtIqAhce5qNytIA7PAciaJrweOgY0VFiiSmPNhKZDNwcEr4CCxtN8SYugGZolby7+w
	gdTwCghKnJz5BGwBs0CZxNV5m9lA6pkFpCWW/+MACXMKOEm0/TzEBHGpssT1fYvZIOxaic9/
	nzFOYBSehWTSLCSTZiFMgghrSdz495IJQ1hbYtnC18wQtq3EunXvWRYwsq9iFEktLc5Nzy02
	1CtOzC0uzUvXS87P3cQIjPttx35u3sE479VHvUOMTByMhxhVgDofbVh9gVGKJS8/L1VJhJed
	+2eqEG9KYmVValF+fFFpTmrxIUZTYChOZJYSTc4HJqS8knhDMwNTQxMzSwNTSzNjJXFez4KO
	RCGB9MSS1OzU1ILUIpg+Jg5OqQYmuSTdtwymzW57N4pYqSl4L/nEbq8r1C34/EbG9qQ7D3ut
	v9ZpflLmW6zmf+PjmnpF/qsl1/Yv8z51mMWnyrun/Z5BENvbtu8tE4T6ftrPcbZfVv/8mMrV
	257L3kQlHeYxenxu44aUzaHTDPeEv7qfq9wo2VZrG9VzN/DmHI5X9dIPJvE1fl/v3tJkelvP
	kUFZp8F5/4N5NwyjVPtOvJNmYdhjOHvPurtbdtQkPzZ2PhGZdy2znyGFb8L+K3Zsyg9Sv85O
	nDBPM3FbS4kVa8dr4WwxlRvlB9+K7XbcqTX119/HSQpWD//sXLrEP1RP1uOD5a9S3sp+zy/L
	Nkj+nlXxOVr20HQ7uzKXo14/4wqVWIozEg21mIuKEwFd0M+MkAMAAA==
X-CMS-MailID: 20240321163220eucas1p1d95bba582d728afbe8b013eb977d8b87
X-Msg-Generator: CA
X-RootMTR: 20240320103608eucas1p235f843330beda0c826ab3cc1709c65e6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240320103608eucas1p235f843330beda0c826ab3cc1709c65e6
References: <26c450f6467b4cbaf94cdb10f047abc6ab0c2a5d.1710863674.git.wenyang.linux@foxmail.com>
	<tencent_3066A7AB308FF9F53E3B5639514306914D0A@qq.com>
	<CGME20240320103608eucas1p235f843330beda0c826ab3cc1709c65e6@eucas1p2.samsung.com>
	<20240320103603.u6uqhk6viu4qkaht@quack3>
	<20240321105555.f4qg5g3wbe57mzzx@joelS2.panther.com>
	<20240321113849.hfzmnz6p3cjbmmwt@quack3>
	<tencent_5C3A21886D522B5D9DF9CAAFF499AB6A9805@qq.com>

--kwjstpfzr53dfx5y
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 10:41:26PM +0800, Wen Yang wrote:
>=20
>=20
> On 2024/3/21 19:38, Jan Kara wrote:
> > On Thu 21-03-24 11:55:55, Joel Granados wrote:
> >> On Wed, Mar 20, 2024 at 11:36:03AM +0100, Jan Kara wrote:
> >>> On Tue 19-03-24 23:57:49, wenyang.linux@foxmail.com wrote:
> >>>> From: Wen Yang <wenyang.linux@foxmail.com>
> >>>>
> >>>> Delete unnecessary static variables (it_zero and it_int_max)
> >>>> and encode them directly in the table entry.
> >>>>
> >>>> Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
> >>>> Cc: Eric W. Biederman <ebiederm@xmission.com>
> >>>> Cc: Luis Chamberlain <mcgrof@kernel.org>
> >>>> Cc: Kees Cook <keescook@chromium.org>
> >>>> Cc: Joel Granados <j.granados@samsung.com>
> >>>> Cc: Christian Brauner <brauner@kernel.org>
> >>>> Cc: Jan Kara <jack@suse.cz>
> >>>> Cc: "Darrick J. Wong" <djwong@kernel.org>
> >>>> Cc: linux-kernel@vger.kernel.org
> >>>
> >>> This looks as a sensible cleanup but I don't see the first patch in t=
he
> >>> series (and neither it is archived at lore.kernel.org) so I cannot re=
ally
> >>> verify whether your conversion is correct...
> >> This was my original comment. If you want to see the cover letter
> >> look for this mail ID tencent_06797E65CFC655DCD4F0414B9380E95ECC08@qq.=
com
> >>
> >> Not sure why it separates the cover letter from the rest of the patche=
s.
> >=20
> > No, that is actually a different email :) Based on lore the message ID
> > should be:
> > 26c450f6467b4cbaf94cdb10f047abc6ab0c2a5d.1710863674.git.wenyang.linux@f=
oxmail.com
> >=20
> > but the email is not in the archive...
> >=20
> > 								Honza
>=20
> Sorry, my email box changed the message ID when sending, but it can be=20
> found in lcore:
>=20
>=20
> or
> https://lore.kernel.org/all/tencent_0D6ABA209A4980742DE6003FBFE7FE2A3207@=
qq.com/
>=20
>=20
> If it causes any inconvenience to you, I can resend it. After some=20
> experiments, I have finally found a way to send them in a thread.
Before resending it, please read my comments to your original patchset.

--=20

Joel Granados

--kwjstpfzr53dfx5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmX8YRIACgkQupfNUreW
QU/xfQv+MZ561xgb6+R6JgcECKyr5wWcBtLS9B7I110XN/4kgn06e3KDA6fq0s0y
Z7iWVW80AsEk8JLkoNDx7RKirnpW4TTA6qBR0PlFBZYr92L8d9Bhr2sUVt8MPYbF
5g6AYkeJ+xJjT01k53krNVXNVQd23RyocnLoUc74nJ8QMuy+YkhGLd7daYPWzguW
BEGHbNo8FqLI3TVQZ98LuXYg3LMKs/NXTLDFiNx4MmCfqU79yK86uCVtN5jiOvuC
UzCYtua/ihbnzB44vmWTnwnsfOc8TcmzeJ3mDKEnvQ1w4tUNBjSYdz1KwQatk/Pa
1E7KLyKx5+06+UKNey35KjMO4On4hy9O5zhFQ8wNVTs+WLWCzz6OFZu2qIoj81Ze
2GRvRBgBlewRG27JJLSdbWJNM2QWz0B5QVNr0JiKpFT+4s9PRw0pWpAr3t61I73Z
dbkIVYry6WmtDT1Kna5jNiHShh+a7jg/CpV0f+sTnEzJ6qEmGFS+NBf30z6yJujQ
9zAb7zth
=RfXT
-----END PGP SIGNATURE-----

--kwjstpfzr53dfx5y--

