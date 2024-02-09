Return-Path: <linux-kernel+bounces-59822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B642084FC28
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76DCE2839DA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD51586ADE;
	Fri,  9 Feb 2024 18:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f7r2TGpU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A1A86126;
	Fri,  9 Feb 2024 18:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707504056; cv=none; b=WxIApv7OOaK1I7QWviOeJvvzfBkVQrrZk5f2MTYkOongfp3HQc+rG+dLFFpeuD3nOKcDhjIFlhCLPkuTIOGB9t9pQvtTP1KcwDwgCE8/Ccha4xkbbQVksu0Ev351fel77on2MH58KPEWVwVx4Ndh5WaQya9MxHRgfdetUDawpAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707504056; c=relaxed/simple;
	bh=BKNQSuPVa2RVwMPfjPNyzaEGK8eenV1H2PpHZXkt30s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjNsCCoWD/Gn/57TfieHKUAm9ZxasNIUpbREs4N6ZVRqs185WcWB1fiG9Js84QfEKD0HCswqowRwmU+512X9RgwkS/gmVIeh/sJJLgphaQTg4yfkNUzGeeZ4I8LDvpl/7Y7l73JHZJpyL88h7UvdIu4UERxNnUpD2w8Y/4n24RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=f7r2TGpU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 419GUiEj013042;
	Fri, 9 Feb 2024 18:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=ZgnHF/ikoNR4V9ITAX3Gn
	CNosN99diJjNhBScY/Vods=; b=f7r2TGpUSd+/UPuUGFn3Wa6X4DyiP5BRF2Ja0
	8mnhGwkl5bHDdXJ6ApZpAtIs2Jnr2wUnRBgF411u79X+JZGaH9Mmg2rIY2hs0WEv
	5hQ8wMuVJIRVSYHAi3HS/VP6jTLyqXSJt+B0p2+yfJyJbHO4yYwsgQZbZJD4Kbzi
	5jycEQrxlCr00Kyf5fc5e3Ovk1lrqFfgfT9h2PwMes83qz80phUbKkad8yeAoqMX
	DgcNp9SV17pz8qra4lOpzZn+KZZE2wXrZaDHcKDPLbf+5oh1RZVMqoIZ4tnE3wJ/
	lvzejCoMxNcZumcAy/pp0d9u7NQO8mBcgeODpSceY8JgqA0Xw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w5m158sc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 18:40:49 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 419IemwE031201
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Feb 2024 18:40:48 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 9 Feb 2024 10:40:47 -0800
Date: Fri, 9 Feb 2024 10:40:46 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Declare GCC clocks
 protected
Message-ID: <20240209184046.GB2936378@hu-bjorande-lv.qualcomm.com>
References: <20240209-qcm6490-gcc-protected-clocks-v1-1-bd3487b2e7b1@quicinc.com>
 <CAA8EJpr987frG7rpceybSmg8TFj-OsQeoRKBdLT=dnTbfzruKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJpr987frG7rpceybSmg8TFj-OsQeoRKBdLT=dnTbfzruKQ@mail.gmail.com>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zUXhDf_aS1WxVx85JtWM3jeI6hl7qfbs
X-Proofpoint-ORIG-GUID: zUXhDf_aS1WxVx85JtWM3jeI6hl7qfbs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_16,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=967 lowpriorityscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402090136

On Fri, Feb 09, 2024 at 08:01:15PM +0200, Dmitry Baryshkov wrote:
> On Fri, 9 Feb 2024 at 18:21, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
> >
> > The SC7180 GCC binding describes clocks which, due to the difference in
> > security model, are not accessible on the RB3gen2 - in the same way seen
> > on QCM6490.
> >
> > Mark these clocks as protected, to allow the board to boot.
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
> >         };
> >  };
> >
> > +&gcc {
> > +       protected-clocks = <GCC_CFG_NOC_LPASS_CLK>,
> > +                          <GCC_EDP_CLKREF_EN>,
> 
> I'd say these two clocks looks strange in this list, but you probably
> know what you are doing. Thus:
> 

Perhaps I wasn't clear enough in the commit message, I took this list
from one of the QCM6490 devices, as it seemed reasonable. I wondered
about this entry, but didn't pay enough attention and didn't test
without it.

But you're obviously correct, it would be very weird, in particular
considering that the board exposes &mdss_edp on a physical connector.

Sure enough, not only is it accessible, I hacked up a patch for enabling
DisplayPort (on &mdss_edp) and as expected it doesn't work without
GCC_EDP_CLKREF_EN.

> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 

Taking the liberty to carry this into v2.

Thank you,
Bjorn

> > +                          <GCC_MSS_CFG_AHB_CLK>,
> > +                          <GCC_MSS_GPLL0_MAIN_DIV_CLK_SRC>,
> > +                          <GCC_MSS_OFFLINE_AXI_CLK>,
> > +                          <GCC_MSS_Q6SS_BOOT_CLK_SRC>,
> > +                          <GCC_MSS_Q6_MEMNOC_AXI_CLK>,
> > +                          <GCC_MSS_SNOC_AXI_CLK>,
> > +                          <GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
> > +                          <GCC_QSPI_CORE_CLK>,
> > +                          <GCC_QSPI_CORE_CLK_SRC>,
> > +                          <GCC_SEC_CTRL_CLK_SRC>,
> > +                          <GCC_WPSS_AHB_BDG_MST_CLK>,
> > +                          <GCC_WPSS_AHB_CLK>,
> > +                          <GCC_WPSS_RSCP_CLK>;
> > +};
> > +
> >  &qupv3_id_0 {
> >         status = "okay";
> >  };
> >
> > ---
> > base-commit: b1d3a0e70c3881d2f8cf6692ccf7c2a4fb2d030d
> > change-id: 20240209-qcm6490-gcc-protected-clocks-ee5fafdb76b3
> >
> > Best regards,
> > --
> > Bjorn Andersson <quic_bjorande@quicinc.com>
> >
> 
> 
> -- 
> With best wishes
> Dmitry

