Return-Path: <linux-kernel+bounces-10802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0778E81DBFD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 19:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61E9D1F21A65
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 18:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C5AD294;
	Sun, 24 Dec 2023 18:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="po65WuYV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D36D266
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 18:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231224184439euoutp011a772c025fd288a9bc2c49c17bbc1252~j2NHLFIMX2830328303euoutp01P;
	Sun, 24 Dec 2023 18:44:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231224184439euoutp011a772c025fd288a9bc2c49c17bbc1252~j2NHLFIMX2830328303euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703443479;
	bh=zvs4L5xA1gJXnSnFiXh0mNywjNNpsNFRAhl3ngQ3knM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=po65WuYVekF5REzHrDPU8m9gCPWH/R7HB2va8nbj5Y6feN9JbFMkIZs/6PMSgZRPx
	 QhSIjpkbr9+zTIAtjFjCYw1GhMINU2T7l/Rh4d9rZ5qnEqvYxsAJOb7d7hUXXVUvcN
	 1xKCbkcPfjC52v4ZsugCD7XntPVA6mo3S7JWKB5w=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231224184439eucas1p11bb12583bcbd327b042616edb21d0575~j2NG5o0vg2785527855eucas1p1c;
	Sun, 24 Dec 2023 18:44:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 81.1D.09814.71C78856; Sun, 24
	Dec 2023 18:44:39 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20231224184438eucas1p1daf091669f36e799df6542b90af6739e~j2NF4WRep1881118811eucas1p1O;
	Sun, 24 Dec 2023 18:44:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231224184438eusmtrp2e75fd47ac8c6f51ba6f53addc32667ce~j2NF35n1W1283112831eusmtrp2t;
	Sun, 24 Dec 2023 18:44:38 +0000 (GMT)
X-AuditID: cbfec7f4-727ff70000002656-17-65887c1783cc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 28.53.09274.61C78856; Sun, 24
	Dec 2023 18:44:38 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231224184438eusmtip19371f5936cd28c8e1a109c805822900b~j2NFq1r0R3266432664eusmtip15;
	Sun, 24 Dec 2023 18:44:38 +0000 (GMT)
