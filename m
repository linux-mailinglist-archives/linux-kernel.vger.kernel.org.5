Return-Path: <linux-kernel+bounces-26196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBD082DC9D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4850B283C08
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1BC17BB3;
	Mon, 15 Jan 2024 15:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ACr6gIzx"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB8A17BAF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240115154913euoutp0152dfeb70d3dc37f52d9c7cf156681bbd~qkANipyGR0612206122euoutp01W;
	Mon, 15 Jan 2024 15:49:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240115154913euoutp0152dfeb70d3dc37f52d9c7cf156681bbd~qkANipyGR0612206122euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1705333753;
	bh=DDK2iFTetcCqvO6VugL53gp2zlYJEjnscZ6upVA4Aj8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ACr6gIzxbXH3+A8pQF4Fmwhg01e8pC1YYZ3fcKf3xXlImI3Wq4mZf+hDDB5E3DuT7
	 cqHcWOnfKrExpPHF1vAYgprTAsZE8talg7v95eAaQBDSsGNXT0s/F09y78TW457D4c
	 KyYI7TvDPjhWSR4Peh9jVgmdK54HB8pT+SnhvGYY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240115154912eucas1p177cc773f5a9f751eb8c6452c24b60f8a~qkANZi9ph1742917429eucas1p1d;
	Mon, 15 Jan 2024 15:49:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 3E.47.09552.8F355A56; Mon, 15
	Jan 2024 15:49:12 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240115154912eucas1p2e5ebae8bbeed7bdbaec30f80dbf52df1~qkANAzrCE1315413154eucas1p2W;
	Mon, 15 Jan 2024 15:49:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240115154912eusmtrp2e1ba161be4b1e79231fae633f0e755da~qkANARVSS1355813558eusmtrp2k;
	Mon, 15 Jan 2024 15:49:12 +0000 (GMT)
X-AuditID: cbfec7f5-83dff70000002550-b0-65a553f8fdaa
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 1D.6D.09146.8F355A56; Mon, 15
	Jan 2024 15:49:12 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240115154912eusmtip2dc8d3fbf9d5bdc3f1915671dbf9a58ae~qkAM2RsRB0679506795eusmtip25;
	Mon, 15 Jan 2024 15:49:12 +0000 (GMT)
Received: from localhost (106.210.248.50) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 15 Jan 2024 15:49:11 +0000
Date: Mon, 15 Jan 2024 16:49:07 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] scripts: check-sysctl-docs: adapt to new API
Message-ID: <20240115154907.ubr4admknmousjbz@localhost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="j7wblihvlqrnvzk4"
Content-Disposition: inline
In-Reply-To: <20231226-sysctl-check-v2-1-2d4f50b30d34@weissschuh.net>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djP87o/gpemGky7YWZxedccNovfP54x
	WdyY8JTRgdlj06pONo/Pm+Q8+ruPsQcwR3HZpKTmZJalFunbJXBl3J69ia2gXadiy+55bA2M
	y5W7GDk5JARMJBbeWsvcxcjFISSwglFi6qsLjBDOF0aJm+ufQDmfGSX+PrjDBNPSefM0C0Ri
	OaPEohPn2eCqug+0MEE4WxglNnbuYwFpYRFQlZjdMIMNxGYT0JE4/+YOM4gtImAjsfLbZ/Yu
	Rg4OZgEPib0TQkHCwgIuEqvvT2AEsXkFzCXO/jvEBGELSpyc+QRsJLNAhcSMvhOsEK3SEsv/
	cYCEOQVcJa50XAELSwgoSXxf7QVxc63EqS23wC6TEHjDIbF/9lw2iISLxL0vd6EeE5Z4dXwL
	O4QtI/F/53yohsmMEvv/fWCHcFYzSixr/ArVYS3RcuUJVIejxKe7PVCb+SRuvBWEuJNPYtK2
	6cwQYV6JjjYhiGo1idX33rBMYFSeheSzWUg+m4XwGURYT+LG1ClsGMLaEssWvmaGsG0l1q17
	z7KAkX0Vo3hqaXFuemqxcV5quV5xYm5xaV66XnJ+7iZGYDo6/e/41x2MK1591DvEyMTBeIhR
	Baj50YbVFxilWPLy81KVRHir7yxJFeJNSaysSi3Kjy8qzUktPsQozcGiJM6rmiKfKiSQnliS
	mp2aWpBaBJNl4uCUamCqrVVbnBO21Nxe3mcC53TftUssNB7GamQUxKawLEjQnhBd07djU29Q
	gj9nzewH5y6mOLOa7eJOyYo3M/1sfr1s4h6bBtcYh22MzIvPTQid1J2wo7DmJZOL9pXgOSyT
	uibM8Z7469D+qxb+sZpWh+8ul1U9rPWdrWRtSunbnQ/O/C84NMv6wf4l5vz9887pbXMV2fpT
	S0c/aOpNzUds56JLUt90fIqd/HLBZqNp+2cfMhMXK75u/9y4MkpYbtP89ImWC5P3tMwq3B4X
	IyuzK0m1uthCeJn7xepZSxLll8ZV/2DsdTuaxGQmHSuxYsKxkyeD9u43YHg7PbDe2/l1k9Sd
	u34uCurscR0cf3pFpymxFGckGmoxFxUnAgCvelRrwgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xe7o/gpemGjy5KWNxedccNovfP54x
	WdyY8JTRgdlj06pONo/Pm+Q8+ruPsQcwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hka
	m8daGZkq6dvZpKTmZJalFunbJehlvP//mqmgVafi2ow/rA2MS5W7GDk5JARMJDpvnmbpYuTi
	EBJYyijR9LiNHSIhI7Hxy1VWCFtY4s+1LjaIoo+MEr83bWGFcLYwSjzduI8RpIpFQFVidsMM
	NhCbTUBH4vybO8wgtoiAjcTKb5+BpnJwMAt4SOydEAoSFhZwkVh9fwJYK6+AucTZf4eYIGbO
	YJRY/LSDCSIhKHFy5hMWEJtZoExi7aEuFog50hLL/3GAhDkFXCWudFxhBQlLCChJfF/tBXFz
	rcTnv88YJzAKz0IyaBaSQbMQBkGEdSR2br3DhiGsLbFs4WtmCNtWYt269ywLGNlXMYqklhbn
	pucWG+oVJ+YWl+al6yXn525iBMbktmM/N+9gnPfqo94hRiYOxkOMKkCdjzasvsAoxZKXn5eq
	JMJbfWdJqhBvSmJlVWpRfnxRaU5q8SFGU2AYTmSWEk3OByaLvJJ4QzMDU0MTM0sDU0szYyVx
	Xs+CjkQhgfTEktTs1NSC1CKYPiYOTqkGJt8u0fDuWUtFteYWGE41PPF6qZLgQguVhSLbFIQa
	Trrkbdj/+W5bxPvzel4TG3mznbZcll4wTTIpQszw8o5ppVns3+O+WJfKlQTsPjjjqsNWBd0H
	M7bbnznrfGLR/4pTqnyegn/UFk+ZMdHmo5vs+S3WGxc+N16tWcJ4kkk2YZvu+UaDA+4W2T6h
	V26/SO5YPHtGS3brsjhfY13eH6mVF019l6y4F3G1M7pK8Ennlwu5W1Z77XvRrHejP9qwc9qE
	1faT279eeXQkPs7JcH2kKHtZuO6fVbtnOea7eVQunu115UPCm21+4Vum8540imz/9umpbHdM
	/4usnXpBMbeEV/ofXzpNn+dDfVjEiaqs60osxRmJhlrMRcWJAL9MmapeAwAA
