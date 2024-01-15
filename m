Return-Path: <linux-kernel+bounces-30182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C11831B14
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E6B1C2601A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762D32575E;
	Thu, 18 Jan 2024 14:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="I1fka0Az"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA5224B4B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 14:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705586773; cv=none; b=X1Ajir9hWREALG3pw/RPMTBZEIfhF2kdkMdd0xOjesoEqUNDoZVKy9/h2oGuxn/DPx4Z6C5TbYjGAEJ71JfMbeJcVbMOmse2hQWfb9TRAk+28zgmKujjnImhDmfXOVSZE5EtmTilHUuEzIxwXvuxUogbbP9ccRNbGnyYW6wwOK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705586773; c=relaxed/simple;
	bh=AKyHK8oB1BiR8XsIEcJMZqaJuTrSYnW+ZO7vXZvyEpU=;
	h=Received:DKIM-Filter:DKIM-Signature:Received:Received:Received:
	 Received:X-AuditID:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Originating-IP:X-ClientProxiedBy:
	 X-Brightmail-Tracker:X-Brightmail-Tracker:X-CMS-MailID:
	 X-Msg-Generator:X-RootMTR:X-EPHeader:CMS-TYPE:X-CMS-RootMailID:
	 References; b=Nd0EWcl+JeV7VSx+7+GZ6GIB+RJWAbgvgffrBF+zLn70X66NMHG//xWB/pQotrVnf3b3Dz0rSGHlJ3QxTd5J6dhJBYekl3I1tHSXrVBevjvsBV0b22P1mZk/GIlQ+wMdpzpN6qhHkTdzci8DzeOv7adj8SyPXcDcy7wAwQuC8KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=I1fka0Az; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240118140602euoutp02c4b9217a712f22f8c17f7aaeb2c59b52~rdh-RNJHj0577605776euoutp02H;
	Thu, 18 Jan 2024 14:06:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240118140602euoutp02c4b9217a712f22f8c17f7aaeb2c59b52~rdh-RNJHj0577605776euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1705586762;
	bh=DDK2iFTetcCqvO6VugL53gp2zlYJEjnscZ6upVA4Aj8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=I1fka0Azd4oeIcljKo1QXEH85tfMRR87fK0pMfjeCkaTDlGKU0Wkr7TH1uscUbOXB
	 4FjUpEiR/gQEE7kRbPynmImyBdPC5V1otwe3jwpvbIVGUo0AM5n8bLWz8O+ZDjntC1
	 njx5L5t/OQvjkw9QdLFkL4c6yIVXmbGAMhXZQh3Y=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240118140602eucas1p2d072ca50e14198b4d94251de8081326f~rdh_-9IXX2986529865eucas1p2m;
	Thu, 18 Jan 2024 14:06:02 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id F0.06.09552.A4039A56; Thu, 18
	Jan 2024 14:06:02 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240118140602eucas1p1db646611a1aaffb26d07cf69ef620f85~rdh_i59ab1550115501eucas1p1x;
	Thu, 18 Jan 2024 14:06:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240118140602eusmtrp2f6b0d0c6dd837ec122558d2ff133e33e~rdh_iOqvy2229622296eusmtrp2j;
	Thu, 18 Jan 2024 14:06:02 +0000 (GMT)
X-AuditID: cbfec7f5-83dff70000002550-6e-65a9304a8ecd
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 58.FA.09146.A4039A56; Thu, 18
	Jan 2024 14:06:02 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240118140601eusmtip17ee701c97bd81d513b8972a23b754fda~rdh_YBU8v0330603306eusmtip1p;
	Thu, 18 Jan 2024 14:06:01 +0000 (GMT)
