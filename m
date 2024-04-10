Return-Path: <linux-kernel+bounces-138464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D56A189F19D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04EF61C22395
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFE715B10B;
	Wed, 10 Apr 2024 12:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxP89rtL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F315B13DB9F;
	Wed, 10 Apr 2024 12:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712750469; cv=none; b=HO+E6jgQbbfqiMzys5HVuVr8PS9P48W5UbdMXFoRiBRbNppRKhOcRc9QS7wOKyoFQCDGW1SiNZ3GqL38LbXeAd8XWsPmamWTIBMCcMnA1Xek7B8kI9KOE/uYntV9MzWW7/z8LcMC3kbu4/Lcuxao1Y5kKv7IUIcez2miQVKLJuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712750469; c=relaxed/simple;
	bh=BoExRXiMcEXH0BB16rFl2FgwKpjzKlm3TkVjGmjluGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+fHM+Y7ZY68dQ5MbzJ1Iz62yCTzEIWYmNeK+yM37idM8cyu/94gXMyGIg+IwGVwuqP+qdjWy59As/3I/b96hpXYf4cHRdTsf1mu+EDbtPsTPaTIPpwb6fEjX9hYfQjUaWgJJa8+8NpZGdZ6slTfQ6pn8cxt2u4oq8dIcxc3kzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxP89rtL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C975C433F1;
	Wed, 10 Apr 2024 12:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712750468;
	bh=BoExRXiMcEXH0BB16rFl2FgwKpjzKlm3TkVjGmjluGc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oxP89rtLZUenYQp+bRCY1ohx8slIf931KDb7uKqOFB3VqvlQURN7da45HZ9U7hzov
	 14pBrFXMZsmEs+scitIC6a86OhDgmhbw5d/B2a9zBqOUyoPQRRg+wQKqSUZ0MP3vrm
	 MhTjB5DcLyfoQre5tzXyFAjAJmkkh/uUdRyGhW9oANeCtafSzL8BnSkCvlmUioMMc5
	 Mkg1nt/THT1J5vBgZ+z40ok5pYRDkDUOm/cCdyIlDE2POHUZSZ4jJUMU8CAqVMr9be
	 mhNydRd+YtytC0yh/W95o04qWXs1S6yPfxjChtyIT0cj4SPBugKHjR/ZEM1QW8HiBt
	 uN73ufBc9D4Og==
Message-ID: <82e5503c-0710-4b17-af79-8dece4794ec8@kernel.org>
Date: Wed, 10 Apr 2024 14:01:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/5] dt-bindings: interconnect: Add Qualcomm IPQ9574
 support
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, djakov@kernel.org,
 dmitry.baryshkov@linaro.org, quic_anusha@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240403104220.1092431-1-quic_varada@quicinc.com>
 <20240403104220.1092431-2-quic_varada@quicinc.com>
 <58c9b754-b9a7-444d-9545-9e6648010630@kernel.org>
 <Zg5q6mnWtK6hmPBT@hu-varada-blr.qualcomm.com>
 <ZhTxFVDH0xTSkw7r@hu-varada-blr.qualcomm.com>
 <1ec401be-11cb-416a-9eae-d72ea8acf06f@kernel.org>
 <ZhUghsa5Do5m7wrX@hu-varada-blr.qualcomm.com>
 <a0173a13-5f20-4e24-8417-afce5fdbda0e@kernel.org>
 <ZhZjuCkJrtPbwtS/@hu-varada-blr.qualcomm.com>
 <70d0afa7-4990-4180-8dfa-cdf267e4c7a2@kernel.org>
 <f1b0d280-6986-4055-a611-2caceb15867d@linaro.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <f1b0d280-6986-4055-a611-2caceb15867d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/04/2024 13:48, Konrad Dybcio wrote:
> 
> 
> On 4/10/24 13:15, Krzysztof Kozlowski wrote:
>> On 10/04/2024 12:02, Varadarajan Narayanan wrote:
>>>> Okay, so what happens if icc-clk way of generating them changes a bit?
>>>> It can change, why not, driver implementation is not an ABI.
>>>>
>>>>>
>>>>> 	2. These auto-generated id-numbers have to be correctly
>>>>> 	   tied to the DT nodes. Else, the relevant clocks may
>>>>> 	   not get enabled.
>>>>
>>>> Sorry, I don't get, how auto generated ID number is tied to DT node.
>>>> What DT node?
>>>
>>> I meant the following usage for the 'interconnects' entry of the
>>> consumer peripheral's node.
>>>
>>> 	interconnects = <&gcc MASTER_ANOC_PCIE0 &gcc SLAVE_ANOC_PCIE0>,
>>> 			      ^^^^^^^^^^^^^^^^^      ^^^^^^^^^^^^^^^^
>>> 			<&gcc MASTER_SNOC_PCIE0 &gcc SLAVE_SNOC_PCIE0>;
>>> 			      ^^^^^^^^^^^^^^^^^      ^^^^^^^^^^^^^^^^
>>>
>>>>> Since ICC-CLK creates two ids per clock entry (one MASTER_xxx and
>>>>> one SLAVE_xxx), using those MASTER/SLAVE_xxx macros as indices in
>>>>> the below array would create holes.
>>>>>
>>>>> 	static int icc_ipq9574_hws[] = {
>>>>> 		[MASTER_ANOC_PCIE0] = GCC_ANOC_PCIE0_1LANE_M_CLK,
>>>>> 		[MASTER_SNOC_PCIE0] = GCC_SNOC_PCIE0_1LANE_S_CLK,
>>>>> 		[MASTER_ANOC_PCIE1] = GCC_ANOC_PCIE1_1LANE_M_CLK,
>>>>> 		[MASTER_SNOC_PCIE1] = GCC_SNOC_PCIE1_1LANE_S_CLK,
>>>>> 		. . .
>>>>> 	};
>>>>>
>>>>> Other Qualcomm drivers don't have this issue and they can
>>>>> directly use the MASTER/SLAVE_xxx macros.
>>>>
>>>> I understand, thanks, yet your last patch keeps adding fake IDs, means
>>>> IDs which are not part of ABI.
>>>>
>>>>>
>>>>> As the MASTER_xxx macros cannot be used, have to define a new set
>>>>> of macros that can be used for indices in the above array. This
>>>>> is the reason for the ICC_BINDING_NAME macros.
>>>>
>>>> Then maybe fix the driver, instead of adding something which is not an
>>>> ABI to bindings and completely skipping the actual ABI.
>>>
>>> Will remove the ICC_xxx defines from the header. And in the
>>> driver will change the declaration as follows. Will that be
>>> acceptable?
>>>
>>> 	static int icc_ipq9574_hws[] = {
>>> 		[MASTER_ANOC_PCIE0 / 2] = GCC_ANOC_PCIE0_1LANE_M_CLK,
>>
>> What is the binding in such case? What exactly do you bind between
>> driver and DTS?
> 
> I think what Krzysztof is trying to say here is "the icc-clk API is tragic"
> and the best solution would be to make it such that the interconnect indices
> are set explicitly, instead of (master, slave), (master, slave) etc.
> 
> Does that sound good, Krzysztof?

Yes, I think earlier I expressed that icc-clk might needs fixes. The
indices you define in the binding must be used by DTS and by the driver.
Directly, otherwise it is error-prone and not really an ABI...

Best regards,
Krzysztof


