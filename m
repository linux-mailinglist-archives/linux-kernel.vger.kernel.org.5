Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749D47D29EC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbjJWGJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjJWGJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:09:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4820ED6E;
        Sun, 22 Oct 2023 23:09:23 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39N4jJhk028372;
        Mon, 23 Oct 2023 06:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RVwdo42PwJpIdRXFedIcwEKv3gDyeNTdEVeioPj9xUg=;
 b=fpXluilZIrrT9BYQolSV9M6f8axBCVZLRpmOEPMZI07DkZQfhw3mhd4Lkt3aoRe4Ts9m
 FxPkc2K/QAcebV43JAcpiTlGSJ2YYpynER1FHeZbQTtiImt07pq94sqEueDCcP2AqZ8Q
 Ke2cnoqDwZGxm/a+PLzTUD+drDN1usEPrXHaDUjc4qQ0GPkAbzj8YSxBcYZbRRveYVh6
 E+9b8+e63vRnlU2T6CPuFw2nGt7A/COETu7tXMktDferpN+2kNuZ2hWXhCgy2V8pUBpM
 PMtZo7+1cfjTp9R5GB0jWj6OPe3DNPWyprqvwWZqt3XpeI970TiiQbxzwFylYB9Cmfr9 oA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv5ndu8yw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 06:08:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39N68rWS025286
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 06:08:53 GMT
Received: from [10.216.48.174] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Sun, 22 Oct
 2023 23:08:41 -0700
Message-ID: <4bb709ad-c5ca-955b-92eb-2825475b0da5@quicinc.com>
Date:   Mon, 23 Oct 2023 11:38:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 01/11] iio: adc: Update bindings for ADC7 name used on
 QCOM PMICs
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <sboyd@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_kamalw@quicinc.com>,
        <quic_jestar@quicinc.com>, <marijn.suijten@somainline.org>,
        <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Zhang Rui" <rui.zhang@intel.com>, Luca Weiss <luca@z3ntu.xyz>,
        <linux-iio@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     <linux-arm-msm-owner@vger.kernel.org>
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
 <20230708072835.3035398-2-quic_jprakash@quicinc.com>
 <935c14fd-e87f-e89b-f641-7fb529bc7e50@linaro.org>
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <935c14fd-e87f-e89b-f641-7fb529bc7e50@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yHAkkRlkv-2nTBhgwmke_PtZhQkO3zEm
X-Proofpoint-ORIG-GUID: yHAkkRlkv-2nTBhgwmke_PtZhQkO3zEm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_03,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310230053
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Sorry for the late reply, I could not get back earlier as I got occupied 
with other work till now. I have addressed your comments inline.

On 7/9/2023 10:47 PM, Krzysztof Kozlowski wrote:
> On 08/07/2023 09:28, Jishnu Prakash wrote:
>> The name used initially for this version of Qualcomm Technologies, Inc.
>> PMIC ADC was ADC7, following the convention of calling the PMIC generation
>> PMIC7. However, the names were later amended internally to ADC5 Gen2 and
>> PMIC5 Gen2. In addition, the latest PMIC generation now is known as
>> PMIC5 Gen3 with ADC5 Gen3 supported on it. With this addition, it makes more
>> sense to correct the name for this version of ADCs to ADC5 Gen2 from ADC7.
>> Since this affects ADC devices across some PMICs, update the names accordingly.
>>
>> In order to avoid breaking the existing implementations of ADC7, add
>> support for ADC5 Gen2 first now and remove the ADC7 support in a later
>> patch.
> I don't understand and I do not see it explained, why do you remove
> ADC7. The patch is also doing way too many things at the same time...

In patches 1-5 of this series, I intended to update all existing support 
for ADC7 by renaming it to ADC5 Gen2 to match the correct name used 
internally. In addition, since I am adding support for ADC5 Gen3 in 
patches 6 and 7, I thought it would make sense to rename this older 
peripheral, to make it more obvious to others that this version lies 
between ADC5 and ADC5 Gen3.

I have also left a comment in one earlier upstream change for PMIC5 Gen2 
ADC_TM (closely related to ADC5 Gen2) where I mentioned the same 
briefly, when I was asked why we were not naming it ADC_TM7: 
https://lore.kernel.org/linux-arm-msm/111fcc56-6441-3300-8d96-029ef8600702@quicinc.com/.

Is it fine if we keep the old compatible for adc7, marking it 
deprecated, while adding the new compatible for adc5-gen2 and updating 
the bindings, driver and devicetree completely to use gen2 (while not 
replacing instances of the old compatible)?

Or should we also keep the old bindings with macros using the adc7 name 
instead of directly replacing them with new macros using the adc5 gen2 
name, to avoid the possibility breaking the devicetree for some users?

>
>> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
>> ---
>>   .../bindings/iio/adc/qcom,spmi-vadc.yaml      | 21 +++--
>>   .../bindings/thermal/qcom-spmi-adc-tm5.yaml   | 16 ++--
>>   .../iio/qcom,spmi-adc5-gen2-pm8350.h          | 64 +++++++++++++
>>   .../iio/qcom,spmi-adc5-gen2-pm8350b.h         | 89 +++++++++++++++++++
>>   .../iio/qcom,spmi-adc5-gen2-pmk8350.h         | 47 ++++++++++
>>   .../iio/qcom,spmi-adc5-gen2-pmr735a.h         | 29 ++++++
>>   .../iio/qcom,spmi-adc5-gen2-pmr735b.h         | 28 ++++++
>>   include/dt-bindings/iio/qcom,spmi-vadc.h      | 77 ++++++++++++++++
> Bindings are always separate patches. If this is commit for bindings, then:
>
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching.

Sure, I'll check this for the next patch series.

Thanks,

Jishnu

>
>
>
> Best regards,
> Krzysztof
>
