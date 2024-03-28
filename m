Return-Path: <linux-kernel+bounces-123614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9E0890BC0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3DB8B234D0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9109C13AA5C;
	Thu, 28 Mar 2024 20:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="R8RrE/WV"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694F412FB2D;
	Thu, 28 Mar 2024 20:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658585; cv=none; b=HPxKbDytaFsQEXdsei3evVfFLmIHWl8/dhFrnIegJS/VkVAywIiHHRJakYb15n7hn+TbOeZwPH9VfvmKMPDea5iRwN4Lks1XKoAjeLJMVn3rg8r7s0kv4zA86ydIJrBJDW8YVU6BKEzLjYRoeCV9Bjd91C6oR6qNbYN5PckN5+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658585; c=relaxed/simple;
	bh=wwVK0az7Vz5xXRiFxnwtFZ/et4fSgewUTyUqQBVFi00=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=K4+siR1GXluR/zmv6Hh+jPaqd4s6v0+uMWAgffDEBJz9WjjoBdye63mnS9usn77Xmcp6YJLxuvdIaUGsZS1L9UQHvUuTn5d/R6LSPI1OitLoEsbyzlfGEb5B1hxvtrIt0YzM4mI5V/nFZBPM1ZWGbziOqNq0u/gRzf+RSWSp+gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=R8RrE/WV; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240328204300euoutp02d7eee9320ddd3e5fbea5c4dd40b8d298~BCGj0MZrs0678306783euoutp02F;
	Thu, 28 Mar 2024 20:43:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240328204300euoutp02d7eee9320ddd3e5fbea5c4dd40b8d298~BCGj0MZrs0678306783euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1711658580;
	bh=JgXGkpnWdKDz6hCWir0P3L7GaIVHsxjZP+k30qYYK9o=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=R8RrE/WVYvsfo/+F1I+G1HP08tKh68dItklAChZndlw7MSE+NRY/fpEa+e/7bBlH3
	 ALx7wOj5tR8PVsxgMMcmDt4y+nz6iORl1mFu7tLSTZNTQ64xWb2Wcg4OinjbfU7iWK
	 kJZT1W5tI6lkjuT13iYGogHZYJ+31UZ7vKnWke7o=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240328204259eucas1p20353930a844142684290833c8a248743~BCGjGtE4x0936509365eucas1p2S;
	Thu, 28 Mar 2024 20:42:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 89.3E.09539.356D5066; Thu, 28
	Mar 2024 20:42:59 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240328204258eucas1p142f0672d9a34ff6875723786803eedc4~BCGiRq_-e2618326183eucas1p1L;
	Thu, 28 Mar 2024 20:42:58 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240328204258eusmtrp1607b57569a48b7beef0399d895ad77c0~BCGiRGI9P1887718877eusmtrp1P;
	Thu, 28 Mar 2024 20:42:58 +0000 (GMT)
X-AuditID: cbfec7f2-52bff70000002543-f1-6605d6531485
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 0A.01.09146.256D5066; Thu, 28
	Mar 2024 20:42:58 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240328204258eusmtip2323bbd8f254703cd7bb523bbb451d975~BCGiELmxl0755407554eusmtip20;
	Thu, 28 Mar 2024 20:42:58 +0000 (GMT)
Received: from localhost (106.210.248.208) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 28 Mar 2024 20:42:38 +0000
Date: Thu, 28 Mar 2024 21:42:32 +0100
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Eric W.
 Biederman" <ebiederm@xmission.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] fs/proc/proc_sysctl.c: always initialize i_uid/i_gid
