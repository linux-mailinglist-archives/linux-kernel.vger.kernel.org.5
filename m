Return-Path: <linux-kernel+bounces-110179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E972885B2F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE1D3B23C84
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5386185945;
	Thu, 21 Mar 2024 14:52:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC9C58232;
	Thu, 21 Mar 2024 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711032737; cv=none; b=TZPVLZd5ng1MlsZ/HPOpClVl1M+i5ABRlHgxJEfp7hcmLVvvbA4WO1zzOt4SuNGoZpepPjcj6cEovjmfD686X18RRO381M90Paor/cq2CiN3CluOordDdd5wg3EYKDErnPkKafVg0uNYnGe8svWdowrzSPo8K8pKrug9EQqpjfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711032737; c=relaxed/simple;
	bh=EUh2B2yBe9JAd5dMMj00ZCYwh//VjKBq0E4ohqEGc6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hvyinkuLhbpwnKWuSrJoK2uR7lA21w+T+9CxrOJTLzbS1GTHkP3Vby9oyKyGAu0HOmCfHkShXweETmrCLCNMQv2hcr7/MYOSQzY4RvyTJdjHoQY9Fpc6fv6Usc8RviUq17ER0O7uFEArN242nUlh18+E7wXdMjwRPBlQTT4k3hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08E341007;
	Thu, 21 Mar 2024 07:52:48 -0700 (PDT)
Received: from [10.1.38.27] (FVFF763DQ05P.cambridge.arm.com [10.1.38.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C2E53F67D;
	Thu, 21 Mar 2024 07:52:11 -0700 (PDT)
Message-ID: <d44ddcc7-1e44-415c-93d0-c08e7836e3e3@arm.com>
Date: Thu, 21 Mar 2024 14:52:10 +0000
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
To: Rob Herring <robh@kernel.org>, Tao Zhang <quic_taozha@quicinc.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Konrad Dybcio <konradybcio@gmail.com>, Mike Leach <mike.leach@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Jinlong Mao <quic_jinlmao@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Tingwei Zhang <quic_tingweiz@quicinc.com>,
 Yuanfang Zhang <quic_yuanfang@quicinc.com>,
 Trilok Soni <quic_tsoni@quicinc.com>, Song Chai <quic_songchai@quicinc.com>,
 linux-arm-msm@vger.kernel.org, andersson@kernel.org
References: <1711009927-17873-1-git-send-email-quic_taozha@quicinc.com>
 <1711009927-17873-2-git-send-email-quic_taozha@quicinc.com>
 <20240321144226.GA1689544-robh@kernel.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20240321144226.GA1689544-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/03/2024 14:42, Rob Herring wrote:
> On Thu, Mar 21, 2024 at 04:32:04PM +0800, Tao Zhang wrote:
>> Add new property "label" to label the source corresponding to the
>> output connection. When the funnel supports multi-output, this
>> property needs to be introduced to mark which source component a
>> certain output connection corresponds to.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> ---
>>   .../arm/arm,coresight-dynamic-funnel.yaml     | 34 ++++++++++++++++---
>>   1 file changed, 30 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
>> index 44a1041cb0fc..cde62c286d29 100644
>> --- a/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
>> +++ b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
>> @@ -66,13 +66,39 @@ properties:
>>           $ref: /schemas/graph.yaml#/properties/port
>>   
>>     out-ports:
>> -    $ref: /schemas/graph.yaml#/properties/ports
>> -    additionalProperties: false
>> -
>> +    type: object
>>       properties:
>> +      "#address-cells":
>> +        const: 1
>> +
>> +      "#size-cells":
>> +        const: 0
>> +
>>         port:
>> +        type: object
>> +
>> +    patternProperties:
>> +      '^port(@[0-7])?$':
>> +        type: object
>>           description: Output connection to CoreSight Trace bus
>> -        $ref: /schemas/graph.yaml#/properties/port
> 
> Nope, now you have no constraints on port node properties. Please look
> at how other bindings are done to add properties on endpoint node.
> 
>> +
>> +        patternProperties:
>> +          "^endpoint(@[0-9a-f]+)?$":
>> +            type: object
>> +            properties:
>> +              remote-endpoint:
>> +                description: |
>> +                  phandle to an 'endpoint' subnode of a remote device node.
>> +                  $ref: /schemas/types.yaml#/definitions/phandle
> 
> Don't need this.
> 
>> +              label:
>> +                description: Label the source corresponding to the output connection
>> +                $ref: /schemas/types.yaml#/definitions/string
> 
> label already has a type.
> 
> As this node is an output, aren't you labeling what the destination is,
> not the "source"?
> 
> Why can't you look at the remote connection to identify what it is?

+1


Suzuki


> 
> 
>> +    oneOf:
>> +      - required:
>> +          - port
>> +      - required:
>> +          - "#address-cells"
>> +          - "#size-cells"
> 
> The common schema that you removed handles this.
> 
> Rob


