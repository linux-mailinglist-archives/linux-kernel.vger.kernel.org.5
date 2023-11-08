Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414C07E50DF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 08:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbjKHHVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 02:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjKHHVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 02:21:38 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09AF10F9;
        Tue,  7 Nov 2023 23:21:36 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A84TMvP024836;
        Wed, 8 Nov 2023 07:21:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fWksQUMil+B/Wy7CX7XDZrLx6f9mZ/XXlqnJLxZ7SOE=;
 b=o5dEzm8YHCVTB0kZURvBFg3/cNdasvbDoIykepPDReJiDAdZ6Z5TmhjHWHAsHZGAK75+
 vbg71byyk0uCku0VNZQGRZKqciFXVXRhZysVLHV8DriiaWfKCFOCBfI1XxANn6vfzrH1
 nItuiVCqrtJTHIqtKwzTNyc4FLBismth7DwIy2o7xl9UoO51vyvpIDkowp72Yw27UfpS
 hckabGhfDqXvXFZp/4Xm12eS5BABtzJwDR3Czskts7D8adRQjJNoPggQjJhLyha8qRb6
 qX6OP/n+ncIe6TM3yocxEPlCFB9uIiDeGKh7Xc8n/ZtxZS88y+58hRxvhDYmljXyUvOI vg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u7w2dry84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 07:21:24 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A87LNLj028235
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Nov 2023 07:21:23 GMT
Received: from [10.239.133.211] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 7 Nov
 2023 23:21:19 -0800
Message-ID: <d04c9db2-6198-46d4-81be-689a221a51ac@quicinc.com>
Date:   Wed, 8 Nov 2023 15:21:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] dt-bindings: arm: Add support for CMB element size
From:   Tao Zhang <quic_taozha@quicinc.com>
To:     Rob Herring <robh@kernel.org>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Song Chai <quic_songchai@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <andersson@kernel.org>
References: <1698202408-14608-1-git-send-email-quic_taozha@quicinc.com>
 <1698202408-14608-2-git-send-email-quic_taozha@quicinc.com>
 <20231026212546.GA420866-robh@kernel.org>
 <15cbd29f-100c-48cc-9fc6-fde222a783b1@quicinc.com>
Content-Language: en-US
In-Reply-To: <15cbd29f-100c-48cc-9fc6-fde222a783b1@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uzRSf08sCGLtn-KirOosotmjF8pp7ERp
X-Proofpoint-ORIG-GUID: uzRSf08sCGLtn-KirOosotmjF8pp7ERp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080059
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/1/2023 2:29 PM, Tao Zhang wrote:
>
> On 10/27/2023 5:25 AM, Rob Herring wrote:
>> On Wed, Oct 25, 2023 at 10:53:21AM +0800, Tao Zhang wrote:
>>> Add property "qcom,cmb-elem-size" to support CMB(Continuous
>>> Multi-Bit) element for TPDM. The associated aggregator will read
>>> this size before it is enabled. CMB element size currently only
>>> supports 32-bit and 64-bit.
>>>
>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>>> ---
>>>   .../bindings/arm/qcom,coresight-tpdm.yaml          | 27 
>>> ++++++++++++++++++++++
>>>   1 file changed, 27 insertions(+)
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml 
>>> b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
>>> index 61ddc3b..f9a2025 100644
>>> --- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
>>> @@ -52,6 +52,14 @@ properties:
>>>       $ref: /schemas/types.yaml#/definitions/uint8
>>>       enum: [32, 64]
>>>   +  qcom,cmb-element-size:
>> What are the units? Use '-bits' suffix.
>
> Yes, its unit should be bit.
>
> Do you mean that you prefer to use "qcom, cmb-element-size-bits"?
>
> Do I also need to replace "qcom, dsb-element-size" with "qcom, 
> dsb-element-size-bits".

I will continue to use the property name "qcom, cmb-element-size" in 
order to be consistent with "qcom, dsb-element-size".

Let me know if you have any concerns about this.


Best,

Tao

>
>>
>>> +    description:
>>> +      Specifies the CMB(Continuous Multi-Bit) element size 
>>> supported by
>>> +      the monitor. The associated aggregator will read this size 
>>> before it
>>> +      is enabled. CMB element size currently only supports 32-bit 
>>> and 64-bit.
>> The enum says 8-bit is supported.
>
> Yes, 8-bit is supported. I will update the description in the next 
> patch series.
>
>
> Best,
>
> Tao
>
>>
>>> +    $ref: /schemas/types.yaml#/definitions/uint8
>>> +    enum: [8, 32, 64]
>>> +
>>>     qcom,dsb-msrs-num:
>>>       description:
>>>         Specifies the number of DSB(Discrete Single Bit) MSR(mux 
>>> select register)
>>> @@ -110,4 +118,23 @@ examples:
>>>         };
>>>       };
>>>   +    tpdm@6c29000 {
>>> +      compatible = "qcom,coresight-tpdm", "arm,primecell";
>>> +      reg = <0x06c29000 0x1000>;
>>> +      reg-names = "tpdm-base";
>>> +
>>> +      qcom,cmb-element-size = /bits/ 8 <64>;
>>> +
>>> +      clocks = <&aoss_qmp>;
>>> +      clock-names = "apb_pclk";
>>> +
>>> +      out-ports {
>>> +        port {
>>> +          tpdm_ipcc_out_funnel_center: endpoint {
>>> +            remote-endpoint =
>>> +              <&funnel_center_in_tpdm_ipcc>;
>>> +          };
>>> +        };
>>> +      };
>>> +    };
>>>   ...
>>> -- 
>>> 2.7.4
>>>
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org
