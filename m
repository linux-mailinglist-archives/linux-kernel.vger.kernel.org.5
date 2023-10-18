Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4497CD9DE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjJRK5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjJRK5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:57:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D0F109;
        Wed, 18 Oct 2023 03:57:09 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IAWqe2022369;
        Wed, 18 Oct 2023 10:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=D9bNJTP4bMopav6T6KtJN4NLOAcxeSrKyA4wBf/28Mc=;
 b=SsxT3+lP2GiZWs7eAgFypvrh7L56g/u61fI22Fjh56/3NbqNc5y1neUaobNhLBXUA9T3
 42G+WFYMx6l8DSuoH7/MGC9Z4ee82EA3+dnF+3rFOsDvM+gMqbZ0pcAFe79xMLM89oAp
 cMDWzo3zlnH42Cz2gtIgPTnxz5z4w0hu17TvPFuXSuRSB1o43Y/HfO9klJeRKuVz/bkG
 qpqQOb3vQ5xX9o67nHw1LxVDSYuiuz6L9HSzuQHGj/3jRF6tMpHMpm93lNp4S42i1aEJ
 3v6t3RmabPAc1agAa+oXEjaRt7Au9O0j1ccYLUGHpBAzxwxzl3eXGlgCNepB9D0tmmjC cw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tt9058q9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 10:57:06 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39IAv5vw002959
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 10:57:05 GMT
Received: from [10.216.39.143] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 18 Oct
 2023 03:56:59 -0700
Message-ID: <8bc65c14-7ac1-7d1f-c201-468956c560ff@quicinc.com>
Date:   Wed, 18 Oct 2023 16:26:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V2 2/4] clk: qcom: branch: Add mem ops support for branch2
 clocks
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20231011090028.1706653-1-quic_imrashai@quicinc.com>
 <20231011090028.1706653-3-quic_imrashai@quicinc.com>
 <ac3fc5fd-b6fa-4386-aa62-f182547d1a59@linaro.org>
From:   Imran Shaik <quic_imrashai@quicinc.com>
In-Reply-To: <ac3fc5fd-b6fa-4386-aa62-f182547d1a59@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7OxXQ2qxO3QTHGQ5SHxKGCH7pl3gbmf6
X-Proofpoint-ORIG-GUID: 7OxXQ2qxO3QTHGQ5SHxKGCH7pl3gbmf6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_09,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180090
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2023 3:21 PM, Konrad Dybcio wrote:
> 
> 
> On 10/11/23 11:00, Imran Shaik wrote:
>> From: Taniya Das <quic_tdas@quicinc.com>
>>
>> Clock CBCRs with memories need an update for memory before enable/disable
>> of the clock, which helps retain the respective block's register 
>> contents.
>> Add support for the mem ops to handle this sequence.
>>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
>> ---
>>   drivers/clk/qcom/clk-branch.c | 37 +++++++++++++++++++++++++++++++++++
>>   drivers/clk/qcom/clk-branch.h | 21 ++++++++++++++++++++
>>   2 files changed, 58 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/clk-branch.c 
>> b/drivers/clk/qcom/clk-branch.c
>> index fc4735f74f0f..9ac8d04b425a 100644
>> --- a/drivers/clk/qcom/clk-branch.c
>> +++ b/drivers/clk/qcom/clk-branch.c
>> @@ -1,6 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   /*
>>    * Copyright (c) 2013, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>>    */
>>   #include <linux/kernel.h>
>> @@ -134,6 +135,42 @@ static void clk_branch2_disable(struct clk_hw *hw)
>>       clk_branch_toggle(hw, false, clk_branch2_check_halt);
>>   }
>> +static int clk_branch2_mem_enable(struct clk_hw *hw)
>> +{
>> +    struct clk_mem_branch *mem_br = to_clk_mem_branch(hw);
>> +    const char *name = clk_hw_get_name(&mem_br->branch.clkr.hw);
>> +    u32 val;
>> +    int timeout = 200, ret;
> Reverse-Christmas-tree, please
> 
> You can drop the timeout variable and pass the int literal.
> 

Sure, will take care of this in the next series.

>> +
>> +    regmap_update_bits(mem_br->branch.clkr.regmap, 
>> mem_br->mem_enable_reg,
>> +            mem_br->mem_enable_ack_bit, mem_br->mem_enable_ack_bit);
> This is a mask, not a bit.
> 

Yes, will check and update.

>> +
>> +    ret = regmap_read_poll_timeout(mem_br->branch.clkr.regmap, 
>> mem_br->mem_ack_reg,
>> +            val, val & mem_br->mem_enable_ack_bit, 0, timeout);
> 
> [...]
> 
>> +/**
>> + * struct clk_mem_branch - gating clock which are associated with 
>> memories
>> + *
>> + * @mem_enable_reg: branch clock memory gating register
>> + * @mem_ack_reg: branch clock memory ack register
>> + * @mem_enable_ack_bit: ANDed with @mem_ack_reg to check memory 
>> enablement
> @dog: woofs
> 
> Describe what it is instead.
> 
> Konrad

Sure, will update the description in the next series.

Thanks,
Imran
