Return-Path: <linux-kernel+bounces-33277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EB28367DC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10EA51F23CC8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FFA5A114;
	Mon, 22 Jan 2024 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WAS0KDUQ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD7B5A10F;
	Mon, 22 Jan 2024 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935582; cv=none; b=molLmWdQETVy6kwjcHtL6HveTQfaBgmxor5V1HBL94UOMfQS+0kiRXNZmgqIFz6XlvaBF+W5OZSNzfMQ1ru0zwGFhB/7oo+9MvEWv3VJsTqzlokLWPcMWVnuUJrqRH25lP2wy3yDtI500LQY2O2wivVXiRJFv6+7VyvvN3sNanU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935582; c=relaxed/simple;
	bh=72awLrC95FZfePkRhHaH0kmE8jNzlhiZyJTOnOQmCaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QCL1SrnP7R/TJ/5GGxXp4zVxINb4bUB5oz17/TutCYCzOjteX58+Khg+TgPnqkS8QU+BLhBEtFZCKaVQf4fViWBFQf0/Edx5lw95dkgq/ME3aQm/ogAT1eHqXeYDoZD5ZWcnhvSf+FKqBjnBn++yDVkk2AXFSRUFj5mMtpallWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WAS0KDUQ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705935579;
	bh=72awLrC95FZfePkRhHaH0kmE8jNzlhiZyJTOnOQmCaQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WAS0KDUQj9f4b2k33ZTrz2Q2/N0epdobShFxXhdTDDp2L4ZIOz7Og6T5uvsEfRNYH
	 bT3kjV46JXMvDrSOfJJ/VbojlkD2Hn2xLLZFLZvTUDEORPcrY/XZsGuxDl1QV3ppAQ
	 4GesLbXv+GUWLRwWmNVoFi/9nOEKOD5h4YrEgJ+8dp0EXSrdgM96GywiseVLgqRJiN
	 312VdKfycu1zSg5u24f2ijRnYMyYj1F0M2XQjXS/1WWb3F8ZYCiTuhfYerjKrJ1kSY
	 9d38NYHpA9n0UuRmXxjmqBm6lboURxq7RMIZTf4/vbeZV9uvxpc2zaNG5jfHuIzv1U
	 GBHK+CBWYNCPg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 97DAE3781F89;
	Mon, 22 Jan 2024 14:59:38 +0000 (UTC)
Message-ID: <48946c81-dad0-4e2d-9569-5fbac1675bb6@collabora.com>
Date: Mon, 22 Jan 2024 15:59:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] arm64: dts: qcom: msm8956-loire: Add SD Card
 Detect to SDC2 pin states
Content-Language: en-US
To: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, ~postmarketos/upstreaming@lists.sr.ht,
 Luca Weiss <luca@z3ntu.xyz>, Adam Skladowski <a39.skl@gmail.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Martin Botka <martin.botka@somainline.org>,
 Jami Kettunen <jami.kettunen@somainline.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240121-msm8976-dt-v2-0-7b186a02dc72@somainline.org>
 <20240121-msm8976-dt-v2-6-7b186a02dc72@somainline.org>
 <9d3623f8-697b-44ab-a9eb-9d2d305b0e5c@collabora.com>
 <iatieesr52v5au4kkovw3gc34tn3snt454grq7le66oar6x7t4@4jfwxgxov36v>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <iatieesr52v5au4kkovw3gc34tn3snt454grq7le66oar6x7t4@4jfwxgxov36v>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 22/01/24 14:49, Marijn Suijten ha scritto:
> On 2024-01-22 12:48:27, AngeloGioacchino Del Regno wrote:
>> Il 21/01/24 23:33, Marijn Suijten ha scritto:
>>> In addition to the SDC2 pins, set the SD Card Detect pin in a sane state
>>> to be used as an interrupt when an SD Card is slotted in or removed.
>>>
>>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
>>> ---
>>>    arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi | 17 +++++++++++++++++
>>>    1 file changed, 17 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi b/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi
>>> index b0b83edd3627..75412e37334c 100644
>>> --- a/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi
>>> @@ -264,10 +264,27 @@ &sdhc_1 {
>>>    	status = "okay";
>>>    };
>>>    
>>> +&sdc2_off_state {
>>> +	sd-cd-pins {
>>> +		pins = "gpio100";
>>> +		function = "gpio";
>>> +		drive-strength = <2>;
>>> +		bias-disable;
>>> +	};
>>
>> Are you sure that you really don't want card detect during system suspend?
> 
> Does it make a difference if the rest of pinctrl and the SDHCI controller are
> also turned off?
> 
>> You could simply add a sdc2-cd-pins out of sdc2_{on,off}_state and add use it for
>> both default and sleep.
> 
> This sounds close to what Konrad suggested by using a new block wit its own
> label rather than extending the existing state.
> 
>> pinctrl-0 = <&sdc2_on_state>, <&sdc2_card_det_n>;
>> pinctrl-1 = <&sdc2_off_state>;
> 
> You said both, but it's not in pinctrl-1 here?  (And might unselect bias-pull-up
> implicitly instead of explicitly selecting bias-disable via an off node?)
> 

I meant to add it to both, sorry.

In any case, take the typo'ed example as a simplification of your first version :-)


> - Marijn
> 
>> Cheers,
>> Angelo
>>
>>> +};
>>> +
>>>    &sdc2_on_state {
>>>    	clk-pins {
>>>    		drive-strength = <10>;
>>>    	};
>>> +
>>> +	sd-cd-pins {
>>> +		pins = "gpio100";
>>> +		function = "gpio";
>>> +		drive-strength = <2>;
>>> +		input-enable;
>>> +		bias-pull-up;
>>> +	};
>>>    };
>>>    
>>>    &sdhc_2 {
>>>
>>
>>


