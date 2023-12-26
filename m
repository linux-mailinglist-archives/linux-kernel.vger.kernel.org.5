Return-Path: <linux-kernel+bounces-11390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDCC81E584
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 07:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1C181F22469
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 06:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE964C3D6;
	Tue, 26 Dec 2023 06:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kbZuLVhK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D274C62B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 06:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231226063431epoutp03a7f14e6553ebc29f347bb6e7a514fa2f~kTiMg5BSt1047610476epoutp03s
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 06:34:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231226063431epoutp03a7f14e6553ebc29f347bb6e7a514fa2f~kTiMg5BSt1047610476epoutp03s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703572471;
	bh=QTB84M50WFYIDe/+9MiAYey4svYfPT1DbPQhlDkmeEg=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=kbZuLVhKqJwYE/hpR5vnjGHPphn4VbfDxaEsQKATm7D8KKFDh34UWA/9rQ4Cht1AT
	 ochOcunOOALMlw55dzxNmYJYCa9XW1ER6WSHCAbo1VBnNo+y8HFXbCQF5Qtwvb4saP
	 wRkjBS/cSpEeF893Ii14p0bYbBEgl9VJJiJnakoc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20231226063431epcas5p2a1d9081c0516f4d5e4d0375bc170e60b~kTiL28fQj2204722047epcas5p20;
	Tue, 26 Dec 2023 06:34:31 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4SzlP13BZBz4x9Pp; Tue, 26 Dec
	2023 06:34:29 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A8.F1.19369.5F37A856; Tue, 26 Dec 2023 15:34:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20231226062756epcas5p22bc39bd25d403a9bed16c220f82c4a83~kTccWazlP0679806798epcas5p21;
	Tue, 26 Dec 2023 06:27:56 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231226062756epsmtrp1bf1ad9b6da87585b49f8d077f6cdf6ff~kTccVuCsa1947119471epsmtrp10;
	Tue, 26 Dec 2023 06:27:56 +0000 (GMT)
X-AuditID: b6c32a50-9e1ff70000004ba9-de-658a73f55bd7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	A8.C7.18939.C627A856; Tue, 26 Dec 2023 15:27:56 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20231226062754epsmtip29f5e872132462de8780110b3955da104~kTcasjk3e0864408644epsmtip2g;
	Tue, 26 Dec 2023 06:27:54 +0000 (GMT)
From: "Aakarsh Jain" <aakarsh.jain@samsung.com>
To: "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>, "'Marek
 Szyprowski'" <m.szyprowski@samsung.com>, "'Andrzej Hajda'"
	<andrzej.hajda@intel.com>, "'Mauro Carvalho Chehab'" <mchehab@kernel.org>
Cc: <linux-fsd@tesla.coma>, <linux-samsung-soc@vger.kernel.org>, "'Smitha T
 Murthy'" <smithatmurthy@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20231224-n-s5p-mfc-const-v1-9-a3b246470fe4@linaro.org>
