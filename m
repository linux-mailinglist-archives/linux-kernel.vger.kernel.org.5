Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03294755AB2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 06:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjGQEsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 00:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGQEsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 00:48:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CC3E55;
        Sun, 16 Jul 2023 21:48:21 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36H3uIB4007843;
        Mon, 17 Jul 2023 04:48:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cGwmHD8+T91qYYMYUM0G0clisp+LZ1ofLajeygGLwrU=;
 b=CNC0fU6OKDTIv+OUNCvS54fyQd4bA2c2zI/OASkx6c4N2PP6WpULp8QPgCQVQVoKj2Fo
 i1Tb7wO+FJURSLGSoaUYqIWkKY/wQPSTr1yLI7BKxxXVA3v9+W43Vq7CIM2fqDd7bnuu
 Rjf4OGkLDBoOqg2F9nlhbaGdVD7kul3Xe/bk56HlaLaak3lT4KvoCEn1vDj7Xt4yLdYF
 G3PmBhtr7/5JoDl8wjrgBI7s2DWhwbzrJqlObEuP49zfvsDpgD+68AcPfyHzwsVhK+mT
 LIRAhRTTt1D5gGHosoPhFIQzMraSRFeRv7cLYwJUnItZhoLIZcIwcNf1SMB3P2KMCVQg pA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3run1jjebp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 04:48:15 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36H4mErk007691
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 04:48:14 GMT
Received: from [10.216.12.245] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sun, 16 Jul
 2023 21:48:09 -0700
Message-ID: <faf315ee-bc5a-bd02-9d3c-0312989a24b3@quicinc.com>
Date:   Mon, 17 Jul 2023 10:18:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 5/5] thermal/drivers/tsens: Add IPQ5332 support
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>
References: <20230713052732.787853-1-quic_ipkumar@quicinc.com>
 <20230713052732.787853-6-quic_ipkumar@quicinc.com>
 <adc04328-d9c5-1c67-8396-08137334af1e@linaro.org>
Content-Language: en-US
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <adc04328-d9c5-1c67-8396-08137334af1e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: f1WjR0T1d-pW_XyxHpjyr61Q7p_GRaIu
X-Proofpoint-GUID: f1WjR0T1d-pW_XyxHpjyr61Q7p_GRaIu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_03,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307170043
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/15/2023 7:36 PM, Konrad Dybcio wrote:
> On 13.07.2023 07:27, Praveenkumar I wrote:
>> IPQ5332 uses tsens v2.3.3 IP and it is having combined interrupt.
>> It does not have RPM and kernel needs to take care of sensor
>> enablement, calibration. Hence introduced new feature_config,
>> ops and data for IPQ5332.
>>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> ---
>> [v3]:
>> 	No changes.
>> [v2]:
>> 	Added tsens_features for ipq5332 with VER_2_X_NO_RPM. Used
>> 	hw_ids to mention the available sensors. Dropped v2 in
>> 	ops_ipq5332.
>>
>>   drivers/thermal/qcom/tsens-v2.c | 25 +++++++++++++++++++++++++
>>   drivers/thermal/qcom/tsens.c    |  3 +++
>>   drivers/thermal/qcom/tsens.h    |  2 +-
>>   3 files changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
>> index 781595a9a622..e25d9d34e519 100644
>> --- a/drivers/thermal/qcom/tsens-v2.c
>> +++ b/drivers/thermal/qcom/tsens-v2.c
>> @@ -62,6 +62,17 @@ static struct tsens_features ipq8074_feat = {
>>   	.trip_max_temp	= 204000,
>>   };
>>   
>> +static struct tsens_features ipq5332_feat = {
>> +	.ver_major	= VER_2_X_NO_RPM,
>> +	.crit_int	= 1,
>> +	.combo_int	= 1,
>> +	.adc		= 0,
>> +	.srot_split	= 1,
>> +	.max_sensors	= 16,
>> +	.trip_min_temp	= 0,
>> +	.trip_max_temp	= 204000,
> 204 degrees Celcius?
Yes, it is 204 degrees celcius as like ipq8074.
> Konrad
>> +};
>> +
>>   static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>>   	/* ----- SROT ------ */
>>   	/* VERSION */
>> @@ -262,6 +273,20 @@ struct tsens_plat_data data_ipq8074 = {
>>   	.fields	= tsens_v2_regfields,
>>   };
>>   
>> +static const struct tsens_ops ops_ipq5332 = {
>> +	.init		= init_tsens_v2_no_rpm,
>> +	.get_temp	= get_temp_tsens_valid,
>> +	.calibrate	= tsens_v2_calibration,
>> +};
>> +
>> +struct tsens_plat_data data_ipq5332 = {
>> +	.num_sensors	= 5,
>> +	.ops		= &ops_ipq5332,
>> +	.hw_ids		= (unsigned int []){11, 12, 13, 14, 15},
>> +	.feat		= &ipq5332_feat,
>> +	.fields		= tsens_v2_regfields,
>> +};
>> +
>>   /* Kept around for backward compatibility with old msm8996.dtsi */
>>   struct tsens_plat_data data_8996 = {
>>   	.num_sensors	= 13,
>> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
>> index 9dc0c2150948..af58a94628a8 100644
>> --- a/drivers/thermal/qcom/tsens.c
>> +++ b/drivers/thermal/qcom/tsens.c
>> @@ -1106,6 +1106,9 @@ static const struct of_device_id tsens_table[] = {
>>   	}, {
>>   		.compatible = "qcom,ipq8074-tsens",
>>   		.data = &data_ipq8074,
>> +	}, {
>> +		.compatible = "qcom,ipq5332-tsens",
>> +		.data = &data_ipq5332,
>>   	}, {
>>   		.compatible = "qcom,mdm9607-tsens",
>>   		.data = &data_9607,
>> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
>> index b2e8f0f2b466..1dde363914cd 100644
>> --- a/drivers/thermal/qcom/tsens.h
>> +++ b/drivers/thermal/qcom/tsens.h
>> @@ -648,6 +648,6 @@ extern struct tsens_plat_data data_8226, data_8909, data_8916, data_8939, data_8
>>   extern struct tsens_plat_data data_tsens_v1, data_8976, data_8956;
>>   
>>   /* TSENS v2 targets */
>> -extern struct tsens_plat_data data_8996, data_ipq8074, data_tsens_v2;
>> +extern struct tsens_plat_data data_8996, data_ipq8074, data_ipq5332, data_tsens_v2;
>>   
>>   #endif /* __QCOM_TSENS_H__ */
