Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5F5786722
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 07:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239803AbjHXFZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 01:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239787AbjHXFZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 01:25:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356AA198;
        Wed, 23 Aug 2023 22:25:09 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37O52iuX009529;
        Thu, 24 Aug 2023 05:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kmKwr01EpasB+ADLvTx3XipsclwcdrknzBWShzrD9Zk=;
 b=jdE0/k++x3t83vuoFzNfhCms8tzDxHxR77PSRhsc0hm7ih83U4Xuq0f7p24ag3gVB6x1
 W1sYvH/K/Ms2cZluI+8qjYBSBhAfciXdSE+6O6WrUnqld+z0eeFs/1aATtK98NJ2PGPq
 gOhvfVpkuRjTk+xchb4DA3AeQDc3IGbrgp7FCTetsy5HqpWQvi3IsOMMYoHmgtQOwstG
 7BjoU9zdDvV8yjvuAONZ+7P2xQGbhV1X16eaxFJfxz0MlKPtc9T7R4nawTePLT3RyaR3
 wqyjdkRb+8Ez568EnIBDpsWd4BQsuieIfKaneDGuSGeZxORObK0STZfYl5oj72b7NH/B rQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3snkumsj0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 05:24:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37O5OnVw025425
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 05:24:49 GMT
Received: from [10.216.48.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 23 Aug
 2023 22:24:28 -0700
Message-ID: <b6d0664c-02b8-5641-c9af-218cd7bd0898@quicinc.com>
Date:   Thu, 24 Aug 2023 10:54:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/6] clk: qcom: gcc-ipq9574: Mark nssnoc clocks as
 critical
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <richardcochran@gmail.com>,
        <arnd@arndb.de>, <geert+renesas@glider.be>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>
CC:     <quic_saahtoma@quicinc.com>
References: <20230711093529.18355-1-quic_devipriy@quicinc.com>
 <20230711093529.18355-3-quic_devipriy@quicinc.com>
 <8433cbfa-52c5-90c5-1e4c-0b13236d2153@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <8433cbfa-52c5-90c5-1e4c-0b13236d2153@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jiROBs6DdN3kCx_eanj1-sVr18Hdaf0n
X-Proofpoint-ORIG-GUID: jiROBs6DdN3kCx_eanj1-sVr18Hdaf0n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_02,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=972
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308240042
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/11/2023 3:55 PM, Dmitry Baryshkov wrote:
> On 11/07/2023 12:35, Devi Priya wrote:
>> Mark nssnoc clocks as critical as they are to be turned on to access
>> nss port tx/rx clocks.
> 
> Can you please clarify, if these are turned off, one can not access 
> nsscc clocks? Then the nsscc should be the consumer of these clocks 
> (instead of declaring them as critical). May be using pm_clk for nsscc 
> will work. If not, you'll have to do that manually from 
> runtime_suspend/runtime_resume callbacks.

Sure, will use pm_clk for nsscc in V2

Thanks,
Devi Priya
> 
>>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>>   drivers/clk/qcom/gcc-ipq9574.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clk/qcom/gcc-ipq9574.c 
>> b/drivers/clk/qcom/gcc-ipq9574.c
>> index 6914f962c893..b68addc6f687 100644
>> --- a/drivers/clk/qcom/gcc-ipq9574.c
>> +++ b/drivers/clk/qcom/gcc-ipq9574.c
>> @@ -2166,7 +2166,7 @@ static struct clk_branch gcc_nssnoc_nsscc_clk = {
>>                   &pcnoc_bfdcd_clk_src.clkr.hw
>>               },
>>               .num_parents = 1,
>> -            .flags = CLK_SET_RATE_PARENT,
>> +            .flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
>>               .ops = &clk_branch2_ops,
>>           },
>>       },
>> @@ -2565,7 +2565,7 @@ static struct clk_branch gcc_nssnoc_snoc_clk = {
>>                   &system_noc_bfdcd_clk_src.clkr.hw
>>               },
>>               .num_parents = 1,
>> -            .flags = CLK_SET_RATE_PARENT,
>> +            .flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
>>               .ops = &clk_branch2_ops,
>>           },
>>       },
>> @@ -2582,7 +2582,7 @@ static struct clk_branch gcc_nssnoc_snoc_1_clk = {
>>                   &system_noc_bfdcd_clk_src.clkr.hw
>>               },
>>               .num_parents = 1,
>> -            .flags = CLK_SET_RATE_PARENT,
>> +            .flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
>>               .ops = &clk_branch2_ops,
>>           },
>>       },
> 
