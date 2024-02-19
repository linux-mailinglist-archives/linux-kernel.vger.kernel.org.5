Return-Path: <linux-kernel+bounces-71091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4677F85A087
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794031C215FE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26C225577;
	Mon, 19 Feb 2024 10:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="roMbp9l4"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AF825601;
	Mon, 19 Feb 2024 10:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708337249; cv=none; b=WHWtf7KnVMK5zZjaD8p/VLICk76gORSwqu5R+wtCA0GPjYwJ3FpB2Xgcydy/ubGqgu+QHv1P2xHYTmoUgMBqkYS87REYgVxgx0F/MjlUfWgFKBd3ityHhL6xBlc4eFfS1pud1Rf3VMuPGxIv8YKGyZZYuGyeKZYSS0laJdpN2hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708337249; c=relaxed/simple;
	bh=am4RhiD/FxNhL3HLfhI49lqlwjcS8S6GwDUUEW8SpzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KMh83Dxx/MdaYcv2sYnjQaEagz59KTxwbuqwHLYtctiWXLYQoSA/oXRsaRYjABqciaSHDCN142hLtf7xxtwTH925OBP1/zYT882gfu/FqMQnO3r9mrIODj5noSFlrEaiyBw9wq/4/xJ9OPMOpB+QxIlaLH45jSypV+YL4qHytvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=roMbp9l4; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708337246;
	bh=am4RhiD/FxNhL3HLfhI49lqlwjcS8S6GwDUUEW8SpzA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=roMbp9l49OJOpROD48oGAD38RS1uRNs6pN+0W1yv3jOIExs8smXlzqAyxN7hltckj
	 DhY008fWzU6Z8jydVKOVB6WG0i99EODJOHC4b41eI6J1TUqU6VKToGlBJnzVMG3hNq
	 TQzAoUdR/CQXAwuff8KXJxNZ8kJg0NQYGPHfV3T04toPx7f08ClzrwwMh9BteqLpO/
	 A+yt4guoJ/NJT26sbgRZNrw+g//ATmKcGpN4XQ0P14KT0FlTmiS+3KMJlBiQSujnnQ
	 HR0XX0wTlwdDrYFUdx+dKdpnjA0x/F+saXK6BOvHHP5dEb4c/8Lo96vC2oHErgvlKv
	 4FlOlMA9beDAQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4D5883781FF7;
	Mon, 19 Feb 2024 10:07:25 +0000 (UTC)
Message-ID: <9cc4fc3f-d697-4e51-a629-9f581dc3c35b@collabora.com>
Date: Mon, 19 Feb 2024 11:07:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: arm64: mediatek: add Kontron
 3.5"-SBC-i1200
Content-Language: en-US
To: Michael Walle <mwalle@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Chen-Yu Tsai <wenst@chromium.org>
References: <20240219084456.1075445-1-mwalle@kernel.org>
 <ed3530f0-227a-47f2-938c-28eba90dd6eb@collabora.com>
 <CZ8YCQETS7LL.1BLJJZNCLV7DT@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CZ8YCQETS7LL.1BLJJZNCLV7DT@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 19/02/24 10:36, Michael Walle ha scritto:
> On Mon Feb 19, 2024 at 10:23 AM CET, AngeloGioacchino Del Regno wrote:
>> Il 19/02/24 09:44, Michael Walle ha scritto:
>>> Add the compatible string for the Kontron 3.5"-SBC-i1200 single board
>>> computer.
>>>
>>> Signed-off-by: Michael Walle <mwalle@kernel.org>
>>> ---
>>> v2:
>>>    - convert enum to const as there is only one specific board
>>>
>>>    Documentation/devicetree/bindings/arm/mediatek.yaml | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
>>> index 09f9ffd3ff7b..add167d8b8da 100644
>>> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
>>> @@ -357,6 +357,11 @@ properties:
>>>                  - radxa,nio-12l
>>>              - const: mediatek,mt8395
>>>              - const: mediatek,mt8195
>>> +      - description: Kontron 3.5"-SBC-i1200
>>> +        items:
>>> +          - const: kontron,3-5-sbc-i1200
>>> +          - const: mediatek,mt8395
>>> +          - const: mediatek,mt8195
>>>          - items:
>>>              - enum:
>>>                  - mediatek,mt8516-pumpkin
>>
>> I understand that you took inspiration from the Google Chromebooks entries, but
>> those are separated only because they've got "a bunch of revisions".
>>
> 
> I don't really care about the description. It's just the way I've
> done it in the past. And in this file, there is also google,burnet,
> google,cozmo, google,damu, without any further revs.
> 

Yeah, I have to check why it is like this - as in - if there's any real reason for
those to be like that... otherwise I wouldn't mind cleaning 'em all up.

Whatever - that's not on you, and completely irrelevant to this specific patch,
so don't worry about the cleanup of the other entries.

>> For machines that don't have a billion compatible strings, I would suggest to
>> add the compatible under a single big entry: like this, the binding is (imo) a
>> bit more readable .. and cleaner.
>>
>> Eventually, the machine name is in the devicetree so we're not losing any kind
>> of information anyway... :-)
>>
>>         - items:
>>             - enum:
>>                 - kontron,3-5-sbc-i1200
>>                 - mediatek,mt8395-evk
>>                 - radxa,nio-12l
>>             - const: mediatek,mt8395
>>             - const: mediatek,mt8195
> 
> Ack. I'll give you some time to look at the actual DTS before
> posting a new version.
> 
> -michael



