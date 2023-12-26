Return-Path: <linux-kernel+bounces-11374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E75381E54A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 06:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C9192817CE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 05:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79E74BA80;
	Tue, 26 Dec 2023 05:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="K2029mDN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24644B5C0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 05:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231226054821epoutp022d25ffd5e5f67d38798d206a5679e956~kS54SuGsU1993419934epoutp02U
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 05:48:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231226054821epoutp022d25ffd5e5f67d38798d206a5679e956~kS54SuGsU1993419934epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703569701;
	bh=kstvCx6jNVu2CCvkXsM3Qz2KWSJ0p2P53GBZD83dv0o=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=K2029mDNYn+jYNExDA/hH4G2/hco+joImX2Mdn3/Cvj0w/Oxs668LjAs42pfKBXTH
	 dFkdqGjB9M12nPk6d9SbWbNz+N02ZwqEaMWxgVYQz3raAf28J0Gx0i0QMoNHqlL6e4
	 X37mH9rybpflPRrmP6ibCw4y/1+J0uemYaVtnAeQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20231226054820epcas5p31a07a71b0994a17837dc1adecf82b022~kS531Jw002282622826epcas5p3V;
	Tue, 26 Dec 2023 05:48:20 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4SzkMk6J13z4x9Q7; Tue, 26 Dec
	2023 05:48:18 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E5.E1.09672.2296A856; Tue, 26 Dec 2023 14:48:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20231226051014epcas5p1b824a015d457f7c9384f8942f2bcb97b~kSYmk7WxY2028320283epcas5p1a;
	Tue, 26 Dec 2023 05:10:14 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231226051014epsmtrp115ce0d8c3313d5951fa61b70d4946a6d~kSYmkRGgw0840308403epsmtrp1U;
	Tue, 26 Dec 2023 05:10:14 +0000 (GMT)
X-AuditID: b6c32a4b-60bfd700000025c8-e8-658a692243e7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EC.23.07368.6306A856; Tue, 26 Dec 2023 14:10:14 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20231226051012epsmtip136aed81b9125ce7e0827b5c0edde16b1~kSYlBRcj_3214032140epsmtip1D;
	Tue, 26 Dec 2023 05:10:12 +0000 (GMT)
From: "Aakarsh Jain" <aakarsh.jain@samsung.com>
To: "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>, "'Marek
 Szyprowski'" <m.szyprowski@samsung.com>, "'Andrzej Hajda'"
	<andrzej.hajda@intel.com>, "'Mauro Carvalho Chehab'" <mchehab@kernel.org>
Cc: <linux-fsd@tesla.coma>, <linux-samsung-soc@vger.kernel.org>, "'Smitha T
 Murthy'" <smithatmurthy@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20231224-n-s5p-mfc-const-v1-1-a3b246470fe4@linaro.org>
