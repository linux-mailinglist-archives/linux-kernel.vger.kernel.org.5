Return-Path: <linux-kernel+bounces-134268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5597089AFD3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73BC11C21145
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004091773A;
	Sun,  7 Apr 2024 08:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9n3FMDo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031CC125AC;
	Sun,  7 Apr 2024 08:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712480227; cv=none; b=RJfmyR/epjxWd868AmIo2vBD5IE4twyHGnqv2k3r3jbDaJ0APQz1fs8/yG/43kgjDBpRbC841dTM3gspXq2qh4wS1bsc4ONpKhtZszVVQbPQUu4Zx9tMgCLvy+KCZznNa15a4qVlQe9TrrKGVBtYF4ZbiQLMKdfPhPM4Da+SuZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712480227; c=relaxed/simple;
	bh=1UmJRBIshTbsNwOgZA2SDcfXRmjyJJJe+7oDBNgAf30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sfJUv2fVc/VzzwkQiQYVWTh1goqARxnQ/6IX0ajw++gSy80HT0Jw4BHJ2Kfa1E9AZTo4r8yFSqERAtRycPIlutIOVfWQyaS9xdCbnDQUYlvMqpi9ivfuO9TSAs0cRW6viYWUn3RF2cVPh8W+RKMCD3wYf204hD7AedkawxUpQKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9n3FMDo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FEABC433F1;
	Sun,  7 Apr 2024 08:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712480226;
	bh=1UmJRBIshTbsNwOgZA2SDcfXRmjyJJJe+7oDBNgAf30=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i9n3FMDooGJnPJbxeHPBkUwJYKIArbiPKkYdJ+i4VzW3zkHL7/gh9OS4kVfo7E8vA
	 TcFSFEbzZp1RNt7/5hiHsTE+5SHb254FcBCWLASA+czYxiTK4oP2GRoAHXo8+nS12F
	 rmThpFWbRfbGneYzJRN+Jm3TflUS9CRuD1LpSW15M0vMTpi4iA6I23aoeoU4LB5D38
	 QGXcX7/iGBQ0pcHr3DpVpE7mtYU4fNENIixnITwRlujbSg6+Hr08F7ab+HzGO0lEVn
	 ro0EumLzfOqhbgaXMDjlUdacBxg1+iHe/Idz+WMtdsb0tX0T0sI+m/GNevGrVkcFBI
	 3HrU8pRFFA5/w==
Message-ID: <ca7f1e62-5f70-4aa5-b539-764b778a71e5@kernel.org>
Date: Sun, 7 Apr 2024 10:57:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] dt-bindings: firmware: add i.MX SCMI Extension
 protocol
To: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Cristian Marussi <cristian.marussi@arm.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
 <20240405-imx95-bbm-misc-v2-v2-2-9fc9186856c2@nxp.com>
 <9aab8dab-27c4-40b6-b1d5-0a2babe0700d@kernel.org>
 <DU0PR04MB941719A18C3F749E7D180FD888012@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <DU0PR04MB941719A18C3F749E7D180FD888012@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/04/2024 02:51, Peng Fan wrote:
>> Subject: Re: [PATCH v2 2/6] dt-bindings: firmware: add i.MX SCMI Extension
>> protocol
>>
>> On 05/04/2024 14:39, Peng Fan (OSS) wrote:
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> Add i.MX SCMI Extension protocols bindings for:
>>>  - Battery Backed Secure Module(BBSM)
>>
>> Which is what?
> 
> I should say BBM(BBSM + BBNSM), BBM has RTC and ON/OFF
> key features, but BBM is managed by SCMI firmware and exported
> to agent by BBM protocol. So add bindings for i.MX BBM protocol.
> 
> Is this ok?

No, I still don't know what is BBSM, BBNSM and BBM.

