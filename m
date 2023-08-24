Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225BD786BE9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240161AbjHXJa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239433AbjHXJ34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:29:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8CC10F;
        Thu, 24 Aug 2023 02:29:54 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37O9SWaj017447;
        Thu, 24 Aug 2023 09:29:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6bZ620qEvkbrHV7D/BfIRZQUDwzV6fiMdsV1nBDq/NE=;
 b=e2aBXhzpD9f/K/BDbmwUeqAuRLHTsKQtaAFBk2o+B4RpWAP8WwIOoOeZV9FHBJY20IJa
 bmnfFQHZxj8K1tPA5adIzsmzB2eDbdlLxZcn/cH3wbwQF54Ps2T468j3DhlGqU3h0wB0
 2nuJeWJPlL9CJBOVYg7TEfJkDgL0UyF5m+3gpW7X2pNopfGA1y6lTfJxOkziSp7AuqZa
 EmLkVWJB1x+Dupux0M2UcpP0P4JddZ8bp5Rlxl9lMruAQk38kGpFb34Se+JAz8WHcXEE
 MtkcH29JHstaJLkG80EUnJKbCtaxu5SmwCvI+wdKUzGvHdIeorv1jINVnzq8f/iHJIW+ Jw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3snkumsyek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 09:29:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37O9Tegd003868
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 09:29:40 GMT
Received: from [10.216.60.202] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 24 Aug
 2023 02:29:34 -0700
Message-ID: <6df0d730-7fa0-f0f3-ceb8-b011feaff824@quicinc.com>
Date:   Thu, 24 Aug 2023 14:59:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] dt-bindings: thermal: tsens: Add sa8775p compatible
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_manafm@quicinc.com>
References: <20230821112928.19284-1-quic_priyjain@quicinc.com>
 <20230821112928.19284-2-quic_priyjain@quicinc.com>
 <ea0a31ac-6860-4cd2-a2ec-25416d035278@linaro.org>
From:   Priyansh Jain <quic_priyjain@quicinc.com>
In-Reply-To: <ea0a31ac-6860-4cd2-a2ec-25416d035278@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0JRwRwWSu2AKDMI40Wu9PBF981uLJDgh
X-Proofpoint-ORIG-GUID: 0JRwRwWSu2AKDMI40Wu9PBF981uLJDgh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_06,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308240076
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

On 8/21/2023 5:21 PM, Konrad Dybcio wrote:
> On 21.08.2023 13:29, Priyansh Jain wrote:
>> Add compatibility string for the thermal sensors on sa8775p platform.
>>
>> Signed-off-by: Priyansh Jain <quic_priyjain@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>> index 27e9e16e6455..37d0c9150327 100644
>> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>> @@ -65,6 +65,7 @@ properties:
>>                 - qcom,sm8350-tsens
>>                 - qcom,sm8450-tsens
>>                 - qcom,sm8550-tsens
>> +              - qcom,sa8775p-tsens
>>             - const: qcom,tsens-v2
> Please keep this sorted alphanumerically.
Sure will update in next revision.
> Konrad
