Return-Path: <linux-kernel+bounces-59797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4815084FBD5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F87286C31
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1430B80BF2;
	Fri,  9 Feb 2024 18:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M3+c8kOa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C88364D6;
	Fri,  9 Feb 2024 18:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707503057; cv=none; b=huwKjQHJCNkKpATmLOHMklhS47O0FNM+IdvASYkTgBG2z5WWQfr+QmrCwVOlbVvapj9kax+xDMgOh1pJmdTQ+7/BssC9kdsEUH7t7Wqz1yG7AF1knrk/8+8O6sCSPPXOKp9/dzoo0MCuDeNE7EaVa6DtIBnkfK3t3aDw7PCyEQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707503057; c=relaxed/simple;
	bh=PgZPAVkl0LXmi0Xe3yog5F2rMh5y1yDtq+xvo9DtUTA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqMgrKVMdyxO4s9tD2X2HZp/OauzjT45C4PjwVni0JYrB/iNkhMQ9IbiLK4VyZi1JTDPWtiLxD91/jmiu1SLJvVlChYQv85XqJEWYqicrE3PsMcnW1k/82YP/I8qmtXokj15gGfoQ2O/eiewUzMp8RTVPbEx8Plp0OfTMdzYdtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M3+c8kOa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 419Cunxb015379;
	Fri, 9 Feb 2024 18:24:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=QBdBsX0kPn8MiHnpBrXAS
	253OIjig4HJEiEMOsctvCM=; b=M3+c8kOa0mDK9+kixxfmdzW03Nh9rFNuG2xbg
	eLpISSIwkZ9OReotSKbGMKFPayMINoJzdDGRrYJMH5ewzmO2Ea4g49Jw+2uqxve0
	IW1bplbruL4LWJwJBMmgmLhWcmr5N+jQsZ8yyksyFczU07zfQUrPQbkDZ4NqN1Dd
	chk92RTY3wR30f6khe3ZLhUvgu11uCCQz9nZnUDFySApJPUqdzjPLtr0rVxknFwE
	9oUEY+b1tlSlqTgrSdhPT41uNz/QQ4gL4WfHDGoeU4a76PXfvgl6Q2jc7tg+orQa
	aIt2bOhoIVFvkj3RBrVhW9vQkQ2CDd99CcYKgLog/+17ZsWhw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4m3an7jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 18:24:10 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 419IO9DY011544
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Feb 2024 18:24:09 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 9 Feb 2024 10:24:08 -0800
Date: Fri, 9 Feb 2024 10:24:07 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Luca Weiss <luca.weiss@fairphone.com>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Declare GCC clocks
 protected
Message-ID: <20240209182407.GA2936378@hu-bjorande-lv.qualcomm.com>
References: <20240209-qcm6490-gcc-protected-clocks-v1-1-bd3487b2e7b1@quicinc.com>
 <CZ0P9E67Q6AQ.TU3Q2Y8VTWUK@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CZ0P9E67Q6AQ.TU3Q2Y8VTWUK@fairphone.com>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1-KVbzFurcW5HxvV0RSx9Uz0Vk4Q8jxT
X-Proofpoint-GUID: 1-KVbzFurcW5HxvV0RSx9Uz0Vk4Q8jxT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_16,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxlogscore=605 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402090134

On Fri, Feb 09, 2024 at 05:47:35PM +0100, Luca Weiss wrote:
> On Fri Feb 9, 2024 at 5:21 PM CET, Bjorn Andersson wrote:
> > The SC7180 GCC binding describes clocks which, due to the difference in
> 
> SC7180 -> SC7280?
> 

Indeed, got lost in the number soup.

> With that fixed:
> 
> Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>
> 
> > security model, are not accessible on the RB3gen2 - in the same way seen
> > on QCM6490.
> >
> > Mark these clocks as protected, to allow the board to boot.
> 
> So the board never was able to boot before this patch?
> 

Correct.

With this and the correction of the voltage ranges for vph_pwr, the
board is now booting with only some minor errors in the log...

Regards,
Bjorn

> >
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> > I did notice Taniya's patch [1] after writing this patch. I'd prefer to
> > merge this minimal set asap, to make the board boot, unless there's a
> > strong argument for including those other clocks in the protected list.
> >
> > [1] https://lore.kernel.org/linux-arm-msm/20240208062836.19767-6-quic_tdas@quicinc.com/
> > ---
> >  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > index 8bb7d13d85f6..97b1586f9f19 100644
> > --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > @@ -413,6 +413,24 @@ vreg_bob_3p296: bob {
> >  	};
> >  };
> >  
> > +&gcc {
> > +	protected-clocks = <GCC_CFG_NOC_LPASS_CLK>,
> > +			   <GCC_EDP_CLKREF_EN>,
> > +			   <GCC_MSS_CFG_AHB_CLK>,
> > +			   <GCC_MSS_GPLL0_MAIN_DIV_CLK_SRC>,
> > +			   <GCC_MSS_OFFLINE_AXI_CLK>,
> > +			   <GCC_MSS_Q6SS_BOOT_CLK_SRC>,
> > +			   <GCC_MSS_Q6_MEMNOC_AXI_CLK>,
> > +			   <GCC_MSS_SNOC_AXI_CLK>,
> > +			   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
> > +			   <GCC_QSPI_CORE_CLK>,
> > +			   <GCC_QSPI_CORE_CLK_SRC>,
> > +			   <GCC_SEC_CTRL_CLK_SRC>,
> > +			   <GCC_WPSS_AHB_BDG_MST_CLK>,
> > +			   <GCC_WPSS_AHB_CLK>,
> > +			   <GCC_WPSS_RSCP_CLK>;
> > +};
> > +
> >  &qupv3_id_0 {
> >  	status = "okay";
> >  };
> >
> > ---
> > base-commit: b1d3a0e70c3881d2f8cf6692ccf7c2a4fb2d030d
> > change-id: 20240209-qcm6490-gcc-protected-clocks-ee5fafdb76b3
> >
> > Best regards,
> 

