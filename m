Return-Path: <linux-kernel+bounces-13321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F87820378
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 04:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38A72826B1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 03:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5F35249;
	Sat, 30 Dec 2023 03:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oKxfJHLV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB124416;
	Sat, 30 Dec 2023 03:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BU3DREf006099;
	Sat, 30 Dec 2023 03:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=8c0GH8dqUCpd9jsZDZf2CgJ01L5NHGOI5uNMKuoPtrs=; b=oK
	xfJHLVSGmAr819OJMj2iXNSnaDhkOCMplbjA9+B95s070mQTFKTvE+m/Bcc86Ngz
	Fke3JoarvRBBpfn+ySI3Ef46EkTkMZgg/gXRZ46puMmYKtwwTHUWIPgLCJJrNC+M
	KUgR5+V9L2mh8WYXLy+HgLeRTD2M/upmmGOzuXQAv27ti7JiV/4um0FRrYzUGDod
	Bw1Ou8tQp0CTVXKc882eAFSg+9M47SM2qexDp4dbV31xe9pGJc9BLEhdg2IFTpos
	lng64Qf8vwOYkoUX506E6UxTrqiOfRMxCK4IjcooNcaSLAL9yp9ql5/Mn0DiPZN5
	DTstNnw4wkbG5zww62Qg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v9655bxtm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Dec 2023 03:15:16 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BU3FFjd029089
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Dec 2023 03:15:15 GMT
Received: from [10.253.33.123] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 Dec
 2023 19:15:11 -0800
Message-ID: <f15dee29-662b-4f8f-ad88-87b1548658d7@quicinc.com>
Date: Sat, 30 Dec 2023 11:15:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] net: mdio: ipq4019: move eth_ldo_rdy before MDIO
 bus register
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <robert.marko@sartura.hr>
CC: <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20231225084424.30986-1-quic_luoj@quicinc.com>
 <20231225084424.30986-2-quic_luoj@quicinc.com>
 <aa495827-4d20-4b66-8496-eef378d8f7c1@linaro.org>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <aa495827-4d20-4b66-8496-eef378d8f7c1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rvtaT6WZ0fHTvQlQchC6aH1RXiY0VpFH
X-Proofpoint-ORIG-GUID: rvtaT6WZ0fHTvQlQchC6aH1RXiY0VpFH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312300025



