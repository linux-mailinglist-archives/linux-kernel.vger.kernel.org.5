Return-Path: <linux-kernel+bounces-110368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F111885E19
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 359D02808E7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F01137912;
	Thu, 21 Mar 2024 16:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qt+nxLUX"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059381369A4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039063; cv=none; b=ENQOAPrWngFZVmM7bvrBzKlK9wAexwEUUZRQH0MbW/FxfMoaPc5bIwKT7oIsFd7JeUy8immtf2hch5SgPJtqHKaSZ2T5sEx8amWT1/KjxV0hVbPttFHfcBE+lgTHMWu/UkZJdFPdZA1rMHy2FemhoIbCJa9B9RSAzukCwZ+ERlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039063; c=relaxed/simple;
	bh=9NxPKnKTxYxP1AVJuK9e+tWEb/zjIESfPEwUEc+PvsY=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=dlqekfDj3SsQH9pdKuVkEiW+RLAXSEEd98wWUtzpnIbsDIw9z2Irwer+JhQIuAUsvNfGsWAj+G+QoKZ+hh+78CWn5C/U3400y5tV+w++bsJi6bPkdmQUagDg75tVkYH915G+mT08FQZux1oeRmswUURhA0xaPowxxAsh4/sRWFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qt+nxLUX; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240321163736euoutp027f62b04001acb1ef6b7bcb4211c49283~_1PTbNlEG2901029010euoutp02N;
	Thu, 21 Mar 2024 16:37:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240321163736euoutp027f62b04001acb1ef6b7bcb4211c49283~_1PTbNlEG2901029010euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1711039056;
	bh=P0PL+YV51lBoPPLBXlNYhO3sylePQdWWfpLD5cv1T0w=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=qt+nxLUXHotpfCcsSwJDTPzpkGY4bnNMl+zn7Xe5iWzxwe+SCSBSKjr9lZzurvr37
	 SaYp1Vt/VY0u7pbHpzHkSdeMAG0Eqfje0rX6gN/JTpPqstTgXUmvGdbIDKU9q1yBCG
	 mx8Cm/sPK0DY+IaQUqQYF7jb26AqYo0dVAWZ6qt0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240321163736eucas1p2d7f86e689b06be4649dfc6b7e6fbec2c~_1PTGvAOB1319013190eucas1p2Y;
	Thu, 21 Mar 2024 16:37:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id EF.70.09814.0526CF56; Thu, 21
	Mar 2024 16:37:36 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240321163735eucas1p2b477eca3ea69e9f20da66f2d16531518~_1PSmJFi62784827848eucas1p2E;
	Thu, 21 Mar 2024 16:37:35 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240321163735eusmtrp25a471119de88e29a2bc1e915f9d66389~_1PSlZDlI2146221462eusmtrp2q;
	Thu, 21 Mar 2024 16:37:35 +0000 (GMT)
X-AuditID: cbfec7f4-727ff70000002656-01-65fc6250e76e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id ED.B5.10702.F426CF56; Thu, 21
	Mar 2024 16:37:35 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240321163735eusmtip1ab812bf977436a303030c3cbca5f70a8~_1PSbX6wf2626326263eusmtip1k;
	Thu, 21 Mar 2024 16:37:35 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 21 Mar 2024 16:37:34 +0000
Date: Thu, 21 Mar 2024 17:37:33 +0100
From: Joel Granados <j.granados@samsung.com>
To: Jan Kara <jack@suse.cz>
CC: <wenyang.linux@foxmail.com>, "Eric W . Biederman"
	<ebiederm@xmission.com>, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook
	<keescook@chromium.org>, Christian Brauner <brauner@kernel.org>, Dave Young
	<dyoung@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v2 8/9] fs: inotify: delete these unnecessary
 static variables it_zero and it_int_max
