Return-Path: <linux-kernel+bounces-87401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA0D86D3F3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45E32B2248F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024221428F8;
	Thu, 29 Feb 2024 20:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnBGpwl3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3868713F42C;
	Thu, 29 Feb 2024 20:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709237382; cv=none; b=bjRDSsx49FwufU+OWmIOEY5j8m8a1UV53pED87J6B2HR79+1zMpK8LsW9MrFNwo/P4ZA+Zpv8IHgwTkJ8i7k/xoDy1yhInmvaK/hj4+UODSyLGgKM6HYQv27IJap+RxoHpZNIHU+y+Xg14p7v0lJd38ojkyHbsG9KI8RlazlZZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709237382; c=relaxed/simple;
	bh=JDZQAlHv20O1j1Z2SnkX+3voyyWezZa9uKTLnWAP2gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tqDgkyDmwdaCAtrbChakoIbGLSakGwU4soOBsQ+mCbjXYf+cLpepe2Dm4pynuBisvlbObnJ02BQhOEnJD88DPlT6KbdlTPb6biPdO/8+1EyzwM4ANpk2jdmc6yeOzfzM4E7axMxQClIqBpYbPOf8YvFviPA2PRNlbF8INSz9k80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnBGpwl3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B3BC433C7;
	Thu, 29 Feb 2024 20:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709237381;
	bh=JDZQAlHv20O1j1Z2SnkX+3voyyWezZa9uKTLnWAP2gc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LnBGpwl3pA6qb42DQGMKa6ANgnycvmiut6Sz4sc3/SUbSN+o7zpvbGr6gDv3IU/cO
	 ucPMMAfbkxzMKPwFD5m+cg7jEhywAkIKdDWPHGsjGHK8p7RmbUfJZiRKf6qBYQY6cC
	 uUs/wK4VAlKrJIbd3DJdPtQnBIF2aUoLxcbB9PniJ3WOp8/v/JBwcHFh6MdUzUMd8D
	 81k1WGMKUMREO7Zz39LpZWLMas8GW6iVZI1SutFbkamd5Z8msbACMbzzMryT+RgeIK
	 fXufboa8usOyDcrkX1qgQvSMtiYDLnRgsF/Oe8SB599yMsU3M29RTgVAnfq8ofxBwZ
	 bKR9XJynv79mg==
Message-ID: <70095e04-eaec-4323-b2ac-2d4d366763d5@kernel.org>
Date: Thu, 29 Feb 2024 22:09:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] dt-bindings: iommu: Add Qualcomm TBU bindings
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Georgi Djakov <quic_c_gdjako@quicinc.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, iommu@lists.linux.dev
Cc: devicetree@vger.kernel.org, andersson@kernel.org,
 konrad.dybcio@linaro.org, robdclark@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, quic_cgoldswo@quicinc.com,
 quic_sukadev@quicinc.com, quic_pdaly@quicinc.com, quic_sudaraja@quicinc.com
References: <20240226172218.69486-1-quic_c_gdjako@quicinc.com>
 <20240226172218.69486-2-quic_c_gdjako@quicinc.com>
 <b6215fcd-29fc-4495-999f-b7b03b36c087@linaro.org>
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <b6215fcd-29fc-4495-999f-b7b03b36c087@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 29.02.24 19:53, Krzysztof Kozlowski wrote:
> On 26/02/2024 18:22, Georgi Djakov wrote:
>> The "apps_smmu" on the Qualcomm sdm845 platform is an implementation
>> of the SMMU-500, that consists of a single TCU (Translation Control
>> Unit) and multiple TBUs (Translation Buffer Units). These TBUs have
>> hardware debugging features that are specific and only present on
>> Qualcomm hardware. Represent them as independent DT nodes. List all
>> the resources that are needed to operate them (such as registers,
>> clocks, power domains and interconnects).
>>
>> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
>> ---
>>   .../devicetree/bindings/iommu/qcom,tbu.yaml   | 65 +++++++++++++++++++
>>   1 file changed, 65 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iommu/qcom,tbu.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/qcom,tbu.yaml b/Documentation/devicetree/bindings/iommu/qcom,tbu.yaml
>> new file mode 100644
>> index 000000000000..6841ca9af21f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iommu/qcom,tbu.yaml
>> @@ -0,0 +1,65 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iommu/qcom,tbu.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm TBU (Translation Buffer Unit)
>> +
>> +maintainers:
>> +  - Georgi Djakov <quic_c_gdjako@quicinc.com>
>> +
>> +description:
>> +  The Qualcomm SMMU500 implementation consists of TCU and TBU. The TBU contains
>> +  a Translation Lookaside Buffer (TLB) that caches page tables. TBUs provides
>> +  debug features to trace and trigger debug transactions. There are multiple TBU
>> +  instances with each client core.
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,qsmmuv500-tbu
> 
> Why we don't have SoC specific compatibles? If that's for SDM845, then
> it should be qcom,sdm845-tbu or qcom,sdm845-qsmmuv500-tbu
> 

Because they should be all compatible (as registers). Adding a SoC compatible
might get overly-specific, but i can also see the benefits in that, so ok will
do it!

> 
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  interconnects:
>> +    maxItems: 1
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +  qcom,stream-id-range:
>> +    description: Phandle of a SMMU device and Stream ID range (address and size) that is assigned by the TBU
> 
> Please wrap it according to coding style, so 80.
> 

Sure, thanks!

>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    items:
>> +      - items:
>> +          - description: phandle of a smmu node
>> +          - description: stream id base address
>> +          - description: stream id size
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - qcom,stream-id-range
>> +
>> +unevaluatedProperties: false
> 
> This should be additionalProperties: false
> 

Ok right, thanks for taking a look!

BR,
Georgi

