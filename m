Return-Path: <linux-kernel+bounces-106337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2970487ECAF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADAABB21870
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB51548E9;
	Mon, 18 Mar 2024 15:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="L5UflZSp"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915A852F83;
	Mon, 18 Mar 2024 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710777085; cv=none; b=mv5TWpq9HCivIK5/lY/pxD9AP7LryLi6JnX5c9QpE/vNGK3+wZdRPyII6VcsqS9QIwNYpNloUeGcoH61iAeIzcz7ZgO6GgxDMvZjlaKSm/KRIq3UEyJPLixoTLu/vIoBD66IqDYMnK3MeTN5rLLyDtV0yBVpFxKnjZphqfDeDWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710777085; c=relaxed/simple;
	bh=1fZJZWNWJbLA2ckdpmhdzs+n3qrTr7rfpP5E/IhBtCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mFuN5XZj1kXhaopYpKLq97Z1YQbjMyKeXjQDOFmyhLXwYnA+tZPmZLI+BoG/OHlTvxD99yK/adInq5o5ImHxbzY6dGrxeeBjpdRQ2jC0QbP6r2q1NTMF8uStxGFuFoNZrq4c72vkZAWP7a2m6eW2LK/EhDg8QDfS5+Zn7CBewbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=L5UflZSp; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 32915E0005;
	Mon, 18 Mar 2024 15:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710777075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A05q6KoR0JEWg+AapjwLG9ZBzCyQlsIDEalElRAtOMg=;
	b=L5UflZSpH2pvPOZJq67tgjFsh9FmimSSKG1CIj7BkPVn21owzSnc2FCv1Z8TXrEjr/COf8
	0uJVcTuS33VzvGeLFN5Y/XcLYfniCTmzArj5bhddNit2+9A67ea1/6PUZkM2PjfNt4bSIp
	gGAvUAuJtQaviRuMz5g6AlLTzU7rKdCtuTIqQHiGWdfqU3cyGUe4YpgG7UhCFDNJXV3WWo
	mTc9Zt0BhBXUR0vUveKS1+oTBzjeRHXVKOtVu2r+2ZQ+BGfMtE7ldow4JAVLJdcje4hfbj
	ro9naMUU213HFXZdugz0B+Ej0dYWyoTFn04VRizljW+pYZWxFze224bvvcYUVQ==
Message-ID: <4c1c4420-b539-4e29-972d-cb3838fff066@arinc9.com>
Date: Mon, 18 Mar 2024 18:50:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: mediatek: mt7622: set PHY address of
 MT7531 switch to 0x1f
Content-Language: en-US
To: Florian Fainelli <f.fainelli@gmail.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240314-for-mediatek-mt7531-phy-address-v1-0-52f58db01acd@arinc9.com>
 <20240314-for-mediatek-mt7531-phy-address-v1-1-52f58db01acd@arinc9.com>
 <94e3d09a-e6a4-4808-bc29-3f494b65e170@gmail.com>
 <62d128f1-11ac-4669-90ff-e9cdd0ec5bd9@arinc9.com>
 <71dd200a-0306-4baa-abab-6e6906aeef2a@gmail.com>
 <7d1ad037-d8ac-4b9a-b6d2-ab683e52a898@arinc9.com>
 <23f4c9b1-5c6b-4f3c-9290-41d195650368@gmail.com>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <23f4c9b1-5c6b-4f3c-9290-41d195650368@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 18.03.2024 18:38, Florian Fainelli wrote:
> On 3/18/24 08:26, Arınç ÜNAL wrote:
>> On 18.03.2024 16:02, Florian Fainelli wrote:
>>>>> Can we call it a pseudo PHY to use a similar terminology as what is done through drivers/net/dsa/{bcm_sf2,b53}*?
>>>>>
>>>>> This is not a real PHY as in it has no actual transceiver/digital signal processing logic, this is a piece of logic that snoops for MDIO transactions at that specific address and lets you access the switch's internal register as if it was a MDIO device.
>>>>
>>>> I can get behind calling the switch a psuedo-PHY in the context of MDIO.
>>>> However, as described on "22.2.4.5.5 PHYAD (PHY Address)" of "22.2.4.5
>>>> Management frame structure" of the active standard IEEE Std 802.3™‐2022,
>>>> the field is called "PHY Address". The patch log doesn't give an identifier
>>>> as to what a switch is in the context of MDIO. Only that it listens on a
>>>> certain PHY address which the term complies with IEEE Std 802.3™‐2022.
>>>>
>>>> So I don't see an improvement to be made on the patch log. Feel free to
>>>> elaborate further.
>>>
>>> I would just s/PHY/MDIO bus address/ since that is simply more generic, but if it is not written as-is in the spec, then I won't fight it much more than I already did.
>>
>> I'm not sure what you're referring to by spec. Are you asking how specific
>> the name of the PHYAD field is described on the standard?
> 
> Spec = IEEE Std 802.3-2022 standard, aka the document you are quoting.

Ok. The field is referred to as "PHY Address" (capital A) in a sentence on
the standard. I interpret that as it defines the term to mention the field
in a sentence which is why I'd like to stick to it on my patch log.

Arınç

