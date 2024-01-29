Return-Path: <linux-kernel+bounces-42581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27438840371
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5731F22A4E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6802D5B20F;
	Mon, 29 Jan 2024 11:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="I9yZrPy2"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227545A78A;
	Mon, 29 Jan 2024 11:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706526311; cv=none; b=sOpAh1aEceTUPr9Q4JuK2zyTiekVUebWiYBijf2gdQTsD+7UUSwoQ+I4aG46UrrnyWdWevlWQmlOylhYE/CWckdS7BvWGO5HluQ8A7Hxp5CdR6YS/dKbd8EWoLCu/G1teXwDIvtqmluvjJ4s377D9Sf+f440bB4udp9yOq9GZoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706526311; c=relaxed/simple;
	bh=cAM4F7mXABDgUuuAxryLFBBtLF6iWnSdz7msYKa89Q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dvMPn79fG1Ts/yzP31Cp1eRUlrVfZ9wgf6OAof6n9z4neYaCVMsEYnvb6CwHQYi64S2IJky0leSaYEhCsR4LZefBoHwywNddubwsIa/KHHJHVqnuLlvtYS7Soof4JkZ29ZnmHGoDTPGUahB1ciQAGV6lk331FZ63QzX8DsNCxVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=I9yZrPy2; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706526308;
	bh=cAM4F7mXABDgUuuAxryLFBBtLF6iWnSdz7msYKa89Q4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I9yZrPy29regUhzuTyK40h8+Nik5jOXg/Uh7inRJaKSITeDuaNUU718eX3r5KG136
	 IUsv7lVEj6sv3aVKSNWRpVnnk/1ZUydGunOwBuzdcQCuOd6MxYYcwHUUwQDJyvZAi6
	 Zt5Ddh2nofNWeGRZG/JwWfW7B4O0LaHQ01U+RJFWIlSifx+JOUE874qkY7HD0BR5/F
	 rmkKVSjl/MGRF0fHb7sFVwRViF2nTqzuutSKeuBrHpvTWwMNUNfZma+OvQjLDW672U
	 +r5X+0mwKFiKxzIE+YRN1S/EAjv05BDKjmkHqfBSJCgYPYx0R+htrNndyh2iNhycod
	 xiyZgFy5ugCDg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A482C37810CD;
	Mon, 29 Jan 2024 11:05:07 +0000 (UTC)
Message-ID: <81783153-45a4-478d-a0d1-8ab401e9da58@collabora.com>
Date: Mon, 29 Jan 2024 12:05:07 +0100
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
 <48946c81-dad0-4e2d-9569-5fbac1675bb6@collabora.com>
 <quqkqv4eer7tmubvsqkbuwammqaa5qqxojedsh42ryax3laah7@v7khc2cq4eti>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <quqkqv4eer7tmubvsqkbuwammqaa5qqxojedsh42ryax3laah7@v7khc2cq4eti>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 22/01/24 16:15, Marijn Suijten ha scritto:
> On 2024-01-22 15:59:37, AngeloGioacchino Del Regno wrote:
>> Il 22/01/24 14:49, Marijn Suijten ha scritto:
>>> On 2024-01-22 12:48:27, AngeloGioacchino Del Regno wrote:
>>>> Il 21/01/24 23:33, Marijn Suijten ha scritto:
>>>>> In addition to the SDC2 pins, set the SD Card Detect pin in a sane state
>>>>> to be used as an interrupt when an SD Card is slotted in or removed.
>>>>>
>>>>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
>>>>> ---
>>>>>     arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi | 17 +++++++++++++++++
>>>>>     1 file changed, 17 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi b/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi
>>>>> index b0b83edd3627..75412e37334c 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi
>>>>> @@ -264,10 +264,27 @@ &sdhc_1 {
>>>>>     	status = "okay";
>>>>>     };
>>>>>     
>>>>> +&sdc2_off_state {
>>>>> +	sd-cd-pins {
>>>>> +		pins = "gpio100";
>>>>> +		function = "gpio";
>>>>> +		drive-strength = <2>;
>>>>> +		bias-disable;
>>>>> +	};
>>>>
>>>> Are you sure that you really don't want card detect during system suspend?
>>>
>>> Does it make a difference if the rest of pinctrl and the SDHCI controller are
>>> also turned off?
>>>
>>>> You could simply add a sdc2-cd-pins out of sdc2_{on,off}_state and add use it for
>>>> both default and sleep.
>>>
>>> This sounds close to what Konrad suggested by using a new block wit its own
>>> label rather than extending the existing state.
>>>
>>>> pinctrl-0 = <&sdc2_on_state>, <&sdc2_card_det_n>;
>>>> pinctrl-1 = <&sdc2_off_state>;
>>>
>>> You said both, but it's not in pinctrl-1 here?  (And might unselect bias-pull-up
>>> implicitly instead of explicitly selecting bias-disable via an off node?)
>>>
>>
>> I meant to add it to both, sorry.
>>
>> In any case, take the typo'ed example as a simplification of your first version :-)
> 
> Okay, I'll resend a version that creates a new pinctrl node and applies it to both cases.
> 
> Unfortunately I can no longer test and confirm that it makes a difference
> to have the card-detect IRQ always biased, even while the SDHCI controller
> is "asleep" or off, so I'll trust your word for it.  If I remember correctly
> downstream turns it off as well?

Marijn, I don't remember anything about a downstream kernel from 10 years ago..!

But yes, it's okay to do so - the worst case is that it won't wake up, but that
won't happen, as it's going to generate an interrupt and wake up the entire system
which includes the SDHCI controller.

Go on!

Cheers,
Angelo


