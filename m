Return-Path: <linux-kernel+bounces-11377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B2C81E554
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 06:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11E981F2274E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 05:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416A84BAAA;
	Tue, 26 Dec 2023 05:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="W0DAspUY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F944C3C7
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 05:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231226054918epoutp028bf2c1e1b9126da2c19498ec5b1dbcd1~kS6t6uHh41946119461epoutp028
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 05:49:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231226054918epoutp028bf2c1e1b9126da2c19498ec5b1dbcd1~kS6t6uHh41946119461epoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703569758;
	bh=QGoy2nJdjcdnaul3wYhlPgWg9GOfx5HxXC9YSrGrIk8=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=W0DAspUYnubOOO0cM25bWsNdORoBnsbSELWS+1uaPDNTM3RZKGoTTltr4pn8fbuGM
	 /XbJyfP7ycMURpEOlBxLG6R/ahe3F4scd0fFKF6JVYGnOQ9poOF1XXT2oSjRSY6xwO
	 HkgoDMLeUvQmE/T7T3DvqxrEV1jxjW+3K0TChMCs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20231226054918epcas5p166498f7df1d23b4a67330267e13247ae~kS6tOJ8PC0916309163epcas5p1X;
	Tue, 26 Dec 2023 05:49:18 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4SzkNr31jBz4x9Pv; Tue, 26 Dec
	2023 05:49:16 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	28.D5.10009.C596A856; Tue, 26 Dec 2023 14:49:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20231226054352epcas5p4ef0146716bc8d9b7c552e73fd8441318~kS19flDG70420304203epcas5p4f;
	Tue, 26 Dec 2023 05:43:52 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231226054352epsmtrp17c4b5be6889da7c2e5d17c2b3f14fb22~kS19exPZR2744827448epsmtrp1F;
	Tue, 26 Dec 2023 05:43:52 +0000 (GMT)
X-AuditID: b6c32a4a-261fd70000002719-d6-658a695c2b95
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	64.DA.08755.7186A856; Tue, 26 Dec 2023 14:43:51 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20231226054350epsmtip268103a7a425efd4c97203b76eaf47c3b~kS177-Zt81877918779epsmtip2Y;
	Tue, 26 Dec 2023 05:43:50 +0000 (GMT)
From: "Aakarsh Jain" <aakarsh.jain@samsung.com>
To: "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>, "'Marek
 Szyprowski'" <m.szyprowski@samsung.com>, "'Andrzej Hajda'"
	<andrzej.hajda@intel.com>, "'Mauro Carvalho Chehab'" <mchehab@kernel.org>
Cc: <linux-fsd@tesla.coma>, <linux-samsung-soc@vger.kernel.org>, "'Smitha T
 Murthy'" <smithatmurthy@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20231224-n-s5p-mfc-const-v1-5-a3b246470fe4@linaro.org>
Subject: RE: [PATCH 05/15] media: s5p-mfc: constify s5p_mfc_buf_size
 structures