Subject: RE: [PATCH 01/15] media: s5p-mfc: drop unused static s5p_mfc_cmds
Date: Tue, 26 Dec 2023 10:40:11 +0530
Message-ID: <15ce01da37b9$cede8d20$6c9ba760$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKOGlHY6WxiJqLoSx78067AznjgmAHo/W/vAklP6R+vMaxvAA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmuq5SZleqwcR+fYv7iz+zWOx9vZXd
	YtPja6wWy2YHWVzeNYfNomfDVlaLGef3MVmsPXKX3WLZpj9MFi2NS1gduDx2zrrL7rF4z0sm
	j02rOtk87lzbw+axeUm9R9+WVYwef1+/YvP4vEkugCMq2yYjNTEltUghNS85PyUzL91WyTs4
	3jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6EQlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5x
	ia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGhxNbmQom81cs+bSHuYGxm7eLkZND
	QsBEYvavHuYuRi4OIYHdjBKHH75lg3A+MUr8OdEElfkGlFn5jg2mZdHWfVBVexkl9j6bxQTh
	PGeUeH1kJwtIFZuAvsT9Uz2sIAkRgXOMEtv6p4BVMQvcZJQ49mYmM0gVp4CLRPuzXYwgtrCA
	l8SRu4fAulkEVCUmX3jFBGLzClhK/NwwnxHCFpQ4OfMJWA2zgLbEsoWvmSFuUpD4+XQZK4gt
	IuAk8eTyLjaIGnGJoz8h3pMQOMIh0b5kE1SDi8SefXdYIGxhiVfHt7BD2FISL/vboOxkiceL
	XkLV50is3zMFqt5e4sCVOUA2B9ACTYn1u/QhwrISU0+tY4LYyyfR+/sJE0ScV2LHPBhbTWLO
	nR+sELaMxOHVSxknMCrNQvLaLCSvzULywiyEbQsYWVYxSqYWFOempxabFhjnpZbD4zw5P3cT
	IzgRa3nvYHz04IPeIUYmDsZDjBIczEoivLKKHalCvCmJlVWpRfnxRaU5qcWHGE2B4T2RWUo0
	OR+YC/JK4g1NLA1MzMzMTCyNzQyVxHlft85NERJITyxJzU5NLUgtgulj4uCUamByMqyYz1j2
	4vKuSdvt/4vMaTXfaVHPuH26g6MDF8/XOzVyh3RUVCSvr/ySICtkbSHz/3vJiY2XdGNv3O72
	mqOffP5w7aG34a8P/dqy9vnKd+nbYi8a2u38r+SdsuukwmqX/49zp8+s/SfN73HuZV9er8im
	XUUznReXbPzN75f38fbNRV9O/N6t3G23+sTGPfv+1n+XOWn0fXvrGzPLN3lLnR481fcUKZQQ
	fbDL6tbNOSWaRxfGcWitXj7jkbr9Gn/TaAXxjnPmRz4+VdimvTaVb/7XlxyrJh7el2Vz10TJ
	/MHLK6Zi2xk2aq85Wfxkigdj5vklHeI2WoLN2QdSfFVsPipWNzYF+JRavrshc/jyHiWW4oxE
	Qy3mouJEAGHPU5BNBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsWy7bCSnK5ZQleqwboOaYv7iz+zWOx9vZXd
	YtPja6wWy2YHWVzeNYfNomfDVlaLGef3MVmsPXKX3WLZpj9MFi2NS1gduDx2zrrL7rF4z0sm
	j02rOtk87lzbw+axeUm9R9+WVYwef1+/YvP4vEkugCOKyyYlNSezLLVI3y6BK+P3pqfMBRf4
	Ko5MbmBuYDzF08XIySEhYCKxaOs+ti5GLg4hgd2MEnfbelkgEjIS/9uOsUPYwhIr/z1nhyh6
	yihxad5zsASbgL7E/VM9rCAJEYELjBJb9iwAG8UscJ9RomvTdiaQKiGBs4wS8+ZFgNicAi4S
	7c92MYLYwgJeEkfuHgJbxyKgKjH5wiuwel4BS4mfG+YzQtiCEidnPgGrYRbQluh92MoIYy9b
	+JoZ4jwFiZ9Pl7GC2CICThJPLu9ig6gRlzj6s4d5AqPwLCSjZiEZNQvJqFlIWhYwsqxilEwt
	KM5Nz002LDDMSy3XK07MLS7NS9dLzs/dxAiORS2NHYz35v/TO8TIxMF4iFGCg1lJhFdWsSNV
	iDclsbIqtSg/vqg0J7X4EKM0B4uSOK/hjNkpQgLpiSWp2ampBalFMFkmDk6pBqbol5IfDjtd
	a74pIBadO+PUipa2PXfMVh59vpf1vtvMPd0qXyfPy7a66bjH8O4rvXBtHv5DTzdOZRfOPpJr
	Xh4X9nnOkhclndEzBNRLFmVHzwwr7mXaeHvx3VkrRVJf3FuoVCZduonTvfKql6fr5OMK10tn
	VR3d81OeZ86cU0cco9eq/9Wq6ztp0KkV2H9ERGHW3wfrapT6ll/deXX5Vfb87bVBV+zzlz7O
	mbDo6gTeO3+kvDIeZJzR1lone27FrXsTON76B15xtGD/zHlq76nNR5Y9ucYfN+vdpZcNnGtv
	/tvHsZ7p/dVH2tGv/ZV/HJywehb/5RY2XefYNROt4/9oc6zT2WRvav3pQFtfXZStrxJLcUai
	oRZzUXEiAKwMUM80AwAA
X-CMS-MailID: 20231226051014epcas5p1b824a015d457f7c9384f8942f2bcb97b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231224154435epcas5p11c17dce71c5ce263c8028a43b401aa22
References: <20231224-n-s5p-mfc-const-v1-0-a3b246470fe4@linaro.org>
	<CGME20231224154435epcas5p11c17dce71c5ce263c8028a43b401aa22@epcas5p1.samsung.com>
	<20231224-n-s5p-mfc-const-v1-1-a3b246470fe4@linaro.org>



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
> Subject: =5BPATCH 01/15=5D media: s5p-mfc: drop unused static s5p_mfc_cmd=
s
>=20
> File-scope static variable =22s5p_mfc_cmds=22 is not read after assignmen=
t, thus
> it can be dropped entirely.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski=40linaro.org>
> ---
>  drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd.c =7C 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd.c
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd.c
> index 774c573dc075..196d8c99647b 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd.c
> =40=40 -12,14 +12,10 =40=40
>  =23include =22s5p_mfc_cmd_v5.h=22
>  =23include =22s5p_mfc_cmd_v6.h=22
>=20
> -static struct s5p_mfc_hw_cmds *s5p_mfc_cmds;
> -
>  void s5p_mfc_init_hw_cmds(struct s5p_mfc_dev *dev)  =7B
>  	if (IS_MFCV6_PLUS(dev))
> -		s5p_mfc_cmds =3D s5p_mfc_init_hw_cmds_v6();
> +		dev->mfc_cmds =3D s5p_mfc_init_hw_cmds_v6();
>  	else
> -		s5p_mfc_cmds =3D s5p_mfc_init_hw_cmds_v5();
> -
> -	dev->mfc_cmds =3D s5p_mfc_cmds;
> +		dev->mfc_cmds =3D s5p_mfc_init_hw_cmds_v5();
>  =7D
>=20
> --
> 2.34.1

Reviewed-by: Aakarsh Jain <aakarsh.jain=40samsung.com>

Thanks=21


