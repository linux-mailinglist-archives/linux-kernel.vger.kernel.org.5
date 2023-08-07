Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C670772330
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjHGL4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjHGL4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:56:32 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A627129;
        Mon,  7 Aug 2023 04:56:30 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 377BuFm8025297;
        Mon, 7 Aug 2023 11:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2wRweqfbsWCbqbe7C3KfbXQf9okmGrunhzinTVTmvtM=;
 b=A6D8gVWxXQH9nrW6CQgxhBG7CazM6VnMpy8WFbPjgckNG6PzYRsH+go4kpaavar8am9X
 r9pFAj32sRI/XCgTjxtGRC5a8jPVWcmXRx1sfzFD2w3QQGn2rfAwnUT0EIpnQMtDeuOJ
 9v3MuRPq563Kg1DHY2R+O5m0GXzXyoqJTWf6Fq5q9+E5z99lI8ivUapy47Ug713BuAgY
 vokkkhFRCQ9P0khssgZl4FHhsqyCqWQGycwqu/cQW+FJV6PcerFKuIK1z5zb9fkc++zH
 Fi8KOJz7gZQuDN8LIWx1QGpr1Kyoo99eI3pao0z7I6nrk+txJcJ9zpVKPawWMhno/A/7 pQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s9drrkf56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 11:56:24 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 377BuNQn030354
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Aug 2023 11:56:23 GMT
Received: from [10.214.67.128] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 7 Aug
 2023 04:56:19 -0700
Message-ID: <ff316b1f-d4b5-6a02-b4e3-d73e122197ff@quicinc.com>
Date:   Mon, 7 Aug 2023 17:26:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v6 6/6] soc: qcom: llcc: Add QDU1000 and QRU1000 LLCC
 support
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230802091429.20892-1-quic_kbajaj@quicinc.com>
 <20230802091429.20892-7-quic_kbajaj@quicinc.com>
 <c25456de-4d5a-033f-3328-6183c754b08f@quicinc.com>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <c25456de-4d5a-033f-3328-6183c754b08f@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: V6h49Ztb08ckKdbigEVE8zW5ICorcuO0
