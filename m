Return-Path: <linux-kernel+bounces-72982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CF785BB6F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FA48282EFB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9987E67C74;
	Tue, 20 Feb 2024 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Kw14HRUB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F17E67C61;
	Tue, 20 Feb 2024 12:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708430821; cv=none; b=aYAepljz79Oxi16vwrxfNc7ZKQvXo+/Pfp4ghDx3gfovIsN9SBqIi+8NxJsMms85SzyKe0xaU9A+jG4OMLUEr7XyQ6uU48o4rXMDACpfnM4FUSG03FJnH7Xcjnyel5XMjnTSLKZqYuvbmJ1Qv2wSBVFC4BdVSr9dL7l9D/48a7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708430821; c=relaxed/simple;
	bh=38bn2fHxN8Ck7genRflG7wkA4fCw3Vpd41PgBFZgUC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SDlP6oTvfM0Mi2vEsdTC2iiKtL5N3OjrrzQfKp7EIlNziVMfBsGcmzQ4eV8AiNWT4SnuP7d2p5Ex6KgTzayBQsMki/SQkBbaXjFlq6VH9XaSzVtfiGuKuGJ+2VmiHcHNTvOXQhqhjr6+m513IU1VVAy7AT3CsLiXHIkXNN35XEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Kw14HRUB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41KAteL1004369;
	Tue, 20 Feb 2024 12:06:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=3Un3DywxvOe0E6Au+Vjnmv8pOY2C5ymlgd6WWC4EYZo=; b=Kw
	14HRUBbgb9LFrT62fSnlquI3rQRjJ11RaNMx24MuvUGkDMfqifKQYJ+jWquj9mGm
	/9GDXhuIYTFaxH8sl00mn0+aBzOEiKYWMNp7R2TWN9kUWrpHgdvFaM273JhT7CQP
	pZdVBfgO9VzgUgAzp+TTYuo3OfPrEPk7nFr3gJCevHfn5HSI1To2+gddB9TkwoW9
	24KTHpwWG/DO6n6IH8OVg1CYwdTDZxvliB53sxT0Gg0YPdhckN31JYkfOCW435rr
	U/tseWfZA7VwHX0lzaJdfXfM6ZR66f3vgv02Kuj5RzYAXklPrJQJjra7OEnV2yjB
	LHH9VhcmVKSFfxmMDbOQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wct3eg75b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 12:06:50 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41KC6mqI004735
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 12:06:49 GMT
Received: from [10.216.16.129] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 04:06:43 -0800
Message-ID: <0dae7231-6bd1-b7fc-4a5e-b0787b0adaba@quicinc.com>
Date: Tue, 20 Feb 2024 17:36:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/5] spi: dt-bindings: add binding doc for spi-qpic-snand
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <broonie@kernel.org>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <manivannan.sadhasivam@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.com>
References: <20240215134856.1313239-1-quic_mdalam@quicinc.com>
 <20240215134856.1313239-2-quic_mdalam@quicinc.com>
 <20240215-upon-anime-af032e49e84d@spud>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <20240215-upon-anime-af032e49e84d@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bz2KTbBLMa6vU1xmmZGH03T_QBaLtLKk
X-Proofpoint-GUID: bz2KTbBLMa6vU1xmmZGH03T_QBaLtLKk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 phishscore=0 clxscore=1011 mlxscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402200087



On 2/15/2024 7:54 PM, Conor Dooley wrote:
> On Thu, Feb 15, 2024 at 07:18:52PM +0530, Md Sadre Alam wrote:
>> Add device-tree binding documentation for QCOM QPIC-SNAND-NAND Flash
>> Interface.
>>
>> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> ---
>>   .../bindings/spi/qcom,spi-qpic-snand.yaml     | 82 +++++++++++++++++++
>>   1 file changed, 82 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
>> new file mode 100644
>> index 000000000000..fa7484ce1319
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
>> @@ -0,0 +1,82 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/spi/qcom,spi-qpic-snand.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm QPIC NAND controller
>> +
>> +maintainers:
>> +  - Md sadre Alam <quic_mdalam@quicinc.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,ipq9574-snand
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    minItems: 2
>> +    maxItems: 3
>> +
>> +  clock-names:
>> +    minItems: 2
>> +    maxItems: 3
>> +
>> +allOf:
>> +  - $ref: /schemas/spi/spi-controller.yaml#
>> +  - if:
> 
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,ipq9574-snand
>> +
>> +    then:
>> +      properties:
>> +        dmas:
>> +          items:
>> +            - description: tx DMA channel
>> +            - description: rx DMA channel
>> +            - description: cmd DMA channel
>> +
>> +        dma-names:
>> +          items:
>> +            - const: tx
>> +            - const: rx
>> +            - const: cmd
> 
> None of this complexity here is needed, you have only one device in this
> binding and therefore can define these properties at the top level.

  Thanks for reviewing, Will fix this in next patch.
> 
> Cheers,
> Conor.
> 
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
>> +    qpic_nand: spi@79b0000 {
>> +        compatible = "qcom,ipq9574-snand";
>> +        reg = <0x1ac00000 0x800>;
>> +
>> +        clocks = <&gcc GCC_QPIC_CLK>,
>> +                 <&gcc GCC_QPIC_AHB_CLK>,
>> +                 <&gcc GCC_QPIC_IO_MACRO_CLK>;
>> +        clock-names = "core", "aon", "iom";
>> +
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        flash@0 {
>> +            compatible = "spi-nand";
>> +            reg = <0>;
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>> +            nand-ecc-engine = <&qpic_nand>;
>> +            nand-ecc-strength = <4>;
>> +            nand-ecc-step-size = <512>;
>> +            };
>> +        };
>> -- 
>> 2.34.1
>>

