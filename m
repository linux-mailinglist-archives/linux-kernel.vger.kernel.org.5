Return-Path: <linux-kernel+bounces-11428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D9481E621
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F1F5B20FC8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 09:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D75D4CE1A;
	Tue, 26 Dec 2023 09:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NZKatsOS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4045D4CDF9
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 09:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231226090318epoutp04b085411b493d5600af8fe63596365a60~kVkFyH__h2392723927epoutp044
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 09:03:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231226090318epoutp04b085411b493d5600af8fe63596365a60~kVkFyH__h2392723927epoutp044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703581398;
	bh=lQRe+owTbimdd8Sp6N+poqTXfo6QgtFnNj5z5IZviKo=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=NZKatsOSJ5xstGkHsKkQHk8Wa4sptGRbZEM+QplYGs9PbAMBxIR9949mBO3Qf8WLd
	 i7ufNvVywlR26qJUtODtbnS/Pgb9sVSmWdhfUDG+dCiZ92CbKVkRSu52AtCNvHuVQd
	 6B7aVSBX3KVRAo4rP2srg3mjGbG0NlQRe77uUfmE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20231226090317epcas5p4e85595818e86b20e766b7f254c7e2007~kVkFQbmny3126531265epcas5p4n;
	Tue, 26 Dec 2023 09:03:17 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Szphg5TLJz4x9Q1; Tue, 26 Dec
	2023 09:03:15 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EA.AF.19369.3D69A856; Tue, 26 Dec 2023 18:03:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20231226085324epcas5p28fdb50c880752cab3e5e949f829e216f~kVbcwRGpo2527825278epcas5p2L;
	Tue, 26 Dec 2023 08:53:24 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231226085324epsmtrp1c575756ed28e9ae60a273c4a5b79a73d~kVbcswjw_0472704727epsmtrp1O;
	Tue, 26 Dec 2023 08:53:24 +0000 (GMT)
X-AuditID: b6c32a50-c99ff70000004ba9-de-658a96d35cab
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2D.5F.07368.4849A856; Tue, 26 Dec 2023 17:53:24 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20231226085322epsmtip110d49d9d15d4341de41e5161909a1015~kVbbIaMr00059800598epsmtip1Z;
	Tue, 26 Dec 2023 08:53:22 +0000 (GMT)
From: "Aakarsh Jain" <aakarsh.jain@samsung.com>
To: "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>, "'Marek
 Szyprowski'" <m.szyprowski@samsung.com>, "'Andrzej Hajda'"
	<andrzej.hajda@intel.com>, "'Mauro Carvalho Chehab'" <mchehab@kernel.org>
Cc: <linux-fsd@tesla.coma>, <linux-samsung-soc@vger.kernel.org>, "'Smitha T
 Murthy'" <smithatmurthy@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20231224-n-s5p-mfc-const-v1-4-a3b246470fe4@linaro.org>
