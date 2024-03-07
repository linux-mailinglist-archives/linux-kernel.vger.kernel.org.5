Return-Path: <linux-kernel+bounces-95435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B08D2874D9A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFCB11C20D9E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0687E12839C;
	Thu,  7 Mar 2024 11:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JZ1PU5hf"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0561412D77D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 11:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811300; cv=none; b=NXxGIYcZQQ9yBnqX2kN1n8iL4IMbNmNlioqOV369YE9Ol5RGWir1pdBLmbjcGEKqAR9rxzZIHLkt4gfCqQjW845gLCJDVWnWtuzf0ZRmwAoyzMcX0JzcH/tdUXtCJkHqFmVAF5QT9lr885OUmaOlTrriKDkE605j1na1PHScOlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811300; c=relaxed/simple;
	bh=77XpPWrRcZ1uwK/G6uNa4Y7IvqsXg6FOPc+MNvtcQtI=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=Nj5mY7fxFO8XR91/565oKCK7L4x7CWDj60MT3XQtpORLtt16enH0WYpQ0KssPOpkTcv/56A7ZMHN9uFL5SndC/3N+wzcFF6F8etgP0v7Pkqd4J8cUwx0mbAM4CNUp1ZaRo8qhAUcKqFCWFIzlt3ep1lZef6FaCLBDDw0VIlRg28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JZ1PU5hf; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240307113454epoutp03f0c563e4057892afeb174b1bbb1b066a~6eFBHTLta0242002420epoutp035
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 11:34:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240307113454epoutp03f0c563e4057892afeb174b1bbb1b066a~6eFBHTLta0242002420epoutp035
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1709811294;
	bh=77XpPWrRcZ1uwK/G6uNa4Y7IvqsXg6FOPc+MNvtcQtI=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=JZ1PU5hfFXfnp/vi8Tv2laQ/9et5B7CqDbgJQF6o2wkxIBDCUwhhGS2j1vfiJU/8X
	 PyLgfhopVeq6dA1UHUiMSnXOEpx9yXc/t8qNDn1kYQxclnHI5P4RpGog8U5ZmNDuP7
	 TCrpbnC+AM1X0CtC3xvQWBcDcdqsKOG/g755EVUM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240307113453epcas1p2af1e9447d1c7e65dd803fc35aac6bab5~6eFAO572p3272332723epcas1p2W;
	Thu,  7 Mar 2024 11:34:53 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.144]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Tr6fN6FV0z4x9Ps; Thu,  7 Mar
	2024 11:34:52 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	50.3E.08572.C56A9E56; Thu,  7 Mar 2024 20:34:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240307113452epcas1p1b47c88707a532705d73aa2c529174fc9~6eE-Fy-Au0265402654epcas1p1L;
	Thu,  7 Mar 2024 11:34:52 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240307113452epsmtrp2ac873d5a3345563338b7d71cc3e9b324~6eE-FJi_f2329823298epsmtrp2k;
	Thu,  7 Mar 2024 11:34:52 +0000 (GMT)
