Return-Path: <linux-kernel+bounces-77880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD002860B6E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225A11F2474C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD42D1401D;
	Fri, 23 Feb 2024 07:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="e27SJ6Tx"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DB212E45
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 07:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708674208; cv=none; b=KpnGdhLbE4GHR8XTgV90cSopgKJacggRW/6nbBRZk4joiFr1klOqJsCPOUrYnprZVhY2q0+xOJXaJQDmBCQ2x7D8yRKccKgY6M71Nuo9Yn2bFN/UTw082fEVPQsiuqrlgPR1u2g0i4BIKmmnXhUhfh/+TJvhQfSboPuGx1BPhdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708674208; c=relaxed/simple;
	bh=y4869a+5UPWFivactLXvq7LGVu29XzZBZxt67nVeI3M=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=h4QmtwQaE63eIjaGZN9/ec+d8cKDxCc4AhYVrsc2wnwIT3eIMhgxqkjtRyTINO5WHyCUAluyJDygLnm4JsBliio9++rBhuTBdTlh0KYHuuegBlXVSpWkN4ctXk6bpmzVYGSOT9mkQeQRUN0qTujM0SAHj8Nw5UCMz1PFkfWB0BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=e27SJ6Tx; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240223074317epoutp031a9ad0c613f18f98e32e3ef33c207321~2biFF9hkj2335123351epoutp03i
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 07:43:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240223074317epoutp031a9ad0c613f18f98e32e3ef33c207321~2biFF9hkj2335123351epoutp03i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708674197;
	bh=9ocYm+fHbKwbVZzYfw8kuCyF9mhmA0CdruBcBst3zeA=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=e27SJ6TxmSWcZ127BHVjhkMm22BIewOaQklL0TqnRvFkojQehVMv0OyN3HD6o5QQx
	 pkFDMiERfqb8RkTwGnOTognKH90oNpl2I7C11y9s8UkXtmDJjwdbloWDUMi6cAWIf6
	 1iUQG44bNIeIi3IkdbPJFdJ4rl0hpQHhFyJujtfw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240223074317epcas1p22be5213b7a6b2733e1f399df020b529b~2biE0oIVE2275422754epcas1p26;
	Fri, 23 Feb 2024 07:43:17 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.132]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Th2781DHSz4x9Px; Fri, 23 Feb
	2024 07:43:16 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
	epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	5D.CC.11177.49C48D56; Fri, 23 Feb 2024 16:43:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240223074315epcas1p29a05eef3c9b189b96ae5c56be5e73f87~2biC3vqfp2274622746epcas1p23;
	Fri, 23 Feb 2024 07:43:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240223074315epsmtrp194efef440b3194c4e4b9589c37bbe9af~2biC3CnmE0878308783epsmtrp1o;
	Fri, 23 Feb 2024 07:43:15 +0000 (GMT)
