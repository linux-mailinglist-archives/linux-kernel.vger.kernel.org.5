Return-Path: <linux-kernel+bounces-94848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130F68745E1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3736B1C23977
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BD15C89;
	Thu,  7 Mar 2024 02:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VDn1qX5N"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7759A5221
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 02:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709777124; cv=none; b=PXQ7diJ4i0LunstznGyjIkTtloZGo8sqc5297RY4RaRkxpwXmdwYUJSVgMZjTzpLziZXeOw13evJhwvSglye35hgjtpbA+nwJSl19huFEOtSY3xBdQlaUIDpjIxrKMTcWU4Ef8Yg4ecc6FywQ/rXlNDC6xNbbiT75W3+ke0i/NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709777124; c=relaxed/simple;
	bh=3Uo0mqyyxcagU7ODBaeoaCB6S7zSEzNxaJ8hwq57tGU=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=IHx1ufekuOg4Iox3DuwR2ur1/aLIbsKRJXy8sr3EK/kV6i/gXolLR2oefwhwn1wpWBWAAb5XjEdoUntlfGOsQ0m6Uc3V661NXR98CLIosNQNVB+Aidpvo4sr9yY7uq21gnKML2U6PMEO240HnQbrL5/xnZoGJRvT/W0suYvGx0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=VDn1qX5N; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240307020520epoutp041a8496d508c148d9d96a9ab478df5366~6WTt0XW8A2365623656epoutp04S
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 02:05:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240307020520epoutp041a8496d508c148d9d96a9ab478df5366~6WTt0XW8A2365623656epoutp04S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1709777120;
	bh=3Uo0mqyyxcagU7ODBaeoaCB6S7zSEzNxaJ8hwq57tGU=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=VDn1qX5Nc1vBZajjWBKzgl9h+w+brPxHGJ6w/wjuY2jhzDnaOpCAUpfqxWNkuQfe4
	 oGv1M7+VAoGEsiz6BleWDNxxmNYxGKNRfnAU+DvDFjCHSNUxmUFdGX0+5O6EPeB4OH
	 1nQx8qyHaralpTvALm4cVGuEZhLhta5puFvGS1oc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240307020519epcas5p43becbc9801ce213abd1ecc9c539839ff~6WTs9cQGk0419104191epcas5p44;
	Thu,  7 Mar 2024 02:05:19 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Tqt1B2CqMz4x9Pt; Thu,  7 Mar
	2024 02:05:18 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	18.D4.09672.ED029E56; Thu,  7 Mar 2024 11:05:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240307020517epcas5p3a7072addc92dfe8f7f408c701cf241bc~6WTrYoojm0456504565epcas5p32;
	Thu,  7 Mar 2024 02:05:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240307020517epsmtrp2bc774932d72e6472e86a96ec9a1e7949~6WTrXv-052088420884epsmtrp2W;
	Thu,  7 Mar 2024 02:05:17 +0000 (GMT)
