Return-Path: <linux-kernel+bounces-15550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1243822DFC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C69284C97
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675731947E;
	Wed,  3 Jan 2024 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o1HORcO6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2743C1945E;
	Wed,  3 Jan 2024 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 403CICU4030794;
	Wed, 3 Jan 2024 13:06:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=6AihegcrHuKOKVAT22QfdIlNLXan2cC61758qMqmqts=; b=o1
	HORcO66e7KRXO79u2YP06PNJvhOWBc8QJui8Vd6ufOk4RNIY117WyGj/IZkwCaOC
	WHtxgIKdnq0CKl7zNTpNimaajPO49ZlbWZ6CoKLglZ/SiHCt1GvHrmbA8QClWQZe
	MfIvm/QQNmY08T+DImeXjYMJIT+3yRoKZoXKHJ8+JT2xCHdbGcv8FGfFrvtXsj6o
	rjOuSEOQnCYyxO22pKEiYO/5XMi6bhWBQwt48D1ep+NFP+u8iL4BBOsE5W4rsDr4
	r8+cZ1rzvSDBnMoGUxqoWN5z3qEQnrnX0yEZou0jhP88MG9HSsOPy9siBkE8wy0r
	RnJTNgmmauFLh6c0MIvA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vcg41ba7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 13:06:19 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 403D6IZw032623
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jan 2024 13:06:18 GMT
Received: from [10.253.72.77] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 3 Jan
 2024 05:06:13 -0800
Message-ID: <365d76a4-db05-40ac-a453-fb7e8b6db423@quicinc.com>
Date: Wed, 3 Jan 2024 21:06:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] net: mdio: ipq4019: configure CMN PLL clock for
 ipq5332
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
 <20231225084424.30986-4-quic_luoj@quicinc.com>
 <1d7ef6cc-5c25-4a59-ad7f-38870ac132c4@linaro.org>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <1d7ef6cc-5c25-4a59-ad7f-38870ac132c4@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TdYOiUNuml-WWw9-fiDVZ4SKAWquoQeD
X-Proofpoint-ORIG-GUID: TdYOiUNuml-WWw9-fiDVZ4SKAWquoQeD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401030107



On 1/3/2024 5:50 PM, Bryan O'Donoghue wrote:
> On 25/12/2023 08:44, Luo Jie wrote:
>> The reference clock of CMN PLL block is selectable, the internal
>> 48MHZ is used by default.
>>
>> The output clock of CMN PLL block is for providing the clock
>> source of ethernet device(such as qca8084), there are 1 * 25MHZ
>> and 3 * 50MHZ output clocks available for the ethernet devices.
>>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---
>>   drivers/net/mdio/mdio-ipq4019.c | 129 +++++++++++++++++++++++++++++++-
>>   1 file changed, 128 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/mdio/mdio-ipq4019.c 
>> b/drivers/net/mdio/mdio-ipq4019.c
>> index e24b0e688b10..e4862ac02026 100644
>> --- a/drivers/net/mdio/mdio-ipq4019.c
>> +++ b/drivers/net/mdio/mdio-ipq4019.c
>> @@ -44,6 +44,17 @@
>>   /* Maximum SOC PCS(uniphy) number on IPQ platform */
>>   #define ETH_LDO_RDY_CNT                3
>> +#define CMN_PLL_REFERENCE_SOURCE_SEL        0x28
>> +#define CMN_PLL_REFCLK_SOURCE_DIV        GENMASK(9, 8)
>> +
>> +#define CMN_PLL_REFERENCE_CLOCK            0x784
>> +#define CMN_PLL_REFCLK_EXTERNAL            BIT(9)
>> +#define CMN_PLL_REFCLK_DIV            GENMASK(8, 4)
>> +#define CMN_PLL_REFCLK_INDEX            GENMASK(3, 0)
>> +
>> +#define CMN_PLL_POWER_ON_AND_RESET        0x780
>> +#define CMN_ANA_EN_SW_RSTN            BIT(6)
>> +
>>   enum mdio_clk_id {
>>       MDIO_CLK_MDIO_AHB,
>>       MDIO_CLK_UNIPHY0_AHB,
>> @@ -55,6 +66,7 @@ enum mdio_clk_id {
>>   struct ipq4019_mdio_data {
>>       void __iomem *membase;
>> +    void __iomem *cmn_membase;
>>       void __iomem *eth_ldo_rdy[ETH_LDO_RDY_CNT];
>>       struct clk *clk[MDIO_CLK_CNT];
>>   };
>> @@ -227,12 +239,116 @@ static int ipq4019_mdio_write_c22(struct 
>> mii_bus *bus, int mii_id, int regnum,
>>       return 0;
>>   }
>> +/* For the CMN PLL block, the reference clock can be configured 
>> according to
>> + * the device tree property "qcom,cmn-ref-clock-frequency", the 
>> internal 48MHZ
>> + * is used by default.
>> + *
>> + * The output clock of CMN PLL block is provided to the ethernet 
>> devices,
>> + * threre are 4 CMN PLL output clocks (1*25MHZ + 3*50MHZ) enabled by 
>> default.
>> + *
>> + * Such as the output 50M clock for the qca8084 ethernet PHY.
>> + */
>> +static int ipq_cmn_clock_config(struct mii_bus *bus)
>> +{
>> +    struct ipq4019_mdio_data *priv;
>> +    u32 reg_val, src_sel, ref_clk;
>> +    int ret;
>> +
>> +    priv = bus->priv;
>> +    if (priv->cmn_membase) {
> 
> if (!priv->cnm_membase)
>      return 0;
> 
> then move the indentation here one tab left.
> 
Ok, will update this, Thanks.

> ---
> bod

