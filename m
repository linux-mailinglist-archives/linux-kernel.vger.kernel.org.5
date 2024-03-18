Return-Path: <linux-kernel+bounces-106269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D55387EBAE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E2241C21422
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4AD4F1E0;
	Mon, 18 Mar 2024 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pQU4I7xW"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028545024E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710774489; cv=none; b=VMoXiZq7eyg6oyS7sRJvXQpuEdc8bLka4sLUTKT6NrRlOPTJM/ckrFTadlPG6Dw9I1Ai0peGAG53GsJ7L3kS5BTf5nNi9BrJFlBAYH7Uc6bjICyyPf4HfNoPVVtqNMGjwkR3B7UzGseWM+TVjYNRjr1R2cRreOAtyalbuym5Y+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710774489; c=relaxed/simple;
	bh=AKfXwCUOBDDc2KqjCcP0/eMGXWoVE7oAmI4zOdAIEmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GPYHIe81R964SAQ0aGJUod9+Cddpe8uO0cHGUD71CA0H8P7nT6Xl9NWL+RugPPMdvgnI1Pw/OSszlrkVk5R3BYxtaVX2+/hG1C/9mNZObEve7JwJpDcYxGPhscpKE5dfFa5G5DEIV1H4z+trj8QGBkQjzAmFa/vbLuyDSgWey9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pQU4I7xW; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9daf9c8f-6606-4ff6-8065-6a32fa0d152c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710774486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eagCYYq0b9lVpWnIs8vZtDFTcZ2Qotru6uGD8hNAyBY=;
	b=pQU4I7xW5EIuiwbtAzMdqS5CAw285dl/NFpIiRhvu7RBf6wrNs5dAnzG+jujizFEyQJRKe
	/g+osXAIoNBK8F51GNGtIPGkxG8eJJpk5ow4BJfrBce0jbQOKfBXOExfN2TUJu75KBIwPF
	1uNAHm/wHJYBq5yGKhKqpBvSS6MJNxo=
Date: Mon, 18 Mar 2024 11:08:00 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: Remove fsl,t1023-sfp in favor of
 fsl,layerscape-sfp
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Richard Alpe <richard@bit42.se>, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Michael Walle <michael@walle.cc>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <20240316002026.1808336-1-sean.anderson@linux.dev>
 <20240317-starved-pager-7a81c5045cfc@spud>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240317-starved-pager-7a81c5045cfc@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/17/24 11:10, Conor Dooley wrote:
> On Fri, Mar 15, 2024 at 08:20:25PM -0400, Sean Anderson wrote:
>> These bindings document the same hardware (just different minor
>> revisions). Remove the newer fsl,t1023-sfp.
>> 
>> Fixes: aa1ed6047107 ("dt-bindings: nvmem: Add t1023-sfp efuse support")
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>> 
>>  .../bindings/nvmem/fsl,layerscape-sfp.yaml    | 21 ++++++++++-
>>  .../bindings/nvmem/fsl,t1023-sfp.yaml         | 37 -------------------
>>  2 files changed, 19 insertions(+), 39 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
>> index 70fb2ad25103..8a54dd1328ea 100644
>> --- a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
>> +++ b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
>> @@ -19,6 +19,13 @@ allOf:
>>  properties:
>>    compatible:
>>      oneOf:
>> +      - description: Trust architecture 2.0 SFP
>> +        items:
>> +          enum:
>> +            - fsl,t1023-sfp
> 
>> +            - fsl,t1040-sfp
>> +            - fsl,t2080-sfp
>> +            - fsl,t4240-sfp
> 
> You should at least mention where these three compatibles came from,
> given they were not documented in t1023-sfp.yaml

They come from the existing DTSs for these processors. Will add this to
the commit message.

> Additionally, should
> they fall back to t1023-sfp? I see that there's already some dts files
> with these compatibles in them but seemingly no driver support as there
> is for the t1023-sfp.

I checked the reference manuals for these processors, and all of them use TA 2.0.

--Sean

>>        - description: Trust architecture 2.1 SFP
>>          items:
>>            - const: fsl,ls1021a-sfp
>> @@ -45,8 +52,18 @@ properties:
>>  required:
>>    - compatible
>>    - reg
>> -  - clock-names
>> -  - clocks
>> +
>> +if:
>> +  properties:
>> +    compatible:
>> +      contains:
>> +        enum:
>> +          - fsl,ls1021a-sfp
>> +          - fsl,ls1028a-sfp
>> +then:
>> +  required:
>> +    - clocks
>> +    - clock-names
>>  
>>  unevaluatedProperties: false
>>  
>> diff --git a/Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml
>> deleted file mode 100644
>> index df826b40d8ca..000000000000
>> --- a/Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml
>> +++ /dev/null
>> @@ -1,37 +0,0 @@
>> -# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> -%YAML 1.2
>> ----
>> -$id: http://devicetree.org/schemas/nvmem/fsl,t1023-sfp.yaml#
>> -$schema: http://devicetree.org/meta-schemas/core.yaml#
>> -
>> -title: NXP QorIQ eFuse support
>> -
>> -maintainers:
>> -  - Richard Alpe <richard@bit42.se>
>> -
>> -description:
>> -  Read support for the eFuses (SFP) on NXP QorIQ series SoC's.
>> -
>> -allOf:
>> -  - $ref: nvmem.yaml#
>> -
>> -properties:
>> -  compatible:
>> -    const: fsl,t1023-sfp
>> -
>> -  reg:
>> -    maxItems: 1
>> -
>> -required:
>> -  - compatible
>> -  - reg
>> -
>> -unevaluatedProperties: false
>> -
>> -examples:
>> -  - |
>> -    efuse@e8000 {
>> -        compatible = "fsl,t1023-sfp";
>> -        reg = <0xe8000 0x1000>;
>> -    };
>> -...
>> -- 
>> 2.35.1.1320.gc452695387.dirty
>> 


