Return-Path: <linux-kernel+bounces-148119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B658A7DF2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64F31F2203D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C307F7CA;
	Wed, 17 Apr 2024 08:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ivKuyAT5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBEE7D3E4;
	Wed, 17 Apr 2024 08:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713341847; cv=none; b=GUGLQEwEKwCXYI0lxiw6+KgrPKrQwivtZkNqZ5XNcrHW7l6SbK0iPpCQcQVJlO2GocNWBvaU+iOC0vUHinLdfisJKyDFl5Ta44B1nlM2bXo9+JdNGwBfKjRJ4eb+v7cpqn18ZI900be2X5Wm2bMLtpBAWW1vDvoKytar9bZJau0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713341847; c=relaxed/simple;
	bh=RM9ZBHtvZ8LTwszIbZZWTkb98vredc/IQ7JGaF2pg7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ltLxWYI6J/3Xf2dY5Za1Gt0I2cF4YnxwQ55bkKh3FUv5jjZrErrq9FX/1zruR0DuGt6ygqnRIJ3cs5BJa1ggOfOwt4ApbBecS2A7XR27yxVw/PRoAglySKsDy46KuFlZ3G7s3RWhpMctKbrlSzrsTAGiUxUjzSw6qKvr7BYqaNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ivKuyAT5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H6pNTJ005096;
	Wed, 17 Apr 2024 08:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Htu9QXA5aLlbaAxRyDgW1Hl5A5etbp7+sMkhoF3/F+k=; b=iv
	KuyAT5kwmF+JgfSVVFVVg9RlSOiK0WPriR1IYBxryrfPHv/qrEPfgc/Fzi7VwoQk
	yk+c05xdPvWpMjUq4Ihu6w05qzojExFLCPPFxFZ/o1a7ubQ7VlQegaoyVnDeTfjT
	oJQTSP6yZM9xqvWXLhUlD63Bt6VNv2Wn5mwZAZ+v0d3Bprg+lyPswhm2x9bu8nja
	Jir3aCKrkRkJ7yZQiF2T+TRviFRMkKqoNmv9/eC9+3NqfcIqFpV7qxDxmEKDP2YB
	cIaHfNxILBxJoD7gC+Q/MFdY87DbVjpSr9UZf92wVYhjhP3yA1anup+7TOv+BcXs
	HPTqQ6A8NSGP8r1eT79g==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xj2sxs1wj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 08:17:09 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43H8H8uX007517
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 08:17:08 GMT
Received: from [10.216.25.227] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Apr
 2024 01:17:03 -0700
Message-ID: <13bff1dd-d134-e5ab-6691-b2bcb0a786c8@quicinc.com>
Date: Wed, 17 Apr 2024 13:47:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/8] ASoC: dt-bindings: wcd937x-sdw: add bindings for
 wcd937x-sdw
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
CC: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami
	<bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai
	<tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-sound@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <quic_pkumpatl@quicinc.com>
References: <20240416063600.309747-1-quic_mohs@quicinc.com>
 <20240416063600.309747-4-quic_mohs@quicinc.com>
 <20240416143237.GA2250258-robh@kernel.org>
From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
In-Reply-To: <20240416143237.GA2250258-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0HHyvM2ank2fxScBe0q2l6VEcz40MkiC
X-Proofpoint-ORIG-GUID: 0HHyvM2ank2fxScBe0q2l6VEcz40MkiC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_07,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170056

On 4/16/2024 8:02 PM, Rob Herring wrote:
> On Tue, Apr 16, 2024 at 12:05:55PM +0530, Mohammad Rafi Shaik wrote:
>> From: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
>>
>> Qualcomm WCD9370/WCD9375 Codec is a standalone Hi-Fi audio codec IC
>> connected over SoundWire. This device has two SoundWire devices RX and
>> TX respectively.
>> This binding is for those slave devices on WCD9370/WCD9375.
>>
>> Co-developed-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
>> Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
>> Signed-off-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
>> ---
>>   .../bindings/sound/qcom,wcd937x-sdw.yaml      | 71 +++++++++++++++++++
>>   1 file changed, 71 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.yaml
>> new file mode 100644
>> index 000000000000..2b7358e266ba
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.yaml
>> @@ -0,0 +1,71 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/qcom,wcd937x-sdw.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm SoundWire Slave devices on WCD9370
>> +
>> +maintainers:
>> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> +
>> +description: |
> 
> Don't need '|' if no formatting.
> 
>> +  Qualcomm WCD9370 Codec is a standalone Hi-Fi audio codec IC.
>> +  It has RX and TX Soundwire slave devices. This bindings is for the
>> +  slave devices.
>> +
>> +properties:
>> +  compatible:
>> +    const: sdw20217010a00
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  qcom,tx-port-mapping:
>> +    description: |
>> +      Specifies static port mapping between slave and master tx ports.
>> +      In the order of slave port index.
> 
> Are there constraints on the values of the entries?

The port mapping entries are fixed values.
There is no constraints.

Thanks
Rafi
> 
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    minItems: 4
>> +    maxItems: 4
>> +
>> +  qcom,rx-port-mapping:
>> +    description: |
>> +      Specifies static port mapping between slave and master rx ports.
>> +      In the order of slave port index.
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    minItems: 5
>> +    maxItems: 5
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - qcom,port-mapping
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    soundwire@3210000 {
>> +        #address-cells = <2>;
>> +        #size-cells = <0>;
>> +        reg = <0x03210000 0x2000>;
>> +        wcd937x_rx: codec@0,4 {
>> +            compatible = "sdw20217010a00";
>> +            reg  = <0 4>;
>> +            qcom,rx-port-mapping = <1 2 3 4 5>;
>> +        };
>> +    };
>> +
>> +    soundwire@3230000 {
>> +        #address-cells = <2>;
>> +        #size-cells = <0>;
>> +        reg = <0x03230000 0x2000>;
>> +        wcd937x_tx: codec@0,3 {
>> +            compatible = "sdw20217010a00";
>> +            reg  = <0 3>;
>> +            qcom,tx-port-mapping = <2 3 4 5>;
>> +        };
>> +    };
>> +
>> +...
>> -- 
>> 2.25.1
>>


