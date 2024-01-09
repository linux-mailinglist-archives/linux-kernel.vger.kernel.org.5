Return-Path: <linux-kernel+bounces-20784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2200E828531
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 482E01C2381B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7659F3716C;
	Tue,  9 Jan 2024 11:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CKhF/9jW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DBC36AFB;
	Tue,  9 Jan 2024 11:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409AtP93015068;
	Tue, 9 Jan 2024 11:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=11kmWaTfq5gVnjxWEk+ZiTDAdTKMMZdYDV2oLH+AlMw=; b=CK
	hF/9jWshy1a39c4j9jKDxMtnqvSrAfRqL95YAUMt3gncha0emYC5meAGyTZ31vIf
	7V49aqGJAWF3bG/xdI9gJggz5LKaLKNjo0M+jwlnrn78vRL7gsCaZ0BsFUnABLqT
	YvDlTZX5BsCIFflxRtpmaHn2Eib1uWxDt3I0bzEOZa8QuBUVromUCyp+2dyQdjAR
	H1vhoGJ2Ct2bc4JXAgEYi88JkuzLahtcuTIT9C9GelrhZTOskfCvgA99jYcNt85e
	PPpd9w3QxLMm1BdQm7ZcdssltiVZYdc8m2ZXw5VJzozVNOrm4/hIsFJ20UW/E7r6
	bSo7d3HGB2WhfhRxY4IA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgwsjrve0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 11:35:41 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409BZdJT022045
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 11:35:39 GMT
Received: from [10.253.15.239] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 9 Jan
 2024 03:35:34 -0800
Message-ID: <eedcf2b7-66e9-45be-8ef2-ae6f875bdb5f@quicinc.com>
Date: Tue, 9 Jan 2024 19:35:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] support ipq5332 platform
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn
	<andrew@lunn.ch>
CC: Sergey Ryazanov <ryazanov.s.a@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <robert.marko@sartura.hr>,
        <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20231225084424.30986-1-quic_luoj@quicinc.com>
 <a6a50fb6-871f-424c-a146-12b2628b8b64@gmail.com>
 <cfb04c82-3cc3-49f6-9a8a-1f6d1a22df40@quicinc.com>
 <dd05a599-247a-4516-8ad3-7550ceea99f7@gmail.com>
 <ac1977f5-cd6a-4f16-b0a0-f4322c34c5f5@quicinc.com>
 <bdeca791-f2e5-4256-b386-a75c03f93686@gmail.com>
 <895eadd7-1631-4b6b-8db4-d371f2e52611@lunn.ch>
 <ZZwabT7pmwDof8Cs@shell.armlinux.org.uk>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <ZZwabT7pmwDof8Cs@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NCq1_Gj-E3WFQMevO2Q0k7iay_tjAj4U
X-Proofpoint-ORIG-GUID: NCq1_Gj-E3WFQMevO2Q0k7iay_tjAj4U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 adultscore=0
 spamscore=0 impostorscore=0 mlxscore=0 bulkscore=0 mlxlogscore=686
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090092



On 1/8/2024 11:53 PM, Russell King (Oracle) wrote:
> On Sat, Jan 06, 2024 at 04:45:08PM +0100, Andrew Lunn wrote:
>>> I just realized that the UNIPHY block is a MII (probably SGMII) controller.
>>> Isn't it? And I expect that it responsible more then just for clock
>>> enabling. It should also activate and perform a basic configuration of MII
>>> for actual data transmission. If so, then it should placed somewhere under
>>> drivers/net/phy or drivers/net/pcs.
>>
>> Before we decide that, we need a description of what the UNIPHY
>> actually does, what registers it has, etc. Sometimes blocks like this
>> get split into a generic PHY, aka drivers/phy/ and a PCS driver. This
>> would be true if the UNIPHY is also used for USB SERDES, SATA SERDES
>> etc. The SERDES parts go into a generic PHY driver, and the SGMII on
>> to of the SERDES is placed is a PCS driver.
>>
>> The problem i have so far is that there is no usable description of
>> any of this hardware, and the developers trying to produce drivers for
>> this hardware don't actually seem to understand the Linux architecture
>> for things like this.
> 
> +1. I think it's now more convoluted than ever, and someone needs to
> take a step back, look at the hardware, look at the kernel model, and
> work out how to implement this. It needs to be explained in a clear
> and concise way in _one_ go, not spread over multiple emails. Probably
> with ASCII art diagrams showing the structure.
> 
> If that isn't possible, then someone needs to provide a detailed
> description of the hardware so that the subsystem maintainers get a
> proper view of what this hardware is so they can advise. This is the
> least preferable option due to the maintainer time it takes.
> 
> If neither of these two things happen, then I'm afraid all bets are
> off for getting this into the kernel.
> 

Thanks Russell for suggestions.
I will provide the diagram of the hardware and the description in the
cover letter of new patch set, i know it is really important to for the
review smoothly.

Christian's work is designing the PHY package level DT, which is very
suitable for the complex clock configs of qca8084 PHY, i also provides
some descriptions of the qca8084 PHY, it will be very welcome to
review the clock DT model of qca8084 PHY.

