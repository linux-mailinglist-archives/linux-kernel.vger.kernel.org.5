Return-Path: <linux-kernel+bounces-11376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8188681E551
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 06:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0598E1F2275D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 05:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435084BAA6;
	Tue, 26 Dec 2023 05:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uYOCEoC6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930824C3AB
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 05:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231226054905epoutp039c609c41b5e96fac5c89597d82746e34~kS6hiMCVH3086930869epoutp03L
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 05:49:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231226054905epoutp039c609c41b5e96fac5c89597d82746e34~kS6hiMCVH3086930869epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703569745;
	bh=hkQen3AdOWTbExNDUzRUzaRPsqqWvW9MnbDVqcJ13wU=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=uYOCEoC6JjNNd1BZ6egoj8hWNGc0uSJXlT83yW+Jp5EbPeDk6Mqh84xEsy8mZuP/v
	 oHizN/hmGnLoGIntU4b27vjvq4NbhEJy6KFhu/TpCvMRO5woWarCs3bQnbrCBqB/Et
	 2q6mX6aPRrlim2kfKoFp7IE2x4wt2XbMeVTZid+0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20231226054902epcas5p207dc58e0818905104a85359085efff99~kS6fCk3TJ0812208122epcas5p2w;
	Tue, 26 Dec 2023 05:49:02 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4SzkNY1GHtz4x9Q7; Tue, 26 Dec
	2023 05:49:01 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F0.02.09672.D496A856; Tue, 26 Dec 2023 14:49:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20231226051858epcas5p4f84108ba89d2f0ffa73b1ce56c87f264~kSgOwloSy1795017950epcas5p4s;
	Tue, 26 Dec 2023 05:18:58 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231226051858epsmtrp1df91f597d00655664111bea03d85c2c8~kSgOv6tJs1299112991epsmtrp1c;
	Tue, 26 Dec 2023 05:18:58 +0000 (GMT)
X-AuditID: b6c32a4b-39fff700000025c8-58-658a694d34e0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8E.A3.07368.2426A856; Tue, 26 Dec 2023 14:18:58 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20231226051857epsmtip1df10d5bfeb9118b0aede77fc79134c38~kSgNQ99os2994629946epsmtip1f;
	Tue, 26 Dec 2023 05:18:57 +0000 (GMT)
From: "Aakarsh Jain" <aakarsh.jain@samsung.com>
To: "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>, "'Marek
 Szyprowski'" <m.szyprowski@samsung.com>, "'Andrzej Hajda'"
	<andrzej.hajda@intel.com>, "'Mauro Carvalho Chehab'" <mchehab@kernel.org>
Cc: <linux-fsd@tesla.coma>, <linux-samsung-soc@vger.kernel.org>, "'Smitha T
 Murthy'" <smithatmurthy@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20231224-n-s5p-mfc-const-v1-3-a3b246470fe4@linaro.org>
Subject: RE: [PATCH 03/15] media: s5p-mfc: drop unused get_*_def_fmt
 declarations
