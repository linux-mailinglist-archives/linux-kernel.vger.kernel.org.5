Return-Path: <linux-kernel+bounces-110151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBB2885AD4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDFC31F234A3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9E686254;
	Thu, 21 Mar 2024 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Fqt1R7IU"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E9D84A4E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711031342; cv=none; b=Z2jJ/hxoAEV99co/1joyxdvmoLsXA8qoukEF2IibRIXiujETD3BrmjKHvTcA6ySBKzgUa8K57L/pAievw7iHn47lpVVJ/0wuns7lUBwV6Vpk4SORtoxXaXNMSjhgb7pwAWpMDivhdQP3ZHAvkPl2rfP7LjrqisJSetoApOwbYLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711031342; c=relaxed/simple;
	bh=v+xOyKjeU5rktvRgco68fNb6UlXYyNsjO9f6LvYOvHA=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=ioLVYcT/9MfUdYFB2BqeuUdd9UJBjW9yYzTrqt9iUh9n7MCQDpkqulE11HVhqS5UBPVpevc7ghUx/2uUZ2EPtbmhtZFE9V3DiRB75PRAF9owLscsmVWBUXRPJrE30WqCBmtFoN35a/amljys5I/RSalY9SubTyM1cTyqKEfhXsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Fqt1R7IU; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240321142851euoutp01ef543ca11c314d7bbb8e485580c6f7ec~_ze5AhtH91723517235euoutp01B;
	Thu, 21 Mar 2024 14:28:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240321142851euoutp01ef543ca11c314d7bbb8e485580c6f7ec~_ze5AhtH91723517235euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1711031331;
	bh=WlR7t/ZFKS6OjGYjMpOV4h/ihJmeFKSCx/COvD0pVMg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Fqt1R7IUWnMBAGTZUdzwcwtXahP8Rr/PVmd44D+AE3mfaZBC98ZInZ76ZW2FzmOFG
	 v4SdE/4Zloqo+Kz+OJhJtNu3hqNEr/jRxAFBixSyWOUX3ktctH+wDR0yd+pJtqNvui
	 pOGiK31l/CGoMZAzot6kG9r8SKkZr4AMP2nkVdfY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240321142851eucas1p216e6cb9973e59a3ddfd6346d71e2dcff~_ze4xvCOA1852118521eucas1p2f;
	Thu, 21 Mar 2024 14:28:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id F8.18.09552.3244CF56; Thu, 21
	Mar 2024 14:28:51 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240321142850eucas1p1abb6869b4b30dc128e0f54ecfa7e56a8~_ze4ScEwo2307023070eucas1p1B;
	Thu, 21 Mar 2024 14:28:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240321142850eusmtrp219a72be70ad37d87b225023dd8db4594~_ze4RwsoY0424704247eusmtrp21;
	Thu, 21 Mar 2024 14:28:50 +0000 (GMT)
X-AuditID: cbfec7f5-83dff70000002550-44-65fc4423a1e2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 0A.82.10702.2244CF56; Thu, 21
	Mar 2024 14:28:50 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240321142850eusmtip11a853c02413adef14b05cd1c229d0b73~_ze4GR7W11382813828eusmtip1b;
	Thu, 21 Mar 2024 14:28:50 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 21 Mar 2024 14:28:50 +0000
Date: Thu, 21 Mar 2024 15:28:48 +0100
From: Joel Granados <j.granados@samsung.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: <wenyang.linux@foxmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Kees
	Cook <keescook@chromium.org>, Christian Brauner <brauner@kernel.org>,
	<davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Shuah Khan <skhan@linuxfoundation.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/8] ucounts: delete these duplicate static variables
 ue_zero and ue_int_max
