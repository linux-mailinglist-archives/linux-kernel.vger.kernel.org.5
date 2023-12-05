Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC834804A9C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 07:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344442AbjLEGvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 01:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjLEGve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 01:51:34 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A934011F;
        Mon,  4 Dec 2023 22:51:40 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B55gaWY022792;
        Tue, 5 Dec 2023 06:51:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BVvNCdvGjyZq25vNtHzXGLk/rYdZ12wJoWOL0EDbIEQ=;
 b=mrdeGsndkw7uIl7/xk91UKGGsYoo9PYaaG388R+pSPf5Ub4JCoQxXFhygR8qBP9TvNTw
 uuIK5iHeAB2pbaVi9BpHM1WIkfDA7PFw+9FyoMQVxH8tSDHwESwm9wAvd5o6/gWffJyH
 eS4qHYIadznO7UXUx2j8gnI1QPZbk4UkrX1K/d3NKKsMh1Wgswze09bZpKxWiDRpRnSV
 xVhy3kTtclLkVH6GExesdxQbj2cAsBFCnv7m12wtQDrFVvt2CoO7j4BBE0ZiXXd/xsJ7
 mwTLQbl29DCLNcS6NcaJR7U78bWVnK7LufnBiacycO8zNyFXz1rSfmwy6YbmUZIVk4y2 oA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3usdfwjf55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 06:51:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B56pZRs025392
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Dec 2023 06:51:35 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 4 Dec
 2023 22:51:30 -0800
Message-ID: <2e874228-b1b4-48b8-87e4-c81e0957cfd1@quicinc.com>
Date:   Tue, 5 Dec 2023 14:51:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] pinctrl: qcom: Add SM4450 pinctrl driver
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, <andersson@kernel.org>,
        <agross@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
References: <20231130024046.25938-1-quic_tengfan@quicinc.com>
 <20231130024046.25938-3-quic_tengfan@quicinc.com>
 <1d2fbb36-9476-4f32-8bcd-33fd5dcbd6e4@kernel.org>
 <d192f32a-130f-4568-9622-d3465c709853@quicinc.com>
 <1b65f67a-8142-4690-af6e-4a0bf641b7be@kernel.org>
 <e3817ea6-3cdc-418f-bbeb-ed93e7f537e3@quicinc.com>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <e3817ea6-3cdc-418f-bbeb-ed93e7f537e3@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QDYWXb2KgkVSCoGuVMRso-YW7uBKY_Bn
X-Proofpoint-ORIG-GUID: QDYWXb2KgkVSCoGuVMRso-YW7uBKY_Bn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_03,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=827 mlxscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312050053
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 12/5/2023 12:04 AM, Jeff Johnson 写道:
> On 12/3/2023 11:56 PM, Krzysztof Kozlowski wrote:
>> On 04/12/2023 02:57, Tengfei Fan wrote:
>>>
>>>
>>> 在 11/30/2023 7:57 PM, Krzysztof Kozlowski 写道:
>>>> On 30/11/2023 03:40, Tengfei Fan wrote:
>>>>> Add pinctrl driver for TLMM block found in SM4450 SoC.
>>>>>
>>>>> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
>>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>>>> ---
>>>>>    drivers/pinctrl/qcom/Kconfig.msm      |    8 +
>>>>>    drivers/pinctrl/qcom/Makefile         |    1 +
>>>>>    drivers/pinctrl/qcom/pinctrl-sm4450.c | 1013 +++++++++++++++++++++++++
>>>>>    3 files changed, 1022 insertions(+)
>>>>>    create mode 100644 drivers/pinctrl/qcom/pinctrl-sm4450.c
>>>>>
>>>>
>>>> Hm, was this patch ever built?
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>> This patch has been built before, I will check and compare if there are
>>> any errors and changes when I submitted this patch series.
>>>
>>
>> No, it wasn't built. I just tried - applied it and:
>>
>> pinctrl-sm4450.c:996:19: error: initialization of ‘int (*)(struct
>> platform_device *)’ from incompatible pointer type ‘void (*)(struct
>> platform_device *)’ [-Werror=incompatible-pointer-types]
>>    996 |         .remove = msm_pinctrl_remove,
>>        |                   ^~~~~~~~~~~~~~~~~~
>> ../drivers/pinctrl/qcom/pinctrl-sm4450.c:996:19: note: (near
>> initialization for ‘sm4450_tlmm_driver.remove’)
>>
>> So you just sent a patch which was not even compiled.
>>
>> NAK.
>>
>> Best regards,
>> Krzysztof
>>
> 
> The problem here is patch 2/4 incorrectly initializes .remove and patch
> 3/4 changes it to correctly use .remove_new. Bisection at patch 2
> doesn't build.
> 
> Those two patches should be squashed
Yes, next version patch series will squash these two patches.

-- 
Thx and BRs,
Tengfei Fan
