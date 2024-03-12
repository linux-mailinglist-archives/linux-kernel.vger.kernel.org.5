Return-Path: <linux-kernel+bounces-99920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BB6878F36
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01043B215C3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECDA69974;
	Tue, 12 Mar 2024 07:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ipfK8Rx1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D778B657;
	Tue, 12 Mar 2024 07:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710229746; cv=none; b=Y3k96D/StSBbTsWCyGAp0qGaQHiu77rsjF5HX5UTjkE4G0eR/71OY451liY/Ep/cVkQx1yhdU4GBktXeh8H5e5oCgIEGjOmY+Z0QD8hcA3rftIPOrtUmyNWs596DcYAeFmZeIJnqLKHUMk1o2h0Ph6dALWnFf5+kk7Jw2L/JTNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710229746; c=relaxed/simple;
	bh=CnDj4IfCHLZHcS/QVCnsqSx+w23pfSL78CMmdBfa9XA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TvG49A91PanVB/6uwk3LTePGqN9QkxZqRZ6SBW2Doh6o1Tv95dSRt/sopJek9TCjYzIgM5JInE7d06T6Z+8z6AjI5KxaR7sej7Sg4tixHtgGKIDLKZ8sFh9+RWCfSbKzP+vMtbiYqulqOrzHOKhFdyztDgIXITwAkz0IbLGqLBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ipfK8Rx1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42C69UPN027712;
	Tue, 12 Mar 2024 07:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=6Uzy/8D9SZEN26+WLHmsf3RcTY73t2Lstgw30JYn4wo=; b=ip
	fK8Rx1089YWDyPMu9MowG9vh32IQVKBbjlT2xVoSCds7iOUICt2pJl8D75c2Ch6/
	Q0dlT3sw26Ww1J6GsCiAejZnIy1qHVjHj/clAMDawo0tzjYXg2CjgPk79hVR7QN+
	XE39Z5qAqlhD1O19isDUnAoo7Wv83AgfFnwUhJq/Bz2plOEJ2MKWwZPCbUo+3kKu
	Yk7yNZNK404JlnVrtfNl1pg8gGsKB/AaHEGRO7mfti20CbmpDxSP5xT2LY4aBUXf
	e5FTP8yuTTgQK64UpM5F1vxpImMwtaMOTdg6Y9D3svfZENxagOxjvDITKYhOqpho
	dX9OsCxWk8rEsDzKX8fQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wth7rr6y5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 07:48:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42C7mxur006194
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 07:48:59 GMT
Received: from [10.216.13.198] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 12 Mar
 2024 00:48:55 -0700
Message-ID: <b25ce24d-12d1-4112-9c35-30a75634f9fc@quicinc.com>
Date: Tue, 12 Mar 2024 13:18:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Add missing hs_phy_irq in USB
 nodes
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>
References: <20240219075720.640529-1-quic_kriskura@quicinc.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20240219075720.640529-1-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bK8TgxxplakkFS6aXl3vXr-5TDomRXAk
X-Proofpoint-ORIG-GUID: bK8TgxxplakkFS6aXl3vXr-5TDomRXAk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_06,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 mlxlogscore=634 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403120060



On 2/19/2024 1:27 PM, Krishna Kurapati wrote:
> Recent binding update [1] indicates that there are hs_phy_irq
> present in primary and secondary usb controllers of sc8280xp.
> 
> Add the missing hs_phy_irq for these controllers. Since the driver
> doesn't use this interrupt, this change has been only compile
> tested.
> 
> [1]: https://lore.kernel.org/all/20231227091951.685-2-quic_kriskura@quicinc.com/
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index a5b194813079..62e2b99915af 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -3361,10 +3361,12 @@ usb_0: usb@a6f8800 {
>   			assigned-clock-rates = <19200000>, <200000000>;
>   
>   			interrupts-extended = <&intc GIC_SPI 804 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&intc GIC_SPI 805 IRQ_TYPE_LEVEL_HIGH>,
>   					      <&pdc 14 IRQ_TYPE_EDGE_BOTH>,
>   					      <&pdc 15 IRQ_TYPE_EDGE_BOTH>,
>   					      <&pdc 138 IRQ_TYPE_LEVEL_HIGH>;
>   			interrupt-names = "pwr_event",
> +					  "hs_phy_irq",
>   					  "dp_hs_phy_irq",
>   					  "dm_hs_phy_irq",
>   					  "ss_phy_irq";
> @@ -3421,10 +3423,12 @@ usb_1: usb@a8f8800 {
>   			assigned-clock-rates = <19200000>, <200000000>;
>   
>   			interrupts-extended = <&intc GIC_SPI 811 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&intc GIC_SPI 790 IRQ_TYPE_LEVEL_HIGH>,
>   					      <&pdc 12 IRQ_TYPE_EDGE_BOTH>,
>   					      <&pdc 13 IRQ_TYPE_EDGE_BOTH>,
>   					      <&pdc 136 IRQ_TYPE_LEVEL_HIGH>;
>   			interrupt-names = "pwr_event",
> +					  "hs_phy_irq",
>   					  "dp_hs_phy_irq",
>   					  "dm_hs_phy_irq",
>   					  "ss_phy_irq";

Gentle ping for review.
Thanks in advance.

- Krishna