Message-ID: <20240321142848.qh4jsp5j2ict2ar3@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="lwua24korejtob7w"
Content-Disposition: inline
In-Reply-To: <875xyczpzm.fsf@email.froward.int.ebiederm.org>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7djPc7rKLn9SDe7u57d4ffgTo8Wc8y0s
	Fut2tTJZ/N/Wwm7x9Ngjdosz3bkWF7b1sVpc3jWHzeLGhKeMFt9Ov2G02Dt9GatFy+pdrA48
	HrMbLrJ4bFl5k8ljQc95Zo8Fm0o9Nq3qZPPYP3cNu8f7fVfZPD5vkvOYcqidJYAzissmJTUn
	syy1SN8ugSvj6+2igulCFfdafzI1MG7k72Lk5JAQMJG48m41YxcjF4eQwApGiYMzrrJAOF8Y
	JaYdXcYO4XxmlDj9ezEjTMuRlYfYIBLLGSXOt31ghKuaMm8DM4SzlVHi192pTCAtLAKqEnee
	PWUHsdkEdCTOv7nDDGKLCOhL3Hw/iQ3EZhZoYpZ4vQvsKmGBJIkFj1aC1fMKOEhsv3mAEcIW
	lDg58wkLRH2FxOzv24FsDiBbWmL5Pw6QMKeAjcSKJXfYIS5Vlri+bzEbhF0rcWrLLSaQ2yQE
	rnFKnOi4A5Vwkbj7fR6ULSzx6vgWqGYZif8750M1TGaU2P/vAzuEs5pRYlnjVyaIKmuJlitP
	oDocJXbdeQ12kYQAn8SNt4IQh/JJTNo2nRkizCvR0SYEUa0msfreG5YJjMqzkLw2C8lrsxBe
	gwjrSCzY/YkNQ1hbYtnC18wQtq3EunXvWRYwsq9iFE8tLc5NTy02zkst1ytOzC0uzUvXS87P
	3cQITJGn/x3/uoNxxauPeocYmTgYDzGqADU/2rD6AqMUS15+XqqSCC87989UId6UxMqq1KL8
	+KLSnNTiQ4zSHCxK4ryqKfKpQgLpiSWp2ampBalFMFkmDk6pBibzxPqdPmc+OO/lbbkW7hGj
	OffchLMtc5SfeGiL1eXNrOQ5WZwxcb/p5e1ZN86++OktWDhBq++xW2ZWlur8FQpVrRvue3c9
	tE8/kt7BKJa7tj1RjCcjYZanSNFCv/chxV/v9l9b/v1a2oqtGSHnb3QsKliUd1r3xKe86SVW
	Fxtsr4XOuvhztceuU0/u71/18dEntg/bgyTMhXatmPvF/fKNaftXzVB93Pe2Oc9MxW7yzLcO
	YSqXlczD77buCy3X7d175ku77KRq6c8bnvy/+4lHklHpKOdhwbsWzLZT9+3tSO2eEHtShbH1
	WFuIk46+9a33CsvN8j8v9q2w53P/ZtW2cHeUiLyyIsO6ehMz6XQlluKMREMt5qLiRADHb3xL
	DAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsVy+t/xu7pKLn9SDTrf6Vm8PvyJ0WLO+RYW
	i3W7Wpks/m9rYbd4euwRu8WZ7lyLC9v6WC0u75rDZnFjwlNGi2+n3zBa7J2+jNWiZfUuVgce
	j9kNF1k8tqy8yeSxoOc8s8eCTaUem1Z1snnsn7uG3eP9vqtsHp83yXlMOdTOEsAZpWdTlF9a
	kqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJex/8I7poKpQhV/
	d19lb2Bcz9/FyMkhIWAicWTlIbYuRi4OIYGljBL3JjSwQyRkJDZ+ucoKYQtL/LnWBVX0kVGi
	d0MXC4SzlVFiHdDxIFUsAqoSd549BetmE9CROP/mDjOILSKgL3Hz/SQ2EJtZoIlZ4sLfShBb
	WCBJYsGjlWD1vAIOEttvHmCEGPqXUWLnrvUsEAlBiZMzn7BANJdJtJ65DzSIA8iWllj+jwMk
	zClgI7FiyR2oq5Ulru9bzAZh10p8/vuMcQKj8Cwkk2YhmTQLYRJEWEvixr+XTBjC2hLLFr5m
	hrBtJdate8+ygJF9FaNIamlxbnpusZFecWJucWleul5yfu4mRmCi2Hbs55YdjCtffdQ7xMjE
	wXiIUQWo89GG1RcYpVjy8vNSlUR42bl/pgrxpiRWVqUW5ccXleakFh9iNAWG4kRmKdHkfGAK
	yyuJNzQzMDU0MbM0MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRqYBKYbHpQ2NvGYbLG
	tpUP/5zv+KtpFba8Sc996f9Gpw/+iY9+2vPfrXhSMuPADvuPTccP9khs5PNMLzqd9GZn9OwP
	XMJcE5IvfWiuTxXdr/vpvmhBVu3XO32O+1yPM83IO7n8Vt3RrqOPZzW8YGq1+X42pHThmutr
	5Wcdnfwnnj1vd/fSC9r/vh9JZdw0syl8jXKoidmquzOjmSZliaafvBC0kvP9A9ldfUnHYop9
	tQ9e9YqpXTT/UL6TfvgZR/3vhQe+CsqpzO07tEFVvPEye93C3euOHr141/dtlbiI+uaHXS7h
	D9LvVjiYzRC99P93uIyfBQ9D5ndD+flhDye61yreDOZzT1pucy1mpfDGwholluKMREMt5qLi
	RAA+0vqcqQMAAA==