X-AuditID: b6c32a33-f5ffd7000000217c-3f-65e9a65c281b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3D.BE.07368.C56A9E56; Thu,  7 Mar 2024 20:34:52 +0900 (KST)
Received: from cw00choi03 (unknown [10.113.111.106]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240307113452epsmtip1a457b4c443598acf5acb4a4e455908d3~6eE_1GoxW2774127741epsmtip1U;
	Thu,  7 Mar 2024 11:34:52 +0000 (GMT)
From: "Chanwoo Choi" <cw00.choi@samsung.com>
To: =?utf-8?Q?'Uwe_Kleine-K=C3=B6nig'?= <u.kleine-koenig@pengutronix.de>,
	"'MyungJoo Ham'" <myungjoo.ham@samsung.com>
Cc: <linux-kernel@vger.kernel.org>, "'Krzysztof Kozlowski'"
	<krzysztof.kozlowski@linaro.org>, "'Benson Leung'" <bleung@chromium.org>,
	"'Guenter Roeck'" <groeck@chromium.org>, <chrome-platform@lists.linux.dev>
In-Reply-To: <cover.1708876186.git.u.kleine-koenig@pengutronix.de>
Subject: RE: [PATCH 0/7] extcon: Convert to platform remove callback
 returning void
Date: Thu, 7 Mar 2024 20:34:52 +0900
Message-ID: <000001da7083$78636ee0$692a4ca0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJTuJl05+ZysO5I9S1ypzFKCpFyLADjHTzlsDJ8rSA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmnm7MspepBp1vDCymP7nMYvF22TxG
	i1OvljFb7H29ld3i8q45bBa3G1cAiYmTGR3YPWY3XGTxuHNtD5vHi80zGT36/xp49G1Zxejx
	eZNcAFtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO
	0ClKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALTAr3ixNzi0rx0vbzUEitDAwMj
	U6DChOyMCy2PmAoeiVc8/trC3MDYK97FyMkhIWAiceTcAdYuRi4OIYEdjBJX7i5ggnA+MUrM
	nH+AEcL5xiix7eVqNpiWlh0nWCASexklvnx+xgbhvGSUePrsJdAwDg42AR2JBT9CQRpEBMol
	/vcsBxvLLHCFUaJt9QNGkASngJPE9I6bYFOFBUIlNj6fwwJiswioSOzuP8wOYvMKWEpsmtjI
	BmELSpyc+QSshllAW2LZwtfMEBcpSPx8uowVYpmVxPzNa9ggakQkZne2MYMslhCYyyFx8NRU
	JogGF4nnj1awQ9jCEq+Ob4GypSQ+v9vLBtEwmVHi4uvXUN3rGSU2rmyBWmcssX/pZCaQN5kF
	NCXW79KH2MYn8e5rD9j3EgK8Eh1tQhDVyhKXH9yF2ispsbi9kw2ixEOi4XfiBEbFWUhem4Xk
	tVlIXpiFsGsBI8sqRrHUguLc9NRkwwJDeHQn5+duYgSnUy3jHYyX5//TO8TIxMF4iFGCg1lJ
	hJfF4mWqEG9KYmVValF+fFFpTmrxIUZTYGBPZJYSTc4HJvS8knhDE0sDEzMjYxMLQzNDJXHe
	M1fKUoUE0hNLUrNTUwtSi2D6mDg4pRqYVop3e85Xdez6sEJMWPqtybY77+2YJqtVT7j08HLf
	E7ldC7ettXTclrNbbeGLrazBv3ROXOhYdP7/sYVzmD8sFbSL42M+Vfoi/FnPaoWHZxJlVp50
	SvMWCvj+rWl6R3Hq4pZVGcGP3yYLl210TLLyf1+dK3i99NXR2PVT8/zNzhtXWMSc8z2yef9q
	sZLZX86//LbiWKTZHlk5u4ciLeuzNt14O/d766aSs5umnu4QPbly1jvNqNMdZw1yFNmy3+/d
	nHHkst3r69Iym6pup9V1RunEft/+ev3KIn7eg1ezuTl8eWZVc/06kdi+jpPxTPMHm/jZu3Va
	nBQuCXuFPLi+2czndFHfxnW2m8tL1tsvmqDEUpyRaKjFXFScCAAP3kwjMAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJTjdm2ctUg6efpSymP7nMYvF22TxG
	i1OvljFb7H29ld3i8q45bBa3G1cAiYmTGR3YPWY3XGTxuHNtD5vHi80zGT36/xp49G1Zxejx
	eZNcAFsUl01Kak5mWWqRvl0CV8brxpPsBZMEK/5/OMnUwNjL18XIySEhYCLRsuMESxcjF4eQ
	wG5GielXe9kgEpIS0y4eZe5i5ACyhSUOHy4GCQsJPGeUaJnjBxJmE9CRWPAjFCQsIlAu8b9n
	ORPIGGaBG4wSs888YIKYOZlR4tW3FSwgVZwCThLTO26CzRcWCJZ4ceIdI4jNIqAisbv/MDuI
	zStgKbFpYiMbhC0ocXLmE7BeZgFtiac3n8LZyxa+Zoa4U0Hi59NlrBBXWEnM37yGDaJGRGJ2
	ZxvzBEbhWUhGzUIyahaSUbOQtCxgZFnFKJlaUJybnptsWGCYl1quV5yYW1yal66XnJ+7iREc
	VVoaOxjvzf+nd4iRiYPxEKMEB7OSCC+LxctUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryGM2an
	CAmkJ5akZqemFqQWwWSZODilGpiezLOLmF7P0X3uwN1ooz5180OiR9fsOq/4yzbrH2/QtMfL
	3MvrLol8PRraPbuGn7/8XcjV21NP2i+YeH3tyeKvb5vuXFOK9mWLb1S2cLF95MrBoXKIqZPF
	Q2ZDV+WHbdan7myVZVhnPKfk67vTO7pEXnV03PP70Zi6/0n/QqlHy3mrhLf+zf265pBbqcZh
	Pp81Lev3J/h5a01wYX4j4ZX03f2s8X7hq39Up7R9dtJsfHDYhWHGLi+WqX0TPFUnvlcyftCa
	F3x4QdPxz/ev/ng0+ZqgvaCHlPR/Z+1mpyK+acpfOtYESGfwVovMf2x3sz6AWXH3jdxvkq+m
	BicKf+uvCuA33nKbW+H8KeUDM1uUWIozEg21mIuKEwEMhZugGQMAAA==
X-CMS-MailID: 20240307113452epcas1p1b47c88707a532705d73aa2c529174fc9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240225161430epcas1p371a4ee6a088b0121092af5064d56bc16
References: <CGME20240225161430epcas1p371a4ee6a088b0121092af5064d56bc16@epcas1p3.samsung.com>
	<cover.1708876186.git.u.kleine-koenig@pengutronix.de>



> -----Original Message-----
> From: Uwe Kleine-K=C3=B6nig=20<u.kleine-koenig=40pengutronix.de>=0D=0A>=
=20Sent:=20Monday,=20February=2026,=202024=2012:55=20AM=0D=0A>=20To:=20Myun=
gJoo=20Ham=20<myungjoo.ham=40samsung.com>;=20Chanwoo=20Choi=0D=0A>=20<cw00.=
choi=40samsung.com>=0D=0A>=20Cc:=20linux-kernel=40vger.kernel.org;=20Krzysz=
tof=20Kozlowski=0D=0A>=20<krzysztof.kozlowski=40linaro.org>;=20Benson=20Leu=
ng=20<bleung=40chromium.org>;=20Guenter=0D=0A>=20Roeck=20<groeck=40chromium=
org>;=20chrome-platform=40lists.linux.dev=0D=0A>=20Subject:=20=5BPATCH=200=
/7=5D=20extcon:=20Convert=20to=20platform=20remove=20callback=20returning=
=0D=0A>=20void=0D=0A>=20=0D=0A>=20Hello,=0D=0A>=20=0D=0A>=20this=20series=
=20converts=20all=20drivers=20below=20drivers/extcon=20to=20struct=0D=0A>=
=20platform_driver::remove_new().=20See=20commit=205c5a7680e67b=20(=22platf=
orm:=0D=0A>=20Provide=20a=20remove=20callback=20that=20returns=20no=20value=
=22)=20for=20an=20extended=20explanation=0D=0A>=20and=20the=20eventual=20go=
al.=0D=0A>=20=0D=0A>=20All=20conversations=20are=20trivial,=20because=20the=
ir=20.remove()=20callbacks=20returned=0D=0A>=20zero=20unconditionally.=0D=
=0A>=20=0D=0A>=20There=20are=20no=20interdependencies=20between=20these=20p=
atches,=20so=20they=20could=20be=20picked=0D=0A>=20up=20individually.=20But=
=20I'd=20hope=20that=20they=20get=20picked=20up=20all=20together=20by=20the=
=0D=0A>=20extcon=20maintainer=20team.=0D=0A>=20=0D=0A>=20Best=20regards=0D=
=0A>=20Uwe=0D=0A>=20=0D=0A>=20Uwe=20Kleine-K=C3=B6nig=20(7):=0D=0A>=20=20=
=20extcon:=20adc-jack:=20Convert=20to=20platform=20remove=20callback=20retu=
rning=20void=0D=0A>=20=20=20extcon:=20intel-cht-wc:=20Convert=20to=20platfo=
rm=20remove=20callback=20returning=20void=0D=0A>=20=20=20extcon:=20intel-mr=
fld:=20Convert=20to=20platform=20remove=20callback=20returning=20void=0D=0A=
>=20=20=20extcon:=20max3355:=20Convert=20to=20platform=20remove=20callback=
=20returning=20void=0D=0A>=20=20=20extcon:=20max77843:=20Convert=20to=20pla=
tform=20remove=20callback=20returning=20void=0D=0A>=20=20=20extcon:=20usb-g=
pio:=20Convert=20to=20platform=20remove=20callback=20returning=20void=0D=0A=
>=20=20=20extcon:=20usbc-cros-ec:=20Convert=20to=20platform=20remove=20call=
back=20returning=20void=0D=0A>=20=0D=0A>=20=20drivers/extcon/extcon-adc-jac=
k.c=20=20=20=20=20=7C=206=20++----=0D=0A>=20=20drivers/extcon/extcon-intel-=
cht-wc.c=20=7C=206=20++----=20=20drivers/extcon/extcon-=0D=0A>=20intel-mrfl=
d.c=20=20=7C=206=20++----=0D=0A>=20=20drivers/extcon/extcon-max3355.c=20=20=
=20=20=20=20=7C=206=20++----=0D=0A>=20=20drivers/extcon/extcon-max77843.c=
=20=20=20=20=20=7C=206=20++----=0D=0A>=20=20drivers/extcon/extcon-usb-gpio.=
c=20=20=20=20=20=7C=206=20++----=0D=0A>=20=20drivers/extcon/extcon-usbc-cro=
s-ec.c=20=7C=206=20++----=0D=0A>=20=207=20files=20changed,=2014=20insertion=
s(+),=2028=20deletions(-)=0D=0A>=20=0D=0A=0D=0AApplied=20them.=20Thanks.=0D=
=0A=0D=0ABest=20Regards,=0D=0AChanwoo=20Choi=0D=0A=0D=0A=0D=0A

