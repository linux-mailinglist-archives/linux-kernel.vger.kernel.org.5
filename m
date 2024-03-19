Return-Path: <linux-kernel+bounces-107583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AB987FEA1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB92928536F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01D980604;
	Tue, 19 Mar 2024 13:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="J/UGGTGC"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5159380021;
	Tue, 19 Mar 2024 13:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710854527; cv=none; b=BVBIzLNxWM+tGrvhprnaV0M54PWYXox6+c7TJLNryy6GZo/1EVQOnD1K33ykJ+bqGbva4fBrs+msvPAiAdRNd8UmGwUHrCa9qd5CVSeowCUv6JS9CqPLTdLi1S6yvSTxeJxMoLCo1T0FHhaaz2LQvEKVVFo9atA0YeB2fpP4JIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710854527; c=relaxed/simple;
	bh=e6Bi1CDIhaDiSiMVNFBkAzOJzxheLNal41extx7iiKI=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=T/PvEnDMy0AospEZ/IkkKzFs5Y7QYF1FoYyLI80yAf+PE8yeUhbwuCTcTWVbx10c34eR/MYPfI8uuU4T04iMKbsxF2+pBD0Ci7FmAWBmhgkQ2w3H89+/o+s3qP50cXL+pnapI2kBPEMRAAJo5fBApvyyr8XnP7nPBmH/x7+3pdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=J/UGGTGC; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240319132202euoutp022f4c622d3e9b517cc7414107873f6cc2~_LR_j7ZZT0932509325euoutp02I;
	Tue, 19 Mar 2024 13:22:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240319132202euoutp022f4c622d3e9b517cc7414107873f6cc2~_LR_j7ZZT0932509325euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1710854522;
	bh=7xiG82iUcbnud7ZPrS3/cXUZxYPGj5vKRkqznUSIJQI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=J/UGGTGCnV62kLBaqkC4a9PXHO9bqHGeYQsoIU8EP0E4EyZyCpQJV15stzbTmaMMv
	 OPbuU/aZKrVCgNoUww0XH1sh39h1CaB7Z8S5A005+pqtMWC2WjSzio14DS12NO9N3G
	 AC780xSslctdlQ/Y1SCjsMY31wIx4Glc/Q3FGWlQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240319132201eucas1p2cff4eb22dbdd3ba4de0b24532137555c~_LR_ITzLV2156121561eucas1p2_;
	Tue, 19 Mar 2024 13:22:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 4D.EE.09539.97199F56; Tue, 19
	Mar 2024 13:22:01 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240319132201eucas1p1a04c190a4199134df049d28cc3131dc7~_LR9l-h6O2208922089eucas1p10;
	Tue, 19 Mar 2024 13:22:01 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240319132201eusmtrp2257839d6ab7e5c9e4a002be98178bc53~_LR9lW9q22361223612eusmtrp2P;
	Tue, 19 Mar 2024 13:22:01 +0000 (GMT)
X-AuditID: cbfec7f2-52bff70000002543-6a-65f991796a9b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 81.7E.09146.97199F56; Tue, 19
	Mar 2024 13:22:01 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240319132201eusmtip18a2029a5e1c130dad9d38933f49aa20e~_LR9ZKwTQ3061830618eusmtip1k;
	Tue, 19 Mar 2024 13:22:01 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 19 Mar 2024 13:22:00 +0000
Date: Tue, 19 Mar 2024 14:21:58 +0100
From: Joel Granados <j.granados@samsung.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
CC: <linux@weissschuh.net>, <davem@davemloft.net>,
	<dmitry.torokhov@gmail.com>, <ebiederm@xmission.com>, <edumazet@google.com>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <mcgrof@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH] net: always initialize sysctl ownership
