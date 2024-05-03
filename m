Return-Path: <linux-kernel+bounces-167692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255178BAD85
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D4F1C21E3D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F64915382D;
	Fri,  3 May 2024 13:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aMbYgifR"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C06615381E;
	Fri,  3 May 2024 13:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714742260; cv=none; b=K5d5UnPVSbEM20s+T8Qsks2VrrZ7rAi4zZhLxb6Gg+G1O8ktLdDN1+3XqU68R4ZeGIbUm+yDBN1dYnstn1gJpLsk3NCz7TRH/g/dv1E7FaCD0IyhpVEtgOnV0KEcfltjapte1KZ4dT9fX4UuzIAINcw3x9S7e7i+MIJeUV3gPfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714742260; c=relaxed/simple;
	bh=8M8Cgp+D/629aOkA3HRW7xYv0oir9n6gTpMCuT0JnMU=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=oOgSbg4apDbx/tSy7lcj4FtQoDDW/h8zNMgmmdx4HFCiUGs6biTeaoucL+bRdq3d0gqy63hzQb7aBAUH9er9ksWTWFPt/X81WxzLhDMONCNqJJPNvgCf/uW6iobOeH8alklwQw8bZDppr+j6Bc2yY7fJ63hyLHXsXW1PHchT73g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=aMbYgifR; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240503131735euoutp01b661583980d1a2e07cc29da171c2db8e~L-P8C_C2H2166421664euoutp01n;
	Fri,  3 May 2024 13:17:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240503131735euoutp01b661583980d1a2e07cc29da171c2db8e~L-P8C_C2H2166421664euoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714742255;
	bh=K4kfBQTnOuvYNClHaquijefrHTO06rIgq3MI4amnq+U=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=aMbYgifRaKLjxFy8noJGEdYqSYXoYGQiPxXWHdOB36d4tvOitDEUYyOtlFns2qxyo
	 hLDgruNsZYdFnanDmdvSAQaW8J1kMiZDtdcPZtAuCvZ6nI9tyzCIucyRAsjPDT7lnv
	 HVw44rZboqE0fCj5xoV7IFJ7nwK3AXIHf450mPRY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240503131735eucas1p12145881e4348bcb858275d17a0135023~L-P72CjUJ2330823308eucas1p1m;
	Fri,  3 May 2024 13:17:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 7D.95.09624.EE3E4366; Fri,  3
	May 2024 14:17:34 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240503131734eucas1p1780d91c633f2ef0cc3375f3dca79a786~L-P7VrbmK2330823308eucas1p1l;
	Fri,  3 May 2024 13:17:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240503131734eusmtrp1b1f6d27499873fe8e78ae41b9c4b568f~L-P7VAhTe1543815438eusmtrp1M;
	Fri,  3 May 2024 13:17:34 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-d9-6634e3ee7b45
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 7E.BD.08810.EE3E4366; Fri,  3
	May 2024 14:17:34 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240503131734eusmtip2f6331686f19a35e0856691a8c640ca48~L-P7HXAQN0098800988eusmtip2h;
	Fri,  3 May 2024 13:17:34 +0000 (GMT)
Received: from localhost (106.210.248.112) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 3 May 2024 14:17:33 +0100
Date: Fri, 3 May 2024 15:17:29 +0200
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Eric W.
 Biederman" <ebiederm@xmission.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3] fs/proc/proc_sysctl.c: always initialize i_uid/i_gid
