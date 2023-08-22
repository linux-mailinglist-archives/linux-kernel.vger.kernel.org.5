Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F867839E8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 08:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbjHVG1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 02:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjHVG1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 02:27:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C530B198;
        Mon, 21 Aug 2023 23:27:39 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37M4lNcX003340;
        Tue, 22 Aug 2023 06:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=IoSf8cbXFwS5Xr7IDNZ1rK6UZA1a0iDNuvCxeYTH86I=;
 b=oQCBJmBeYQO7Nb72q38drZvAl0g/TRwLyn8kPluwJcLDmmFFoMzd3wI8Hg+CEuOPh1Xh
 jxK0Dcnt3VaFbCqXrK3gWMvOp9sddUUv3ja+YvY3TD158uDcvGqMQJ5HoR7bTiPZLoFr
 ceo7sgEqTj7j5U/idmNe5eFM8UW146eORxQk5xiGPX6J6Zy+edCILWSTGqoe5GvQ1W19
 Lp01j7gXiEnUf2vIoQdYBkWhhGNZmAW4ZQLS06anlFrh8/j426QQfFGANbkqrDmfsb6j
 n/sLkEXu6V2WjOiwe/i4nLJEndmm0hUeVXjD3O8Vcqo43FyaUFfIkDeQrtlNai6gUv9G tA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3smfjs8rjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 06:27:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37M6RYm1024435
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 06:27:34 GMT
Received: from [10.214.27.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 21 Aug
 2023 23:27:31 -0700
Message-ID: <e8bd304b-2ec9-cbdd-b5ad-f8a0ff552c77@quicinc.com>
Date:   Tue, 22 Aug 2023 11:57:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 2/4] arm: dts: qcom: Add the rpmhpd header
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <cros-qcom-dts-watchers@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1690781104-2290-1-git-send-email-quic_rohiagar@quicinc.com>
 <1690781104-2290-3-git-send-email-quic_rohiagar@quicinc.com>
 <20230821151430.GA1643924-robh@kernel.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <20230821151430.GA1643924-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6cVA2CJ48zPD-n3YHA35m_IKUqYMpAXO
X-Proofpoint-GUID: 6cVA2CJ48zPD-n3YHA35m_IKUqYMpAXO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_04,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=371
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308220050
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/21/2023 8:44 PM, Rob Herring wrote:
> On Mon, Jul 31, 2023 at 10:55:02AM +0530, Rohit Agarwal wrote:
>> Add the rpmhpd header having the definition of the regulator levels
>> for Qualcomm SoCs.
>>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> ---
>>   arch/arm/boot/dts/qcom/qcom-sdx55.dtsi | 1 +
>>   arch/arm/boot/dts/qcom/qcom-sdx65.dtsi | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
>> index df3cd9c..8ffb2a0 100644
>> --- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
>> +++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
>> @@ -12,6 +12,7 @@
>>   #include <dt-bindings/interconnect/qcom,sdx55.h>
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/power/qcom-rpmpd.h>
>> +#include <dt-bindings/power/qcom,rpmhpd.h>
> If patch 4 isn't applied, aren't you going to get warnings about
> redefining the defines since you have them twice?
Isnt that just a macro so redefining wont give any warning. Please 
correct me if I am wrong.
But, I dont see any warnings while compiling without the 4th patch.

Thanks,
Rohit.
>>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>   
>>   / {
>> diff --git a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
>> index 1a35830..f990f5d 100644
>> --- a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
>> +++ b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
>> @@ -11,6 +11,7 @@
>>   #include <dt-bindings/gpio/gpio.h>
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/power/qcom-rpmpd.h>
>> +#include <dt-bindings/power/qcom,rpmhpd.h>
>>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>   #include <dt-bindings/interconnect/qcom,sdx65.h>
>>   
>> -- 
>> 2.7.4
>>
