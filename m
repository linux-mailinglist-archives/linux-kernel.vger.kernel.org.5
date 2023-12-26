Return-Path: <linux-kernel+bounces-11378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6851881E556
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 06:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE2428101E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 05:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E684C3C7;
	Tue, 26 Dec 2023 05:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Dod7ILPh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE5F4C602
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 05:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231226054927epoutp04a951fee0b54f6f3eed23d5bb8714cd07~kS62KlDrY0289802898epoutp04T
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 05:49:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231226054927epoutp04a951fee0b54f6f3eed23d5bb8714cd07~kS62KlDrY0289802898epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703569767;
	bh=PjCrB9sJG92TMahmGFHOSLjyHXg8ofkCAJr5VA8kks8=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=Dod7ILPhaSZHiR7+A4bj1Uvz4Dn9qHeWzZ3hvSisdtdGkgu49KRMl0Kh9OBMZrUGv
	 7kgEiCAmHU45EFwlh46WsxdAaehB12NM7RV4agr496/lZ7YCmxX78d+Vu21n83fwWd
	 G4IWELL+isv9I5slUyWSBzoSPT2MT9rWl91dPBPo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20231226054927epcas5p3fd20bc768b6c740c5ed833d4fed3e948~kS61iWhv61922019220epcas5p34;
	Tue, 26 Dec 2023 05:49:27 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4SzkP12rm5z4x9Q8; Tue, 26 Dec
	2023 05:49:25 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	20.12.09672.5696A856; Tue, 26 Dec 2023 14:49:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20231226054502epcas5p4175bb019139535ed4216678c69604532~kS2-RJboZ0351103511epcas5p4A;
	Tue, 26 Dec 2023 05:45:02 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231226054502epsmtrp1ce3b5d78ebea8c831b1a48e31141862e~kS2-P3Fwp2782527825epsmtrp12;
	Tue, 26 Dec 2023 05:45:02 +0000 (GMT)
X-AuditID: b6c32a4b-39fff700000025c8-a1-658a6965cd1f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8D.30.08817.E586A856; Tue, 26 Dec 2023 14:45:02 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20231226054501epsmtip11d27d5185af80e3fa54671c7e7dad912~kS29uuR8N1689016890epsmtip1g;
	Tue, 26 Dec 2023 05:45:00 +0000 (GMT)
From: "Aakarsh Jain" <aakarsh.jain@samsung.com>
To: "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>, "'Marek
 Szyprowski'" <m.szyprowski@samsung.com>, "'Andrzej Hajda'"
	<andrzej.hajda@intel.com>, "'Mauro Carvalho Chehab'" <mchehab@kernel.org>
Cc: <linux-fsd@tesla.coma>, <linux-samsung-soc@vger.kernel.org>, "'Smitha T
 Murthy'" <smithatmurthy@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20231224-n-s5p-mfc-const-v1-6-a3b246470fe4@linaro.org>
Subject: RE: [PATCH 06/15] media: s5p-mfc: constify s5p_mfc_variant
 structures
