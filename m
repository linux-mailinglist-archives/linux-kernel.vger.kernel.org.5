Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6E8776F2B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 06:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjHJEoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 00:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjHJEog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 00:44:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E524F1982;
        Wed,  9 Aug 2023 21:44:35 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37A43oDa001724;
        Thu, 10 Aug 2023 04:44:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eDtsqRVL8geaU0Wz9/iV1qYT7zkyEJAstPTmlndbnuM=;
 b=B0TuQZkl2FnmkX6N/lB9YVZJ0ED1iiVyIrIMBegHbVNBjILkP9NdoWusichfqYaw54YH
 CiY0dM88nWp7J7R5BPp0b942pY8Y5ZEiGx/yCBpuwPBqdDBX+MYF8762nHAnFTEkc7l2
 IjH1MdLrVoqjML/VH5f+XdpgIC1hp39mdfiMCiXY3zoK2FDoZfIN+COLoE7cYHclOa9k
 88qmLQGmiXT0fq6jDnGTVSKn+lMMhD1CsE0C2MdxFGeFIwGVipqh7eSljy88wfUigcGV
 qtgBE5InVqABEVT5k7cpAd58MMl4P7qaLdR/fKgRkyxhvkt0o5e/wx0zn6Kzppclv2pC nQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3scqsj045y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 04:44:21 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37A4iKG8017596
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 04:44:20 GMT
Received: from [10.253.39.188] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 21:44:16 -0700
Message-ID: <b1d4ea80-c00c-1cd1-d151-40c3756fd42f@quicinc.com>
Date:   Thu, 10 Aug 2023 12:44:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 3/4] clk: qcom: add clock controller driver for
 qca8386/qca8084
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20230809080047.19877-1-quic_luoj@quicinc.com>
 <20230809080047.19877-4-quic_luoj@quicinc.com>
 <18d2241a-98ab-6a57-1c4f-d961a4b37c6b@linaro.org>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <18d2241a-98ab-6a57-1c4f-d961a4b37c6b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UGNRq0m-WeHeVP1Snzhkjgvzv-D_2H0K
X-Proofpoint-GUID: UGNRq0m-WeHeVP1Snzhkjgvzv-D_2H0K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_03,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308100041
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/9/2023 11:38 PM, Krzysztof Kozlowski wrote:
> On 09/08/2023 10:00, Luo Jie wrote:
>> Add clock & reset controller driver for qca8386/qca8084.
>>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---
>>   drivers/clk/qcom/Kconfig       |    8 +
>>   drivers/clk/qcom/Makefile      |    1 +
>>   drivers/clk/qcom/nsscc-qca8k.c | 2195 ++++++++++++++++++++++++++++++++
>>   3 files changed, 2204 insertions(+)
>>   create mode 100644 drivers/clk/qcom/nsscc-qca8k.c
>>
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index 263e55d75e3f..d84705ff920d 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -195,6 +195,14 @@ config IPQ_GCC_9574
>>   	  i2c, USB, SD/eMMC, etc. Select this for the root clock
>>   	  of ipq9574.
>>   
>> +config IPQ_NSSCC_QCA8K
>> +	tristate "QCA8K(QCA8386 or QCA8084) NSS Clock Controller"
> 
> Is it specific to some arch? We keep ARM or ARM64 for most of the entries.

Hi, Krzysztof,
It's not specific to the arch, which is configured by MDIO, not Soc, so 
it does not depend on the ARM.

> 
>> +	help
>> +	  Support for NSS(Network SubSystem) clock controller on
>> +	  qca8386/qca8084 chip.
>> +	  Say Y if you want to use network features of switch or PHY
>> +	  device. Select this for the root clock of qca8k.
>> +
>>   config MSM_GCC_8660
>>   	tristate "MSM8660 Global Clock Controller"
>>   	depends on ARM || COMPILE_TEST
> 
> ...
> 
>> +static int nss_cc_qca8k_probe(struct mdio_device *mdiodev)
>> +{
>> +	struct device *dev = &mdiodev->dev;
>> +	struct regmap *regmap;
>> +	struct qcom_reset_controller *reset;
>> +	struct qcom_cc_desc desc = nss_cc_qca8k_desc;
>> +	size_t num_clks = desc.num_clks;
>> +	struct clk_regmap **rclks = desc.clks;
>> +	struct qcom_cc *cc;
>> +	int ret, i;
>> +
>> +	cc = devm_kzalloc(dev, sizeof(*cc), GFP_KERNEL);
>> +	if (!cc)
>> +		return -ENOMEM;
>> +
>> +	cc->rclks = rclks;
>> +	cc->num_rclks = num_clks;
>> +	reset = &cc->reset;
>> +
>> +	regmap = devm_regmap_init(dev, NULL, mdiodev->bus, desc.config);
>> +
> 
> Drop blank line.

Okay.
> 
>> +	if (IS_ERR(regmap)) {
>> +		dev_err(dev, "Failed to init MDIO regmap\n");
> 
> All of error returns could be converted return dev_err_probe(), just to
> have smaller code. Not a requirement, though.
> 

will update this in the next patch set.

>> +		return PTR_ERR(regmap);
>> +	}
>> +
>> +	reset->rcdev.of_node = dev->of_node;
>> +	reset->rcdev.dev = dev;
>> +	reset->rcdev.ops = &qcom_reset_ops;
>> +	reset->rcdev.owner = dev->driver->owner;
>> +	reset->rcdev.nr_resets = desc.num_resets;
>> +	reset->regmap = regmap;
>> +	reset->reset_map = desc.resets;
>> +
>> +	ret = devm_reset_controller_register(dev, &reset->rcdev);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to register QCA8K reset controller: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	for (i = 0; i < num_clks; i++) {
>> +		if (!rclks[i])
>> +			continue;
>> +
>> +		ret = devm_clk_register_regmap(dev, rclks[i]);
>> +		if (ret) {
>> +			dev_err(dev, "Failed to regmap register for QCA8K clock: %d\n", ret);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	ret = devm_of_clk_add_hw_provider(dev, qcom_qca8k_clk_hw_get, cc);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to register provider for QCA8K clock: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	dev_info(dev, "Registered NSSCC QCA8K clocks\n");
> 
> Drop the simple info for probe status. Kernel has other ways to do this.

will remove this in the next patch set.

> 
>> +	return ret;
>> +}
>> +
>> +static const struct of_device_id nss_cc_qca8k_match_table[] = {
>> +	{ .compatible = "qcom,qca8085-nsscc" },
>> +	{ .compatible = "qcom,qca8084-nsscc" },
>> +	{ .compatible = "qcom,qca8082-nsscc" },
>> +	{ .compatible = "qcom,qca8386-nsscc" },
>> +	{ .compatible = "qcom,qca8385-nsscc" },
>> +	{ .compatible = "qcom,qca8384-nsscc" },
> 
> You only need qca8084 here. Drop all other entries.
will remove these entries in the next patch, thanks for the review.

> 
>> +	{ }
>> +};
> 
> 
> 
> Best regards,
> Krzysztof
> 
