Return-Path: <linux-kernel+bounces-132419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A6B8994A8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9A21C22696
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F52821350;
	Fri,  5 Apr 2024 05:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="q1Riz1Ni"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C3228E2
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 05:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712293896; cv=none; b=Enu2WcBgbquMF/WrAU04TeJnBNUF3ICjHu76J/wDg7Ejn3Zkbgq7KPY0LBuJp20bWtxu4tPj1w48mrM7xt+Uy/ZN1ZoLVGGVZfehMgjNgJgiJwvJRNB46dOncO4HyvQz/UIaiN2xf++erNlfRuL7y8QiUu4fp1msOIYNFpq4Gt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712293896; c=relaxed/simple;
	bh=ECfuPBixhevTExaEoM82zR7UK6Zo84mDciDVg4pO008=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=SH8WSF6EaNEkLH2jH19Vq3K+9ASGvOQf+GoRKmpmIJk4Q3S1mLDj+VCO2o3ayXJq3afqAxSq0QzpVw2hG2+wggNTd6q5EmjPCG13pn37BK8Ttz196EFyZX1ERa5qpQgFmI9nKPw/9mxb9tC+TokCDfNUF+WOHLBDzZpuYqq5mo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=q1Riz1Ni; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240405051125epoutp040f458c0e796a502a2669902b1560259f~DSjdq7PRq2063620636epoutp04q
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 05:11:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240405051125epoutp040f458c0e796a502a2669902b1560259f~DSjdq7PRq2063620636epoutp04q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1712293885;
	bh=Sg1g9N/G1pvV115mMMnWln56UDO17G4Nqgp6n10MxAU=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=q1Riz1NiMrxFpa5owQaFIPQy4RYpkYGS7y4BcUrboRyVDZDE9xfJm4tlYXtGL80Dr
	 srvgoOZCiM4r29xhsh+Zy7Sbg0pEFakhlksBBQ/I6RSGSuKGjz9k49FrX/mnmcv4Ok
	 AjJkx7nIYfGkIGb8ltZjiKoaBR92lDh5lT03h7vs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240405051124epcas1p2bf5cf35b3047c5698f9ca4a9e69e58d6~DSjdKC-ai0826508265epcas1p2U;
	Fri,  5 Apr 2024 05:11:24 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.231]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4V9mmX0sYHz4x9Q7; Fri,  5 Apr
	2024 05:11:24 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	4C.1E.09663.BF78F066; Fri,  5 Apr 2024 14:11:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240405051123epcas1p271e78f5d3b844af6511d7e591df887d7~DSjcOEsKQ0445304453epcas1p2o;
	Fri,  5 Apr 2024 05:11:23 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240405051123epsmtrp2f2a5f9764c39b1081fecfee10c7a5cff~DSjcNSsTB0503805038epsmtrp2Z;
	Fri,  5 Apr 2024 05:11:23 +0000 (GMT)
