Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD362802A23
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 03:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbjLDCCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 21:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjLDCCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 21:02:53 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476D2C3;
        Sun,  3 Dec 2023 18:02:59 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B41xRFm007171;
        Mon, 4 Dec 2023 02:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=p57vtO1ik2rrzvNr6cjj8q52qSne8FWjtX9ybVgpZSY=;
 b=HF4JFiem4OX8l/clUUft6+FpgwcuSF81VL/tERCt1J8oEvvotnk1IXlcVoV0+W7+p6pC
 6TCc8y3344T/KAd9ez20puwXaAuvexMH/FC+O4pK+gSjfU/+uFB5zLoNTdC81wtO5mzA
 TZiKF27bRCELsBbErFayvswxgewNPWM0jq40UgGEOWN7+z/+pVxr/HLMqqem+NTK0gAe
 KSm/0owgDIMAMdPSPOwg9Ncgch5/oJrMh2s0FOaDgR7zo59P8vHrarR0pb+T8yUp4F4H
 uZPmhll5VKgnyXU/HNNeA1HRjLZ04188i4C/brLGZzdGDa3BAD3+CTNRZWzXXh3Ln2My jw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uqsxw2w6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 02:02:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B422sQ4024804
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Dec 2023 02:02:54 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 3 Dec
 2023 18:02:50 -0800
Message-ID: <64fd99b9-51f1-4288-9789-d4f71f7d9dd2@quicinc.com>
Date:   Mon, 4 Dec 2023 10:02:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] pinctrl: qcom: sm4450: correct incorrect address
 offset
To:     Bjorn Andersson <andersson@kernel.org>
CC:     <agross@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>
References: <20231130024046.25938-1-quic_tengfan@quicinc.com>
 <20231130024046.25938-5-quic_tengfan@quicinc.com>
 <dx62durg3wmqviqdpecdqprd5wwkg4i7n5tgcab55axzssdeel@ftt35c6td2sh>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <dx62durg3wmqviqdpecdqprd5wwkg4i7n5tgcab55axzssdeel@ftt35c6td2sh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2QTaamtn9KyXTNVxpVAjs_cF0LFeMMVu
X-Proofpoint-GUID: 2QTaamtn9KyXTNVxpVAjs_cF0LFeMMVu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-03_24,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 malwarescore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040013
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 12/2/2023 5:36 AM, Bjorn Andersson 写道:
> On Thu, Nov 30, 2023 at 10:40:46AM +0800, Tengfei Fan wrote:
>> The address offset of 0x100000 is already provided in SM4450 DTSI, so
>> subtract 0x100000 from the offset which used by ufs and sdc.
>>
> 
> As Konrad points out, please fix the broken patch, don't add a separate
> fix in the same series.
Sure, I will do this as comments.
> 
>> Suggested-by: Can Guo <quic_cang@quicinc.com>
> 
> We unfortunately don't have a way to give credit to those providing
> review feedback, so omit this when fixing patch #2.
Sure, I will omit this in next version patch series.
> 
> Regards,
> Bjorn
> 
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   drivers/pinctrl/qcom/pinctrl-sm4450.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/pinctrl/qcom/pinctrl-sm4450.c b/drivers/pinctrl/qcom/pinctrl-sm4450.c
>> index 49e2e3a7a9cb..5496f955ed2a 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-sm4450.c
>> +++ b/drivers/pinctrl/qcom/pinctrl-sm4450.c
>> @@ -936,14 +936,14 @@ static const struct msm_pingroup sm4450_groups[] = {
>>   	[133] = PINGROUP(133, _, phase_flag, _, _, _, _, _, _, _),
>>   	[134] = PINGROUP(134, tsense_pwm1_out, tsense_pwm2_out, _, _, _, _, _, _, _),
>>   	[135] = PINGROUP(135, _, phase_flag, _, _, _, _, _, _, _),
>> -	[136] = UFS_RESET(ufs_reset, 0x197000),
>> -	[137] = SDC_QDSD_PINGROUP(sdc1_rclk, 0x18c004, 0, 0),
>> -	[138] = SDC_QDSD_PINGROUP(sdc1_clk, 0x18c000, 13, 6),
>> -	[139] = SDC_QDSD_PINGROUP(sdc1_cmd, 0x18c000, 11, 3),
>> -	[140] = SDC_QDSD_PINGROUP(sdc1_data, 0x18c000, 9, 0),
>> -	[141] = SDC_QDSD_PINGROUP(sdc2_clk, 0x18f000, 14, 6),
>> -	[142] = SDC_QDSD_PINGROUP(sdc2_cmd, 0x18f000, 11, 3),
>> -	[143] = SDC_QDSD_PINGROUP(sdc2_data, 0x18f000, 9, 0),
>> +	[136] = UFS_RESET(ufs_reset, 0x97000),
>> +	[137] = SDC_QDSD_PINGROUP(sdc1_rclk, 0x8c004, 0, 0),
>> +	[138] = SDC_QDSD_PINGROUP(sdc1_clk, 0x8c000, 13, 6),
>> +	[139] = SDC_QDSD_PINGROUP(sdc1_cmd, 0x8c000, 11, 3),
>> +	[140] = SDC_QDSD_PINGROUP(sdc1_data, 0x8c000, 9, 0),
>> +	[141] = SDC_QDSD_PINGROUP(sdc2_clk, 0x8f000, 14, 6),
>> +	[142] = SDC_QDSD_PINGROUP(sdc2_cmd, 0x8f000, 11, 3),
>> +	[143] = SDC_QDSD_PINGROUP(sdc2_data, 0x8f000, 9, 0),
>>   };
>>   
>>   static const struct msm_gpio_wakeirq_map sm4450_pdc_map[] = {
>> -- 
>> 2.17.1
>>

-- 
Thx and BRs,
Tengfei Fan