Message-ID: <20240321163733.h2qdb4j4ojr537ao@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="tgfd42bnlx4rycoi"
Content-Disposition: inline
In-Reply-To: <20240321113849.hfzmnz6p3cjbmmwt@quack3>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7djP87oBSX9SDU5cZbN4ffgTo8XlJ3wW
	DRMbWCz+b2tht5g9vZnJ4kx3rsXlXXPYLG5MeMpo0bJ6F6sDp8fshossHgt6zjN7bFrVyebx
	ft9VNo8zC46we3zeJOcx5VA7SwB7FJdNSmpOZllqkb5dAlfGtsX8BYvFKs5sn8DcwPhMqIuR
	k0NCwERib/dtti5GLg4hgRWMEt92H2MESQgJfGGUuH0iAiLxmVFiY8tadpiOG9uPM0IkljNK
	bJ0+kQWuqnfWDyhnK6PE6Y8r2UBaWARUJV6fOM0EYrMJ6Eicf3OHGcQWEZCWmHVsJVgDs8Ba
	Jom21w9YQBLCAkUScz4sZQWxeQUcJPZvPMQOYQtKnJz5BKyGWaBC4s7mV0BxDiBbWmL5Pw6Q
	MKeAqcSzZVvZIE5Vlri+bzGUXStxasstJpBdEgLrOSVu/rvLBtIrIeAi8Xu7MUSNsMSr41ug
	3pSR+L9zPlT9ZEaJ/f8+sEM4qxklljV+ZYKospZoufIEqsNRYv7/5+wQQ/kkbrwVhLiTT2LS
	tunMEGFeiY42aMCrSay+94ZlAqPyLCSfzULy2SyEzyDCOhILdn9iwxDWlli28DUzhG0rsW7d
	e5YFjOyrGMVTS4tz01OLjfJSy/WKE3OLS/PS9ZLzczcxAtPd6X/Hv+xgXP7qo94hRiYOxkOM
	KkDNjzasvsAoxZKXn5eqJMLLzv0zVYg3JbGyKrUoP76oNCe1+BCjNAeLkjivaop8qpBAemJJ
	anZqakFqEUyWiYNTqoFJrWo9m5RYfJmlpab+kZBe5t0ylSltRhJv/le2JU/h3sm9Yv7EE3uX
	3jM8Hcm9323FxqmpHb/uaFslTlzx5mx55d3Vk+sLXrEV/X/FsLfvwh2VF1Usa3hn6/A2z+2O
	9avtNeFTiur3jlBj21bzPZp/8aMv87rcTKXnWPJvldyb6eHWU2o1TzV84yeXzKTQn7c/FDKf
	sbAXsJ1k2fLdf4F+oemnmBSrbys2zDF61NyQXHBxifbDtu/bSp1qfY8tqii7uTnvZ3/RjWkz
	TCa+lJ//WfLf/f/OqfHclabzeh57L5i58POu21salMP1F89b7zaps2h/oOx8HhbTR0btHNsr
	uSM/H0697SSx6bX9fxMlluKMREMt5qLiRADjJEbR8gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsVy+t/xu7r+SX9SDVoOq1i8PvyJ0eLyEz6L
	hokNLBb/t7WwW8ye3sxkcaY71+LyrjlsFjcmPGW0aFm9i9WB02N2w0UWjwU955k9Nq3qZPN4
	v+8qm8eZBUfYPT5vkvOYcqidJYA9Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbK
	yFRJ384mJTUnsyy1SN8uQS+jcfY+toKFYhVnpv1ja2B8ItTFyMkhIWAicWP7ccYuRi4OIYGl
	jBKzfjQyQyRkJDZ+ucoKYQtL/LnWxQZR9JFR4nv/d3YIZyujxJZl15hAqlgEVCVenzgNZrMJ
	6Eicf3MHbJKIgLTErGMrWUAamAVWM0nc/XsQrEhYoEhizoelYCt4BRwk9m88BDX1B5PE7mu3
	mSASghInZz4B6uYA6i6TeL/OFcKUllj+jwOkglPAVOLZsq1sEJcqS1zftxjKrpX4/PcZ4wRG
	4VlIBs1CGDQLYRBIBbOAlsSNfy+ZMIS1JZYtfM0MYdtKrFv3nmUBI/sqRpHU0uLc9NxiI73i
	xNzi0rx0veT83E2MwKjfduznlh2MK1991DvEyMTBeIhRBajz0YbVFxilWPLy81KVRHjZuX+m
	CvGmJFZWpRblxxeV5qQWH2I0BQbiRGYp0eR8YDrKK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQS
	SE8sSc1OTS1ILYLpY+LglGpgmjV9mtFcPfFXGyu8+9daXv2nwufd2ewf2nL/1RUfYVOHnWm/
	4jXWJdqbqDpYXbp1M83f54ruO9UVfK+Xrvxw1/aSP4vAjMUcyz3mLpvDE/4z+deEtBWye076
	vs1w/X1EQrJEtn2mvuKKe+26JdMsJxtXHPpp+3Ee66XIBetSeHwVllkenCD3kyuvOPsM8/ov
	8izbNFYE9kbmis547LjcJz/6zba59SuPX9nm8Hq9trRC78/el6WVzFE2fxQKpZ8GsXR+OWwb
	nfUsnuNDWjDf1s3/GI5e9m2ZN/2ItT73nrXT1l6avOWS3TorXq27k2QmRgR/mKZeadp9iv/U
	QlPZgrKsTR4TWWck82RZc0/iUmIpzkg01GIuKk4EAJrhqjSPAwAA