Received: from localhost (106.210.248.246) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Sun, 24 Dec 2023 18:44:37 +0000
Date: Sun, 24 Dec 2023 19:44:02 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scripts: check-sysctl-docs: adapt to new API
Message-ID: <20231224184402.of6cc2tczajmnbri@localhost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="jvjkiodbs7ntsrn5"
Content-Disposition: inline
In-Reply-To: <20231220-sysctl-check-v1-1-420ced4a69d7@weissschuh.net>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djPc7riNR2pBpcWCVpc3jWHzeL3j2dM
	FjcmPGV0YPbYtKqTzePzJjmP/u5j7AHMUVw2Kak5mWWpRfp2CVwZ3+/MYC3YrVXx6usO1gbG
	t4pdjJwcEgImEi2X9jB2MXJxCAmsYJR4v/EuO4TzBchZ/gvK+cwo8eJ1D1AZO1jL7TiI8HJG
	iUu/ZjPC1WyffJsJwtnKKHHlzEQ2kB0sAqoSf6d+ZQSx2QR0JM6/ucMMYosI2Eis/PYZaAMH
	B7OAh8TeCaEgYWEBR4kzz7ayg9i8AuYSC6dvgLIFJU7OfMICYjMLVEhM/bmHFaJVWmL5Pw6Q
	MKeAq8T1fZuZIT5Tlrj56x2UXStxasstsNMkBF5wSPR/fsgCkXCRWL7rIpQtLPHq+BZ2CFtG
	4v/O+VANkxkl9v/7wA7hrGaUWNb4lQmiylqi5coTqA5HiaV7lrOAXCQhwCdx460gxKF8EpO2
	TWeGCPNKdLQJQVSrSay+94ZlAqPyLCSvzULy2iyE1yDCehI3pk5hwxDWlli28DUzhG0rsW7d
	e5YFjOyrGMVTS4tz01OLjfJSy/WKE3OLS/PS9ZLzczcxApPR6X/Hv+xgXP7qo94hRiYOxkOM
	KkDNjzasvsAoxZKXn5eqJMIrq9iRKsSbklhZlVqUH19UmpNafIhRmoNFSZxXNUU+VUggPbEk
	NTs1tSC1CCbLxMEp1cBUs2R/xbGL35M33Kq+Yfx8F8ezQJ+AGRclRSbMOXr31mNeR9U+ff5d
	jxuqeo9k/5/idqON6cKqdwt2KMyUL7n6Z/aD9WvsjfpeywnzP1pRd+wV+7Kf5guCY5VaTmxR
	Wat+91F77JW2qf6Lz+QohRxxb7rvK5d/yTU/nitn/6tla3bmSGyN32U+jaX+9c6lS632CjxI
	m9+7r0auJlOwSVC3eX/xk9fC9nNcExcLn9w480v205B5e7Xc0z/OSn0suWViSvdMIRf35Ovb
	laSeH/2i+TQsZ85zFcMN0YIzjH457Tzyt9bg4y1rL/7MrRdt35VM+NtgfiHWJf7YDw911mmc
	J0rVKmoms6ZlqfBcfVCSpsRSnJFoqMVcVJwIAIYpGT/BAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xu7piNR2pBit/sltc3jWHzeL3j2dM
	FjcmPGV0YPbYtKqTzePzJjmP/u5j7AHMUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG
	5rFWRqZK+nY2Kak5mWWpRfp2CXoZN689YyrYqVWx88kN1gbG14pdjOwcEgImErfjuhi5OIQE
	ljJKHN92m62LkRMoLCOx8ctVVghbWOLPtS42iKKPjBI3z81lh3C2Mko8WXebBaSKRUBV4u/U
	r4wgNpuAjsT5N3eYQWwRARuJld8+AzVwcDALeEjsnRAKEhYWcJQ482wrO4jNK2AusXD6BqiZ
	MxglVt28CJUQlDg58wnYfGaBMolXS59AzZGWWP6PAyTMKeAqcX3fZmaIQ5Ulbv56B2XXSnz+
	+4xxAqPwLCSTZiGZNAthEkRYR2Ln1jtsGMLaEssWvmaGsG0l1q17z7KAkX0Vo0hqaXFuem6x
	kV5xYm5xaV66XnJ+7iZGYERuO/Zzyw7Gla8+6h1iZOJgPMSoAtT5aMPqC4xSLHn5ealKIryy
	ih2pQrwpiZVVqUX58UWlOanFhxhNgYE4kVlKNDkfmCrySuINzQxMDU3MLA1MLc2MlcR5PQs6
	EoUE0hNLUrNTUwtSi2D6mDg4pRqY6iMPvis+OO/hTUGHyrh/e89FvFvU89Zlk53bW4MNGVpr
	fvXfFprTLCui1ZDqpjBP/O3MHV2foqUyVj9fdPKaf9D6qd92a1jqH62WTZCwWb4idLHJQe69
	c0KnXTn+QCDwalWMo6CMC5uo3y73PCs5YUYh7kM51y8a/Zkz89/rlnfH2Mv2rHz4e5nZMssz
	YXF5bpVp7/ZK55+/cnJO78Q7FQGhjn3aGis+lE641RW5Uqx1bu2310vvXJbxemHlqhaQ+LZ2
	/wSzPWs2s/dOZp7ouqxoB4eYxr7GfRv/vvivbsu0bOIprvNM3xsnHomeasme2qrIH+W+KPN8
	8tLI7PmbOoXevvO2mCf05Nr7BBtZHyWW4oxEQy3mouJEAHFV87FdAwAA
