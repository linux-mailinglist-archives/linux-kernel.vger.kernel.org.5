Return-Path: <linux-kernel+bounces-8993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 720AE81BF02
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43BD1C217A9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1731865198;
	Thu, 21 Dec 2023 19:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PKdBIb1C"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18407651A4;
	Thu, 21 Dec 2023 19:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BLDMiN7031672;
	Thu, 21 Dec 2023 19:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=M4ofItWEa2ZMEZHfAhfrl
	hv/rg3HOV3fP0U/2gxcGck=; b=PKdBIb1CfcNOW97RL8HOl87615EbrPMxnp+Ne
	PvEW4c4XXleqzMpI4vC8L5NeyZYPtlbvWu+PSwE31ibC9bg6SaALCkCpvwEMzvMS
	Z7VlLslOlTRrKQl3MVbTh1hR5mVay5g/oRjeU6rSPk4iMzpp+zU5x55nfiEO3zaQ
	IL+hfRWb5JSgcznKak74AvsVNYsYsZ33JfsjcXnWCtKSC8d1HB3JRE4B/XA4qFls
	/e4v8VTK4Em+GZetTkBYAAS91IoXWTVkN1rxPGYpcCOb/kASLR67QU8/uvDoBOlb
	Dos+LpEphOOte/6awbJ3J9EyXy7FEtradpfqFWmEylXRN6/6g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4gvh25pn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 19:16:36 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BLJGara031058
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 19:16:36 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Dec 2023 11:16:35 -0800
Date: Thu, 21 Dec 2023 11:16:34 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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
        Ulf Hansson
	<ulf.hansson@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        "Catalin
 Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/8] dt-bindings: clock: qcom: Allow VDD_GFX supply to GX
Message-ID: <20231221191634.GS1766637@hu-bjorande-lv.qualcomm.com>
References: <20231220-sa8295p-gpu-v1-0-d8cdf2257f97@quicinc.com>
 <20231220-sa8295p-gpu-v1-1-d8cdf2257f97@quicinc.com>
 <CAA8EJprRjRJsV5hPR6mzjgucKa8UEthJd-y573aYJH0P8QRWqw@mail.gmail.com>
 <CAA8EJpqgcOJHUFHtrTEE0T+jtQqdv3RGm-eTuVVa0ama_eFssQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJpqgcOJHUFHtrTEE0T+jtQqdv3RGm-eTuVVa0ama_eFssQ@mail.gmail.com>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sdqrhYe5YehdA1OTvNJ99Jnj2rDKz_Bz
X-Proofpoint-GUID: sdqrhYe5YehdA1OTvNJ99Jnj2rDKz_Bz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 adultscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312210146

On Thu, Dec 21, 2023 at 09:10:28AM +0200, Dmitry Baryshkov wrote:
> On Thu, 21 Dec 2023 at 09:03, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Thu, 21 Dec 2023 at 05:51, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
> > >
> > > In some designs the SoC's VDD_GFX pads are supplied by an external
> > > regulator, rather than a power-domain. Allow this to be described in the
> > > GPU clock controller binding.
> > >
> > > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > > ---
> > >  Documentation/devicetree/bindings/clock/qcom,gpucc.yaml | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> > > index f369fa34e00c..013ef78d2b31 100644
> > > --- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> > > +++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> > > @@ -53,6 +53,9 @@ properties:
> > >    power-domains:
> > >      maxItems: 1
> > >
> > > +  vdd-gfx-supply:
> > > +    description: Regulator supply for the VDD_GFX pads
> > > +
> > >    '#clock-cells':
> > >      const: 1
> >
> > I think it might be good to restrict this property to a particular
> > platform (via if:not:properties:compatible:contains
> > then:properties:vdd-gfx-supply:false).
> 
> After reading the last patches in the series, there is another
> suggestion. Maybe we should explicitly say that there should be either
> power-domains or vdd-gfx-supply, but not both.
> 

Even on this platform it's not a property of the SoC, but surrounding
design. So I like this proposal.

Thanks,
Bjorn

