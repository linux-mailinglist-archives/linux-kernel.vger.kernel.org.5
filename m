Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46B4780744
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358639AbjHRIgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjHRIgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:36:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781373A94;
        Fri, 18 Aug 2023 01:36:21 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37I5aDHQ024491;
        Fri, 18 Aug 2023 08:36:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=v/kACXt63NJxIGkn0xwWK1EDATP14TEgK+yK4c43CoE=;
 b=L/0OWBDFD0MhMyee/l0TRAqoyuVVRaEMz5bW37kEkGnTMJWUgkHyYSpwkRB9Vt6MyBVc
 aVFIFNzQ/F9g58yl4GcwalpDTrecnlkYM/N8E1XXJXQPrinsVXpU+npoxgnIVG0lwqhR
 8CTM4b52aEkFt56FGWp/bK2Lqath0PVZckos8XIGgbKx0F/OW1S975QWYgbTtas1lAE1
 WJxCkQJhUAe9gz2AD4IFIu9uzB0f3f6kxGJF9flfh0O73Evi9jXJ0+a8byGE5aJ7STvz
 KVTpG/smS61amORUji638B7oC1uUPrvMWc8uqpAvZu2jEGxzg+RjSu8PVzX9AXNx7aLV Jg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3she6ptyrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 08:36:00 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37I8ZxX3015377
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 08:35:59 GMT
Received: from [10.253.34.149] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 18 Aug
 2023 01:35:55 -0700
Message-ID: <6ee2129b-04c6-4978-03d6-835e3a10e665@quicinc.com>
Date:   Fri, 18 Aug 2023 16:35:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 3/4] clk: qcom: common: add _qcom_cc_really_probe
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     <agross@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20230815085205.9868-1-quic_luoj@quicinc.com>
 <20230815085205.9868-4-quic_luoj@quicinc.com>
 <2dcu7jjwd2bhjbzxrxbfif566nupznb5n4oadnqha4h45w2n2g@4uy2pxkj5bvj>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <2dcu7jjwd2bhjbzxrxbfif566nupznb5n4oadnqha4h45w2n2g@4uy2pxkj5bvj>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: U4o7DFOgkh6_T-S-KHKiGnRlRMNjstDc
X-Proofpoint-ORIG-GUID: U4o7DFOgkh6_T-S-KHKiGnRlRMNjstDc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_10,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180080
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/2023 11:14 AM, Bjorn Andersson wrote:
> On Tue, Aug 15, 2023 at 04:52:04PM +0800, Luo Jie wrote:
>> Add the common function _qcom_cc_really_probe, which takes
>> struct device as parameter.
> 
> This commit message completely fails to describe the problem/issue the
> change is solving. So when we look back in the git history, there will
> be no indication of why things looks like they do.
> 
Thanks for the comments, i will update the commit message in detail on 
the issue resolved in the next patch set.

>>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---
>>   drivers/clk/qcom/common.c | 10 ++++++++--
>>   drivers/clk/qcom/common.h |  2 ++
>>   2 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
>> index 75f09e6e057e..4cbdbfb65606 100644
>> --- a/drivers/clk/qcom/common.c
>> +++ b/drivers/clk/qcom/common.c
>> @@ -234,11 +234,10 @@ static struct clk_hw *qcom_cc_clk_hw_get(struct of_phandle_args *clkspec,
>>   	return cc->rclks[idx] ? &cc->rclks[idx]->hw : NULL;
>>   }
>>   
>> -int qcom_cc_really_probe(struct platform_device *pdev,
>> +int _qcom_cc_really_probe(struct device *dev,
>>   			 const struct qcom_cc_desc *desc, struct regmap *regmap)
>>   {
>>   	int i, ret;
>> -	struct device *dev = &pdev->dev;
>>   	struct qcom_reset_controller *reset;
>>   	struct qcom_cc *cc;
>>   	struct gdsc_desc *scd;
>> @@ -305,6 +304,13 @@ int qcom_cc_really_probe(struct platform_device *pdev,
>>   
>>   	return 0;
>>   }
>> +EXPORT_SYMBOL_GPL(_qcom_cc_really_probe);
>> +
>> +int qcom_cc_really_probe(struct platform_device *pdev,
>> +			 const struct qcom_cc_desc *desc, struct regmap *regmap)
> 
> Why do we want to keep this wrapper around?
> 
There are many existed clock controller drivers using this wrapper 
qcom_cc_really_probe, so i still keep this wrapper.

do we need to remove this wrapper and update the existed drivers to use 
_qcom_cc_really_probe?
> 
> PS. Please give some time before posting v5, I would like to understand
> the MDIO regmap operations in patch 4 better before commenting on it.
> 
> Regards,
> Bjorn
> 
Sure, the MDIO read/write operations need to check whether the MDIO bus 
is in busy state, the poll and sleep are taken to check.

Thanks Bjorn for your time and review comments.
>> +{
>> +	return _qcom_cc_really_probe(&pdev->dev, desc, regmap);
>> +}
>>   EXPORT_SYMBOL_GPL(qcom_cc_really_probe);
>>   
>>   int qcom_cc_probe(struct platform_device *pdev, const struct qcom_cc_desc *desc)
>> diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
>> index 9c8f7b798d9f..9710ade9bf15 100644
>> --- a/drivers/clk/qcom/common.h
>> +++ b/drivers/clk/qcom/common.h
>> @@ -58,6 +58,8 @@ extern int qcom_cc_register_sleep_clk(struct device *dev);
>>   
>>   extern struct regmap *qcom_cc_map(struct platform_device *pdev,
>>   				  const struct qcom_cc_desc *desc);
>> +extern int _qcom_cc_really_probe(struct device *dev,
>> +			 const struct qcom_cc_desc *desc, struct regmap *regmap);
>>   extern int qcom_cc_really_probe(struct platform_device *pdev,
>>   				const struct qcom_cc_desc *desc,
>>   				struct regmap *regmap);
>> -- 
>> 2.17.1
>>
