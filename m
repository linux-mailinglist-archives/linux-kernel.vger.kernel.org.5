Return-Path: <linux-kernel+bounces-157368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5C98B109A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C79391F21CE5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C070816D32E;
	Wed, 24 Apr 2024 17:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R70mT1Aa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC6913C672;
	Wed, 24 Apr 2024 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713978230; cv=none; b=oeZEjEvGaqgpX42RGt1xVoyXxMzw4TG35TZcraVsca/nJTT//8mZtwPNs1u8npf/U5CXwl5JM17ybIbU8Z40EUVeVCwtmuBpuhfIc7+KicUZAhvqGr30+POwkKGUlHznsOc6lZPpX4bMu2jo63QiTvP3VF1btbuiEj9dKq++TUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713978230; c=relaxed/simple;
	bh=T/ZAKPy8buCjIGF88sh6UkNXWW9YC7Q/1iCoPhwjICo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yew+2T5KRzpAJy+/IBdxE6D+zMq8LNRxGvFZGCnzAJodlOkigziuLdxwZNj2CHf24YXNteBkt3Zi9nC/YN7KpujC0PFzBml6LHm1V1KVnZOcKVJGUPRFbav4ECSH0lHxc1+8w5AEPaBY6300z/CaGiyj87VULHth9+idg6WMa08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R70mT1Aa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OGrUX7008348;
	Wed, 24 Apr 2024 17:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=aAP/A4cazOsZMHUrBbO9u
	js3tZYwr0E6vouW1eMsocI=; b=R70mT1AaMtL/nEexBQlKHi4L1lplQNQX4WA/H
	74cf1i2vBH3nl4uAoDbzqVeADgq7aSnocfWxMiDm2Bnzod81H3VjKHQUiTo1psb5
	BBPzK5lXFkTla/4dbP/nWUobI4LLH6dm99v3/xP3eBks31Wm+/ce3+A/v79/yXW/
	30uUuDq54psJHvpxWGRJDoga0Us7BExdhEtQdE/N3VcyG0JMX2bGbpEy34Z3B1zz
	ypAx1tmpJQPEs05q01UCM8sQvDoAHdnpRSqun2b378dVHWIC2PL28WtyJRNjranV
	lTlA6spxLdi35pbTxS7yxXTl5kxdfzNeVPkaq+xvrOYDT/tvQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9gsjrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 17:03:44 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43OH3htw011575
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 17:03:43 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 24 Apr 2024 10:03:42 -0700
Date: Wed, 24 Apr 2024 10:03:41 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Tengfei Fan <quic_tengfan@quicinc.com>
CC: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <manivannan.sadhasivam@linaro.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: cpufreq: cpufreq-qcom-hw: Add SM4450
 compatibles
Message-ID: <Zik7bbuDakqhXeI+@hu-bjorande-lv.qualcomm.com>
References: <20240424101503.635364-1-quic_tengfan@quicinc.com>
 <20240424101503.635364-2-quic_tengfan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240424101503.635364-2-quic_tengfan@quicinc.com>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Y8y0Oah7A-mLEHJbTSonoWgQAFD5RFOL
X-Proofpoint-ORIG-GUID: Y8y0Oah7A-mLEHJbTSonoWgQAFD5RFOL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_14,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1011
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 mlxlogscore=973
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240070

On Wed, Apr 24, 2024 at 06:15:01PM +0800, Tengfei Fan wrote:
> Add compatible for EPSS CPUFREQ-HW on SM4450.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>

Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Regards,
Bjorn

> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> index 56fc71d6a081..1e9797f96410 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> @@ -38,6 +38,7 @@ properties:
>                - qcom,sc7280-cpufreq-epss
>                - qcom,sc8280xp-cpufreq-epss
>                - qcom,sdx75-cpufreq-epss
> +              - qcom,sm4450-cpufreq-epss
>                - qcom,sm6375-cpufreq-epss
>                - qcom,sm8250-cpufreq-epss
>                - qcom,sm8350-cpufreq-epss
> @@ -133,6 +134,7 @@ allOf:
>                - qcom,sc8280xp-cpufreq-epss
>                - qcom,sdm670-cpufreq-hw
>                - qcom,sdm845-cpufreq-hw
> +              - qcom,sm4450-cpufreq-epss
>                - qcom,sm6115-cpufreq-hw
>                - qcom,sm6350-cpufreq-hw
>                - qcom,sm6375-cpufreq-epss
> -- 
> 2.25.1
> 