X-Proofpoint-GUID: V6h49Ztb08ckKdbigEVE8zW5ICorcuO0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_11,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 spamscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070110
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/2023 6:39 PM, Mukesh Ojha wrote:
>
>
> On 8/2/2023 2:44 PM, Komal Bajaj wrote:
>> Add LLCC configuration data for QDU1000 and QRU1000 SoCs.
>>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
>>   drivers/soc/qcom/llcc-qcom.c | 67 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 67 insertions(+)
>>
>> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
>> index 315f7a1b90aa..8e1b2399700d 100644
>> --- a/drivers/soc/qcom/llcc-qcom.c
>> +++ b/drivers/soc/qcom/llcc-qcom.c
>> @@ -366,6 +366,36 @@ static const struct llcc_slice_config 
>> sm8550_data[] =  {
>>       {LLCC_VIDVSP,   28,  256, 4, 1, 0xFFFFFF, 0x0,   0, 0, 0, 0, 0, 
>> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
>>   };
>>
>> +static const struct llcc_slice_config qdu1000_data_2ch[] = {
>> +    { LLCC_MDMHPGRW, 7, 512, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +    { LLCC_MODHW,    9, 256, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +    { LLCC_MDMPNG,  21, 256, 0, 1, 0x3,   0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +    { LLCC_ECC,     26, 512, 3, 1, 0xffc, 0x0, 0, 0, 0, 0, 1, 0, 0 },
>> +    { LLCC_MODPE,   29, 256, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +    { LLCC_APTCM,   30, 256, 3, 1, 0x0,   0xc, 1, 0, 0, 1, 0, 0, 0 },
>> +    { LLCC_WRCACHE, 31, 128, 1, 1, 0x3,   0x0, 0, 0, 0, 0, 1, 0, 0 },
>> +};
>> +
>> +static const struct llcc_slice_config qdu1000_data_4ch[] = {
>> +    { LLCC_MDMHPGRW, 7, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +    { LLCC_MODHW,    9, 512,  1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +    { LLCC_MDMPNG,  21, 512,  0, 1, 0x3,   0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +    { LLCC_ECC,     26, 1024, 3, 1, 0xffc, 0x0, 0, 0, 0, 0, 1, 0, 0 },
>> +    { LLCC_MODPE,   29, 512,  1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +    { LLCC_APTCM,   30, 512,  3, 1, 0x0,   0xc, 1, 0, 0, 1, 0, 0, 0 },
>> +    { LLCC_WRCACHE, 31, 256,  1, 1, 0x3,   0x0, 0, 0, 0, 0, 1, 0, 0 },
>> +};
>> +
>> +static const struct llcc_slice_config qdu1000_data_8ch[] = {
>> +    { LLCC_MDMHPGRW, 7, 2048, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +    { LLCC_MODHW,    9, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +    { LLCC_MDMPNG,  21, 1024, 0, 1, 0x3,   0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +    { LLCC_ECC,     26, 2048, 3, 1, 0xffc, 0x0, 0, 0, 0, 0, 1, 0, 0 },
>> +    { LLCC_MODPE,   29, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +    { LLCC_APTCM,   30, 1024, 3, 1, 0x0,   0xc, 1, 0, 0, 1, 0, 0, 0 },
>> +    { LLCC_WRCACHE, 31, 512,  1, 1, 0x3,   0x0, 0, 0, 0, 0, 1, 0, 0 },
>> +};
>> +
>>   static const struct llcc_edac_reg_offset llcc_v1_edac_reg_offset = {
>>       .trp_ecc_error_status0 = 0x20344,
>>       .trp_ecc_error_status1 = 0x20348,
>> @@ -432,6 +462,37 @@ static const u32 llcc_v2_1_reg_offset[] = {
>>       [LLCC_COMMON_STATUS0]    = 0x0003400c,
>>   };
>>
>> +static const struct qcom_llcc_config qdu1000_cfg[] = {
>> +    {
>> +        .sct_data       = qdu1000_data_8ch,
>> +        .size        = ARRAY_SIZE(qdu1000_data_8ch),
>> +        .need_llcc_cfg    = true,
>> +        .reg_offset    = llcc_v2_1_reg_offset,
>> +        .edac_reg_offset = &llcc_v2_1_edac_reg_offset,
>> +    },
>> +    {
>> +        .sct_data       = qdu1000_data_4ch,
>> +        .size           = ARRAY_SIZE(qdu1000_data_4ch),
>> +        .need_llcc_cfg  = true,
>> +        .reg_offset     = llcc_v2_1_reg_offset,
>> +        .edac_reg_offset = &llcc_v2_1_edac_reg_offset,
>> +    },
>> +    {
>> +        .sct_data       = qdu1000_data_4ch,
>> +        .size           = ARRAY_SIZE(qdu1000_data_4ch),
>> +        .need_llcc_cfg  = true,
>> +        .reg_offset     = llcc_v2_1_reg_offset,
>> +        .edac_reg_offset = &llcc_v2_1_edac_reg_offset,
>> +    },
>> +    {
>> +        .sct_data       = qdu1000_data_2ch,
>> +        .size           = ARRAY_SIZE(qdu1000_data_2ch),
>> +        .need_llcc_cfg  = true,
>> +        .reg_offset     = llcc_v2_1_reg_offset,
>> +        .edac_reg_offset = &llcc_v2_1_edac_reg_offset,
>> +    },
>> +};
>> +
>>   static const struct qcom_llcc_config sc7180_cfg[] = {
>>       {
>>           .sct_data    = sc7180_data,
>> @@ -553,6 +614,11 @@ static const struct qcom_llcc_config 
>> sm8550_cfg[] = {
>>       },
>>   };
>>
>> +static const struct qcom_sct_config qdu1000_cfgs = {
>> +    .llcc_config    = qdu1000_cfg,
>> +    .num_config    = 4,
>
> looks like you missed to take konrad suggestion here
>
> https://lore.kernel.org/lkml/2a68b891-b855-1998-3eaf-a21473da0851@linaro.org/ 
>

Yes, I missed that. Thanks for catching it.

>
> -Mukesh
>
>> +};
>> +
>>   static const struct qcom_sct_config sc7180_cfgs = {
>>       .llcc_config    = sc7180_cfg,
>>       .num_config    = ARRAY_SIZE(sc7180_cfg),
>> @@ -1171,6 +1237,7 @@ static int qcom_llcc_probe(struct 
>> platform_device *pdev)
>>   }
>>
>>   static const struct of_device_id qcom_llcc_of_match[] = {
>> +    { .compatible = "qcom,qdu1000-llcc", .data = &qdu1000_cfgs},
>>       { .compatible = "qcom,sc7180-llcc", .data = &sc7180_cfgs },
>>       { .compatible = "qcom,sc7280-llcc", .data = &sc7280_cfgs },
>>       { .compatible = "qcom,sc8180x-llcc", .data = &sc8180x_cfgs },
>> -- 
>> 2.41.0
>>