> 
>>
>>>  - MISC settings such as General Purpose Registers settings.
>>>
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>> ---
>>>  .../devicetree/bindings/firmware/imx,scmi.yaml     | 80
>> ++++++++++++++++++++++
>>>  1 file changed, 80 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/firmware/imx,scmi.yaml
>>> b/Documentation/devicetree/bindings/firmware/imx,scmi.yaml
>>> new file mode 100644
>>> index 000000000000..7ee19a661d83
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/firmware/imx,scmi.yaml
>>> @@ -0,0 +1,80 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) # Copyright 2024
>>> +NXP %YAML 1.2
>>> +---
>>> +$id:
>>> +https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevi
>>>
>> +cetree.org%2Fschemas%2Ffirmware%2Fimx%2Cscmi.yaml%23&data=05%7
>> C02%7Cp
>>>
>> +eng.fan%40nxp.com%7C5d16781d3eca425a342508dc562910b7%7C686ea
>> 1d3bc2b4c
>>>
>> +6fa92cd99c5c301635%7C0%7C0%7C638479981570959816%7CUnknown%
>> 7CTWFpbGZsb
>>>
>> +3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn
>> 0%3D
>>>
>> +%7C0%7C%7C%7C&sdata=mWNwPvu2eyF18MroVOBHb%2Fjeo%2BIHfV5V
>> h%2F9ebdx65MM
>>> +%3D&reserved=0
>>> +$schema:
>>> +https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevi
>>> +cetree.org%2Fmeta-
>> schemas%2Fcore.yaml%23&data=05%7C02%7Cpeng.fan%40nx
>>>
>> +p.com%7C5d16781d3eca425a342508dc562910b7%7C686ea1d3bc2b4c6fa
>> 92cd99c5c
>>>
>> +301635%7C0%7C0%7C638479981570971949%7CUnknown%7CTWFpbGZs
>> b3d8eyJWIjoiM
>>>
>> +C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7
>> C%7C%7
>>>
>> +C&sdata=v4XnGG00D4I8j5MJvDUVYMRTm7yRrvz0V3fUyc5KAAA%3D&reser
>> ved=0
>>> +
>>> +title: i.MX System Control and Management Interface(SCMI) Vendor
>>> +Protocols Extension
>>> +
>>> +maintainers:
>>> +  - Peng Fan <peng.fan@nxp.com>
>>> +
>>> +allOf:
>>> +  - $ref: arm,scmi.yaml#
>>
>> Sorry, but arm,scmi is a final schema. Is your plan to define some common
>> part?
> 
> No. I just wanna add vendor extension per SCMI spec. 
> 
> 0x80-0xFF:
> Reserved for vendor or platform-specific extensions to this interface
> 
> Each vendor may have different usage saying id 0x81, so I add
> i.MX dt-schema file.
> 
>>
>>> +
>>> +properties:
>>> +  protocol@81:
>>> +    $ref: 'arm,scmi.yaml#/$defs/protocol-node'
>>> +    unevaluatedProperties: false
>>> +    description:
>>> +      The BBM Protocol is for managing Battery Backed Secure Module
>> (BBSM) RTC
>>> +      and the ON/OFF Key
>>> +
>>> +    properties:
>>> +      reg:
>>> +        const: 0x81
>>> +
>>> +    required:
>>> +      - reg
>>> +
>>> +  protocol@84:
>>> +    $ref: 'arm,scmi.yaml#/$defs/protocol-node'
>>> +    unevaluatedProperties: false
>>> +    description:
>>> +      The MISC Protocol is for managing SoC Misc settings, such as
>>> + GPR settings
>>
>> Genera register is not a setting... this is a pleonasm. Please be more specific
>> what is the GPR, MISC protocol etc.
> 
> The MISC Protocol is for managing SoC Misc settings, such as SAI MCLK/MQS in
> Always On domain BLK CTRL,  SAI_CLK_SEL in WAKEUP BLK CTRL, gpio
> expanders which is under control of SCMI firmware.

So like a bag for everything which you do not want to call something
specific?

No, be specific...

> 
>>> +
>>> +    properties:
>>> +      reg:
>>> +        const: 0x84
>>> +
>>> +      wakeup-sources:
>>> +        description:
>>> +          Each entry consists of 2 integers, represents the source
>>> + and electric signal edge
>>
>> Can you answer questions from reviewers?
> 
> Sorry. Is this ok?
> minItems: 1
> maxItems: 32

No. Does it answers Rob's question? I see zero correlation to his question.

Do not ignore emails from reviewers but respond to them.

> 
>>
>>> +        items:
>>> +          items:
>>> +            - description: the wakeup source
>>> +            - description: the wakeup electric signal edge
>>> +        $ref: /schemas/types.yaml#/definitions/uint32-matrix
>>> +
>>> +    required:
>>> +      - reg
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    firmware {
>>> +        scmi {
>>> +            compatible = "arm,scmi";
>>
>>> +            mboxes = <&mu2 5 0>, <&mu2 3 0>, <&mu2 3 1>;
>>> +            shmem = <&scmi_buf0>, <&scmi_buf1>;
>>> +
>>> +            #address-cells = <1>;
>>> +            #size-cells = <0>;
>>> +
>>> +            protocol@81 {
>>> +                reg = <0x81>;
>>> +            };
>>> +
>>> +            protocol@84 {
>>> +                reg = <0x84>;
>>> +                wakeup-sources = <0x8000 1
>>> +                                  0x8001 1
>>> +                                  0x8002 1
>>> +                                  0x8003 1
>>> +                                  0x8004 1>;
>>
>> Nothing improved... If you are going to ignore reviews, then you will only get
>> NAKed.
> 
> Sorry, you mean the examples, or the whole dt-schema?

*Read comments and respond to them*. Regardless where they are.

Best regards,
Krzysztof