X-CMS-MailID: 20240321163735eucas1p2b477eca3ea69e9f20da66f2d16531518
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

--tgfd42bnlx4rycoi
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 12:38:49PM +0100, Jan Kara wrote:
> On Thu 21-03-24 11:55:55, Joel Granados wrote:
> > On Wed, Mar 20, 2024 at 11:36:03AM +0100, Jan Kara wrote:
> > > On Tue 19-03-24 23:57:49, wenyang.linux@foxmail.com wrote:
> > > > From: Wen Yang <wenyang.linux@foxmail.com>
> > > >=20
> > > > Delete unnecessary static variables (it_zero and it_int_max)
> > > > and encode them directly in the table entry.
> > > >=20
> > > > Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
> > > > Cc: Eric W. Biederman <ebiederm@xmission.com>
> > > > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > > > Cc: Kees Cook <keescook@chromium.org>
> > > > Cc: Joel Granados <j.granados@samsung.com>
> > > > Cc: Christian Brauner <brauner@kernel.org>
> > > > Cc: Jan Kara <jack@suse.cz>
> > > > Cc: "Darrick J. Wong" <djwong@kernel.org>
> > > > Cc: linux-kernel@vger.kernel.org
> > >=20
> > > This looks as a sensible cleanup but I don't see the first patch in t=
he
> > > series (and neither it is archived at lore.kernel.org) so I cannot re=
ally
> > > verify whether your conversion is correct...
> > This was my original comment. If you want to see the cover letter
> > look for this mail ID tencent_06797E65CFC655DCD4F0414B9380E95ECC08@qq.c=
om
> >=20
> > Not sure why it separates the cover letter from the rest of the patches.
>=20
> No, that is actually a different email :) Based on lore the message ID
Indeed. I have no idea where I got that ID from. I went back and found
the one I wanted: https://lore.kernel.org/all/tencent_C5E6023F97E7CC2A046AA=
EA09BC9ACF43907@qq.com/
that one is the original V2. This one is just a resend AFAIK.

> should be:
> 26c450f6467b4cbaf94cdb10f047abc6ab0c2a5d.1710863674.git.wenyang.linux@fox=
mail.com
>=20
> but the email is not in the archive...
>=20
> 								Honza
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

--=20

Joel Granados

--tgfd42bnlx4rycoi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmX8YkwACgkQupfNUreW
QU/04wwAiSkGtJtr/aohdlb6yhJVf3rJlBoxnmwUEnuKhucDGf9NFgO1mo660rir
c6NxtH9bkjYoI4utJwt1im6wR553h/Sa4ajeAY+SbO2ACoDw8HCZ0aYtg8o+eDoE
ikpT5nGTsAKIUNxTHGjosrSI5fX2aOcngr1Jx7uHg+i9lPFo3s+g7ginQ85i42uT
t83VEY1fR3OMTeXDIMhAMz/vqXYiCuGPUN8IKakzeWiyUwxVfzp3vB6xGhhgDAlK
kLCU4AsHZM3JmotSCqKhdicrDSqYoYYhiu1J6q7RP/9V0pdVup8xQZKoGuaFfiiQ
OEbzIOjgKkypPSSSMbnzAZ7NNlLTQrD7BgkLD9j8guHPRdu1F0jHZw3Faw/BhHGp
bYlefo3sEpf5vUmot+XSRDSMl7jbq3UbynAhDB+63zdsLCEPNrUN0TbJ5xn4yLy5
YhwR+EMrv1DGOwzkQyaEU9XOLfonYxBjBeOl+6ngiZ+TQm10RIAmVeR5NO/38M46
qqwVpN3E
=MYda
-----END PGP SIGNATURE-----

--tgfd42bnlx4rycoi--

