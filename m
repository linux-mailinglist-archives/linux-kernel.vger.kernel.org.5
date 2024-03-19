Return-Path: <linux-kernel+bounces-107615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB86887FF29
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 953DC283A17
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA7E81AC1;
	Tue, 19 Mar 2024 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="XvMIDRR9"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB0C81734;
	Tue, 19 Mar 2024 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710856622; cv=none; b=nOoBpsGMq4Lknz4Rt2DlMurdUJnlsTWV0jqxgXOGravJ1W7yNoWYeSfs7Fws8l98xdqDauPAZXQui4+lL6eaoD6hodSMCGsUCNww4rxwS87rLp9xnJJDpYabmbsT+dcNEku538scOCq2VQ4AHYpjCjOdQzCWQF6/4VjcFAn/YfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710856622; c=relaxed/simple;
	bh=FNnVUxP5kKoCDRumiMd76zCH0Ns7cHeJNwsmi1pOsnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FMsg3eDgBCML1KCiZu8f+MzQCKHPYapIKErCISaDUda/T4uhuqI0KC0C1IbQoERikXIE7Hb6MQif8EVgLYgUeEARp/+aZQec9f51LiMhuVg4D/Ai2FHf7JIZqFcpI5rxWb2kAJJcbhqpn5maBz4QKRq6p2jMYMuh9z6wtp/CcbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=XvMIDRR9; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3C7EAC80;
	Tue, 19 Mar 2024 14:56:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710856591;
	bh=FNnVUxP5kKoCDRumiMd76zCH0Ns7cHeJNwsmi1pOsnw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XvMIDRR9CVXFv0oazyi54aW3lVKYAUvu/LlHjBOe+IupZ05gQ7GDsIubTwsG2DYs0
	 K1KrJeIgXUWIarv+X2aNE1uJTxtaW5EnpgbciDnvY0e2qdhsicd6cSw9fq1Lng/DSw
	 xv80yR5R5wU7s4sOaVTer2bX7CMkaJ/SRCYEA5r8=
Message-ID: <aaf0faf8-7041-4510-9e02-1ec896baf4ae@ideasonboard.com>
Date: Tue, 19 Mar 2024 15:56:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: media: Add bindings for
 raspberrypi,rp1-cfe
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Naushir Patuck
 <naush@raspberrypi.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
References: <20240318-rp1-cfe-v1-0-ac6d960ff22d@ideasonboard.com>
 <20240318-rp1-cfe-v1-2-ac6d960ff22d@ideasonboard.com>
 <3834dd0a-6dd0-45b1-8b9c-0c840aaf8cf2@linaro.org>
 <22225e92-803d-4aaa-b75f-cfd1d7d8c279@ideasonboard.com>
 <8caabb1a-dfba-48d5-a794-a26d0286bad2@linaro.org>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <8caabb1a-dfba-48d5-a794-a26d0286bad2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/03/2024 11:31, Krzysztof Kozlowski wrote:
> On 19/03/2024 07:46, Tomi Valkeinen wrote:
>>>> +  reg:
>>>> +    items:
>>>> +      - description: CSI-2 registers
>>>> +      - description: D-PHY registers
>>>> +      - description: MIPI CFG (a simple top-level mux) registers
>>>> +      - description: FE registers
>>>> +
>>>> +  interrupts:
>>>> +    maxItems: 1
>>>> +
>>>> +  clocks:
>>>> +    maxItems: 1
>>>> +
>>>> +  port:
>>>> +    $ref: /schemas/graph.yaml#/$defs/port-base
>>>> +    additionalProperties: false
>>>> +    description: CSI-2 RX Port
>>>
>>> Only one port, so there is nothing to output to?
>>
>> The CFE has DMA, so it writes to memory. But no other outputs.
> 
> You still might have some sort of pipeline, e.g. some post processing
> block. But if this is end block, then I guess it's fine.

There is a processing block, FE. But it's considered part of the same 
module.

Whether that's exactly correct or not, I'm not sure. I don't have 
detailed hardware docs, but my understanding of the architecture is that 
we have the D-PHY, CSI-2 RX and FE blocks, and a "MIPI CFG" wrapper 
around these (with some CSI-2 & FE muxing and interrupt status flags). 
These are all considered to be part of the same CFE module, and thus we 
represent it here as a single node.

In the patch 4 I explain a bit more about the HW blocks, but maybe it 
would've been beneficial to have some description here too. Here's the 
relevant part:

> +The PiSP Camera Front End (CFE) is a module which combines a CSI-2 receiver with
> +a simple ISP, called the Front End (FE).
> +
> +The CFE has four DMA engines and can write frames from four separate streams
> +received from the CSI-2 to the memory. One of those streams can also be routed
> +directly to the FE, which can do minimal image processing, write two versions
> +(e.g. non-scaled and downscaled versions) of the received frames to memory and
> +provide statistics of the received frames.


>>>> +
>>>> +    properties:
>>>> +      endpoint:
>>>> +        $ref: video-interfaces.yaml#
>>>> +        unevaluatedProperties: false
>>>> +
>>>> +        properties:
>>>> +          data-lanes:
>>>> +            minItems: 1
>>>> +            maxItems: 4
>>>> +
>>>> +          clock-lanes:
>>>> +            maxItems: 1
>>>> +
>>>> +          clock-noncontinuous: true
>>>
>>> Drop
>>
>> Hmm, I saw this used in multiple other bindings, and thought it means
>> the property is allowed and copied it here.
>>
>> If that's not the case, does this mean all the properties from
>> video-interfaces.yaml are allowed (even invalid ones, like pclk-sample)?
> 
> Yes, that's the meaning of unevaluatedProperties you have a bit above.
> 
>>
>>>> +
>>>> +        required:
>>>> +          - clock-lanes
>>>> +          - data-lanes
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +  - interrupts
>>>> +  - clocks
>>>> +
>>>> +additionalProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    #include <dt-bindings/clock/rp1.h>
>>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>>> +    #include <dt-bindings/mfd/rp1.h>
>>>> +
>>>> +    rpi1 {
>>>
>>> soc
>>
>> That should actually be "rp1", not "rpi1". rp1 is the co-processor on
>> which the cfe is located, so it doesn't reside in the soc itself. But
> 
> Where is the co-processor located?

RP1 is a separate chip on the board, behind PCIe. It contains multiple 
blocks, dealing with I/O (like this CSI-2, but also USB, eth, ...). To 
the driver the CFE just shows up as a normal memory mapped IP. Afaics, 
in theory CFE could as well be in the main SoC itself, so, for an 
example, I don't see "soc" as a bad parent node.

  Tomi

>> perhaps that's not relevant, and "soc" is just a generic container that
>> should always be used?
> 
> Does not have to be soc, but rp1 is not generic.
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> 
> 
> 
> Best regards,
> Krzysztof
> 


