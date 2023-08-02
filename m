Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B0D76C8CF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjHBIzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjHBIy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:54:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CFB194;
        Wed,  2 Aug 2023 01:54:55 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3723TGnQ007052;
        Wed, 2 Aug 2023 08:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=WYYBV28A0cHmyNqt9zcAmtNFRR1sfaLhQFS5OQHy5VM=;
 b=bDa74WHMActTcv6ODNkDFGTjjmpV/A1ScswiavbX0tzCTFwEKQOFb7tkM84jAVhgFhXA
 1BGahHIBzBObXFgKeXjYPE1HF5gYVKqRAK98Wqcm7upLcTGu/8KHtvMB2ehkYaFsp2Z4
 YjW1GrKXeUTIvWeye2OIDKqaywVs12tqmXV1F0WylfcSYAezp1AzscdmG5IhjsacR+UV
 4l45fh1mku8q6yrtofV4t+Q8JtAedRP/BXvK4X/iami+M8J9DT/W4BwoPhB7FTnmJY/i
 l4y+dlOicvaqIElsopt3yfJde6R2TKctlsLoidgM8ZJwCpQ5x7jsLSxoNf7r4lCKNT87 eg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6rhaumpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 08:54:52 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3728sqWF018881
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 08:54:52 GMT
Received: from [10.214.67.128] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 2 Aug
 2023 01:54:48 -0700
Message-ID: <bcd9c1d4-61d8-3339-93fb-e7eca1f01fb3@quicinc.com>
Date:   Wed, 2 Aug 2023 14:24:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 4/6] soc: qcom: Add LLCC support for multi channel DDR
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230724084155.8682-1-quic_kbajaj@quicinc.com>
 <20230724084155.8682-5-quic_kbajaj@quicinc.com>
 <6971e2d5-e97d-cb60-473a-e1966e3818cb@quicinc.com>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <6971e2d5-e97d-cb60-473a-e1966e3818cb@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CxTaxcV0khmGv6wYjMO3OneY_Xbi2SHc
X-Proofpoint-ORIG-GUID: CxTaxcV0khmGv6wYjMO3OneY_Xbi2SHc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_03,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020079
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/2023 6:10 PM, Mukesh Ojha wrote:
>
>
> On 7/24/2023 2:11 PM, Komal Bajaj wrote:
>> Add LLCC support for multi channel DDR configuration
>> based on a feature register.
>>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
>>   drivers/soc/qcom/llcc-qcom.c | 26 +++++++++++++++++++++++++-
>>   1 file changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
>> index 321f8d2079f7..1d2b08dfecea 100644
>> --- a/drivers/soc/qcom/llcc-qcom.c
>> +++ b/drivers/soc/qcom/llcc-qcom.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>>   #include <linux/mutex.h>
>> +#include <linux/nvmem-consumer.h>
>>   #include <linux/of.h>
>>   #include <linux/of_device.h>
>>   #include <linux/regmap.h>
>> @@ -997,6 +998,19 @@ static int qcom_llcc_cfg_program(struct 
>> platform_device *pdev,
>>       return ret;
>>   }
>>   +static int qcom_llcc_get_cfg_index(struct platform_device *pdev, 
>> u8 *cfg_index)
>> +{
>> +    int ret;
>> +
>> +    ret = nvmem_cell_read_u8(&pdev->dev, "multi-chan-ddr", cfg_index);
>> +    if (ret == -ENOENT || ret == -EOPNOTSUPP) {
>> +        *cfg_index = 0;
>> +        return 0;
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>>   static int qcom_llcc_remove(struct platform_device *pdev)
>>   {
>>       /* Set the global pointer to a error code to avoid referencing 
>> it */
>> @@ -1033,6 +1047,7 @@ static int qcom_llcc_probe(struct 
>> platform_device *pdev)
>>       const struct qcom_llcc_config *cfg;
>>       const struct llcc_slice_config *llcc_cfg;
>>       u32 sz;
>> +    u8 cfg_index;
>>       u32 version;
>>       struct regmap *regmap;
>>   @@ -1050,7 +1065,16 @@ static int qcom_llcc_probe(struct 
>> platform_device *pdev)
>>       }
>>         cfgs = of_device_get_match_data(&pdev->dev);
>> -    cfg = &cfgs->llcc_config[0];
>> +    ret = qcom_llcc_get_cfg_index(pdev, &cfg_index);
>> +     if (ret)
>
> alignment.. ?

Thanks for pointing it out. Will fix it in the next series.

Thanks
Komal

>
> -Mukesh
>
>> +        goto err;
>> +
>> +    if (cfg_index >= cfgs->num_cfgs) {
>> +        ret = -EINVAL;
>> +        goto err;
>> +    }
>> +
>> +    cfg = &cfgs->llcc_config[cfg_index];
>>         ret = regmap_read(regmap, 
>> cfg->reg_offset[LLCC_COMMON_STATUS0], &num_banks);
>>       if (ret)