Date: Tue, 26 Dec 2023 11:13:49 +0530
Message-ID: <15d101da37be$818f7f70$84ae7e50$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKOGlHY6WxiJqLoSx78067AznjgmAEkj0yKAmH/OB+vNxO3AA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmhm5MZleqwdJDohb3F39msdj7eiu7
	xabH11gtls0Osri8aw6bRc+GrawWM87vY7JYe+Quu8WyTX+YLFoal7A6cHnsnHWX3WPxnpdM
	HptWdbJ53Lm2h81j85J6j74tqxg9/r5+xebxeZNcAEdUtk1GamJKapFCal5yfkpmXrqtkndw
	vHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0IlKCmWJOaVAoYDE4mIlfTubovzSklSFjPzi
	Elul1IKUnAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMF983MResCa7Y29DF2sC43q2LkZND
	QsBEom9zH3sXIxeHkMBuRolVLztZIJxPjBIb1h9ghHC+MUpc3dHIBtNyc0cjM0RiL6PEsn/T
	mSCc54wS327MZgapYhPQl7h/qocVJCEicI5RYlv/FLAqZoGbjBLH3swEq+IUcJHoPfWLFcQW
	FgiUmHjpAQuIzSKgKjHtzg6wfbwClhKvT1+GsgUlTs58AlbDLCAvsf3tHGaImxQkfj5dBjSH
	A2ibk8TUR+oQJeISR3/2gJ0qIXCEQ6Jt+SMmiHoXicmXtzJC2MISr45vYYewpSRe9rdB2ckS
	jxe9hJqfI7F+zxQWCNte4sCVOSwgu5gFNCXW79KHCMtKTD21jgliL59E7+8nUKt4JXbMg7HV
	JObc+cEKYctIHF69lHECo9IsJJ/NQvLZLCQvzELYtoCRZRWjZGpBcW56arFpgVFeajk8ypPz
	czcxgtOwltcOxocPPugdYmTiYDzEKMHBrCTCK6vYkSrEm5JYWZValB9fVJqTWnyI0RQY3BOZ
	pUST84GZIK8k3tDE0sDEzMzMxNLYzFBJnPd169wUIYH0xJLU7NTUgtQimD4mDk6pBqa5p55l
	TfYRSzjTa+7za9Px1JXrk08odSWcFNunuXG/5uoNi3eWb1Pu8Qq+a6OxP2q7zalPdsxVUor9
	v+J12TxPvL+7rnU1512zhSXJf+d+OLIhUihSkfF2yGbpnu/7F21hvTVvf+6PoO1/b7mL/Kx8
	v+hbiYLCDF5hoYxtWo++35vXZl54X6stQWfRQa38woNxxvkTGBckCjLci1I7ujr6SmHF4q1T
	1YViLDfndbnxizZvPXy9l/fUjRuPL6S4VTx5zhv45HnA3n+brc82rQ/ivKLKKLBCX+vI7QnC
	XOcYPrlKdPtNPfsjMUdjtuSCxsBl/9b8fbwn/efMTFOLY4+fbnFivVlQF6IRdWlRw53jSizF
	GYmGWsxFxYkADo8gi0wEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsWy7bCSvK54Rleqwdln5hb3F39msdj7eiu7
	xabH11gtls0Osri8aw6bRc+GrawWM87vY7JYe+Quu8WyTX+YLFoal7A6cHnsnHWX3WPxnpdM
	HptWdbJ53Lm2h81j85J6j74tqxg9/r5+xebxeZNcAEcUl01Kak5mWWqRvl0CV8aL75uYC9YE
	V+xt6GJtYFzv1sXIySEhYCJxc0cjcxcjF4eQwG5GiTMfF7NBJGQk/rcdY4ewhSVW/nvODlH0
	lFHi3oG3LCAJNgF9ifunelhBEiICFxgltuxZwAbiMAvcZ5To2rSdCaLlLKNES/8TZpAWTgEX
	id5Tv1hBbGEBf4mLF1+D2SwCqhLT7uwA280rYCnx+vRlKFtQ4uTMJ2DrmAW0JXoftjJC2PIS
	29/OYYa4T0Hi59NlQHM4gM5wkpj6SB2iRFzi6M8e5gmMwrOQTJqFZNIsJJNmIWlZwMiyilEy
	taA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjOBa1NHcwbl/1Qe8QIxMH4yFGCQ5mJRFeWcWO
	VCHelMTKqtSi/Pii0pzU4kOM0hwsSuK84i96U4QE0hNLUrNTUwtSi2CyTBycUg1MzddUn3xa
	/ctvofytZZPvNzh9Dztj9t6DLZdB/dUUx19dp014v4sduCHy1vbpgq09Fg7hvw0S+UUO3m/m
	aHwV1LI+olovvlvwkZ277swr1Tqfvc9MYv547m6Z675wQdlXTstX5b8Wi/6i0xV1osXn0mme
	NQemM8RuSRPrX7L56/7dH/zeN25qmL338AYT8VXn6poXBi16U+tvsPzEqosys7uSFK7Py3EW
	+G+gn2bw8bf37p2phuZa17u767c93OTq4cO450in47etxfs6zuYfa/X1FL8Rntq3lb3c7eSy
	J+ZnlMT5D0dMizKVWGK6Uq2v4ATPVXfbaZ89fpl91XApODjv2M8H8WbGQac/TPBLUmIpzkg0
	1GIuKk4EALBVtr80AwAA
