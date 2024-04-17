Return-Path: <linux-kernel+bounces-148378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB44E8A81BC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60DD62856B3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB2913C903;
	Wed, 17 Apr 2024 11:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="h2LdnW3o"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B99B13BC1B;
	Wed, 17 Apr 2024 11:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352273; cv=none; b=YBxn3KtND4qUlrizGjEs6dbkmYOGuuo18cB2muu+ntFfxUtLI8Dr/tzpUvzUNdsP6fCwzXGUBWH9eR+gQGvCiII6EYBbRMmyBH73pLXQoRsIbZORFWyUwGNY//a7YPzWEpQV3L2uZ1bMr+Fiks6YH33kSkaNKn6aC9/4xtO5R80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352273; c=relaxed/simple;
	bh=9Kuul0Us5T+DsH8WBIvY0W68/yCJswNN/bgL0D8F6/A=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=Q13joI9t0cBOITz7UP1nIBViFTYkYh8aH+UCDz+XoeJmTgGLWImtINdNGwu/9EwuH1OrSb7clP3TscfhL+A/n+DijO4bE+2tiqr94IwSOxTEKk5DpXqCiKXKOjyq76aXceWkE40K9qpELmDOzfPBULYzFyu9VX3jSWJyfUPWbJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=h2LdnW3o; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240417111106euoutp0241e6dab5e1af4767ae19a9df21bd0d06~HDM7xY4u01112511125euoutp021;
	Wed, 17 Apr 2024 11:11:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240417111106euoutp0241e6dab5e1af4767ae19a9df21bd0d06~HDM7xY4u01112511125euoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1713352266;
	bh=OY+E3AP4o+cMwdsRSlfCthUAuVMUvOkgraCoEy1EQcs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=h2LdnW3oQlEqsYLbJsjvMNJan0Xxl2M9JUFeftc+dZY2ha4AfwdS6IZKD9SJJjT1e
	 pmt5hhXhVz6EkU01r55GA1DVcoZC/ScZ78Q9i+3+g9IXtQcsLPfDbahW8RRhlqd/9A
	 To5nCwmOXhOmebgmRDbUM4DfB+uzcGOtkgdnE7/g=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240417111106eucas1p1eaa943e8073a58cb94d54d7f42a86df6~HDM7mGwPe2053320533eucas1p1B;
	Wed, 17 Apr 2024 11:11:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 1E.E2.09875.94EAF166; Wed, 17
	Apr 2024 12:11:05 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240417111105eucas1p19e8fbbbe60d347e12d0f6d767198e338~HDM7FrwvZ2052520525eucas1p1D;
	Wed, 17 Apr 2024 11:11:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240417111105eusmtrp2e7d69c7090f22d9fcf00febc06c7bddb~HDM7E_AQx0473304733eusmtrp2Z;
	Wed, 17 Apr 2024 11:11:05 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-fc-661fae49bb20
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 91.5F.08810.94EAF166; Wed, 17
	Apr 2024 12:11:05 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240417111105eusmtip2d9a2a1c25a17928cf241e21e4357f84d~HDM62RzBf1251912519eusmtip2k;
	Wed, 17 Apr 2024 11:11:05 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 17 Apr 2024 12:10:54 +0100
Date: Wed, 17 Apr 2024 11:44:33 +0200
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Eric W.
 Biederman" <ebiederm@xmission.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3] fs/proc/proc_sysctl.c: always initialize i_uid/i_gid
