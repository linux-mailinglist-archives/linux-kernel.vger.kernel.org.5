Return-Path: <linux-kernel+bounces-37684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0E583B3CD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B5A1F273E2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD0B1353E8;
	Wed, 24 Jan 2024 21:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Mme52Erm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27907E760;
	Wed, 24 Jan 2024 21:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131288; cv=none; b=iF8hmDiMo0Ji+eM9Nsjv3R0pTJDOU2eLQJZJLZ0hsLnaGjpoA6SMNZLim+ElFgwm9wxrDdBjqFyAHxa8CJQ3wNf5n6O5s/5bsyyqshKCDAbupvRVlw2tlnXweWyf2UXhRaawNuX66XOnwCI+f+9CgTHaOTDZ7SBRuv5iO9jGsdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131288; c=relaxed/simple;
	bh=FzOKL9KxZDnA9cvK6swo/MuG4jFcfk0VvlqEQegPZuM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwzDoNxCrr864qeHlF53AOVBuvpdSgzOqba+aqBBsLiAH9HHjZOojj+gJ1b2EfNj0Q//YLNbRLPauxjR/k63u8WyprUL4ChJvrdC5TKAcyvIIi0VDeUpFpxnUx2gb3yPBDhCGXTj0tRU3rdE/sb18GyEf2EnwuE5dB+YA+3E6iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Mme52Erm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40OKkjkD001981;
	Wed, 24 Jan 2024 21:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=NrQMdqBAv+lIUzaRxo00i
	82mdCZlOLZNAfk2vB4ojS4=; b=Mme52Erm7bRgY2cHMG7zrbWV9VeZlueP72/SI
	JzCtHwuU1jvIbLmKRsg0RAMQ7t4nsxFzJRFy+ZLB8y5n2MyYgVEiSiHgU4myr+Gu
	4iCH8fGWtSycVUDtW5gJklU+HyTQ/dZBKVA+eu0Shf9Gv3hg0UOQinH08UMr0iNH
	dZwPVprAOXP+2tPbYVscUV8RUMgLYWX9TWF1rqXzplwJTYt0lpOA6NGBe3ZXDWUi
	/3jgraC2txKrPuuessJ9P3r88C+0YHbpF3laifc/xTF5BAvd+HBix5ejLYyfmq6Y
	prHgL1hxangmbrrqWceKYs6qV3LejrDEEQXHvjxV74F/WPq+Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vu81g8b4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 21:21:18 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40OLLHoS012562
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 21:21:17 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 24 Jan 2024 13:21:17 -0800
Date: Wed, 24 Jan 2024 13:21:16 -0800
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
Message-ID: <20240124212116.GH2936378@hu-bjorande-lv.qualcomm.com>
References: <20240123-sa8295p-gpu-v3-0-d5b4474c8f33@quicinc.com>
 <20240123-sa8295p-gpu-v3-1-d5b4474c8f33@quicinc.com>
 <f6844d28-c7c2-4afa-8520-2e62c608930d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f6844d28-c7c2-4afa-8520-2e62c608930d@linaro.org>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PnLJdRJX2jEfCfQfJoYniqoyj87W6M1A
X-Proofpoint-ORIG-GUID: PnLJdRJX2jEfCfQfJoYniqoyj87W6M1A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_10,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0
 spamscore=0 malwarescore=0 impostorscore=0 mlxscore=0 mlxlogscore=771
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401240154

On Wed, Jan 24, 2024 at 07:31:34AM +0100, Krzysztof Kozlowski wrote:
> On 24/01/2024 05:25, Bjorn Andersson wrote:
> > +# Allow either power-domains or vdd-gfx-supply, not both
> > +oneOf:
> > +  - required:
> > +      - power-domains
> > +  - required:
> > +      - vdd-gfx-supply
> > +  - not:
> > +      anyOf:
> > +        - required:
> > +            - power-domains
> > +        - required:
> > +            - vdd-gfx-supply
> 
> I don't fully understand what you want to achieve here. If only "allow
> either", so not a "require either", then simpler:
> 
> https://lore.kernel.org/all/20230118163208.GA117919-robh@kernel.org/
> 

As discussed in v2, power-domains is currently an optional property in
this binding and I'm adding vdd-gfx-supply as an alternative to that.

As it's optional, barely any of our platforms define the property, so
requiring this would not be compatible with existing DT source.

It's clear that this does not accurately represent the power situation
for the block, so we should fix this. But I'd prefer to see that as a
separate task.


Implementation-wise, we need to figure how to consume multiple
power-domains in the GPUCC drivers in Linux, because the correct
definition seems to be to add both CX and GX/GFX domains here - and if
we just add them to the DT node Linux will break.

Regards,
Bjorn

