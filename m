Return-Path: <linux-kernel+bounces-15565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 105F9822E31
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36FAA1C228C0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6149199C7;
	Wed,  3 Jan 2024 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RNdSTdxu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9984B199A2;
	Wed,  3 Jan 2024 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 403D6cW1032742;
	Wed, 3 Jan 2024 13:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Q1OedofFFqxTrsRq2LE9w6jzniiienr/0koej1/OS34=; b=RN
	dSTdxuduppU3UbnUsSaiOhPl2MB+Vnje/zjLjkMR//OgM9Os1EWc0xeGni+XfJgd
	ZNKOcy1kmMn8FIfEY3kIKGLkw/6a6b+RLJAIrUa6TB3SOLtTN8CqSDDonbzdMVtX
	MZYtknWqXw+waa4nQFc0eqeHwId0cDw7YGX5kect04C8af7c3pF06zee3q7FZudw
	kdisFoPsfV6oH/w5uHEK7pU8uSxeXw1otUIX+GXnSR4arAIjYnbt1fmU2/HwBl1S
	h36Il3gu8Gn8Gth/NGAU6WLAT1rqu/QTVkhEN5qZDoQS6d1CUIHteQJMimeS/XPB
	gsgHKquY+9XGJZwvbS0g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vd84cr1gw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 13:25:46 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 403DPjbh013194
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jan 2024 13:25:45 GMT
Received: from [10.253.72.77] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 3 Jan
 2024 05:25:40 -0800
Message-ID: <06aae775-4d62-4cca-9152-f752a8f9a33a@quicinc.com>
Date: Wed, 3 Jan 2024 21:25:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] net: mdio: ipq4019: enable the SoC uniphy clocks
 for ipq5332 platform
Content-Language: en-US
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <robert.marko@sartura.hr>
CC: <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20231225084424.30986-1-quic_luoj@quicinc.com>
 <20231225084424.30986-3-quic_luoj@quicinc.com>
 <e0926d70-09d1-40ab-939a-7e110d718448@linaro.org>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <e0926d70-09d1-40ab-939a-7e110d718448@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lr9s0WBhR1YkKwFZdnIvUWsCgfrpvr2u
X-Proofpoint-GUID: lr9s0WBhR1YkKwFZdnIvUWsCgfrpvr2u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401030110



On 1/3/2024 5:48 PM, Bryan O'Donoghue wrote:
> On 25/12/2023 08:44, Luo Jie wrote:
>> On the platform ipq5332, the related SoC uniphy GCC clocks need
>> to be enabled for making the MDIO slave devices accessible.
>>
>> These UNIPHY clocks are from the SoC platform GCC clock provider,
>> which are enabled for the connected PHY devices working.
>>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---
>>   drivers/net/mdio/mdio-ipq4019.c | 75 ++++++++++++++++++++++++++++-----
>>   1 file changed, 64 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/net/mdio/mdio-ipq4019.c 
>> b/drivers/net/mdio/mdio-ipq4019.c
>> index 5273864fabb3..e24b0e688b10 100644
>> --- a/drivers/net/mdio/mdio-ipq4019.c
>> +++ b/drivers/net/mdio/mdio-ipq4019.c
>> @@ -35,15 +35,36 @@
>>   /* MDIO clock source frequency is fixed to 100M */
>>   #define IPQ_MDIO_CLK_RATE    100000000
>> +/* SoC UNIPHY fixed clock */
>> +#define IPQ_UNIPHY_AHB_CLK_RATE    100000000
>> +#define IPQ_UNIPHY_SYS_CLK_RATE    24000000
>> +
>>   #define IPQ_PHY_SET_DELAY_US    100000
>>   /* Maximum SOC PCS(uniphy) number on IPQ platform */
>>   #define ETH_LDO_RDY_CNT                3
>> +enum mdio_clk_id {
>> +    MDIO_CLK_MDIO_AHB,
>> +    MDIO_CLK_UNIPHY0_AHB,
>> +    MDIO_CLK_UNIPHY0_SYS,
>> +    MDIO_CLK_UNIPHY1_AHB,
>> +    MDIO_CLK_UNIPHY1_SYS,
>> +    MDIO_CLK_CNT
>> +};
>> +
>>   struct ipq4019_mdio_data {
>>       void __iomem *membase;
>>       void __iomem *eth_ldo_rdy[ETH_LDO_RDY_CNT];
>> -    struct clk *mdio_clk;
>> +    struct clk *clk[MDIO_CLK_CNT];
>> +};
>> +
>> +static const char *const mdio_clk_name[] = {
>> +    "gcc_mdio_ahb_clk",
>> +    "uniphy0_ahb",
>> +    "uniphy0_sys",
>> +    "uniphy1_ahb",
>> +    "uniphy1_sys"
>>   };
>>   static int ipq4019_mdio_wait_busy(struct mii_bus *bus)
>> @@ -209,14 +230,43 @@ static int ipq4019_mdio_write_c22(struct mii_bus 
>> *bus, int mii_id, int regnum,
>>   static int ipq_mdio_reset(struct mii_bus *bus)
>>   {
>>       struct ipq4019_mdio_data *priv = bus->priv;
>> -    int ret;
>> +    unsigned long rate;
>> +    int ret, index;
>> -    /* Configure MDIO clock source frequency if clock is specified in 
>> the device tree */
>> -    ret = clk_set_rate(priv->mdio_clk, IPQ_MDIO_CLK_RATE);
>> -    if (ret)
>> -        return ret;
>> +    /* For the platform ipq5332, there are two SoC uniphies available
>> +     * for connecting with ethernet PHY, the SoC uniphy gcc clock
>> +     * should be enabled for resetting the connected device such
>> +     * as qca8386 switch, qca8081 PHY or other PHYs effectively.
>> +     *
>> +     * Configure MDIO/UNIPHY clock source frequency if clock instance
>> +     * is specified in the device tree.
>> +     */
>> +    for (index = MDIO_CLK_MDIO_AHB; index < MDIO_CLK_CNT; index++) {
> 
> you could do a
> 
> if (!priv->clk[index])
>      continue;

Thanks for the comments, will update it.
> 
> here and save a few cycles executing code for absent clocks. ipq6018 has 
> just 1/5 of the clocks you are checking for here.
> 
> Better still capture the number of clocks you find in probe() in a 
> variable priv->num_clocks and only step through the array

Ok, thanks bod for the comments to improve the code.

> 
> for (i = 0; i < priv->num_clocks; i++) {}
> 
> ---
> bod

