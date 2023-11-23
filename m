Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCEC7F5658
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 03:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjKWCQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 21:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbjKWCQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 21:16:50 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34EA191;
        Wed, 22 Nov 2023 18:16:56 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AN23qkK031644;
        Thu, 23 Nov 2023 02:16:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=ZIFtMVk2/zT7KrXEsO8zDd8+y32VJ41gKUIrX4m+Jb0=;
 b=h9q32c2NgYD9HpC2rx5uwDmFtdfnJAeX9L0gzqghM50KgRDwd5Nny1xwEOxTiMMhZvm3
 q6+ustyhVhV/dESzkq1P42t+ZQW3g8tApzXVJsd84WX7rt6yZ2yKdu1wKdPbpLNkwELp
 CLowU3apuF/K4Y4RLeVIQAt0h99nhln+oAnOk36Rx6hGoMJLDki4ujQyjf/9mfqAqdII
 LSfW79sb6fm6Vs/SjYn2FOTKUXb2sAymQ4A+e3zBKVKl1srmYtwvxMR8YCbfR3H4mbPF
 etBXpoJoM+WGCYvM6Ntnh8V7tRczcVdD7GaiJX/eRtwTMr0NN7NrvgLzm35NAZAbPKGS PA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uhwme80g3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 02:16:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AN2GnEY027100
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 02:16:49 GMT
Received: from hu-jackp-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 22 Nov 2023 18:16:48 -0800
Date:   Wed, 22 Nov 2023 18:16:44 -0800
From:   Jack Pham <quic_jackp@quicinc.com>
To:     Johan Hovold <johan+linaro@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Jonathan Marek <jonathan@marek.ca>
Subject: Re: [PATCH 10/11] arm64: dts: qcom: sm8150: fix USB wakeup interrupt
 types
Message-ID: <20231123021612.GA4127689@hu-jackp-lv.qualcomm.com>
References: <20231120164331.8116-1-johan+linaro@kernel.org>
 <20231120164331.8116-11-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231120164331.8116-11-johan+linaro@kernel.org>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: t_Q_Fe3Ve5dJPlXs3Ig-1P1FnU14DetM
X-Proofpoint-ORIG-GUID: t_Q_Fe3Ve5dJPlXs3Ig-1P1FnU14DetM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_18,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 suspectscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 mlxlogscore=224 lowpriorityscore=0
 impostorscore=0 mlxscore=1 adultscore=0 bulkscore=0 spamscore=1
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311230015
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 05:43:30PM +0100, Johan Hovold wrote:
> The DP/DM wakeup interrupts are edge triggered and which edge to trigger
> on depends on use-case and whether a Low speed or Full/High speed device
> is connected.
> 
> Fixes: 0c9dde0d2015 ("arm64: dts: qcom: sm8150: Add secondary USB and PHY nodes")
> Fixes: b33d2868e8d3 ("arm64: dts: qcom: sm8150: Add USB and PHY device nodes")
> Cc: stable@vger.kernel.org      # 5.10
> Cc: Jonathan Marek <jonathan@marek.ca>
> Cc: Jack Pham <quic_jackp@quicinc.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Reviewed-by: Jack Pham <quic_jackp@quicinc.com>

>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 97623af13464..3e7048d8ac55 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -3567,8 +3567,8 @@ usb_1: usb@a6f8800 {
>  
>  			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 488 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 489 IRQ_TYPE_LEVEL_HIGH>;
> +				     <GIC_SPI 488 IRQ_TYPE_EDGE_BOTH>,
> +				     <GIC_SPI 489 IRQ_TYPE_EDGE_BOTH>;
>  			interrupt-names = "hs_phy_irq", "ss_phy_irq",
>  					  "dm_hs_phy_irq", "dp_hs_phy_irq";
>  
> @@ -3620,8 +3620,8 @@ usb_2: usb@a8f8800 {
>  
>  			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 487 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 490 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 491 IRQ_TYPE_LEVEL_HIGH>;
> +				     <GIC_SPI 490 IRQ_TYPE_EDGE_BOTH>,
> +				     <GIC_SPI 491 IRQ_TYPE_EDGE_BOTH>;
>  			interrupt-names = "hs_phy_irq", "ss_phy_irq",
>  					  "dm_hs_phy_irq", "dp_hs_phy_irq";