Message-ID: <20240328204232.jh2ymioigvptjooa@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="f5njphdhtcms5gyn"
Content-Disposition: inline
In-Reply-To: <20240322-sysctl-net-ownership-v2-1-a8b4a3306542@weissschuh.net>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7djPc7rB11jTDN5eE7WYc76FxeLwoheM
	Fv+3tbBbPD32iN3iwrY+VotlPWvZLC7vmsNm8fvHMyaLGxOeMlocWyBm8e30G0aLBRsfMTrw
	eKy40MXqsWXlTSaPnbPusnss2FTqsWlVJ5vH+31X2Tw+b5Lz6O8+xu4x5VA7SwBnFJdNSmpO
	Zllqkb5dAlfGydklBfelKqavOs7awPhdrIuRg0NCwESib0ltFyMXh5DACkaJdbs2skI4Xxgl
	Vpw6CuV8ZpT413qXsYuRE6zj9vu1TBCJ5YwSLWcnM8NVbfw9AaplK6PEpaN3mEBaWARUJZ68
	28cCYrMJ6Eicf3OHGcQWEbCRWPntMzuIzSwwnVniy0QtEFtYwEfiwuG3rCAH8go4SFw46gkS
	5hUQlDg58wkLRHmFxKmGd4wgJcwC0hLL/3GAhDkFfCVOXOhjhThUWeJux2k2CLtW4tSWW2BH
	Swjc4pS4/PgPC0TCReL63f/MELawxKvjW9ghbBmJ05N7WCAaJjNK7P/3gR3CWc0osazxKxNE
	lbVEy5UnUB2OEhNm/2WBhCqfxI23ghCH8klM2jadGSLMK9HRJgRRrSax+t4blgmMyrOQvDYL
	yWuzEF6DCOtJ3Jg6hQ1DWFti2cLXzBC2rcS6de9ZFjCyr2IUTy0tzk1PLTbMSy3XK07MLS7N
	S9dLzs/dxAhMj6f/Hf+0g3Huq496hxiZOBgPMaoANT/asPoCoxRLXn5eqpII786jLGlCvCmJ
	lVWpRfnxRaU5qcWHGKU5WJTEeVVT5FOFBNITS1KzU1MLUotgskwcnFINTHqSWjGd66VaJ59V
	+/JcYfpCxdxSI4E8q7cnaw4IeOuY7IqqOfo9ffbHRQw+punlvFNC60xmq/q27U2uPSGyL+DW
	nuQYHQPjM7XSwgWahq6dhrGPXzbV1Z/8XW/x0vJOyrf8BQd72iJ/Fn1zOzb/zGHm175L/96d
	mvCyReylpZo6h+gMxV/Sq/ktBG2s+YIYljNOqV3xyOS1e5Zu2rk05TdPWYu/zJujd2GzzsnE
	Pyz/ed4/yIjp++6zzJ2HbYL1vNOmy3ccL5rz+9cL5e/ilqLeGqfWzWS157wUFJOfLjrjeHC0
	5EtmnTVv/PfLHq5sC3PcUl6WcjRJLer1tP9/L+7ZYfH3+IuzBv1N32blKrEUZyQaajEXFScC
	AM69kPIKBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsVy+t/xe7pB11jTDDb/kbGYc76FxeLwoheM
	Fv+3tbBbPD32iN3iwrY+VotlPWvZLC7vmsNm8fvHMyaLGxOeMlocWyBm8e30G0aLBRsfMTrw
	eKy40MXqsWXlTSaPnbPusnss2FTqsWlVJ5vH+31X2Tw+b5Lz6O8+xu4x5VA7SwBnlJ5NUX5p
	SapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7GykfX2QruSlU8
	ae9mbmD8KtbFyMkhIWAicfv9WqYuRi4OIYGljBIzV81ng0jISGz8cpUVwhaW+HOtiw2i6COj
	xM5bp8ASQgJbGSVm/bQEsVkEVCWevNvHAmKzCehInH9zhxnEFhGwkVj57TM7iM0sMJ1Z4stE
	LRBbWMBH4sLht0BzODh4BRwkLhz1hJi/gFHixodzYHN4BQQlTs58wgLRWyZx/T+IzQFkS0ss
	/8cBEuYU8JU4caEP6k5libsdp6Hur5X4/PcZ4wRG4VlIJs1CMmkWwiSIsI7Ezq132DCEtSWW
	LXzNDGHbSqxb955lASP7KkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMAkse3Yz807GOe9+qh3
	iJGJg/EQowpQ56MNqy8wSrHk5eelKonw7jzKkibEm5JYWZValB9fVJqTWnyI0RQYiBOZpUST
	84HpK68k3tDMwNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1Oqgcl2qfjkBydz
	cp7/aAoIuHTsx7vpdlcVbHlM+efOnvdVYUr8xaDeuPbwy9vOJH5cdeHbZt+2asWjPNmTD1TI
	GL7+5Lw55mp6TrD9rLuMp3V9fUq4r93yfOYW/pTLrSqiz+rLn3hHSRO3v0rLvn3SZDnfFGHq
	vTUwo3X+v6MnN8tHC34Sm6mi1f3gf+yjJ6dEe/bqxTXZnMj4rXhjzQnL7tKki44hace5GM8U
	vjswf6lfkUiJzO2as9q3X57K9Dv6dZGVVpBu2MMTCqLRt9Ztfs7Bc9l184WjM9YrG+2daOOQ
	dc7TOtz8QfGDtzN7TjIun7alcN/k2+Z5n32nhmkwBefVGwQYO3iFvtp18licQIMSS3FGoqEW
	c1FxIgCxy8BhpwMAAA==
