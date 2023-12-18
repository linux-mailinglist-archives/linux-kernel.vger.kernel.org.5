Return-Path: <linux-kernel+bounces-3240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C4D8169BD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB871F23098
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D567125B0;
	Mon, 18 Dec 2023 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LO0gjkCJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D96611C82;
	Mon, 18 Dec 2023 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BI8F7SS009591;
	Mon, 18 Dec 2023 09:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=eqNU+wI7c51LjdCSDXdyX5iD4gjSXnctMsoSiFsfA7c=; b=LO
	0gjkCJW2bJjuIo4HT7Gavs7h/cFHbfjlzWTJRxYaWnkJUd2VgGqhFcNmS6Qqr612
	kNzvujKQQhW9wodMjmMVZnQJtdJ3SMge+lbC+y+DqNue1tYq21mGnkSCc/bu8aoH
	eiA+KUhMWBAbwb3fQzNagLti5b8cqtUTi2BK+7naNZfpOXchPeFsAffxzoEte+Xx
	nMf6qlxyPjtwnCzq5d8/lxi0OVg1kbd2ep8GKUh96i1zFoXMf7AJlx6spKFqf9Oz
	GJEd7W0sHv9mTi4jnxigV738XeBP4Cp2QRd/hzY+zXr90KtptmXrjHZGvCAphkl4
	ylYCSOHgagKOL5j6GgXg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v152qbur0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 09:21:41 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BI9Le5p011492
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 09:21:40 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 18 Dec
 2023 01:21:35 -0800
Message-ID: <7d906e89-827f-49c7-96a2-004919218a26@quicinc.com>
Date: Mon, 18 Dec 2023 17:21:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] dt-bindings: arm: Add support for CMB element size
To: James Clark <james.clark@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Jinlong Mao <quic_jinlmao@quicinc.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni
	<quic_tsoni@quicinc.com>,
        Song Chai <quic_songchai@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <andersson@kernel.org>, Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio
	<konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>
References: <1700533494-19276-1-git-send-email-quic_taozha@quicinc.com>
 <1700533494-19276-2-git-send-email-quic_taozha@quicinc.com>
 <09447d69-e0ce-13e9-95ea-0db475b8bb6e@arm.com>
Content-Language: en-US
From: Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <09447d69-e0ce-13e9-95ea-0db475b8bb6e@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RLdUNNWjX9wsKBgMsoNfq-2rfbODkJls
X-Proofpoint-GUID: RLdUNNWjX9wsKBgMsoNfq-2rfbODkJls
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1011 malwarescore=0 mlxlogscore=814
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180066


On 12/15/2023 7:19 PM, James Clark wrote:
>
> On 21/11/2023 02:24, Tao Zhang wrote:
>> Add property "qcom,cmb-elem-size" to support CMB(Continuous
>> Multi-Bit) element for TPDM. The associated aggregator will read
>> this size before it is enabled. CMB element size currently only
>> supports 32-bit and 64-bit.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> ---
>>   .../bindings/arm/qcom,coresight-tpdm.yaml     | 28 +++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
>> index 61ddc3b5b247..0d9fe01a8b15 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
>> @@ -52,6 +52,15 @@ properties:
>>       $ref: /schemas/types.yaml#/definitions/uint8
>>       enum: [32, 64]
>>   
>> +  qcom,cmb-element-size:
>> +    description:
>> +      Specifies the CMB(Continuous Multi-Bit) element size supported by
>> +      the monitor. The associated aggregator will read this size before it
>> +      is enabled. CMB element size currently only supports 8-bit, 32-bit
>> +      and 64-bit.
>> +    $ref: /schemas/types.yaml#/definitions/uint8
>> +    enum: [8, 32, 64]
>> +
>>     qcom,dsb-msrs-num:
>>       description:
>>         Specifies the number of DSB(Discrete Single Bit) MSR(mux select register)
>> @@ -110,4 +119,23 @@ examples:
>>         };
>>       };
>>   
>> +    tpdm@6c29000 {
>> +      compatible = "qcom,coresight-tpdm", "arm,primecell";
>> +      reg = <0x06c29000 0x1000>;
>> +      reg-names = "tpdm-base";
> I think this one gives this error:
>
>   $ make dt_binding_check DT_SCHEMA_FILES=arm/qcom,coresight
>
>   DTC_CHK Documentation/devicetree/bindings/arm/qcom,coresight-
>    tpdm.example.dtb
>   qcom,coresight-tpdm.example.dtb: tpdm@6c29000: 'reg-names' does not
>    match any of the regexes: 'pinctrl-[0-9]+'
>          from schema $id: http://devicetree.org/schemas
>          /arm/qcom,coresight-tpdm.yaml#

I will fix this in the next patch series.


Best,

Tao

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

