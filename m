Return-Path: <linux-kernel+bounces-8949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D508681BE74
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7401F258AD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DC465193;
	Thu, 21 Dec 2023 18:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Dod2Pbof"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FE81F168;
	Thu, 21 Dec 2023 18:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BLChLbb004616;
	Thu, 21 Dec 2023 18:48:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=sQxnXv2QZ91rvTy9EikfE
	DboCiFHZdWI2Das2uHCzEQ=; b=Dod2PbofTkdrw5ydPU4RlkfLkdq48BcGzbxVQ
	2JiX5XqSVhaNnZrqvgwqRPyvwjkTvb1QG98md1Bjk+hljlgjjWZnAbBonY6+HYYa
	oMDjHYCzf5gqY9VTgg05QKSBJX9wtjIQwEXyXBZNet5E3ca192cdX77kElWfY4g4
	glJ3FkvTnqy967NHvsql/Xmp45euyz5JM6N5y8YFtz56yOXzsu1gVnYXUeS/GL4H
	Me7TE4oHJcbHQ10L9BlbcmYpdB4wlB2+2njlFfrXtgtyvnMKt5bnW5EYEAeSj9zH
	ZgoewfhJshyvVFpVU5T+mlnoGrsIzfpJ11VuPwQAHb6UxWHcw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4j43hqah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 18:48:14 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BLImDqI017158
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 18:48:13 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Dec 2023 10:48:12 -0800
Date: Thu, 21 Dec 2023 10:48:11 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 6/8] arm64: dts: qcom: sa8295p-adp: add max20411
Message-ID: <20231221184811.GR1766637@hu-bjorande-lv.qualcomm.com>
References: <20231220-sa8295p-gpu-v1-0-d8cdf2257f97@quicinc.com>
 <20231220-sa8295p-gpu-v1-6-d8cdf2257f97@quicinc.com>
 <b6866ee4-31d9-4404-9bd9-92bc4ab59b8c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b6866ee4-31d9-4404-9bd9-92bc4ab59b8c@linaro.org>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: b9eDND2NLVzdrH67u4FycB7wqL-w-D19
X-Proofpoint-GUID: b9eDND2NLVzdrH67u4FycB7wqL-w-D19
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0 mlxlogscore=916
 mlxscore=0 phishscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312210143

On Thu, Dec 21, 2023 at 01:51:58PM +0100, Konrad Dybcio wrote:
> On 21.12.2023 04:50, Bjorn Andersson wrote:
> > From: Bjorn Andersson <andersson@kernel.org>
> > 
> > The SA8295P ADP has a MAX20411 LDO regulator on I2C 12, supplying the
> > VDD_GFX pads. Enable the bus and add the maxim,max20411 device on the
> > bus.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 40 ++++++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> > index fd253942e5e5..e16406c9c19d 100644
> > --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> > +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> > @@ -266,6 +266,26 @@ &dispcc1 {
> >  	status = "okay";
> >  };
> >  
> > +&i2c12 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&qup1_i2c4_state>;
> property-n
> property-names
> 
> (same below)
> > +
> > +	status = "okay";
> > +
> > +	vdd_gfx: regulator@39 {
> > +		compatible = "maxim,max20411";
> > +		reg = <0x39>;
> > +
> > +		regulator-min-microvolt = <800000>;
> > +		regulator-max-microvolt = <968750>;
> Is this ever going to be scaled? I suppose you could add some OPP code to
> drm/msm and use opp-microvolts.. Or lock this down at min=max
> 

Downstream leave it at 0.8V, so let's lock it down for now.

Regards,
Bjorn

> Konrad

