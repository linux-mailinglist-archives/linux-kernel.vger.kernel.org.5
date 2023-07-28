Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C595A766EDA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236845AbjG1Nyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236357AbjG1Nyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:54:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCA2DB;
        Fri, 28 Jul 2023 06:54:39 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SDTsnb029491;
        Fri, 28 Jul 2023 13:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cUbZNwgkhLbcjo6iICAjiDjPRxWlHzzIVGzYr7g2vzw=;
 b=Lyv0m/EoroRiOclTDIkv0UDrL+/si1D7C2aSWaodLImctui5kHhw8uRw48wcNTunOmrg
 t69mBetaU+T99QilbdpShc8VKQCnmdj13wKagYYjEoFXrGfvfnjsXyGi0Vz0O0raaqpB
 R/ffLD9Une0vLmChsMkbX6Va+w5k9TmsBEOaOkRgFYtchyLBoiaZelnS7Yx1/NC94fUr
 5TFxyCdeG7k1UVd9uZvVguzqHKstuouVJPFG8z+CbJc1pIQIG8GdWkzHPRi3OJkS1r1D
 xOGtvQ91m6l7LHk011ZDFEvk7FO2g+aM1lPE9QzkxSzzg2BuuRRtPvGmRWy57n4TjUEp lQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s4e2704js-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 13:54:35 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36SDsYOf001485
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 13:54:34 GMT
Received: from [10.214.230.142] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 28 Jul
 2023 06:54:31 -0700
Message-ID: <2b870e62-9b74-7eae-7e91-eae26361b1e6@quicinc.com>
Date:   Fri, 28 Jul 2023 19:24:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 1/2] dt-bindings: nvmem: sec-qfprom: Add bindings for
 secure qfprom
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <srinivas.kandagatla@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230724083849.8277-1-quic_kbajaj@quicinc.com>
 <20230724083849.8277-2-quic_kbajaj@quicinc.com>
 <20230726164039.GA1558299-robh@kernel.org>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <20230726164039.GA1558299-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JdFMoo5rfHgGB1QDuY6KLc2JHF95vDFa
X-Proofpoint-ORIG-GUID: JdFMoo5rfHgGB1QDuY6KLc2JHF95vDFa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0
 impostorscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280128
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/2023 10:10 PM, Rob Herring wrote:
> On Mon, Jul 24, 2023 at 02:08:48PM +0530, Komal Bajaj wrote:
>> This patch adds bindings for secure qfprom found in QCOM SOCs.
>> Secure QFPROM driver is based on simple nvmem framework.
>>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
>>   .../bindings/nvmem/qcom,sec-qfprom.yaml       | 58 +++++++++++++++++++
>>   1 file changed, 58 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml
>> new file mode 100644
>> index 000000000000..1425ced36fdf
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml
>> @@ -0,0 +1,58 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/nvmem/qcom,sec-qfprom.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Technologies Inc, Secure QFPROM Efuse
>> +
>> +maintainers:
>> +  - Komal Bajaj <quic_kbajaj@quicinc.com>
>> +
>> +description: |
> Don't need '|'

Okay, will drop this.
Just a doubt here, when do we use this '|' symbol, I

  thought we will use this when
we have multi-line description/value.

>
>> +  For some of the Qualcomm SoC's, it is possible that
>> +  the qfprom region is protected from non-secure access.
>> +  In such situations, linux will have to use secure calls
> s/linux/the OS/

Will do it.

>
>> +  to read the region.
> Wrap lines at 80
>
> The wording for this is strange. Only sometimes for this binding do
> secure calls have to be used? If you are using secure calls, does that
> mean the 'reg' address is not directly accessible.

For this binding, we will always use secure calls because the 'reg' 
address is not directly
accessible to the OS.

Thanks
Komal

>
>> +
>> +allOf:
>> +  - $ref: nvmem.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - qcom,qdu1000-sec-qfprom
>> +      - const: qcom,sec-qfprom
>> +
>> +  reg:
>> +    items:
>> +      - description: The secure qfprom corrected region.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/qcom,gcc-sc7180.h>
>> +
>> +    soc {
>> +      #address-cells = <2>;
>> +      #size-cells = <2>;
>> +
>> +      efuse@221c8000 {
>> +        compatible = "qcom,qdu1000-sec-qfprom", "qcom,sec-qfprom";
>> +        reg = <0 0x221c8000 0 0x1000>;
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +
>> +        multi_chan_ddr: multi-chan-ddr@12b {
>> +          reg = <0x12b 0x1>;
>> +          bits = <0 2>;
>> +        };
>> +      };
>> +    };
>> +
>> --
>> 2.40.1
>>