Date: Tue, 26 Dec 2023 11:14:59 +0530
Message-ID: <15d201da37be$abae6d20$030b4760$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKOGlHY6WxiJqLoSx78067AznjgmAG+IMttAZIPrQOvOMcZAA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmlm5qZleqwaErIhb3F39msdj7eiu7
	xabH11gtls0Osri8aw6bRc+GrawWM87vY7JYe+Quu8WyTX+YLFoal7A6cHnsnHWX3WPxnpdM
	HptWdbJ53Lm2h81j85J6j74tqxg9/r5+xebxeZNcAEdUtk1GamJKapFCal5yfkpmXrqtkndw
	vHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0IlKCmWJOaVAoYDE4mIlfTubovzSklSFjPzi
	Elul1IKUnAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMz1PNC1pkK74damVsYHwu3sXIySEh
	YCLxo+MPUxcjF4eQwG5GiRObrzNCOJ8YJTp33YDKfGOUOH5wHQtMy7Mlu9lBbCGBvYwSi1bz
	QxQ9Z5RYvWEPWIJNQF/i/qkeVpCEiMA5Rolt/VPARjEL3GSUOPZmJjNIFaeAi8Tncz1sILaw
	QIDEvzefwFawCKhKdE19xQpi8wpYSqz71M8CYQtKnJz5BMxmFpCX2P52DjPESQoSP58uA6sX
	EXCS+Lj0OztEjbjE0Z89zCCLJQSOcEiseT6XDaLBRaJ3axM7hC0s8er4FihbSuJlfxuUnSzx
	eNFLqAU5Euv3TIH6317iwJU5QDYH0AJNifW79CHCshJTT61jgtjLJ9H7+wkTRJxXYsc8GFtN
	Ys6dH6wQtozE4dVLGScwKs1C8tosJK/NQvLCLIRtCxhZVjFKphYU56anFpsWGOellsNjPDk/
	dxMjOAlree9gfPTgg94hRiYOxkOMEhzMSiK8soodqUK8KYmVValF+fFFpTmpxYcYTYHhPZFZ
	SjQ5H5gH8kriDU0sDUzMzMxMLI3NDJXEeV+3zk0REkhPLEnNTk0tSC2C6WPi4JRqYLq7Plib
	javKZuWiqPrM5V0cjV8v/W/jyIpV4uIxs5LX/zTrPF/aWnGjrcbCBk7xUXz3o1USf4W3ubrc
	kJUOuNLTuc++9toKpgcvT/CceXqp5lbZtah72VFnFjXMf3S1Xv0rS1v1/8LWW7YbdsiLbH57
	pH5f0ESdhrJzZ3w5KoqPBXHeF4jVu/b81YdZ75K6fEpNBT3j5S/Pnyv7b/3VtLWrf/AzfFg3
	NYL5Td8xlVwObqWk3a61KZmON89lzl6fJRd2q9KXe6JAyqw9ejnzPzccLDs87XHjwyMT/RuN
	nBJ33Tp9PClnSu55pz/lbX0sovms2i/OPd5WNFnwXM5+drPtV5f8tk4Jq0w3UHqxTomlOCPR
	UIu5qDgRACYYzTtLBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsWy7bCSnG5cRleqwZy5Shb3F39msdj7eiu7
	xabH11gtls0Osri8aw6bRc+GrawWM87vY7JYe+Quu8WyTX+YLFoal7A6cHnsnHWX3WPxnpdM
	HptWdbJ53Lm2h81j85J6j74tqxg9/r5+xebxeZNcAEcUl01Kak5mWWqRvl0CV8bnqeYFLbIV
	3w61MjYwPhfvYuTkkBAwkXi2ZDd7FyMXh5DAbkaJL8+OMEIkZCT+tx1jh7CFJVb+ew5V9JRR
	4vq+bWwgCTYBfYn7p3pYQRIiAhcYJbbsWcAG4jAL3GeU6Nq0nQmi5SyjxOsZh5lAWjgFXCQ+
	n+sBaxcW8JOY39PDAmKzCKhKdE19xQpi8wpYSqz71M8CYQtKnJz5BMxmFtCW6H3Yyghhy0ts
	fzuHGeI+BYmfT5eB9YoIOEl8XPqdHaJGXOLozx7mCYzCs5CMmoVk1Cwko2YhaVnAyLKKUTK1
	oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4FrW0djDuWfVB7xAjEwfjIUYJDmYlEV5ZxY5U
	Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzfXvemCAmkJ5akZqemFqQWwWSZODilGpjmZ1YvcTob
	z7R//tqm+0+OHxTOZN6p6GyqaJP39Zi+ovSTtDVLN9fYifXX6kmY1l70P53RdENr9Ve3JxKJ
	cTvtz8RmhTUYn7C4n3vDe4tuj93HXcXL1J8cTQkt737hcG32u0uFp5jCzrDdtA5cHKLyszc4
	p+fjav/sxJ0edvL1WTZLVdf++v7U/EVr2d1HoZ63jMP3XX9tucc0Q0q0uS/lPoupxt9TB+P3
	sXtKf5l0Kui6mI7jm7Dv1Q8yikP8Z7P7Sv4x2Cj8XXuKuebhNa+O7fsdnq+7+OyGjxd8TasZ
	dlyf11/czqmjHKoc8ftsOD+v3Xwfyd+8D1dNyvnk12uweSv71q8Zj7yz7y0pklBiKc5INNRi
	LipOBADfPUQ1NAMAAA==
