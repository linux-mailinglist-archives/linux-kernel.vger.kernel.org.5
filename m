Return-Path: <linux-kernel+bounces-127153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A607894780
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35180283730
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC60756B6F;
	Mon,  1 Apr 2024 22:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oum5Y+Kt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914575644E;
	Mon,  1 Apr 2024 22:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712012139; cv=none; b=WJXaWDq0VPOZ5H095PgeVftplTcJj6XOEBThUTBPSqhnY8ouiQ3xiVgIeBq0tjGagQLdu4qqbRLcbLEPnlUxx+z9x9UqW8nyHgT/3AxLwh3G8W4xGS2UGBmFTzqm/n7c3NCdff+g2lwH/WDCbhoIqETj9FPFPx3a7jmMOif4zoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712012139; c=relaxed/simple;
	bh=x3ePgie20BKz3/0JgExygH6c+y0Q/ablqbQfmT/CvFM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StBuOmcpeQjjgFWm4SfLW2cVrKWBzjOE20tJhQElfFOFRhVuNGoQFW70Pc+B5g67nkSHrN6w9l+kAX3DRzIk6vbQNCjxCJqOwA4sfLFMPKkgOj+MK0GNdg6bdQZ13dDBB0keyjCP+L4GAoyBFsdzhZn09kXePe1eLiSYIcU5al0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oum5Y+Kt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 431LfiNu006910;
	Mon, 1 Apr 2024 22:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=sGn7IBkoj6U5EbmA4fihg
	co2JtnZzSxt6wX7u+QxBfg=; b=oum5Y+KtDn5Bu2vhXXTzUkECVGb0FTz7Jiejb
	zmBfPdrrbOTjElQpQ3TqdtxoUf0IGWf6kXbGctnJv7VbdBKE2mS8jh7y3f2K3tVf
	XeeRw2HurdnRf63maIWMsJ2l3cRfFA4X4qE57Eyox0uVpYCg20FVSquD+NvEyGZT
	UL+Q8DDZ5XN4Avkj+Qa8zG2B9C7tVP6s2+5wOR/9Ae1u4MoK8IYQzIniGtIVCSPL
	IyQuhIe72fr6UfJf9a+Qw6FXVsMzVPPtQ/WXx/GrLpYrGlz/qPpSnJ4xbt/mDDbO
	dOkNzPyJ6b4LEymi2yIqAO38ht+YkeVwgPGYmBTdhmkk/T7Zw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x803d8ujt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 22:55:31 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 431MtVJY008535
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Apr 2024 22:55:31 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 1 Apr 2024 15:55:30 -0700
Date: Mon, 1 Apr 2024 15:55:29 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Komal Bajaj <quic_kbajaj@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Amrit Anand <quic_amrianan@quicinc.com>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: qdu1000-idp: enable USB nodes
Message-ID: <Zgs7Yau1/jYvys4i@hu-bjorande-lv.qualcomm.com>
References: <20240319091020.15137-1-quic_kbajaj@quicinc.com>
 <20240319091020.15137-3-quic_kbajaj@quicinc.com>
 <CAA8EJprXPvji8TgZu1idH7y4GtHtD4VmQABFBcRt-9BQaCberg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJprXPvji8TgZu1idH7y4GtHtD4VmQABFBcRt-9BQaCberg@mail.gmail.com>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: E59YW7_rvDS6jE2ikFvPW9_UiCNBzOJV
X-Proofpoint-GUID: E59YW7_rvDS6jE2ikFvPW9_UiCNBzOJV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_16,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=784
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404010160

On Tue, Mar 19, 2024 at 11:52:15AM +0200, Dmitry Baryshkov wrote:
> On Tue, 19 Mar 2024 at 11:11, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
> >
> > Enable both USB controllers and associated hsphy and qmp phy
> > nodes on QDU1000 IDP. Add the usb type B port linked with the
> > DWC3 USB controller switched to OTG mode and tagged with
> > usb-role-switch.
> >
> > Co-developed-by: Amrit Anand <quic_amrianan@quicinc.com>
> > Signed-off-by: Amrit Anand <quic_amrianan@quicinc.com>
> > Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> > ---
> >  arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 65 ++++++++++++++++++++++++
> >  1 file changed, 65 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> > index 89b84fb0f70a..26442e707b5e 100644
> > --- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> > +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> > @@ -46,6 +46,33 @@ ppvar_sys: ppvar-sys-regulator {
> >                 regulator-boot-on;
> >         };
> >
> > +       usb_conn_gpio: usb-conn-gpio {
> > +               compatible = "gpio-usb-b-connector";
> 
> If this board has only a USB-B connector, can it really handle USB 3.0?
> 

Here's a USB 3.0 Type-B cable, so no problem there:
https://en.wikipedia.org/wiki/USB_hardware#/media/File:USB_3.0_plug,_type_B_-_1709.jpg


@Komal, please confirm that this is the connector you have on the IDP?

Regards,
Bjorn

