Return-Path: <linux-kernel+bounces-34908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D427E838912
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053F21C21819
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EED56B6F;
	Tue, 23 Jan 2024 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="C2jQQpBZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V4Pn7sZ3"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091625C60C;
	Tue, 23 Jan 2024 08:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705998796; cv=none; b=uZW5GWyJJNR/VA+NEjeckehyMWibMCoitS+WHAThXT/JlUyz5rTHsu+7MygLDr6idT1wSpkk4dclR8fTd+HSfDxfusyp2qME95oMLkmHJBnFO7TxEU29Zli68RXzc4oM/6DsGdD+81HZCbJpy/SBPGj0P24sKVkl8Akk6FKX6xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705998796; c=relaxed/simple;
	bh=3W4oCTdv0FXEFahQwcsqyn/FRaGXMhdpGJXywPb64hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tI4RrlFP+RXUPggQLr+/msHpj4VvCCecNyphyqrtUYFUjjGxHxnKuHVWJ5UHNgXb0z95FSqs6wZYUtaNscRH2vVQz7p2Uf8HynFDBYxRcLQKCAxqNlMMx6qWSKrW1Awrt5/euW6LC+s/ce99kWircaUuMnrAmQ8/LOJ4QL7JjF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org; spf=pass smtp.mailfrom=feathertop.org; dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b=C2jQQpBZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V4Pn7sZ3; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 08B923200AC2;
	Tue, 23 Jan 2024 03:33:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 23 Jan 2024 03:33:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1705998791; x=1706085191; bh=3W4oCTdv0FXEFahQwcsqyn/FRaGXMhdp
	GJXywPb64hs=; b=C2jQQpBZjiTlZxWq/nsAQj9sYzK41RT2t7QgkgSFBK4et80H
	cWUSkh3GUxz8Yc4v2Ta6ftvzxdhXQvJgzJQsvame6l1FQDBpFa0/inRr9Er0C4tr
	xgJ+zIXKSLbq0yT3MZB+00qwAaH+7BgvcWffyo1gCwLRUG7gjgsZ7AsUOV2U04JI
	2oZQJve/0aC+KIiaQB8XhVjbLsbsyaV003up94jneDia7d+f7rt/AE0Y+HEZ9nQa
	/CLyHQeVSmxz1iI59QWA3QjTCChkUXaDQRI+vBp0mhPDhwXyl5fNsczOEvs/9o/j
	FA2+TeCv9/UBeO64N5k665gj75NOOcMpWfhSSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705998791; x=
	1706085191; bh=3W4oCTdv0FXEFahQwcsqyn/FRaGXMhdpGJXywPb64hs=; b=V
	4Pn7sZ34NQuv4MvbyKMEzfMWGVvQvHt+AP4RDfQZSC2Jl9cix8jQXRWHCzbtui86
	HQu2zbSIZbznekkJqZYteWG845W9sT9l3XTkC8HFPrwATMCTkCrOR5lCs6lVlyW9
	uI4+dEBochgxzIRBeA7mW/A2qajKecew1AGwo9Lg0a9RPxxvlGMVDH3me/zFTHJ5
	f1AEq+Z0OPnDoA4tn1vt+wJLp11c92Ab6gCjkDre1/r8YTP9heze+25pqLcrTV4Z
	yPYHeQq8g9RdUjojFnrs/K1dq5ygmS/9uhRnYb1wH6XNT0xU+a1dtfSTHOSKVmSo
	uscZQ2OA8w2t6pP+OmU+w==
X-ME-Sender: <xms:xnmvZcMl1U8ryt4MaF4-8iy-uaNV4ypxh02D1mCwyW4gNBB1C9OPpw>
    <xme:xnmvZS9iaK-FcP9UkD2fnAM6SJPTA2vIdNbCoQyHJU8_0Q6Yjg1wspIBzS6K5XjEV
    4qJW5mHow>