X-CMS-MailID: 20231226054352epcas5p4ef0146716bc8d9b7c552e73fd8441318
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231224154441epcas5p3c802781d7e3fc305be11e19caee7b639
References: <20231224-n-s5p-mfc-const-v1-0-a3b246470fe4@linaro.org>
	<CGME20231224154441epcas5p3c802781d7e3fc305be11e19caee7b639@epcas5p3.samsung.com>
	<20231224-n-s5p-mfc-const-v1-5-a3b246470fe4@linaro.org>



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
> Subject: [PATCH 05/15] media: s5p-mfc: constify s5p_mfc_buf_size
> structures
> 
> Static "s5p_mfc_buf_size*" structures are not modified by the driver, so
> they can be made const for code safety.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c     | 20 ++++++++++---
> -------
>  .../media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c  |  2 +-
> .../media/platform/samsung/s5p-mfc/s5p_mfc_common.h  |  4 ++--
> drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c |  2 +-
> .../media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c  |  6 +++---
> .../media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c  |  6 +++---
>  6 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
> index e30e54935d79..6af7b812c5df 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
> @@ -1516,14 +1516,14 @@ static const struct dev_pm_ops
> s5p_mfc_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(s5p_mfc_suspend, s5p_mfc_resume)
> };
> 
> -static struct s5p_mfc_buf_size_v5 mfc_buf_size_v5 = {
> +static const struct s5p_mfc_buf_size_v5 mfc_buf_size_v5 = {
>  	.h264_ctx	= MFC_H264_CTX_BUF_SIZE,
>  	.non_h264_ctx	= MFC_CTX_BUF_SIZE,
>  	.dsc		= DESC_BUF_SIZE,
>  	.shm		= SHARED_BUF_SIZE,
>  };
> 
> -static struct s5p_mfc_buf_size buf_size_v5 = {
> +static const struct s5p_mfc_buf_size buf_size_v5 = {
>  	.fw	= MAX_FW_SIZE,
>  	.cpb	= MAX_CPB_SIZE,
>  	.priv	= &mfc_buf_size_v5,
> @@ -1540,7 +1540,7 @@ static struct s5p_mfc_variant mfc_drvdata_v5 = {
>  	.use_clock_gating = true,
>  };
> 
> -static struct s5p_mfc_buf_size_v6 mfc_buf_size_v6 = {
> +static const struct s5p_mfc_buf_size_v6 mfc_buf_size_v6 = {
>  	.dev_ctx	= MFC_CTX_BUF_SIZE_V6,
>  	.h264_dec_ctx	= MFC_H264_DEC_CTX_BUF_SIZE_V6,
>  	.other_dec_ctx	= MFC_OTHER_DEC_CTX_BUF_SIZE_V6,
> @@ -1548,7 +1548,7 @@ static struct s5p_mfc_buf_size_v6 mfc_buf_size_v6
> = {
>  	.other_enc_ctx	= MFC_OTHER_ENC_CTX_BUF_SIZE_V6,
>  };
> 
> -static struct s5p_mfc_buf_size buf_size_v6 = {
> +static const struct s5p_mfc_buf_size buf_size_v6 = {
>  	.fw	= MAX_FW_SIZE_V6,
>  	.cpb	= MAX_CPB_SIZE_V6,
>  	.priv	= &mfc_buf_size_v6,
> @@ -1569,7 +1569,7 @@ static struct s5p_mfc_variant mfc_drvdata_v6 = {
>  	.num_clocks	= 1,
>  };
> 
> -static struct s5p_mfc_buf_size_v6 mfc_buf_size_v7 = {
> +static const struct s5p_mfc_buf_size_v6 mfc_buf_size_v7 = {
>  	.dev_ctx	= MFC_CTX_BUF_SIZE_V7,
>  	.h264_dec_ctx	= MFC_H264_DEC_CTX_BUF_SIZE_V7,
>  	.other_dec_ctx	= MFC_OTHER_DEC_CTX_BUF_SIZE_V7,
> @@ -1577,7 +1577,7 @@ static struct s5p_mfc_buf_size_v6 mfc_buf_size_v7
> = {
>  	.other_enc_ctx	= MFC_OTHER_ENC_CTX_BUF_SIZE_V7,
>  };
> 
> -static struct s5p_mfc_buf_size buf_size_v7 = {
> +static const struct s5p_mfc_buf_size buf_size_v7 = {
>  	.fw	= MAX_FW_SIZE_V7,
>  	.cpb	= MAX_CPB_SIZE_V7,
>  	.priv	= &mfc_buf_size_v7,
> @@ -1603,7 +1603,7 @@ static struct s5p_mfc_variant mfc_drvdata_v7_3250
> = {
>  	.num_clocks     = 2,
>  };
> 
> -static struct s5p_mfc_buf_size_v6 mfc_buf_size_v8 = {
> +static const struct s5p_mfc_buf_size_v6 mfc_buf_size_v8 = {
>  	.dev_ctx	= MFC_CTX_BUF_SIZE_V8,
>  	.h264_dec_ctx	= MFC_H264_DEC_CTX_BUF_SIZE_V8,
>  	.other_dec_ctx	= MFC_OTHER_DEC_CTX_BUF_SIZE_V8,
> @@ -1611,7 +1611,7 @@ static struct s5p_mfc_buf_size_v6 mfc_buf_size_v8
> = {
>  	.other_enc_ctx	= MFC_OTHER_ENC_CTX_BUF_SIZE_V8,
>  };
> 
> -static struct s5p_mfc_buf_size buf_size_v8 = {
> +static const struct s5p_mfc_buf_size buf_size_v8 = {
>  	.fw	= MAX_FW_SIZE_V8,
>  	.cpb	= MAX_CPB_SIZE_V8,
>  	.priv	= &mfc_buf_size_v8,
> @@ -1637,7 +1637,7 @@ static struct s5p_mfc_variant mfc_drvdata_v8_5433
> = {
>  	.num_clocks	= 3,
>  };
> 
> -static struct s5p_mfc_buf_size_v6 mfc_buf_size_v10 = {
> +static const struct s5p_mfc_buf_size_v6 mfc_buf_size_v10 = {
>  	.dev_ctx        = MFC_CTX_BUF_SIZE_V10,
>  	.h264_dec_ctx   = MFC_H264_DEC_CTX_BUF_SIZE_V10,
>  	.other_dec_ctx  = MFC_OTHER_DEC_CTX_BUF_SIZE_V10, @@ -
> 1646,7 +1646,7 @@ static struct s5p_mfc_buf_size_v6 mfc_buf_size_v10 = {
>  	.other_enc_ctx  = MFC_OTHER_ENC_CTX_BUF_SIZE_V10,  };
> 
> -static struct s5p_mfc_buf_size buf_size_v10 = {
> +static const struct s5p_mfc_buf_size buf_size_v10 = {
>  	.fw     = MAX_FW_SIZE_V10,
>  	.cpb    = MAX_CPB_SIZE_V10,
>  	.priv   = &mfc_buf_size_v10,
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
> index f8588e52dfc8..25c4719a5dd0 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
> @@ -32,7 +32,7 @@ static int s5p_mfc_cmd_host2risc_v6(struct
> s5p_mfc_dev *dev, int cmd,  static int s5p_mfc_sys_init_cmd_v6(struct
> s5p_mfc_dev *dev)  {
>  	struct s5p_mfc_cmd_args h2r_args;
> -	struct s5p_mfc_buf_size_v6 *buf_size = dev->variant->buf_size-
> >priv;
> +	const struct s5p_mfc_buf_size_v6 *buf_size =
> +dev->variant->buf_size->priv;
>  	int ret;
> 
>  	ret = s5p_mfc_hw_call(dev->mfc_ops, alloc_dev_context_buffer,
> dev); diff --git a/drivers/media/platform/samsung/s5p-
> mfc/s5p_mfc_common.h b/drivers/media/platform/samsung/s5p-
> mfc/s5p_mfc_common.h
> index f33a755327ef..6a47f3434c60 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> @@ -219,14 +219,14 @@ struct s5p_mfc_buf_size_v6 {  struct
> s5p_mfc_buf_size {
>  	unsigned int fw;
>  	unsigned int cpb;
> -	void *priv;
> +	const void *priv;
>  };
> 
>  struct s5p_mfc_variant {
>  	unsigned int version;
>  	unsigned int port_num;
>  	u32 version_bit;
> -	struct s5p_mfc_buf_size *buf_size;
> +	const struct s5p_mfc_buf_size *buf_size;
>  	const char	*fw_name[MFC_FW_MAX_VERSIONS];
>  	const char	*clk_names[MFC_MAX_CLOCKS];
>  	int		num_clocks;
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
> index 268ffe4da53c..4dbe8792ac3d 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
> @@ -426,7 +426,7 @@ static int vidioc_s_fmt(struct file *file, void *priv,
> struct v4l2_format *f)
>  	struct s5p_mfc_ctx *ctx = fh_to_ctx(priv);
>  	int ret = 0;
>  	struct v4l2_pix_format_mplane *pix_mp;
> -	struct s5p_mfc_buf_size *buf_size = dev->variant->buf_size;
> +	const struct s5p_mfc_buf_size *buf_size = dev->variant->buf_size;
> 
>  	mfc_debug_enter();
>  	ret = vidioc_try_fmt(file, priv, f);
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c
> index 28a06dc343fd..13a3ff55e547 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c
> @@ -34,7 +34,7 @@
>  static int s5p_mfc_alloc_dec_temp_buffers_v5(struct s5p_mfc_ctx *ctx)  {
>  	struct s5p_mfc_dev *dev = ctx->dev;
> -	struct s5p_mfc_buf_size_v5 *buf_size = dev->variant->buf_size-
> >priv;
> +	const struct s5p_mfc_buf_size_v5 *buf_size =
> +dev->variant->buf_size->priv;
>  	int ret;
> 
>  	ctx->dsc.size = buf_size->dsc;
> @@ -200,7 +200,7 @@ static void s5p_mfc_release_codec_buffers_v5(struct
> s5p_mfc_ctx *ctx)  static int s5p_mfc_alloc_instance_buffer_v5(struct
> s5p_mfc_ctx *ctx)  {
>  	struct s5p_mfc_dev *dev = ctx->dev;
> -	struct s5p_mfc_buf_size_v5 *buf_size = dev->variant->buf_size-
> >priv;
> +	const struct s5p_mfc_buf_size_v5 *buf_size =
> +dev->variant->buf_size->priv;
>  	int ret;
> 
>  	if (ctx->codec_mode == S5P_MFC_CODEC_H264_DEC || @@ -345,7
> +345,7 @@ static void s5p_mfc_enc_calc_src_size_v5(struct s5p_mfc_ctx
> *ctx)  static void s5p_mfc_set_dec_desc_buffer(struct s5p_mfc_ctx *ctx)  {
>  	struct s5p_mfc_dev *dev = ctx->dev;
> -	struct s5p_mfc_buf_size_v5 *buf_size = dev->variant->buf_size-
> >priv;
> +	const struct s5p_mfc_buf_size_v5 *buf_size =
> +dev->variant->buf_size->priv;
> 
>  	mfc_write(dev, OFFSETA(ctx->dsc.dma),
> S5P_FIMV_SI_CH0_DESC_ADR);
>  	mfc_write(dev, buf_size->dsc, S5P_FIMV_SI_CH0_DESC_SIZE); diff --
> git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> index c0df5ac9fcff..70a62400908e 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> @@ -333,7 +333,7 @@ static void s5p_mfc_release_codec_buffers_v6(struct
> s5p_mfc_ctx *ctx)  static int s5p_mfc_alloc_instance_buffer_v6(struct
> s5p_mfc_ctx *ctx)  {
>  	struct s5p_mfc_dev *dev = ctx->dev;
> -	struct s5p_mfc_buf_size_v6 *buf_size = dev->variant->buf_size-
> >priv;
> +	const struct s5p_mfc_buf_size_v6 *buf_size =
> +dev->variant->buf_size->priv;
>  	int ret;
> 
>  	mfc_debug_enter();
> @@ -393,7 +393,7 @@ static void
> s5p_mfc_release_instance_buffer_v6(struct s5p_mfc_ctx *ctx)
>  /* Allocate context buffers for SYS_INIT */  static int
> s5p_mfc_alloc_dev_context_buffer_v6(struct s5p_mfc_dev *dev)  {
> -	struct s5p_mfc_buf_size_v6 *buf_size = dev->variant->buf_size-
> >priv;
> +	const struct s5p_mfc_buf_size_v6 *buf_size =
> +dev->variant->buf_size->priv;
>  	int ret;
> 
>  	mfc_debug_enter();
> @@ -493,7 +493,7 @@ static int s5p_mfc_set_dec_stream_buffer_v6(struct
> s5p_mfc_ctx *ctx,  {
>  	struct s5p_mfc_dev *dev = ctx->dev;
>  	const struct s5p_mfc_regs *mfc_regs = dev->mfc_regs;
> -	struct s5p_mfc_buf_size *buf_size = dev->variant->buf_size;
> +	const struct s5p_mfc_buf_size *buf_size = dev->variant->buf_size;
> 
>  	mfc_debug_enter();
>  	mfc_debug(2, "inst_no: %d, buf_addr: 0x%08x,\n"
> 
> --
> 2.34.1

Reviewed-by: Aakarsh Jain <aakarsh.jain@samsung.com>

Thanks!