Message-ID: <20240417094433.ahfnijzz2svjhrvt@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="yvgo774vb4mne4gd"
Content-Disposition: inline
In-Reply-To: <20240402-sysctl-net-ownership-v3-1-366b1a76d48a@weissschuh.net>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7djP87qe6+TTDHZ1G1vMOd/CYnF40QtG
	i//bWtgtnh57xG5xYVsfq8WynrVsFpd3zWGz+P3jGZPFjQlPGS2OLRCz+Hb6DaPFgo2PGB14
	PFZc6GL12LLyJpPHzll32T0WbCr12LSqk83j/b6rbB6fN8l59HcfY/eYcqidJYAzissmJTUn
	syy1SN8ugSvj+abXzAUT5Spenv3O0sD4SbKLkYNDQsBE4vRbgS5GLg4hgRWMEmvWTGKBcL4w
	Ssy694QVwvnMKLHs8HG2LkZOsI7uZy+ZIRLLGSWOTJrLBlfV8/ECE4SzmVHi4czJrCAtLAKq
	En93nWEHsdkEdCTOv7nDDGKLCNhIrPz2GSzOLDCdWeLLRC0QW1jAR6Jr2zYmEJtXwEFizeIv
	LBC2oMTJmU9YQA5nFqiQOH/XGsKUllj+jwOkglPAV+LQlknsEIcqSnxdfI8Fwq6VOLXlFthp
	EgK3OCWeH1rJCJFwkTh2sBfqM2GJV8e3QDXLSPzfOR+qYTKjxP5/H9ghnNXAsGj8ygRRZS3R
	cuUJVIejRNeyBcyQUOWTuPFWEOIvPolJ26ZDhXklOtqEIKrVJFbfe8MygVF5FpLPZiF8Ngvh
	s1lgc/QkbkydwoYhrC2xbOFrZgjbVmLduvcsCxjZVzGKp5YW56anFhvlpZbrFSfmFpfmpesl
	5+duYgSmx9P/jn/Zwbj81Ue9Q4xMHIyHGFWAmh9tWH2BUYolLz8vVUmEt0VYNk2INyWxsiq1
	KD++qDQntfgQozQHi5I4r2qKfKqQQHpiSWp2ampBahFMlomDU6qBSXjTvJMzbi6bc1yltben
	bMYUgctHNl43bbvzVnBNwXnTbNE6h0luN5mi1jvsVq/fniDd+nLNJeXZDJW2W9K1NmtrH3t6
	UeNc3U492dmXp3Dnxrm1HJx49kag0vua+Q7H7HiPea87+jH4FmdE84WLD8xsPDZV88x3uWQg
	wBLmccv3zS+ptTuE/phMd7i3ufjlIn6O2ytmqBssOdDMIMJ59Me286nie/Vm/rU3eL7h5swP
	swqKeTMbN3y/Vx395urD9cFX/kuozn20ZIGjcMVS/bbb1UKHK7OrkroSz9bKTN7klhJov8hy
	4l9Tq1V/Dbkv75/b3X5bPFor1ap9v2KVo/OEBQZ5on6rLzzk0XzPWqjEUpyRaKjFXFScCAAt
	WmLjCgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsVy+t/xe7qe6+TTDHa+EbaYc76FxeLwoheM
	Fv+3tbBbPD32iN3iwrY+VotlPWvZLC7vmsNm8fvHMyaLGxOeMlocWyBm8e30G0aLBRsfMTrw
	eKy40MXqsWXlTSaPnbPusnss2FTqsWlVJ5vH+31X2Tw+b5Lz6O8+xu4x5VA7SwBnlJ5NUX5p
	SapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7Gm5fn2Ar65So2
	rTzM2MD4QbKLkZNDQsBEovvZS+YuRi4OIYGljBKtrR9YIBIyEhu/XGWFsIUl/lzrYoMo+sgo
	sWZlFxOEs5lRYsbvOWwgVSwCqhJ/d51hB7HZBHQkzr+5wwxiiwjYSKz89hksziwwnVniy0Qt
	EFtYwEeia9s2JhCbV8BBYs3iLywQQxcwSjzecJ4dIiEocXLmExaI5jKJ+WcuMnYxcgDZ0hLL
	/3GAhDkFfCUObZnEDnGposTXxfegPqiV+Pz3GeMERuFZSCbNQjJpFsIkiLCOxM6td9gwhLUl
	li18zQxh20qsW/eeZQEj+ypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzARLHt2M/NOxjnvfqo
	d4iRiYPxEKMKUOejDasvMEqx5OXnpSqJ8LYIy6YJ8aYkVlalFuXHF5XmpBYfYjQFhuJEZinR
	5HxgCssriTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCUamAq1QpqniJv
	rbNOsilgrW/FnRi7FysvRF7s5XThijM1tar/crN68Zr5n9obQ1P37HGYwr3MoOSsnl++ZdaR
	LPNvvaXcfZ9udl27dVn5qUmbONta8TVFz50+aNXPVxVT3uPyqMppTeIz00uTkg9fm7TVZWZ2
	3+FnVpzx0Umi4hO0ex4/N5r/wfqJ5TX/nhPfjnzeL7D7THDzP9GbL4MUdJ7N36S+8fbCjh7t
	21w7fgVx59xu+TR19tcpDCVTj1tUz/DzPRr5VZTd+HDYTfcixTN725aypm390yq/uW6+8cYt
	mgkXz8Rbnn4yLzOvuzRsZeJj2bftH68tdTn0aee/MLGqaYy3edqql83qiAiZIeqnxFKckWio
	xVxUnAgAg0XQpakDAAA=
X-CMS-MailID: 20240417111105eucas1p19e8fbbbe60d347e12d0f6d767198e338
X-Msg-Generator: CA
X-RootMTR: 20240402211043eucas1p173a936d187ae9bcf5be3729e69739e38
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240402211043eucas1p173a936d187ae9bcf5be3729e69739e38
References: <CGME20240402211043eucas1p173a936d187ae9bcf5be3729e69739e38@eucas1p1.samsung.com>
	<20240402-sysctl-net-ownership-v3-1-366b1a76d48a@weissschuh.net>

