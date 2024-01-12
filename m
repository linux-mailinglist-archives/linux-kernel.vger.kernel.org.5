Return-Path: <linux-kernel+bounces-24774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACFB82C243
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FA661F2609D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232246E2D0;
	Fri, 12 Jan 2024 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AD0P7pTY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159736DD09;
	Fri, 12 Jan 2024 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40CBvqpO012097;
	Fri, 12 Jan 2024 14:55:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=3UGFsNKGRrS4TKXanKYHSZDlh/L0lTRy0EEXiGIzMFQ=; b=AD
	0P7pTYanvr5fxNK5FqCplMLTaJthJCLkhDnILSDs8LfBxMuS5zrGsMyXEdCXII/o
	LpkNXNrtmwooc3bStHR/z5BgGYdSls1RTieNOtvj+8xA+7iaOYdzVJEaU8CAMF9s
	KMJnZP/4XpN0OlkbWUSBHEwd2yQkM57Bn+TZ7LH0XV46GWvpQEx+bDhHqWMVR3Hc
	VoIx0+TR4+kWbVj0eIuK6scRmJ3P14PjVqe2pKf2KkF1pZi8jMCVO5CebHOcrltY
	4im5mkCtDBQkZoPtdQV9rk3JATChImSzL0hcS/MWH+UAxRiN0iZjFh4a/6rWZRuv
	pSGl3mrogFnhMBWLOvjQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vk1x18wf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 14:55:21 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40CEtK85003254
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 14:55:20 GMT
Received: from [10.253.78.164] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 12 Jan
 2024 06:55:16 -0800
Message-ID: <9c19bfc3-4ecf-4953-8bee-ef46cd613caa@quicinc.com>
Date: Fri, 12 Jan 2024 22:55:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Add PPE device tree node for Qualcomm IPQ SoC
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <quic_kkumarcs@quicinc.com>, <quic_suruchia@quicinc.com>,
        <quic_soni@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_souravp@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>
References: <20240110112059.2498-1-quic_luoj@quicinc.com>
 <0ac211de-e3d4-4a41-b0ed-d2bf393e58cb@linaro.org>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <0ac211de-e3d4-4a41-b0ed-d2bf393e58cb@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rDGUjiaxMtXY6fN0gK_3GE5L_4_7QUsh
X-Proofpoint-GUID: rDGUjiaxMtXY6fN0gK_3GE5L_4_7QUsh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 mlxscore=0 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=773 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401120116



On 1/10/2024 7:32 PM, Konrad Dybcio wrote:
> 
> 
> On 1/10/24 12:20, Luo Jie wrote:
>> The PPE(packet process engine) hardware block is supported by Qualcomm
>> IPQ platforms, such as IPQ9574 and IPQ5332. The PPE includes the various
>> packet processing modules such as the routing and bridging flow engines,
>> L2 switch capability, VLAN and tunnels. Also included are integrated
>> ethernet MAC and PCS(uniphy), which is used to connect with the external
>> PHY devices by PCS.
>>
>> This patch series enables support for the following DTSI functionality
>> for Qualcomm IPQ9574 and IPQ5332 chipsets.
>>
>> 1. Add PPE (Packet Processing Engine) HW support
>>
>> 2. Add IPQ9574 RDP433 board support, where the PPE is connected
>>     with qca8075 PHY and AQ PHY.
>>
>> 3. Add IPQ5332 RDP441 board support, where the PPE is connected
>>     with qca8386 and SFP
>>
>> PPE DTS depends on the NSSCC clock driver below, which provides the
>> clocks for the PPE driver.
>> https://lore.kernel.org/linux-arm-msm/20230825091234.32713-1-quic_devipriy@quicinc.com/
>> https://lore.kernel.org/linux-arm-msm/20231211-ipq5332-nsscc-v3-0-ad13bef9b137@quicinc.com/
> 
> None of these describe (or even use) the compatible in the first
> patch of this series ("qcom,ipq9574-ppe"). I didn't check the
> subsequent ones, as I assume it's the same situtation, so this
> is a NAK.

The DT binding file was included in the PPE driver series, which
documents the compatible string.

https://lore.kernel.org/netdev/20240110142428.52026d9e@kernel.org/

I will hold off this DTSI patch series for now as per discussion in the
series. When the series is resumed later, I will mention the link of PPE 
driver patch series in the cover letter, when updating this DTS patch 
series. Sorry for this confusion caused.



> 
>> Lei Wei (2):
>>    arm64: dts: qcom: ipq5332: Add RDP441 board device tree
>>    arm64: dts: qcom: ipq9574: Add RDP433 board device tree
> 
> These two look unrelated?

These two patches are for adding the PPE port related configuration 
nodes (such as port speed, interface mode and MDIO address) which are 
board specific. RDP441 and RDP433 are two different board types. Perhaps
the title of the patches are not clear enough. I will update the title
to make it clear when the patch series resumes.

> 
>>
>> Luo Jie (4):
>>    arm64: dts: qcom: ipq9574: Add PPE device tree node
>>    arm64: dts: qcom: ipq5332: Add PPE device tree node
>>    arm64: dts: qcom: ipq5332: Add MDIO device tree
>>    arm64: dts: qcom: ipq9574: Add MDIO device tree
> 
> Konrad

