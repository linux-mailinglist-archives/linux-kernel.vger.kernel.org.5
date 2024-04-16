Return-Path: <linux-kernel+bounces-146441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF9A8A6555
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B7AA1C21B69
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7723E84D3E;
	Tue, 16 Apr 2024 07:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BhXDmMJt"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C686A6F06D;
	Tue, 16 Apr 2024 07:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713253423; cv=none; b=au5U9wz/wFaSfH5C8GFaYCj8PIZaEeFK377Rak7BAKP0gMJo9yhwrSZF4g/jJ5rCweuXQEnbRo8/Q2DINcZRhur1QYEYDPZuQbYG4cDX0ks2ldoD4ZTE9dHRi6pxRyQYcq3AM9zuOxt+qcDBHVXvJk8xjJ58SDsTfLmqOAQ69bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713253423; c=relaxed/simple;
	bh=X1Vcw62l7Ek+/f0Ou02coxzDyic5lJOn7jwbKRTwpik=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=f6v7z2QWqwf4sLn4g5XYnTPZlL2682CM+fv+KBeZzTKlo9+KjbLryFZsWjnnQJgvdv6G3gtwd7vIo9pRgNz/Yq5pnMmwqvWYfzIEx4CKYTFjuimzSAg+i3kyQBG31Oy1oJ56/8BtdTmbEo+gTCyy2aXEDC3emgzz+TmCKxIpmQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BhXDmMJt; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240416074333euoutp028b501f50a3215b929876f5a82a270b87~Gsub_C_JP1015410154euoutp02v;
	Tue, 16 Apr 2024 07:43:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240416074333euoutp028b501f50a3215b929876f5a82a270b87~Gsub_C_JP1015410154euoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1713253413;
	bh=TjfVzkNH2Z5KdNt4ACyy65MVY1rM2cr/zaPB8/gncUk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=BhXDmMJtalOmmWs1bizsaetYno6MWRhqmCepGuIMQ6yFDPE4lOq9bDBN8ROsjwLWs
	 P62EJPQwBaudXGpqaobr9GpXASjpNFDFzkJQYut5LtHYm3yN2o8ll+fXPr4uYGNmSJ
	 OiLGWHgTsB3ZRHoPfi6O9JfUShKgugJHxmVr4/W8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240416074333eucas1p144964b20d4f24a66529c0d55255e682b~Gsubxgg543103231032eucas1p1U;
	Tue, 16 Apr 2024 07:43:33 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 85.9F.09875.52C2E166; Tue, 16
	Apr 2024 08:43:33 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240416074332eucas1p2c852836fdfd1e657ad07543470707438~GsubXKTC71567315673eucas1p2a;
	Tue, 16 Apr 2024 07:43:32 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240416074332eusmtrp10dfb97e61dc7b1435894b6674c0ad762~GsubWknVC0396403964eusmtrp1W;
	Tue, 16 Apr 2024 07:43:32 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-bc-661e2c25eea2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 80.60.08810.42C2E166; Tue, 16
	Apr 2024 08:43:32 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240416074332eusmtip105bd2f00b401e492ecfb0833a65f6f3f~GsubLmB1_0992609926eusmtip1B;
	Tue, 16 Apr 2024 07:43:32 +0000 (GMT)
Received: from localhost (106.210.248.128) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 16 Apr 2024 08:43:32 +0100
Date: Tue, 16 Apr 2024 09:43:27 +0200
From: Joel Granados <j.granados@samsung.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing
	List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the sysctl tree