Message-ID: <20240503131729.zrh3owxk5tldv4xe@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="qi45cf7gspm2kfed"
Content-Disposition: inline
In-Reply-To: <20240402-sysctl-net-ownership-v3-1-366b1a76d48a@weissschuh.net>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7djPc7rvHpukGczdaWMx53wLi8XhRS8Y
	Lf5va2G3eHrsEbvFhW19rBbLetayWVzeNYfN4vePZ0wWNyY8ZbQ4tkDM4tvpN4wWCzY+YnTg
	8VhxoYvVY8vKm0weO2fdZfdYsKnUY9OqTjaP9/uusnl83iTn0d99jN1jyqF2lgDOKC6blNSc
	zLLUIn27BK6MG//WMBdMkqhYuruHsYHxk0gXIyeHhICJxKmmVSxdjFwcQgIrGCV+HDrOBOF8
	YZR4sPMgVOYzo8S+yTuYYFrO/F3ABpFYzigxefplRriqCadXs4FUCQlsYZTYv9W9i5GDg0VA
	RWLFSnaQMJuAjsT5N3eYQWwRARuJld8+g8WZBaYzS3yZqAViCwv4SHRt2wa2jFfAQeLZ6YuM
	ELagxMmZT1gg6iskFm9uYAMZzywgLbH8HwdImFPAV+LQlknsEHcqSxzZPhfKrpU4teUW2GcS
	Atc4Jda9+Qf1jIvEranzoGxhiVfHt0A1yEicntzDAtEwGeiVfx/YIZzVjBLLGr9CdVhLtFx5
	AtXhKNG1bAEzyEUSAnwSN94KQhzKJzFp23SoMK9ER5sQRLWaxOp7b1gmMCrPQvLaLCSvzUJ4
	DSKsJ3Fj6hRMYW2JZQtfM0PYthLr1r1nWcDIvopRPLW0ODc9tdgwL7Vcrzgxt7g0L10vOT93
	EyMwQZ7+d/zTDsa5rz7qHWJk4mA8xKgC1Pxow+oLjFIsefl5qUoivNqTjdOEeFMSK6tSi/Lj
	i0pzUosPMUpzsCiJ86qmyKcKCaQnlqRmp6YWpBbBZJk4OKUamEJSyp+uXBfz40jy1MjyPMHK
	14ckfA/6ZLJxPZ5wI2FFk9ZrHr+d0srKM5hjT/vs/qy1KedQbazC6UOHK6K3Hlyq2bBBN3bG
	3ZkfU88lrz3EU7GLTX/dqg+9C29LervvPRYtvjCrqPPUlHTVafsVbpoX/lrAvMmM2cq5NCjG
	cHbczL/xzB2l8Wo86VNEH4he/ftzo01qf+h0gaO8ITlBv4/Pct/QOUd6ZUDfl/RaMXWF7GCH
	PO+ldVMla8Q+VNsr5rDs+ZymMqG9qo6TKf7ggTlH1wvYvUmb6G09Z66t0ePUBAN3v4PrTcxu
	6kQ1LO5RXS/a2r+Na2bOJ98zHh2T/SWee6rrJW/Xd3e58d9CiaU4I9FQi7moOBEAo3Le+wsE
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsVy+t/xe7rvHpukGexeImsx53wLi8XhRS8Y
	Lf5va2G3eHrsEbvFhW19rBbLetayWVzeNYfN4vePZ0wWNyY8ZbQ4tkDM4tvpN4wWCzY+YnTg
	8VhxoYvVY8vKm0weO2fdZfdYsKnUY9OqTjaP9/uusnl83iTn0d99jN1jyqF2lgDOKD2bovzS
	klSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2Mw5sfMRdMkKi4
	tCy8gfGDSBcjJ4eEgInEmb8L2LoYuTiEBJYySrx9388KkZCR2PjlKpQtLPHnWhdU0UdGiX33
	NjFDOFsYJRo3rGbqYuTgYBFQkVixkh2kgU1AR+L8mzvMILaIgI3Eym+fweLMAtOZJb5M1AKx
	hQV8JLq2bWMCsXkFHCSenb7ICDFzAaPE4w3n2SESghInZz5hgWguk1j4+wcjyC5mAWmJ5f84
	QMKcAr4Sh7ZMYoc4VFniyPa5UHatxOe/zxgnMArPQjJpFpJJsxAmQYR1JHZuvcOGIawtsWzh
	a2YI21Zi3br3LAsY2VcxiqSWFuem5xYb6hUn5haX5qXrJefnbmIEJoltx35u3sE479VHvUOM
	TByMhxhVgDofbVh9gVGKJS8/L1VJhFd7snGaEG9KYmVValF+fFFpTmrxIUZTYCBOZJYSTc4H
	pq+8knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS1OzU1ILUIpg+Jg5OqQYmXmeTuhiWeJmm
	3kCul4ua+TLePd6WNZOze+Zf8cwbj51YT/09z/0o/8Pf2A+SHSG/ls6a8/hE9JR30k5qMm+f
	bYxQ2Go/Yfph75CGvd2Vx/TuSHfLdXtcmS80pyfLcP3USsZ/rxx/T5217VOVSKjNETuJp+EX
	59nt4KhY9eTcvJkBD/V8byjK2ntZ1NnfX1r4+KuSd2tRmdQnn7KCRZ1umeui97DMuOy17UpV
	6ou5O7UnSNycWBf+/MOybQKmZu9sklz/+syemHm8skx+av3Vh6sEN8qzSpd80N5W9O350aSo
	2kc8yWVnMlcU1Yh7W8nPM/S0/3FmWd+EFYezfVu3hMs9XJK8037dfbvTwXcmKrEUZyQaajEX
	FScCABIY8/enAwAA
X-CMS-MailID: 20240503131734eucas1p1780d91c633f2ef0cc3375f3dca79a786
X-Msg-Generator: CA
X-RootMTR: 20240402211043eucas1p173a936d187ae9bcf5be3729e69739e38
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240402211043eucas1p173a936d187ae9bcf5be3729e69739e38
References: <CGME20240402211043eucas1p173a936d187ae9bcf5be3729e69739e38@eucas1p1.samsung.com>
	<20240402-sysctl-net-ownership-v3-1-366b1a76d48a@weissschuh.net>

--qi45cf7gspm2kfed
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
Queueing this up for 6.11....

Reviewed-by: Joel Granados <j.granados@samsung.com>
--=20

Joel Granados

--qi45cf7gspm2kfed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmY04+gACgkQupfNUreW
QU+O3Qv+Io8rNWddMLhIj+rGj2f2uUC8Af+47Y6bkOGDVrpYa8KuqdMJPezuRjZT
dafAPD8RReoOY6teYWZ29U45aWIHbb0HhD4A6Xh/sY3cibRIb6FT2O7N99Mp6/Al
eMtOPE+pOtpBM+BjV5r+HojEATahweEOz4ZWe9zv4w7J6kPL7zLAUnU6wLM3KSSU
Aw/Eu1LWlM329NKKN+ZTf9NI9qJcT6sv9biLIP2Fn0er0U9febjDHAMfeMAhurOv
MEgNJYuBtqUR6e0iFI3T2VREtTJa/ULJ8jEPfK9ZAwqYbBXVVpe7lfV8mKpICmlE
U4AA5IVDFLctrm3sDksOOrb023Wj9fhgIvCF2Gi6fcWQ4SI4hTRTF1GSnbo0ahYF
49HpUrPTUcOl8ArZt8xYVE8WP3XBBT6mr/dyoZSk8im/FssyBn4hH18KBoWGciip
dtvfvO+Zu3+LElkRo2om3BJT223lNzF5gidaLEvQcOnRQglM3hy2JIj9eIljAwFL
2SGTt+NN
=UgRY
-----END PGP SIGNATURE-----

--qi45cf7gspm2kfed--

