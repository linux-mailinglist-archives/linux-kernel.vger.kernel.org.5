Return-Path: <linux-kernel+bounces-75778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE2885EECB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23BD628558D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC36134A7;
	Thu, 22 Feb 2024 01:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Filr8qnn"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEA680C
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708566853; cv=none; b=QeLucceQcOBufvzACXfn9ulOUwVGhEgTMofmfNMmkcnK+LadVDr5gO9CWfXaVWgu86k9pmG+VSjLCNFXtxjVLPTJ+0gmvr4yBaJ/Xoxx+Wnd9YiSES317Z5W3RBdXClm3HuAEdkKbUnaGGMCncNyJF6pYpaGo5qSj3YIXUpe+qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708566853; c=relaxed/simple;
	bh=4jl0Pufu+F2dbk97RorxRCXPxWBIIa4C5+goEroktRc=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=hhvy0NfQ+hSt9txvG0SJGjTK/WSvPkUysjOiv+C5mgK9S4h/yvhlPDXQI0ZMxHf836QVMvwSuOQfqjdUM8VY2gPCgNTa7cfr8ibx0iRwYUPUXDHAvLWkKyv7BFgT5ImX0MzJIDzAPSWNw77Y9s8kG9KElXPL9q0xc9Vt5r2+b24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Filr8qnn; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240222015400epoutp02472531b855e3db14d02bb881dd6355b2~2DH1J3HXl0764807648epoutp02V
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:54:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240222015400epoutp02472531b855e3db14d02bb881dd6355b2~2DH1J3HXl0764807648epoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708566840;
	bh=4jl0Pufu+F2dbk97RorxRCXPxWBIIa4C5+goEroktRc=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=Filr8qnnhL/xelWGNiuwAQiO6TGz6Avbcj1HJobA7Dl5EEo2m45GZ8w+o1BrS/xJp
	 Haw+pPZX5AQQgp5IXtJwwPrDDl35tPsvcwjyHQuX0lbxHCgIICd6we5FeXL2FJpSrk
	 eAIY6hzvBNUHWnf4eMInSXwxgaw8ByDp13eQwjck=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240222015400epcas1p1dad6f58a20d3a359020ea82596d97bc2~2DH07NggN1037210372epcas1p1S;
	Thu, 22 Feb 2024 01:54:00 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.134]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4TgGQb2kxNz4x9Ps; Thu, 22 Feb
	2024 01:53:59 +0000 (GMT)
X-AuditID: b6c32a39-9d9ff70000002729-94-65d6a9337471
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
	18.4B.10025.339A6D56; Thu, 22 Feb 2024 10:53:55 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: Re: [PATCH v1 1/1] extcon: intel-mrfld: Switch to use
 dev_err_probe()