X-AuditID: b6c32a4b-60bfd700000025c8-d6-65e920de80f9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	94.DE.08755.DD029E56; Thu,  7 Mar 2024 11:05:17 +0900 (KST)
Received: from INBRO000447 (unknown [107.122.12.5]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240307020515epsmtip215c9f872498d33ad5208f5ccf093224f~6WTpdBulP1482014820epsmtip23;
	Thu,  7 Mar 2024 02:05:15 +0000 (GMT)
From: "Alim Akhtar" <alim.akhtar@samsung.com>
To: "'Tudor Ambarus'" <tudor.ambarus@linaro.org>, "'Sylwester Nawrocki'"
	<s.nawrocki@samsung.com>, "'Chanwoo Choi'" <cw00.choi@samsung.com>
Cc: "'Sam Protsenko'" <semen.protsenko@linaro.org>, "'Krzysztof Kozlowski'"
	<krzysztof.kozlowski@linaro.org>, <linux-samsung-soc@vger.kernel.org>,
	<linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"'linux-arm-kernel'" <linux-arm-kernel@lists.infradead.org>, "'Peter
 Griffin'" <peter.griffin@linaro.org>, =?utf-8?Q?'Andr=C3=A9_Draszik'?=
	<andre.draszik@linaro.org>, "'William McVicker'" <willmcvicker@google.com>,
	<kernel-team@android.com>, <jaewon02.kim@samsung.com>
In-Reply-To: <9732478c-c371-4db6-b8f2-5623ac733a0c@linaro.org>
Subject: RE: samsung: clk: re-parent MUX to OSCCLK at run-time
Date: Thu, 7 Mar 2024 07:35:14 +0530
Message-ID: <33e001da7033$e6a13ae0$b3e3b0a0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKxjg6/pX91DIw7ou3pXLvWj7BlkgJSyW8WAtnMGMgCuGwGCK8+IWrQ
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDJsWRmVeSWpSXmKPExsWy7bCmlu49hZepBucWcFpsebWZxeL6l+es
	FjsajgCJ7SIWe19vZbfY9Pgaq8XHnnusFpd3zWGzmHF+H5PFhhn/WCwOv2lntXjeB+R+uhVn
	serTf0YHPo9tu7exeizYVOpx59oeNo/NS+o9+rasYvT4vEkugC0q2yYjNTEltUghNS85PyUz
	L91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6FQlhbLEnFKgUEBicbGSvp1NUX5p
	SapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbG62uuBWdiKh6sf8DawPgi
	souRk0NCwESiue05WxcjF4eQwG5Gid0fL0E5nxglHq49CuV8Y5R4fG8acxcjB1jLy/n+IN1C
	AnsZJa7elYWoecEosevXIlaQBJuArsSOxW1sILaIQC+jxMpdASBFzAIvmSW+3j/JDJLgFLCT
	aNxylwnEFgay1x/+BdbMIqAisXvmZ3YQm1fAUuJ12zQWCFtQ4uTMJ2A2s4C2xLKFr5khflCQ
	+Pl0GSvEMjeJT9+fskPUiEu8PHqEHWSxhMAJDon5s+cwQTS4SLRfaGGFsIUlXh3fwg5hS0l8
	freXDeJLD4lFf6QgwhkSb5evZ4Sw7SUOXJnDAlLCLKApsX6XPsQqPone30+YIDp5JTrahCCq
	VSWa311lgbClJSZ2d0Mt9ZD4dWU10wRGxVlIHpuF5LFZSB6YhbBsASPLKkbJ1ILi3PTUYtMC
	47zUcnhsJ+fnbmIEJ2Mt7x2Mjx580DvEyMTBeIhRgoNZSYTX9P2LVCHelMTKqtSi/Pii0pzU
	4kOMpsDQnsgsJZqcD8wHeSXxhiaWBiZmZmYmlsZmhkrivK9b56YICaQnlqRmp6YWpBbB9DFx
	cEo1MJlcvpHNJiH9n6tv8pYppy9M2/5zifhlFvn4pTEZjGkff3uHcJTzGme5iPz2Md8l9OL7
	eZvyyo+KXju0iw8fVS35N1VB9vTWd3IaCyqZ9117u1hEJ1voldvWUumz975stzvwT6+y13bF
	9hwhuZ4trzuZtYqS7L6ZbK6vlr0vO0+Ph7nL+QWHZLX9zpLYm1dKDWs65q2Q4NGvCX253dfO
	m6Up9eqTJ1wyT6oe7K6JYptn6MefberEHpvxebeFBqez3b4rOx7xHQph/ba5nX8+7xL/M4Gd
	KyTTvsizFTAznVkp3CyXN2/SQeY+s92+s11Ys6/q7T8bFsEjufia1FrVdU2NpZtZqybwzfXI
	vlmvxFKckWioxVxUnAgALk2eV08EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSvO5dhZepBj/6dSy2vNrMYnH9y3NW
	ix0NR4DEdhGLva+3sltsenyN1eJjzz1Wi8u75rBZzDi/j8liw4x/LBaH37SzWjzvA3I/3Yqz
	WPXpP6MDn8e23dtYPRZsKvW4c20Pm8fmJfUefVtWMXp83iQXwBbFZZOSmpNZllqkb5fAldF5
	8AVbwS3Dio6zDUwNjJNkuxg5OCQETCRezvfvYuTiEBLYzSix5n4jWxcjJ1BcWuL6xgnsELaw
	xMp/z9khip4xSlye950FJMEmoCuxY3EbG0hCRKCfUeJF51RGEIdZ4COzxMlry1kgWt4zSnzu
	uw/WwilgJ9G45S4TiC0MZK8//IsVxGYRUJHYPfMz2D5eAUuJ123TWCBsQYmTM5+A2cwC2hJP
	bz6Fs5ctfM0McZ+CxM+ny8DmiAi4SXz6/pQdokZc4uXRI+wTGIVnIRk1C8moWUhGzULSsoCR
	ZRWjZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnBsamnuYNy+6oPeIUYmDsZDjBIczEoi
	vKbvX6QK8aYkVlalFuXHF5XmpBYfYpTmYFES5xV/0ZsiJJCeWJKanZpakFoEk2Xi4JQCRsn9
	Cs0wcx+hTTkLxD+eThMSipb8ZCt7b81hfp8TfVlfmP82Wnq/zKxK4d/Z9N79svm8T9zyVdWB
	2xRbJmalf/8jxpEoUC73JmP54aRJEXZ9xgVKN9IDpudHRlb9ejQl4/3jKO9dCXPmddedMLxy
	8L3lLw7pq0qx2SyWSsGuC6Q/pRpM+x92IuFju96fbE3RJW/vfNtrl/zk6YczX6a/ec41o086
	z1x5iVTy9smLhfgyd31dyMZi/0I9itUq6lo367Xvl+zaL011nBHCs8viEUenVnfk7oerStvP
	pOS7pbyv+VLV+bSi7b5xi7J6SqqnnJ7zfsUEzvbprFnHeNkaBHy+z/850UE/nvXao34lluKM
	REMt5qLiRADa1BAaPAMAAA==
X-CMS-MailID: 20240307020517epcas5p3a7072addc92dfe8f7f408c701cf241bc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240306032013epcas5p4932674432fbb49f586ed9d00f006a9e8
References: <CGME20240306032013epcas5p4932674432fbb49f586ed9d00f006a9e8@epcas5p4.samsung.com>
	<d508dfc1-bc28-4470-92aa-cf71915966f4@linaro.org>
	<324701da6f81$ad1379d0$073a6d70$@samsung.com>
	<9732478c-c371-4db6-b8f2-5623ac733a0c@linaro.org>

Hi Tudor

> -----Original Message-----
> From: Tudor Ambarus <tudor.ambarus=40linaro.org>
> Sent: Wednesday, March 6, 2024 11:40 AM
> To: Alim Akhtar <alim.akhtar=40samsung.com>; 'Sylwester Nawrocki'
> <s.nawrocki=40samsung.com>; 'Chanwoo Choi' <cw00.choi=40samsung.com>
> Cc: 'Sam Protsenko' <semen.protsenko=40linaro.org>; 'Krzysztof Kozlowski'
> <krzysztof.kozlowski=40linaro.org>; linux-samsung-soc=40vger.kernel.org;
> linux-clk=40vger.kernel.org; linux-kernel=40vger.kernel.org; 'linux-arm-k=
ernel'
> <linux-arm-kernel=40lists.infradead.org>; 'Peter Griffin'
> <peter.griffin=40linaro.org>; 'Andr=C3=A9=20Draszik'=20<andre.draszik=40l=
inaro.org>;=0D=0A>=20'William=20McVicker'=20<willmcvicker=40google.com>;=20=
kernel-team=40android.com;=0D=0A>=20jaewon02.kim=40samsung.com=0D=0A>=20Sub=
ject:=20Re:=20samsung:=20clk:=20re-parent=20MUX=20to=20OSCCLK=20at=20run-ti=
me=0D=0A>=20=0D=0A>=20=0D=0A>=20=0D=0A>=20On=203/6/24=2004:49,=20Alim=20Akh=
tar=20wrote:=0D=0A>=20>=20Hi=20Tudor=0D=0A>=20=0D=0A>=20Hi=21=0D=0A>=20=0D=
=0A>=20>=0D=0A>=20>>=20-----Original=20Message-----=0D=0A>=20>>=20From:=20T=
udor=20Ambarus=20<tudor.ambarus=40linaro.org>=0D=0A>=20>>=20Sent:=20Wednesd=
ay,=20March=206,=202024=208:50=20AM=0D=0A>=20>>=20To:=20Sylwester=20Nawrock=
i=20<s.nawrocki=40samsung.com>;=20Chanwoo=20Choi=0D=0A>=20>>=20<cw00.choi=
=40samsung.com>;=20Alim=20Akhtar=20<alim.akhtar=40samsung.com>=0D=0A>=20>>=
=20Cc:=20Sam=20Protsenko=20<semen.protsenko=40linaro.org>;=20Krzysztof=20Ko=
zlowski=0D=0A>=20>>=20<krzysztof.kozlowski=40linaro.org>;=20linux-samsung-s=
oc=40vger.kernel.org;=0D=0A>=20>>=20linux-clk=40vger.kernel.org;=20linux-ke=
rnel=40vger.kernel.org;=0D=0A>=20>>=20linux-arm-kernel=20<linux-arm-kernel=
=40lists.infradead.org>;=20Peter=0D=0A>=20>>=20Griffin=20<peter.griffin=40l=
inaro.org>;=20Andr=C3=A9=20Draszik=0D=0A>=20>>=20<andre.draszik=40linaro.or=
g>;=20William=20McVicker=0D=0A>=20>>=20<willmcvicker=40google.com>;=20kerne=
l-team=40android.com=0D=0A>=20>>=20Subject:=20samsung:=20clk:=20re-parent=
=20MUX=20to=20OSCCLK=20at=20run-time=0D=0A>=20>>=0D=0A>=20>>=20Hi,=0D=0A>=
=20>>=0D=0A>=20>>=20Trying=20to=20get=20some=20feedback=20from=20the=20sams=
ung=20experts.=20Please=20consider=0D=0A>=20>>=20the=0D=0A>=20>>=20followin=
g:=0D=0A>=20>>=0D=0A>=20>>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20---------------------------------------------=
=0D=0A>=20>>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=7C=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20CMU_PERIC0=20=20=20=7C=0D=0A>=20>>=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=0D=0A>=20>>=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=7C=20=20MUX_USI=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=0D=0A>=20>>=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=0D=0A>=20>>=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=20=
=20=7C=5C=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=0D=0A>=20>>=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20OSCCLK=20---=7C->=7C=20=5C=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=0D=0A>=20>>=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=20=20=7C=20=20=5C=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=0D=0A>=20>>=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=20=20=7C=20M=
=20=7C=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=0D=0A>=20>>=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=20=20=7C=20=
U=20=7C-->=20DIV_CLK_PERIC0_USI*_=20-->=20GATE_USI=20=7C=0D=0A>=20>>=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=20=
=20=7C=20X=20=7C=20=20=20=20=20=20=20=20(1=20=7E=2016)=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=0D=0A>=20>>=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=20=20=7C=20=
=20/=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=0D=0A>=20>>=20DIV_CLKCM=
U_PERIC0_IP=20---=7C->=7C=20/=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=7C=0D=0A>=20>>=20=20=20=20=20(1=20=7E=2016)=20=20=20=20=20=20=20=20=20=20=
=7C=20=7C=20=20=7C/=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=0D=
=0A>=20>>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=7C=20=7C=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=
=0D=0A>=20>>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=7C=20=7C=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=7C=0D=0A>=20>>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=7C=20=7C=20=20MUX_I3C=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=0D=0A=
>=20>>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=7C=20=7C=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=0D=
=0A>=20>>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=7C=20=7C=20=20=7C=5C=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=
=0D=0A>=20>>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20--=7C->=7C=20=5C=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=0D=
=0A>=20>>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=7C=20=20=7C=20=20=5C=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=
=0D=0A>=20>>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=7C=20=20=7C=20M=20=7C=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=7C=0D=0A>=20>>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=7C=20=20=7C=20U=20=7C-->=20DIV_CLK_PERIC0_I3C=20-->=20GATE_=
I3C=20=20=20=7C=0D=0A>=20>>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=7C=20=20=7C=20X=20=7C=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=7C=0D=0A>=20>>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=7C=20=20=7C=20=20/=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=7C=0D=0A>=20>>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20OSCCLK=20---=7C->=7C=20/=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=
=0D=0A>=20>>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=7C=20=20=7C/=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=7C=0D=0A>=20>>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=7C=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=7C=0D=0A>=20>>=0D=0A>=20>>=20------------------------------------------=
---=0D=0A>=20>>=0D=0A>=20>>=20Is=20it=20fine=20to=20re-parent=20the=20MUX_U=
SI=20from=20above=20to=20OSCCLK=20at=20run-time,=0D=0A>=20>=0D=0A>=20>=20I=
=20am=20not=20aware=20of=20the=20exact=20SOC/HW=20you=20are=20working=20on.=
=0D=0A>=20=0D=0A>=20I'm=20working=20with=20GS101.=20I'm=20interested=20in=
=20exynos850=20as=20well.=0D=0A>=20=0D=0A>=20>=20It=20depends=20on=20the=20=
CMU=20design=20about=20how=20to=20achieve=20low=20power=20mode=20and=0D=0A>=
=20clock=20gating=20for=20an=20IP/Block.=0D=0A>=20>=0D=0A>=20>=20In=20theor=
y=20and=20looking=20at=20your=20clock=20diagram=20above,=20it=20is=20ok=20t=
o=20switch=20to=0D=0A>=20OSCCLK=20=20for=20MUX_USI.=0D=0A>=20>=0D=0A>=20>=
=20If=20you=20can=20just=20use=20GATE_USI=20clock=20to=20clock=20gate=20USI=
=20IP,=20you=20will=20have=20a=20low=0D=0A>=20power=20for=20USI=20(of=20cou=
rse=20there=20will=20be=20a=20leakage=20current=20still=20drawn).=0D=0A>=20=
>=20Is=20that=20what=20you=20want=20to=20achieve=20(low=20power=20mode)?=20=
Or=20you=20are=20looking=20to=0D=0A>=20get=20lowest=20possible=20operating=
=20clock=20for=20USI=20IP?=0D=0A>=20=0D=0A>=20I'm=20trying=20to=20get=20the=
=20lowest=20possible=20operating=20clock=20for=20the=20USI=20IP.=0D=0A>=20=
=0D=0A>=20>=0D=0A>=20>=20You=20need=20to=20takecare=20about=20if=20that=20c=
lock=20is=20being=20shared=20with=20any=0D=0A>=20>=20other=20IP,=0D=0A>=20=
=0D=0A>=20It's=20not=20shared,=20the=20entire=20MUX=20USI,=20DIV,=20and=20G=
ATE=20sequence=20is=20dedicated=0D=0A>=20per=20IP.=20GS101=20has=2015=20USI=
=20blocks,=20each=20with=20its=20dedicated=20MUX-DIV-GATE=0D=0A>=20sequence=
=20of=20clocks.=0D=0A>=20=0D=0A>=20>=20so=20unless=20all=20the=20IPs=20whic=
h=20consume=20this=20clock,=20goes=20into=20idle=20state,=20you=20can=0D=0A=
>=20avoid=20MUX_USI=20change=20to=20OSCCLK.=0D=0A>=20=0D=0A>=20Since=20the=
=20MUX=20USI=20is=20per=20IP,=20I=20guess=20I=20shouldn't=20be=20concerned=
=20about=20this,=0D=0A>=20right?=0D=0AYes,=20that=20should=20be=20fine=0D=
=0A=0D=0A>=20=0D=0A>=20I'm=20trying=20to=20find=20out=20if=20it's=20OK=20to=
=20reparent=20the=20MUX=20to=20OSCCLK=20in=20normal=0D=0A>=20operation=20mo=
de=20(not=20low=20power=20mode),=20in=20order=20to=20get=20the=20lowest=20p=
ossible=0D=0A>=20operating=20clock=20for=20the=20USI=20IP.=20Would=20be=20g=
reat=20if=20the=20decision=20is=20backed=20up=20by=0D=0A>=20some=20info=20f=
rom=20datasheet.=20Unfortunately=20the=20datasheet=20that=20I=20have=20acce=
ss=20to=0D=0A>=20it's=20not=20explicit.=0D=0A>=20=0D=0AUnfortunately,=20I=
=20don't=20have=20access=20to=20either=20of=20the=20datasheets.=20So=20won'=
t=20be=20able=20to=20provide=20input=20from=20datasheet.=0D=0ALooking=20at=
=20your=20explanation=20above,=20like=20MUX=20USI=20is=20per=20IP,=20so=20i=
t=20okay=20to=20switch=20to=20OSCCLK=20to=20get=20lowest=20possible=20clock=
=20for=20USI.=0D=0AYou=20need=20to=20do=20some=20more=20regression=20test=
=20with=20this=20change=20(I=20would=20still=20suggest=20to=20reach=20out=
=20to=20GS101=20team=20to=20get=20the=20confirmation=20of=20any=20other=20s=
ide=20effect)=0D=0AFor=20me,=20it=20looks=20ok=20to=20use=20OSCCLK=20for=20=
USI=0D=0A=0D=0A>=20Thanks=20for=20the=20help=21=0D=0A>=20ta=0D=0A>=20=0D=0A=
>=20>=0D=0A=0D=0A

