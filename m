Return-Path: <linux-kernel+bounces-136588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7E889D5D4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9289F285607
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D8980604;
	Tue,  9 Apr 2024 09:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKHp2IoS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910C77FBC7;
	Tue,  9 Apr 2024 09:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712655960; cv=none; b=hBsLa04k3C9eGfalfMdwXgfu8Mm8Lr/8ujD++Myn94bIqnHhjC7IkhtQrCw5WX1Q3t6RLl1NHRn6xVsaIGprIyl4XhAYTBJtya9xN+U8HN+ZBqcCPiV5dUj9Bi/NNfkgy0tmwtkt4BhxtryuYM/cdggUmuix7PsZTSSuAxjd7fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712655960; c=relaxed/simple;
	bh=6P0fVlv1EwM/ol/eVv4loTKhBtSfCzBSs+mfTaV1zOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oTjadl+g7QO1byU4sqGs+dKeC7R4seitjxvLdJ5L0vOSGZD9TQ2jaQLLjAno03hxW0QuN+5O4tmNw389ScXiEZUm8/YoYucxcd18bQoHQY/QmLzDfTbr8YdkPUK2N1J1YAGwPFeXhtU31xQkqc01SL2xqR1rsDxsMKBRAWFVUrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKHp2IoS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76370C433F1;
	Tue,  9 Apr 2024 09:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712655960;
	bh=6P0fVlv1EwM/ol/eVv4loTKhBtSfCzBSs+mfTaV1zOw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bKHp2IoS1onAxJJZBsycjc1zFTYcWSKRRbqbTnHi50XMA2+dEuT5YSEhrJtxb/DnN
	 FKDyRtkCn2xOALr5ujt66zvgdmLpGtgtHOuNF7DvNt5mNzF42lDrhaTwPb+WiO8Jr9
	 xU2FpNbk1XGBxSlcr73lk7TTkopU6xq9AWHIUNPoZS0rgwbtEkDXBhuNzY0JjHKiKp
	 Kp2NtBRkDX3bZA8++sGXs+NxXfaxM4xMcwrYpwjt6HQNobmmA4t+q5GVZUihU6vUuD
	 61YEaFeNyPGImV2qBzsX54QZBJKHJ6knaZcUBhAKM/B20Az/9bAeM+0xs4R0nWcUWu
	 eoKmzsObTq+/w==
Message-ID: <1ec401be-11cb-416a-9eae-d72ea8acf06f@kernel.org>
Date: Tue, 9 Apr 2024 11:45:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/5] dt-bindings: interconnect: Add Qualcomm IPQ9574
 support
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, mturquette@baylibre.com,
 sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 djakov@kernel.org, dmitry.baryshkov@linaro.org, quic_anusha@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240403104220.1092431-1-quic_varada@quicinc.com>
 <20240403104220.1092431-2-quic_varada@quicinc.com>
 <58c9b754-b9a7-444d-9545-9e6648010630@kernel.org>
 <Zg5q6mnWtK6hmPBT@hu-varada-blr.qualcomm.com>
 <ZhTxFVDH0xTSkw7r@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <ZhTxFVDH0xTSkw7r@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/04/2024 09:41, Varadarajan Narayanan wrote:
> On Thu, Apr 04, 2024 at 02:25:06PM +0530, Varadarajan Narayanan wrote:
>> On Wed, Apr 03, 2024 at 04:59:40PM +0200, Krzysztof Kozlowski wrote:
>>> On 03/04/2024 12:42, Varadarajan Narayanan wrote:
>>>> Add interconnect-cells to clock provider so that it can be
>>>> used as icc provider.
>>>>
>>>> Add master/slave ids for Qualcomm IPQ9574 Network-On-Chip
>>>> interfaces. This will be used by the gcc-ipq9574 driver
>>>> that will for providing interconnect services using the
>>>> icc-clk framework.
>>>>
>>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>>> ---
>>>> v7:
>>>> Fix macro names to be consistent with other bindings
>>>> v6:
>>>> Removed Reviewed-by: Krzysztof Kozlowski
>>>> Redefine the bindings such that driver and DT can share them
>>>>
>>>> v3:
>>>> Squash Documentation/ and include/ changes into same patch
>>>>
>>>> qcom,ipq9574.h
>>>> 	Move 'first id' to clock driver
>>>>
>>>> ---
>>>>  .../bindings/clock/qcom,ipq9574-gcc.yaml      |  3 +
>>>>  .../dt-bindings/interconnect/qcom,ipq9574.h   | 87 +++++++++++++++++++
>>>>  2 files changed, 90 insertions(+)
>>>>  create mode 100644 include/dt-bindings/interconnect/qcom,ipq9574.h
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
>>>> index 944a0ea79cd6..824781cbdf34 100644
>>>> --- a/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
>>>> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq9574-gcc.yaml
>>>> @@ -33,6 +33,9 @@ properties:
>>>>        - description: PCIE30 PHY3 pipe clock source
>>>>        - description: USB3 PHY pipe clock source
>>>>
>>>> +  '#interconnect-cells':
>>>> +    const: 1
>>>> +
>>>>  required:
>>>>    - compatible
>>>>    - clocks
>>>> diff --git a/include/dt-bindings/interconnect/qcom,ipq9574.h b/include/dt-bindings/interconnect/qcom,ipq9574.h
>>>> new file mode 100644
>>>> index 000000000000..0b076b0cf880
>>>> --- /dev/null
>>>> +++ b/include/dt-bindings/interconnect/qcom,ipq9574.h
>>>> @@ -0,0 +1,87 @@
>>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>>>> +#ifndef INTERCONNECT_QCOM_IPQ9574_H
>>>> +#define INTERCONNECT_QCOM_IPQ9574_H
>>>> +
>>>> +#define ICC_ANOC_PCIE0		0
>>>> +#define ICC_SNOC_PCIE0		1
>>>> +#define ICC_ANOC_PCIE1		2
>>>> +#define ICC_SNOC_PCIE1		3
>>>> +#define ICC_ANOC_PCIE2		4
>>>> +#define ICC_SNOC_PCIE2		5
>>>> +#define ICC_ANOC_PCIE3		6
>>>> +#define ICC_SNOC_PCIE3		7
>>>> +#define ICC_SNOC_USB		8
>>>> +#define ICC_ANOC_USB_AXI	9
>>>> +#define ICC_NSSNOC_NSSCC	10
>>>> +#define ICC_NSSNOC_SNOC_0	11
>>>> +#define ICC_NSSNOC_SNOC_1	12
>>>> +#define ICC_NSSNOC_PCNOC_1	13
>>>> +#define ICC_NSSNOC_QOSGEN_REF	14
>>>> +#define ICC_NSSNOC_TIMEOUT_REF	15
>>>> +#define ICC_NSSNOC_XO_DCD	16
>>>> +#define ICC_NSSNOC_ATB		17
>>>> +#define ICC_MEM_NOC_NSSNOC	18
>>>> +#define ICC_NSSNOC_MEMNOC	19
>>>> +#define ICC_NSSNOC_MEM_NOC_1	20
>>>> +
>>>> +#define ICC_NSSNOC_PPE		0
>>>> +#define ICC_NSSNOC_PPE_CFG	1
>>>> +#define ICC_NSSNOC_NSS_CSR	2
>>>> +#define ICC_NSSNOC_IMEM_QSB	3
>>>> +#define ICC_NSSNOC_IMEM_AHB	4
>>>> +
>>>> +#define MASTER_ANOC_PCIE0		(ICC_ANOC_PCIE0 * 2)
>>>> +#define SLAVE_ANOC_PCIE0		((ICC_ANOC_PCIE0 * 2) + 1)
>>>
>>> Which existing Qualcomm platform has such code?
>>
>> Existing Qualcomm platforms don't use icc-clk. They use icc-rpm
>> or icc-rpmh. clk-cbf-msm8996.c is the only driver that uses icc-clk.
>>
>> The icc_clk_register automatically creates master & slave nodes
>> for each clk entry provided as input with the node-ids 'n' and
>> 'n+1'. Since clk-cbf-msm8996.c has only one entry, it could just
>> define MASTER_CBF_M4M and SLAVE_CBF_M4M with 0 and 1 and avoid these
>> calculations.
>>
>> However, ipq9574 gives an array of clock entries as input to
>> icc_clk_register. To tie the order/sequence of these clock
>> entries correctly with the node-ids, this calculation is needed.
>>
>>> This is the third time I am asking for consistent headers. Open
>>> existing, recently added headers and look how it is done there. Why?
>>> Because I am against such calculations and see no reason for them.
>>
>> Apologies. Regret that I have to trouble you.
>>
>> In this ipq9574 case, have to reconcile between the following
>> feedbacks.
>>
>> 1. https://lore.kernel.org/linux-arm-msm/fe40b307-26d0-4b2a-869b-5d093415b9d1@linaro.org/
>>    We could probably use indexed identifiers here to avoid confusion:
>>    [ICC_BINDING_NAME] = CLK_BINDING_NAME
>>
>> 2. https://lore.kernel.org/linux-arm-msm/95f4e99a60cc97770fc3cee850b62faf.sboyd@kernel.org/
>>    Are these supposed to be in a dt-binding header?
>>
>> 3. https://lore.kernel.org/linux-arm-msm/031d0a35-b192-4161-beef-97b89d5d1da6@linaro.org/
>>    Do you use them as well in the DTS?
>>
>> Having the defines (with the calculations) seemed to to comply
>> with the above three feedbacks.
>>
>> Please let me know if this can be handled in a different way that
>> would be consistent with other Qualcomm platforms.
> 
> Krzysztof,
> 
> Is this ok? Can I post a new version addressing other review comments?

I don't understand and you did not answered before, why you have to do
it differently than all other Qualcomm interconnect providers. Maybe the
code here needs it, maybe not, but I don't see any argument proving this.

Best regards,
Krzysztof


