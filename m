Return-Path: <linux-kernel+bounces-39272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3610583CDF0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E051D1F26D59
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E937E13A240;
	Thu, 25 Jan 2024 21:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B/GIJejZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FA31386B5;
	Thu, 25 Jan 2024 21:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216441; cv=none; b=X15WIUW2wd3033tIAtaIz+0byAZZDVidKG0Vfkiqpy3Anp4rpZuLD0P0GTMz3WWbavZ+IJB04vCjFwlGowblH79ntDWPJMf97OaW78ZBsldVZ9mE5KX2InqZ3160CIaAAtEgI3B/K+KoeIBckjhhXFUAZiZXFKzR8SGb9HWXB24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216441; c=relaxed/simple;
	bh=ok+32FtmVclV0n6TpLijrlAAhb9UWUJRHcgWWrOsCho=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtggdpC5YK330t2ygwlMuDt+/IWA7Vb30DXSSRLzB5N0iE1GuSMckyM73VrFxqE8tbB34q7p1aj8xpSydetBFJhxIqcdrNib+YPSgaOXfH/CgvVJWAxZTrrrSAL7tGyZHp2OCZagIyO1Ne228hPKMounXenlEAqqjhhr/cE2B0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B/GIJejZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40PITWOx010339;
	Thu, 25 Jan 2024 21:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=qYbd+OgO9VT2uIIAAIIiB
	iDYaYXBdYYPdxEdS1JCPeI=; b=B/GIJejZ46j9qkZmmsAhjANbwmtB4voZO09Ua
	Vood/zrUeUC+TRVbih2Vuu636SrX6xrLvbMTu+o/V9wWjr83VmMhk/ItDf2z+3Dl
	kHNSwjDd18NTg14qIH2u/n4hUxJtlQHHSP7X3fiTAg7HA6N8RoRLHNY32D208tx9
	vNyESANezegWQSbZSotpAG+Z/upV2p/ZNO5PKEuNiKMnK/LOLUnN9A1zi+n83cR5
	+hFRaxGnc8pjtE2otnyUUz3CJwK7PlgmVM/o2rLvEVtSbfjrP/GRSaOQKe2+A52d
	SYKmzB6llcv9S4SxCx6ABpKjQ6N+8Jzqx8e2jkssdZJpCDKmw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vun6w1tfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 21:00:18 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40PL0HWD022504
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 21:00:17 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 25 Jan 2024 13:00:16 -0800
Date: Thu, 25 Jan 2024 13:00:15 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Johan Hovold
	<johan+linaro@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 1/8] dt-bindings: clock: qcom: Allow VDD_GFX supply to
 GX
Message-ID: <20240125210015.GL2936378@hu-bjorande-lv.qualcomm.com>
References: <20240123-sa8295p-gpu-v3-0-d5b4474c8f33@quicinc.com>
 <20240123-sa8295p-gpu-v3-1-d5b4474c8f33@quicinc.com>
 <f6844d28-c7c2-4afa-8520-2e62c608930d@linaro.org>
 <20240124212116.GH2936378@hu-bjorande-lv.qualcomm.com>
 <cc68112f-3863-4f82-b708-7787a4895a88@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cc68112f-3863-4f82-b708-7787a4895a88@linaro.org>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: T61nsVoCgfHh9mUrWbMo-vwlSjlVLmgd
X-Proofpoint-ORIG-GUID: T61nsVoCgfHh9mUrWbMo-vwlSjlVLmgd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_13,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=530
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 phishscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250150

On Thu, Jan 25, 2024 at 08:39:15AM +0100, Krzysztof Kozlowski wrote:
> On 24/01/2024 22:21, Bjorn Andersson wrote:
> > On Wed, Jan 24, 2024 at 07:31:34AM +0100, Krzysztof Kozlowski wrote:
> >> On 24/01/2024 05:25, Bjorn Andersson wrote:
> >>> +# Allow either power-domains or vdd-gfx-supply, not both
> >>> +oneOf:
> >>> +  - required:
> >>> +      - power-domains
> >>> +  - required:
> >>> +      - vdd-gfx-supply
> >>> +  - not:
> >>> +      anyOf:
> >>> +        - required:
> >>> +            - power-domains
> >>> +        - required:
> >>> +            - vdd-gfx-supply
> >>
> >> I don't fully understand what you want to achieve here. If only "allow
> >> either", so not a "require either", then simpler:
> >>
> >> https://lore.kernel.org/all/20230118163208.GA117919-robh@kernel.org/
> >>
> > 
> > As discussed in v2, power-domains is currently an optional property in
> > this binding and I'm adding vdd-gfx-supply as an alternative to that.
> > 
> 
> Then go with Rob's syntax - not:required: Much easier code.
> 

I looked at it, but was not able to understand that it expressed my
desired result. Now I do, and I agree with you, so will update it.

Thanks,
Bjorn

