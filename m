Return-Path: <linux-kernel+bounces-2972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB570816566
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 04:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0529E1C22110
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 03:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161335397;
	Mon, 18 Dec 2023 03:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Kuj3DL5X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19371440A;
	Mon, 18 Dec 2023 03:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BI2pK4A010523;
	Mon, 18 Dec 2023 03:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=8QxqtTgZPkn+11BMXB8gGJCnSChYrUFsq+roZCMEQVg=; b=Ku
	j3DL5XTdR4AarRSjvkOLKq0UI6ViSB/srmdUSYD9O2ulTJ8a39a0wr/PhxJy7i1/
	pBBElLn+zRuThLuZ7TDmrpPfC9Z7ctGt5+QyjuwDiY+5YzNyqerZomvcNxpsaN4Q
	n5okXOJ4ypvdJEgP+FJfhoYzFxEOx8VCfCH441IfkP21axISwM8NeIB0PM6dT1WT
	C/37pyrPKeMpOwczUG99x6Kxg0Lwwha6J4HXKAcqmPFDE/iPCEUAWrX8qzuXJCsk
	m4IugFm+J+5TaDgzVQntCWzFWPXbLgTG8MtD8+5/45VtCmvf0mt6nTZ3+nooAXMx
	h6/HezHavRkltR+D+Ecg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v1536u7ad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 03:33:18 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BI3XHeb005017
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 03:33:17 GMT
Received: from [10.253.9.247] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 17 Dec
 2023 19:33:13 -0800
Message-ID: <a604a08e-def6-427f-b33c-1e62e693bd96@quicinc.com>
Date: Mon, 18 Dec 2023 11:33:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 13/14] net: phy: at803x: configure qca8084 work mode
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
CC: <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>,
        <p.zabel@pengutronix.de>, <f.fainelli@gmail.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
References: <20231215074005.26976-1-quic_luoj@quicinc.com>
 <20231215074005.26976-14-quic_luoj@quicinc.com>
 <20231217130221.GZ6288@kernel.org>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <20231217130221.GZ6288@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: o1Kxkwi4UZfHb-KHciI_c9Bzk4b3ICQz
X-Proofpoint-ORIG-GUID: o1Kxkwi4UZfHb-KHciI_c9Bzk4b3ICQz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=894
 mlxscore=0 suspectscore=0 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180024



On 12/17/2023 9:02 PM, Simon Horman wrote:
> On Fri, Dec 15, 2023 at 03:40:03PM +0800, Luo Jie wrote:
> 
> ...
> 
>> @@ -1038,6 +1045,46 @@ static int qca8084_common_clock_init(struct phy_device *phydev)
>>   	return clk_prepare_enable(priv->clk[MDIO_MASTER_AHB_CLK]);
>>   }
>>   
>> +static int qca8084_parse_and_set_work_mode(struct phy_device *phydev)
>> +{
>> +	struct device_node *node;
>> +	struct at803x_priv *priv;
>> +	u32 value, work_mode;
>> +	int ret;
>> +
>> +	node = phydev->mdio.dev.of_node;
>> +	priv = phydev->priv;
> 
> Hi Luo Jie,
> 
> a minor nit from my side: priv is set but otherwise unused in this function.

Thanks Simon, i will update it to remove it.

> 
>> +
>> +	/* The property "qcom,phy-work-mode" is only defined in one
>> +	 * PHY device tree node.
>> +	 */
>> +	ret = of_property_read_u32(node, "qcom,phy-work-mode", &value);
>> +	if (ret)
>> +		return ret == -EINVAL ? 0 : ret;
>> +
>> +	switch (value) {
>> +	case 0:
>> +		work_mode = QCA8084_WORK_MODE_QXGMII;
>> +		break;
>> +	case 1:
>> +		work_mode = QCA8084_WORK_MODE_QXGMII_PORT4_SGMII;
>> +		break;
>> +	case 2:
>> +		work_mode = QCA8084_WORK_MODE_SWITCH;
>> +		break;
>> +	case 3:
>> +		work_mode = QCA8084_WORK_MODE_SWITCH_PORT4_SGMII;
>> +		break;
>> +	default:
>> +		phydev_err(phydev, "invalid qcom,phy-work-mode %d\n", value);
>> +		return -EINVAL;
>> +	}
>> +
>> +	return qca8084_mii_modify(phydev, QCA8084_WORK_MODE_CFG,
>> +				  QCA8084_WORK_MODE_MASK,
>> +				  FIELD_PREP(QCA8084_WORK_MODE_MASK, work_mode));
>> +}
> 
> ...

