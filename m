Return-Path: <linux-kernel+bounces-11808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B3681EBF0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 04:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF2C28347E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 03:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8483C2C;
	Wed, 27 Dec 2023 03:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YAQVPq9O"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55253290D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 03:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231227035020epoutp025708566e241bb779c46d426e03e7253a~kk8HuZ25p1472014720epoutp02d
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 03:50:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231227035020epoutp025708566e241bb779c46d426e03e7253a~kk8HuZ25p1472014720epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703649020;
	bh=X/SHZHgq/5cI4VAINc2siN4jX/34DzokarP9pIXKC+A=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=YAQVPq9OcfgPN+EY+oN2DgTzFSd5uuYKyo6l43hg/2S/vaHVO+/yGOPLftj55rnSr
	 y6A8jfQgMVVpMtY9cUNcNQVlUFNlRZQK6Lb+pMgQgt/Ej5/o4YQQnucCUUe2h0IxHv
	 wu//yIzeFKN2N5gWRG9/R7/ededIjGBq4tkHJvv4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20231227035019epcas5p1d4b5d03e0396f31931141858c6ff15ee~kk8G-NQQ33087230872epcas5p1t;
	Wed, 27 Dec 2023 03:50:19 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4T0Hj61T2wz4x9Pr; Wed, 27 Dec
	2023 03:50:18 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F5.C3.09634.9FE9B856; Wed, 27 Dec 2023 12:50:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20231226170509epcas5p1b6ee8be540b10806a21b219c71e3a73f~kcIzLe9KF0531105311epcas5p1Y;
	Tue, 26 Dec 2023 17:05:09 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231226170509epsmtrp2153ac11e493df950035d0485eb5d6c6c~kcIzKjIAj2371823718epsmtrp24;
	Tue, 26 Dec 2023 17:05:09 +0000 (GMT)
