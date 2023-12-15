Return-Path: <linux-kernel+bounces-481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F9D8141CF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC80528568B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934D0D281;
	Fri, 15 Dec 2023 06:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Tdbx2iqr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62249846C;
	Fri, 15 Dec 2023 06:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BF3lJrM016521;
	Fri, 15 Dec 2023 06:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=4dgoJSL6fpykBgSPTc+vnHIGdRnJHEe3ikKjD/45brs=; b=Td
	bx2iqr3yVwMYLRyNhV49MnRHEU7H8fyTv0Ot4pf14Y1ESOMCSxgvK80zkXYg/es4
	pG2Rwh4V5vm/xLNmwEPsJkgSHt2UJ92Ff/ggrZmrF4d6UFMkj3D227P0eEpntMAR
	HLox28coARkRUEe0L/VPDhB0WE4ttd8yJuyYXThWaG1nsh75h/yMmOSxq1mjUiY9
	D3SwwNoo9LL10jCtmksax6Ja8r5oVmBuAB4+mS1v1qmrYnJlHqJi/ZRhVHvJmll3
	Dfexa4WhQ2/Z76ihIVGQmP3epVw9KwDkkgHmVxSVCIdHwnZI8D2LZZ72tFeb6lGv
	Ig+87xM1zosMrBqoCSKw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0a37h592-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 06:30:15 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BF6UDCI015491
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 06:30:13 GMT
Received: from [10.253.13.71] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Dec
 2023 22:30:02 -0800
Message-ID: <c2a8c9e5-b9f0-41ec-b9a7-90f28b17a09c@quicinc.com>
Date: Fri, 15 Dec 2023 14:29:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/14] net: phy: at803x: add QCA8084 ethernet phy
 support
To: Andrew Lunn <andrew@lunn.ch>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>,
        <p.zabel@pengutronix.de>, <f.fainelli@gmail.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
References: <20231214094813.24690-1-quic_luoj@quicinc.com>
 <20231214094813.24690-4-quic_luoj@quicinc.com>
 <c05e4756-0b33-4c97-ba88-1e14f459bbe3@lunn.ch>
Content-Language: en-US
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <c05e4756-0b33-4c97-ba88-1e14f459bbe3@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: T7nOZWFxGJjt3Xo-tT9FfbcX0DJIm-Et
X-Proofpoint-ORIG-GUID: T7nOZWFxGJjt3Xo-tT9FfbcX0DJIm-Et
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312150037



On 12/14/2023 7:01 PM, Andrew Lunn wrote:
> On Thu, Dec 14, 2023 at 05:48:02PM +0800, Luo Jie wrote:
>> Add qca8084 PHY support, which is four-port PHY with maximum
>> link capability 2.5G, the features of each port is almost same
>> as QCA8081 and slave seed config is not needed.
>>
>> Three kind of interface modes supported by qca8084.
>> PHY_INTERFACE_MODE_10G_QXGMII, PHY_INTERFACE_MODE_2500BASEX and
>> PHY_INTERFACE_MODE_SGMII.
>>
>> The PCS(serdes) and clock are also needed to be configured to
>> bringup qca8084 PHY, which will be added in the pcs driver.
>>
>> The additional CDT configurations used for qca8084.
>>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---
>>   drivers/net/phy/at803x.c | 49 ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 49 insertions(+)
>>
>> diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
>> index 37fb033e1c29..8dfdf2ff56a5 100644
>> --- a/drivers/net/phy/at803x.c
>> +++ b/drivers/net/phy/at803x.c
>> @@ -176,6 +176,7 @@
>>   #define AT8030_PHY_ID_MASK			0xffffffef
>>   
>>   #define QCA8081_PHY_ID				0x004dd101
>> +#define QCA8084_PHY_ID				0x004dd180
>>   
>>   #define QCA8327_A_PHY_ID			0x004dd033
>>   #define QCA8327_B_PHY_ID			0x004dd034
>> @@ -1760,6 +1761,9 @@ static bool qca808x_is_prefer_master(struct phy_device *phydev)
>>   
>>   static bool qca808x_has_fast_retrain_or_slave_seed(struct phy_device *phydev)
>>   {
>> +	if (phydev_id_compare(phydev, QCA8084_PHY_ID))
>> +		return false;
>> +
>>   	return linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported);
>>   }
> 
> 
> It looks like these patches need rebasing on net-next/main. It appears
> you are missing Christians patches.
> 
> 
>      Andrew
> 
> ---
> pw-bot: cr

Oh, Yes, i will update the patch set based on the latest code, thanks.