--yvgo774vb4mne4gd
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2024 at 11:10:34PM +0200, Thomas Wei=DFschuh wrote:
> Commit 5ec27ec735ba ("fs/proc/proc_sysctl.c: fix the default values of i_=
uid/i_gid on /proc/sys inodes.")
> added defaults for i_uid/i_gid when set_ownership() is not implemented.
> It missed to also adjust net_ctl_set_ownership() to use the same default
> values in case the computation of a better value fails.
>=20
> Instead always initialize i_uid/i_gid inside the sysfs core so
> set_ownership() can safely skip setting them.

Added this to sysctl-testing with minor changes in the commit message:

"""
sysctl: always initialize i_uid/i_gid

Always initialize i_uid/i_gid inside the sysfs core so set_ownership()
can safely skip setting them.

Commit 5ec27ec735ba ("fs/proc/proc_sysctl.c: fix the default values of
i_uid/i_gid on /proc/sys inodes.") added defaults for i_uid/i_gid when
set_ownership() was not implemented. It also missed adjusting
net_ctl_set_ownership() to use the same default values in case the
computation of a better value failed.

Fixes: 5ec27ec735ba ("fs/proc/proc_sysctl.c: fix the default values of i_ui=
d/i_gid on /proc/sys inodes.")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
Signed-off-by: Joel Granados <j.granados@samsung.com>
"""

Will let it simmer in testing for now.

Best

>=20
> Fixes: 5ec27ec735ba ("fs/proc/proc_sysctl.c: fix the default values of i_=
uid/i_gid on /proc/sys inodes.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---
> Changes in v3:
> - Rebase onto v6.9-rc1
> - Reword commit message and mention correct fixed commit
> - Link to v2: https://lore.kernel.org/r/20240322-sysctl-net-ownership-v2-=
1-a8b4a3306542@weissschuh.net
>=20
> Changes in v2:
> - Move the fallback logic to the sysctl core
> - Link to v1: https://lore.kernel.org/r/20240315-sysctl-net-ownership-v1-=
1-2b465555a292@weissschuh.net
> ---
>  fs/proc/proc_sysctl.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 37cde0efee57..9e34ab9c21e4 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -479,12 +479,10 @@ static struct inode *proc_sys_make_inode(struct sup=
er_block *sb,
>  			make_empty_dir_inode(inode);
>  	}
> =20
> +	inode->i_uid =3D GLOBAL_ROOT_UID;
> +	inode->i_gid =3D GLOBAL_ROOT_GID;
>  	if (root->set_ownership)
>  		root->set_ownership(head, table, &inode->i_uid, &inode->i_gid);
> -	else {
> -		inode->i_uid =3D GLOBAL_ROOT_UID;
> -		inode->i_gid =3D GLOBAL_ROOT_GID;
> -	}
> =20
>  	return inode;
>  }
>=20
> ---
> base-commit: 4cece764965020c22cff7665b18a012006359095
> change-id: 20240315-sysctl-net-ownership-bc4e17eaeea6
>=20
> Best regards,
> --=20
> Thomas Wei=DFschuh <linux@weissschuh.net>
>=20

--=20

Joel Granados

--yvgo774vb4mne4gd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmYfmgAACgkQupfNUreW
QU9U/Av9HKXJffWcIsZrwOT7yI37cd8cc4W1cjH3yBMzvQ9RWE6365mNygSJp0hs
eGO+pFN+UtxaJmkPKG8MPVuggE+fmrvU++Ld4s/W9H55mNRALAu7q/KPPSgNXcb6
wjfhKLcCteSVTMW/jU8LWWevH/35Y6Uf1eVWoNbzuQbxKsDTy52JzmRzSo2AC/8R
1L10XsolcGe90NlnRlM7BHYvh02ZPrgjjZBCzYcxy8XhjqNZZsrRRmWLTwnGb80+
gPjx6gRO3QYnQu0+jmfvu8C85dJKG9hV0oR9xSV0tqVITre0dpsjhgYKWz/mGIUN
m/oOSDIiJhYFzUcSxcv4B/sNEnxltWMrgNYv7+lpUTekxFRKxlO7vwHVp/2SVJFO
NoGTC//FKOPASWRRzKpCdlulMDEndfHgsYHksFxQs/90sBfGhCYGKDjZ1sCQ5Xoc
ytuR3cgJd/01e9R235dLfq5+JXN0ORzJefcwS88B7365Yah0PY6IxR81kMhM/gCL
niVLSZ0W
=WR4U
-----END PGP SIGNATURE-----

--yvgo774vb4mne4gd--

