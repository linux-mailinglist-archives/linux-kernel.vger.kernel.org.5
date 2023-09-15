Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EC07A1936
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjIOIxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjIOIxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:53:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B6210C3;
        Fri, 15 Sep 2023 01:53:32 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38F7eHx6003950;
        Fri, 15 Sep 2023 08:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=//2nAYjOmcE5p4p0cxze69B6rxCiDlRI7WFYWaMvEb4=;
 b=j8VwC+7TvMKTWNwb4llxo1hGqoXl5ht5rrHqb2i6itjPIhfmorTa+s9yDUDcXiElamo/
 YFmocDgKWrjkVdnXr1GhjjX1s6LZX4qs11kclFU4vcslj16a/b8ghCJ6TEh8noexiR7p
 zC7WJWPkl4Z1SVJqDs8nAwjO3Hg3ZAgLLW8eBnNx5RzvhX5EII2Ads0guu7plgQ1J+fr
 RzQjWxpdkav+Ye6iBc4VUxgMfHKmXPe2PLG+oX3zNRtJg+NwNF976jrLX3+ELeO5od24
 NxLotJHS52RNAUUjXQ974gyY8h0WKF5ainobIc30ztnt4+gTReOXpOboMA2rSVHC92VZ KQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4g070k6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 08:52:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38F8qsEY030335
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 08:52:54 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 15 Sep
 2023 01:52:46 -0700
Message-ID: <c993ecc1-771e-4061-bd10-d3dea1254389@quicinc.com>
Date:   Fri, 15 Sep 2023 16:52:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] dt-bindings: arm-smmu: Add compatible for SM4450
 SoC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <catalin.marinas@arm.com>
CC:     <geert+renesas@glider.be>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tdas@quicinc.com>, <quic_tingweiz@quicinc.com>,
        <quic_aiquny@quicinc.com>, <kernel@quicinc.com>
References: <20230915021509.25773-1-quic_tengfan@quicinc.com>
 <20230915021509.25773-3-quic_tengfan@quicinc.com>
 <5a386be4-facc-8aef-aad7-da6508aa0505@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <5a386be4-facc-8aef-aad7-da6508aa0505@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nGgYYbeD4lV7XyvjzAflKbgSpdyEaIWU
X-Proofpoint-ORIG-GUID: nGgYYbeD4lV7XyvjzAflKbgSpdyEaIWU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_05,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=983 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150077
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 9/15/2023 3:11 PM, Krzysztof Kozlowski 写道:
> On 15/09/2023 04:15, Tengfei Fan wrote:
>> Add the SoC specific compatible for SM4450 implementing arm,mmu-500.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> index cf29ab10501c..b57751c8ad90 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> @@ -47,6 +47,7 @@ properties:
>>                 - qcom,sdx55-smmu-500
>>                 - qcom,sdx65-smmu-500
>>                 - qcom,sdx75-smmu-500
>> +              - qcom,sm4450-smmu-500
>>                 - qcom,sm6115-smmu-500
>>                 - qcom,sm6125-smmu-500
>>                 - qcom,sm6350-smmu-500
>> @@ -70,6 +71,7 @@ properties:
>>                 - qcom,sc8180x-smmu-500
>>                 - qcom,sc8280xp-smmu-500
>>                 - qcom,sdm845-smmu-500
>> +              - qcom,sm4450-smmu-500
> 
> Isn't there comment just few lines above your edit? Comment saying DON'T?
> 
> 
> Best regards,
> Krzysztof
> 
Hi Kraysztof
I seems haven't understand your comments totaly.
I want to confirm that if you think only need "qcom,smmu-500" and 
"arm,mmu-500" compitbale name, needn't specific compitable name for each 
platform?

-- 
Thx and BRs,
Tengfei Fan