X-AuditID: b6c32a37-2f9ff700000025bf-03-660f87fbcbc0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	29.C0.07541.BF78F066; Fri,  5 Apr 2024 14:11:23 +0900 (KST)
Received: from inkidae001 (unknown [10.113.221.213]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240405051123epsmtip15d4fe3d57130e9c0c35db04f6492aa13~DSjb_hNYb2139921399epsmtip1G;
	Fri,  5 Apr 2024 05:11:23 +0000 (GMT)
From: =?UTF-8?B?64yA7J246riwL1RpemVuIFBsYXRmb3JtIExhYihTUikv7IK87ISx7KCE7J6Q?=
	<inki.dae@samsung.com>
To: "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>, "'Seung-Woo
 Kim'" <sw0312.kim@samsung.com>, "'Kyungmin Park'"
	<kyungmin.park@samsung.com>, "'David Airlie'" <airlied@gmail.com>, "'Daniel
 Vetter'" <daniel@ffwll.ch>, "'Alim Akhtar'" <alim.akhtar@samsung.com>
Cc: <dri-devel@lists.freedesktop.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
In-Reply-To: <20240330-b4-module-owner-drm-exynos-v1-0-3fa30e2c7e5a@linaro.org>
Subject: RE: [PATCH 00/11] drm/exynos: drop driver owner initialization
Date: Fri, 5 Apr 2024 14:11:23 +0900
Message-ID: <017601da8717$b3ebbee0$1bc33ca0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQEofrVXOxMdMsLkDHpOmMtI8zwlmAIjrw+ysqwUVQA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEJsWRmVeSWpSXmKPExsWy7bCmge6fdv40gydXmC1OXF/EZPFg3jY2
	i//bJjJbXPn6ns1i7+ut7BZnm96wW2x6fI3V4vKuOWwWM87vY7KYMfklmwOXx95vC1g8ds66
	y+5x59oeNo/73ceZPDYvqffo27KK0ePzJrkA9qhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hT
	MwNDXUNLC3MlhbzE3FRbJRefAF23zByg85QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqp
	BSk5BaYFesWJucWleel6eaklVoYGBkamQIUJ2RkdT/YyFpwQqrgw6xJbA2MffxcjB4eEgInE
	xadqXYxcHEICOxglOvbMY4JwPjFKXDvTzALhfGOUaP/xl62LkROsY/+J56wQib2MEo93fmSD
	cF4ySryfuoIFpIpNIF3ibncD2CwRgclMEqtOfGcGcZgFpjFKHJrbyQRSxSngL7HvVxMziC0s
	4C5xZOpUMJtFQEXi3YyXTCAX8gpYSjTNkwIJ8woISpyc+QRsAbOAvMT2t3OYIU5SkPj5dBkr
	RFxEYnZnG1hcRMBK4tCmJnaQvRICBzgk9jT+ZYFocJFYM3khI4QtLPHq+BZ2CFtK4vO7vWwQ
	DZMZJe5cX8EC4cxglDj88zpUh7HE/qWTwa5jFtCUWL9LH2Izn8S7rz2skGDllehoE4KoVpI4
	dvEGVKeExIUlE6Hh6CFx9fB9xgmMirOQ/DYLyW+zkPwzC2HZAkaWVYxiqQXFuempxYYFxvD4
	Ts7P3cQITrxa5jsYp739oHeIkYmD8RCjBAezkghvtwNvmhBvSmJlVWpRfnxRaU5q8SFGU2Bg
	T2SWEk3OB6b+vJJ4QxNLAxMzI2MTC0MzQyVx3jNXylKFBNITS1KzU1MLUotg+pg4OKUamA6W
	rJ8vaPnxpWui3O6prjVptps75desf9Gc8ObYtW0LQubwWFdu8+RZXdSiy/LraO5refGli2ws
	FvHYPHxaeX6mQtW8g2xf5wqUF5pont2juTA5l19KZ0P/ksN88+wf3On0XLFro6ehLGOPs7B1
	kq2oUHSpwgafhy07v7y06W45991MSuT0ai3bet72ylW1K1ms+lhqam9eEt+hkTUjzlPhw59r
	b+86z5LnvSywSn7dxa9VJrOetigFHeMx0Qp/qdq5yKj0/k1FYc4vrYuc1u+93L55/5OSv2VT
	/7vXM0/54L7oTK7t2+h/cT4Nbz8xqycKcB553ufuumCL2UO+3nqBEga5Y3luZw/mfrJfpcRS
	nJFoqMVcVJwIACrsKa9FBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSnO7vdv40g7+nFS1OXF/EZPFg3jY2
	i//bJjJbXPn6ns1i7+ut7BZnm96wW2x6fI3V4vKuOWwWM87vY7KYMfklmwOXx95vC1g8ds66
	y+5x59oeNo/73ceZPDYvqffo27KK0ePzJrkA9igum5TUnMyy1CJ9uwSujI4nexkLTghVXJh1
	ia2BsY+/i5GTQ0LARGL/ieesXYxcHEICuxkl9k5YwtjFyAGUkJDYspUDwhSWOHy4GKLkOaNE
	y/upzCC9bAKpEjc+fWQHSYgITGeSWNR7BGwQs8AMRom12y4xQbQsYJQ4dvQ5C0gLp4C/xL5f
	TWDtwgLuEkemQoxiEVCReDfjJRPIOl4BS4mmeVIgYV4BQYmTM5+AtTILaEv0PmxlhLDlJba/
	ncMM8YGCxM+ny1gh4iISszvbwOIiAlYShzY1sU9gFJ6FZNQsJKNmIRk1C0n7AkaWVYySqQXF
	uem5yYYFhnmp5XrFibnFpXnpesn5uZsYwfGnpbGD8d78f3qHGJk4GA8xSnAwK4nwdjvwpgnx
	piRWVqUW5ccXleakFh9ilOZgURLnNZwxO0VIID2xJDU7NbUgtQgmy8TBKdXAVLjF5JPe02fi
	T04HNBhF9uQvfVxed0Hp5qFnL2SVt6jMnL77tozuypsWmW8+v3/xc/GmK4/PbpUOcN070Ua9
	Kijl6zXdxmhzi6sbDvPuNoh+et57a1XKiTi5zwzKWdf+1JQWZJpcz15+osNQMnxFdF/tce8H
	C4+Z5kVduXCzqnjxslUW1yKA6YH18H/FBZrHJapqd1WsrvqaMePKbWZHB2vx6nKt3CNCfDdk
	V5o9PnmUL30vm2jahPXNN+rczYuVLCWXVkftfHThxrWQ/wvubZzEYKvYxz51hqXGrMjVM7ir
	Mh33HPki+NfK5JTG5Bdyrx4U3fBee6yJJaVXZFt6LbspV9iaxodx6lb+DZ9rlViKMxINtZiL
	ihMBXtExwy4DAAA=
X-CMS-MailID: 20240405051123epcas1p271e78f5d3b844af6511d7e591df887d7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240330203328epcas1p3132c85946c00e6a2432d3e23db6213e8
References: <CGME20240330203328epcas1p3132c85946c00e6a2432d3e23db6213e8@epcas1p3.samsung.com>
	<20240330-b4-module-owner-drm-exynos-v1-0-3fa30e2c7e5a@linaro.org>

Hi Krzysztof,

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Sunday, March 31, 2024 5:33 AM
> To: Inki Dae <inki.dae@samsung.com>; Seung-Woo Kim
> <sw0312.kim@samsung.com>; Kyungmin Park <kyungmin.park@samsung.com>; David
> Airlie <airlied@gmail.com>; Daniel Vetter <daniel@ffwll.ch>; Krzysztof
> Kozlowski <krzysztof.kozlowski@linaro.org>; Alim Akhtar
> <alim.akhtar@samsung.com>
> Cc: dri-devel@lists.freedesktop.org; linux-arm-kernel@lists.infradead.org;
> linux-samsung-soc@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH 00/11] drm/exynos: drop driver owner initialization
> 
> Simplify the code by dropping unnecessary .owner initialization in the
> driver.

