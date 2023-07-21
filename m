Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC92275BC2A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 04:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjGUCTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 22:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjGUCTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 22:19:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A391BDC;
        Thu, 20 Jul 2023 19:18:58 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L0cRVf013837;
        Fri, 21 Jul 2023 02:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3J8phghglW9OUevvcPX2Y2pD7QJQpZ5tEMMjOMHC2JY=;
 b=jpqbBWf2bxQbTDuZ1Eb0dNDWrexZEtxvlTYm2OQbun/9gTXZQmKMOAMrvTBRERBHcUYF
 vKaulsbSkv+s9B/c2F6bqgajBg1HO00VseZWb2DoAxT41LZULRI+rJTN0UJLe0fk+iJR
 q953E2lD2C0Tw6Ewewbg55DN1H2sV7j3yVOOMBrIgYXDSZh78++ainWuixqXTfPohR0W
 pY+RZ1ZSHZZFz4CMDLoN4/ZgYBRXh9rpWSkOKfz3l0C5EE8/3xCeVigcpGXFXH/qUrA/
 IqqqyZkEWKdSw5BiIw0Xp5b0ZGW7iEuRWxHCyv6V9AfQVmu5hAyxHctN22R1h4At1f9A Vw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxt18b17r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 02:18:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36L2IsdZ028122
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 02:18:54 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 20 Jul
 2023 19:18:50 -0700
Message-ID: <bd16b009-491b-0edf-4e99-1f0dc5fd769d@quicinc.com>
Date:   Fri, 21 Jul 2023 10:18:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] arm64: dts: qcom: Add base SM4450 QRD DTS
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <quic_tsoni@quicinc.com>, <quic_shashim@quicinc.com>,
        <quic_kaushalk@quicinc.com>, <quic_tdas@quicinc.com>,
        <quic_tingweiz@quicinc.com>, <quic_aiquny@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230719100135.21325-1-quic_tengfan@quicinc.com>
 <20230719100135.21325-3-quic_tengfan@quicinc.com>
 <def2f081-49a6-3ab9-6bf4-d8672fa28a31@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <def2f081-49a6-3ab9-6bf4-d8672fa28a31@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AvXrJ2c1cAxtENU3r25M0OSQBS5JNTJF
X-Proofpoint-GUID: AvXrJ2c1cAxtENU3r25M0OSQBS5JNTJF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_12,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=870 adultscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307210019
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 7/19/2023 6:23 PM, Krzysztof Kozlowski 写道:
> On 19/07/2023 12:01, Tengfei Fan wrote:
>> Add DTS for Qualcomm QRD platform which uses SM4450 SoC.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile       |  1 +
>>   arch/arm64/boot/dts/qcom/sm4450-qrd.dts | 18 ++++++++++++++++++
>>   2 files changed, 19 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/sm4450-qrd.dts
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index 337abc4ceb17..a0cfd37e674b 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -215,3 +215,4 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx223.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx224.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-mtp.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-qrd.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= sm4450-qrd.dtb
> 
> Messed order.
V2 patch will order this.
> 
>> diff --git a/arch/arm64/boot/dts/qcom/sm4450-qrd.dts b/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
>> new file mode 100644
>> index 000000000000..851a6761a6ea
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
>> @@ -0,0 +1,18 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "sm4450.dtsi"
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. SM4450 QRD";
>> +	compatible = "qcom,sm4450-qrd", "qcom,sm4450";
> 
> Missing bindings.
[PATCH 4/5] updated bindings, will move [PATCH 4/5] in front of this 
patch[PATCH 2/5].
> 
>> +
>> +	aliases { };
>> +
>> +	chosen {
>> +		bootargs = " ";
> 
> Drop, useless.
Will Drop bootargs="", only chosen empty.
> 
> OTOH, you miss here several properties. This is not even a basic board -
> nothing works here, right? Please submit when you have at least serial
> working.
We tested DCC console done(CONFIG_HVC_DCC), currnty DCC console can be 
used after enable CONFIG_HVC_DCC and add some reasonable dcc properties, 
so want to get review for this patch.
> 
>> +	};
>> +};
> 
> Best regards,
> Krzysztof
> 

-- 
Thx and BRs,
Tengfei Fan