Message-ID: <20240416074327.ran3jwdrcp4gz67u@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="opc3ici7b5eccz64"
Content-Disposition: inline
In-Reply-To: <20240416085831.51b372a3@canb.auug.org.au>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7djP87qqOnJpBidPsFqc6c61uLxrDpvF
	wYVtjBY3JjxltNi69yq7A6tH440bbB6zGy6yeGxa1cnm8XmTXABLFJdNSmpOZllqkb5dAlfG
	gc17WQqOcFV8bXvE3MC4i7OLkZNDQsBEovvKLJYuRi4OIYEVjBI90+YzQzhfGCX+bHrPCOF8
	ZpQ41vSSFablzrsWJojEckaJm98Os4AkwKoOfrOESGxllJg0/TNQgoODRUBVYvFZV5AaNgEd
	ifNv7jCDhEUEtCUO/BYAKWcW2M8ocXnzU3aQGmEBH4m7u/vYQGxeAQeJM5MeskPYghInZz4B
	28UsUCHxqKkRbA6zgLTE8n8cIGFOAXOJY/2v2CDuVJZoerQE6uZaiVNbboHdLCHQzCnRt/Ey
	C0TCReLvlTWMELawxKvjW9ghbBmJ05N7WCAaJjNK7P/3gR3CWc0osazxKxNElbVEy5UnUB2O
	EqseHmMFuUhCgE/ixltBiEP5JCZtm84MEeaV6GgTgqhWk1h97w3LBEblWUhem4XktVkIr0GE
	dSQW7P7EhiGsLbFs4WtmCNtWYt269ywLGNlXMYqnlhbnpqcWG+WllusVJ+YWl+al6yXn525i
	BKaq0/+Of9nBuPzVR71DjEwcjIcYVYCaH21YfYFRiiUvPy9VSYS3RVg2TYg3JbGyKrUoP76o
	NCe1+BCjNAeLkjivaop8qpBAemJJanZqakFqEUyWiYNTqoGpTN6G7VnPN9P0Vvfq2KppZ7/Z
	1GU+XdJ4QWBN1ZuO1NSzR3aVip5S8zyplbTYrbJRcqtOkf2mNTtbmQ4HFW+ue3tKfJ+ZhdpU
	vZp/8za/WbVTXmbZkjsaYXpGsjFnP030+f43/cbDmTFbwp3PF4TfunM/rSL4e0PXrj18744k
	zJ+tJn2gbGVWxpE8zc+K1eUP5rQtfrjVOt161+czZ6JX/VP7Wxr3QE8o80mSX8ykXxE73qtv
	FBE6MOuRaJnwsW0LrkmHF/ycZ9+p1SFn0yWqvNAwLerO3hVtGu/qP8wzmvur/HvZeYaqSU5n
	OFwvFHMqFqTtnZj7UVt24U2uwz++KM7vZ6+4x7MnR+Uk36srSizFGYmGWsxFxYkA1zQt4NAD
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsVy+t/xu7oqOnJpBquXa1mc6c61uLxrDpvF
	wYVtjBY3JjxltNi69yq7A6tH440bbB6zGy6yeGxa1cnm8XmTXABLlJ5NUX5pSapCRn5xia1S
	tKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7GsiM6BYe4Kl5tb2NsYNzB2cXI
	ySEhYCJx510LUxcjF4eQwFJGid83dzBCJGQkNn65ygphC0v8udbFBlH0kVFixoUdLBDOVkaJ
	lTPmAlVxcLAIqEosPusK0sAmoCNx/s0dZpCwiIC2xIHfAiDlzAL7GSV2NfxlA6kRFvCRuLu7
	D8zmFXCQODPpITvEzC5GiUc/jjNDJAQlTs58wgJiMwuUSZw+94ENZCizgLTE8n8cIGFOAXOJ
	Y/2v2CAOVZZoerQE6uhaic9/nzFOYBSehWTSLCSTZiFMgghrSdz495IJQ1hbYtnC18wQtq3E
	unXvWRYwsq9iFEktLc5Nzy021CtOzC0uzUvXS87P3cQIjNdtx35u3sE479VHvUOMTByMhxhV
	gDofbVh9gVGKJS8/L1VJhLdFWDZNiDclsbIqtSg/vqg0J7X4EKMpMBAnMkuJJucDE0leSbyh
	mYGpoYmZpYGppZmxkjivZ0FHopBAemJJanZqakFqEUwfEwenVAOT1cGbN65z66QuvFB6bYGT
	jeXqxzUfj12VCZywdmJwXYGMjof+NsW1Ez5+KsnxPtekVxRbxfrk/De7tbu6NRd2lUpIeMdH
	7/nhpVOhYslWbvvjrcg7QdN1r5Unz47MWutz4Xqxn+EDHT65F1KLQtWEZz99GDn3VfH+4+cd
	FlRb9q6aOfN+WoLNAtFM56/5RwRTZ69ttUq6VCUkaSSimHqtop+vz/uw2Hah+R9OsM1q3iVk
	sFoydNelO8aSj9QL9FomrH+jeVD8mdVUS0N/94a4byH/Ow3yT++S09p1/mSmbmjL5aVH+7Xb
	1pXZCd+Y87L83ONbzpaHtp8zeclu/vCSzDmuaR+yHp9w91Cdu22/EktxRqKhFnNRcSIAN10A
	XGwDAAA=
X-CMS-MailID: 20240416074332eucas1p2c852836fdfd1e657ad07543470707438
X-Msg-Generator: CA
X-RootMTR: 20240415225837eucas1p1ebba36eabbb4ccbd2693ee5dc2b744af
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240415225837eucas1p1ebba36eabbb4ccbd2693ee5dc2b744af
References: <CGME20240415225837eucas1p1ebba36eabbb4ccbd2693ee5dc2b744af@eucas1p1.samsung.com>
	<20240416085831.51b372a3@canb.auug.org.au>

--opc3ici7b5eccz64
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 08:58:31AM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> Commits
>=20
>   693d33b8fc7e ("sysctl: treewide: constify argument ctl_table_root::perm=
issions(table)")
>   e423195d7930 ("sysctl: treewide: drop unused argument ctl_table_root::s=
et_ownership(table)")
>=20
> are missing a Signed-off-by from their committer.
oops!. My bad. Let me fix that.

Best
--=20

Joel Granados

--opc3ici7b5eccz64
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmYeLB4ACgkQupfNUreW
QU/29wv/dY7znnWSddBJrrmeAPH1kYWxi/+sEW94ZbnWb44cFMaesktxkrQiWjCm
/Lb4fn/XHMm5np+pz/B5ZAOWlvY9wWLiYYclk8Qjevpj1mETlOnwblmDA1z0Li5u
3AxXiRomqhe+rdhsHZewtahFfzWJ8AIGnFIXU0w2NrEIms4FnFr24+aevSsFge5O
m0B6U1RhHpIEo5Zluljmam4q5LxPRBqt6jKWwosd5jIDNys7ifVXXblaqSJTCWbM
MbcbEiPCwJqD24SEXxoSRGW0wkRHnarIs3w3j5XMbmQ/HbnDVJET6Uc1avtmLqg2
dpVh7UJCXTYN3L9Z+cxVCzbvhpMwDXxlVdoZFD7qC0hShZhfo/spv7Tsvp1nBzol
WvxM1EA1MYhvHjKX0e5ra42yE7nGanPeh1ZfSWSfjmjLY/BK3ULkCzMcpjXNgHGC
L52ltJG/lGtJsCERMy4f9qc9/7X1I2tXy8frAgO1Sjfr0pWDU+mc6vcL8jHRRjMf
WE1Fat0y
=Odlp
-----END PGP SIGNATURE-----

--opc3ici7b5eccz64--

