Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B11D7571D9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 04:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjGRChf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 22:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGRChd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 22:37:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9922910C7;
        Mon, 17 Jul 2023 19:37:31 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36I2W6tp012078;
        Tue, 18 Jul 2023 02:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=T9CKhz+EHs+ldtZocIgatXObTDYOJIeNM4t29hyF+rg=;
 b=iHlhCcUUruoovGl4bom+HjuQQpWkCYrJhAAZWAG/azsa9M/RTtB3ju/BtBiUDZl9ak33
 Yn9bICAoIL9bokhuxIwq11lx/AkrugZpifa7w6hiaGxAJh0AMX8ZaxvDvF1RrBRpZJNy
 NscJr2lhwwomlOa5ifp+4ahxFHC+d09xBaaCiey2KypuLr2Bv9moC49k7PPbyA7V4+3y
 eWJPMpoKUcoXtFxKyJQ7bu2IsitcZLMrhXE8gcUTOJkbUFhZ3MN/knH3qurysx/fLGer
 rkITIgHPTHO8tObye+aCUjPFbjuuNrtfJuKvvbereplFOlE73OTUAW6uK+j+FCnpetxS uw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3run1jcxfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 02:37:27 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36I2bPpb032471
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 02:37:25 GMT
Received: from [10.239.154.73] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 17 Jul
 2023 19:37:22 -0700
Message-ID: <2b1301e6-fac3-7a06-6716-a65ffd0be7c2@quicinc.com>
Date:   Tue, 18 Jul 2023 10:37:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1 1/2] dt-bindings: input: qcom,pm8xxx-vib: add more PMIC
 support
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
        <quic_kamalw@quicinc.com>, <jestar@qti.qualcomm.com>
References: <20230717062547.2086869-1-quic_fenglinw@quicinc.com>
 <20230717062547.2086869-2-quic_fenglinw@quicinc.com>
 <6338cc75-e3fe-ba19-3df7-727b63fec245@linaro.org>
Content-Language: en-US
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <6338cc75-e3fe-ba19-3df7-727b63fec245@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DfzgLbA65DS-cEQR5qDEIk7iq-SCeqeq
X-Proofpoint-ORIG-GUID: DfzgLbA65DS-cEQR5qDEIk7iq-SCeqeq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 clxscore=1011 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=988
 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180022
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/18/2023 3:59 AM, Krzysztof Kozlowski wrote:
> On 17/07/2023 08:25, Fenglin Wu wrote:
>> Add support for vibrator module inside Qualcomm PMI632, PM7250B, PM7325B
>> and PM7550BA PMICs.
>>
>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
>> index c8832cd0d7da..642408e2b35f 100644
>> --- a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
>> +++ b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
>> @@ -15,6 +15,10 @@ properties:
>>         - qcom,pm8058-vib
>>         - qcom,pm8916-vib
>>         - qcom,pm8921-vib
>> +      - qcom,pmi632-vib
>> +      - qcom,pm7250b-vib
>> +      - qcom,pm7325b-vib
>> +      - qcom,pm7550ba-vib
> 
> Aren't the last two compatible?

There are still every different PMICs even though the vibrator module in 
PM7325B and PM7550BA are the same and they share the same register base 
address as well.

> 
> Best regards,
> Krzysztof
> 
