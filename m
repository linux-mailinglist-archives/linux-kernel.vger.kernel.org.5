Return-Path: <linux-kernel+bounces-13742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AF8820BD9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 16:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4C061C209BD
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 15:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615638F57;
	Sun, 31 Dec 2023 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lg88fDrq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4248F49
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 15:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231231153341euoutp02e3f8a54db01f98886709b13694a6937f~l9HXxEhtx0636106361euoutp02O;
	Sun, 31 Dec 2023 15:33:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231231153341euoutp02e3f8a54db01f98886709b13694a6937f~l9HXxEhtx0636106361euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1704036821;
	bh=zWDLoByyB9Gs8PwBTCC+QNCWZ7LoPsLOrfqfxKDhMiY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=lg88fDrq5IbCgaGZ/2/rI26T/5XVLb8tA0LUpXdiJB34GqikCFcrSI5GpTrb9lGri
	 Gvd8UP14krGQBkBP04ZHyzR2au5IJDqaERMd/594EiEOY7mG0wa2pp3tNck4WszQ7K
	 EwLUbCZ5I1mpN3ZgYY59+vgmusvAon4Jq9iKx6RM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231231153341eucas1p29e9cb4e69570f0cccf8bd3f26b5a026b~l9HXpw1M72718327183eucas1p2Y;
	Sun, 31 Dec 2023 15:33:41 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id BB.37.09814.5D981956; Sun, 31
	Dec 2023 15:33:41 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20231231153340eucas1p2acbbe93229fe31dd93f8d14be2f3efba~l9HXKJ7Z11877918779eucas1p2w;
	Sun, 31 Dec 2023 15:33:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231231153340eusmtrp2b607afe5baf4f228f6e7abc76018d091~l9HXJr9xE2909829098eusmtrp2d;
	Sun, 31 Dec 2023 15:33:40 +0000 (GMT)
X-AuditID: cbfec7f4-711ff70000002656-b4-659189d595c2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 81.39.09274.4D981956; Sun, 31
	Dec 2023 15:33:40 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231231153340eusmtip12a0a2fd052528f3fd18cf7a76220f4e9~l9HW6Geoc2421224212eusmtip1d;
	Sun, 31 Dec 2023 15:33:40 +0000 (GMT)
Received: from localhost (106.210.248.231) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Sun, 31 Dec 2023 15:33:39 +0000
Date: Sun, 31 Dec 2023 15:34:55 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
CC: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Luis
	Chamberlain <mcgrof@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scripts: check-sysctl-docs: adapt to new API