Message-ID: <20240319132158.37aitf2ysxqcd3bt@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="wcyzp5c3nczdoa42"
Content-Disposition: inline
In-Reply-To: <20240316003958.65385-1-kuniyu@amazon.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsWy7djPc7qVE3+mGqxbYWAx53wLi8XhRS8Y
	Lf5va2G3eHrsEbvFhW19rBbLetayWVzeNYfN4vePZ0wWNyY8ZbQ4tkDM4tvpN4wO3B4rLnSx
	emxZeZPJY+esu+weCzaVemxa1cnm8X7fVTaPz5vkPPq7j7F7TDnUzhLAGcVlk5Kak1mWWqRv
	l8CVMX3dJLaCG6oVe698Zm5gPC3fxcjJISFgInHn9n5WEFtIYAWjxPl/xl2MXED2F0aJFQdn
	MUM4nxklWjp6WWE6dq58ygqRWM4o0dm8hxWuqm1OM5SzlVFi9ebTTCAtLAKqEq0rl4G1swno
	SJx/c4cZxBYR0JToWNcD1sAs8JtR4siq2WANwgI2ErPnnmcEsXkFHCSOnfrLDmELSpyc+YQF
	xGYWqJD4t/M5UJwDyJaWWP6PAyTMKWAusfXtakaIU5Ulru9bzAZh10qc2nKLCWSXhMAlTok/
	e06zQyRcJGZcaYP6TVji1fEtUHEZif8750M1TGaU2P/vAzuEs5pRYlnjVyaIKmuJlitPoDoc
	Ja70LmAEuUhCgE/ixltBiEP5JCZtm84MEeaV6GgTgqhWk1h97w3LBEblWUhem4XktVkIr0GE
	9SRuTJ3ChiGsLbFs4WtmCNtWYt269ywLGNlXMYqnlhbnpqcWG+allusVJ+YWl+al6yXn525i
	BKbG0/+Of9rBOPfVR71DjEwcjIcYVYCaH21YfYFRiiUvPy9VSYSXnftnqhBvSmJlVWpRfnxR
	aU5q8SFGaQ4WJXFe1RT5VCGB9MSS1OzU1ILUIpgsEwenVAMTj5WAioKIho35kah1BzR9+hfo
	7OX4t62et8Pv0D6LFdLN18rMP16OCL+Vn54esedQhfzzv133/L7tlUh3XRC6UjnTWrzs9mfJ
	68EMMwNrnY6a9zDWW32veJyl9JBnxfGzHPf6T0+97HViRrJBr3+f9OU4HxOvhWq+EbcmnWbY
	dHnWzIybJbnxXF2VsT9/FaxsdJikfzue5yljXu4qppNP9V+trtwRldXx/lN7We3Jl+oTTpY9
	6lvJaTr3xt7HnjtXd+T4s2487eUVELH2vsj3mvibD179UN6UMDvJX0ztvqqez/cry0/9fRuR
	LWVpeLD+/erNrFMNs0qa1u1IWJTz/+Wdcrl/nld870rnHldQYinOSDTUYi4qTgQAsfQkjAgE
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsVy+t/xu7qVE3+mGuybzWcx53wLi8XhRS8Y
	Lf5va2G3eHrsEbvFhW19rBbLetayWVzeNYfN4vePZ0wWNyY8ZbQ4tkDM4tvpN4wO3B4rLnSx
	emxZeZPJY+esu+weCzaVemxa1cnm8X7fVTaPz5vkPPq7j7F7TDnUzhLAGaVnU5RfWpKqkJFf
	XGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX8a33EVPBNdWKHUdOsDUw
	npTvYuTkkBAwkdi58ilrFyMXh5DAUkaJOd/PsEEkZCQ2frnKCmELS/y51sUGUfSRUaL3/h0o
	ZyujxNzu1+wgVSwCqhKtK5eBdbAJ6Eicf3OHGcQWEdCU6FjXA7aCWeA3o8SRVbOZQBLCAjYS
	s+eeZwSxeQUcJI6d+ssOMfUso8T6Td1sEAlBiZMzn7CA2MwCZRKNB44DxTmAbGmJ5f84QMKc
	AuYSW9+uZoQ4VVni+r7FUC/USnz++4xxAqPwLCSTZiGZNAthEkRYR2Ln1juYwtoSyxa+Zoaw
	bSXWrXvPsoCRfRWjSGppcW56brGhXnFibnFpXrpecn7uJkZggth27OfmHYzzXn3UO8TIxMF4
	iFEFqPPRhtUXGKVY8vLzUpVEeNm5f6YK8aYkVlalFuXHF5XmpBYfYjQFBuNEZinR5Hxg6sor
	iTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCUamAK8VkRt+TrnwlbN+26
	wzChUejDuy/zl89Ntln426F/xnrxuX+4pfbbz5Y5GNRZw+5oXyGsyK1nJfb17WxOWb9Nh7RC
	o+dtPWDJHty7649K/+nOmjeTPLicBe67ND7S93gaFv9Pgs+Mc23o900Rh1WK4q3fBXT+mr4n
	iluBMUXP7MsHjqPBueeXcZnE82V9cFERDvf/veDYy8mOe76VPYmsNb6V7/1yRZ1ues0y/voS
	129/1eOer2HN+77iQKWgUuuNpqNBvUmndlapTuRdcfFdjM+uy1VTZvxmO8fvo2rWdkdxktZL
	vvPz7x7+X1M/beW1envtD1rZ4odULnTXxcR61T7XyrE+9NH1uuzZ5ZeUWIozEg21mIuKEwHd
	TFukpQMAAA==