X-CMS-MailID: 20231224184438eucas1p1daf091669f36e799df6542b90af6739e
X-Msg-Generator: CA
X-RootMTR: 20231220213032eucas1p2889cb35ee41ed155ce68e75b02892582
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231220213032eucas1p2889cb35ee41ed155ce68e75b02892582
References: <CGME20231220213032eucas1p2889cb35ee41ed155ce68e75b02892582@eucas1p2.samsung.com>
	<20231220-sysctl-check-v1-1-420ced4a69d7@weissschuh.net>

--jvjkiodbs7ntsrn5
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 10:30:26PM +0100, Thomas Wei=DFschuh wrote:
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
>  scripts/check-sysctl-docs | 42 ++++++++++++------------------------------
>  1 file changed, 12 insertions(+), 30 deletions(-)
>=20
> diff --git a/scripts/check-sysctl-docs b/scripts/check-sysctl-docs
> index 4f163e0bf6a4..bd18ab4b950b 100755
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
> @@ -20,14 +20,12 @@ BEGIN {
>  }
> =20
>  # The following globals are used:
> -# children: maps ctl_table names and procnames to child ctl_table names
>  # documented: maps documented entries (each key is an entry)
>  # entries: maps ctl_table names and procnames to counts (so
>  #          enumerating the subkeys for a given ctl_table lists its
>  #          procnames)
>  # files: maps procnames to source file names
>  # paths: maps ctl_path names to paths
> -# curpath: the name of the current ctl_path struct
>  # curtable: the name of the current ctl_table struct
>  # curentry: the name of the current proc entry (procname when parsing
>  #           a ctl_table, constructed path when parsing a ctl_path)
> @@ -94,44 +92,24 @@ FNR =3D=3D NR {
> =20
>  # Stage 2: process each file and find all sysctl tables
>  BEGINFILE {
> -    delete children
>      delete entries
>      delete paths
Why did you leave paths? As I read it you remove the use of paths and
now this is not needed any longer.

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
Would these regular expressions match lines that have more than one
spaces before const?

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
> @@ -140,10 +118,14 @@ curtable && /\.procname[\t ]*=3D[\t ]*".+"/ {
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
> base-commit: 1a44b0073b9235521280e19d963b6dfef7888f18
> change-id: 20231220-sysctl-check-8802651d945d
>=20
> Best regards,
> --=20
> Thomas Wei=DFschuh <linux@weissschuh.net>
>=20

--=20

Joel Granados

--jvjkiodbs7ntsrn5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmWIe+MACgkQupfNUreW
QU+nAgv8CxhzHsN++0uY7h36mOFVhZN/c1cDkKd4EnQ0qMdB0g8/POd7J8oyjG70
v8aVx/NUmaM5hOGHlyp3oyosGYhB5RfYDMvaJuMGr+ilU6ViXz8l7H6hkZXX6vaj
OkCwPS/uBHLLRh4TmarACmFngnL/qZE6YFIJY0Qw1BCMuYNtjgLfABVyOaDflVLk
fnZ/+6mou3bSfFXDKW4oWfOtS8LTg82wUfqCPweh0o9gVt73eCZ3iwHphfz5fhtF
nEpocfvBJN1kl04uDoc4oGFH6zJkB5yrSsIDOTmqdBL+UpcfE4/DRbMbMCXPriU1
wCB1kv7bqYNf85Pr7d/e1cvZcC0gll19pRo92DjUKwwRHL/bVNk154S2tzOnjhqG
DEk2eze69U+sXw4yrPCptzsloph4at2z8MmfVl22A0h1CpDOWVuswqHbJANbCAYj
rn1fulPptsaEALMD0tStcIrivhPZzpngMgrLzhZp8eetN7c0rcZQyApjbYC6FHGV
gXTMzI22
=eqMn
-----END PGP SIGNATURE-----

--jvjkiodbs7ntsrn5--