Message-ID: <20231231143455.tvwb464awfzv5uti@localhost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="few6xo3quqjzprh5"
Content-Disposition: inline
In-Reply-To: <8e54a5e4-731f-4b37-97f8-2c65a026fd6f@t-8ch.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJKsWRmVeSWpSXmKPExsWy7djPc7pXOyemGmz+wGVxedccNovfP54x
	WdyY8JTR4tDb6WwOLB6bVnWyecxecoPF4/MmOY/+7mPsASxRXDYpqTmZZalF+nYJXBmz3/5l
	KphvUfFo0VzGBsaDel2MnBwSAiYSEy7cYO1i5OIQEljBKLFs4QUmkISQwBdGia4XNhCJz4wS
	669tYIPpePTiCjtE0XJGiSO9IXBFLQcPskE4WxklFt2+wgJSxSKgKjH14VWwbjYBHYnzb+4w
	g9giAuYSdw7OZgZpYBZoYZToXbIArEhYwFHizLOtYCt4gYqeft3KDGELSpyc+QRsKLNAhcST
	l+uBbuUAsqUllv/jAAlzCthILLjYzgISlhBQlvj0PAHi6FqJU1tuMYGskhBo5pRYv+EaO0TC
	ReLHvAtQnwlLvDq+BSouI/F/53yohsmMEvv/fWCHcFYDA6nxKxNElbVEy5UnUB2OEkv3LIfa
	zCdx460gxJ18EpO2TWeGCPNKdLQJQVSrSay+94ZlAqPyLCSfzULy2SyEzyDCehI3pk5hwxDW
	BsbZa2YI21Zi3br3LAsY2VcxiqeWFuempxYb5aWW6xUn5haX5qXrJefnbmIEpqjT/45/2cG4
	/NVHvUOMTByMhxhVgJofbVh9gVGKJS8/L1VJhPfXzv5UId6UxMqq1KL8+KLSnNTiQ4zSHCxK
	4ryqKfKpQgLpiSWp2ampBalFMFkmDk6pBqaF893lXnguaLnVxOnwesOtz46vwjhfW5hxpove
	+bIxYZXOouPbCrk9ioRuWH3bIlO84+3a0/F3ZnGtZGBo7vh/61xgT02c4yqHeVob3oV8j/6Z
	6HLthMyTw4x3s+csyle1v7/gkPEu/YRkyQYLlvxFDc1WzZPcV8lk3tLc98HZlHvNvhOFf512
	yrn58KgrOVbPL1NfWaA5peLWS9WGG38XnNvldk6VeZ5N0T2bB+r92y/Ocvq5uiNL+7XtTN2T
	f1Ia/h/hKviyw4it1n17e+GPrbPtu5LSL07kUVf7ldk89d1C/obg2bx2pi9E3yukLXCKai5T
	X8a7aOa74srTn25c/a3uee72WgVmz9n/jn5TYinOSDTUYi4qTgQAGmUH/swDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xu7pXOiemGmydqmpxedccNovfP54x
	WdyY8JTR4tDb6WwOLB6bVnWyecxecoPF4/MmOY/+7mPsASxRejZF+aUlqQoZ+cUltkrRhhZG
	eoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehmzuq8yF8y1qGg+c4W9gXG/XhcjJ4eE
	gInEoxdX2LsYuTiEBJYySqybvZYZIiEjsfHLVVYIW1jiz7UuNoiij4wSa0/2gBUJCWxllOia
	qwpiswioSkx9eJUNxGYT0JE4/+YOWI2IgLnEnYOzmUGamQVaGCXa2zpYQBLCAo4SZ55tZQex
	eYGKnn7dygyx4QejxO2N06ESghInZz4Ba2AWKJP4f7iRqYuRA8iWllj+jwMkzClgI7HgYjsL
	SFhCQFni0/MEiKNrJT7/fcY4gVF4FpJBs5AMmoUwCCKsI7Fz6x02DGFtiWULXzND2LYS69a9
	Z1nAyL6KUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMFK3Hfu5ZQfjylcf9Q4xMnEwHmJUAep8
	tGH1BUYplrz8vFQlEd5fO/tThXhTEiurUovy44tKc1KLDzGaAkNxIrOUaHI+MIXklcQbmhmY
	GpqYWRqYWpoZK4nzehZ0JAoJpCeWpGanphakFsH0MXFwSjUwbTcw6Y2JvClsFLzw2b745e47
	VslKJeZvltTzU/jOWxXJVmsgzbKD76z+3EPT1UvWGWYE3DgfMXmtYcOhkzERZxt9H/1yD2sR
	PBAo/PmscP0izQ0TjphqJW05qnbxmmD85PvLj6axvAvYIpJyflkYw8V6T9HDcx+/3Xj43mtJ
	3+/bmXm4Lh/+6WvxSMYxaN6qrLUrz1TNseM/YuGUMH1fa6m6vfWhqo0Z808VH+Ze4b1gw/RJ
	b06l/hR++jxFcYZmyfars+/KfbKaWrxiccr+2/qmWzYkW8gGf1sUfcjPT4qxe1bCkYAjgf9n
	8z5ee6f3/v59t2fFzWWY5nTK5KK/0xLx0z0HG6asvrsvp+PEwklKLMUZiYZazEXFiQAJhqmy
	aQMAAA==
X-CMS-MailID: 20231231153340eucas1p2acbbe93229fe31dd93f8d14be2f3efba
X-Msg-Generator: CA
X-RootMTR: 20231220213032eucas1p2889cb35ee41ed155ce68e75b02892582
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231220213032eucas1p2889cb35ee41ed155ce68e75b02892582
References: <CGME20231220213032eucas1p2889cb35ee41ed155ce68e75b02892582@eucas1p2.samsung.com>
	<20231220-sysctl-check-v1-1-420ced4a69d7@weissschuh.net>
	<20231224184402.of6cc2tczajmnbri@localhost>
	<8e54a5e4-731f-4b37-97f8-2c65a026fd6f@t-8ch.de>

