Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11B57E7FA3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbjKJR46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbjKJRzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:55:42 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DE09EF0;
        Fri, 10 Nov 2023 00:33:31 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA7gT4Y029128;
        Fri, 10 Nov 2023 08:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qgi/6ZmsAMu0M3Ful5hR6Pp9eqYEByDbCU19aAVLbJA=;
 b=gWt4CxOsc81kHBT0iUUwQHxnitRMAUTo/BFK/vc4D1bJoL65jQwpHp6/VtTzjS8RV0RM
 b6u6//t8tWLcnxYD3SsMs5a9pHMiealh4MHfGITUo1M3gg24/9V8lsxHjA1HHSYYe6cs
 1L0FuwM7TPWOBeQtYxt56NQgox/ODSPofdtQhkYnlpW8Bb9YMGlz9JMxDggm7wx50dEY
 qt9K9afOGIp95uUbwxnepT1jO2wu3hj3yW+mIawW6yiRSHmy8Ag/c7rWRg5ceW/bYWuy
 OOksSIlbRB+tBuaTlULZMVWzqfzOX5J4eFbvEWY2CWKrVoi/+gqBBD+jA+6HfnAPwirC yA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u99e90w8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 08:33:20 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AA8XJCK029098
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 08:33:19 GMT
Received: from [10.216.7.246] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 10 Nov
 2023 00:33:12 -0800
Message-ID: <d89efebe-19a1-8690-ebde-bad78e0c7682@quicinc.com>
Date:   Fri, 10 Nov 2023 14:02:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V3 2/4] clk: qcom: branch: Add mem ops support for branch2
 clocks
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20231106103027.3988871-1-quic_imrashai@quicinc.com>
 <20231106103027.3988871-3-quic_imrashai@quicinc.com>
 <CAA8EJpqcyh1YrfHkdYaZfjyEDjKiV+HixrhcfPzsuTPwA5pzTQ@mail.gmail.com>
Content-Language: en-US
From:   Imran Shaik <quic_imrashai@quicinc.com>
In-Reply-To: <CAA8EJpqcyh1YrfHkdYaZfjyEDjKiV+HixrhcfPzsuTPwA5pzTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xrv6S76aioNvbKrsSJa2sPLcvmUjMgIQ
X-Proofpoint-ORIG-GUID: xrv6S76aioNvbKrsSJa2sPLcvmUjMgIQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_04,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311100071
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/6/2023 6:30 PM, Dmitry Baryshkov wrote:
> On Mon, 6 Nov 2023 at 12:31, Imran Shaik <quic_imrashai@quicinc.com> wrote:
>>
>> From: Taniya Das <quic_tdas@quicinc.com>
>>
>> Clock CBCRs with memories need an update for memory before enable/disable
>> of the clock, which helps retain the respective block's register contents.
>> Add support for the mem ops to handle this sequence.
>>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
> 
> It would be nice to have a description of what is 'CBCR with memories'
> and how does it differ from CBCR_FORCE_MEM_CORE_ON?
> 

This mem_ops implementation is to enable/disable the memories in 
ethernet PHY, prior to turning on the respective clocks. Where as the 
FORCE_MEM_CORE_ON is to keep the memories awake even if the clock is gated.

