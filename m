Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97C97FCDDE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 05:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376897AbjK2EWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 23:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjK2EWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 23:22:12 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C7E1710;
        Tue, 28 Nov 2023 20:22:18 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT3LoTh026472;
        Wed, 29 Nov 2023 04:22:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5GPHYWNLlw5rUJSjPsApRdIgwkJG6a4bhZxOWXdiWCM=;
 b=X7xXVYwS21iJ6zBE+7BhDLSuL7pjydLeECqInL8N5jiqWffbJ3Ivu/KWNGW3Xs0jdqIE
 1EVYovBsewFOeF73shW+aGRbaTDQRu/FPHDnCKCoVZz35fFTAztoZ30wuqCsCuJCLAUt
 AflgekSW+sUJqUJRMn0N4TZo6u8a/UyecgQd3HhuvPcvc+Opsu1MQaE9t9Gjz+VQVXSP
 meKSaxP0ALMrJvS2MWAz/eIDpo4MXkejs3XazcNBQtielw8hQZCyYHtWJMoAYTEeZvA5
 OSqnGTRsCG8Q71O/SARc3O5RxBf/Q5hsWBXwaFdPLNQHkhTnMdHSGaOrrpzikUvUHjPd tA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3unekyjh06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 04:22:12 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AT4MBs7021674
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 04:22:11 GMT
Received: from [10.239.154.73] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 28 Nov
 2023 20:22:08 -0800
Message-ID: <bf772476-79a1-4a52-a8e3-54709adf4673@quicinc.com>
Date:   Wed, 29 Nov 2023 12:22:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v7 0/3] Add support for vibrator in multiple PMICs
Content-Language: en-US
To:     <linux-arm-msm@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_collinsd@quicinc.com>,
        <quic_subbaram@quicinc.com>, <quic_kamalw@quicinc.com>,
        <jestar@qti.qualcomm.com>, Luca Weiss <luca.weiss@fairphone.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
References: <20231108-pm8xxx-vibrator-v7-0-632c731d25a8@quicinc.com>
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <20231108-pm8xxx-vibrator-v7-0-632c731d25a8@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NsV8g-GEnr5H-cqykFoC4HzDLpvgYYw9
X-Proofpoint-ORIG-GUID: NsV8g-GEnr5H-cqykFoC4HzDLpvgYYw9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_01,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1011 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290032
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry Torokhov,

Can you help to review the series of the changes?
I knew that you left comment in patch V6 about moving shift and mask 
into a chip-specific data structure to avoid defining 'hw_type'. 
Actually 'hw_type' is added here to differentiate the SSBI vibrator 
module which doesn't need to read the base address from the DT and add 
it up in register read/write access, while SPMI vibrators in different 
PMICs may be the same HW but just with different base address, and we 
can use device compatibles instead of adding the chip-specific data 
structure for each of them by just updating the base address. See 
discussion here for more details:
https://lore.kernel.org/linux-arm-msm/20230718062639.2339589-3-quic_fenglinw@quicinc.com/

I also responded here that having 'hw_type' would help us with a cleaner 
code logic instead of checking specific reg/mask for particular 
operations: 
https://lore.kernel.org/linux-arm-msm/8697d115-9aa7-2a1c-4d96-25b15adb5cca@quicinc.com/

Let me know what's your final suggestion, if you insist that I should 
move the reg/mask/shift in the chip-specific data structure, I can 
update it even it won't be as clean as what it looks right now.
Thanks

Fenglin

On 11/8/2023 3:36 PM, Fenglin Wu via B4 Relay wrote:
> Add SW support for the vibrator module inside PMI632, PM7250B, PM7325B, PM7550BA.
> It is very similar to the vibrator module inside PM8916 which is supported in
> pm8xxx-vib driver but just the drive amplitude is controlled with 2 registers,
> and the register base offset in each PMIC is different.
> 
> Changes in v7;
>    1. Fix a typo: SSBL_VIB_DRV_REG --> SSBI_VIB_DRV_REG
>    2. Move the hw_type switch case in pm8xxx_vib_set() to the refactoring
>       change.
> 
> Changes in v6:
>    1. Add "qcom,pmi632-vib" as a standalone compatible string.
> 
> Changes in v5:
>    1. Drop "qcom,spmi-vib-gen2" generic compatible string as requested
>       and use device specific compatible strings only.
> 
> Changes in v4:
>    1. Update to use the combination of the HW type and register offset
>       as the constant match data, the register base address defined in
>       'reg' property will be added when accessing SPMI registers using
>       regmap APIs.
>    2. Remove 'qcom,spmi-vib-gen1' generic compatible string.
> 
> Changes in v3:
>    1. Refactor the driver to support different type of the vibrators with
>      better flexibility by introducing the HW type with corresponding
>      register fields definitions.
>    2. Add 'qcom,spmi-vib-gen1' and 'qcom,spmi-vib-gen2' compatible
>      strings, and add PMI632, PM7250B, PM7325B, PM7550BA as compatbile as
>      spmi-vib-gen2.
> 
> Changes in v2:
>    Remove the "pm7550ba-vib" compatible string as it's compatible with pm7325b.
> 
> Fenglin Wu (3):
>    input: pm8xxx-vib: refactor to easily support new SPMI vibrator
>    dt-bindings: input: qcom,pm8xxx-vib: add new SPMI vibrator module
>    input: pm8xxx-vibrator: add new SPMI vibrator support
> 
>   .../bindings/input/qcom,pm8xxx-vib.yaml       |  16 +-
>   drivers/input/misc/pm8xxx-vibrator.c          | 171 ++++++++++++------
>   2 files changed, 132 insertions(+), 55 deletions(-)
> 
> --
> 2.25.1
> 
> ---
> Fenglin Wu (3):
>        input: pm8xxx-vib: refactor to easily support new SPMI vibrator
>        dt-bindings: input: qcom,pm8xxx-vib: add new SPMI vibrator module
>        input: pm8xxx-vibrator: add new SPMI vibrator support
> 
>   .../devicetree/bindings/input/qcom,pm8xxx-vib.yaml |  16 +-
>   drivers/input/misc/pm8xxx-vibrator.c               | 170 ++++++++++++++-------
>   2 files changed, 131 insertions(+), 55 deletions(-)
> ---
> base-commit: 650cda2ce25f08e8fae391b3ba6be27e7296c6a5
> change-id: 20230925-pm8xxx-vibrator-62df3df46a6c
> 
> Best regards,