Applied.

Thanks. :)
Inki Dae

> 
> Best regards,
> Krzysztof
> 
> ---
> Krzysztof Kozlowski (11):
>       drm/exynos: fimc: drop driver owner initialization
>       drm/exynos: fimd: drop driver owner initialization
>       drm/exynos: dsi: drop driver owner initialization
>       drm/exynos: g2d: drop driver owner initialization
>       drm/exynos: gsc: drop driver owner initialization
>       drm/exynos: mic: drop driver owner initialization
>       drm/exynos: rotator: drop driver owner initialization
>       drm/exynos: scaler: drop driver owner initialization
>       drm/exynos: vidi: drop driver owner initialization
>       drm/exynos: hdmi: drop driver owner initialization
>       drm/exynos: mixer: drop driver owner initialization
> 
>  drivers/gpu/drm/exynos/exynos_drm_dsi.c     | 1 -
>  drivers/gpu/drm/exynos/exynos_drm_fimc.c    | 1 -
>  drivers/gpu/drm/exynos/exynos_drm_fimd.c    | 1 -
>  drivers/gpu/drm/exynos/exynos_drm_g2d.c     | 1 -
>  drivers/gpu/drm/exynos/exynos_drm_gsc.c     | 1 -
>  drivers/gpu/drm/exynos/exynos_drm_mic.c     | 1 -
>  drivers/gpu/drm/exynos/exynos_drm_rotator.c | 1 -
>  drivers/gpu/drm/exynos/exynos_drm_scaler.c  | 1 -
>  drivers/gpu/drm/exynos/exynos_drm_vidi.c    | 1 -
>  drivers/gpu/drm/exynos/exynos_hdmi.c        | 1 -
>  drivers/gpu/drm/exynos/exynos_mixer.c       | 1 -
>  11 files changed, 11 deletions(-)
> ---
> base-commit: 7fdcff3312e16ba8d1419f8a18f465c5cc235ecf
> change-id: 20240330-b4-module-owner-drm-exynos-d2f1b2d48af3
> 
> Best regards,
> --
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 



