Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951507D2A45
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjJWGUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjJWGU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:20:29 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1EAB9;
        Sun, 22 Oct 2023 23:20:27 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39N5wxpj002986;
        Mon, 23 Oct 2023 06:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UiNyF/RZ+Y+U5yIffdrpOm0dqqjSpu0l0RIgED41prg=;
 b=etP0RkkKayZOS+5cQ25MIepAiOdU4hkHgjRr3lSZdzH4P7Crl+LXr4/H3Y+5/YuJxRnu
 R3Bd8Um1cbqYeepFIZJcs3xccnH9AXMXA8d6JByAIrE861GipAEtJ6n2AMwz0mXNIj5e
 501/bV9OGQWBPWcDWk6MWl3lGzjU9Z/Pw62MYJEvMZR83x45dF46Cwotw2pmMFNT9gLc
 +piid8BiVlwc0Ge52MvznuBtjGMR2AwEfdCf91SORzpgptRIkCMjudBhnMJszsJc7Xec
 4y20oOoYpWcCBpXl0hrIfnkVQ4tWbHfGRKYmZdVvdg98EOYy8OLYpslIwICbMcIvpNne yw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv5ndu9h0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 06:19:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39N6JvLA026101
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 06:19:57 GMT
Received: from [10.216.48.174] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Sun, 22 Oct
 2023 23:19:48 -0700
Message-ID: <e6c27567-070e-1765-3d5a-30a6e6fa119b@quicinc.com>
Date:   Mon, 23 Oct 2023 11:49:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 11/11] dt-bindings: iio: remove QCOM ADC files from iio
 folder
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <sboyd@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_kamalw@quicinc.com>,
        <quic_jestar@quicinc.com>, <marijn.suijten@somainline.org>,
        <andriy.shevchenko@linux.intel.com>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <linux-arm-msm-owner@vger.kernel.org>
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
 <20230708072835.3035398-12-quic_jprakash@quicinc.com>
 <8b2dd686-382a-f490-7b6e-9603d939bad7@linaro.org>
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <8b2dd686-382a-f490-7b6e-9603d939bad7@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iOPs_cGueR93UyrTQiIXeLAv8rUQ2VJ_
X-Proofpoint-ORIG-GUID: iOPs_cGueR93UyrTQiIXeLAv8rUQ2VJ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_03,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310230054
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

On 7/9/2023 10:58 PM, Krzysztof Kozlowski wrote:
> On 08/07/2023 09:28, Jishnu Prakash wrote:
>> Now that the ADC dt-binding paths have been updated everywhere
>> to use the files copied to the 'iio/adc' folder, remove them
>> from the 'iio' folder.
>>
>> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
>> ---
> Nothing this was explained in previous patches... We should not have to
> read patchset from the end to understand what is happening here. Anyway,
> your commits lack rationale why this is done. Without it, this is pure
> churn which breaks users. ABI breaks need to be explained in the commit
> msg and come with some reason.


I'll try to do the changes in one or two patchsets, based on my replies 
for the previous few patchsets (8, 9, 10), hope this can work.


>
> ...
>
>> -/* 400k pull-up3 */
>> -#define ADC5_GEN3_AMUX1_THM_400K_PU		0x64
>> -#define ADC5_GEN3_AMUX2_THM_400K_PU		0x65
>> -#define ADC5_GEN3_AMUX3_THM_400K_PU		0x66
>> -#define ADC5_GEN3_AMUX4_THM_400K_PU		0x67
>> -#define ADC5_GEN3_AMUX5_THM_400K_PU		0x68
>> -#define ADC5_GEN3_AMUX6_THM_400K_PU		0x69
>> -#define ADC5_GEN3_AMUX1_GPIO_400K_PU		0x6a
>> -#define ADC5_GEN3_AMUX2_GPIO_400K_PU		0x6b
>> -#define ADC5_GEN3_AMUX3_GPIO_400K_PU		0x6c
>> -#define ADC5_GEN3_AMUX4_GPIO_400K_PU		0x6d
>> -
>> -/* 1/3 Divider */
>> -#define ADC5_GEN3_AMUX1_GPIO_DIV3		0x8a
>> -#define ADC5_GEN3_AMUX2_GPIO_DIV3		0x8b
>> -#define ADC5_GEN3_AMUX3_GPIO_DIV3		0x8c
> You just added these defines in previous patches. Don't add them to
> incorrect places just to fix it second later.


Right, I'll avoid this and add the ADC5 Gen3 macros in the 
dt-bindings/iio/adc/ folder in the next patchset, irrespective of what 
happens with updating the file paths, hope there won't be any issues.

Thanks,

Jishnu


>
> Best regards,
> Krzysztof
>
