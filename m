Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2776F7FD46F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjK2Kif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjK2KiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:38:21 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B0C1BC0;
        Wed, 29 Nov 2023 02:38:27 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT6xODY005375;
        Wed, 29 Nov 2023 10:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dwDLVwBiYfvHonsK507EpnuHyfrplrM/XOwuzgUOwoE=;
 b=QhER3nzFgCF0/EWPV4PJQZn+tyqYDKzzwdkxU32fqQSKJraO0ysyBQnluR2TrYfO6CIL
 JpjavTb9/N9fN/ALx10QxJYpl93u/E/wry3Kw9km1HhhFjjNQ7L49+KtXkyj7sK9rNfW
 d5vMXku90nc3ePwO5m1FN8BWFyHCyU82ULz8y1hHdyEtdkSn9rvwv9mdv9pTCiiQukbT
 oppfRxTMFPTuDa0lPbLqiAPTBwB5bLGLrzvA2X758FEfDoJ/NhTSd2zU4SK9JTLuNUHy
 ep5uaAzpWjKQsWy9G7KmM+ITVA2AEWUOhKh/sWOuxCksSnJH2TzNs3t3HmZuPloFGgH/ FA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3undc5bmhc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 10:38:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ATAc5qZ003130
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 10:38:05 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 29 Nov
 2023 02:37:58 -0800
Message-ID: <d8b25f71-2f06-f043-31ef-3696b33642eb@quicinc.com>
Date:   Wed, 29 Nov 2023 16:07:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 1/5] dt-bindings: arm: cpus: Add qcom,oryon compatible
Content-Language: en-US
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     Rob Herring <robh@kernel.org>
CC:     <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <catalin.marinas@arm.com>,
        <ulf.hansson@linaro.org>, <agross@kernel.org>,
        <conor+dt@kernel.org>, <ayan.kumar.halder@amd.com>, <j@jannau.net>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <m.szyprowski@samsung.com>, <u-kumar1@ti.com>, <peng.fan@nxp.com>,
        <lpieralisi@kernel.org>, <quic_rjendra@quicinc.com>,
        <abel.vesa@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_tsoni@quicinc.com>,
        <neil.armstrong@linaro.org>
References: <20231117113931.26660-1-quic_sibis@quicinc.com>
 <20231117113931.26660-2-quic_sibis@quicinc.com>
 <20231119155935.GA260100-robh@kernel.org>
 <b01eb441-7d9d-9de3-06aa-ddbdf9b69c26@quicinc.com>
In-Reply-To: <b01eb441-7d9d-9de3-06aa-ddbdf9b69c26@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mMxnKUOVFnswdvXAV59R0VALFyl_hZ8D
X-Proofpoint-ORIG-GUID: mMxnKUOVFnswdvXAV59R0VALFyl_hZ8D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_07,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311290079
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/20/23 12:14, Sibi Sankar wrote:
> Hey Rob,
> 
> Thanks for taking time to review the series.
> 
> On 11/19/23 21:29, Rob Herring wrote:
>> On Fri, Nov 17, 2023 at 05:09:27PM +0530, Sibi Sankar wrote:
>>> From: Rajendra Nayak <quic_rjendra@quicinc.com>
>>>
>>> These are the CPU cores in Qualcomm's X1E80100 SoC.
>>>
>>> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
>>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>>> ---
>>>
>>> v2:
>>> * Update the part number from sc8380xp to x1e80100.
>>>
>>>   Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml 
>>> b/Documentation/devicetree/bindings/arm/cpus.yaml
>>> index ffd526363fda..cc5a21b47e26 100644
>>> --- a/Documentation/devicetree/bindings/arm/cpus.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
>>> @@ -198,6 +198,7 @@ properties:
>>>         - qcom,kryo660
>>>         - qcom,kryo685
>>>         - qcom,kryo780
>>> +      - qcom,oryon
>>
>> Wasn't it previously said 'oryon' is not specific enough?

https://lore.kernel.org/lkml/b165d2cd-e8da-4f6d-9ecf-14df2b803614@linaro.org/

The cpu part numbers were indeed different in engineering samples
which has now been fixed in the production version.

-Sibi

>>
>> Also, please describe what oryon is in the commit msg.
> 
> ack. Will add more details in the next re-spin.
> 
> -Sibi
> 
>>
>> Rob
