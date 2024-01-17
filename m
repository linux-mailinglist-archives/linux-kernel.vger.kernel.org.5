Return-Path: <linux-kernel+bounces-28609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32978300B2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02B5F1C238CA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185B8C122;
	Wed, 17 Jan 2024 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="sZNaaTxt"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AB8BE49;
	Wed, 17 Jan 2024 07:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705477523; cv=none; b=TLf0yFhgD9Dx/dWqkpTFk8gIjrRoU93qUm/53IZTDJTguZ4EVkQvRhqg392CATBlsxjvWPo0SGLd1cjncW7GKjbCqWm5BLkQ+kDAWtEFS5P7A110M0aL1ZPK7H8ZtQYhP+pC+jt+TCg+AiYlHbea2JxQn2mgw/9yXEKre2UuX5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705477523; c=relaxed/simple;
	bh=hQv+I0Eiq+7fB9xg1HNP3chTKc1a2Bf/A03yve21M1w=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:CC:References:From:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-Proofpoint-Virus-Version; b=T4UJEA9o9xtFH2IHY8cBmfWmJpJa2dztefKj8FfGxveisZZwVaZBa7SOUFGzE2Jhjo3FdJ1RviJ2msj8i9KRS/ftba23GcWID7bfmyHYhi4seXOD1GxkzdlDOe4qpPnSW3xT1Yljrr6E+zeXf3Vynp7/1pE1Lhq27jPNQE8crf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=sZNaaTxt; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H3x5lt020013;
	Wed, 17 Jan 2024 08:44:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=OZrP5toRyjcJF2MlSXBcWkH6wmirRqD90mK0q6wA+8s=; b=sZ
	NaaTxtfHG0uZgegMGyKzip7iEYjjLmR6zGfV8xvOnL1Kid70iHiDFayu6HehNrgU
	a//XoLX3+f2/t6xhEYxJsnpz2wahW6gYJ/fJGs6UxwU3bqn0Bjx4MpSoMldru9kw
	7Zjq7yfBUTf15XqCv4vj8uM5d1ckOq7xKdqhTxWKJgdlSrncdwytdGgK6cBGqA4d
	ui2WFAHsofdKJEscuoCSEXi6d7JeKmTwjhc/WIv3AMTbCATg9TCPuP1zlfi3AVjL
	xPBEyj8BcVi1Fy0fQz9pt5pgUmM4JXVT6vDKB2w1+eK8U95tBjw7XGOCSrHIahjf
	fVSXEmqnUGFRy63nR08Q==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vm4y501dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 08:44:53 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 19FAC10007B;
	Wed, 17 Jan 2024 08:44:52 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E4C96212317;
	Wed, 17 Jan 2024 08:44:51 +0100 (CET)
Received: from [10.252.22.63] (10.252.22.63) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 17 Jan
 2024 08:44:51 +0100
Message-ID: <b4f21821-fbfc-42cc-8bfb-ee8d650b46e1@foss.st.com>
Date: Wed, 17 Jan 2024 08:44:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: remoteproc: add compatibility for TEE
 support
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <op-tee@lists.trustedfirmware.org>, <devicetree@vger.kernel.org>
References: <20240115135249.296822-1-arnaud.pouliquen@foss.st.com>
 <20240115135249.296822-3-arnaud.pouliquen@foss.st.com>
 <20240116192145.GA265232-robh@kernel.org>
From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <20240116192145.GA265232-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_03,2024-01-16_01,2023-05-22_02



On 1/16/24 20:21, Rob Herring wrote:
> On Mon, Jan 15, 2024 at 02:52:47PM +0100, Arnaud Pouliquen wrote:
>> The "st,stm32mp1-m4-tee" compatible is utilized in a system configuration
>> where the Cortex-M4 firmware is loaded by the Trusted execution Environment
>> (TEE).
>> This compatible is used in both the Linux and OP-TEE device-tree.
>> - In OP-TEE, a node is defined in the device tree with the
>>   st,stm32mp1-m4-tee to support signed remoteproc firmware.
>>   Based on DT properties, OP-TEE authenticates, loads, starts, and stops
>>   the firmware.
>> - On Linux, when the compatibility is set, the Cortex-M resets should not
>>   be declared in the device tree.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>> ---
>>  .../bindings/remoteproc/st,stm32-rproc.yaml   | 53 +++++++++++++++----
>>  1 file changed, 44 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
>> index 370af61d8f28..9fdfa30eff20 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
>> +++ b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
>> @@ -16,7 +16,12 @@ maintainers:
>>  
>>  properties:
>>    compatible:
>> -    const: st,stm32mp1-m4
>> +    enum:
>> +      - st,stm32mp1-m4
>> +      - st,stm32mp1-m4-tee
>> +    description:
>> +      Use "st,stm32mp1-m4" for the Cortex-M4 coprocessor management by Linux
> 
> What if other OSs want to manage the M4?

Right, for instance this compatibles are also used by U-boot. I will change
 "by Linux"  by "by non secure context"


> 
>> +      Use "st,stm32mp1-m4-tee" for the Cortex-M4 coprocessor management by secure context
>>  
>>    reg:
>>      description:
>> @@ -142,21 +147,41 @@ properties:
>>  required:
>>    - compatible
>>    - reg
>> -  - resets
>>  
>>  allOf:
>>    - if:
>>        properties:
>> -        reset-names:
>> -          not:
>> -            contains:
>> -              const: hold_boot
>> +        compatible:
>> +          contains:
>> +            const: st,stm32mp1-m4
>> +    then:
>> +      if:
>> +        properties:
>> +          reset-names:
>> +            not:
>> +              contains:
>> +                const: hold_boot
>> +      then:
>> +        required:
>> +          - st,syscfg-holdboot
>> +          - resets
>> +      else:
>> +        properties:
>> +          st,syscfg-holdboot: false
>> +        required:
>> +          - reset-names
> 
> Looks like a new required property.

I just realize that it does not make sense. We execute this
only if "reset-names" contains "hold_boot".
I will remove it

Thanks!
Arnaud

> 
>> +          - resets
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: st,stm32mp1-m4-tee
>>      then:
>> -      required:
>> -        - st,syscfg-holdboot
>> -    else:
>>        properties:
>>          st,syscfg-holdboot: false
>> +        reset-names: false
>> +        resets: false
>>  
>>  additionalProperties: false
>>  
>> @@ -188,5 +213,15 @@ examples:
>>        st,syscfg-rsc-tbl = <&tamp 0x144 0xFFFFFFFF>;
>>        st,syscfg-m4-state = <&tamp 0x148 0xFFFFFFFF>;
>>      };
>> +  - |
>> +    #include <dt-bindings/reset/stm32mp1-resets.h>
>> +    m4@10000000 {
>> +      compatible = "st,stm32mp1-m4-tee";
>> +      reg = <0x10000000 0x40000>,
>> +            <0x30000000 0x40000>,
>> +            <0x38000000 0x10000>;
>> +      st,syscfg-rsc-tbl = <&tamp 0x144 0xFFFFFFFF>;
>> +      st,syscfg-m4-state = <&tamp 0x148 0xFFFFFFFF>;
>> +    };
>>  
>>  ...
>> -- 
>> 2.25.1
>>

