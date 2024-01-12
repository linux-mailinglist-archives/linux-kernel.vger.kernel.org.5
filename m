Return-Path: <linux-kernel+bounces-24840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAD882C34A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0110A1F25487
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B7673188;
	Fri, 12 Jan 2024 16:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZbuHgO/1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DAC6EB7F;
	Fri, 12 Jan 2024 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40CEu3Vf000923;
	Fri, 12 Jan 2024 16:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=M1x83cN8XOE+7DNlVKFKPABwCb6JtMLdTeKXKDUhjVc=; b=Zb
	uHgO/1JODIsqKSelHLRXkp1YW/jiyKLpn56yA9JN68pcIUoZrJuoJMCXIornqc+t
	LPnHqyKb5ZTGBydw3R1bjf/8Tu/aQQ4srP8pcUK+c33tHw34i6GXohLE1JIJzjOA
	gqGrxh5xY8LM2rimDWzvNyekWywcecsNXygffnozrOGOVH1pyTFoUsKXwCrWOGWi
	8Cm/uJ/ehygHR9jkFerNFL2eVdlM5ekYgCkzi45856r8d4Gmw6o1FIqv0UvRej2J
	qi/xd1qLipJH1f+kEz/5bykkIpjID78YO8U5T8bBZRHVyeCIqHRyu6Y8WGj6i7lT
	pkbcrMHPMzVt1bRmZgpQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vk1x192g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 16:06:00 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40CG60JP008657
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 16:06:00 GMT
Received: from [10.253.78.164] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 12 Jan
 2024 08:05:56 -0800
Message-ID: <5c88945b-4a80-4346-a77c-82a68ae02047@quicinc.com>
Date: Sat, 13 Jan 2024 00:05:53 +0800
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
 <e893c298-fbfa-4ae4-9b76-72a5030a5530@quicinc.com>
 <61973012-3f74-4b58-9575-3bc5199f61d9@lunn.ch>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <61973012-3f74-4b58-9575-3bc5199f61d9@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1TX3T7RW1OYossRy0DccJUdBsQ6fuvg6
X-Proofpoint-GUID: 1TX3T7RW1OYossRy0DccJUdBsQ6fuvg6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 mlxscore=0 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=442 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401120125



On 1/12/2024 12:30 AM, Andrew Lunn wrote:
>> Sorry for the confusion, the pin nodes are for the MDIO and MDC, these
>> PINs are used by the dedicated hardware MDIO block in the SoC. I will update
>> the node name from mux_0 to MDC, mux_1 to MDIO, to make it clear. The driver
>> for this node is drivers/net/mdio/mdio-ipq4019.c, it is not related to the
>> mdio-mux-* code.
> 
> So these is all about pinmux.

Yes, it is about pinmux.

> 
> When you say:
>> PINs are used by the dedicated hardware MDIO block in the SoC
> 
> do you actually mean:
> 
> PINs are used by the two dedicated hardware MDIO blocks in the SoC.
> 
> You have two sets of mdio/mdc configurations here, so i assume there
> are two MDIO hardware blocks, each being an MDIO bus master.
> 
>      Andrew

There are two MDIO hardware blocks on IPQ5332 SoC. One is
for the MDIO bus master(gpio27, 28), which is for accessing the MDIO
slave devices(like PHY device). The mdio-ipq4019.c driver enables
this MDIO bus master.

Another one is the MDIO slave(gpio25, 26), which is dedicated
for receiving the back pressure signal from the connected Ethernet 
switch device QCA8386.

There is a MDIO master block integrated in QCA8386 switch device, this
integrated MDIO master is dedicated for generating the back
pressure signal to IPQ5332 SoC.

This MDIO slave block of IPQ5322 just needs to configure these PIN
mux for MDC and MDIO PINs. No additional driver is needed for this MDIO
slave block of IPQ5332.