X-CMS-MailID: 20240321142850eucas1p1abb6869b4b30dc128e0f54ecfa7e56a8
X-Msg-Generator: CA
X-RootMTR: 20240225123015eucas1p2e13b3b1eb009f5d30e662fee25515b1d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240225123015eucas1p2e13b3b1eb009f5d30e662fee25515b1d
References: <20240225040538.845899-1-wenyang.linux@foxmail.com>
	<tencent_AA60553AD4DF41859328E9CACC367EFDCF08@qq.com>
	<CGME20240225123015eucas1p2e13b3b1eb009f5d30e662fee25515b1d@eucas1p2.samsung.com>
	<875xyczpzm.fsf@email.froward.int.ebiederm.org>

--lwua24korejtob7w
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 06:29:33AM -0600, Eric W. Biederman wrote:
> wenyang.linux@foxmail.com writes:
>=20
> > From: Wen Yang <wenyang.linux@foxmail.com>
> >
> > Since these static variables (ue_zero and ue_int_max) are only used for
> > boundary checks and will not be changed, remove it and use the ones in
> > our shared const array.
>=20
> What happened to the plans to kill the shared const array?
I agree with removing sysctl_vals. I wanted to get more info but was not
able to find much in lore.kernel.org. I was wondering if the push
towards removing it had been discussed in the lists? Or was it more like
a conference hallway discussion?

Best
>=20
> You can still save a lot more by turning .extra1 and .extra2
> into longs instead of keeping them as pointers and needing
> constants to be pointed at somewhere.
>=20
> As I recall the last version of this actually broke the code,
> (but not on little endian).
>=20
> This one if the constants are properly named looks better
> than that, but I don't see any reason why you want shared
> constants for such a handful of things.  Especially when
> it has proven to be error prone in the past.
>=20
> The only people I can see who find a significant benefit by
> consolidating all of the constants into one place are people who know
> how to stomp kernel memory.
>=20
> Eric
>=20

--=20

Joel Granados

--lwua24korejtob7w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmX8RB8ACgkQupfNUreW
QU9fSgwAlbWex7MGOQ7kR1UgahM25aVbA4W6xidoG8TRcCy2hWHTfvVx88Jv8c9n
nxUe00W5BJwV6cgalwrqD0X/YOCsJQfH1TvWqdJB25LzqmrQdm/PKaHAWu5j7jAt
k8RTQdGh/X9PNwuf1P+yatuemBkHbJmAfDYt+bHf+8+rmz+iJn5MPFiysRfy3u7w
SLkHLg1xZqydT++WXQ6ZnDY0L5InVGxo/ZjpYuG27zxQdCa/ngt7fp0tVAzJB9+K
u9DnMtR3c8SRRpB/ClmeZuDma7ayom+hVG5Gyjxocm9mnwuZ2wYssgKhOPnx3ufC
M21PiqKgxdcgNmo+ma2E/biEn3WDwGFi1q1LzZUsEwp4CIbpcWg5+Gq4wFEn8MgZ
GgDPIyNHN91Kp3ZcdTqH54/iv+S3zdMzQc0C4SEo1EJHGT+0iSPvM7/Fog90kqbK
mhFOrh6B6kMIEyyiUa40UVeXzWHDhAMribxCihfE2tno4x2RRrdEOxOXcXmoFwJ+
M/lAdy8p
=F3Hy
-----END PGP SIGNATURE-----

--lwua24korejtob7w--

