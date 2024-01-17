Return-Path: <linux-kernel+bounces-28796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9EC83031D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 108301F25979
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BFE1DA39;
	Wed, 17 Jan 2024 09:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="el1d9IgE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y7RMsG2j"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5555314A83;
	Wed, 17 Jan 2024 09:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485547; cv=none; b=ZawT+1zMW6cQWYMDIGoIFhDSsO4bVn1xiYX1ulKqbsijhw9SCbE0KfoScTGsAUTM9GiU345boAnFElhhvFmGpzI5waknjPs4rJ9QbnT8CEbjpbQ9CQenC3BtV7YIA2p+qTBHUAkTDpAGO9drfwc2f7PzECBcLlHEPt6/fnQD3tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485547; c=relaxed/simple;
	bh=mRT3EjLZpYhhIUIaXauClGnrvF2Fbf6aNEoyqkA3BCk=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=D7BOWNMqX0Mr1EJbF/Ht+DW8kv6vWJuOhFAIgaJgCmsiorSftVcgPunSITbHSpSXGZhTNLD6ggfN8a9uLaM0lO3iJlIwl0AJ7iDfdA2VZnsFAWDqt6bRl7IiUMZR1vC7cdMdgnLryYTmSyh1A/+Kv2VFFZUcx0cTb6ESqd+p44c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org; spf=pass smtp.mailfrom=feathertop.org; dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b=el1d9IgE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=y7RMsG2j; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 418985C01BD;
	Wed, 17 Jan 2024 04:59:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 17 Jan 2024 04:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1705485544; x=1705571944; bh=FDqjaZ03gFkn9ORtPEiPxozWQL1Qp2mV
	EXyd5abNaqU=; b=el1d9IgECykrWvy2Dn3AKGmFwsnowYik3h06zjECRGi4+y4I
	QH6Xrg5k3ZzIrdrhOj3jwaleoK7bh12DYolGADB/gkp8wyBQP+K75znWZKIL3FBj
	8Zex3DKGbFe4lCbHHkGp79msfJwgSeFV8N5Y1elBdu7TwfPCwEYs24aV/RN2VEVg
	q3h/vDm5fF/7AJFnQk2arbSGQqdB0QY828I9cdrX+ld8Nyg+d7v0Tg/YZIBHq/g7
	gEZx8IK22N8V3xEDJe87LJblm6Xq6q7Wy+BI9niDmuUPk8ozCUVP1lxyUc4Nw7kg
	o/AYp9qdWief0Qn7JY51AhQSyNK0qjQXLKtxWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705485544; x=
	1705571944; bh=FDqjaZ03gFkn9ORtPEiPxozWQL1Qp2mVEXyd5abNaqU=; b=y
	7RMsG2jIPO+QzvMxqt/FW9cL/6QkWznRjH8MAQX8zlcSg/nWg+T0TxJCB513UjSf
	ZzPn9PY4VWJFRoqTSlHe456lmufIl/C3ZeyErx3ndtN0F9q+6jK1fd6+X7ILWm8n
	Kj+fDVIQ4fLnrnEN3PC8tMUcAyt5Lksaz45mOkG/PewTXZW9QI5ZRaTDzcwA9gJK
	QrwBIydoa3YPgHPdaNb+jXjOqk4Ad6IUaMUvLIlnQmQ2Sg+7EdZ5h/cciECgRbOW
	yq0OHRSfy1aBR+urZqtH0GQoKzIsOsIodQdq2sRzHUVN3x9N4GR6NlQRhGNcln62
	0huKsvg6fP8KTw9xH837Q==
X-ME-Sender: <xms:56SnZX2nXUkAYbhOcjgGwpkCH1aLPc4_qM8hb9Vw0iUH3mMMzkuf2w>
    <xme:56SnZWG6jHaB2pVIvBHMGUtyitbqRdM1kmMiXDR0rre3_-J2ZcWWImQ7sFUd3i8ZS
    HlTvj4khA>
X-ME-Received: <xmr:56SnZX7ZKtBrx5mtrUHTmhYR-mGSl1PDN_qOA9r3i-MTPOOPkT5G7avUUNobOAq0TqHaBpHEt8H_h_FYkNk9HyS2GM2sZ42PkJD5Gw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejhedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhm
    ucfnuhhnnhcuoehtihhmsehfvggrthhhvghrthhophdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueegfefgveeuiedtheffgfefveejkeetiefhhfdvjeevlefhueekudeuleeghfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhimh
    esfhgvrghthhgvrhhtohhprdhorhhg
