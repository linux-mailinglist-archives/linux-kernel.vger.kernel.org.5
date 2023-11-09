Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFD57E6578
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 09:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbjKIIlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 03:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbjKIIlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 03:41:01 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3CBD5A;
        Thu,  9 Nov 2023 00:40:58 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A96wmwa031035;
        Thu, 9 Nov 2023 08:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=si4S0+PigtnfpKrx9uqTjzcl2aCL6PAyb/NTxxpjs4c=;
 b=j8JfkoxKcWvnI7WUf2kivqG0scvJxGlyPwq417shiffC8Zzr3YJNgx7LR9um89XSJ5P6
 kyCHxuInpkV7yrOipuxdHEkcyeBeIjhy3lkp2adDHBF9moryQxYHiSP4txfVqmUDQXnD
 LAVysJrxdL1Cgb53ZfBrcr8Sx9QRfrmk8EUgiPjMWlGtggpO45TVmY+yG53IoyJyXrKk
 mUlUQ6mgdkMTJHOM3cstE4qv4H16Vffm+sHMIfRTsMd5Pp0Q5PjYCKbx52Gff7Ol7BfN
 2eODUAq9X/tUxOdMUEXyjrfdjqtRrlKRvR4XTMClPOnd13QxKyWu+VSj2TfqepQG91lL LQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u8nhd15bc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Nov 2023 08:40:54 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A98eoG2013576
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Nov 2023 08:40:50 GMT
Received: from [10.216.50.129] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 9 Nov
 2023 00:40:45 -0800
Message-ID: <ec0bb93c-30a1-bcda-a842-8cbad6ceea62@quicinc.com>
Date:   Thu, 9 Nov 2023 14:10:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dt-bindings: cache: qcom,llcc: correct QDU1000 reg
 entries
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231107080436.16747-1-krzysztof.kozlowski@linaro.org>
 <0f76a5c1-14ce-cbfa-bbd9-b2826c4bbbdb@quicinc.com>
 <20231108-hurricane-carefully-d9d3c1348f8c@spud>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20231108-hurricane-carefully-d9d3c1348f8c@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _ONhkTefcxfQDmhf-gjvw9q4ZmN31ixS
X-Proofpoint-ORIG-GUID: _ONhkTefcxfQDmhf-gjvw9q4ZmN31ixS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_07,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 malwarescore=0 phishscore=0 mlxlogscore=706 lowpriorityscore=0
 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090069
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/8/2023 5:56 PM, Conor Dooley wrote:
> On Tue, Nov 07, 2023 at 02:25:25PM +0530, Mukesh Ojha wrote:
>>
>>
>> On 11/7/2023 1:34 PM, Krzysztof Kozlowski wrote:
>>> Qualcomm QDU1000 DTSI comes with one LLCC0 base address as pointed by
>>> dtbs_check:
>>>
>>>     qdu1000-idp.dtb: system-cache-controller@19200000: reg-names:2: 'llcc2_base' was expected
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> ---
>>>
>>> Recent LLCC patches were not tested on QDU1000 thus the LLCC is there
>>> broken.  This patch at least tries to bring some sense according to
>>> DTSI, but I have no clue what is here correct: driver, DTS or bindings.
>>> ---
>>>    Documentation/devicetree/bindings/cache/qcom,llcc.yaml | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/cache/qcom,llcc.yaml b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
>>> index 580f9a97ddf7..d610b0be262c 100644
>>> --- a/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
>>> +++ b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
>>> @@ -64,6 +64,7 @@ allOf:
>>>            compatible:
>>>              contains:
>>>                enum:
>>> +              - qcom,qdu1000-llcc
>>>                  - qcom,sc7180-llcc
>>>                  - qcom,sm6350-llcc
>>
>> Thanks, again.
>>
>> Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>
> 
> I'm assuming given your employer, this ack means that there is no
> llcc2_base on the qdu1000.

Yes, not even have llcc1 , just llcc0.

-Mukesh
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Cheers,
> Conor.
