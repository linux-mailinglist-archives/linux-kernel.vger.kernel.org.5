Return-Path: <linux-kernel+bounces-148065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C871F8A7D33
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517D21F211D5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8C37C081;
	Wed, 17 Apr 2024 07:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="p3fawXY3"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCEC6F065
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339378; cv=none; b=LnXO9ja/ewi4mn2I5M0aW2XZuAs6yRdakaVPUbzab8F8bjKjzuO7DN5WBLjElHqX4G73dGWXDZc7xraD2a2/62/GPyt9MyhXZZs0in135lO9BqEpLnE4UlxFpnsJtv0L9y7SWToXFYxoXpdkkljMyTCECwgGqLaHbbniQvU2S2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339378; c=relaxed/simple;
	bh=otVw6EYy+DnTkwgr4NzobyVMEmxegW2JE0ZH2Lagd9s=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=e+oh/9C2QyqY5/Wi7AKGqj8G39yz7LIXmk4C6qX5ILQjlizTfxBN+Nq3214gJqFJTMwh8DDUw1p0BA+mfeEEQntlfd/ecpPu2Wo9Coat4Qje2irY0Nm+OtkrMQGKaMfCuJ7y0F8tUDueveNHYrr/OGVnHQ4zhg4dfVcq4YJx7DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=p3fawXY3; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240417073613euoutp01a34053ab83e6cd575d8184712bb90167~HARUeT6um0257202572euoutp01j;
	Wed, 17 Apr 2024 07:36:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240417073613euoutp01a34053ab83e6cd575d8184712bb90167~HARUeT6um0257202572euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1713339373;
	bh=UGcZcOmDGqEeNYf2mUuCQPN1dgJJiFQDqkjeeow7mCE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=p3fawXY3Qevp4CU0eJv9MnWVX3KPhaTZ/PcyLHtf9EzPCEaAwRzQzfa0fX17lcPDT
	 xJtSqS8aq+s3iYY2Oc/bhvf2pZCKgh3+2MWyRrOkyWBO+7mWAKanT5+UXmNEOKUXxW
	 5UXW8WwgJjq/VxNAOt501vY4xxeai4g4vFBpKHI8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240417073613eucas1p23ded227ff5dcd9d10b86609768883d89~HARUP5YK42371723717eucas1p2R;
	Wed, 17 Apr 2024 07:36:13 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id CA.E3.09875.DEB7F166; Wed, 17
	Apr 2024 08:36:13 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240417073612eucas1p2d71107a20fc91b2cd164bd4796c26a45~HART6Z1qc0985709857eucas1p2m;
	Wed, 17 Apr 2024 07:36:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240417073612eusmtrp20e665009c840b7b6e803d2b6d73f85ba~HART52Pkd2992029920eusmtrp2G;
	Wed, 17 Apr 2024 07:36:12 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-8a-661f7bed1ed2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id CC.57.08810.CEB7F166; Wed, 17
	Apr 2024 08:36:12 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240417073612eusmtip1d6be8a88e6eb6a9b23b07f593ea9aaca~HARTuSAvm1299112991eusmtip12;
	Wed, 17 Apr 2024 07:36:12 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 17 Apr 2024 08:36:12 +0100
Date: Wed, 17 Apr 2024 09:36:07 +0200
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	Eric Dumazet <edumazet@google.com>, Dave Chinner <david@fromorbit.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/11] sysctl: treewide: constify ctl_table argument
 of sysctl handlers
