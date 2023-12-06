Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E34806E46
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377748AbjLFLrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377634AbjLFLrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:47:13 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C75A8F;
        Wed,  6 Dec 2023 03:47:20 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B64tA5b025974;
        Wed, 6 Dec 2023 11:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qYzF+lPCV2W5wRZWSwD+SxHZZNEer3OthZmLgZk4EVw=;
 b=atHDuOZGY3tQ6Azc4qVLDt6VzBx9jp17UA2O+Su2Mv3Js9TFbEKntyVlDdofn/hWw9dC
 raxrQQ2nkUhr777/F+c4aUdampzb0U4Wz7WnwxkWXH81vUKzEsBU8F/SP6BDo9H4chPI
 klOhVKylDaWGGbcJ+vf+Di79ENaEazvTwMqMZikvMMHdpBAa7CmCh/uQgxiVWFLlbX1t
 ls1Sn8q0z8FyCAhd4otbN+1efXvyVkcjVob7WDrJS85ze3JIs0tY/pA9KJgPj9QDyBr2
 7qtWsw0ihPIyD94/OQC1JCYPRC7zksUN/2vTxLHHhiyf/8Ju4/k1p9bzjNrMdv2Liaus Yg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3utdmd1ft4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Dec 2023 11:47:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B6BlFIS026165
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Dec 2023 11:47:15 GMT
Received: from [10.239.133.49] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Dec
 2023 03:47:12 -0800
Message-ID: <cb06e6c4-d597-4bba-8292-f26d6089de16@quicinc.com>
Date:   Wed, 6 Dec 2023 19:47:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: arm: Add remote etm dt-binding
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>
References: <20231205082922.32149-1-quic_jinlmao@quicinc.com>
 <20231205082922.32149-2-quic_jinlmao@quicinc.com>
 <cb41490a-72f8-4eb4-b9ff-3823fa452a39@linaro.org>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <cb41490a-72f8-4eb4-b9ff-3823fa452a39@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JTqR_LaVtYJGpsp7itKq7fd7-J6bJL2w
X-Proofpoint-ORIG-GUID: JTqR_LaVtYJGpsp7itKq7fd7-J6bJL2w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_09,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=762 spamscore=0
 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/2023 7:25 PM, Krzysztof Kozlowski wrote:
> On 05/12/2023 09:29, Mao Jinlong wrote:
>> Remote ETM(Embedded Trace Macrocell) is to capture information of
>> the executed processor instructions of remote processors like modem.
>> Add new coresight-remote-etm.yaml file describing the bindings
>> required to define coresight remote etm in the device trees.
>>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> 
> 
>> +description:
>> +  Support for ETM trace collection on remote processor using coresight
>> +  framework. Enabling this will allow turning on ETM tracing on remote
>> +  processor like modem processor via sysfs and collecting the trace
>> +  via coresight TMC sinks.
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,coresight-remote-etm
>> +
>> +  qcom,inst-id:
> 
> I did not receive my answer about this property one month ago, so:
> NAK, drop this property.

Thanks for the review. I will remove this first and add it back with 
driver codes.
> 
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      Each kind of remote ETM has its unique instance id. The remote etm will
>> +      be enabled/disabled on remote processor based on the id send from
>> +      ap processor.
>> +
>> +  out-ports:
>> +    $ref: /schemas/graph.yaml#/properties/ports
>> +    additionalProperties: false
>> +
>> +    properties:
>> +      port:
>> +        description: Output connection to the CoreSight Trace bus.
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +
>> +required:
>> +  - compatible
>> +  - qcom,inst-id
>> +  - out-ports
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    modem-etm0 {
> 
> etm {
> 
>> +          compatible = "qcom,coresight-remote-etm";
>> +          qcom,inst-id = <2>;
>> +
>> +          out-ports {
>> +              port {
>> +                  modem_etm0_out_funnel_modem: endpoint {
>> +                  remote-endpoint = <&funnel_modem_in_modem_etm0>;
> 
> Missing indentation level
> 
I will make changes in next version.

>> +                  };
>> +              };
>> +          };
>> +    };
>> +...
> 
> Best regards,
> Krzysztof
> 
