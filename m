Return-Path: <linux-kernel+bounces-21015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DE5828886
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25A8C1C24667
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EEA39AED;
	Tue,  9 Jan 2024 14:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TM0gbXfk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783ED36AFB;
	Tue,  9 Jan 2024 14:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409ENnvR002340;
	Tue, 9 Jan 2024 14:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=RbGkMtmcIUmZkCSQgfI1agSfOQGEQ2UE0CzkFakTXzc=; b=TM
	0gbXfkPZkdtMwWSkuL7CMDHMvE6r8eXQL582MHFNCyYjZj8jhPmAM9bdUblXV9ya
	pu8QHF/s7Pua8211juDTZ02eHiZTJB9e/veU9grgcg+6u1EQFJLE5HGqRmq7OJWh
	anyZIUjjn80CiA+NfMDIgJSU94wHt2cBlFproeQT8asBFdBtQnE8wQkmF7IP1PEf
	EM/llUr0M03qHFjLuUyum8oBKwurNaA+0pDZep2Rhja/lwR0C4aHlYxR53lcySkT
	DbDGZHhj+ZzB190yUnUoWDLrCjQNLfzuAx9sEwno42aTClxufI2nu1iPQhkaJED0
	7D0klDfHzgze8VeRsDsw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh234gs7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 14:52:54 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409EqrOm027611
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 14:52:53 GMT
Received: from [10.216.4.210] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 9 Jan
 2024 06:52:44 -0800
Message-ID: <6f97e753-435e-4b86-bd47-290097f6a3f0@quicinc.com>
Date: Tue, 9 Jan 2024 20:22:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: stmmac: dwmac-qcom-ethqos: Add support for 2.5G
 SGMII
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: Vinod Koul <vkoul@kernel.org>, Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu
	<joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>
References: <20240108121128.30071-1-quic_snehshah@quicinc.com>
 <4216bcbb-730d-4c51-a9ce-d3f0a0846e31@lunn.ch>
From: Sneh Shah <quic_snehshah@quicinc.com>
In-Reply-To: <4216bcbb-730d-4c51-a9ce-d3f0a0846e31@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DBji45IuvE3EsiejT6zlKGf0MYzIiDJt
X-Proofpoint-GUID: DBji45IuvE3EsiejT6zlKGf0MYzIiDJt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=638 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401090122



On 1/9/2024 1:00 AM, Andrew Lunn wrote:
> On Mon, Jan 08, 2024 at 05:41:28PM +0530, Sneh Shah wrote:
>> Serdes phy needs to operate at 2500 mode for 2.5G speed and 1000
>> mode for 1G/100M/10M speed.
>> Added changes to configure serdes phy and mac based on link speed.
> 
> Please take a look at:
> 
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
> 
> The Subject is missing which tree this is for. Also, net-next is
> closed at the moment.

It was supposed to be net-next. Missed updating in subject.
Sorry for that!
If net-next is closed at the moment, how to proceed further?
Should I wait until it gets reopened?
> 
>>  	switch (ethqos->speed) {
>> +	case SPEED_2500:
>> +		val &= ~ETHQOS_MAC_CTRL_PORT_SEL;
>> +		rgmii_updatel(ethqos, RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
>> +			      RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
>> +			      RGMII_IO_MACRO_CONFIG2);
>> +		if (ethqos->serdes_speed != SPEED_2500)
>> +			phy_set_speed(ethqos->serdes_phy, SPEED_2500);
> 
> Is calling phy_set_speed() expensive? Why not just unconditionally
> call it?
> 
It reconfigures whole serdes phy block, with lots of register read/writes.
So I feel it is better to avoid doing this unconditionally
>      Andrew