Subject: RE: [PATCH 09/15] media: s5p-mfc: constify s5p_mfc_fmt structures
Date: Tue, 26 Dec 2023 11:57:53 +0530
Message-ID: <15d401da37c4$a9dece80$fd9c6b80$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKOGlHY6WxiJqLoSx78067AznjgmAGjTMXtAfUJOwGvNpHr8A==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmlu7X4q5Ug7dPhC3uL/7MYrH39VZ2
	i02Pr7FaLJsdZHF51xw2i54NW1ktZpzfx2Sx9shddotlm/4wWbQ0LmF14PLYOesuu8fiPS+Z
	PDat6mTzuHNtD5vH5iX1Hn1bVjF6/H39is3j8ya5AI6obJuM1MSU1CKF1Lzk/JTMvHRbJe/g
	eOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoBOVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnF
	JbZKqQUpOQUmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZG884FezRqPh78Tx7A+N6pS5GTg4J
	AROJpjMzGLsYuTiEBPYwSsw7dZEVJCEk8IlRYm6bC0QCyP74vIcdpqNx01wmiMRORomObZOY
	IZznjBIP/i8Ea2cT0Je4f6qHFSQhInCOUWJb/xSwFmaBm4wSx97MZAap4hRwkfiz6iRYh7CA
	l8TD3xfYuhg5OFgEVCV23wwGCfMKWErM+zmBFcIWlDg58wkLiM0soC2xbOFrZoiTFCR+Pl0G
	ViMi4CSxcMltJogacYmjP3vArpMQOMAhcWLKYqgfXCT6Tt5jhLCFJV4d3wIVl5J42d8GZSdL
	PF70EmpBjsT6PVNYIGx7iQNX5rCA3MksoCmxfpc+RFhWYuqpdVB7+SR6fz9hgojzSuyYB2Or
	Scy584MVwpaROLx6KeMERqVZSF6bheS1WUhemIWwbQEjyypGqdSC4tz01GTTAkPdvNRyeIwn
	5+duYgQnYa2AHYyrN/zVO8TIxMF4iFGCg1lJhFdWsSNViDclsbIqtSg/vqg0J7X4EKMpMLwn
	MkuJJucD80BeSbyhiaWBiZmZmYmlsZmhkjjv69a5KUIC6YklqdmpqQWpRTB9TBycUg1MPmlp
	S/VqXGduTNg1tfCkjcUOdfunFgqb9y73qy0WPLKCK/4+D8fbsxOEn97MebTMOc3t2r1Tl80P
	Vif93Nq2VlpGUKb1dkmjQ+p7NeF0pde6b7XuNPIavr9YvifFfM1eP5VNwb8OyIe0ZUWHnDth
	su8Yu8GhcMFNMxxed73X6jv1uos7wvgJV4K92uzy5ijt2c/uTD3f/f7C329THI5vb7Kb7183
	/9xa3vN7uvvm3vt9b1avxr/7Rgt3KRjdfPapX0L16VVxN46iR4dW7QytmbClXDS4KONS2mE7
	pjbtXG5+dTfOTf1pWS2HCu6YsYvt2CrQZaas4HPDR15Xvvhy8g/BBDutyT7yd29VzpitxFKc
	kWioxVxUnAgANnw1BUsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWy7bCSvG5OUVeqwfN2KYv7iz+zWOx9vZXd
	YtPja6wWy2YHWVzeNYfNomfDVlaLGef3MVmsPXKX3WLZpj9MFi2NS1gduDx2zrrL7rF4z0sm
	j02rOtk87lzbw+axeUm9R9+WVYwef1+/YvP4vEkugCOKyyYlNSezLLVI3y6BK+P6qe1MBZ/U
	Ktat38/cwPhSoYuRk0NCwESicdNcpi5GLg4hge2MEhPWzGOESMhI/G87xg5hC0us/PecHaLo
	KaPEyyOT2EASbAL6EvdP9bCCJEQELjBKbNmzgA3EYRa4zyjRtWk71NyzQM6i/WCzOAVcJP6s
	OskKYgsLeEk8/H0BqIODg0VAVWL3zWCQMK+ApcS8nxNYIWxBiZMzn7CA2MwC2hK9D1sZYexl
	C18zQ5ynIPHz6TKwehEBJ4mFS24zQdSISxz92cM8gVF4FpJRs5CMmoVk1CwkLQsYWVYxiqYW
	FOem5yYXGOoVJ+YWl+al6yXn525iBMegVtAOxmXr/+odYmTiYDzEKMHBrCTCK6vYkSrEm5JY
	WZValB9fVJqTWnyIUZqDRUmcVzmnM0VIID2xJDU7NbUgtQgmy8TBKdXAtLo2tqbGc0rlx9b4
	x19ke9IXPQm6M/F76vYvzh/O9Llc69RflCX97e3hvc5zp+1uPPrgqCzv36gVdy/2dVhcX7NO
	7+3HWS9XF57p3ZCXvOa4e1XbbMYV/6PWbQ/Jla+NsLpv1GS5zCTPRLTunkGO0x/t2LSC81oP
	n0pOueLxxbPqg3l0zffbxzfNXsJV5DzXb+cKwSZ7npcfHiUr1XT49JkZHjs8eZKys+HmoFli
	X9rjL21jOly55Nwky06l3+eW7VCwNft9cRLzC8FjpjK14fzi0XdV1hXebo16yq9wanK+ifbm
	p5eD5/8K0tNceXBdMPu9QzOn7y9RNLzHae8eekZ26ta/xeufHLr36yx7wwslluKMREMt5qLi
	RADyq//SMAMAAA==
