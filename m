Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D4B7651AD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjG0KwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjG0KwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:52:07 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E118F2688;
        Thu, 27 Jul 2023 03:52:02 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R6Kkdu019067;
        Thu, 27 Jul 2023 10:51:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=C5RYwUGjBtTl+5dNSpZ5G/v7elv+x3Dv1cSvaxxti00=;
 b=CEs4QFqqlOSJIZ2XHwnxKUKPFwfqKl5jqZ5uO4D+FZd261MpQdai32vT24itIVqHdyqh
 m0hwlgm0HDtripDdVIOBR8mUoOL8tCnD+PtFUdKSAHJU9qSgXJD/FnJiSe++GoQaC8hF
 ChyJ8LeHMo5NeSn/TNVajeKIbDxkum2ebYsUc/ht7EeVeMZLPdSYUCmU2l1TIZlcFNdT
 je+59zTqzozd0iwXE4MEXqHhpC1LRVVMK7SaLiD1U8I+Cp1yPEmF85iXxXae6VS3hYfo
 1XGx+cEfZnd5jL4uy4/Dz4ujQ+URC9qyWf/T3Ow7ddj2+jNMbmVkHxgnsOigu4bz3mmB Og== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s3k7u0kpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 10:51:52 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36RApS5S031807
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 10:51:28 GMT
Received: from [10.253.74.152] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 27 Jul
 2023 03:51:24 -0700
Message-ID: <b5e58172-beb5-0be3-834f-3f1db3e8b3b3@quicinc.com>
Date:   Thu, 27 Jul 2023 18:51:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] dt-bindings: input: qcom,pm8xxx-vib: add more PMIC
 support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_kamalw@quicinc.com>, <jestar@qti.qualcomm.com>,
        <quic_huliu@quicinc.com>
References: <20230718062639.2339589-1-quic_fenglinw@quicinc.com>
 <20230718062639.2339589-2-quic_fenglinw@quicinc.com>
 <cb534cdb-508e-b03e-4e39-50cd6654377a@linaro.org>
 <4cb9f443-bdea-695a-f1b7-3963747e9a17@quicinc.com>
 <5b7e624b-5d06-826d-92d1-2a721b7c83b7@quicinc.com>
 <fec38f3a-f103-ff0f-138c-cffa3a808001@linaro.org>
 <4210b137-2d5d-a467-ea8c-d047701fdcc2@quicinc.com>
 <dd5864ee-7df2-eb64-c7f2-0fb234900d6a@linaro.org>
 <2fa3f27d-ff08-b923-2fb1-cf7cc888e5d5@linaro.org>
 <f1286da7-05a6-c8aa-d13b-075c0fd45b77@quicinc.com>
 <b0999940-8cd1-349d-9bf4-d6494145254c@linaro.org>
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <b0999940-8cd1-349d-9bf4-d6494145254c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mVup8Z_5NoWlGBgLcsqKSsJupBSPeNZN
X-Proofpoint-ORIG-GUID: mVup8Z_5NoWlGBgLcsqKSsJupBSPeNZN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307270097
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/2023 4:29 PM, Krzysztof Kozlowski wrote:
> On 27/07/2023 09:54, Fenglin Wu wrote:
>>>>> +          - enum:
>>>>> +              - qcom,pm7550ba-vib
>>>>> +          - const: qcom,pm7325b-vib
>>>>>
>>>>
>>>> Yes
>>>
>>> I wonder why this approved change turned out to something incorrect in
>>> your v3 patch...
>>>
>> Since I got review comments in the driver change and I was told to
>> refactor the driver before adding new HW support. I added the HW type
>> logic in the driver and I was thinking it might be good to add some
>> generic compatible strings to match with the HW type introduced in the
>> driver change.
>>
>> Anyway, I will update it to what you suggested in next patch.
> 
> Drivers are not really related to bindings, so whatever HW type you add
> in driver, is not a reason to change bindings. Reason to change bindings
> could be for example: because hardware is like that.
> 
Understood.

Sorry, I forgot to mention, in v3, I added the 'reg' value to the 
register offset and no longer hard code the 16-bit register address, 
that makes the vibrators inside PMI632/PM7250B/PM7325B/PM7550BA all 
compatible, and that was another motivation of adding a generic 
compatible string and make the others as the fallback.

This will be still the case in v4, I might keep it similar in v3 but 
just drop "qcom,spmi-vib-gen1"

> Best regards,
> Krzysztof
> 
