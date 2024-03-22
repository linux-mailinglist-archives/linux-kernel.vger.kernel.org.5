Return-Path: <linux-kernel+bounces-111240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E12886993
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D031C21030
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C848B224EE;
	Fri, 22 Mar 2024 09:43:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511323FE46;
	Fri, 22 Mar 2024 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711100581; cv=none; b=ISlbWdFH5+fVZis7Xqziiuh++usmq+YAFoCTRrOLHZKztVddlMh2pku8PSEMHUJc6PzivXt1dpFd3grcgNGmeAWxpxD9s1KyJcQHJDI+8P6Z32MgOaQj5ffgXkyekRhkxYYJKxtMPkDevuxeWvoCnf+8e59i//kWYXJy+WGEruo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711100581; c=relaxed/simple;
	bh=4XSgrd53fgq8pz/oH+SK70bj/WOL2pQYKk/6vEmUPMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJ6Nt9FqSf8lfsMb6J/+0ipGdf4wurMF6i4868/EFKSCSOVksZaUwlZyoVTwrcPDETi7Lb9qLGbuXHPw7DoHTsUx/su2pVhgWuF48sNwM3lE4TMgQ+fl0FQywrsI7p8s57gvOKWdrIrrDSgdp3irJo+kPHwl8JRL0ZvuYbKYXwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDAE01007;
	Fri, 22 Mar 2024 02:43:32 -0700 (PDT)
Received: from [10.57.53.86] (unknown [10.57.53.86])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEA703F64C;
	Fri, 22 Mar 2024 02:42:55 -0700 (PDT)
Message-ID: <77fd8549-5e69-42a8-9e35-5d3de56a490f@arm.com>
Date: Fri, 22 Mar 2024 09:42:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: arm: qcom,coresight-funnel: Add label
 for multi-ouput
Content-Language: en-GB
To: Tingwei Zhang <quic_tingweiz@quicinc.com>, Rob Herring <robh@kernel.org>,
 Tao Zhang <quic_taozha@quicinc.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Konrad Dybcio <konradybcio@gmail.com>, Mike Leach <mike.leach@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Jinlong Mao <quic_jinlmao@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Yuanfang Zhang <quic_yuanfang@quicinc.com>,
 Trilok Soni <quic_tsoni@quicinc.com>, Song Chai <quic_songchai@quicinc.com>,
 linux-arm-msm@vger.kernel.org, andersson@kernel.org
References: <1711009927-17873-1-git-send-email-quic_taozha@quicinc.com>
 <1711009927-17873-2-git-send-email-quic_taozha@quicinc.com>
 <20240321144226.GA1689544-robh@kernel.org>
 <443edf61-2a28-4ae7-ac88-2da2d29cebe3@quicinc.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <443edf61-2a28-4ae7-ac88-2da2d29cebe3@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/03/2024 07:02, Tingwei Zhang wrote:
> On 3/21/2024 10:42 PM, Rob Herring wrote:
>> On Thu, Mar 21, 2024 at 04:32:04PM +0800, Tao Zhang wrote:
>>> Add new property "label" to label the source corresponding to the
>>> output connection. When the funnel supports multi-output, this
>>> property needs to be introduced to mark which source component a
>>> certain output connection corresponds to.
>>>
>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>> ---
>>>   .../arm/arm,coresight-dynamic-funnel.yaml     | 34 ++++++++++++++++---
>>>   1 file changed, 30 insertions(+), 4 deletions(-)
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
>>> index 44a1041cb0fc..cde62c286d29 100644
>>> --- 
>>> a/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
>>> +++ 
>>> b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
>>> @@ -66,13 +66,39 @@ properties:
>>>           $ref: /schemas/graph.yaml#/properties/port
>>>     out-ports:
>>> -    $ref: /schemas/graph.yaml#/properties/ports
>>> -    additionalProperties: false
>>> -
>>> +    type: object
>>>       properties:
>>> +      "#address-cells":
>>> +        const: 1
>>> +
>>> +      "#size-cells":
>>> +        const: 0
>>> +
>>>         port:
>>> +        type: object
>>> +
>>> +    patternProperties:
>>> +      '^port(@[0-7])?$':
>>> +        type: object
>>>           description: Output connection to CoreSight Trace bus
>>> -        $ref: /schemas/graph.yaml#/properties/port
>>
>> Nope, now you have no constraints on port node properties. Please look
>> at how other bindings are done to add properties on endpoint node.
>>
> Thanks for pointing this out, Rob. Shall we ref port-base and
> endpoint-base then add new properties on endpoint? In this way, the 
> redundant code from port schema is not required.
>>> +
>>> +        patternProperties:
>>> +          "^endpoint(@[0-9a-f]+)?$":
>>> +            type: object
>>> +            properties:
>>> +              remote-endpoint:
>>> +                description: |
>>> +                  phandle to an 'endpoint' subnode of a remote 
>>> device node.
>>> +                  $ref: /schemas/types.yaml#/definitions/phandle
>>
>> Don't need this.
>>
>>> +              label:
>>> +                description: Label the source corresponding to the 
>>> output connection
>>> +                $ref: /schemas/types.yaml#/definitions/string
>>
>> label already has a type.
>>
>> As this node is an output, aren't you labeling what the destination is,
>> not the "source"?
>>
>> Why can't you look at the remote connection to identify what it is?
>>
> This funnel can route data stream from different trace source to 
> different output ports. This lable property is added to describe which 
> source is routed to this output port.
> 
> For example, the graph is as below. Funnel3 routes trace data from TPDM0 
> to output[0] and output[0] of funnel3 is connected to input[0] of TPDA0.

Funnel3 and Funnel4 are really Replicators ! How are they Funnels ? 
Again, my question still stands. Are Funnel(Replicator-renamed)3/4 and 
Funnel 0/1/2 programmable ?

Suzuki


> While Funnels routes trace data from TPDM1 to output[1] which connects 
> to input[1] of TPDA0. Hope that clarifies this a little bit.
> 
> |---------|    |---------|    |---------|    |---------|    |---------|
> |  TPDM0  |    |  TPDM1  |    |  TPDM2  |    |  TPDM3  |    |  TPDM4  |
> |---------|    |---------|    |---------|    |---------|    |---------|
>      |               |             |               |              |
>      |               |             |               |              |
>      |               |             |               |              |
>      |-----|   |-----|             |-----|   |-----|              |
>            |   |                         |   |                    |
>            |   |                         |   |                    |
>         [0]|   |[1]                   [0]|   |[1]                 |
>       \-------------/               \-------------/        \------------/
>        \  FUNNEL0  /                 \  FUNNEL1  /          \  FUNNEL2  /
>         -----------                   -----------            -----------
>              |                             |                      |
>       \-------------/               \-------------/               |
>        \  FUNNEL3  /                 \  FUNNEL4  /                |
>         -----------                   -----------                 |
>            |  |                         |   |
>         [0]|  |[1]                   [0]|   |[1]                  |
>            |  |----------               |   |                     |
>            |            |               |   |                     |
>            |-------|    |      |------- |   |          |--------- |
>                    |    |      |            |          |
>                    |    |      |            |          |
>                 [0]|    |[1]   |[2]         |[3]       |[4]
>             \ ---------------------------------------------------/
>              \                     TPDA0                        /
>               \                                                /
>                ------------------------------------------------
> 
>>
>>> +    oneOf:
>>> +      - required:
>>> +          - port
>>> +      - required:
>>> +          - "#address-cells"
>>> +          - "#size-cells"
>>
>> The common schema that you removed handles this.
>>
>> Rob
> 