>> ---
>>   drivers/clk/qcom/clk-branch.c | 39 +++++++++++++++++++++++++++++++++++
>>   drivers/clk/qcom/clk-branch.h | 21 +++++++++++++++++++
>>   2 files changed, 60 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
>> index fc4735f74f0f..61bdd2147bed 100644
>> --- a/drivers/clk/qcom/clk-branch.c
>> +++ b/drivers/clk/qcom/clk-branch.c
>> @@ -1,6 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   /*
>>    * Copyright (c) 2013, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>>    */
>>
>>   #include <linux/kernel.h>
>> @@ -134,6 +135,44 @@ static void clk_branch2_disable(struct clk_hw *hw)
>>          clk_branch_toggle(hw, false, clk_branch2_check_halt);
>>   }
>>
>> +static int clk_branch2_mem_enable(struct clk_hw *hw)
>> +{
>> +       struct clk_mem_branch *mem_br = to_clk_mem_branch(hw);
>> +       struct clk_branch branch = mem_br->branch;
>> +       const char *name = clk_hw_get_name(&branch.clkr.hw);
>> +       u32 val;
>> +       int ret;
>> +
>> +       regmap_update_bits(branch.clkr.regmap, mem_br->mem_enable_reg,
>> +                       mem_br->mem_enable_ack_mask, mem_br->mem_enable_ack_mask);
>> +
>> +       ret = regmap_read_poll_timeout(branch.clkr.regmap, mem_br->mem_ack_reg,
>> +                       val, val & mem_br->mem_enable_ack_mask, 0, 200);
>> +       if (ret) {
>> +               WARN(1, "%s mem enable failed\n", name);
>> +               return ret;
>> +       }
>> +
>> +       return clk_branch2_enable(hw);
>> +}
>> +
>> +static void clk_branch2_mem_disable(struct clk_hw *hw)
>> +{
>> +       struct clk_mem_branch *mem_br = to_clk_mem_branch(hw);
>> +
>> +       regmap_update_bits(mem_br->branch.clkr.regmap, mem_br->mem_enable_reg,
>> +                                               mem_br->mem_enable_ack_mask, 0);
>> +
>> +       return clk_branch2_disable(hw);
>> +}
>> +
>> +const struct clk_ops clk_branch2_mem_ops = {
>> +       .enable = clk_branch2_mem_enable,
>> +       .disable = clk_branch2_mem_disable,
>> +       .is_enabled = clk_is_enabled_regmap,
>> +};
>> +EXPORT_SYMBOL_GPL(clk_branch2_mem_ops);
>> +
>>   const struct clk_ops clk_branch2_ops = {
>>          .enable = clk_branch2_enable,
>>          .disable = clk_branch2_disable,
>> diff --git a/drivers/clk/qcom/clk-branch.h b/drivers/clk/qcom/clk-branch.h
>> index 0cf800b9d08d..8ffed603c050 100644
>> --- a/drivers/clk/qcom/clk-branch.h
>> +++ b/drivers/clk/qcom/clk-branch.h
>> @@ -38,6 +38,23 @@ struct clk_branch {
>>          struct clk_regmap clkr;
>>   };
>>
>> +/**
>> + * struct clk_mem_branch - gating clock which are associated with memories
>> + *
>> + * @mem_enable_reg: branch clock memory gating register
>> + * @mem_ack_reg: branch clock memory ack register
>> + * @mem_enable_ack_mask: branch clock memory enable and ack field in @mem_ack_reg
>> + * @branch: branch clock gating handle
>> + *
>> + * Clock which can gate its memories.
>> + */
>> +struct clk_mem_branch {
>> +       u32     mem_enable_reg;
>> +       u32     mem_ack_reg;
>> +       u32     mem_enable_ack_mask;
>> +       struct clk_branch branch;
>> +};
>> +
>>   /* Branch clock common bits for HLOS-owned clocks */
>>   #define CBCR_CLK_OFF                   BIT(31)
>>   #define CBCR_NOC_FSM_STATUS            GENMASK(30, 28)
>> @@ -85,8 +102,12 @@ extern const struct clk_ops clk_branch_ops;
>>   extern const struct clk_ops clk_branch2_ops;
>>   extern const struct clk_ops clk_branch_simple_ops;
>>   extern const struct clk_ops clk_branch2_aon_ops;
>> +extern const struct clk_ops clk_branch2_mem_ops;
>>
>>   #define to_clk_branch(_hw) \
>>          container_of(to_clk_regmap(_hw), struct clk_branch, clkr)
>>
>> +#define to_clk_mem_branch(_hw) \
>> +       container_of(to_clk_branch(_hw), struct clk_mem_branch, branch)
>> +
>>   #endif
>> --
>> 2.25.1
>>
> 
> 
