Return-Path: <linux-kernel+bounces-40372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5E983DF2D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EDCE1C21ACF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBAD1DFCA;
	Fri, 26 Jan 2024 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pBNOeetC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998761D69B;
	Fri, 26 Jan 2024 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706287880; cv=none; b=rqfBW8PXvff6ICcAcA4B9AWiByqdEHtT93qU1741/IPPjDY04NGQt+DVduQHsID7JS2cL9dcGNBrTF8iHuTsVF3tnBUXQ8t0u0eRnZ6dp34VRKeR5fHDlbbuXR8eaFge9IUMPfJZN5KI7fIp6R74/seM0ThUrcT1ajlIFE2KBKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706287880; c=relaxed/simple;
	bh=Dvo77+b0CaXF8L8N/JnH1v9l4fUzUkl8fbokmIY7bvo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tngAkiSF2M2qK0WO8S4hgpVgkfMqwwlu7vsvEAUKorJEN7F77Cr4DdCNlOVLZ/WNf/HXEXLULAJdWaTa0TvZSr8E815LgcWR2uxzLSh/3p5CHqeHzUs6P2wk3zrFd7UAcMnfsQNqfcTmI8iZFRJtr9zILqbLv17m2T6i2+l2nkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pBNOeetC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QDk8kL017809;
	Fri, 26 Jan 2024 16:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=sDGZNUwgwzTAlymgzSlLI
	UNM2DehZJKdLtrw982F314=; b=pBNOeetCO5Md8vf91jwMTTwNHLylaZRqeoFpq
	EbMH80wjSP6b8jzhsJH7pth28oqkxbFile4Yfp/NJLF4PjeQ7d4vtU6pc/WpAnXn
	XOo7QRDqajtuT9/hAbs2ApQHJoIVBAUzas4EXDQZT/vWr6skChzWFj7Sa5EvOQRa
	CM6elaQ7IUwajF/NZAjl0CPiNzRisV7knjFYHLX+XB7mNeev7ZSkCAiwre/R/STg
	hWHWFC8RQLnr2zN6de/os8u/NJrCfuXGyCu4F2mgeEEU+GTQU8NsUz7u65lk+05U
	zkTlXOocYmTMB+5EmdrejDc5drU/LT7LksL8d/diXTnPBPX5w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vv4v81mj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 16:51:15 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QGpEcT030211
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 16:51:14 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 08:51:14 -0800
Date: Fri, 26 Jan 2024 08:51:13 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Johan Hovold <johan@kernel.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc8280xp: Introduce additional
 tsens instances
Message-ID: <20240126165113.GS2936378@hu-bjorande-lv.qualcomm.com>
References: <20240126-sc8280xp-tsens2_3-v2-1-8504d18828de@quicinc.com>
 <ZbPfeq6ElA3vMf_O@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZbPfeq6ElA3vMf_O@hovoldconsulting.com>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 91C-FdgUp8b2zTqdqCZJ4mW7-GW6_Mi1
X-Proofpoint-ORIG-GUID: 91C-FdgUp8b2zTqdqCZJ4mW7-GW6_Mi1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=842
 adultscore=0 impostorscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260124

On Fri, Jan 26, 2024 at 05:36:10PM +0100, Johan Hovold wrote:
> On Fri, Jan 26, 2024 at 07:12:45AM -0800, Bjorn Andersson wrote:
> > The SC8280XP contains two additional tsens instances, providing among
> > other things thermal measurements for the GPU.
> > 
> > Add these and a GPU thermal-zone.
> > 
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> > Changes in v2:
> > - Drop TM/SROT comments
> > - Remove polling delays, rely on interrupts
> > - Link to v1: https://lore.kernel.org/r/20240118-sc8280xp-tsens2_3-v1-1-e86bce14f6bf@quicinc.com
> > ---
> >  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 37 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > index febf28356ff8..7bfbb1bd8f4a 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > @@ -4033,6 +4033,28 @@ tsens1: thermal-sensor@c265000 {
> >  			#thermal-sensor-cells = <1>;
> >  		};
> >  
> > +		tsens2: thermal-sensor@c251000 {
> > +			compatible = "qcom,sc8280xp-tsens", "qcom,tsens-v2";
> > +			reg = <0 0x0c251000 0 0x1ff>,
> > +			      <0 0x0c224000 0 0x8>;
> > +			#qcom,sensors = <11>;
> > +			interrupts-extended = <&pdc 122 IRQ_TYPE_LEVEL_HIGH>,
> > +					      <&pdc 124 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-names = "uplow", "critical";
> > +			#thermal-sensor-cells = <1>;
> > +		};
> > +
> > +		tsens3: thermal-sensor@c252000 {
> > +			compatible = "qcom,sc8280xp-tsens", "qcom,tsens-v2";
> > +			reg = <0 0x0c252000 0 0x1ff>,
> > +			      <0 0x0c225000 0 0x8>;
> > +			#qcom,sensors = <5>;
> > +			interrupts-extended = <&pdc 123 IRQ_TYPE_LEVEL_HIGH>,
> > +					      <&pdc 125 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-names = "uplow", "critical";
> > +			#thermal-sensor-cells = <1>;
> > +		};
> 
> These should go before tsens0 based on the unit address.
> 

You're right, thanks for spotting that.

> > +
> >  		aoss_qmp: power-management@c300000 {
> >  			compatible = "qcom,sc8280xp-aoss-qmp", "qcom,aoss-qmp";
> >  			reg = <0 0x0c300000 0 0x400>;
> > @@ -5212,6 +5234,21 @@ cpu-crit {
> >  			};
> >  		};
> >  
> > +		gpu-thermal {
> > +			polling-delay-passive = <0>;
> > +			polling-delay = <0>;
> > +
> > +			thermal-sensors = <&tsens2 2>;
> > +
> > +			trips {
> > +				cpu-crit {
> > +					temperature = <110000>;
> > +					hysteresis = <1000>;
> > +					type = "critical";
> > +				};
> > +			};
> > +		};
> 
> Shall you submit a follow-on patch to set the polling delays to zero
> for the other thermal zones (cpu, cluster, mem) so that we don't poll
> for those?
> 

I optimistically interpreted Konrad's response as a promise by him to do
so ;)

I do like his patch which remove the poll-properties for non-polling
mode. Would be nice to not first change the values to 0 and then remove
the properties...

> Looks good to me otherwise: 
> 
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> 

Thanks,
Bjorn

> Johan

