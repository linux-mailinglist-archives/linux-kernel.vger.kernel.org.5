Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AC3802CB2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 09:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343684AbjLDIHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjLDIG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:06:56 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B700218F;
        Mon,  4 Dec 2023 00:06:59 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B45wSgx030488;
        Mon, 4 Dec 2023 08:06:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Hq9R7DYrxM2igzYSQ4iQwslU8PL4G2Av2d2fNc3mfi0=;
 b=kD8tztp8sVF+NSXBjDWQgXoteBjptUsySTTCaqFUW1xaITTFwuBraDG3n12onReUSzgu
 mX9bEZVXoZWQvMG8jed/6fcgFYyaoHrX37einDHIocAGqWJjyUYutba6PMWt7v0+4/qw
 ht4Rql+yH87leiwOvLqXXmfmz+2tNlStkmu5R7TozdNtK8uVJ2thbzIV8/VJR0CsJe/I
 xN3n7JJk8vtuZa8DbNwJJ0p6MbGPkOjmPAKEtNYFVMulnM1QF0ojl9uk6MqV4NYlUAw2
 boVAuh1GAHMVOA8yqAU0IdOBqoJMQgPlbDBeBml7kLQXCxrWinQWTFr8sDUUnnWJ4dIB qg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uquwt3db1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 08:06:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B486pdL023851
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Dec 2023 08:06:51 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 4 Dec
 2023 00:06:45 -0800
Message-ID: <c3e18a62-0d50-4291-94a2-17a51957253d@quicinc.com>
Date:   Mon, 4 Dec 2023 16:06:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] pinctrl: qcom: Add SM4450 pinctrl driver
To:     Krzysztof Kozlowski <krzk@kernel.org>, <andersson@kernel.org>,
        <agross@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
References: <20231130024046.25938-1-quic_tengfan@quicinc.com>
 <20231130024046.25938-3-quic_tengfan@quicinc.com>
 <1d2fbb36-9476-4f32-8bcd-33fd5dcbd6e4@kernel.org>
 <d192f32a-130f-4568-9622-d3465c709853@quicinc.com>
 <1b65f67a-8142-4690-af6e-4a0bf641b7be@kernel.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <1b65f67a-8142-4690-af6e-4a0bf641b7be@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ApuSse2Xl2WdgRnvQ1JTnoGGBmMcjvB-
X-Proofpoint-ORIG-GUID: ApuSse2Xl2WdgRnvQ1JTnoGGBmMcjvB-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_06,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=849 bulkscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040060
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 12/4/2023 3:56 PM, Krzysztof Kozlowski 写道:
> On 04/12/2023 02:57, Tengfei Fan wrote:
>>
>>
>> 在 11/30/2023 7:57 PM, Krzysztof Kozlowski 写道:
>>> On 30/11/2023 03:40, Tengfei Fan wrote:
>>>> Add pinctrl driver for TLMM block found in SM4450 SoC.
>>>>
>>>> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>>> ---
>>>>    drivers/pinctrl/qcom/Kconfig.msm      |    8 +
>>>>    drivers/pinctrl/qcom/Makefile         |    1 +
>>>>    drivers/pinctrl/qcom/pinctrl-sm4450.c | 1013 +++++++++++++++++++++++++
>>>>    3 files changed, 1022 insertions(+)
>>>>    create mode 100644 drivers/pinctrl/qcom/pinctrl-sm4450.c
>>>>
>>>
>>> Hm, was this patch ever built?
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> This patch has been built before, I will check and compare if there are
>> any errors and changes when I submitted this patch series.
>>
> 
> No, it wasn't built. I just tried - applied it and:
> 
> pinctrl-sm4450.c:996:19: error: initialization of ‘int (*)(struct
> platform_device *)’ from incompatible pointer type ‘void (*)(struct
> platform_device *)’ [-Werror=incompatible-pointer-types]
>    996 |         .remove = msm_pinctrl_remove,
>        |                   ^~~~~~~~~~~~~~~~~~
> ../drivers/pinctrl/qcom/pinctrl-sm4450.c:996:19: note: (near
> initialization for ‘sm4450_tlmm_driver.remove’)
> 
> So you just sent a patch which was not even compiled.
> 
> NAK.
> 
> Best regards,
> Krzysztof
> 
I compiled all the related patches together, but I did not compile this 
patch separately.
The fact that there is a compilation problem is known, but because the 
patch is already reviewed-by, so a separate patch(patch 3) is submitted 
to fix the compilation error.

The next version patch series will incorpotate the fix patch into this 
pinctrl driver patch as well.


-- 
Thx and BRs,
Tengfei Fan