X-ME-Received: <xmr:xnmvZTRgXLT7LfaB0o6w7GZf4M_rEPxoaOxDp0HkFSJ4ENw2Gr6MPvWLMA6KE1kVpPWxsmaquwRr4Hnd5ClvdtVylRq1W0qQnVS6EQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekjedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepvfhi
    mhcunfhunhhnuceothhimhesfhgvrghthhgvrhhtohhprdhorhhgqeenucggtffrrghtth
    gvrhhnpeeugeefgfevueeitdehfffgfeevjeekteeihffhvdejveelhfeukeduueelgefh
    keenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtih
    hmsehfvggrthhhvghrthhophdrohhrgh
X-ME-Proxy: <xmx:xnmvZUsal9bpM_dW-cDt-Bp_pG7XDWNL2hLqf5OedLxVnlRHKFQNUg>
    <xmx:xnmvZUdYXaMHXAXwfqjClkA9d1JIU2_oCm_Yky1m43itPAOMvMMz4A>
    <xmx:xnmvZY38aOA0TCd6K94oCp5QkkZOcT_3aEiHiS1_33qy0ZrWeMyUUQ>
    <xmx:x3mvZY1MG1s_IJhE35Inxb_9OYgFMbEtSzCkW_kLz7T-auOOAcgfHg>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jan 2024 03:33:05 -0500 (EST)
Message-ID: <9cb6ae6b-15df-4467-b1b4-e0efd61c0d8f@feathertop.org>
Date: Tue, 23 Jan 2024 19:33:02 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] dt-bindings: rockchip: rk809: Document audio codec
 properties
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-rockchip@lists.infradead.org, conor.dooley@microchip.com,
 robh+dt@kernel.org, devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Chris Zhong <zyw@rock-chips.com>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lee Jones <lee@kernel.org>, Zhang Qing <zhangqing@rock-chips.com>,
 linux-kernel@vger.kernel.org
References: <20240120135529.899403-1-tim@feathertop.org>
 <20240120135529.899403-3-tim@feathertop.org>
 <04ccf5f5-1f02-42f9-b1fc-b781c54d7ae9@linaro.org>
 <93d775df-af84-44ff-870e-f720a33ddf34@feathertop.org>
 <0b0a4c9f-0549-4566-a900-b1d7de5838d5@linaro.org>
From: Tim Lunn <tim@feathertop.org>
In-Reply-To: <0b0a4c9f-0549-4566-a900-b1d7de5838d5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/23/24 18:37, Krzysztof Kozlowski wrote:
> On 23/01/2024 05:10, Tim Lunn wrote:
>> On 1/22/24 19:14, Krzysztof Kozlowski wrote:
>>> On 20/01/2024 14:55, Tim Lunn wrote:
>>>> Rockchip RK809 shares the same audio codec block as the rk817 mfd, and
>>>> is compatible with the existing rk817_codec driver.
>>> Please use subject prefixes matching the subsystem. You can get them for
>>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>>> your patch is touching.
>> Ok I will check this.
>>>> This patch introduces to the binding the standard property #sound-dai-cells
>>>> and also an optional codec child node to hold codec specific properties.
>>>> Currently there is only one property in this node however the downstream
>>>> driver shows a number of other properties that are supported by the codec
>>>> hardware, that could be implemented in the future. This maintains the
>>>> existing driver ABI and keeps consistency with the rk817 bindings.
>>> So you are adding a new node? Just for one property? No, just put it
>>> into parent node.
>> The existing upstream codec driver parses the property from the "codec"
>> sub-node, if I
>> move it to the parent node here, I will need to patch the codec driver
>> to search in both locations,
>> so as to not break the rk817 bindings.  If that is preferred, I can do
>> it that way.
> Your long commit msg has just very short mention about existing driver
> and the rest is not helpful. Please rephrase to explain why and what you
> are doing it.
>
OK I will rephrase both commit messages for the next version.
>>> Downstream driver does not matter at all in that aspect.
>>>
>> The codec hardware supports additional properties but they are not
>> implemented currently in
>> upstream driver.
>
> Again: it does not matter. Bindings are not about drivers.
>
> Best regards,
> Krzysztof
>

