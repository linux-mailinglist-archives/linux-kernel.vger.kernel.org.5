Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4327FD49D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjK2Kp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjK2KpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:45:24 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D6510FC;
        Wed, 29 Nov 2023 02:45:30 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT42Bp3003568;
        Wed, 29 Nov 2023 10:45:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cTSpEqMQc5eLV2nqpZmBK8WLhgzNhz/ygqJzgtxguzU=;
 b=WOwvOxbH+Lw7kN4C3Wt6MaQFydRfROi6nxioK31gfYllL0OWuAEzjr+XlDgk83hPH4j/
 HG4h9k90g/Oz/r9+EgYxgz8cKM4Isuye+LAhJSEaPkDhzE+MWCWycKQ8cgFdOOuxQQ1O
 noPAOM7GBZ5Tvt6uy/RxU9t0ueqrqTgXUvRs5s+WhI6qD5+to8+LJsxm4R7mV9k/a/WI
 yxBAVrLUdejJNGCCNdx3hsGz6oWN3b2AzP06OpsNIru45bzaijFRZFRuO/FES7VuRcO6
 tUQdwcdVeo7W14YGF1GYROafi/hhNOVrQ97Adh7VN4k/ITR/fHTjASiI/2zLlRRO7bKi tg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3undc5bmwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 10:45:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ATAj9K1012619
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 10:45:09 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 29 Nov
 2023 02:45:00 -0800
Message-ID: <cbce7643-7b62-4d48-8c30-7856b39e29b9@quicinc.com>
Date:   Wed, 29 Nov 2023 18:44:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/6] arm64: dts: qcom: sm4450-qrd: mark QRD4450
 reserved gpios
From:   Tengfei Fan <quic_tengfan@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <geert+renesas@glider.be>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <m.szyprowski@samsung.com>,
        <u-kumar1@ti.com>, <peng.fan@nxp.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tdas@quicinc.com>, <quic_tingweiz@quicinc.com>,
        <quic_aiquny@quicinc.com>, <kernel@quicinc.com>
References: <20231031075004.3850-1-quic_tengfan@quicinc.com>
 <20231031075004.3850-6-quic_tengfan@quicinc.com>
 <6a799fc7-8d7d-4035-8e7e-458f9a61bf4e@linaro.org>
 <ef0f23fa-03b2-45f3-b803-4bd319d91ee7@quicinc.com>
In-Reply-To: <ef0f23fa-03b2-45f3-b803-4bd319d91ee7@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: R137ozYBDCjNyBenIda0gXRy0TN3yPLC
X-Proofpoint-ORIG-GUID: R137ozYBDCjNyBenIda0gXRy0TN3yPLC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_08,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=747 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311290080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 11/27/2023 1:58 PM, Tengfei Fan 写道:
> 
> 
> 在 11/18/2023 8:45 AM, Konrad Dybcio 写道:
>> On 31.10.2023 08:50, Tengfei Fan wrote:
>>> Some gpios are reserved for other subsystems, so mark these reserved
>>> gpios.
>>>
>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sm4450-qrd.dts | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm4450-qrd.dts 
>>> b/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
>>> index bb8c58fb4267..e354bad57a9e 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
>>> +++ b/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
>>> @@ -23,6 +23,11 @@
>>>       status = "okay";
>>>   };
>>> +&tlmm {
>>> +    /* Reserved for other subsystems */
>> that much we can guess :D
>>
>> it would be very appreciated if you could do e.g.
>>
>> <0 4>, /* fingerprint scanner */
>> <136 1>; /* coffee machine trigger */
>>
>> Konrad
> Hi Konrad,
> Thank you for reviewing this patch series, I will update new patch 
> series according to your suggestion.
Hi Konrad,
Storage team discovered that gpio 136 was inaccessible due to the 
pinctrl driver issue. So new version patch series will drop gpio 136 
from this gpio-reserved-ranges node.

New version patch series:
https://lore.kernel.org/linux-arm-msm/20231129103325.24854-1-quic_tengfan@quicinc.com/
> 
> 

-- 
Thx and BRs,
Tengfei Fan