Reply-To: myungjoo.ham@samsung.com
Sender: MyungJoo Ham <myungjoo.ham@samsung.com>
From: MyungJoo Ham <myungjoo.ham@samsung.com>
To: Chanwoo Choi <cw00.choi@samsung.com>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <ZdYOPISUzbjid9l8@smile.fi.intel.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240222015355epcms1p36eb91aa458c336900a52af653a5b7a44@epcms1p3>
Date: Thu, 22 Feb 2024 10:53:55 +0900
X-CMS-MailID: 20240222015355epcms1p36eb91aa458c336900a52af653a5b7a44
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsWy7bCmvq7xymupBhsnWlr0Nk1nsrj+5Tmr
	xeVdc9gcmD3mnQz06NuyitHj8ya5AOaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11D
	SwtzJYW8xNxUWyUXnwBdt8wcoD1KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALT
	Ar3ixNzi0rx0vbzUEitDAwMjU6DChOyMrW+XshVs4ag4+WoPcwNjI0cXIyeHhICJxJ5Xi5i7
	GLk4hAR2MEqcWD6FvYuRg4NXQFDi7w5hkBphgRCJKedmM4HYQgJKEg039zFDxPUlOh5sYwSx
	2QR0JbZuuMsCYosIaEjM/HsFLM4sUCHRfugxI8QuXokZ7U9ZIGxpie3Lt4LFOQWMJN4/uckG
	EReVuLn6LTuM/f7YfKheEYnWe2eZIWxBiQc/dzPCzDl2pxeqPl9i15OVUHMCJSasn84EYetL
	bDp8jg3iLV+JNZ+1QMIsAqoSsza/hip3kdjbtJ8F4mRtiWULXzODlDMLaEqs36UPEeaTePe1
	hxXmkx3znkBNV5M4tHsJ1AUyEqenL4S60kPibe8TaMg+YJTon7iFaQKj/CxE4M5Csm0WwrYF
	jMyrGMVSC4pz01OLDQtM4fGZnJ+7iRGcyrQsdzBOf/tB7xAjEwfjIUYJDmYlEV6W8iupQrwp
	iZVVqUX58UWlOanFhxhNgf6cyCwlmpwPTKZ5JfGGJpYGJmZGxiYWhmaGSuK8Z66UpQoJpCeW
	pGanphakFsH0MXFwSjUwBXNKzFqy6Wpz8bkvN0P2P55xMObQkvX6PZ+5V9gIlj0ovDVRk10j
	/+WxjWeXnHpR4+aonsbPVXMq6ltNkdBTBu76jblHjyWzHK9IaXa/41W7p8q352Fa0zRDkRIG
	jeuH5noIsL8UW8EcdPiJOHfWUzee6IXSE65Peh/XyeEle2nBx0d6MtLCpcEMOZl1M78w/Exa
	+HKn6jyXnDMTdk9IfDYrrHGN4LFJHZo3Li40efNXbsUZsQlutUxP757d8G83g9S+duvwo3+2
	dlzwdIw9GVXjJd4Z8vDRhHTjypNsiQlvog/cX9RUKp/uc2KLWs9c9tVzGys0db6wTdubE2OW
	c/D6MdbnDPdvzLFN2W56TImlOCPRUIu5qDgRAKioe9nuAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240221145253epcas1p4fb6f5b36089cb81aebd0fa2f29da5a07
References: <ZdYOPISUzbjid9l8@smile.fi.intel.com>
	<20231222161954.2955905-1-andriy.shevchenko@linux.intel.com>
	<ZbuJ8zCEfU-ORmk_@smile.fi.intel.com>
	<CGME20240221145253epcas1p4fb6f5b36089cb81aebd0fa2f29da5a07@epcms1p3>

>
>---------Original Message---------
>Sender: Andy Shevchenko <andriy.shevchenko=40linux.intel.com>
>Date: 2024-02-21 23:52 (GMT+9)
>Title: Re: =5BPATCH v1 1/1=5D extcon: intel-mrfld: Switch to use dev_err_p=
robe()
>=C2=A0=0D=0A>On=20Thu,=20Feb=2001,=202024=20at=2002:09:23PM=20+0200,=20And=
y=20Shevchenko=20wrote:=0D=0A>>=20On=20Fri,=20Dec=2022,=202023=20at=2006:19=
:54PM=20+0200,=20Andy=20Shevchenko=20wrote:=0D=0A>>=20>=20Switch=20to=20use=
=20dev_err_probe()=20to=20simplify=20the=20error=20path=20and=0D=0A>>=20>=
=20unify=20a=20message=20template.=0D=0A>>=0D=0A>>=20Any=20comments?=20Can=
=20these=20two=20patches=20(with=0D=0A>>=2020231222161854.2955859-1-andriy.=
shevchenko=40linux.intel.com)=20be=20applied?=0D=0A>=0D=0A>Ping?=0D=0A>=0D=
=0A>It's=20more=20than=20two=20months=20passed...=0D=0A=0D=0AThe=20patch=20=
=22extcon:=20intel-mrfld:=20Switch=20to=20use=20dev_err_probe()=22=0D=0Aloo=
ked=20good=20to=20me.=0D=0A=0D=0AChanwoo,=20please=20take=20a=20look.=0D=0A=
=0D=0AAcked-by:=20MyungJoo=20Ham=20<myungjoo.ham=40samsung.com>=0D=0A=0D=0A

