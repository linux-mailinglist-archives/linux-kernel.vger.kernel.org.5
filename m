Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3957EDA00
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 04:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344454AbjKPDXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 22:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKPDXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 22:23:39 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995F11A4;
        Wed, 15 Nov 2023 19:23:35 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG1spf6000357;
        Thu, 16 Nov 2023 03:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ZJHZ0hYzA9hL5E4FTKSXb/MkIlhg4z+4Eg5vBs84CWU=;
 b=CzcD0bnLVUI7v5UoeXwP90mPYMrSo4zJlOshDfe5BMrbwW9Ehjexo2/21m0OjAtweCge
 s3l29tgnEhqzn3Bj6VXN9K2sD6IfCwEmXVfV2t4NJ+e0gaxMBKKQ3PSJyx75b8TxRAkk
 IXeOy3XRYb56QBY1L5YEPR3QCNumrG8GIdK4OxAwI7qx3vCV8fyRGslgFUSy6YTA8AtL
 8mSF1dpcAU+mbUfXeShBkBPyOZrzIhFZVQpEXyD5B/y/HBpzVP6SHKjmWhpIooeXm08m
 HKRVHx143Thd/WbOsNz4EsfRjHXXR7cGmgARocnQJmUjU9AGXckLPOO6oDJssa2PeIiL zA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ud41f8ts9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 03:23:22 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AG3NK9S002852
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 03:23:20 GMT
Received: from [10.216.41.162] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 15 Nov
 2023 19:23:13 -0800
Message-ID: <823317c7-7076-7f54-bb23-9e05c4a3ba87@quicinc.com>
Date:   Thu, 16 Nov 2023 08:53:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
Subject: Re: [PATCH 03/11] ARM: dts: qcom: Update devicetree for ADC7 rename
 for QCOM PMICs
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <sboyd@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_kamalw@quicinc.com>,
        <marijn.suijten@somainline.org>,
        <andriy.shevchenko@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     <linux-iio@vger.kernel.org>, <linux-arm-msm-owner@vger.kernel.org>
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
 <20230708072835.3035398-4-quic_jprakash@quicinc.com>
 <839cfac2-8f74-3386-5854-e3fb2ba4e07f@linaro.org>
 <27b5806f-ef15-7a90-5adc-5ee12690f2ca@quicinc.com>
 <7af782f3-fe6c-415b-a993-55962845a102@linaro.org>
 <7ccaf08e-0add-33e5-fbea-ce737e53fa28@quicinc.com>
 <8114d2f9-43d8-4761-adfa-aad9ae249cbc@linaro.org>
Content-Language: en-US
In-Reply-To: <8114d2f9-43d8-4761-adfa-aad9ae249cbc@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: I7vMNTuFf4imOtkJde7sKj7OtMAwTQuJ
X-Proofpoint-ORIG-GUID: I7vMNTuFf4imOtkJde7sKj7OtMAwTQuJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_20,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=381 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311160025
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 11/10/2023 4:29 PM, Krzysztof Kozlowski wrote:
> On 09/11/2023 09:22, Jishnu Prakash wrote:
>> Hi Krzysztof,
>>
>> On 10/23/2023 12:02 PM, Krzysztof Kozlowski wrote:
>>
>> Since you do not want us to modify the existing bindings, is it fine if
>> I just add a new compatible for ADC5 Gen2 and comments to indicate the
>> ADC7 compatible should be considered deprecated?
> No, because adc7 compatible is valid and there is no reason to replace
> it. Just because you changed naming does not matter for compatibles.
> It's just unique string, that's it. Don't touch it.
>
>
>> If you are not convinced, we can drop the Gen2 name related changes from
>> the patch series.
> Feel free to add comments or descriptions, if you want to map some
> marketing name to real hardware or to compatibles.

Yes, I'll just add a line in the documentation to mention ADC7 goes 
between ADC5 and ADC5 Gen3.

Thanks,

Jishnu


> Best regards,
> Krzysztof
>