Received: from localhost (106.210.248.244) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 18 Jan 2024 14:06:00 +0000
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djP87peBitTDe6sVLS4vGsOm8XvH8+Y
	LG5MeMrowOyxaVUnm8fnTXIe/d3H2AOYo7hsUlJzMstSi/TtErgybs/exFbQrlOxZfc8tgbG
	5cpdjJwcEgImEh2/W5i6GLk4hARWMErcvnCSFcL5wiixbUkfG4TzmVHi/ZJd7DAt/75NZoFI
	LGeUeNjwA6Hq0ez7TCBVQgJbGSWubvMGsVkEVCVmN8xgA7HZBHQkzr+5wwxiiwjYSKz89hlo
	KgcHs4CHxN4JoSBhYQEXidX3JzCC2LwC5hJn/x1igrAFJU7OfMICYjMLVEjM6DvBCtEqLbH8
	HwdImFPAVeJKxxWwsISAssS/ncwQJ9dKnNpyC+xLCYE3HBJrtv6F+sVFYuXC11BFwhKvjm+B
	istI/N85H6phMqPE/n8f2CGc1YwSyxq/MkFUWUu0XHkC1eEo8eluD9RmPokbbwUh7uSTmLRt
	OjNEmFeio00IolpNYvW9NywTGJVnIflsFpLPZiF8BhHWk7gxdQobhrC2xDKgByBsW4l1696z
	LGBkX8UonlpanJueWmycl1quV5yYW1yal66XnJ+7iRGYjE7/O/51B+OKVx/1DjEycTAeYlQB
	an60YfUFRimWvPy8VCURXn+DZalCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeVVT5FOFBNITS1Kz
	U1MLUotgskwcnFINTDO9JZy/pZtGrmgo2H6g58PbhTYNa5PTX8z8FLFr2vLeQCv/h2c9RH+2
	VRxImDNbkCt1zT/zyPqE53LKTRpWjmf28/gc36Yq/9n5QXtuFL+OvM7ztc0B0/Ikcx8t3fA6
	mdWr5f3pYvlOk9RZIYzPy19xMb/6YCQnLzPB3fTKGs+/YTfkrrPw+vznNNx79o3TvfcO5+WW
	PHi/ruvymtt9ld/s8mUM/eKz1skdPnPQJCjpw8Elp297HTMXfnZF8rWkkWfQhcnLfE59bQ+P
	+TZF9abvoedhzcLPpP7wdOxccVricMt23unJvx+/fN+x4rCWjYb4ijuRQp5mcT9K+Gay6/kr
	nQli9byz0K5O+HB0gxJLcUaioRZzUXEiAOo86mvBAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xu7peBitTDWbcYba4vGsOm8XvH8+Y
	LG5MeMrowOyxaVUnm8fnTXIe/d3H2AOYo/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyN
	zWOtjEyV9O1sUlJzMstSi/TtEvQy3v9/zVTQqlNxbcYf1gbGpcpdjJwcEgImEv++TWbpYuTi
	EBJYyihx5vllRoiEjMTGL1dZIWxhiT/Xutggij4ySiw8foUJwtnKKNE2sResg0VAVWJ2www2
	EJtNQEfi/Js7zCC2iICNxMpvn9m7GDk4mAU8JPZOCAUJCwu4SKy+PwGslVfAXOLsv0NQM2cw
	Six+2sEEkRCUODnzCQuIzSxQJrH2UBcLxBxpieX/OEDCnAKuElc6rrCChCUElCX+7WSGuLlW
	4vPfZ4wTGIVnIRk0C8mgWQiDIMI6Eju33mHDENaWWLbwNTOEbSuxbt17lgWM7KsYRVJLi3PT
	c4sN9YoTc4tL89L1kvNzNzECY3LbsZ+bdzDOe/VR7xAjEwfjIUYVoM5HG1ZfYJRiycvPS1US
	4fU3WJYqxJuSWFmVWpQfX1Sak1p8iNEUGIYTmaVEk/OBySKvJN7QzMDU0MTM0sDU0sxYSZzX
	s6AjUUggPbEkNTs1tSC1CKaPiYNTqoHJeMvmykPumseXpjSdvDpJ4zdnanLcloN7zs2a+vOc
	vrOKbPHep1u8fhnsX7A4XX3m8XdnJ55ccXz74SQb3jkTEtaLJj0/MUOOJ8/25CbtjvRUftdD
	gr5fX7vvO+jCGD83LuV8hsiHxmMpmmpZGzZ83s0YfoNr8oFLfTLLL2SWxGe8OsZ7VmVH/0lv
	08fZWqpJDUG/r4fsk2tapOBlFm/84ty3CX8ZFpasCxa89o75UprFhRPdP7ZfNu9yOybbbCKx
	x3fyhuKjKyc1nbArMH3fGJdz1sylRU7ggnH7H3aBm0eZuDwy9rjmr5KObK6+9rBMN49h5Qr5
	CW9OzRF7uET/yOxLW2cmuF3d6XFY67CrlxJLcUaioRZzUXEiAJxuqkBeAwAA
X-CMS-MailID: 20240118140602eucas1p1db646611a1aaffb26d07cf69ef620f85
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

