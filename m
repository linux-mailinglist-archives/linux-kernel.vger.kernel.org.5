Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523927F5815
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjKWGVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjKWGVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:21:11 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C618110;
        Wed, 22 Nov 2023 22:21:18 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AN3OtEl031046;
        Thu, 23 Nov 2023 06:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dTy++ncCkASmzMy2lPTP9AkYMPYSGftpH1MuX9Vynvc=;
 b=U3e/GsCZ7x7ASxdMfY6xKnb1ghlazriKa/4ovcB8ZnclBcouSflZk+jdn9bqVkXuAb10
 WfuDg35u6cd/OJ97NOwtfnwfjSX6lp6x4xX1sAktlGBb/gY9iawGbl5A9HoS8Gblc6BS
 zoqwYIrbS/KXe81+jEAHZ41xEKIBR6BKhAQtpb62NnlYQqh7FdffLkebmeWPT30vjU9R
 vmw9cVw4NoCeBlyUgnt/7EVxe5s0xOrwOgcAp5TIPFxN7fgjqHzBjdPskMZH+87EVLEJ
 +vqnFa/wfjLORnKD7wS16oLQyuwNWCuFaxyVjVaGV7afOcvV+6QcXQVzpjg/sti6GKyD vw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uhguda4gd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 06:21:14 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AN6LDW2002723
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 06:21:13 GMT
Received: from [10.216.46.160] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 22 Nov
 2023 22:21:07 -0800
Message-ID: <6f7ee679-38be-abfd-a71c-d33e15c79c7d@quicinc.com>
Date:   Thu, 23 Nov 2023 11:50:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V4 2/4] clk: qcom: branch: Add mem ops support for branch2
 clocks
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
        <netdev@vger.kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20231117095558.3313877-1-quic_imrashai@quicinc.com>
 <20231117095558.3313877-3-quic_imrashai@quicinc.com>
 <90885d90-2e25-404b-b3a3-13d134801146@linaro.org>
Content-Language: en-US
From:   Imran Shaik <quic_imrashai@quicinc.com>
In-Reply-To: <90885d90-2e25-404b-b3a3-13d134801146@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7nV9iKCq3kAFyatrqrTlwW4dlkqjIfG_
X-Proofpoint-ORIG-GUID: 7nV9iKCq3kAFyatrqrTlwW4dlkqjIfG_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_03,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311230043
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/23/2023 1:39 AM, Konrad Dybcio wrote:
> 
> 
> On 11/17/23 10:55, Imran Shaik wrote:
>> From: Taniya Das <quic_tdas@quicinc.com>
>>
>> Add the support for mem ops implementation to handle the sequence of
>> enable/disable of the memories in ethernet PHY, prior to enable/disable
>> of the respective clocks, which helps retain the respecive block's
>> register contents.
>>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
>> ---
>>   drivers/clk/qcom/clk-branch.c | 39 +++++++++++++++++++++++++++++++++++
>>   drivers/clk/qcom/clk-branch.h | 21 +++++++++++++++++++
>>   2 files changed, 60 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/clk-branch.c 
>> b/drivers/clk/qcom/clk-branch.c
>> index fc4735f74f0f..61bdd2147bed 100644
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
>> @@ -134,6 +135,44 @@ static void clk_branch2_disable(struct clk_hw *hw)
>>       clk_branch_toggle(hw, false, clk_branch2_check_halt);
>>   }
>> +static int clk_branch2_mem_enable(struct clk_hw *hw)
>> +{
>> +    struct clk_mem_branch *mem_br = to_clk_mem_branch(hw);
>> +    struct clk_branch branch = mem_br->branch;
>> +    const char *name = clk_hw_get_name(&branch.clkr.hw);
> Bit of a microoptimization, but adding this implicitly in the WARN
> would only execute clk_hw_get_name when necessary
> 

Sure, will remove this line and use the clk_hw_get_name implicitly in WARN.

>> +    u32 val;
>> +    int ret;
>> +
>> +    regmap_update_bits(branch.clkr.regmap, mem_br->mem_enable_reg,
>> +            mem_br->mem_enable_ack_mask, mem_br->mem_enable_ack_mask);
> It's quite a nit from me, but it would be nice to have the next line 
> aligned
> with the opening brace (with a tab size of 8)
> 
> Konrad

Sure, will align the lines and post another series.

Thanks,
Imran