X-CMS-MailID: 20231226062756epcas5p22bc39bd25d403a9bed16c220f82c4a83
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231224154446epcas5p2b08000b76b8a94063b164a55e5e8a999
References: <20231224-n-s5p-mfc-const-v1-0-a3b246470fe4@linaro.org>
	<CGME20231224154446epcas5p2b08000b76b8a94063b164a55e5e8a999@epcas5p2.samsung.com>
	<20231224-n-s5p-mfc-const-v1-9-a3b246470fe4@linaro.org>



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski=40linaro.org>
> Sent: 24 December 2023 21:14
> To: Marek Szyprowski <m.szyprowski=40samsung.com>; Andrzej Hajda
> <andrzej.hajda=40intel.com>; Mauro Carvalho Chehab
> <mchehab=40kernel.org>
> Cc: Aakarsh Jain <aakarsh.jain=40samsung.com>; linux-fsd=40tesla.coma; li=
nux-
> samsung-soc=40vger.kernel.org; Smitha T Murthy
> <smithatmurthy=40gmail.com>; linux-arm-kernel=40lists.infradead.org; linu=
x-
> media=40vger.kernel.org; linux-kernel=40vger.kernel.org; Krzysztof Kozlow=
ski
> <krzysztof.kozlowski=40linaro.org>
> Subject: =5BPATCH 09/15=5D media: s5p-mfc: constify s5p_mfc_fmt structure=
s
>=20
> Static =22s5p_mfc_fmt=22 structures are not modified by the driver, so th=
ey can
> be made const for code safety.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski=40linaro.org>
> ---
>  drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h =7C 4 ++--
>  drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c    =7C 6 +++---
>  drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c    =7C 8 ++++----
>  3 files changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> index fa556f27fa06..e9283020070e 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> =40=40 -633,8 +633,8 =40=40 struct s5p_mfc_ctx =7B
>  	unsigned int int_err;
>  	wait_queue_head_t queue;
>=20
> -	struct s5p_mfc_fmt *src_fmt;
> -	struct s5p_mfc_fmt *dst_fmt;
> +	const struct s5p_mfc_fmt *src_fmt;
> +	const struct s5p_mfc_fmt *dst_fmt;
>=20
>  	struct vb2_queue vq_src;
>  	struct vb2_queue vq_dst;
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
> index 4dbe8792ac3d..2f664c7e9e4c 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
> =40=40 -27,7 +27,7 =40=40
>  =23include =22s5p_mfc_opr.h=22
>  =23include =22s5p_mfc_pm.h=22
>=20
> -static struct s5p_mfc_fmt formats=5B=5D =3D =7B
> +static const struct s5p_mfc_fmt formats=5B=5D =3D =7B
>  	=7B
>  		.fourcc		=3D V4L2_PIX_FMT_NV12MT_16X16,
>  		.codec_mode	=3D S5P_MFC_CODEC_NONE,
> =40=40 -163,7 +163,7 =40=40 static struct s5p_mfc_fmt formats=5B=5D =3D =
=7B  =23define
> NUM_FORMATS ARRAY_SIZE(formats)
>=20
>  /* Find selected format description */
> -static struct s5p_mfc_fmt *find_format(struct v4l2_format *f, unsigned i=
nt
> t)
> +static const struct s5p_mfc_fmt *find_format(struct v4l2_format *f,
> +unsigned int t)
>  =7B
>  	unsigned int i;
>=20
> =40=40 -387,7 +387,7 =40=40 static int vidioc_g_fmt(struct file *file, vo=
id *priv,
> struct v4l2_format *f)  static int vidioc_try_fmt(struct file *file, void=
 *priv,
> struct v4l2_format *f)  =7B
>  	struct s5p_mfc_dev *dev =3D video_drvdata(file);
> -	struct s5p_mfc_fmt *fmt;
> +	const struct s5p_mfc_fmt *fmt;
>=20
>  	mfc_debug(2, =22Type is %d=5Cn=22, f->type);
>  	if (f->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) =7B diff --git
> a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
> index 4b4c129c09e7..d6a4b9c701eb 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
> =40=40 -30,7 +30,7 =40=40
>  =23define DEF_SRC_FMT_ENC	V4L2_PIX_FMT_NV12M
>  =23define DEF_DST_FMT_ENC	V4L2_PIX_FMT_H264
>=20
> -static struct s5p_mfc_fmt formats=5B=5D =3D =7B
> +static const struct s5p_mfc_fmt formats=5B=5D =3D =7B
>  	=7B
>  		.fourcc		=3D V4L2_PIX_FMT_NV12MT_16X16,
>  		.codec_mode	=3D S5P_MFC_CODEC_NONE,
> =40=40 -97,7 +97,7 =40=40 static struct s5p_mfc_fmt formats=5B=5D =3D =7B=
  =7D;
>=20
>  =23define NUM_FORMATS ARRAY_SIZE(formats) -static struct s5p_mfc_fmt
> *find_format(struct v4l2_format *f, unsigned int t)
> +static const struct s5p_mfc_fmt *find_format(struct v4l2_format *f,
> +unsigned int t)
>  =7B
>  	unsigned int i;
>=20
> =40=40 -1394,7 +1394,7 =40=40 static int vidioc_g_fmt(struct file *file, =
void *priv,
> struct v4l2_format *f)  static int vidioc_try_fmt(struct file *file, void=
 *priv,
> struct v4l2_format *f)  =7B
>  	struct s5p_mfc_dev *dev =3D video_drvdata(file);
> -	struct s5p_mfc_fmt *fmt;
> +	const struct s5p_mfc_fmt *fmt;
>  	struct v4l2_pix_format_mplane *pix_fmt_mp =3D &f->fmt.pix_mp;
>=20
>  	if (f->type =3D=3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) =7B =40=40 -
> 2355,7 +2355,7 =40=40 static const struct v4l2_ioctl_ops s5p_mfc_enc_ioct=
l_ops
> =3D =7B
>  	.vidioc_unsubscribe_event =3D v4l2_event_unsubscribe,  =7D;
>=20
> -static int check_vb_with_fmt(struct s5p_mfc_fmt *fmt, struct vb2_buffer
> *vb)
> +static int check_vb_with_fmt(const struct s5p_mfc_fmt *fmt, struct
> +vb2_buffer *vb)
>  =7B
>  	int i;
>=20
>=20
> --
> 2.34.1

Reviewed-by: Aakarsh Jain <aakarsh.jain=40samsung.com>

Thanks=21


