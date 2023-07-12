Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCA1750EE5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbjGLQpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjGLQp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:45:29 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA4611B;
        Wed, 12 Jul 2023 09:45:28 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CDgDhU024621;
        Wed, 12 Jul 2023 16:44:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Ecv2JxhYijVtgzl9hWfCcUgczVGuOQqmpvz3ynsFnRA=;
 b=XDVNGf240CXJcETtLNGEh/cCBRb4pCDtJOJQXvr+FBj/CsY39az+BTh/jUwChJBvHeT/
 7+UMYE+EYs5m4d7/6c4CI2Tmabhk90gPXRkurTGnOdbV2wCKG8oYC1zs4OWDdpDkmk5L
 8otzzSVBFOCak154MjOmus/+ca8Ct8G9OVAg/r5sEHoumcP9m4jKE8qb26UZ4lRa3f+y
 40of8jEuGwS87dCorbYbz3xMMz2fhQUzbAjdAG8q/vIZppdTe8HsmCVnfH0l0F1ACBNT
 kN+isPcRShr/o87oNK1G0xHdWTB6wZJdONQuSNuu94g7PrtXtTtxSKVxqza8TtU449KZ dQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rseqpt48v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 16:44:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36CGipGb013382
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 16:44:52 GMT
Received: from [10.216.33.107] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 12 Jul
 2023 09:44:46 -0700
Message-ID: <4adcdd78-8cc3-8ea8-7195-4ece0527d627@quicinc.com>
Date:   Wed, 12 Jul 2023 22:14:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/5] dt-bindings: thermal: tsens: Add ipq5332
 compatible
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>
References: <20230712113539.4029941-1-quic_ipkumar@quicinc.com>
 <20230712113539.4029941-3-quic_ipkumar@quicinc.com>
 <f31e9ff1-807b-c252-6f7e-146aba844fd9@linaro.org>
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <f31e9ff1-807b-c252-6f7e-146aba844fd9@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: R5CWdmS8An8U0na_MfefeWrU8AF9HpJc
X-Proofpoint-ORIG-GUID: R5CWdmS8An8U0na_MfefeWrU8AF9HpJc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_11,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120150
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/12/2023 7:55 PM, Krzysztof Kozlowski wrote:
> On 12/07/2023 13:35, Praveenkumar I wrote:
>> IPQ5332 uses TSENS v2.3.3 with combined interrupt. RPM is not
>> available in the SoC, hence adding new compatible to have the
>> sensor enablement and calibration function.
>>
>> This patch also adds nvmem-cell-names for ipq5332
>>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> ---
>> [v2]:
>> 	Followed the order for ipq5332 and added nvmem-cell-names.
>>
>>   .../devicetree/bindings/thermal/qcom-tsens.yaml      | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>> index 27e9e16e6455..cca115906762 100644
>> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>> @@ -69,6 +69,7 @@ properties:
>>   
>>         - description: v2 of TSENS with combined interrupt
>>           enum:
>> +          - qcom,ipq5332-tsens
>>             - qcom,ipq8074-tsens
>>   
>>         - description: v2 of TSENS with combined interrupt
>> @@ -205,6 +206,15 @@ properties:
>>             - const: s9_p2_backup
>>             - const: s10_p1_backup
>>             - const: s10_p2_backup
>> +      - items:
>> +          - const: mode
>> +          - const: base0
>> +          - const: base1
>> +          - pattern: '^s[0-9]+$'
>> +          - pattern: '^s[0-9]+$'
>> +          - pattern: '^s[0-9]+$'
>> +          - pattern: '^s[0-9]+$'
>> +          - pattern: '^s[0-9]+$'
> Previously there were 17 items here. What changed?
Previously I have added all the available sensor offsets in QFPROM. But 
in IPQ5332,only 5 sensors are present.
Other sensors not present/wired in the SoC, hence updated only for 5 
sensors now.

--
Thanks,
Praveenkumar
>
> Best regards,
> Krzysztof
>
