Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BA97EDA12
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 04:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344782AbjKPDZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 22:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344463AbjKPDZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 22:25:35 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927F71A1;
        Wed, 15 Nov 2023 19:25:29 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG2ZRhK017184;
        Thu, 16 Nov 2023 03:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5Ljk8Ozx5F7sLSJTRFBLUMRx0bAGjYnp7zAznV9povM=;
 b=N1a97VnVWxS/+UnoK3B/OXNjGdmGmEDCFCw3STBRfa/g0ivG5F3NmM3bj7eYeIxl05yA
 w7pYsAqIRU0oVLRON4M7D84lA7/4dbdFkOOEnxDW2HuAJTvrPr9+cNsYVBH0qaur+I2i
 znXuayMyf/DgpYlH6rMQTMVfYADG0CKnMTh1rt7m6lcQeaHYoYOz4kZq4mRDncqadxyi
 b2VNh8bbxT8F+0KUse96ZTe6YLXb2IgPgYeFXKpBnmpuwWsP2J4tEQaayh7yMsbcPjMi
 cGqWo5kM/JU/Vru5t/E31BnBfDZx6nO43jwjyAy60D0m/OJPPqBL6CNTXPIG5l5VzmIu 4A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucu27t7k4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 03:25:16 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AG3PFnJ009802
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 03:25:15 GMT
Received: from [10.216.41.162] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 15 Nov
 2023 19:25:07 -0800
Message-ID: <78041157-e084-08e5-06e6-07c731b106b3@quicinc.com>
Date:   Thu, 16 Nov 2023 08:55:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
Subject: Re: [PATCH 10/11] ARM: dts: qcom: Update devicetree for QCOM ADC
 bindings path change
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
        <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
 <20230708072835.3035398-11-quic_jprakash@quicinc.com>
 <59ea565c-93ad-e8e3-10db-ae3ba481ebe9@linaro.org>
 <706d3b7e-a9b5-081c-52b2-7cce4f0d5f10@quicinc.com>
 <20231110234758.GE3553829@hu-bjorande-lv.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20231110234758.GE3553829@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -q8IhKzNHHQyCGy6j-XkkY3gcxaqYMJ8
X-Proofpoint-ORIG-GUID: -q8IhKzNHHQyCGy6j-XkkY3gcxaqYMJ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_20,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160025
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 11/11/2023 5:17 AM, Bjorn Andersson wrote:
> On Mon, Oct 23, 2023 at 11:48:13AM +0530, Jishnu Prakash wrote:
>> Hi Krzysztof,
>>
>> On 7/9/2023 10:56 PM, Krzysztof Kozlowski wrote:
>>> On 08/07/2023 09:28, Jishnu Prakash wrote:
>>>> Update ADC dt-bindings file paths in QCOM devicetree files to
>>>> match the dt-bindings change moving the files from 'iio' to
>>>> 'iio/adc' folder.
>>>>
>>>> Signed-off-by: Jishnu Prakash<quic_jprakash@quicinc.com>
>>>> ---
>>> Your order of patches is incorrect. DTS cannot be before bindings,
>>> because this indicates you broke ABI. Please keep entire patchset
>>> bisectable and split DTS to separate patchset (linking the driver and
>>> bindings).
>>>
>>> Best regards,
>>> Krzysztof
>> OK....so you mean I can move the dtbinding files and update documentation
>> and driver files for this, all in one patch and then make a second patch for
>> updating devicetree files for the file paths?
>>
>> I'll make this change in the next patchset if it looks fine, although the
>> two patches would need to be picked together to avoid kernel breakage. I
>> have asked Jonathan about this too in my reply for the previous patchset 9.
>>
> 1) We need to be able to use git bisect to identify regressions, and as
> such the kernel need to be buildable and functional after each applied
> patch.
>
> 2) DeviceTree source (dts) changes enters the kernel through different
> maintainer paths than the DeviceTree binding and driver changes, and
> therefore at different times. In some cases the .dtb file is also
> delivered separately from the kernel, which means people might be
> running an old .dtb for a considerable amount of time after your change.
> As such your driver changes needs to be compatible with both the new and
> the old DeviceTree binding.


Thanks for your comments. For now, Jonathan and Dmitry have asked me to 
move the binding files and fix all errors in one commit for their 
review, so I'll be doing as they requested. Based on their review, I'm 
assuming they will also suggest what other changes are needed for 
compatibility with older devicetrees as you mentioned.


> Regards,
> Bjorn
