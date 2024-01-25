Return-Path: <linux-kernel+bounces-37988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F1A83B951
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE59B28183A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4881710A13;
	Thu, 25 Jan 2024 05:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OJypJfPk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA0010A09;
	Thu, 25 Jan 2024 05:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706162274; cv=none; b=irv6rUmlOw+AkndPDJn6t4c/xwOlLQkBelQ0w//xA3dSLsr7UxLmzuzdPeIlhQE5APKGJ9L/6ksQSnxn/4N/3OVTyw8asVUG/0xxLnp9guBagrpBBS2AEvBszj2/y35zKXigdkR07QzfRbdG/INEgMo9RmOGTv/0Nt3itdJsqRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706162274; c=relaxed/simple;
	bh=6rpUqc4mjiy4kKVxPx+aduOZN23mYLXAOQ+9TJPnLo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y0f9yQkbC011ZrfeqW6Z0oRfaowVS19a5xJNx1NK4sfftG4M4ho07IaQRRnr1R28EFZpSKyJpSkBT4w2fIhqCxg2b7mB/4J86LYAu1xkpzHPU52HwXLvhrZ0993BSNUzbIR5wZ54u9ibGlu1rqfziKHJfdqtFlaPwhooFCUzTCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OJypJfPk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P5AVuw006910;
	Thu, 25 Jan 2024 05:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Pqc+xX/TZT2wrUmJY75RyztBsHJ5cRSWochi3dAiI6Q=; b=OJ
	ypJfPkuraL7mN4S9YM3LKOIddvBQ0HwZmIKJM+LjWed0H3bYjG83RZVQ87kUMeNp
	wE3/BwcGd3e4cUatTQYkaOa5e1hE5ZUL1IVM/825YQmMc3fkIQwKTuNwJ75sV/4S
	ikbjK1YPNEoVsCKHY7O0y5YIdQZVCxT9//RpRGMwMQIFMi0qCN7SElZUv+A3qnwp
	3mvy51uq0e6DTtufhr/A2nbYJeQfEJ6dbR8QyAH3rSq11A+8pb3PedBvCYEAQ1vK
	/nh8YlBJtR4pt92zbTO14FtyZe9/zy11cHBGL8NMyfXGZfYOZX/KAYYAbNJmTdK0
	+K67O9jDlQGw+zxL9O1g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vu4999w5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 05:57:29 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40P5vSsn013717
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 05:57:28 GMT
Received: from [10.253.33.199] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 21:57:23 -0800
Message-ID: <53445feb-a02c-4859-a993-ccf957208115@quicinc.com>
Date: Thu, 25 Jan 2024 13:57:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH 0/3] net: mdio-ipq4019: fix wrong default MDC
 rate
Content-Language: en-US
To: Christian Marangi <ansuelsmth@gmail.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell
 King <linux@armlinux.org.uk>,
        Robert Marko <robert.marko@sartura.hr>,
        <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sergey Ryazanov
	<ryazanov.s.a@gmail.com>
References: <20240124213640.7582-1-ansuelsmth@gmail.com>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <20240124213640.7582-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EyM9ju-pxiA_mNCxhWscwcDkFPx6OcGf
X-Proofpoint-GUID: EyM9ju-pxiA_mNCxhWscwcDkFPx6OcGf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_02,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=698 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250038



On 1/25/2024 5:36 AM, Christian Marangi wrote:
> This was a long journey to arrive and discover this problem.
> 
> To not waste too much char, there is a race problem with PHY and driver
> probe. This was observed with Aquantia PHY firmware loading.
> 
> With some hacks the race problem was workarounded but an interesting
> thing was notice. It took more than a minute for the firmware to load
> via MDIO.
> 
> This was strange as the same operation was done by UBoot in at max 5
> second and the same data was loaded.
> 
> A similar problem was observed on a mtk board that also had an
> Aquantia PHY where the load was very slow. It was notice that the cause
> was the MDIO bus running at a very low speed and the firmware
> was missing a property (present in mtk sdk) that set the right frequency
> to the MDIO bus.
> 
> It was fun to find that THE VERY SAME PROBLEM is present on IPQ in a
> different form. The MDIO apply internally a division to the feed clock
> resulting in the bus running at 390KHz instead of 6.25Mhz.
> 
> Searching around the web for some documentation and some include and
> analyzing the uboot codeflow resulted in the divider being set wrongly
> at /256 instead of /16 as the value was actually never set.
> Applying the value restore the original load time for the Aquantia PHY.
> 
> This series mainly handle this by adding support for the "clock-frequency"
> property.
> 
> Christian Marangi (3):
>    dt-bindings: net: ipq4019-mdio: document now supported clock-frequency
>    net: mdio: ipq4019: add support for clock-frequency property
>    arm64: dts: qcom: ipq8074: add clock-frequency to MDIO node
> 
>   .../bindings/net/qcom,ipq4019-mdio.yaml       | 10 +++
>   arch/arm64/boot/dts/qcom/ipq8074.dtsi         |  2 +
>   drivers/net/mdio/mdio-ipq4019.c               | 68 +++++++++++++++++--
>   3 files changed, 75 insertions(+), 5 deletions(-)
> 

Hi Christian,
Just a gentle reminder.

The MDIO frequency config is already added by the following patch series.
https://lore.kernel.org/netdev/28c8b31c-8dcb-4a19-9084-22c77a74b9a1@linaro.org/T/#m840cb8d269dca133c3ad3da3d112c63382ec2058

This MDIO patch series will be updated to just keep the MDIO frequency
patch and DT document for this MDIO frequency property added.

For CMN PLL config will be moved to the CMN PLL clock driver and the 
UNIPHY clock config will be moved the uniphy driver as suggested by
Sergey's suggestions.

Thanks.