On 12/28/2023 5:49 PM, Konrad Dybcio wrote:
> On 25.12.2023 09:44, Luo Jie wrote:
>> The ethernet LDO provides the clock for the ethernet PHY that
>> is connected with PCS, each LDO enables the clock output to
>> each PCS, after the clock output enablement, the PHY GPIO reset
>> can take effect.
>>
>> For the PHY taking the MDIO bus level GPIO reset, the ethernet
>> LDO should be enabled before the MDIO bus register.
>>
>> For example, the qca8084 PHY takes the MDIO bus level GPIO
>> reset for quad PHYs, there is another reason for qca8084 PHY
>> using MDIO bus level GPIO reset instead of PHY level GPIO
>> reset as below.
>>
>> The work sequence of qca8084:
>> 1. enable ethernet LDO.
>> 2. GPIO reset on quad PHYs.
>> 3. register clock provider based on MDIO device of qca8084.
>> 4. PHY probe function called for initializing common clocks.
>> 5. PHY capabilities acquirement.
>>
>> If qca8084 takes PHY level GPIO reset in the step 4, the clock
>> provider of qca8084 can't be registered correctly, since the
>> clock parent(reading the current qca8084 hardware registers in
>> step 3) of the registered clocks is deserted after GPIO reset.
>>
>> There are two PCS(UNIPHY) supported in SOC side on ipq5332,
>> and three PCS(UNIPHY) supported on ipq9574.
>>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---
>>   drivers/net/mdio/mdio-ipq4019.c | 51 +++++++++++++++++++++------------
>>   1 file changed, 32 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
>> index abd8b508ec16..5273864fabb3 100644
>> --- a/drivers/net/mdio/mdio-ipq4019.c
>> +++ b/drivers/net/mdio/mdio-ipq4019.c
>> @@ -37,9 +37,12 @@
>>   
>>   #define IPQ_PHY_SET_DELAY_US	100000
>>   
>> +/* Maximum SOC PCS(uniphy) number on IPQ platform */
>> +#define ETH_LDO_RDY_CNT				3
>> +
>>   struct ipq4019_mdio_data {
>> -	void __iomem	*membase;
>> -	void __iomem *eth_ldo_rdy;
>> +	void __iomem *membase;
>> +	void __iomem *eth_ldo_rdy[ETH_LDO_RDY_CNT];
>>   	struct clk *mdio_clk;
>>   };
>>   
>> @@ -206,19 +209,8 @@ static int ipq4019_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
>>   static int ipq_mdio_reset(struct mii_bus *bus)
>>   {
>>   	struct ipq4019_mdio_data *priv = bus->priv;
>> -	u32 val;
>>   	int ret;
>>   
>> -	/* To indicate CMN_PLL that ethernet_ldo has been ready if platform resource 1
>> -	 * is specified in the device tree.
>> -	 */
>> -	if (priv->eth_ldo_rdy) {
>> -		val = readl(priv->eth_ldo_rdy);
>> -		val |= BIT(0);
>> -		writel(val, priv->eth_ldo_rdy);
>> -		fsleep(IPQ_PHY_SET_DELAY_US);
>> -	}
>> -
>>   	/* Configure MDIO clock source frequency if clock is specified in the device tree */
>>   	ret = clk_set_rate(priv->mdio_clk, IPQ_MDIO_CLK_RATE);
>>   	if (ret)
>> @@ -236,7 +228,7 @@ static int ipq4019_mdio_probe(struct platform_device *pdev)
>>   	struct ipq4019_mdio_data *priv;
>>   	struct mii_bus *bus;
>>   	struct resource *res;
>> -	int ret;
>> +	int ret, index;
>>   
>>   	bus = devm_mdiobus_alloc_size(&pdev->dev, sizeof(*priv));
>>   	if (!bus)
>> @@ -252,11 +244,32 @@ static int ipq4019_mdio_probe(struct platform_device *pdev)
>>   	if (IS_ERR(priv->mdio_clk))
>>   		return PTR_ERR(priv->mdio_clk);
>>   
>> -	/* The platform resource is provided on the chipset IPQ5018 */
>> -	/* This resource is optional */
>> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> -	if (res)
>> -		priv->eth_ldo_rdy = devm_ioremap_resource(&pdev->dev, res);
>> +	/* These platform resources are provided on the chipset IPQ5018 or
>> +	 * IPQ5332.
>> +	 */
>> +	/* This resource are optional */
>> +	for (index = 0; index < ETH_LDO_RDY_CNT; index++) {
>> +		res = platform_get_resource(pdev, IORESOURCE_MEM, index + 1);
>> +		if (res) {
> if (!res)
> 	break

will update this.

> 
>> +			priv->eth_ldo_rdy[index] = devm_ioremap(&pdev->dev,
>> +								res->start,
>> +								resource_size(res));
>> +
>> +			/* The ethernet LDO enable is necessary to reset PHY
>> +			 * by GPIO, some PHY(such as qca8084) GPIO reset uses
>> +			 * the MDIO level reset, so this function should be
>> +			 * called before the MDIO bus register.
>> +			 */
>> +			if (priv->eth_ldo_rdy[index]) {
>> +				u32 val;
>> +
>> +				val = readl(priv->eth_ldo_rdy[index]);
>> +				val |= BIT(0);
>> +				writel(val, priv->eth_ldo_rdy[index]);
>> +				fsleep(IPQ_PHY_SET_DELAY_US);
> fsleep should only be used when the argument is variable
> 
> Konrad

Ok, will update to use usleep_range, Thanks.

