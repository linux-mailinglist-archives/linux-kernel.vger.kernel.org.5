Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE2E76C8D5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbjHBI5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjHBI5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:57:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D557F5;
        Wed,  2 Aug 2023 01:57:20 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3726DM2V030516;
        Wed, 2 Aug 2023 08:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eJFg7zYisQAi1WB3ybXV8vNe+po1sL08Fx5ZL/kI5jw=;
 b=Nqyqq21rXvk2+mc/joRkQ/BAC+rXYiFdXT9M/Gej2Q8VdR1w6nbP/kcSfOw/OlZhvUpe
 vFLuIUechuIeNLZsBYRSrqIFB2MuJGH5LbkUrEOqpOHwti6laL44VSEFdjxrO+mffT1C
 prJBNw5Y0aTL4SGN06tnokn3erubclPVc+N09XwyVf3A/mgSiD00sqvj0TtlLeB/h0sd
 sP494zd7ACQUAbEmq3IKhJ8ffTArF2VMFy/trYSciz3zh+3NkiCrAMTPvCAJxdVogbUT
 cQtt8gjmIDG9nPw6cPb75FNJrDGZBOMh4KBQ8IasPFeKV/TcKVIZVfsz6ssB8MeKuAE7 5g== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s76jv1rts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 08:57:14 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3728vDMe023993
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 08:57:13 GMT
Received: from [10.214.67.128] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 2 Aug
 2023 01:57:09 -0700
Message-ID: <9c52889a-eb46-f3a5-e669-4783cb75da42@quicinc.com>
Date:   Wed, 2 Aug 2023 14:27:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 6/6] soc: qcom: llcc: Add QDU1000 and QRU1000 LLCC
 support
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230724084155.8682-1-quic_kbajaj@quicinc.com>
 <20230724084155.8682-7-quic_kbajaj@quicinc.com>
 <34868b94-abe3-aa67-fb76-35d9a2481cfd@quicinc.com>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <34868b94-abe3-aa67-fb76-35d9a2481cfd@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: To7Kn-lLFmMMz_y2anK7k_Jo_vXfFS5O
X-Proofpoint-GUID: To7Kn-lLFmMMz_y2anK7k_Jo_vXfFS5O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_03,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020079
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/2023 6:15 PM, Mukesh Ojha wrote:
>
>
> On 7/24/2023 2:11 PM, Komal Bajaj wrote:
>> Add LLCC configuration data for QDU1000 and QRU1000 SoCs.
>>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
>>   drivers/soc/qcom/llcc-qcom.c | 67 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 67 insertions(+)
>>
>> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
>> index 228ffb4a8971..95766260b3b8 100644
>> --- a/drivers/soc/qcom/llcc-qcom.c
>> +++ b/drivers/soc/qcom/llcc-qcom.c
>> @@ -364,6 +364,36 @@ static const struct llcc_slice_config 
>> sm8550_data[] =  {
>>       {LLCC_VIDVSP,   28,  256, 4, 1, 0xFFFFFF, 0x0,   0, 0, 0, 0, 0, 
>> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
>>   };
>>   +static const struct llcc_slice_config qdu1000_data_2ch[] = {
>> +    { LLCC_MDMHPGRW, 7, 512, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +    { LLCC_MODHW,    9, 256, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +    { LLCC_MDMPNG,  21, 256, 0, 1, 0x3,   0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +    { LLCC_ECC,     26, 512, 3, 1, 0xffc, 0x0, 0, 0, 0, 0, 1, 0, 0 },
>> +    { LLCC_MODPE,   29, 256, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +    { LLCC_APTCM,   30, 256, 3, 1, 0x0,   0xC, 1, 0, 0, 1, 0, 0, 0 },
>> +    { LLCC_WRCACHE, 31, 128, 1, 1, 0x3,   0x0, 0, 0, 0, 0, 1, 0, 0 },
>> +};
>> +
>> +static const struct llcc_slice_config qdu1000_data_4ch[] = {
>> +    { LLCC_MDMHPGRW, 7, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +    { LLCC_MODHW,    9, 512,  1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +    { LLCC_MDMPNG,  21, 512,  0, 1, 0x3,   0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +    { LLCC_ECC,     26, 1024, 3, 1, 0xffc, 0x0, 0, 0, 0, 0, 1, 0, 0 },
>> +    { LLCC_MODPE,   29, 512,  1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +    { LLCC_APTCM,   30, 512,  3, 1, 0x0,   0xC, 1, 0, 0, 1, 0, 0, 0 },
>> +    { LLCC_WRCACHE, 31, 256,  1, 1, 0x3,   0x0, 0, 0, 0, 0, 1, 0, 0 },
>> +};
>> +
>> +static const struct llcc_slice_config qdu1000_data_8ch[] = {
>> +    { LLCC_MDMHPGRW, 7, 2048, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +    { LLCC_MODHW,    9, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +    { LLCC_MDMPNG,  21, 1024, 0, 1, 0x3,   0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +    { LLCC_ECC,     26, 2048, 3, 1, 0xffc, 0x0, 0, 0, 0, 0, 1, 0, 0 },
>> +    { LLCC_MODPE,   29, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0, 0 },
>> +    { LLCC_APTCM,   30, 1024, 3, 1, 0x0,   0xC, 1, 0, 0, 1, 0, 0, 0 },
>> +    { LLCC_WRCACHE, 31, 512,  1, 1, 0x3,   0x0, 0, 0, 0, 0, 1, 0, 0 },
>> +};
>> +
>>   static const struct llcc_edac_reg_offset llcc_v1_edac_reg_offset = {
>>       .trp_ecc_error_status0 = 0x20344,
>>       .trp_ecc_error_status1 = 0x20348,
>> @@ -551,6 +581,37 @@ static const struct qcom_llcc_config 
>> sm8550_cfg[] = {
>>       },
>>   };
>>   +static const struct qcom_llcc_config qdu1000_cfg[] = {
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
>>   static const struct qcom_sct_config sc7180_cfgs = {
>>       .llcc_config    = sc7180_cfg,
>>       .num_cfgs    = 1,
>> @@ -611,6 +672,11 @@ static const struct qcom_sct_config sm8550_cfgs = {
>>       .num_cfgs    = 1,
>>   };
>>   +static const struct qcom_sct_config qdu1000_cfgs = {
>> +    .llcc_config    = qdu1000_cfg,
>> +    .num_cfgs    = 1,
>
>
> Should not this be 4 ?

Yes, it should be 4. Thanks for pointing it out.

-Komal

>
> -Mukesh
>
>> +};
>> +
>>   static struct llcc_drv_data *drv_data = (void *) -EPROBE_DEFER;
>>     /**
>> @@ -1167,6 +1233,7 @@ static int qcom_llcc_probe(struct 
>> platform_device *pdev)
>>   }
>>     static const struct of_device_id qcom_llcc_of_match[] = {
>> +    { .compatible = "qcom,qdu1000-llcc", .data = &qdu1000_cfgs},
>>       { .compatible = "qcom,sc7180-llcc", .data = &sc7180_cfgs },
>>       { .compatible = "qcom,sc7280-llcc", .data = &sc7280_cfgs },
>>       { .compatible = "qcom,sc8180x-llcc", .data = &sc8180x_cfgs },