X-ME-Proxy: <xmx:56SnZc06sSo7kXK53_9jJ6gjrv334GReo3Ufsv8YBRFLMcSgl0y8lQ>
    <xmx:56SnZaH7iZ97AohgmTeahkKtLtgiz3e4Z-kdPYq5ymQGr565uZptBg>
    <xmx:56SnZd9lJf3AOLT-EjNKayic3rbT_k5djkSKen-9kblokQXmbkBMKQ>
    <xmx:6KSnZV-u7JgdL-RQOv2D54bq9ir1EKDtf7HOWR-89LcpLpRgzoEEeA>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jan 2024 04:58:59 -0500 (EST)
Message-ID: <9636bcb9-6b4b-41ef-bcfc-ff39c11d127e@feathertop.org>
Date: Wed, 17 Jan 2024 20:58:56 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: rockchip: Document rk809 support for
 rk817 audio codec
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Conor Dooley <conor@kernel.org>
Cc: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Chris Zhong <zyw@rock-chips.com>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Zhang Qing <zhangqing@rock-chips.com>, linux-kernel@vger.kernel.org
References: <20240116132102.3272682-1-tim@feathertop.org>
 <20240116132102.3272682-2-tim@feathertop.org>
 <20240116-mangle-parish-93b5cd672d17@spud>
 <72ed509c-f754-4e65-a65e-130185777c53@feathertop.org>
 <b798a7cc-c9fd-4bc3-bb14-401e10e4eeb8@linaro.org>
From: Tim Lunn <tim@feathertop.org>
In-Reply-To: <b798a7cc-c9fd-4bc3-bb14-401e10e4eeb8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/17/24 20:22, Krzysztof Kozlowski wrote:
> On 17/01/2024 10:19, Tim Lunn wrote:
>> On 1/17/24 04:06, Conor Dooley wrote:
>>> On Wed, Jan 17, 2024 at 12:21:00AM +1100, Tim Lunn wrote:
>>>> Rockchip RK809 shares the same audio codec as the rk817 mfd, it is also
>>>> using the same rk817_codec driver. However it is missing from the
>>>> bindings.
>>>>
>>>> Update dt-binding documentation for rk809 to include the audio codec
>>>> properties. This fixes the following warning from dtb check:
>>>>
>>>> pmic@20: '#sound-dai-cells', 'assigned-clock-parents', 'assigned-clocks',
>>>>      'clock-names', 'clocks', 'codec' do not match any of the regexes:
>>>>      'pinctrl-[0-9]+'
>>>>
>>>> Signed-off-by: Tim Lunn<tim@feathertop.org>
>>>> ---
>>>>
>>>> (no changes since v1)
>>>>
>>>>    .../bindings/mfd/rockchip,rk809.yaml          | 30 ++++++++++++++++++-
>>>>    1 file changed, 29 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
>>>> index 839c0521f1e5..bac2e751e2f2 100644
>>>> --- a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
>>>> +++ b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
>>>> @@ -12,7 +12,7 @@ maintainers:
>>>>    
>>>>    description: |
>>>>      Rockchip RK809 series PMIC. This device consists of an i2c controlled MFD
>>>> -  that includes regulators, an RTC, and power button.
>>>> +  that includes regulators, an RTC, a power button, and an audio codec.
>>>>    
>>>>    properties:
>>>>      compatible:
>>>> @@ -93,6 +93,34 @@ properties:
>>>>            unevaluatedProperties: false
>>>>        unevaluatedProperties: false
>>>>    
>>>> +  clocks:
>>>> +    description:
>>>> +      The input clock for the audio codec.
>>>> +
>>>> +  clock-names:
>>>> +    description:
>>>> +      The clock name for the codec clock.
>>>> +    items:
>>>> +      - const: mclk
>>> You have one clock only, why do you need to have clock-names?
>> This is just documenting the existing rk817 codec driver, which is using
>> the name to get the clock:
>>
>> devm_clk_get(pdev->dev.parent, "mclk");
>>
>> Thus i dont think clock-names can  be removed in this case? atleast not
>> without patching the driver as well?
> Your commit msg claims this is for existing driver using rk817_codec. So
> what about rk817? It does not use clocks?
>
rk817 uses exactly the same properties as what I included here. i.e it 
includes both clocks and clock-names.
My point above was that I dont think I can just remove the clock-names 
property as Conor suggested? I could be wrong though.
>
> Best regards,
> Krzysztof
>