X-CMS-MailID: 20240328204258eucas1p142f0672d9a34ff6875723786803eedc4
X-Msg-Generator: CA
X-RootMTR: 20240322195138eucas1p14ff532294e26ed63a400321066f03d98
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240322195138eucas1p14ff532294e26ed63a400321066f03d98
References: <CGME20240322195138eucas1p14ff532294e26ed63a400321066f03d98@eucas1p1.samsung.com>
	<20240322-sysctl-net-ownership-v2-1-a8b4a3306542@weissschuh.net>

--f5njphdhtcms5gyn
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 08:51:11PM +0100, Thomas Wei=DFschuh wrote:
> Commit e79c6a4fc923 ("net: make net namespace sysctls belong to container=
's owner")
> added default values for i_uid/i_gid.
> These however are only used when ctl_table_root->set_ownership is not
> implemented.
> But the callbacks themselves could fail to compute i_uid/i_gid and they
> all need to have the same fallback logic for this case.
All this text is related to commit e79c6a4fc923; which is not the one at
fault. I think mentioning e79c6a4fc923 here is incorrect. Please mention
5ec27ec735ba0 ("fs/proc/proc_sysctl.c: fix the default values of
i_uid/i_gid on /proc/sys inodes") and how it missed adjusting
net_ctl_set_ownership when it was committed.

>=20
> This is unnecessary code duplication and prone to errors.
> For example net_ctl_set_ownership() missed the fallback.
This paragraph can be dropped

>=20
> Instead always initialize i_uid/i_gid inside the sysfs core so
> set_ownership() can safely skip setting them.
>=20
> Fixes: e79c6a4fc923 ("net: make net namespace sysctls belong to container=
's owner")
Why did you leave this? Do you disagree with my comment in
https://lore.kernel.org/all/20240319130716.vne4nhb3mbwtabfb@joelS2.panther.=
com/?

> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---
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
> base-commit: ff9c18e435b042596c9d48badac7488e3fa76a55
Now that v6.9-rc1 is out, I would rebase your next version there.


The change looks good, but the commit message still needs work.
--=20

Joel Granados

--f5njphdhtcms5gyn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmYF1jcACgkQupfNUreW
QU8Y4Av/apOhPma8wv0im4TrTo3uhkhiSmUil+CyJBYvKIDNanwIE+NtlSRluYs4
b0RTC96XXRfQJe57wd+Sm+pDTKL8rlbtEILfegr+IMMigtZcqIRQZz77GzVQCIhe
AavNY/BlRGpsZiGxCJT4YHJjZsDBuJdy0W57eIZoXNFOqtEAmv5hmRcMKEi2IN2l
faKxpbppNHN3YyOH1cHkA1ObdizsL01VJIIwdh5EjJDHae6a4RJZd0kWpSw/uBkR
DKb+Bej/Hf2uBDHdThJKEJVB9V5+ByzABF8fTaXmsy80WFAKJLkuw5nKi+rNZoAd
YFJsejAO5lpy8ZSTR6BzDWYosfJJndGXp2uuKEPibxquSk+N1NVptujPdsurIczT
3kTSrWh9sInYjpi5wQ78Z9sFqDZyn7t7mLa1OHg/izqI2qcA/+zrnYm9IDbke/PT
FZ9DtiFtJIYYOoqyUKfeJMoaOGd+QhHtGGIAJNQn2ceYuOMPBz5G+SlmWNJ0qFsX
EsOvDGKO
=z7bl
-----END PGP SIGNATURE-----

--f5njphdhtcms5gyn--

