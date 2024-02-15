Return-Path: <linux-kernel+bounces-66768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E6285614D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8889B281350
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A87412BE88;
	Thu, 15 Feb 2024 11:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fTWKfbko"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5159812AAF0
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995753; cv=none; b=G+zRFMrceUvDINdwPm1Ba49eTGa48iyM734hh0VML4Y4ahh2OtcgwOpcQYdzFQwSO+CLXFo0t/CtwcF1ZjJc/uWK/6NlRviNNzuGp28EAFAyEPffodKu5djZMFbfbQH31WqSRPku7dCia0GByMRnrbv01DHPxIR8tOMKigM8YYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995753; c=relaxed/simple;
	bh=aGTSEtzcJDP28SsG98pbFptOSPuM9fuzs91xyFFwOPM=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=MDzGVb5WwVJeG/WG66Fco4H3D9FI8wcvkzxqcjVlvA3nCQfBjNEMDkf1ml/SByDH1/FUEq2xcS/sa0xIHKfMf41y4+pzoEjszjh+W4ytHy81gNL5f9HIY2Tch52byecfUEjTlqCDZDn6l7dLyqLN4osGuktJTuhl40sVbQnGyQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fTWKfbko; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240215111548epoutp036d2f81af93fbe071556a6945d307fafc~0BRVmfXId0038100381epoutp03v
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:15:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240215111548epoutp036d2f81af93fbe071556a6945d307fafc~0BRVmfXId0038100381epoutp03v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707995748;
	bh=aGTSEtzcJDP28SsG98pbFptOSPuM9fuzs91xyFFwOPM=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=fTWKfbkouRRWXl+vygpOAWqXobs+JThjizEqR5BOs4dGcyDKGO9um8hasDDgeMbfJ
	 bk1v/yWSFMHfu1YXZAHjICkph/go3G6JwL7g+2ez73LdWtL5AMsnAAga8nWuBnijcj
	 deD+Xx82VjP4avykbzCoG+u6coj5e1kcPBCFGbXs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240215111547epcas1p1f1a9a04ce7698623222c2d1585532ab1~0BRU4G7VB0437504375epcas1p1w;
	Thu, 15 Feb 2024 11:15:47 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.243]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4TbCD301fmz4x9Pr; Thu, 15 Feb
	2024 11:15:47 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	BD.D4.09731.262FDC56; Thu, 15 Feb 2024 20:15:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20240215111546epcas1p36aab0b36d5e207440440af92773a0d81~0BRT3YvW22982629826epcas1p3M;
	Thu, 15 Feb 2024 11:15:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240215111546epsmtrp1b9b9589c33bc7086e60b61ad25734774~0BRT2jHrI1835618356epsmtrp1a;
	Thu, 15 Feb 2024 11:15:46 +0000 (GMT)