X-CMS-MailID: 20231226054502epcas5p4175bb019139535ed4216678c69604532
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231224154442epcas5p229ceb7d1000dd0949b89cded46d73bb7
References: <20231224-n-s5p-mfc-const-v1-0-a3b246470fe4@linaro.org>
	<CGME20231224154442epcas5p229ceb7d1000dd0949b89cded46d73bb7@epcas5p2.samsung.com>
	<20231224-n-s5p-mfc-const-v1-6-a3b246470fe4@linaro.org>



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: 24 December 2023 21:14
> To: Marek Szyprowski <m.szyprowski@samsung.com>; Andrzej Hajda
> <andrzej.hajda@intel.com>; Mauro Carvalho Chehab
> <mchehab@kernel.org>
> Cc: Aakarsh Jain <aakarsh.jain@samsung.com>; linux-fsd@tesla.coma; linux-
> samsung-soc@vger.kernel.org; Smitha T Murthy
> <smithatmurthy@gmail.com>; linux-arm-kernel@lists.infradead.org; linux-
> media@vger.kernel.org; linux-kernel@vger.kernel.org; Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org>
> Subject: [PATCH 06/15] media: s5p-mfc: constify s5p_mfc_variant structures
> 
> Static "s5p_mfc_variant" structures are not modified by the driver, so they
> can be made const for code safety.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
> index 6af7b812c5df..5d10c1cb8b92 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
> @@ -1529,7 +1529,7 @@ static const struct s5p_mfc_buf_size buf_size_v5 =
> {
>  	.priv	= &mfc_buf_size_v5,
>  };
> 
> -static struct s5p_mfc_variant mfc_drvdata_v5 = {
> +static const struct s5p_mfc_variant mfc_drvdata_v5 = {
>  	.version	= MFC_VERSION,
>  	.version_bit	= MFC_V5_BIT,
>  	.port_num	= MFC_NUM_PORTS,
> @@ -1554,7 +1554,7 @@ static const struct s5p_mfc_buf_size buf_size_v6 =
> {
>  	.priv	= &mfc_buf_size_v6,
>  };
> 
> -static struct s5p_mfc_variant mfc_drvdata_v6 = {
> +static const struct s5p_mfc_variant mfc_drvdata_v6 = {
>  	.version	= MFC_VERSION_V6,
>  	.version_bit	= MFC_V6_BIT,
>  	.port_num	= MFC_NUM_PORTS_V6,
> @@ -1583,7 +1583,7 @@ static const struct s5p_mfc_buf_size buf_size_v7 =
> {
>  	.priv	= &mfc_buf_size_v7,
>  };
> 
> -static struct s5p_mfc_variant mfc_drvdata_v7 = {
> +static const struct s5p_mfc_variant mfc_drvdata_v7 = {
>  	.version	= MFC_VERSION_V7,
>  	.version_bit	= MFC_V7_BIT,
>  	.port_num	= MFC_NUM_PORTS_V7,
> @@ -1593,7 +1593,7 @@ static struct s5p_mfc_variant mfc_drvdata_v7 = {
>  	.num_clocks	= 1,
>  };
> 
> -static struct s5p_mfc_variant mfc_drvdata_v7_3250 = {
> +static const struct s5p_mfc_variant mfc_drvdata_v7_3250 = {
>  	.version        = MFC_VERSION_V7,
>  	.version_bit    = MFC_V7_BIT,
>  	.port_num       = MFC_NUM_PORTS_V7,
> @@ -1617,7 +1617,7 @@ static const struct s5p_mfc_buf_size buf_size_v8 =
> {
>  	.priv	= &mfc_buf_size_v8,
>  };
> 
> -static struct s5p_mfc_variant mfc_drvdata_v8 = {
> +static const struct s5p_mfc_variant mfc_drvdata_v8 = {
>  	.version	= MFC_VERSION_V8,
>  	.version_bit	= MFC_V8_BIT,
>  	.port_num	= MFC_NUM_PORTS_V8,
> @@ -1627,7 +1627,7 @@ static struct s5p_mfc_variant mfc_drvdata_v8 = {
>  	.num_clocks	= 1,
>  };
> 
> -static struct s5p_mfc_variant mfc_drvdata_v8_5433 = {
> +static const struct s5p_mfc_variant mfc_drvdata_v8_5433 = {
>  	.version	= MFC_VERSION_V8,
>  	.version_bit	= MFC_V8_BIT,
>  	.port_num	= MFC_NUM_PORTS_V8,
> @@ -1652,7 +1652,7 @@ static const struct s5p_mfc_buf_size buf_size_v10
> = {
>  	.priv   = &mfc_buf_size_v10,
>  };
> 
> -static struct s5p_mfc_variant mfc_drvdata_v10 = {
> +static const struct s5p_mfc_variant mfc_drvdata_v10 = {
>  	.version        = MFC_VERSION_V10,
>  	.version_bit    = MFC_V10_BIT,
>  	.port_num       = MFC_NUM_PORTS_V10,
> 
> --
> 2.34.1

Reviewed-by: Aakarsh Jain <aakarsh.jain@samsung.com>

Thanks!