--few6xo3quqjzprh5
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 24, 2023 at 11:38:32PM +0100, Thomas Wei=DFschuh  wrote:
> Dec 24, 2023 19:44:42 Joel Granados <j.granados@samsung.com>:
>=20
> > On Wed, Dec 20, 2023 at 10:30:26PM +0100, Thomas Wei=DFschuh wrote:
> >> The script expects the old sysctl_register_paths() API which was remov=
ed
> >> some time ago. Adapt it to work with the new
> >> sysctl_register()/sysctl_register_sz()/sysctl_register_init() APIs.
> >>
> >> In its reference invocation the script won't be able to parse the tabl=
es
> >> from ipc/ipc_sysctl.c as they are using dynamically built tables which
> >> are to complex to parse.
> >>
> >> Note that the script is already prepared for a potential constification
> >> of the ctl_table structs.
> >>
> >> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> >> ---
> >> scripts/check-sysctl-docs | 42 ++++++++++++---------------------------=
---
> >> 1 file changed, 12 insertions(+), 30 deletions(-)
> >>
> >> diff --git a/scripts/check-sysctl-docs b/scripts/check-sysctl-docs
> >> index 4f163e0bf6a4..bd18ab4b950b 100755
> >> --- a/scripts/check-sysctl-docs
> >> +++ b/scripts/check-sysctl-docs
> >> @@ -8,7 +8,7 @@
> >> # Example invocation:
> >> #=A0 scripts/check-sysctl-docs -vtable=3D"kernel" \
> >> #=A0=A0=A0=A0=A0 Documentation/admin-guide/sysctl/kernel.rst \
> >> -#=A0=A0=A0=A0=A0 $(git grep -l register_sysctl_)
> >> +#=A0=A0=A0=A0=A0 $(git grep -l register_sysctl)
> >> #
> >> # Specify -vdebug=3D1 to see debugging information
> >>
> >> @@ -20,14 +20,12 @@ BEGIN {
> >> }
> >>
> >> # The following globals are used:
> >> -# children: maps ctl_table names and procnames to child ctl_table nam=
es
> >> # documented: maps documented entries (each key is an entry)
> >> # entries: maps ctl_table names and procnames to counts (so
> >> #=A0=A0=A0=A0=A0=A0=A0=A0=A0 enumerating the subkeys for a given ctl_t=
able lists its
> >> #=A0=A0=A0=A0=A0=A0=A0=A0=A0 procnames)
> >> # files: maps procnames to source file names
> >> # paths: maps ctl_path names to paths
> >> -# curpath: the name of the current ctl_path struct
> >> # curtable: the name of the current ctl_table struct
> >> # curentry: the name of the current proc entry (procname when parsing
> >> #=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 a ctl_table, constructed path when par=
sing a ctl_path)
> >> @@ -94,44 +92,24 @@ FNR =3D=3D NR {
> >>
> >> # Stage 2: process each file and find all sysctl tables
> >> BEGINFILE {
> >> -=A0=A0=A0 delete children
> >> =A0=A0=A0=A0 delete entries
> >> =A0=A0=A0=A0 delete paths
> > Why did you leave paths? As I read it you remove the use of paths and
> > now this is not needed any longer.
>=20
> Good catch, I'll drop it for V2.
>=20
> >
> >> -=A0=A0=A0 curpath =3D ""
> >> =A0=A0=A0=A0 curtable =3D ""
> >> =A0=A0=A0=A0 curentry =3D ""
> >> =A0=A0=A0=A0 if (debug) print "Processing file " FILENAME
> >> }
> >>
> >> -/^static struct ctl_path/ {
> >> -=A0=A0=A0 match($0, /static struct ctl_path ([^][]+)/, tables)
> >> -=A0=A0=A0 curpath =3D tables[1]
> >> -=A0=A0=A0 if (debug) print "Processing path " curpath
> >> -}
> >> -
> >> -/^static struct ctl_table/ {
> >> -=A0=A0=A0 match($0, /static struct ctl_table ([^][]+)/, tables)
> >> -=A0=A0=A0 curtable =3D tables[1]
> >> +/^static( const)? struct ctl_table/ {
> >> +=A0=A0=A0 match($0, /static( const)? struct ctl_table ([^][]+)/, tabl=
es)
> > Would these regular expressions match lines that have more than one
> > spaces before const?
>=20
> No. But it is consistent with the other regexes.
I would rather see a construct like "[\t ]+" for these cases so we avoid
missing lines that do not have the linux kernel code conventions.

I'm actually seeing some false positives here not related to the space
before "const" but with the way we match. When I run
`./scripts/check-sysctl-docs -vtable=3D"kernel" Documentation/admin-guide/s=
ysctl/kernel.rst $(git grep -l register_sysctl)`
after applying your patch, I get that "msgmni" has no implementation;
but I can see that it is implemented in `vim ipc/ipc_sysctl.c`.
The culprit is that this match does not consider the cases where we use
kmemdup to create the ctl_tables. This is not related to your patch, but
it is something you might consider addressing now that you are here.

Best
>=20
> >> +=A0=A0=A0 curtable =3D tables[2]
> >> =A0=A0=A0=A0 if (debug) print "Processing table " curtable
> >> }
> >>
> >> /^};$/ {
> >> -=A0=A0=A0 curpath =3D ""
> >> =A0=A0=A0=A0 curtable =3D ""
> >> =A0=A0=A0=A0 curentry =3D ""
> >> }
> >>
> >> -curpath && /\.procname[\t ]*=3D[\t ]*".+"/ {
> >> -=A0=A0=A0 match($0, /.procname[\t ]*=3D[\t ]*"([^"]+)"/, names)
> >> -=A0=A0=A0 if (curentry) {
> >> -=A0=A0 curentry =3D curentry "/" names[1]
> >> -=A0=A0=A0 } else {
> >> -=A0=A0 curentry =3D names[1]
> >> -=A0=A0=A0 }
> >> -=A0=A0=A0 if (debug) print "Setting path " curpath " to " curentry
> >> -=A0=A0=A0 paths[curpath] =3D curentry
> >> -}
> >> -
> >> curtable && /\.procname[\t ]*=3D[\t ]*".+"/ {
> >> =A0=A0=A0=A0 match($0, /.procname[\t ]*=3D[\t ]*"([^"]+)"/, names)
> >> =A0=A0=A0=A0 curentry =3D names[1]
> >> @@ -140,10 +118,14 @@ curtable && /\.procname[\t ]*=3D[\t ]*".+"/ {
> >> =A0=A0=A0=A0 file[curentry] =3D FILENAME
> >> }
> >>
> >> -/\.child[\t ]*=3D/ {
> >> -=A0=A0=A0 child =3D trimpunct($NF)
> >> -=A0=A0=A0 if (debug) print "Linking child " child " to table " curtab=
le " entry " curentry
> >> -=A0=A0=A0 children[curtable][curentry] =3D child
> >> +/register_sysctl.*/ {
> >> +=A0=A0=A0 match($0, /register_sysctl(|_init|_sz)\("([^"]+)" *, *([^,)=
]+)/, tables)
> >> +=A0=A0=A0 if (debug) print "Registering table " tables[3] " at " tabl=
es[2]
> >> +=A0=A0=A0 if (tables[2] =3D=3D table) {
> >> +=A0=A0=A0=A0=A0=A0=A0 for (entry in entries[tables[3]]) {
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printentry(entry)
> >> +=A0=A0=A0=A0=A0=A0=A0 }
> >> +=A0=A0=A0 }
> >> }
> >>
> >> END {
> >>
> >> ---
> >> base-commit: 1a44b0073b9235521280e19d963b6dfef7888f18
> >> change-id: 20231220-sysctl-check-8802651d945d
> >>
> >> Best regards,
> >> --
> >> Thomas Wei=DFschuh <linux@weissschuh.net>
> >>
> >
> > --
> >
> > Joel Granados
>=20

--=20

Joel Granados

--few6xo3quqjzprh5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmWRe/8ACgkQupfNUreW
QU/Megv/U4uErJsXXdamOXMGAbUJn/WI5oUjHGwnDGTobBSnAUBixHWK54EcpvVV
0WlBWEDd/KvBiHZ9yVDbm47MY/cHaEZZOzxz6zbd/c3Pyl0iRQK9qszv/5rafive
rjfHJ3Bz1v0rvkzZ86VJzEDhu13Xu5IOQHR6EO+v2iMK6SowL5OVWSZvq6in4zEE
tQMDGM8dV2bmsGfzjPOa8ZgLVW5Ajan7vzpNU/x3eiKUQMRjJ9TOCHNHOe7Dl9ls
utHx/+qAUrf+jU3SBqUiL7swejyPoT5hP3KDTktRDF1LH6oPZ0MGDMDXSW85v3zQ
7tWLHhfRUr7YBwcUv4oD/BZNFmtJlIPFImsVNZ1pSahk4vBug6RQ3GH6fzz0R8mg
UFXjzlqWi8H9ZFeN1Hg0IqMr9akPSVBUV0cQoTTUlUyjCTPrWZrjalibScogpeBp
Wka6mldDh+G+9XAE0s56VU9BNjJpvzoZ5dfXQ9gB3T/mD8y4FVtIyNAjL4pvbY30
66I11FsT
=dTdi
-----END PGP SIGNATURE-----

--few6xo3quqjzprh5--

