Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26479780706
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358543AbjHRIVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358526AbjHRIU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:20:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93919E55;
        Fri, 18 Aug 2023 01:20:55 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37I56bhE023261;
        Fri, 18 Aug 2023 08:20:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0OJB9bimMmDXvfLY8yQNGFq9Rj+mqR3wqinojg+U3To=;
 b=YWxUZBvVJoBTBGVChDYzOfKQwW6vz0xIcdHjUxk6IrrNUuKY/5SSxFQZrCLvYkvw5k8h
 +ydCUhAX5ltisqBosQ78mzh8mYIvIF7YPXq/Cy+MTUA+Mc0Zs6LFn08ZaT7kDnDCysYR
 brHYCB0MPxilE4Fc+Sk3polacfjc9Mg/duyXJzvds7rl8/BnxM2A0OidI4yWQ5zYzl5z
 JOIFHifGTtws9t7fpfFSJhCSF+YDp2AjCVv+ejegJHiKXH6kDBmSG5ZIDqwiJlO+THvk
 MQfgiDiHTvrmzqWAhUoJQnLjpU3BxrxDHyQOnwYJg+0T3vxB0CrNXJ5MSMcBscaxlQTx Ng== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sht44936h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 08:20:40 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37I8KdTa002650
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 08:20:39 GMT
Received: from [10.253.34.149] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 18 Aug
 2023 01:20:36 -0700
Message-ID: <23b1ff70-21c0-f4e2-c377-55317f69357c@quicinc.com>
Date:   Fri, 18 Aug 2023 16:20:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 1/4] clk: qcom: branch: Add clk_branch2_mdio_ops
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
 <20230815085205.9868-2-quic_luoj@quicinc.com>
 <p7m4fi53nc75rjnmxdrukaitaddvq4vgvpydiyjmem4g2leyih@uohiocu35w2u>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <p7m4fi53nc75rjnmxdrukaitaddvq4vgvpydiyjmem4g2leyih@uohiocu35w2u>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wjBlevrSvqOdmcqk8PJVEuNga-l1WrAT
X-Proofpoint-ORIG-GUID: wjBlevrSvqOdmcqk8PJVEuNga-l1WrAT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_09,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180077
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/2023 11:29 AM, Bjorn Andersson wrote:
> On Tue, Aug 15, 2023 at 04:52:02PM +0800, Luo Jie wrote:
>> Add the clk_branch2_mdio_ops for supporting clock controller
>> where the hardware register is accessed by MDIO bus, and the
>> spin clock can't be used because of sleep during the MDIO
> 
> spin clock?
> 
> I believe you're trying to say that the underlying access to the MDIO
> bus can not be done in non-sleepable context and we can therefor not use
> enable/disable to operate it?

Hi Bjorn,
Thanks for the review comments.
yes, the MDIO operation can't be done in non-sleepable context, and 
enable/disable clock is using spin lock, so i enable the clock in 
.prepare ops.

will fix this typo"spin clock" to "spin lock"

> 
>> operation.
>>
>> The clock is enabled by the .prepare instead of .enable when
>> the clk_branch2_mdio_ops is used.
>>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---
>>   drivers/clk/qcom/clk-branch.c | 7 +++++++
>>   drivers/clk/qcom/clk-branch.h | 1 +
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
>> index fc4735f74f0f..5e08c026ca4a 100644
>> --- a/drivers/clk/qcom/clk-branch.c
>> +++ b/drivers/clk/qcom/clk-branch.c
>> @@ -153,3 +153,10 @@ const struct clk_ops clk_branch_simple_ops = {
>>   	.is_enabled = clk_is_enabled_regmap,
>>   };
>>   EXPORT_SYMBOL_GPL(clk_branch_simple_ops);
>> +
>> +const struct clk_ops clk_branch2_mdio_ops = {
>> +	.prepare = clk_branch2_enable,
>> +	.unprepare = clk_branch2_disable,
> 
> I see none of the clocks specify halt_check, which would imply that
> these two calls just turns into clk_enable_regmap() and
> clk_disable_regmap().
> 
> So, isn't this then equivalent to clk_branch_simple_ops?
> 
> Regards,
> Bjorn
> 

Thanks Bjorn for pointing this, i will add the the halt_check in the 
next patch set, halt_check is applicable.

>> +	.is_prepared = clk_is_enabled_regmap,
>> +};
>> +EXPORT_SYMBOL_GPL(clk_branch2_mdio_ops);
>> diff --git a/drivers/clk/qcom/clk-branch.h b/drivers/clk/qcom/clk-branch.h
>> index 0cf800b9d08d..4b006e8eec5e 100644
>> --- a/drivers/clk/qcom/clk-branch.h
>> +++ b/drivers/clk/qcom/clk-branch.h
>> @@ -85,6 +85,7 @@ extern const struct clk_ops clk_branch_ops;
>>   extern const struct clk_ops clk_branch2_ops;
>>   extern const struct clk_ops clk_branch_simple_ops;
>>   extern const struct clk_ops clk_branch2_aon_ops;
>> +extern const struct clk_ops clk_branch2_mdio_ops;
>>   
>>   #define to_clk_branch(_hw) \
>>   	container_of(to_clk_regmap(_hw), struct clk_branch, clkr)
>> -- 
>> 2.17.1
>>
