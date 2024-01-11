Return-Path: <linux-kernel+bounces-23823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB6A82B24C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB9DA1C24D26
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBBF5024B;
	Thu, 11 Jan 2024 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BlBuTy2e"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD014F8B8;
	Thu, 11 Jan 2024 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40BDLenj026594;
	Thu, 11 Jan 2024 16:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=VxOOXNmA3OWQD0kcoMVx3KNZoGxMlXt1SUYjRUxttZQ=; b=Bl
	BuTy2eMy+obzMsIsAhxFXMUg0N/VjELBLtKuzhl2o06jOnDuD5W1EEaolYRfx1a+
	AWXxFNMNJ7Dhucd2JEfc9oVj1Cd1eENtmt6onbxRHQ1fgs6l2jSK25rH34F4uamZ
	9tR3W4HHblkuteABRarSnq9IVPCJ6TSXYjx/APcEM0KWHjczUwr5HkBDnO674R4T
	n2zRQ7caJAfbp3byFbIU7pFLJqeiRzClSzi9YsdnFpLyyar2oDvjFiL65+hXLDh0
	W1CFpUx5pK/aWT8HQskBpad9e3ZoDJaVUS70DFLVplKvF9EjNtfIOznrzCdEDkvO
	InrUH6wyoE/tEQWYv6Qw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vjcvjs03u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 16:00:06 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40BG059C027386
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 16:00:05 GMT
Received: from [10.253.37.156] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 11 Jan
 2024 08:00:01 -0800
Message-ID: <e893c298-fbfa-4ae4-9b76-72a5030a5530@quicinc.com>
Date: Thu, 11 Jan 2024 23:59:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] arm64: dts: qcom: ipq5332: Add MDIO device tree
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <quic_kkumarcs@quicinc.com>, <quic_suruchia@quicinc.com>,
        <quic_soni@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_souravp@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>
References: <20240110112059.2498-1-quic_luoj@quicinc.com>
 <20240110112059.2498-4-quic_luoj@quicinc.com>
 <4bc0aff5-8a1c-44a6-89d8-460961a61310@lunn.ch>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <4bc0aff5-8a1c-44a6-89d8-460961a61310@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bGftCSlIlTaROutu9qN3mpoKbeCsOweN
X-Proofpoint-ORIG-GUID: bGftCSlIlTaROutu9qN3mpoKbeCsOweN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=667 spamscore=0
 adultscore=0 mlxscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401110125



On 1/10/2024 9:35 PM, Andrew Lunn wrote:
> On Wed, Jan 10, 2024 at 07:20:56PM +0800, Luo Jie wrote:
>> Add the MDIO device tree of ipq5332.
>>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq5332.dtsi | 44 +++++++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> index bc89480820cb..e6c780e69d6e 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> @@ -214,6 +214,38 @@ serial_0_pins: serial0-state {
>>   				drive-strength = <8>;
>>   				bias-pull-up;
>>   			};
>> +
>> +			mdio0_pins: mdio0-state {
>> +				mux_0 {
>> +					pins = "gpio25";
>> +					function = "mdc0";
>> +					drive-strength = <8>;
>> +					bias-disable;
>> +				};
>> +
>> +				mux_1 {
>> +					pins = "gpio26";
>> +					function = "mdio0";
>> +					drive-strength = <8>;
>> +					bias-pull-up;
>> +				};
>> +			};
>> +
>> +			mdio1_pins: mdio1-state {
>> +				mux_0 {
>> +					pins = "gpio27";
>> +					function = "mdc1";
>> +					drive-strength = <8>;
>> +					bias-disable;
>> +				};
>> +
>> +				mux_1 {
>> +					pins = "gpio28";
>> +					function = "mdio1";
>> +					drive-strength = <8>;
>> +					bias-pull-up;
>> +				};
> 
> I don't know why i'm asking this, because i don't really expect a
> usable answer. What sort of MUX is this? Should you be using one of
> the muxes in drivers/net/mdio/mdio-mux-* or something similar?
> 
>      Andrew

Sorry for the confusion, the pin nodes are for the MDIO and MDC, these
PINs are used by the dedicated hardware MDIO block in the SoC. I will 
update the node name from mux_0 to MDC, mux_1 to MDIO, to make it clear. 
The driver for this node is drivers/net/mdio/mdio-ipq4019.c, it is not 
related to the mdio-mux-* code.