X-CMS-MailID: 20240115154912eucas1p2e5ebae8bbeed7bdbaec30f80dbf52df1
X-Msg-Generator: CA
X-RootMTR: 20231226113448eucas1p2790755bc45518304822dc9b24c93c2a3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231226113448eucas1p2790755bc45518304822dc9b24c93c2a3
References: <CGME20231226113448eucas1p2790755bc45518304822dc9b24c93c2a3@eucas1p2.samsung.com>
	<20231226-sysctl-check-v2-1-2d4f50b30d34@weissschuh.net>

--j7wblihvlqrnvzk4
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Thomas

I lost track of the thread here. Did you get my latest answer to your V1?
https://lore.kernel.org/all/20231231143455.tvwb464awfzv5uti@localhost/

Best
On Tue, Dec 26, 2023 at 12:34:38PM +0100, Thomas Wei=DFschuh wrote:
> The script expects the old sysctl_register_paths() API which was removed
> some time ago. Adapt it to work with the new
> sysctl_register()/sysctl_register_sz()/sysctl_register_init() APIs.
>=20
> In its reference invocation the script won't be able to parse the tables
> from ipc/ipc_sysctl.c as they are using dynamically built tables which
> are to complex to parse.
>=20
> Note that the script is already prepared for a potential constification
> of the ctl_table structs.
>=20
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---
> Changes in v2:
> - Remove unused global variable "paths"
> - Remove docs for deleted variables "children" and "paths"
> - Link to v1: https://lore.kernel.org/r/20231220-sysctl-check-v1-1-420ced=
4a69d7@weissschuh.net
> ---
>  scripts/check-sysctl-docs | 45 ++++++++++++-----------------------------=
----
>  1 file changed, 12 insertions(+), 33 deletions(-)
>=20
> diff --git a/scripts/check-sysctl-docs b/scripts/check-sysctl-docs
> index 4f163e0bf6a4..739afd766708 100755
> --- a/scripts/check-sysctl-docs
> +++ b/scripts/check-sysctl-docs
> @@ -8,7 +8,7 @@
>  # Example invocation:
>  #	scripts/check-sysctl-docs -vtable=3D"kernel" \
>  #		Documentation/admin-guide/sysctl/kernel.rst \
> -#		$(git grep -l register_sysctl_)
> +#		$(git grep -l register_sysctl)
>  #
>  # Specify -vdebug=3D1 to see debugging information
> =20
> @@ -20,14 +20,10 @@ BEGIN {
>  }
> =20
>  # The following globals are used:
> -# children: maps ctl_table names and procnames to child ctl_table names
>  # documented: maps documented entries (each key is an entry)
>  # entries: maps ctl_table names and procnames to counts (so
>  #          enumerating the subkeys for a given ctl_table lists its
>  #          procnames)
> -# files: maps procnames to source file names
> -# paths: maps ctl_path names to paths
> -# curpath: the name of the current ctl_path struct
>  # curtable: the name of the current ctl_table struct
>  # curentry: the name of the current proc entry (procname when parsing
>  #           a ctl_table, constructed path when parsing a ctl_path)
> @@ -94,44 +90,23 @@ FNR =3D=3D NR {
> =20
>  # Stage 2: process each file and find all sysctl tables
>  BEGINFILE {
> -    delete children
>      delete entries
> -    delete paths
> -    curpath =3D ""
>      curtable =3D ""
>      curentry =3D ""
>      if (debug) print "Processing file " FILENAME
>  }
> =20
> -/^static struct ctl_path/ {
> -    match($0, /static struct ctl_path ([^][]+)/, tables)
> -    curpath =3D tables[1]
> -    if (debug) print "Processing path " curpath
> -}
> -
> -/^static struct ctl_table/ {
> -    match($0, /static struct ctl_table ([^][]+)/, tables)
> -    curtable =3D tables[1]
> +/^static( const)? struct ctl_table/ {
> +    match($0, /static( const)? struct ctl_table ([^][]+)/, tables)
> +    curtable =3D tables[2]
>      if (debug) print "Processing table " curtable
>  }
> =20
>  /^};$/ {
> -    curpath =3D ""
>      curtable =3D ""
>      curentry =3D ""
>  }
> =20
> -curpath && /\.procname[\t ]*=3D[\t ]*".+"/ {
> -    match($0, /.procname[\t ]*=3D[\t ]*"([^"]+)"/, names)
> -    if (curentry) {
> -	curentry =3D curentry "/" names[1]
> -    } else {
> -	curentry =3D names[1]
> -    }
> -    if (debug) print "Setting path " curpath " to " curentry
> -    paths[curpath] =3D curentry
> -}
> -
>  curtable && /\.procname[\t ]*=3D[\t ]*".+"/ {
>      match($0, /.procname[\t ]*=3D[\t ]*"([^"]+)"/, names)
>      curentry =3D names[1]
> @@ -140,10 +115,14 @@ curtable && /\.procname[\t ]*=3D[\t ]*".+"/ {
>      file[curentry] =3D FILENAME
>  }
> =20
> -/\.child[\t ]*=3D/ {
> -    child =3D trimpunct($NF)
> -    if (debug) print "Linking child " child " to table " curtable " entr=
y " curentry
> -    children[curtable][curentry] =3D child
> +/register_sysctl.*/ {
> +    match($0, /register_sysctl(|_init|_sz)\("([^"]+)" *, *([^,)]+)/, tab=
les)
> +    if (debug) print "Registering table " tables[3] " at " tables[2]
> +    if (tables[2] =3D=3D table) {
> +        for (entry in entries[tables[3]]) {
> +            printentry(entry)
> +        }
> +    }
>  }
> =20
>  END {
>=20
> ---
> base-commit: de2ee5e9405e12600c81e39837362800cee433a2
> change-id: 20231220-sysctl-check-8802651d945d
>=20
> Best regards,
> --=20
> Thomas Wei=DFschuh <linux@weissschuh.net>
>=20

--=20

Joel Granados

--j7wblihvlqrnvzk4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmWlU/IACgkQupfNUreW
QU+z9wv/SfmB+xmpyKa9R2Gwimo/vOJ/aUGmeafjnaCVGIugl6ZoW70A4pv0OO1z
1SueAfBzIiXG+8MSduB9aHF2xa83fxLHVw3fuEeMivJMowW26vC9Jsd07eLEYIPJ
Fr3ZD1oXcdDdaI0V3eShij4+/CwkAl1zf9VlrKBlsJNYmqn+egdV054r3XZqoh3s
cux5o/NZB6rDCmATTLoqv45WYZaydtytqJErTmPWHo1RDhp+dd4D0I6NNskt2uEw
TlIZpRdRj7IZ+/8EjmiM7P6PMs2faI/86Zeb2vYYdQ5GDomVRh+Ff3ZF9wxCavCq
g59c8qpcfAX59NZK6iUE4LI1B/eweDoPDXMKhvniMfm1Jv+KwyPL8i/BuWHysgl+
NaNbAlKKQE6zbxFci9YrAG2qSoivIwAgGM94Xq9cZmS7zcz/Y+yZuk7zz096XoTD
200WIoL0/JzVlNpTpgZUoFCWxR7gGEJ1fsh7y8PKrv4GMKsXoizaetHCeIrXi2s8
rGesrIWO
=ikP5
-----END PGP SIGNATURE-----

--j7wblihvlqrnvzk4--