X-AuditID: b6c32a49-eebff700000025a2-81-658b9ef943a8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C0.18.08817.4C70B856; Wed, 27 Dec 2023 02:05:08 +0900 (KST)
Received: from FDSFTE353 (unknown [107.122.81.138]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20231226170505epsmtip2c079b1f29a6a0d45be88eb8c21ce93ea~kcIwK_dwp2649426494epsmtip2O;
	Tue, 26 Dec 2023 17:05:05 +0000 (GMT)
From: "Varada Pavani" <v.pavani@samsung.com>
To: "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <s.nawrocki@samsung.com>,
	<tomasz.figa@gmail.com>
Cc: <linux-samsung-soc@vger.kernel.org>, <alim.akhtar@samsung.com>,
	<aswani.reddy@samsung.com>, <pankaj.dubey@samsung.com>
In-Reply-To: <58ded02d-a5d2-40e2-b575-dc520a7553cf@linaro.org>
Subject: RE: [PATCH 2/2] clk: samsung: Fix typo error and extra space
Date: Tue, 26 Dec 2023 22:35:02 +0530
Message-ID: <003e01da381d$ae1b4240$0a51c6c0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFsxK7RdokujwAzSMTQjk1EP/EpaQHEAApqAU39SO8CArAB6bFuCobQ
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEJsWRmVeSWpSXmKPExsWy7bCmuu6ved2pBvdOMls8mLeNzeLQ5q3s
	Fmv2nmOymH/kHKtF34uHzBZ7XwPFPvbcY7W4vGsOm8WM8/uYLC6ecrVYtPULu8XhN+2sFv+u
	bWSxWLXrD6MDn8f7G63sHjtn3WX32LSqk83jzrU9bB59W1YxenzeJBfAFpVtk5GamJJapJCa
	l5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0rZJCWWJOKVAoILG4WEnf
	zqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO+PWiY1MBStVK5bc
	PMXYwPhYsYuRk0NCwERi3coPzF2MXBxCArsZJfZ3nWSHcD4xSnScegDlfGOU+Hx3ISNMy+Lu
	22wQib2MEpfef2SBcF4wSjS+uwxWxSagI7H75XJWkISIwH4miTuvjzKBJJgFaiROr33BBmJz
	CthJbLp8AMwWFnCVeP3sC1gzi4CqxPOr54HqOTh4BSwlbq9WAQnzCghKnJz5hAVijLbEsoWv
	mSEuUpD4+XQZK4gtIuAmMXv+aagacYmjP3vAnpMQuMIh0bh9GytEg4vEpbdv2SBsYYlXx7ew
	Q9hSEp/f7WUD2SshkCzR/okbIpwjcWn3KiYI217iwJU5LCAlzAKaEut36UOEZSWmnloH9SGf
	RO/vJ1DlvBI75sHYShI7d0yAsiUknq5ewzaBUWkWks9mIflsFpIPZiFsW8DIsopRMrWgODc9
	tdi0wDAvtRwe4cn5uZsYwYlZy3MH490HH/QOMTJxMB5ilOBgVhLhlVXsSBXiTUmsrEotyo8v
	Ks1JLT7EaAoM7YnMUqLJ+cDckFcSb2hiaWBiZmZmYmlsZqgkzvu6dW6KkEB6YklqdmpqQWoR
	TB8TB6dUA5OScJPJb5f2F+/3uRz8xXnk+/Mdk6z31mwvXf5p25z6y8Lnfp/VnD1pZlPK6YYn
	KQp8mqxiu82/sTtGLBGdefH7V1/HGX/nvvzxcuqGqCPR67bqGc3oyS+qCrm9RtPIsM/0jt7D
	3TdkWmbMD/n2pZ07YNsF5nXbuFoNUh4W8Z89fGy1VenZzwfcCzNfSNtvkH6z4OOiBv6KrZFH
	fSa8Paugd2ndwV07FwgJp9z+ONlu7hM1Hress4FKnH+0ZVZEBn3+3mocu/tkNkPR3qq2n4w7
	Q43uiD5oEwxrC5rwik/toOd203VbZppO3f9jRdA6KYnYitSwmSl3LYp2Ga3u5G7TDkpwrvaY
	/OXNQhOGyGUmSizFGYmGWsxFxYkAofk5qlUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsWy7bCSvO4R9u5Ug0NTzSwezNvGZnFo81Z2
	izV7zzFZzD9yjtWi78VDZou9r4FiH3vusVpc3jWHzWLG+X1MFhdPuVos2vqF3eLwm3ZWi3/X
	NrJYrNr1h9GBz+P9jVZ2j52z7rJ7bFrVyeZx59oeNo++LasYPT5vkgtgi+KySUnNySxLLdK3
	S+DKuHJrM1vBBbmK9b2nWRsYr0l0MXJySAiYSCzuvs0GYgsJ7GaUWHlKASIuIbHzWyszhC0s
	sfLfc/YuRi6gmmeMEmvfP2QBSbAJ6EjsfrmcFSQhInCcSWLN8UYWEIdZoIFRYvL9b8wQLa8Z
	JU6fh2jhFLCT2HT5ANg+YQFXidfPvjCC2CwCqhLPr55n6mLk4OAVsJS4vVoFJMwrIChxcuYT
	sFZmAW2J3oetjDD2soWvoc5TkPj5dBkriC0i4CYxe/5pqHpxiaM/e5gnMArPQjJqFpJRs5CM
	moWkZQEjyypGydSC4tz03GLDAqO81HK94sTc4tK8dL3k/NxNjOD41NLawbhn1Qe9Q4xMHIyH
	GCU4mJVEeGUVO1KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ83573ZsiJJCeWJKanZpakFoEk2Xi
	4JRqYMpYEBm32sy2rnTmtvTKXPXKbSKb17yyVfp6xDBD2SF3BnvHJImA+5tSZ+Z9mBoWe+7m
	rjP7GYq8r82PuPjyTOS9Vynu6npWPQemeP5ZebQtRb7ng9rldwXySw8JHF/CsHop8+GLfyR1
	gny+Hi7aq8K+zkrmhfqMUs3ukIaIbYVx/65qSMcERSyQKfw9u7ZX7omtc9jdAx9c18+e23Fu
	wx6+w5O2/b2VYT3v/9qZz4prOBWPrQ2Y89v5vt+Z5fvtHDWlvyzyT5L8kOmxRoL5xun7Sy7u
	MHTsb3w6/bXt9iPSt+5/8k19vFGn/tC7do+MnTrPpvV4/dtrlmvxUoOxy2aBqr2cYVTaKdZ1
	NitPXgxWYinOSDTUYi4qTgQAltFWrD4DAAA=
X-CMS-MailID: 20231226170509epcas5p1b6ee8be540b10806a21b219c71e3a73f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231219115858epcas5p469e925738bcb93ee88842fdea0f9d3f0
References: <20231219115834.65720-1-v.pavani@samsung.com>
	<CGME20231219115858epcas5p469e925738bcb93ee88842fdea0f9d3f0@epcas5p4.samsung.com>
	<20231219115834.65720-2-v.pavani@samsung.com>
	<58ded02d-a5d2-40e2-b575-dc520a7553cf@linaro.org>

Hi Krzysztof,

-----Original Message-----
From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D=20
Sent: 19 December 2023 17:36
To: Varada Pavani <v.pavani=40samsung.com>; mturquette=40baylibre.com; sboy=
d=40kernel.org; krzysztof.kozlowski+dt=40linaro.org; conor+dt=40kernel.org;=
 linux-clk=40vger.kernel.org; devicetree=40vger.kernel.org; linux-kernel=40=
vger.kernel.org; s.nawrocki=40samsung.com; tomasz.figa=40gmail.com
Cc: linux-samsung-soc=40vger.kernel.org; alim.akhtar=40samsung.com; aswani.=
reddy=40samsung.com; pankaj.dubey=40samsung.com
Subject: Re: =5BPATCH 2/2=5D clk: samsung: Fix typo error and extra space

On 19/12/2023 12:58, Varada Pavani wrote:
> Remove extra spaces and fix spelling mistakes in 'drivers/=20
> clk/samsung/clk-cpu.c' and 'drivers/clk/samsung/clk-cpu.h'
>=20
> Signed-off-by: Varada Pavani <v.pavani=40samsung.com>
> ---
>  drivers/clk/samsung/clk-cpu.c =7C 6 +++--- =20
> drivers/clk/samsung/clk-cpu.h =7C 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/clk/samsung/clk-cpu.c=20
> b/drivers/clk/samsung/clk-cpu.c index 3e62ade120c5..18568b8b1b9b=20
> 100644
> --- a/drivers/clk/samsung/clk-cpu.c
> +++ b/drivers/clk/samsung/clk-cpu.c
> =40=40 -19,7 +19,7 =40=40
>   * clock and the corresponding rate changes of the auxillary clocks of t=
he CPU
>   * domain. The platform clock driver provides a clock register configura=
tion
>   * for each configurable rate which is then used to program the clock=20
> hardware
> - * registers to acheive a fast co-oridinated rate change for all the=20
> CPU domain
> + * registers to achieve a fast co-oridinated rate change for all the=20
> + CPU domain
>   * clocks.
>   *
>   * On a rate change request for the CPU clock, the rate change is=20
> propagated =40=40 -181,7 +181,7 =40=40 static int exynos_cpuclk_pre_rate_=
change(struct clk_notifier_data *ndata,
>  	 * If the old parent clock speed is less than the clock speed of
>  	 * the alternate parent, then it should be ensured that at no point
>  	 * the armclk speed is more than the old_prate until the dividers are
> -	 * set.  Also workaround the issue of the dividers being set to lower
> +	 * set. Also workaround the issue of the dividers being set to lower

Why? The double-space is correct.

Okay, I couldn=E2=80=99t=20see=20any=20double=20space=20at=20the=20end=20of=
=20the=20statement=20apart=20from=20this=20line=20and=20below=20one.=20So=
=20updated=20to=20have=20uniformity.=0D=0A=0D=0A=0D=0A>=20=20=09=20*=20valu=
es=20before=20the=20parent=20clock=20speed=20is=20set=20to=20new=20lower=20=
speed=0D=0A>=20=20=09=20*=20(this=20can=20result=20in=20too=20high=20speed=
=20of=20armclk=20output=20clocks).=0D=0A>=20=20=09=20*/=0D=0A>=20=40=40=20-=
303,7=20+303,7=20=40=40=20static=20int=20exynos5433_cpuclk_pre_rate_change(=
struct=20clk_notifier_data=20*ndata,=0D=0A>=20=20=09=20*=20If=20the=20old=
=20parent=20clock=20speed=20is=20less=20than=20the=20clock=20speed=20of=0D=
=0A>=20=20=09=20*=20the=20alternate=20parent,=20then=20it=20should=20be=20e=
nsured=20that=20at=20no=20point=0D=0A>=20=20=09=20*=20the=20armclk=20speed=
=20is=20more=20than=20the=20old_prate=20until=20the=20dividers=20are=0D=0A>=
=20-=09=20*=20set.=20=20Also=20workaround=20the=20issue=20of=20the=20divide=
rs=20being=20set=20to=20lower=0D=0A>=20+=09=20*=20set.=20Also=20workaround=
=20the=20issue=20of=20the=20dividers=20being=20set=20to=20lower=0D=0A=0D=0A=
Why?=0D=0A=0D=0ASame=20as=20above.=0D=0A=0D=0A>=20=20=09=20*=20values=20bef=
ore=20the=20parent=20clock=20speed=20is=20set=20to=20new=20lower=20speed=0D=
=0A>=20=20=09=20*=20(this=20can=20result=20in=20too=20high=20speed=20of=20a=
rmclk=20output=20clocks).=0D=0A>=20=20=09=20*/=0D=0A>=20diff=20--git=20a/dr=
ivers/clk/samsung/clk-cpu.h=20=0D=0A>=20b/drivers/clk/samsung/clk-cpu.h=20i=
ndex=20fc9f67a3b22e..e0a1651174e6=20=0D=0A>=20100644=0D=0A>=20---=20a/drive=
rs/clk/samsung/clk-cpu.h=0D=0A>=20+++=20b/drivers/clk/samsung/clk-cpu.h=0D=
=0A>=20=40=40=20-33,7=20+33,7=20=40=40=20struct=20exynos_cpuclk_cfg_data=20=
=7B=0D=0A>=20=20=20*=20=40hw:=09handle=20between=20CCF=20and=20CPU=20clock.=
=0D=0A>=20=20=20*=20=40alt_parent:=20alternate=20parent=20clock=20to=20use=
=20when=20switching=20the=20speed=0D=0A>=20=20=20*=09of=20the=20primary=20p=
arent=20clock.=0D=0A>=20-=20*=20=40ctrl_base:=09base=20address=20of=20the=
=20clock=20controller.=0D=0A>=20+=20*=20=40ctrl_base:=20base=20address=20of=
=20the=20clock=20controller.=0D=0A=0D=0AWhy=20only=20here=20and=20not=20in=
=20other=20places?=0D=0A=0D=0AWill=20fix=20in=20V2=20for=20this=20file.=0D=
=0A=0D=0AThanks=20for=20the=20review=21=0D=0A=0D=0ABest=20regards,=0D=0AKrz=
ysztof=0D=0A=0D=0A=0D=0A

