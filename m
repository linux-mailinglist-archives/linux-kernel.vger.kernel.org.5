Return-Path: <linux-kernel+bounces-108726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3405880F3D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FEDE1F23353
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A37E3CF6A;
	Wed, 20 Mar 2024 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HnixBj/W"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F9C38F82;
	Wed, 20 Mar 2024 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710929062; cv=none; b=NTiu1wpJnNgTlNLuQ/iltxUkQqHsraiMmXIDsKbTSGbzg9h6UHvw3RF7DDjGmLWDyV76xiRcWojnVLQZ9fJ6MDIH2WAVgCGKBsqw+kFf52QIwaz1FfJS9rggKHMPBqKpNBcSTncBNujogd/xqFy48IyykyhHwCyr8Eiq8fcoVFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710929062; c=relaxed/simple;
	bh=nIqkjMSHV9EcCxgnfZD3kI/SawCNOWAjVuJ+etAG/KE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0yYQGCqX73ASQMLDp8ZAoSyqnCAYs0i3hsPDbE90R78811JMBmJhpSQgG1zKYRsybF9ZQ3P7DercRoQJtsyAITbisHaX+48iBSaBszPw/y+TFy48RBdjXO1Ic4mlE+Vx3ETPZeTj7DgBT9HF7d23nHFi63ioZ+CAphn5PkTg/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HnixBj/W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42K7dJNU023914;
	Wed, 20 Mar 2024 10:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=NSwShFQocCiNdxEXdDTWS
	rFKKz5ddmj/SrKnvqOPygI=; b=HnixBj/WDkUf8h0JAZxntqc7AuKKwlmDNwhiG
	WxDg9KO1gk2y9llKT4/0zEfn+AWy5BQY24HmSmvG3QYrPIdKGhOsuorIrVzm03wF
	s8IHZeBOclGeD3su3QcMJyLqo65mV+76NRHJ3OcbMENv9B35ZYfnblWxYrz2ZNEU
	x+g+VLaptQO8Uzjl2ZgoPppSyK9rHal7Xu0pGZNfac3HR7r/u9ggCRhWuoOre+Rx
	xsmVr2XmiNa9W8U7betciiLFruNUXMEISu5YsUnuUb89LGHB3+SgaO6gO36GoEqL
	FALi0uJdJw+GqmkouU74STgpLbnl+eoYZlRppE6EUsMBvzejw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wypxq0ub4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 10:04:04 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KA43mK029663
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 10:04:03 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Mar 2024 03:04:00 -0700
Date: Wed, 20 Mar 2024 15:33:56 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/31] arm64: dts: qcom: ipq9574-*: Remove thermal zone
 polling delays
Message-ID: <Zfq0jF93iJVgd1+R@hu-varada-blr.qualcomm.com>
References: <20240319-topic-msm-polling-cleanup-v1-0-e0aee1dbcd78@linaro.org>
 <20240319-topic-msm-polling-cleanup-v1-3-e0aee1dbcd78@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240319-topic-msm-polling-cleanup-v1-3-e0aee1dbcd78@linaro.org>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ogZc7Fp0078mp0OWJuL9-WjMhYyv9J7V
X-Proofpoint-GUID: ogZc7Fp0078mp0OWJuL9-WjMhYyv9J7V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_06,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 malwarescore=0
 priorityscore=1501 mlxlogscore=865 adultscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403140001 definitions=main-2403200078

On Tue, Mar 19, 2024 at 05:13:33PM +0100, Konrad Dybcio wrote:
> All of the thermal zone suppliers are interrupt-driven, remove the
> bogus and unnecessary polling that only wastes CPU time.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 26 --------------------------
>  1 file changed, 26 deletions(-)

Reviewed-by: Varadarajan Narayanan <quic_varada@quicinc.com>

Thanks
Varada

> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index 7f2e5cbf3bbb..98c5623f4391 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -749,8 +749,6 @@ frame@b128000 {
>  
>  	thermal-zones {
>  		nss-top-thermal {
> -			polling-delay-passive = <0>;
> -			polling-delay = <0>;
>  			thermal-sensors = <&tsens 3>;
>  
>  			trips {
> @@ -763,8 +761,6 @@ nss-top-critical {
>  		};
>  
>  		ubi-0-thermal {
> -			polling-delay-passive = <0>;
> -			polling-delay = <0>;
>  			thermal-sensors = <&tsens 4>;
>  
>  			trips {
> @@ -777,8 +773,6 @@ ubi_0-critical {
>  		};
>  
>  		ubi-1-thermal {
> -			polling-delay-passive = <0>;
> -			polling-delay = <0>;
>  			thermal-sensors = <&tsens 5>;
>  
>  			trips {
> @@ -791,8 +785,6 @@ ubi_1-critical {
>  		};
>  
>  		ubi-2-thermal {
> -			polling-delay-passive = <0>;
> -			polling-delay = <0>;
>  			thermal-sensors = <&tsens 6>;
>  
>  			trips {
> @@ -805,8 +797,6 @@ ubi_2-critical {
>  		};
>  
>  		ubi-3-thermal {
> -			polling-delay-passive = <0>;
> -			polling-delay = <0>;
>  			thermal-sensors = <&tsens 7>;
>  
>  			trips {
> @@ -819,8 +809,6 @@ ubi_3-critical {
>  		};
>  
>  		cpuss0-thermal {
> -			polling-delay-passive = <0>;
> -			polling-delay = <0>;
>  			thermal-sensors = <&tsens 8>;
>  
>  			trips {
> @@ -833,8 +821,6 @@ cpu-critical {
>  		};
>  
>  		cpuss1-thermal {
> -			polling-delay-passive = <0>;
> -			polling-delay = <0>;
>  			thermal-sensors = <&tsens 9>;
>  
>  			trips {
> @@ -847,8 +833,6 @@ cpu-critical {
>  		};
>  
>  		cpu0-thermal {
> -			polling-delay-passive = <0>;
> -			polling-delay = <0>;
>  			thermal-sensors = <&tsens 10>;
>  
>  			trips {
> @@ -877,8 +861,6 @@ map0 {
>  		};
>  
>  		cpu1-thermal {
> -			polling-delay-passive = <0>;
> -			polling-delay = <0>;
>  			thermal-sensors = <&tsens 11>;
>  
>  			trips {
> @@ -907,8 +889,6 @@ map0 {
>  		};
>  
>  		cpu2-thermal {
> -			polling-delay-passive = <0>;
> -			polling-delay = <0>;
>  			thermal-sensors = <&tsens 12>;
>  
>  			trips {
> @@ -937,8 +917,6 @@ map0 {
>  		};
>  
>  		cpu3-thermal {
> -			polling-delay-passive = <0>;
> -			polling-delay = <0>;
>  			thermal-sensors = <&tsens 13>;
>  
>  			trips {
> @@ -967,8 +945,6 @@ map0 {
>  		};
>  
>  		wcss-phyb-thermal {
> -			polling-delay-passive = <0>;
> -			polling-delay = <0>;
>  			thermal-sensors = <&tsens 14>;
>  
>  			trips {
> @@ -981,8 +957,6 @@ wcss_phyb-critical {
>  		};
>  
>  		top-glue-thermal {
> -			polling-delay-passive = <0>;
> -			polling-delay = <0>;
>  			thermal-sensors = <&tsens 15>;
>  
>  			trips {
> 
> -- 
> 2.40.1
> 
> 

