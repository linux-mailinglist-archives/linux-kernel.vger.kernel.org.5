Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528AA7EDD9F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 10:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbjKPJcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 04:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjKPJcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 04:32:14 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B361A3;
        Thu, 16 Nov 2023 01:32:11 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG96aDp007732;
        Thu, 16 Nov 2023 09:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dUkYPespAQaJg5xtS6/bbkbiwvOohnbVFTSW2JL3fU0=;
 b=YclG/s+0KZsF7nwanuVTT/4FMfvSuo+If08jc5rbKwhyVQrcd0lC8Tkrexx+/KEMJX3K
 Cr+eRRC7/igfkxaoyUXUa2m+6BogYliQvFfjR7KOTWfkLDML508V+1xFDnlDaKdaMWNB
 61vbpvq5huZVRoVRRcoVgrA3edo4XMwR4GCMZcMZ48ftwXev1hbd9Alqb4a6TlwyBv5q
 OD84AeMc4+BoYcbpOld1C2o3j2wju1Htp9MtqTXES8JWcPyxVQZ8shbgP7In1JvW0Byw
 ciOC4j1SmGM8ZmajLoGsXrLUV1Dpav6y7Q7HLlFqwIqHOYGoxG0mP/HIm1N2y8HXHZql kQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ud5fhhb65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 09:32:07 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AG9W5aO003619
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 09:32:05 GMT
Received: from [10.218.19.46] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 16 Nov
 2023 01:32:01 -0800
Message-ID: <91261b98-6bbd-b1d8-4fc8-96387bbcaba4@quicinc.com>
Date:   Thu, 16 Nov 2023 15:01:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 3/4] clk: qcom: videocc-sm8150: Update the
 video_pll0_config
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20231110065029.2117212-1-quic_skakitap@quicinc.com>
 <20231110065029.2117212-4-quic_skakitap@quicinc.com>
 <8457b113-bef2-47e4-a138-0f92a4f5798a@linaro.org>
From:   "Satya Priya Kakitapalli (Temp)" <quic_skakitap@quicinc.com>
In-Reply-To: <8457b113-bef2-47e4-a138-0f92a4f5798a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tgnYhZD5NZI0_OnC_ScqY51i_j5nejGy
X-Proofpoint-ORIG-GUID: tgnYhZD5NZI0_OnC_ScqY51i_j5nejGy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_07,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160076
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/10/2023 4:46 PM, Bryan O'Donoghue wrote:
> On 10/11/2023 06:50, Satya Priya Kakitapalli wrote:
>> Update the video_pll0_config to configure the test_ctl_hi and
>> test_ctl_hi1 values.
>>
>> Fixes: 5658e8cf1a8a ("clk: qcom: add video clock controller driver 
>> for SM8150")
>> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>> ---
>>   drivers/clk/qcom/videocc-sm8150.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/videocc-sm8150.c 
>> b/drivers/clk/qcom/videocc-sm8150.c
>> index 6a5f89f53da8..ddfe784fb9e1 100644
>> --- a/drivers/clk/qcom/videocc-sm8150.c
>> +++ b/drivers/clk/qcom/videocc-sm8150.c
>> @@ -33,6 +33,8 @@ static struct alpha_pll_config video_pll0_config = {
>>       .config_ctl_val = 0x20485699,
>>       .config_ctl_hi_val = 0x00002267,
>>       .config_ctl_hi1_val = 0x00000024,
>> +    .test_ctl_hi_val = 0x00000002,
>> +    .test_ctl_hi1_val = 0x00000020,
>>       .user_ctl_val = 0x00000000,
>>       .user_ctl_hi_val = 0x00000805,
>>       .user_ctl_hi1_val = 0x000000D0,
>
> It would be nice to get a better description of this change.
>
> Reading this - I can see it does an update but, the commit log should 
> contain what it is updating and why plus what effect the update will 
> have.
>
> Please update the commit log to capture that data and +cc me on the V2.
>

Sure will check and update.


Thanks,

Satya Priya

> ---
> bod