X-CMS-MailID: 20240319132201eucas1p1a04c190a4199134df049d28cc3131dc7
X-Msg-Generator: CA
X-RootMTR: 20240316004018eucas1p20c4854c7493c28aa1943faa589a3b33e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240316004018eucas1p20c4854c7493c28aa1943faa589a3b33e
References: <20240315-sysctl-net-ownership-v1-1-2b465555a292@weissschuh.net>
	<CGME20240316004018eucas1p20c4854c7493c28aa1943faa589a3b33e@eucas1p2.samsung.com>
	<20240316003958.65385-1-kuniyu@amazon.com>

--wcyzp5c3nczdoa42
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 05:39:58PM -0700, Kuniyuki Iwashima wrote:
> From: Thomas Wei=DFschuh <linux@weissschuh.net>
> Date: Fri, 15 Mar 2024 17:20:31 +0100
> > The sysctl core does not initialize these fields when the set_ownership
> > callback is present.
> > So always do it in the callback.
>=20
> Could you add few more words here to explain what the problem is
> like commit 5ec27ec735ba ("fs/proc/proc_sysctl.c: fix the default
> values of i_uid/i_gid on /proc/sys inodes.").
I second this proposal. There is more to the story than a simple setting
of default values. IMO, you should mention how the missbehavior was
introduced in 5ec27ec735ba0 (fs/proc/proc_sysctl.c: fix the default
values of i_uid/i_gid on /proc/sys inodes.)

>=20
> BTW, it seems that we can change the value even if the uid/gid is
> invalid unlike the issue mentioned in 5ec27ec735ba.
Indeed and I think it is because net_ctl_permissions set the mode in the
same way as test_perm does. Therefore regardless of the tests against
GLOBAL_ROOT_[U|G]ID being true or false mode gets right shifted by 6 and
3.

>=20
> So, the problem is just the invalid uid/gid exposed to userspace
> or am I missing something ?
That seems to be the case. I think that should just be
GLOBAL_ROOT_[G|U]ID. Please correct me if I'm wrong.

>=20
> ---8<---
> [root@localhost ~]# unshare --user --keep-caps
> [nobody@localhost ~]$ id
> uid=3D65534(nobody) gid=3D65534(nobody) groups=3D65534(nobody)
> [nobody@localhost ~]$ unshare --net --keep-caps
> [nobody@localhost ~]$ stat /proc/sys/net/core/somaxconn
>   File: /proc/sys/net/core/somaxconn
>   Size: 0         	Blocks: 0          IO Block: 1024   regular empty file
> Device: 13h/19d	Inode: 3726        Links: 1
> Access: (0644/-rw-r--r--)  Uid: (65534/  nobody)   Gid: (65534/  nobody)
> Access: 2024-03-16 00:28:51.937789000 +0000
> Modify: 2024-03-16 00:28:51.937789000 +0000
> Change: 2024-03-16 00:28:51.937789000 +0000
>  Birth: -
> [nobody@localhost ~]$ cat /proc/sys/net/core/somaxconn
> 4096
> [nobody@localhost ~]$ echo 2048 > /proc/sys/net/core/somaxconn
> [nobody@localhost ~]$ cat /proc/sys/net/core/somaxconn
> 2048
> ---8<---
>=20
>=20
> >=20
> > Fixes: e79c6a4fc923 ("net: make net namespace sysctls belong to contain=
er's owner")
> > Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> > ---
> >  net/sysctl_net.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/net/sysctl_net.c b/net/sysctl_net.c
> > index 051ed5f6fc93..03e320ddacc9 100644
> > --- a/net/sysctl_net.c
> > +++ b/net/sysctl_net.c
> > @@ -62,12 +62,10 @@ static void net_ctl_set_ownership(struct ctl_table_=
header *head,
> >  	kgid_t ns_root_gid;
> > =20
> >  	ns_root_uid =3D make_kuid(net->user_ns, 0);
> > -	if (uid_valid(ns_root_uid))
> > -		*uid =3D ns_root_uid;
> > +	*uid =3D uid_valid(ns_root_uid) ? ns_root_uid : GLOBAL_ROOT_UID;
> > =20
> >  	ns_root_gid =3D make_kgid(net->user_ns, 0);
> > -	if (gid_valid(ns_root_gid))
> > -		*gid =3D ns_root_gid;
> > +	*gid =3D gid_valid(ns_root_gid) ? ns_root_gid : GLOBAL_ROOT_GID;
> >  }
>=20
> How about setting the default in proc_sys_make_inode() instead ?
> because the default value configured by new_inode() is not
> appropriate for procfs, IIUC.
Are you proposing something like this in proc_sys_make_inode/

inode->i_uid =3D GLOBAL_ROOT_UID;
inode->i_gid =3D GLOBAL_ROOT_GID;
if (root->set_ownership)
    root->set_ownership(head, table, &indoe->i_uid, &inode->i_gid)

?

>=20
> Thanks!
>=20
> > =20
> >  static struct ctl_table_root net_sysctl_root =3D {
> >=20
> > ---
> > base-commit: e5eb28f6d1afebed4bb7d740a797d0390bd3a357
> > change-id: 20240315-sysctl-net-ownership-bc4e17eaeea6
> >=20
> > Best regards,
> > --=20
> > Thomas Wei=DFschuh <linux@weissschuh.net>

--=20

Joel Granados

--wcyzp5c3nczdoa42
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmX5kXUACgkQupfNUreW
QU+sEAv+K1Rgd2l+2cBLVkK04hjTwfhbAdy6iMinBFG5mgYvoJO7m3+Eq4SeSydv
ZEZvy0zoMgqcLyN/fXTKw5GnrcG5mNdIXgKCoV7VH0HT1qelY1mp9k6E8cUp2Vc2
rEvdE000hn+sQlbhnPlYfq3FtQP41I6gGQpRRDN7Qw9YXo2LnRYdolN7APswvpxt
HbBPZpWdzlMaLV0W+Y5WUaqQx8yn8hyQF0J8o8vLPiE9+fAfjB0MF0PXlmj2R4om
5VqKxaBeAXM0mzFrZSQZyxDFgmt8Qft5O1+BkteiuKF+O2Q1z+2rwPf3tpme+S7m
HJ6EwfNPawUNGHBsznyIl+DB4CI2O+HyeolHjIoYFbL+yVJcLbFX8fOc1xnyr376
4BJ+b6ce2hWHMcpDd5iDiEK3QF/LNMmeODOYE9pg8su0jQb7orG3KCrUNhGMlwLa
5qAYkz4O94urq4bokTYa31oZgOtY0cVE1wM+EsF7y2V5flzlPjbLspsRVMqPX09n
uMtYymwu
=uDuO
-----END PGP SIGNATURE-----

--wcyzp5c3nczdoa42--

