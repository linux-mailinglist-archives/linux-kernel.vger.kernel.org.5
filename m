Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305547840A3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbjHVMWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbjHVMWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:22:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567561AD;
        Tue, 22 Aug 2023 05:22:43 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MAmrRR021242;
        Tue, 22 Aug 2023 11:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=lCdAPI2hcrWwv6X1FcNOPHd3uT54TPscRSxMqBnc0s8=;
 b=nn4c1bh1bGsrEIEVG13jVDu7eqJ+rXr0j/avfYgv0zqwr4rkbA67Fzie/kMxNdlTSjQr
 mVkQYYpEi14vaZrEmYq/60/+J93cSB4irP6WhLbyZi6jkeqLngmVbGd6kIK0vLpXW0v1
 rGLT/3xvQZmTOQeYk3xaHE2lu2fePN0+5hS4QgFLLSTHAaQejp4zEXLV33dIurPc3qPG
 Fe+Wju5dhfLWURsUANRIzYaUPTAJzFCqhdxuoIZhKYLV17r+DxwzVmEjcVp/9Fgobj4s
 SKbUF0GDXXmxCY4LOANrTF1S45RhViOXF/MpTFeGyj/XagAKFl8Cy+V2hdq+KAPJsrwj tQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3smgeq16tk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 11:46:43 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37MBkXam006245
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 11:46:33 GMT
Received: from [10.216.34.168] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 22 Aug
 2023 04:46:27 -0700
Message-ID: <bb1b6310-0142-800a-8edb-fb9163d8da75@quicinc.com>
Date:   Tue, 22 Aug 2023 17:16:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/4] dt-bindings: clock: qcom: Add ECPRICC clocks for
 QDU1000 and QRU1000
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20230808051407.647395-1-quic_imrashai@quicinc.com>
 <20230808051407.647395-2-quic_imrashai@quicinc.com>
 <f4f6baa5-37af-f971-6c05-1070ee66501e@linaro.org>
Content-Language: en-US
From:   Imran Shaik <quic_imrashai@quicinc.com>
In-Reply-To: <f4f6baa5-37af-f971-6c05-1070ee66501e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XRvnFqoX-bqaMeO3OD1wydwDpceiFF4q
X-Proofpoint-ORIG-GUID: XRvnFqoX-bqaMeO3OD1wydwDpceiFF4q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_10,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308220089
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/16/2023 11:19 AM, Krzysztof Kozlowski wrote:
> On 08/08/2023 07:14, Imran Shaik wrote:
>> Add device tree bindings for qcom ecpri clock controller on QDU1000 and
>> QRU1000 SoCs.
>>
>> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
>> ---
>>   .../bindings/clock/qcom,qdu1000-ecpricc.yaml  |  68 +++++++
>>   .../dt-bindings/clock/qcom,qdu1000-ecpricc.h  | 192 ++++++++++++++++++
>>   2 files changed, 260 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/qcom,qdu1000-ecpricc.yaml
>>   create mode 100644 include/dt-bindings/clock/qcom,qdu1000-ecpricc.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,qdu1000-ecpricc.yaml b/Documentation/devicetree/bindings/clock/qcom,qdu1000-ecpricc.yaml
>> new file mode 100644
>> index 000000000000..db54052bf360
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/qcom,qdu1000-ecpricc.yaml
>> @@ -0,0 +1,68 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/qcom,qdu1000-ecpricc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm ECPRI Clock & Reset Controller for QDU1000 and QRU1000
>> +
>> +maintainers:
>> +  - Taniya Das <quic_tdas@quicinc.com>
>> +  - Imran Shaik <quic_imrashai@quicinc.com>
>> +
>> +description: |
>> +  Qualcomm ecpri clock control module which supports the clocks, resets
>> +  on QDU1000 and QRU1000
>> +
>> +  See also:: include/dt-bindings/clock/qcom,qdu1000-ecpricc.h
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,qdu1000-ecpricc
>> +
>> +  clocks:
>> +    items:
>> +      - description: Board XO source
>> +      - description: GPLL0 source from GCC
>> +      - description: GPLL1 source from GCC
>> +      - description: GPLL2 source from GCC
>> +      - description: GPLL3 source from GCC
>> +      - description: GPLL4 source from GCC
>> +      - description: GPLL5 source from GCC
>> +
>> +  '#clock-cells':
>> +    const: 1
>> +
>> +  '#reset-cells':
>> +    const: 1
>> +
>> +  reg:
>> +    maxItems: 1
> 
> Keep the same order as in required: below.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 

Sure, will update this in next series.

Thanks,
Imran