X-AuditID: b6c32a36-a7dff70000002603-8c-65cdf2625841
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1F.EF.08755.262FDC56; Thu, 15 Feb 2024 20:15:46 +0900 (KST)
Received: from sh043lee04 (unknown [10.253.101.72]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240215111546epsmtip18ff144b0e38f36aebb9a1679b7f4a484~0BRTo3EmT2958029580epsmtip1s;
	Thu, 15 Feb 2024 11:15:46 +0000 (GMT)
From: =?utf-8?B?7J207Iq57Z2s?= <sh043.lee@samsung.com>
To: "'Greg KH'" <gregkh@linuxfoundation.org>
Cc: "'Ulf Hansson'" <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <avri.altman@wdc.com>,
	<grant.jung@samsung.com>, <jt77.jang@samsung.com>,
	<dh0421.hwang@samsung.com>, <junwoo80.lee@samsung.com>,
	<jangsub.yi@samsung.com>, <cw9316.lee@samsung.com>,
	<sh8267.baek@samsung.com>, <wkon.kim@samsung.com>, <sh043.lee@samsung.com>
In-Reply-To: <2024021528-fretted-sustainer-2ebc@gregkh>
Subject: RE: [PATCH] mmc: sd: Add a variable to check a faulty device
Date: Thu, 15 Feb 2024 20:15:45 +0900
Message-ID: <000001da6000$527c8650$f77592f0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI2QrZr/hQwBfLmGOt++EZEApv72gJjevE2AeL7/EgCVM+otwGWv7XmsBHSPJA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmvm7Sp7OpBjufmlu8/HmVzWLGqTZW
	i33XTrJb/Pq7nt2iefF6NouOrZOZLHY8P8NusetvM5PF5V1z2CyO/O9ntGj6s4/F4tqZE6wW
	x9eGW2y+9I3Fgc/jzrU9bB77565h9+jbsorR4/MmOY/2A91MAaxR2TYZqYkpqUUKqXnJ+SmZ
	eem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QIcqKZQl5pQChQISi4uV9O1sivJL
	S1IVMvKLS2yVUgtScgrMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7Izjl7exFywQ79i1rkHjA2M
	nXpdjJwcEgImEm/uP2LsYuTiEBLYwSix4OAWZgjnE6PEjaO/oDLfGCX+nL7BCtNyavlOVojE
	XkaJX9O3QTkvGCUeLlrD3sXIwcEmYCbx/E4QSIOIgI5Ex5kTLCA1zAJfmSSe713IBJLgFDCX
	OP75DAuILSzgKnH6zHpmEJtFQFXi76E9LCBzeAUsJd42gd3KKyAocXLmE7ByZgFtiWULXzND
	HKQg8fPpMlaQchEBP4mdl6UgSkQkZne2gX0jIXCBQ2LBj6/sEPUuEt9mLGWDsIUlXh3fAhWX
	knjZ38YO0dDMKNHW8JUFwpnAKPFiwSsmiCp7iebWZjaQbcwCmhLrd+lDbOOTePe1B+wICQFe
	iY42IYhqZYmXj5ZBdUpKLGm/BXWzh8Tl9b1sExgVZyF5bRaS12Yh+WEWwrIFjCyrGMVSC4pz
	01OLDQuM4LGdnJ+7iRGciLXMdjBOevtB7xAjEwfjIUYJDmYlEd5JvWdShXhTEiurUovy44tK
	c1KLDzGaAsN6IrOUaHI+MBfklcQbmlgamJgZmVgYWxqbKYnznrlSliokkJ5YkpqdmlqQWgTT
	x8TBKdXAJDTbiSnBePW9BRfv71Tp6i9uftV0+fW6/sPi82XVjMzf1h66G746S8tV5O6BtBfs
	tcs3WqhJhB6xVJ156uO6VU7ngva9LrNnkq7tcv4mPOPoXoe4ZfNYZiwOONMbM+eJ/tIwecbr
	OzONr/QlvY8Xt++v+msqJGE0Qbd2lfe5z3Nl93ac/egnccDLITl1Q4/js+hrmyYeZ782aduM
	+4cSPucvu7uiZ72xyLJDDJbbO/QOLLh2S7n4+KYdBXvOSJ9bYTQ5paZdL1M4s/2N83Yhr9WP
	knQSzp1pcNTbxhRnpHXk1Jy2Ks7lDeczntzhWHndO3TnHVf3GRtubGzyneqx7w3XwpeGzW2L
	ToiV/QuZOE2JpTgj0VCLuag4EQCYEZCdTQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWy7bCSnG7Sp7OpBnO+c1u8/HmVzWLGqTZW
	i33XTrJb/Pq7nt2iefF6NouOrZOZLHY8P8NusetvM5PF5V1z2CyO/O9ntGj6s4/F4tqZE6wW
	x9eGW2y+9I3Fgc/jzrU9bB77565h9+jbsorR4/MmOY/2A91MAaxRXDYpqTmZZalF+nYJXBm7
	F2oXLFSomP9Go4FxhWQXIyeHhICJxKnlO1m7GLk4hAR2M0qsfDyDESIhKbH40UO2LkYOIFtY
	4vDhYoiaZ4wSh6c/YQaJswmYSTy/EwRSLiKgI9Fx5gQLSA2zQDOzxI1JvWBzhARWMkn8PGUI
	YnMKmEsc/3yGBcQWFnCVOH1mPTOIzSKgKvH30B4WkJm8ApYSb5v0QMK8AoISJ2c+AStnFtCW
	eHrzKZy9bOFrZogzFSR+Pl3GCtIqIuAnsfOyFESJiMTszjbmCYzCs5BMmoVk0iwkk2YhaVnA
	yLKKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4ErU0dzBuX/VB7xAjEwfjIUYJDmYl
	Ed5JvWdShXhTEiurUovy44tKc1KLDzFKc7AoifOKv+hNERJITyxJzU5NLUgtgskycXBKNTDN
	T9K/7L3wlqzPh0NZJUc/vf5gfzOjbcL6ys/nZ1zedjU00PTX7rVLLkVw7wopLPhTsZzl/J9F
	S2dKln9NMhGbwNfC8kJiR/Laze+7be9EXP7sabZhmVtzcNvpyXZ5H/9+CT9YPnMP//Su6uaS
	E7Nn7bp7NspjHueWy2zzTy9xKgjpemo2rzZM8/33g8rsfB32Zntrkl4FfmJudLryUT352xHB
	3hkzndapL1+ofCvHef/xXXOLNx9/bbT21F2JXTx9kvUPvh1JqOoyvFF2+4zG5Y4/vr2Sl/Lc
	GPS/LnofemnX/JpHDjYVO9z3nlyWfUq0uH6GfE/y8qn6xz5Z2kxeobRW4KPGmoNLWtMi59Ss
	F1ZiKc5INNRiLipOBADx3b7XMwMAAA==
X-CMS-MailID: 20240215111546epcas1p36aab0b36d5e207440440af92773a0d81
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240213051332epcas1p1f45d02dc34d1b95ea5608ab779d6b6cc
References: <CGME20240213051332epcas1p1f45d02dc34d1b95ea5608ab779d6b6cc@epcas1p1.samsung.com>
	<20240213051716.6596-1-sh043.lee@samsung.com>
	<CAPDyKFrjZ4jRHAfXsvrEvezuHTxbA3SAniF8CuObyLuW=AUoeA@mail.gmail.com>
	<000001da5faa$d34e1600$79ea4200$@samsung.com>
	<2024021528-fretted-sustainer-2ebc@gregkh>

> -----Original Message-----
> From: Greg KH <gregkh=40linuxfoundation.org>
> Sent: Thursday, February 15, 2024 5:07 PM
> To: =EC=9D=B4=EC=8A=B9=ED=9D=AC=20<sh043.lee=40samsung.com>=0D=0A>=20Cc:=
=20'Ulf=20Hansson'=20<ulf.hansson=40linaro.org>;=20linux-mmc=40vger.kernel.=
org;=0D=0A>=20linux-kernel=40vger.kernel.org;=20avri.altman=40wdc.com;=20gr=
ant.jung=40samsung.com;=0D=0A>=20jt77.jang=40samsung.com;=20dh0421.hwang=40=
samsung.com;=20junwoo80.lee=40samsung.com;=0D=0A>=20jangsub.yi=40samsung.co=
m;=20cw9316.lee=40samsung.com;=20sh8267.baek=40samsung.com;=0D=0A>=20wkon.k=
im=40samsung.com=0D=0A>=20Subject:=20Re:=20=5BPATCH=5D=20mmc:=20sd:=20Add=
=20a=20variable=20to=20check=20a=20faulty=20device=0D=0A>=20=0D=0A>=20On=20=
Thu,=20Feb=2015,=202024=20at=2010:03:45AM=20+0900,=20=EC=9D=B4=EC=8A=B9=ED=
=9D=AC=20wrote:=0D=0A>=20>=20>=20-----Original=20Message-----=0D=0A>=20>=20=
>=20From:=20Ulf=20Hansson=20<ulf.hansson=40linaro.org>=0D=0A>=20>=20>=20Sen=
t:=20Wednesday,=20February=2014,=202024=208:27=20PM=0D=0A>=20>=20>=20To:=20=
Seunghui=20Lee=20<sh043.lee=40samsung.com>=0D=0A>=20>=20>=20Cc:=20linux-mmc=
=40vger.kernel.org;=20linux-kernel=40vger.kernel.org;=0D=0A>=20>=20>=20greg=
kh=40linuxfoundation.org;=20avri.altman=40wdc.com;=0D=0A>=20>=20>=20grant.j=
ung=40samsung.com;=20jt77.jang=40samsung.com;=0D=0A>=20>=20>=20dh0421.hwang=
=40samsung.com;=20junwoo80.lee=40samsung.com;=0D=0A>=20>=20>=20jangsub.yi=
=40samsung.com;=20cw9316.lee=40samsung.com;=0D=0A>=20>=20>=20sh8267.baek=40=
samsung.com;=20wkon.kim=40samsung.com=0D=0A>=20>=20>=20Subject:=20Re:=20=5B=
PATCH=5D=20mmc:=20sd:=20Add=20a=20variable=20to=20check=20a=20faulty=0D=0A>=
=20>=20>=20device=0D=0A>=20>=20>=0D=0A>=20>=20>=20On=20Tue,=2013=20Feb=2020=
24=20at=2006:13,=20Seunghui=20Lee=20<sh043.lee=40samsung.com>=0D=0A>=20wrot=
e:=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20In=20mobile=20devices,=20suspend=
/resume=20situations=20are=20frequent.=0D=0A>=20>=20>=20>=20In=20the=20case=
=20of=20a=20defective=20SD=20card=20in=20which=20initialization=20fails,=0D=
=0A>=20>=20>=20>=20unnecessary=20initialization=20time=20is=20consumed=20fo=
r=20each=20resume.=0D=0A>=20>=20>=20>=20A=20field=20is=20needed=20to=20chec=
k=20that=20SD=20card=20initialization=20has=20failed=0D=0A>=20>=20>=20>=20o=
n=20the=20host.=20It=20could=20be=20used=20to=20remove=20unnecessary=20init=
ialization.=0D=0A>=20>=20>=0D=0A>=20>=20>=20It's=20not=20clear=20to=20me,=
=20under=20what=20circumstance=20you=20want=20to=20optimize=20for.=0D=0A>=
=20>=20>=0D=0A>=20>=20>=20Is=20the=20SD=20card=20ever=20getting=20properly=
=20initialized=20during=20boot?=0D=0A>=20>=20>=0D=0A>=20>=20>=20Kind=20rega=
rds=0D=0A>=20>=20>=20Uffe=0D=0A>=20>=20>=0D=0A>=20>=20We=20receive=20a=20lo=
t=20of=20reports=20about=20SD=20card=20issues=20in=20the=20market.=0D=0A>=
=20>=20There=20was=20no=20problem=20with=20the=20first=20time=20at=20the=20=
time=20of=20use,=20and=20there=0D=0A>=20are=20many=20cases=20where=20people=
=20recognize=20that=20it=20is=20not=20recognized=20later=20on.=0D=0A>=20In=
=20most=20cases,=20this=20is=20a=20problem=20with=20the=20SD=20card=20itsel=
f.=0D=0A>=20>=0D=0A>=20>=20SD=20card=20users=20cannot=20determine=20whether=
=20or=20not=20an=20SD=20card=20is=20a=20problem,=0D=0A>=20so=20they=20shoul=
d=20be=20guided=20in=20this=20regard.=0D=0A>=20>=20It=20is=20necessary=20to=
=20distinguish=20whether=20the=20SD=20card=20is=20inserted=20but=0D=0A>=20u=
nrecognized=20or=20the=20SD=20card=20itself=20is=20not=20inserted,=20and=20=
if=20there=20is=20a=0D=0A>=20field=20that=20can=20check=20for=20initializat=
ion=20failure,=20it=20will=20facilitate=0D=0A>=20guidance,=20so=20we=20cons=
idered=20the=20patch.=0D=0A>=20>=0D=0A>=20>=20The=20variable's=20usage=20is=
=20expected=20to=20be=20used=20through=20the=20sysfs=20node=20in=0D=0A>=20t=
he=20vendor=20module.=0D=0A>=20=0D=0A>=20What=20=22vendor=20module=22?=20=
=20You=20need=20to=20include=20all=20of=20the=20needed=20code=20here=0D=0A>=
=20please.=0D=0A>=20=0D=0A>=20thanks,=0D=0A>=20=0D=0A>=20greg=20k-h=0D=0A=
=0D=0AThis=20only=20purpose=20of=20this=20variable=20is=20to=20identify=20a=
=20faulty=20card=20on=20host=20side.=0D=0A=0D=0AIn=20the=20past,=20we=20can=
=20identify=20that=20the=20card=20is=20inserted=20or=20not=20with=20reading=
=20get_cd()=20function.=0D=0ABut=20now,=20most=20mobile=20devices=20use=20h=
ybrid=20type=20of=20SD=20card=20tray.=0D=0AIf=20the=20tray=20is=20inserted,=
=20the=20return=20value=20of=20get_cd=20is=20the=20same=20whatever=20the=20=
SD=20card=20is=20inserted=20or=20not.=0D=0AIt=20can=20help=20us=20diagonose=
=20the=20status=20of=20a=20SD=20card=20as=20well.=0D=0A=0D=0AHere=20is=20th=
e=20example=20of=20usage.=0D=0A=0D=0Astatic=20ssize_t=20status_show(struct=
=20device=20*dev,=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20stru=
ct=20device_attribute=20*attr,=20char=20*buf)=0D=0A=7B=0D=0A=20=20=20=20=20=
=20=20=20struct=20mmc_host=20*host=20=3D=20dev_get_drvdata(dev);=0D=0A=20=
=20=20=20=20=20=20=20struct=20mmc_card=20*card=20=3D=20host->card;=0D=0A=20=
=20=20=20=20=20=20=20char=20*status=20=3D=20NULL;=0D=0A=0D=0A=20=20=20=20=
=20=20=20=20if=20(card)=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20status=20=3D=20mmc_card_readonly(card)=20?=20=22PERMWP=22=20:=20=22NORMA=
L=22;=0D=0A=20=20=20=20=20=20=20=20else=0D=0A=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20status=20=3D=20host->init_failed=20?=20=22INITFAIL=22=20:=
=20=22NOCARD=22;=0D=0A=0D=0A=20=20=20=20=20=20=20=20return=20sysfs_emit(buf=
,=20=22%s=5Cn=22,=20status);=0D=0A=7D=0D=0A=0D=0AAs=20for=20the=20sysfs=20n=
ode,=20it=20should=20keep=20the=20path=20of=20node=20with=20or=20without=20=
the=20SD=20card.=0D=0AThat's=20why=20I=20mention=20the=20vendor=20module.=
=0D=0A=0D=0AIf=20I=20need=20to=20update=20the=20commit's=20comment,=20I'll=
=20fix=20it.=0D=0AIf=20someone=20has=20the=20better=20idea(e.g.=20code,=20c=
omment),=20please=20suggest=20it.=0D=0A=0D=0AThank=20you=20for=20reviewing=
=20this.=0D=0ASeunghui=20Lee.=0D=0A=0D=0A=0D=0A

