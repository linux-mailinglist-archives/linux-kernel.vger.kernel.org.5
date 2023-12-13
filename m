Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9851810BF3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 09:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378743AbjLMIFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 03:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378727AbjLMIFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 03:05:31 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92560B2;
        Wed, 13 Dec 2023 00:05:37 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BD7x5t5028802;
        Wed, 13 Dec 2023 08:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        qcppdkim1; bh=krym0HY/pPafi8NwsXn9ZFmG16blrZh3WAY8SGvQUec=; b=jj
        NwQL5GbLj4obCxjevLbfa6D1x3Wu2DOzYaV6ynnbUxWbiGRYlaoaZr/2JWPLgamC
        nZLs14TkfTenK7DKoyDWCJJRFMIV6GJkWez2Zh8LxYrJOBsQ8sZ+CQUYKXbo2qda
        y3r/2XfQ9V4drpkRr+l7LNMyYhsNC2i2GbjLO2NUfRc8eUoLy/ZKHLYU2IcvQGd0
        SQssq8Kdcv387oIqEPVeK0QsENMqndZqj7IkBzLEpHZ2HqCvL+ZvUSU7Ak0okEFj
        brUi1+Q8Vew/IrQLUxn3hyl8/FV4JWXIhBxDPX2i8a6z5wI0nheW9iLGrA9Yi1Fh
        76GPY6oxpRh1TkbBSuQw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uy3rprqnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 08:05:12 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BD85Bju017157
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 08:05:11 GMT
Received: from [10.253.13.71] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Dec
 2023 00:05:06 -0800
Message-ID: <0495f1c2-00e6-4fa5-aaae-cf01475ef2ba@quicinc.com>
Date:   Wed, 13 Dec 2023 16:05:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] net: mdio: ipq4019: enable the SoC uniphy clocks
 for ipq5332 platform
Content-Language: en-US
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <robert.marko@sartura.hr>,
        <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20231212115151.20016-1-quic_luoj@quicinc.com>
 <20231212115151.20016-3-quic_luoj@quicinc.com>
 <20231212134621.0fe2583f@device.home>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <20231212134621.0fe2583f@device.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -nDUJhHxRajZkDQu6Fy_X7hz_TInw8sM
X-Proofpoint-GUID: -nDUJhHxRajZkDQu6Fy_X7hz_TInw8sM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 mlxscore=0 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312130057
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/12/2023 8:46 PM, Maxime Chevallier wrote:
> Hello,
> 
> On Tue, 12 Dec 2023 19:51:47 +0800
> Luo Jie <quic_luoj@quicinc.com> wrote:
> 
>> On the platform ipq5332, the related SoC uniphy GCC clocks need
>> to be enabled for making the MDIO slave devices accessible.
>>
>> These UNIPHY clocks are from the SoC platform GCC clock provider,
>> which are enabled for the connected PHY devices working.
>>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> 
> [...]
> 
>>   static int ipq4019_mdio_wait_busy(struct mii_bus *bus)
>> @@ -209,14 +230,43 @@ static int ipq4019_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
>>   static int ipq_mdio_reset(struct mii_bus *bus)
>>   {
>>   	struct ipq4019_mdio_data *priv = bus->priv;
>> -	int ret;
>> +	int ret, index;
>> +	unsigned long rate;
> 
> Please remember to use reverse christmas-tree ordering, meaning longer
> declaration lines go first :
> 
> 	struct ipq4019_mdio_data *priv = bus->priv;
> 	unsigned long rate;
> 	int ret, index;

Thanks, i will update this.

> 
>> +
>> +	/* For the platform ipq5332, there are two SoC uniphies available
>> +	 * for connecting with ethernet PHY, the SoC uniphy gcc clock
>> +	 * should be enabled for resetting the connected device such
>> +	 * as qca8386 switch, qca8081 PHY or other PHYs effectively.
>> +	 *
>> +	 * Configure MDIO/UNIPHY clock source frequency if clock instance
>> +	 * is specified in the device tree.
>> +	 */
>> +	for (index = MDIO_CLK_MDIO_AHB; index < MDIO_CLK_CNT; index++) {
>> +		switch (index) {
>> +		case MDIO_CLK_MDIO_AHB:
>> +			rate = IPQ_MDIO_CLK_RATE;
>> +			break;
>> +		case MDIO_CLK_UNIPHY0_AHB:
>> +		case MDIO_CLK_UNIPHY1_AHB:
>> +			rate = IPQ_UNIPHY_AHB_CLK_RATE;
>> +			break;
>> +		case MDIO_CLK_UNIPHY0_SYS:
>> +		case MDIO_CLK_UNIPHY1_SYS:
>> +			rate = IPQ_UNIPHY_SYS_CLK_RATE;
>> +			break;
>> +		default:
>> +			break;
>> +		}
>>   
>> -	/* Configure MDIO clock source frequency if clock is specified in the device tree */
>> -	ret = clk_set_rate(priv->mdio_clk, IPQ_MDIO_CLK_RATE);
>> -	if (ret)
>> -		return ret;
>> +		ret = clk_set_rate(priv->clk[index], rate);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret = clk_prepare_enable(priv->clk[index]);
>> +		if (ret)
>> +			return ret;
>> +	}
>>   
>> -	ret = clk_prepare_enable(priv->mdio_clk);
>>   	if (ret == 0)
>>   		mdelay(10);
>>   
>> @@ -240,10 +290,6 @@ static int ipq4019_mdio_probe(struct platform_device *pdev)
>>   	if (IS_ERR(priv->membase))
>>   		return PTR_ERR(priv->membase);
>>   
>> -	priv->mdio_clk = devm_clk_get_optional(&pdev->dev, "gcc_mdio_ahb_clk");
>> -	if (IS_ERR(priv->mdio_clk))
>> -		return PTR_ERR(priv->mdio_clk);
>> -
>>   	/* These platform resources are provided on the chipset IPQ5018 or
>>   	 * IPQ5332.
>>   	 */
>> @@ -271,6 +317,13 @@ static int ipq4019_mdio_probe(struct platform_device *pdev)
>>   		}
>>   	}
>>   
>> +	for (index = 0; index < MDIO_CLK_CNT; index++) {
>> +		priv->clk[index] = devm_clk_get_optional(&pdev->dev,
>> +							 mdio_clk_name[index]);
>> +		if (IS_ERR(priv->clk[index]))
>> +			return PTR_ERR(priv->clk[index]);
>> +	}
> 
> You should be able to use devm_clk_bulk_get_optional(), to avoid that
> loop.
> 
> Thanks,
> 
> Maxime

Thanks Maxime for the suggestion.
These clocks need to be configured the different clock rate, MDIO system
clock works on 100MHZ, but UNIPHY system clock works on 24MHZ.

For the clock rate set, i still need the loop to configure the different
clock rate on the different clock instance.

So i use the devm_clk_get_optional to acquire the exact clock ID here.


