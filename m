Return-Path: <linux-kernel+bounces-39342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5962983CF00
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D520D1F28583
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB03213AA2E;
	Thu, 25 Jan 2024 21:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZdJeUvlU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8119B131E4F;
	Thu, 25 Jan 2024 21:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706219802; cv=none; b=dF7yIvVs7PO2z0eUBJYuCRX21ES8jkAi/KX+6jwIuZaCmwXqVA0BQIOPo60kJwoeWn0gBp/FGl8w+t67QLSI3MW9ZR2WXyD1puXwvKM5EEfRK3jSnVFayslfDUGS7HpXGsoRDVcWVgsQK7F2nT2eph3v80CedUYUCCA4++HaV5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706219802; c=relaxed/simple;
	bh=cYFh6DjzhH4jld3C3WqVrzKThz5M18vad5QHxvxcs18=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmtvZOaX3hJmRlYgUhYP8waKbrhB/MEfYKUbQ80mhGqzpZ5rGmy0OszFNjyfVGyybXs7kxhWsZDU5hmcyNT2VEbS/xzmi2z1o8BZM7DGGZpRecv6vkSV0vnNHvCqtgg+s70jdS15we3zwSLqfkf7i5zCK4yypW1QueFKmUv43vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZdJeUvlU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40PKXrBG003195;
	Thu, 25 Jan 2024 21:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=MNIFjg7KPSS9mtkOLKuGF
	aB7m22e0JPWn0h7OZRAp+s=; b=ZdJeUvlUWnastTQpUi+xXJnndzb0TEgFajPp4
	6b5M7eTKwK3ixbHe4ImnqK5NO827ASabOhh309g5ePU0J2eKWlgJTKRlRn/6FTyj
	R1+O0hTbaasGRKTbGXO91SWX6d2UyuVlEVdqQFVLdunR6LETpm/iUqkoNt2f4Al2
	pryQxzHjY9XRKsE2LMDXebgrDV0OZtBX/wnTbyFZTjOce/hBRvlKMccr6PTP14ci
	WFI1LdY4dKqtzvybWCLgCyce2YJLjmcQ1PbHxiZ8rHWw8XmuYy3NyMoTyZZmgAs4
	IEYMQwZVNL7cRAWoKRAOp5omV0oR1K8P4Ul9jViAo7F1CwtBQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vumynhux0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 21:56:33 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40PLuWaI013022
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 21:56:32 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 25 Jan 2024 13:56:32 -0800
Date: Thu, 25 Jan 2024 13:56:31 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
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
	<johan+linaro@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Dmitry
 Baryshkov" <dmitry.baryshkov@linaro.org>,
        Ulf Hansson
	<ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 0/8] arm64: dts: qcom: sa8295p: Enable GPU
Message-ID: <20240125215631.GM2936378@hu-bjorande-lv.qualcomm.com>
References: <20240125-sa8295p-gpu-v4-0-7011c2a63037@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240125-sa8295p-gpu-v4-0-7011c2a63037@quicinc.com>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3cWWsYCb9dtHrLwtMGqhnrF6IpoQMnGb
X-Proofpoint-ORIG-GUID: 3cWWsYCb9dtHrLwtMGqhnrF6IpoQMnGb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=927 adultscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250158

On Thu, Jan 25, 2024 at 01:05:06PM -0800, Bjorn Andersson wrote:
> Due to the different PMIC configuration found in the SA8295P platform,
> compared to SC8280XP, the VDD_GFX pads are supplied by an dedicated
> MAX20411 LDO.
> 
> Support for expressing the regulator supply is added to the binding, the
> support for enabling the parent supply for GX is added, the missing
> gfx.lvl power-domain is dropped, and the DeviceTree is wired up to
> enable the GPU in this configuration.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Sorry, I forgot to change the subject prefix of the rpmhpd patch, and
pick up Konrad's two r-b.

Regards,
Bjorn

> ---
> Changes in v4:
> - Updated qcom,gpucc.yaml binding check that both power-domains and
>   vdd-gfx-supply isn't used together. Updated related comment as well.
> - Link to v3: https://lore.kernel.org/r/20240123-sa8295p-gpu-v3-0-d5b4474c8f33@quicinc.com
> 
> Changes in v3:
> - Removed one unnecessary empty line in DT node
> - Rebased series to v6.8-rc1
> - Link to v2: https://lore.kernel.org/r/20231220-sa8295p-gpu-v2-0-4763246b72c0@quicinc.com
> 
> Changes in v2:
> - Made gpucc binding accept either power-domain or vdd-gfx-supply
> - Updated comment in gdsc_gx_do_nothing_enable()
> - Added a comment for the /delete-property/ power-domains
> - Fixed node and property sort order in dts
> - Switched zap firmware to use mbn file
> - Link to v1: https://lore.kernel.org/r/20231220-sa8295p-gpu-v1-0-d8cdf2257f97@quicinc.com
> 
> ---
> Bjorn Andersson (8):
>       dt-bindings: clock: qcom: Allow VDD_GFX supply to GX
>       clk: qcom: gdsc: Enable supply reglator in GPU GX handler
>       clk: qcom: gpucc-sc8280xp: Add external supply for GX gdsc
>       soc: qcom: rpmhpd: Drop SA8540P gfx.lvl
>       arm64: dts: qcom: sa8540p: Drop gfx.lvl as power-domain for gpucc
>       arm64: dts: qcom: sa8295p-adp: add max20411
>       arm64: dts: qcom: sa8295p-adp: Enable GPU
>       arm64: defconfig: Enable MAX20411 regulator driver
> 
>  .../devicetree/bindings/clock/qcom,gpucc.yaml      |  9 +++
>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts           | 68 ++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sa8540p.dtsi              |  3 +
>  arch/arm64/configs/defconfig                       |  1 +
>  drivers/clk/qcom/gdsc.c                            | 12 +++-
>  drivers/clk/qcom/gpucc-sc8280xp.c                  |  1 +
>  drivers/pmdomain/qcom/rpmhpd.c                     |  1 -
>  7 files changed, 92 insertions(+), 3 deletions(-)
> ---
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> change-id: 20231220-sa8295p-gpu-51c5f343e3ec
> 
> Best regards,
> -- 
> Bjorn Andersson <quic_bjorande@quicinc.com>
> 

