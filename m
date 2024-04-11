Return-Path: <linux-kernel+bounces-141494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 712E88A1EFA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A91B28314D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782D4134B0;
	Thu, 11 Apr 2024 18:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hPzQKzVn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7158A12E5D;
	Thu, 11 Apr 2024 18:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712861732; cv=none; b=RFp8lfNA4qBiQ+yyLziPY70BuCSx46nl/ovCyD1ZQqEVOWCwkH5ar09Gw60L0wtUY6hxUOA/wrDvFIbblvIOzUrPkOWTtt7lDBVWJkT9swMEUJ6QxaI2+60NLYxQbG2nkLW1q0USwBEHyRhkAhO3lWlTI8D71Sx1I7IDMJbxHWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712861732; c=relaxed/simple;
	bh=82WAuKFIq3XAh9McX3MVSvtMbClD44X+hGmbxb/6VSs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luPKq1iIJCsXO6ZHoxkvyYmzerpaj6y4y1pFiafDht/6zABQcyZwOcPkO82shv4X0G4MyLCBagCNL7kmg7u3AE+nuUCeHu8kTlYjfeIkO8Aze5hFSDMCElXcCcAvwinjWnv2kjGgh3Jt+tidWN9+iJGc2jJPyeptNEELhGe1OCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hPzQKzVn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43BCvQPb022085;
	Thu, 11 Apr 2024 18:55:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=13hWRm+TBL3RIJcw2GrbA
	uy0XhTMQdVLg5bf1cuNnwQ=; b=hPzQKzVn5pJ23T/voDQpLrvFroMlqgnJdP3AB
	4zVxLuMNyTkigBn6MNA37m4H4bsr6VVVZ1fSpuc1dFfO87kSMdagaBZ+JQkfoMnw
	gD9vecUN3vFrDUut1dm4vVa+8NpbasXQJ5osXv36zWgLhT2u4BD7VeWU4aLGnhZS
	nbE89JyHt+ZO5RfiscXV4bcY8uSeKQDtjaBp8cN38kOBRxzvCFVhGcHnCpRO12vm
	FFvNnWMIgnh+Fm72IJ7RL07XpPrxtrmcUMh8UXIplANXgSt77BfiNc17ylW1VaMc
	gVp05IAcgq4EaFGZ0R7yxjQsI9DrtrHui5LX6u0EsXoQfWAow==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xec6dj0y5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 18:55:21 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43BItK8q012763
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 18:55:20 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 11 Apr 2024 11:55:19 -0700
Date: Thu, 11 Apr 2024 11:55:19 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, "Daniel
 Vetter" <daniel@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/6] soc: qcom: Move some socinfo defines to the header,
 expand them
Message-ID: <20240410132510649-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <20240405-topic-smem_speedbin-v1-0-ce2b864251b1@linaro.org>
 <20240405-topic-smem_speedbin-v1-1-ce2b864251b1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240405-topic-smem_speedbin-v1-1-ce2b864251b1@linaro.org>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mrfVQikCksSyfWHu_d7-aNRvrtFnBno1
X-Proofpoint-ORIG-GUID: mrfVQikCksSyfWHu_d7-aNRvrtFnBno1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404110138

On Fri, Apr 05, 2024 at 10:41:29AM +0200, Konrad Dybcio wrote:
> In preparation for parsing the chip "feature code" (FC) and "product
> code" (PC) (essentially the parameters that let us conclusively
> characterize the sillicon we're running on, including various speed
> bins), move the socinfo version defines to the public header and
> include some more FC/PC defines.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/soc/qcom/socinfo.c       |  8 --------
>  include/linux/soc/qcom/socinfo.h | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+), 8 deletions(-)
> 
..
> diff --git a/include/linux/soc/qcom/socinfo.h b/include/linux/soc/qcom/socinfo.h
..
> @@ -74,4 +84,30 @@ struct socinfo {
>  	__le32 boot_core;
>  };
>  
> +/* Internal feature codes */
> +enum feature_code {
> +	/* External feature codes */
> +	SOCINFO_FC_UNKNOWN = 0x0,
> +	SOCINFO_FC_AA,
> +	SOCINFO_FC_AB,
> +	SOCINFO_FC_AC,
> +	SOCINFO_FC_AD,
> +	SOCINFO_FC_AE,
> +	SOCINFO_FC_AF,
> +	SOCINFO_FC_AG,
> +	SOCINFO_FC_AH,
> +	SOCINFO_FC_EXT_RESERVE,
> +};

SOCINFO_FC_EXT_RESERVE was a convenient limit since we mapped
SOCINFO_FC_AA -> string "AA" via an array, and we've only needed the 8
feature codes so far.

We should remove the EXT_RESERVE and test for the Y0-YF (internal
feature code) values instead.

> +
> +/* Internal feature codes */
> +/* Valid values: 0 <= n <= 0xf */
> +#define SOCINFO_FC_Yn(n)		(0xf1 + n)
> +#define SOCINFO_FC_INT_RESERVE		SOCINFO_FC_Yn(0x10)

We probably should've named this SOCINFO_FC_INT_MAX. Reserve implies
it's reserved for some future use, but it's really the max value it
could be.

> +
> +/* Product codes */
> +#define SOCINFO_PC_UNKNOWN		0
> +/* Valid values: 0 <= n <= 8, the rest is reserved */
> +#define SOCINFO_PCn(n)			(n + 1)
> +#define SOCINFO_PC_RESERVE		(BIT(31) - 1)

Similar comments here as the SOCINFO_FC_EXT_*. It's more like known
values are [0,8], but more values could come in future chipsets.

> +
>  #endif
> 