Message-ID: <20240417073607.nuhuj2we4jln2b2j@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="a5ycuyf4ogpwtr2p"
Content-Disposition: inline
In-Reply-To: <25166edb-4443-421f-abba-38914db2fac4@t-8ch.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7djPc7pvq+XTDJZt57DYcuweo8XTY4/Y
	Lc5051pc3jWHzeL3j2dMFjcmPGV0YPOY3XCRxePUIgmPBZtKPTat6mTz+LxJzqO/+xh7AFsU
	l01Kak5mWWqRvl0CV8ayK1tZC+YpVHRePczewDhNuouRk0NCwERi1v5DbF2MXBxCAisYJb7v
	ucUIkhAS+MIosXO+I0TiM6PE0UUz2WA6Fh5axAiRWM4o8WDVHya4ql3/2qBmbWaU2H7uItgs
	FgFViZU965lAbDYBHYnzb+4wg9giAjYSK799ZgdpYBbYzijR3vYEbIewQILE9p8LwJp5BRwk
	FjyezARhC0qcnPmEBcRmFqiQ+HPyGJDNAWRLSyz/xwES5gSaOWFOKxPEqYoSXxffY4GwayVO
	bbkFdqmEwHROiY0LP7JDJFwk2s4+hWoQlnh1fAtUXEbi/875UA2TGSX2//vADuGsZpRY1vgV
	qsNaouXKE6gOR4m+my2MIBdJCPBJ3HgrCHEon8SkbdOZIcK8Eh1tQhDVahKr771hmcCoPAvJ
	a7OQvDYL4TWIsJ7EjalT2DCEtSWWLXzNDGHbSqxb955lASP7Kkbx1NLi3PTUYqO81HK94sTc
	4tK8dL3k/NxNjMBEdvrf8S87GJe/+qh3iJGJg/EQowpQ86MNqy8wSrHk5eelKonwtgjLpgnx
	piRWVqUW5ccXleakFh9ilOZgURLnVU2RTxUSSE8sSc1OTS1ILYLJMnFwSjUwJSnn8FjeyK2I
	/jnVW9tkR8PvH5+MbolrGUs3lWWbWq+cXNmS5pKz3LO/vO+GNuu9rNV7Zxbzzwn0S99x6kPb
	ev0esQsXKlx/nWMXc9u66Y+F2b7+COaTLw5N9q4VnpKRpZsj+j/8BmvGtM+1LgLbpqvv48z5
	eywjh2GOVcGu/bErvgb/ZWNs3infOSttjYte5lbtG2dakubF/gp/tuqO6fekTc65c34qhxdW
	bdx5/lH7Vae5av0z3sxqiM0SPB2tnJ/eMOP4Jumzpk3vg3ws/A/NSnpqmJMy70nN7vSHYTc1
	zikc59bJ1HjPYKHauyjv0rr37yz0/vb7tD+6+e6r/vXjC69c0c91XVTBy5KjxFKckWioxVxU
	nAgAWTHK+t8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsVy+t/xu7pvquXTDH7d17PYcuweo8XTY4/Y
	Lc5051pc3jWHzeL3j2dMFjcmPGV0YPOY3XCRxePUIgmPBZtKPTat6mTz+LxJzqO/+xh7AFuU
	nk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXkbvpxms
	BXMUKubdfcbawDhFuouRk0NCwERi4aFFjF2MXBxCAksZJb5M38wKkZCR2PjlKpQtLPHnWhcb
	RNFHRolva+6zgCSEBDYzSrw84g9iswioSqzsWc8EYrMJ6Eicf3OHGcQWEbCRWPntMztIM7PA
	dkaJ9rYnbCAJYYEEie0/FzCC2LwCDhILHk9mgthwm1li/7fZrBAJQYmTM5+AbWMWKJM4ewjk
	JA4gW1pi+T8OkDAn0IIJc1qZIC5VlPi6+B4LhF0r8fnvM8YJjMKzkEyahWTSLIRJEGEdiZ1b
	77BhCGtLLFv4mhnCtpVYt+49ywJG9lWMIqmlxbnpucWGesWJucWleel6yfm5mxiB0bzt2M/N
	Oxjnvfqod4iRiYPxEKMKUOejDasvMEqx5OXnpSqJ8LYIy6YJ8aYkVlalFuXHF5XmpBYfYjQF
	BuNEZinR5HxgmskriTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCUamBS
	r44/8pgxhIX9iZnfNW+7vt5lPxm36LTHHlKOdfC5Ud92w77vc4+u9Oy3j1M8r7Gd4NhRaFnJ
	/ppJ/opI1sldn3vOfK3zPGumJ/9zc9X1lj9trysuKew30hWxm/SkJ+debZJd3bRw9t0HO0/P
	zJPZPOdYq4fzB2arigWfipZv3j1rzpbvT06/PMS+puBEsdHU2TOeeE01rdjvufPKj76DP5UT
	ZyVc0ZrQsfau6mm9w3YMFuyzzh565Pnf+bluLPenh3Vqhdz7+HKC9+xnfXovNnnhnxlaKX1f
	Xd30Jk0NL17/4MJmfn3+32Fu7/2FPy6aGBt37OEr7ZLlb6Vm1ZxW9+V//7At+aiBXmPqhhna
	SizFGYmGWsxFxYkA6AdJS3sDAAA=
X-CMS-MailID: 20240417073612eucas1p2d71107a20fc91b2cd164bd4796c26a45
X-Msg-Generator: CA
X-RootMTR: 20240323154426eucas1p12a061ae721193083fd0ed29016277017
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240323154426eucas1p12a061ae721193083fd0ed29016277017
References: <CGME20240323154426eucas1p12a061ae721193083fd0ed29016277017@eucas1p1.samsung.com>
	<20240323-sysctl-const-handler-v2-0-e80b178f1727@weissschuh.net>
	<20240328210016.33wqcpwatamupxyw@joelS2.panther.com>
	<cd60f573-ea02-4834-8bb9-9fef24088cfc@t-8ch.de>
	<20240408085928.dhvexnhvvugfvjkt@joelS2.panther.com>
	<a90e9483-f27b-4448-9fae-b768d8139ead@t-8ch.de>
	<20240416161819.prjyozfkvy3nddzh@joelS2.panther.com>
	<25166edb-4443-421f-abba-38914db2fac4@t-8ch.de>

