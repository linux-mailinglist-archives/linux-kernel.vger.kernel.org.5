Return-Path: <linux-kernel+bounces-29139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE85830966
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25F0DB25180
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732DD21A19;
	Wed, 17 Jan 2024 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OjGZ50xr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FB4241E1;
	Wed, 17 Jan 2024 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705504370; cv=none; b=Qg5uSAyHYutAKZqjiyzJod6Xebgm6ax5WvbUQrwTWsbSdxVFZV23fIbhporH1/RzYt+Tb8dVgnPWmW1k0wY90+lDjmw7sKUztI5SkIsJOLI2uxo+CllKpV/mYXM0PtOteYx5vfIPmmk9WVj5Owhm2f4OHQZSuVcDKufVaNg7Y04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705504370; c=relaxed/simple;
	bh=dZbhxNc+daniXhZZf+t3TJzeHiXnNRJRWkFbbqG2bSw=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=gp/zJTqUB++sZ+8+tmjWv1Ufv7TgW/ToKOYTyC2W99q3NWeCZHanmM927DVZBKnEzDhGZfVYIvtzb2+ktn53MoLXJ0NLNlVQTadARJCV5buLAN55S/D59avcyWN9SZh2KqdRYi+GniHF4zXYG7dijgxAXHC+P7++Ye2HOdujruU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OjGZ50xr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40HBiDqo010828;
	Wed, 17 Jan 2024 15:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=WfqDlO65ezyg65hyX4ylgHvZOhj/nO8njM69ZUbpPNU=; b=Oj
	GZ50xru9UngP+s+07H2jGtm+Z89reJ2LL21vB09rkidBqFJsiJTsEAH8z47ZgTMD
	+qyJV8rXuX/xrP9c3J1DmQjX9ECcH9dm4q0GyDBmMT7hvsYLPFSt2R4OE8G5a/rE
	dMXukuyAIsoIdBSo7qURmO4+483WnA34aSTGf8Yrt37aD41DqePOKc+VnvpR1YBB
	t8f45vz300UDGNcRa2VGjiLmEs2BvGkkDeXdEp27y1HJOA9WCbqfwroBObVR2oMV
	CTD7dZqnHR0EaCkaiabzHpGVH+8NRPNWk2ETQAiETcTE9c39mj4rN8VbOpDNsAJL
	RNoeDgy3Hz1hhXQ61u5w==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vp6sqsca8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 15:12:46 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40HFCjm7013305
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 15:12:45 GMT
Received: from [10.253.12.80] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 17 Jan
 2024 07:12:41 -0800
Message-ID: <62428d47-20eb-4d02-886d-355d704de938@quicinc.com>
Date: Wed, 17 Jan 2024 23:12:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] arm64: dts: qcom: ipq9574: Add RDP433 board device
 tree
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Luo Jie
	<quic_luoj@quicinc.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <quic_kkumarcs@quicinc.com>, <quic_suruchia@quicinc.com>,
        <quic_soni@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_souravp@quicinc.com>, <quic_linchen@quicinc.com>
References: <20240110112059.2498-1-quic_luoj@quicinc.com>
 <20240110112059.2498-7-quic_luoj@quicinc.com>
 <FC335E96-9DE2-4BC8-BE45-8DE77AB453AE@linaro.org>
From: Lei Wei <quic_leiwei@quicinc.com>
In-Reply-To: <FC335E96-9DE2-4BC8-BE45-8DE77AB453AE@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YPG6-Bzkpv1Pl2PyO3N_Y2tYcFRvCB_m
X-Proofpoint-ORIG-GUID: YPG6-Bzkpv1Pl2PyO3N_Y2tYcFRvCB_m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 spamscore=0 clxscore=1011 impostorscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=967 malwarescore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170110



On 1/12/2024 11:05 PM, Dmitry Baryshkov wrote:
> On 10 January 2024 13:20:59 EET, Luo Jie <quic_luoj@quicinc.com> wrote:
>> From: Lei Wei <quic_leiwei@quicinc.com>
>>
>> RDP433 board has four QCA8075 PHYs and two Aquantia 10G PHY onboard.
>>
>> Signed-off-by: Lei Wei <quic_leiwei@quicinc.com>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---
>> arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 66 +++++++++++++++++++++
>> 1 file changed, 66 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>> index 1bb8d96c9a82..298c0853b4d2 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>> @@ -60,3 +60,69 @@ rclk-pins {
>> 		};
>> 	};
>> };
>> +
>> +&qcom_ppe {
>> +	qcom,port_phyinfo {
>> +		ppe_port0: port@0 {
>> +			port_id = <1>;
>> +			phy-mode = "qsgmii";
>> +			phy-handle = <&phy0>;
>> +		};
>> +		ppe_port1: port@1 {
>> +			port_id = <2>;
>> +			phy-mode = "qsgmii";
>> +			phy-handle = <&phy1>;
>> +		};
>> +		ppe_port2: port@2 {
>> +			port_id = <3>;
>> +			phy-mode = "qsgmii";
>> +			phy-handle = <&phy2>;
>> +		};
>> +		ppe_port3: port@3 {
>> +			port_id = <4>;
>> +			phy-mode = "qsgmii";
>> +			phy-handle = <&phy3>;
>> +		};
>> +		ppe_port4: port@4 {
>> +			port_id = <5>;
>> +			phy-mode = "usxgmii";
>> +			phy-handle = <&phy4>;
>> +		};
>> +		ppe_port5: port@5 {
>> +			port_id = <6>;
>> +			phy-mode = "usxgmii";
>> +			phy-handle = <&phy5>;
>> +		};
>> +	};
>> +};
>> +
>> +&mdio {
>> +	reset-gpios = <&tlmm 60 GPIO_ACTIVE_LOW>;
>> +	status = "okay";
>> +
>> +	phy0: ethernet-phy@0 {
>> +		      reg = <16>;
>> +	      };
> 
> This part looks extremely wrong to me. If the reg is 16, then it should be @16 as well. You should have got a warning here.
> 
Sure, I will fix and update it. Thanks.

>> +
>> +	phy1: ethernet-phy@1 {
>> +		      reg = <17>;
>> +	      };
>> +
>> +	phy2: ethernet-phy@2 {
>> +		      reg = <18>;
>> +	      };
>> +
>> +	phy3: ethernet-phy@3 {
>> +		      reg = <19>;
>> +	      };
>> +
>> +	phy4: ethernet-phy@4 {
>> +		      compatible ="ethernet-phy-ieee802.3-c45";
>> +		      reg = <8>;
>> +	      };
>> +
>> +	phy5: ethernet-phy@5 {
>> +		      compatible ="ethernet-phy-ieee802.3-c45";
>> +		      reg = <0>;
>> +	      };
>> +};
> 

