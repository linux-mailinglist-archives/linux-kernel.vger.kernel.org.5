Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80697DDCA5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 07:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbjKAG3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 02:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjKAG3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 02:29:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A792F3;
        Tue, 31 Oct 2023 23:29:41 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A14U7Y3020727;
        Wed, 1 Nov 2023 06:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=uGYrLlifm1n3Hx30VsaPwPrpNELPWRagv4QHl4QU/Kw=;
 b=jcMmMX9TEQHK20b7dYzrwJHC9Nig9zJyzgHvRWzS5iXlkke66gNaT+1vHbwbDYdxbHug
 2kuyXeWNHX85dV9W8AMfNN3ZYx4bQd0S9atT5mSh7iBDWdQf6WcwjSyQVknO2FKKdham
 3XcQrswxvrmkYgBFe3bKK+VYyrHtG+vfU+5iqHsJbxP9z7ySdBvuJ5Q2gn52bEUq5kNg
 gCY/aeJphVRuZYpuF38dfsbtZ+zmsW8qp/8xl1diAc4Tv7s2bV34TQozSoHiCPH/JMpB
 2akpclDLN7oaZWjliw+HS3z/96r+M6W+OG4l95umCbmWc9UhNfrH2H7LGYMxBV+0tiKV Fw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u3382ja5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 06:29:25 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A16TOJh023479
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Nov 2023 06:29:24 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 31 Oct
 2023 23:29:20 -0700
Message-ID: <15cbd29f-100c-48cc-9fc6-fde222a783b1@quicinc.com>
Date:   Wed, 1 Nov 2023 14:29:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] dt-bindings: arm: Add support for CMB element size
To:     Rob Herring <robh@kernel.org>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
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
Content-Language: en-US
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <20231026212546.GA420866-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bd4b4EE1GKMEgn6-VN3E3o55PPe2lrt8
X-Proofpoint-ORIG-GUID: bd4b4EE1GKMEgn6-VN3E3o55PPe2lrt8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_03,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 adultscore=0 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311010054
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/27/2023 5:25 AM, Rob Herring wrote:
> On Wed, Oct 25, 2023 at 10:53:21AM +0800, Tao Zhang wrote:
>> Add property "qcom,cmb-elem-size" to support CMB(Continuous
>> Multi-Bit) element for TPDM. The associated aggregator will read
>> this size before it is enabled. CMB element size currently only
>> supports 32-bit and 64-bit.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> ---
>>   .../bindings/arm/qcom,coresight-tpdm.yaml          | 27 ++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
>> index 61ddc3b..f9a2025 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
>> @@ -52,6 +52,14 @@ properties:
>>       $ref: /schemas/types.yaml#/definitions/uint8
>>       enum: [32, 64]
>>   
>> +  qcom,cmb-element-size:
> What are the units? Use '-bits' suffix.

Yes, its unit should be bit.

Do you mean that you prefer to use "qcom, cmb-element-size-bits"?

Do I also need to replace "qcom, dsb-element-size" with "qcom, 
dsb-element-size-bits".

>
>> +    description:
>> +      Specifies the CMB(Continuous Multi-Bit) element size supported by
>> +      the monitor. The associated aggregator will read this size before it
>> +      is enabled. CMB element size currently only supports 32-bit and 64-bit.
> The enum says 8-bit is supported.

Yes, 8-bit is supported. I will update the description in the next patch 
series.


Best,

Tao

>
>> +    $ref: /schemas/types.yaml#/definitions/uint8
>> +    enum: [8, 32, 64]
>> +
>>     qcom,dsb-msrs-num:
>>       description:
>>         Specifies the number of DSB(Discrete Single Bit) MSR(mux select register)
>> @@ -110,4 +118,23 @@ examples:
>>         };
>>       };
>>   
>> +    tpdm@6c29000 {
>> +      compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +      reg = <0x06c29000 0x1000>;
>> +      reg-names = "tpdm-base";
>> +
>> +      qcom,cmb-element-size = /bits/ 8 <64>;
>> +
>> +      clocks = <&aoss_qmp>;
>> +      clock-names = "apb_pclk";
>> +
>> +      out-ports {
>> +        port {
>> +          tpdm_ipcc_out_funnel_center: endpoint {
>> +            remote-endpoint =
>> +              <&funnel_center_in_tpdm_ipcc>;
>> +          };
>> +        };
>> +      };
>> +    };
>>   ...
>> -- 
>> 2.7.4
>>