Subject: RE: [PATCH 04/15] media: s5p-mfc: constify fw_name strings
Date: Tue, 26 Dec 2023 14:23:21 +0530
Message-ID: <15d501da37d8$fc10bd30$f4323790$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKOGlHY6WxiJqLoSx78067AznjgmAEpEv+0APqc4dOvQl7NcA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmlu7laV2pBjNnaFrcX/yZxWLv663s
	FpseX2O1WDY7yOLyrjlsFj0btrJazDi/j8li7ZG77BbLNv1hsmhpXMLqwOWxc9Zddo/Fe14y
	eWxa1cnmcefaHjaPzUvqPfq2rGL0+Pv6FZvH501yARxR2TYZqYkpqUUKqXnJ+SmZeem2St7B
	8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QCcqKZQl5pQChQISi4uV9O1sivJLS1IVMvKL
	S2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7IzDh36xFjQyVux5MUSpgbGhdxdjJwc
	EgImEjd+7WftYuTiEBLYwyjxau8ZdgjnE6PE5i8v2EGqhAS+MUo82BoN03Hv0kxGiKK9jBKL
	+65CtT9nlJhxACTDycEmoC9x/1QPWEJE4ByjxLb+KUwgDrPATUaJY29mMncxcnBwCrhInFlb
	B9IgLOAs8e/wdrB1LAKqEmubFzOD2LwClhJ/Lk1ggbAFJU7OfAJmMwvIS2x/O4cZ4iQFiZ9P
	l7GCjBQRcJKYtd0XokRc4ujPHqiSIxwSbas4IGwXiUsbNrNA2MISr45vYYewpSRe9rdB2ckS
	jxe9hOrNkVi/ZwpUvb3EgStzWEBWMQtoSqzfpQ8RlpWYemodE8RaPone30+YIOK8Ejvmwdhq
	EnPu/GCFsGUkDq9eyjiBUWkWksdmIXlsFpIPZiFsW8DIsopRKrWgODc9Ndm0wFA3L7UcHuHJ
	+bmbGMEpWCtgB+PqDX/1DjEycTAeYpTgYFYS4ZVV7EgV4k1JrKxKLcqPLyrNSS0+xGgKDO6J
	zFKiyfnALJBXEm9oYmlgYmZmZmJpbGaoJM77unVuipBAemJJanZqakFqEUwfEwenVAOTmK+k
	yQ79j0lSXmJqM3+3HSratuud19OM4OKOiRdMk9gMLmz5kffmVa9L4yP2Mp7u9N9CvC+vvHu7
	WCzKrHudqt/X5DbuGarzJDK497bP3LXcVpN16e2dMrJKhuGpCVwVW2y0u7uY3h9mWVc951V9
	VKTeKRvJDgHPOYoBuWddS59u2HT9A+eSW06rarjLPjB8FxeKU+19G2DAG/Zvx4RJkzrYT2+X
	evSw4/IFznOVvJ95T4ft/5Pq3v3cZ5pbz/fd9m/O/+Asyfr61mL27IknTQ4YBfkfL9/QdnFn
	oPJW866pL9b2V52VnTz5UpnKh2NWE3aoWSyfyuLhV9+UoWiQxey8Q1L0YOqbWScXH36hxFKc
	kWioxVxUnAgAgADVmUoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsWy7bCSnG7LlK5Ug1tn2CzuL/7MYrH39VZ2
	i02Pr7FaLJsdZHF51xw2i54NW1ktZpzfx2Sx9shddotlm/4wWbQ0LmF14PLYOesuu8fiPS+Z
	PDat6mTzuHNtD5vH5iX1Hn1bVjF6/H39is3j8ya5AI4oLpuU1JzMstQifbsEroxDhz4xFnTy
	Vix5sYSpgXEhdxcjJ4eEgInEvUszGbsYuTiEBHYzSiya+Y8ZIiEj8b/tGDuELSyx8t9zMFtI
	4CmjxMG7JSA2m4C+xP1TPawgzSICFxgltuxZwAbiMAvcZ5To2rSdCWLsWUaJQ/OusHQxcnBw
	CrhInFlbB9ItLOAs8e/wdrCpLAKqEmubF4Nt5hWwlPhzaQILhC0ocXLmEzCbWUBbovdhKyOE
	LS+x/e0cqEsVJH4+XcYKMl5EwEli1nZfiBJxiaM/e5gnMArPQjJpFpJJs5BMmoWkZQEjyypG
	ydSC4tz03GTDAsO81HK94sTc4tK8dL3k/NxNjOA41NLYwXhv/j+9Q4xMHIyHGCU4mJVEeGUV
	O1KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xrOmJ0iJJCeWJKanZpakFoEk2Xi4JRqYDqhvuXW
	n/AgRivdc97J6h9u3yp6H1G1+u/ZIHU5z4IOubKinG0cJlffLz2uLxz2K6aPP5AvWW5XRcD1
	mO0SUs4Ksy+x+xucvH7ELs20xa3vca/xycv5iewM5wzlJ9n8luirkrsy8//Vys4Q9ceOzrZV
	DwPSAla/l1yaLxp7wSVxkfSe0PnvpCRidnjVfqlb/i348m87yam5t52lOFocr3kHsd0wk1Zh
	DAu9tMMtc7v69NJQ4xtlShPULe6ZcDRMuLuNrzpN5rdAdKN66of2Tdyv1eqAYXHXOlBXJZDz
	TzDnmvNhu87IKj2+fMZEu6tkfe6l6OXMsY/LLc/ov5/jlnU2z37jdG+HtZvn/lBiKc5INNRi
	LipOBADtgQakMgMAAA==
X-CMS-MailID: 20231226085324epcas5p28fdb50c880752cab3e5e949f829e216f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231224154440epcas5p3c2f26174c8b32edf390629f1e829403a
References: <20231224-n-s5p-mfc-const-v1-0-a3b246470fe4@linaro.org>
	<CGME20231224154440epcas5p3c2f26174c8b32edf390629f1e829403a@epcas5p3.samsung.com>
	<20231224-n-s5p-mfc-const-v1-4-a3b246470fe4@linaro.org>



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
> Subject: [PATCH 04/15] media: s5p-mfc: constify fw_name strings
> 
> Constify stored pointers to firmware names for code safety.  These are not
> modified by the driver.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> index 5304f42c8c72..f33a755327ef 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> @@ -227,7 +227,7 @@ struct s5p_mfc_variant {
>  	unsigned int port_num;
>  	u32 version_bit;
>  	struct s5p_mfc_buf_size *buf_size;
> -	char	*fw_name[MFC_FW_MAX_VERSIONS];
> +	const char	*fw_name[MFC_FW_MAX_VERSIONS];
>  	const char	*clk_names[MFC_MAX_CLOCKS];
>  	int		num_clocks;
>  	bool		use_clock_gating;
> 
> --
> 2.34.1

Reviewed-by: Aakarsh Jain <aakarsh.jain@samsung.com>

Thanks!