Date: Tue, 26 Dec 2023 10:48:55 +0530
Message-ID: <15d001da37bb$0754f030$15fed090$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKOGlHY6WxiJqLoSx78067AznjgmAJOSHqoAlg72bCvLg0rYA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmlq5vZleqwcWnbBb3F39msdj7eiu7
	xabH11gtls0Osri8aw6bRc+GrawWM87vY7JYe+Quu8WyTX+YLFoal7A6cHnsnHWX3WPxnpdM
	HptWdbJ53Lm2h81j85J6j74tqxg9/r5+xebxeZNcAEdUtk1GamJKapFCal5yfkpmXrqtkndw
	vHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0IlKCmWJOaVAoYDE4mIlfTubovzSklSFjPzi
	Elul1IKUnAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyM099PsRVcEq7Y+mUWawPjKsEuRk4O
	CQETiQfrn7N3MXJxCAnsZpRoOfaeDcL5xCjx581PqMw3RolNnY/ZYVpOPL/NCJHYyyix/8h3
	JgjnOaPEsaeP2ECq2AT0Je6f6mEFSYgInGOU2NY/BayKWeAmUNWbmcxdjBwcnAIuEm+nh4M0
	CAsES/TP7mUBsVkEVCUW7ljDBFLCK2Ap0XM6GSTMKyAocXLmE7ASZgF5ie1v5zBDXKQg8fPp
	MlYQW0TASaLt/ytmiBpxiaM/e5hB1koIHOGQ6Ju/H+oFF4nWdTPZIGxhiVfHt0DFpSRe9rdB
	2ckSjxe9hFqQI7F+zxQWCNte4sCVOSwgtzELaEqs36UPEZaVmHpqHRPEXj6J3t9PmCDivBI7
	5sHYahJz7vxghbBlJA6vXso4gVFpFpLXZiF5bRaSF2YhbFvAyLKKUTK1oDg3PbXYtMA4L7Uc
	HuPJ+bmbGMFJWMt7B+OjBx/0DjEycTAeYpTgYFYS4ZVV7EgV4k1JrKxKLcqPLyrNSS0+xGgK
	DO6JzFKiyfnAPJBXEm9oYmlgYmZmZmJpbGaoJM77unVuipBAemJJanZqakFqEUwfEwenVANT
	7eFfDnIpba5bdzKEWzvsyug4a3t29+z57z0nXrfVm3fcJePosQ0/JNZIzLLqLGA0SJh6elPS
	rz7fJ8m+k+znz0m89+2la/VEZZGE7jJfN42oHVUuoVxy+llvQjbqnZ9gc2i5W7bdwW9fvY99
	Wmb748/m+2qvrzubL9lS4hJ2fO/2E41C7z2MfhRcWFifycu2Qu5BTJp8OqNTL1+E6yPTnM3r
	uHmOim7g/irC2R77xHFXTU/rip1v7vekGc2aXcOq+vjLZMV384IzljY9638T1M9SybMvOWlP
	u+kMZdPPS2unM6bKP9OKOvvgl07s3ft7d503/5GdEVRxKNNM+V7oBFumQx6yUi4us419nJyV
	WIozEg21mIuKEwFJ8n2zSwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWy7bCSnK5TUleqwfr96hb3F39msdj7eiu7
	xabH11gtls0Osri8aw6bRc+GrawWM87vY7JYe+Quu8WyTX+YLFoal7A6cHnsnHWX3WPxnpdM
	HptWdbJ53Lm2h81j85J6j74tqxg9/r5+xebxeZNcAEcUl01Kak5mWWqRvl0CV8bp76fYCi4J
	V2z9Mou1gXGVYBcjJ4eEgInEiee3GUFsIYHdjBJ7L6VDxGUk/rcdY4ewhSVW/nvODlHzlFHi
	x5FEEJtNQF/i/qke1i5GLg4RgQuMElv2LGADcZgF7jNKdG3azgTiCAmcBZq6dS+Qw8HBKeAi
	8XZ6OEi3sECgxMwzu1hAbBYBVYmFO9aAlfAKWEr0nE4GCfMKCEqcnPkErIRZQFui92ErI4Qt
	L7H97RxmiOMUJH4+XcYKYosIOEm0/X/FDFEjLnH0Zw/zBEbhWUhGzUIyahaSUbOQtCxgZFnF
	KJlaUJybnptsWGCYl1quV5yYW1yal66XnJ+7iREchVoaOxjvzf+nd4iRiYPxEKMEB7OSCK+s
	YkeqEG9KYmVValF+fFFpTmrxIUZpDhYlcV7DGbNThATSE0tSs1NTC1KLYLJMHJxSDUyT9n47
	snQTU46S4tGg9/znTucG/7sdmc0S+fbuP//VzOfUSiOOxVcUmt9MP3fdWpUvSX+nw03zM8Lp
	t1n7eoN2MUpuYpjK2VDkK3v8zkRFuedntuZs7TI/dr7tr+iSTzr2vqpHNe/WarDWcEl9ZPMs
	5OHxDNumvrxSxOtKkv6caF+FkC/LC/vKy/KWTuuMZxf51sf77cxLrZpfvE9Cliv+tV+y9Oy9
	s/pqAYFfez95+pjdO5N6qbOrc+6+ti/5xjtPd/OLvFv4Y3r6mfIn26XdzWp5b3bL2nBo3JG4
	8ypvx8nJP37LNN3dZLmkKuBrWaBJrMx9ycXHre7xbhRNUf4map4+xSW35ohIUV1bmBJLcUai
	oRZzUXEiAPyyW8QxAwAA
X-CMS-MailID: 20231226051858epcas5p4f84108ba89d2f0ffa73b1ce56c87f264
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231224154438epcas5p4eaeb4089c97bd804f1c0eb3fa756d2e4
References: <20231224-n-s5p-mfc-const-v1-0-a3b246470fe4@linaro.org>
	<CGME20231224154438epcas5p4eaeb4089c97bd804f1c0eb3fa756d2e4@epcas5p4.samsung.com>
	<20231224-n-s5p-mfc-const-v1-3-a3b246470fe4@linaro.org>



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
> Subject: [PATCH 03/15] media: s5p-mfc: drop unused get_*_def_fmt
> declarations
> 
> get_dec_def_fmt() and get_enc_def_fmt() do not have definitions, so their
> declarations are pointless.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.h | 1 -
> drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.h | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.h
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.h
> index 0c52ab46cff7..d4310966a0c2 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.h
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.h
> @@ -12,7 +12,6 @@
>  const struct s5p_mfc_codec_ops *get_dec_codec_ops(void);  struct
> vb2_ops *get_dec_queue_ops(void);  const struct v4l2_ioctl_ops
> *get_dec_v4l2_ioctl_ops(void); -struct s5p_mfc_fmt
> *get_dec_def_fmt(bool src);  int s5p_mfc_dec_ctrls_setup(struct
> s5p_mfc_ctx *ctx);  void s5p_mfc_dec_ctrls_delete(struct s5p_mfc_ctx
> *ctx);  void s5p_mfc_dec_init(struct s5p_mfc_ctx *ctx); diff --git
> a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.h
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.h
> index 3f1b1a037a4f..0cf08b8d40ff 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.h
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.h
> @@ -12,7 +12,6 @@
>  const struct s5p_mfc_codec_ops *get_enc_codec_ops(void);  struct
> vb2_ops *get_enc_queue_ops(void);  const struct v4l2_ioctl_ops
> *get_enc_v4l2_ioctl_ops(void); -struct s5p_mfc_fmt
> *get_enc_def_fmt(bool src);  int s5p_mfc_enc_ctrls_setup(struct
> s5p_mfc_ctx *ctx);  void s5p_mfc_enc_ctrls_delete(struct s5p_mfc_ctx
> *ctx);  void s5p_mfc_enc_init(struct s5p_mfc_ctx *ctx);
> 
> --
> 2.34.1

Reviewed-by: Aakarsh Jain <aakarsh.jain@samsung.com>

Thanks!