X-AuditID: b6c32a35-c75fa70000002ba9-95-65d84c944f73
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	02.A7.08755.39C48D56; Fri, 23 Feb 2024 16:43:15 +0900 (KST)
Received: from cw00choi03 (unknown [10.113.111.106]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240223074315epsmtip2148d574882b27b4ef48189f7ed9afebd~2biCrMbSy1668416684epsmtip2k;
	Fri, 23 Feb 2024 07:43:15 +0000 (GMT)
From: "Chanwoo Choi" <cw00.choi@samsung.com>
To: "'Andy Shevchenko'" <andriy.shevchenko@linux.intel.com>,
	<linux-kernel@vger.kernel.org>
Cc: "'MyungJoo Ham'" <myungjoo.ham@samsung.com>
In-Reply-To: <ZddJeYhe8pCHup9a@smile.fi.intel.com>
Subject: RE: [PATCH v1 1/1] extcon: intel-mrfld: Don't shadow error from
 devm_extcon_dev_allocate()
Date: Fri, 23 Feb 2024 16:43:15 +0900
Message-ID: <061201da662b$f5b68f60$e123ae20$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQHfTpyV7yAFNQt3UIwsEYUxvXodbgFHRVVfASmM5toCUGlICbDnsMbA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmru4UnxupBvdvslj0Nk1nsri8aw6b
	xe3GFWwOzB7zTgZ69G1ZxejxeZNcAHNUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6h
	pYW5kkJeYm6qrZKLT4CuW2YO0B4lhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFp
	gV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGmq/tTAV3WSvet05gb2C8zNLFyMkhIWAisXrJdMYu
	Ri4OIYEdjBL7HsxlgnA+MUo83rKIHcL5xihxauFzNpiWaQ82sEIk9jJKXFz0kQ3CeckoMbWx
	H8jh4GAT0JFY8CMUpEFEIFbi3JOPzCA2s4C+xOoPtxlBbE4BI4mJG3rAhgoLpEp823OdCcRm
	EVCV6Ox7zgoyhlfAUmLNJ7BTeQUEJU7OfMICMUZeYvvbOcwQ9yhI/Hy6jBUiLiIxu7ONGWKt
	m8TSDa/A7pQQeMku8f7WPqifXSQm793ABGELS7w6voUdwpaSeNnfxg7RMBnosdevmSGc9YwS
	G1e2QK0zlti/dDITyHXMApoS63fpQ2zmk3j3tQfsaAkBXomONiGIamWJyw/uQu2SlFjc3gkN
	RA+J3wueM09gVJyF5LdZSH6bheSfWQjLFjCyrGIUSy0ozk1PLTYsMITHdnJ+7iZGcBrUMt3B
	OPHtB71DjEwcjIcYJTiYlUR4WcqvpArxpiRWVqUW5ccXleakFh9iNAUG9kRmKdHkfGAiziuJ
	NzSxNDAxMzI2sTA0M1QS5z1zpSxVSCA9sSQ1OzW1ILUIpo+Jg1Oqgcnbe2ESU3j+CoFHF8LS
	Duac+/3wX+Hd/eYF22+kSO//qnFzetfp2Tfn9jc3tL/i75v6zlLsVOCFmyZzJSZedrqyYHm3
	5MfeOVo6Jyd/SbAxOmq31SM1751T7+fusqDfT15kcE3cw7ZlXkrkL8Pe3B2tyvPMlpY3iOst
	ltI9Z859R/X9nxVLVGaG8dqZLrk/21vwGz/LH+ELCX11vgwM4Z3/0/x/pbPNqJbeb9R2LPiP
	ZfjEA6YsgWKCryyXm8jcrBDLYXz1q6jA/4rO48sxSzlXd3dEXYh/z9Sy+seXrj8Ni69Mf8x9
	+vQxWY2KV/ptjmGXjObNM058VeHJEvywKuT96/q9Mv/uH7voMUFOvkmJpTgj0VCLuag4EQAQ
	jz3jDAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSvO5knxupBj2tIha9TdOZLC7vmsNm
	cbtxBZsDs8e8k4EefVtWMXp83iQXwBzFZZOSmpNZllqkb5fAlbHmaztTwV3WivetE9gbGC+z
	dDFyckgImEhMe7CBtYuRi0NIYDejxM9Nx9ggEpIS0y4eZe5i5ACyhSUOHy6GqHnOKLHs4Umw
	OJuAjsSCH6Eg5SICsRLnnnxkBrGZBfQlVn+4zQhR/4xR4uTz72AJTgEjiYkbesDmCwskS1xa
	0Qp2BIuAqkRn33NWkJm8ApYSaz6BhXkFBCVOznzCAhJmFtCTaNvICDFeXmL72znMEFcqSPx8
	uowVIi4iMbuzjRniHDeJpRtesU5gFJ6FZNIshEmzkEyahaR7ASPLKkbJ1ILi3PTcYsMCw7zU
	cr3ixNzi0rx0veT83E2M4EjQ0tzBuH3VB71DjEwcjIcYJTiYlUR4WcqvpArxpiRWVqUW5ccX
	leakFh9ilOZgURLnFX/RmyIkkJ5YkpqdmlqQWgSTZeLglGpgKrzIH/jzwKyFytmu/+W8dsf1
	F5jp1Lm862zdl5f8Ob7O3oL9zYI3cZ67ZbzevT1VuX6hn/kJg8/cRxL3KrH/mfE7X81xY1mO
	Lte3ztlPlK5ufblr49eO02fn5N3Yq3TS87iPUMAS/l01zy8cFpUyj1VL9+N0VPW74RqW2PWT
	Xfe65W2Jm7Of86/WOun47OvEuOyjH/huT3rvveo53/Y69w19nlxBTbm1KVWS0itWcbes5//3
	JZtTNEc688v9bM62snQB66KKMlGBS7aZXNYPGaVTHm49XbpmRcPbB80lCZZnxCfVpW7VtqvR
	eb99pXXpnMLllVGxd2uLuP9UpnU0RUee8l9i6a9RUOjRHqnEUpyRaKjFXFScCAC24Kws8wIA
	AA==
X-CMS-MailID: 20240223074315epcas1p29a05eef3c9b189b96ae5c56be5e73f87
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240222131814epcas1p3b7a6a405f1170dcfac8e0f53b0f49d4c
References: <20231222161854.2955859-1-andriy.shevchenko@linux.intel.com>
	<ZcUqiaGI8N-FLijJ@smile.fi.intel.com>
	<CGME20240222131814epcas1p3b7a6a405f1170dcfac8e0f53b0f49d4c@epcas1p3.samsung.com>
	<ZddJeYhe8pCHup9a@smile.fi.intel.com>



> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Thursday, February 22, 2024 10:18 PM
> To: linux-kernel@vger.kernel.org
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>; Chanwoo Choi
> <cw00.choi@samsung.com>
> Subject: Re: [PATCH v1 1/1] extcon: intel-mrfld: Don't shadow error from
> devm_extcon_dev_allocate()
> 
> On Thu, Feb 08, 2024 at 09:24:58PM +0200, Andy Shevchenko wrote:
> > On Fri, Dec 22, 2023 at 06:18:54PM +0200, Andy Shevchenko wrote:
> > > Don't shadow error from devm_extcon_dev_allocate() and return it as
is.
> >
> > Any comment on this?
> 
> Here is another one, can it be applied as well?


Applied it. Thanks.

Best Regards,
Chanwoo Choi


