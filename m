Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776C5766EE7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbjG1N5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbjG1N5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:57:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964182D57;
        Fri, 28 Jul 2023 06:57:17 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SDiMIg022462;
        Fri, 28 Jul 2023 13:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=15y0Ty6oih9ty6hZch5B/zAFsQYPV6AL1PQ9UOnltj8=;
 b=lDShtFYeZJPkmKTL/P50qldmgFCZ05cvUJQHoHwQeJcmbwN3EJcpOrmm/e9ZgDbTmprK
 wuMdibEIiHMzKpLHibxqiserhPSeYcKVt/iuPvYj/OnKXhhn6ypNV9tfQflW7it+aqZH
 6VwtfKjcMUb5eaiJHf0vj5RoKeEH0u5kAn+95e5paQo8ye3nSjBLs9PK00sKcAGsf5/E
 MMU8T+YvROZHKLptrowtQZQ3Q7OZCAnmRjqRdAdEYO7cXjDvzCljT4WypRwX6DX3K1u8
 S47O+fvB6xIYjtaaL3myzJr+4OdGeBzc8mhaGfUEjBhTLp2ek/DIRs8vVCKG7XHwroDW Sg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s46tth1qd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 13:57:14 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36SDvCNm006419
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 13:57:12 GMT
Received: from [10.214.230.142] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 28 Jul
 2023 06:57:08 -0700
Message-ID: <25bd2fe1-a981-b30b-ad99-71fe447bf67b@quicinc.com>
Date:   Fri, 28 Jul 2023 19:27:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 1/2] dt-bindings: nvmem: sec-qfprom: Add bindings for
 secure qfprom
Content-Language: en-US
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230724083849.8277-1-quic_kbajaj@quicinc.com>
 <20230724083849.8277-2-quic_kbajaj@quicinc.com>
 <33f2d056-e65d-4bc2-8a1b-bb5815752014@quicinc.com>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <33f2d056-e65d-4bc2-8a1b-bb5815752014@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xV3rXZZQkr5Cjf_KUHs6qgjhglbJUNaX
X-Proofpoint-GUID: xV3rXZZQkr5Cjf_KUHs6qgjhglbJUNaX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=541
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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



On 7/27/2023 2:39 PM, Pavan Kondeti wrote:
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
> [...]
>
>> +$id: http://devicetree.org/schemas/nvmem/qcom,sec-qfprom.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Technologies Inc, Secure QFPROM Efuse
>> +
>> +maintainers:
>> +  - Komal Bajaj <quic_kbajaj@quicinc.com>
>> +
>> +description: |
>> +  For some of the Qualcomm SoC's, it is possible that
>> +  the qfprom region is protected from non-secure access.
>> +  In such situations, linux will have to use secure calls
>> +  to read the region.
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
> minor nitpick:
>
> Since this device does not have any clocks, the above header inclusion
> can be dropped.

Yes, it is not needed, will drop it.

Thanks
Komal

>
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
> Thanks,
> Pavan