--a5ycuyf4ogpwtr2p
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 09:32:24PM +0200, Thomas Wei=DFschuh wrote:
> (+Cc LKML to at least get the conversation into the archives)
>=20
> Hi Joel,
=2E..
>=20
> > Not only that, but it also breaks tools like lei and b4. I have configu=
red b4 to
> > look at https://lore.kernel.org/all to handle patches coming from contr=
ibutors.
> > If the change is not public it breaks my command (`b4 am -o - MESSAGE_I=
D | git
> > am -3`).
>=20
> Understood, as mentioned above the trimming went to far.
>=20
> FYI:
> b4 can do the `git am` itself with `b4 shazam MESSAGE_ID`.
> Use the config `b4.shazam-am-flags` for the `-3` flag.

Thx for the tip.

>=20
> > I do not know who spooked you but I suggest you just remove this person
> > from the to:/cc: of your patches and leave the rest as it is. Like I
> > did with Mathew Wilcox after he asked me to do so here
> > https://lore.kernel.org/all/ZZbJRiN8ENV%2FFoTV@casper.infradead.org/.
> > Please resend the patchset including the relevant kernel mailing lists =
and
> > maintainers but excepting the person that sent you the private e-mail.
>=20
> In addition to the complaint I also got guidance from Thomas Gleixner to
> reduce the scope of recipients.
>=20
> What do you think about the following:
>=20
> You do a review of v2 and give feedback on that and I'll incorporate
> that feedback and afterwards send a v3.
This will *not* work and this is why:
1. I will not be able to use b4 to gather SOBs (and the like) because
   there is no original mail
2. The review would be confusing in public as the original message will
   not have existed.
3. I will most likely forget to add relevant recepients.

Please resend the patch. `b4 send --resend [vN]` should work after you
have added the additional CCs.

> In addition to the recipients of v2 I'll add LKML, Greg and Andrew Morton.
It will just get lost in LKML. If you are *not* going to add all the
maintainers themselves, at least add the relevant kernel lists. These
are the lists that I propose (from running get_maintainers.pl on your
11/11 patch):

linux-fsdevel@vger.kernel.org
netdev@vger.kernel.org
linux-arm-kernel@lists.infradead.org
linux-s390@vger.kernel.org
linux-kernel@vger.kernel.org
linux-riscv@lists.infradead.org
linux-mm@kvack.org
linux-security-module@vger.kernel.org
bpf@vger.kernel.org
linuxppc-dev@lists.ozlabs.org
linux-xfs@vger.kernel.org
linux-trace-kernel@vger.kernel.org
linux-perf-users@vger.kernel.org
netfilter-devel@vger.kernel.org
coreteam@netfilter.org
kexec@lists.infradead.org
linux-hardening@vger.kernel.org
bridge@lists.linux.dev
lvs-devel@vger.kernel.org
linux-rdma@vger.kernel.org
rds-devel@oss.oracle.com
linux-sctp@vger.kernel.org
linux-nfs@vger.kernel.org
apparmor@lists.ubuntu.com

Its a long list because that patch touches everything :)


> =20
> > This also goes for your "[PATCH] sysctl: treewide: constify ctl_table_h=
eader::ctl_table_arg"
> > which is also not public.
>=20
> Thanks for this pointer, too.
> I'd like to handle it the same way as proposed above.
>=20
>=20
> Sorry for all the back-and-forth,
> Thomas

Best

--=20

Joel Granados

--a5ycuyf4ogpwtr2p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmYfe+YACgkQupfNUreW
QU/COQv/WohiPj50zIl6EmTY6PVKv6tWKl9ldmCzg41gqQ12NzrTYkWN9hwHW0HE
Xz+n/vD2427ZEZ1oLv2IaUcpDsBtRa7s2JicOtVrcD/yjPzwgdBS6P+UFDYb40SZ
NszqoSMW5VPv73RHNt9kTwYmyhNCypHAf8B8E6Re/Nu1oFh1mGO+CkltYSOjur4I
Ec0qquVYjPNucF14eBcuMBjhXsxvqD9Y+FqWdvHPRAOnH4M32ZYEro6kQsV4Eb3R
erU1yo++ATQtz+W/Q0eFDNBIW6j+AF8d72d4xADZRfcsu4qgfJPLxkWoGoFO/1+A
GlK8OOgTliSZdkboDUCQCxhmrT04tnoah0vMX11GAyH9la9NzmIvvvU8jE/rtoki
y1u9IWxC4wVsEeFyfvXNDYAWXGOveDJJP1yC0TxVVrbaP/JhUUeeMpnwh03m59XH
oHwx41tyrjtA2Pk0J311HR8Fkq+xpJAe481wNmBWpX2E/Un6FnR2QwPku5tzjVxb
x3CkuYCr
=eMi3
-----END PGP SIGNATURE-----

--a5ycuyf4ogpwtr2p--

