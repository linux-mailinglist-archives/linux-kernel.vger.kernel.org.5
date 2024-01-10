Return-Path: <linux-kernel+bounces-22651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D655782A0F2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E229A1C22BF7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23C14E1BC;
	Wed, 10 Jan 2024 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Dw1CASMg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B824D5B4;
	Wed, 10 Jan 2024 19:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40AII4np021305;
	Wed, 10 Jan 2024 19:19:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=jnvwjaJSh71ZVdoK5gBOs
	QlHTKzC8Uxma1PfqBu+KWY=; b=Dw1CASMgk2yRTzRSq2AcXokPOEjLjSnrVW2l9
	nuZmm1dMt6Iyo7XHd8zvbuBCEVkIBFvO4aWCwMqKt1ajwcRqYj1B1TmQT1iAv56I
	yphX3H0ZYIXZmAfcqvhebNPhYlNlZnqIzzQ23iFur1xuryC1RBE4l2xkuZPQ6yqA
	XMT8jpJZCgyOYqUrzfvUJx7nTzUwuBWYJFnBOO2LooB8FjlHi+IlF8p3NPwQlXCM
	ETplm81jt7KYSM39a0qUjF4O/4imS90ZQVJg69cQWXgKK1sz7DSx/ftj3dstw07R
	E8KeJbcbhUcFzec39aI3anDBtMSiM3nF9v4parOIocVmeP2vQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhq2h1ngg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 19:19:03 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40AJJ1kE003837
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 19:19:01 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 11:19:02 -0800
Date: Wed, 10 Jan 2024 11:19:00 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>
CC: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-mtd@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_tingweiz@quicinc.com>
Subject: Re: [PATCH v2] dt-bindings: mtd: avoid automatically select from
 mtd.yaml
Message-ID: <20240110191900.GM1315173@hu-bjorande-lv.qualcomm.com>
References: <1704885705-7486-1-git-send-email-quic_zhenhuah@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1704885705-7486-1-git-send-email-quic_zhenhuah@quicinc.com>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dC_Wu6G7ldqe4tlIvy4yutzMoxLRc0mM
X-Proofpoint-ORIG-GUID: dC_Wu6G7ldqe4tlIvy4yutzMoxLRc0mM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 mlxlogscore=961 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100153

On Wed, Jan 10, 2024 at 07:21:45PM +0800, Zhenhua Huang wrote:
> The mtd binding is always $ref'ed by other bindings, default selector
> should be from other binding files which ref'ed it. Now, "$nodename" in
> mtd.yaml turns into a "select" automatically such that a few binding check
> issues reported because it conflicts with sram devices(eg, qcom,imem.yaml,
> rules in folder sram/*)
> 
> To avoid the automatically created "select" in mtd.yaml, adding:
> 
> select: false
> 
> Suggested-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> Fixes: 7bdc671822e9 ("dt-bindings: mtd: physmap: Reuse the generic definitions")
> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>

Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

> ---
> Hi Bjorn,
> 
> As the idea is from your comment, I added "Suggested-by" you.
> Please tell me if that's not suitable. Thanks.

I appreciate that, thank you.

Regards,
Bjorn

> 
>  Documentation/devicetree/bindings/mtd/mtd.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/mtd.yaml b/Documentation/devicetree/bindings/mtd/mtd.yaml
> index f322290..ee442ec 100644
> --- a/Documentation/devicetree/bindings/mtd/mtd.yaml
> +++ b/Documentation/devicetree/bindings/mtd/mtd.yaml
> @@ -10,6 +10,8 @@ maintainers:
>    - Miquel Raynal <miquel.raynal@bootlin.com>
>    - Richard Weinberger <richard@nod.at>
>  
> +select: false
> +
>  properties:
>    $nodename:
>      pattern: "^(flash|.*sram|nand)(@.*)?$"
> -- 
> 2.7.4
> 

