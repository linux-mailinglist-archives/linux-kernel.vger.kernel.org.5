Return-Path: <linux-kernel+bounces-116694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AEE88A2A4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9DD21F2CB2E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56E214F118;
	Mon, 25 Mar 2024 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="k0TiPAfG"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3029614F9E6;
	Mon, 25 Mar 2024 08:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711355043; cv=none; b=PqGCtrePjrt+Ien+QUVPpEi8ddRlB6B0lo9EjMQAbO3iEsBv7fGFxs/2frWjTx4bfRsexbxXgBXF0aa3C6bgQNxIiux1gMtgp2u8w6GB13Tus9hrLTd8uHBXrA9xBhnkPUNjfmXM0+qwDspYxZvj6uysLq5nrDxZ+LKRim60DM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711355043; c=relaxed/simple;
	bh=FxeJBW8SRhWP/KtNW8MieDakXdayiD+/WVoSml7b8l0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3RM9DMarAruIaoLDviKnvrjAZA65qAnqJyujONcZCK+FtuJEIyxCkS7lxsdniO82pymaHdac59xu7Km6KxAuFGEyWM030hsprasHZRA/5wGwHq9N4Dt8KVpQg6r4LhbikPm8v6h5Kg1PHOBQ0D4xYZsgqlpfY2AIxmD6nmc8qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=k0TiPAfG; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711355040;
	bh=FxeJBW8SRhWP/KtNW8MieDakXdayiD+/WVoSml7b8l0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k0TiPAfGSgiIx1WnbJvOpKq7uVHspIBm69VBmNfa1dmMUr+dkN4zSASKiw5MtDD7z
	 WXmrj/V2LsPSU73F6+W9xs9Q5U9H3/KJLunK8SHalbg9SX/gocuDwGqhAerUohj2Fk
	 nZaucggQ1R0vO+Dn0USpHSFWw6B/taFk9/NJea9uUHYioH/aGW1/uIgj4Cs6JU3VYC
	 w2Ie/hTHkOcstcEWRy0L9DIK5b5wIGXxMyYBvQhcHfPoYlm4Lp21jz9uBZPD3frbkj
	 1zuyVO38akjU8l1lxCzTiwV/NDzvrWN/YBH1PBOKlzHedu3br1JN4YHg7i/GvHwbHo
	 G6xjvlMmSis2A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3F0E137813B7;
	Mon, 25 Mar 2024 08:23:59 +0000 (UTC)
Message-ID: <f90b2c8b-6eb3-46dc-abcc-600248218b4e@collabora.com>
Date: Mon, 25 Mar 2024 09:23:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: soc: mediatek: Add support for MT8188
 VPPSYS
To: Conor Dooley <conor@kernel.org>
Cc: linux-media@vger.kernel.org, mchehab@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, amergnat@baylibre.com, moudy.ho@mediatek.com,
 hverkuil-cisco@xs4all.nl, sebastian.fricke@collabora.com,
 u.kleine-koenig@pengutronix.de, chunkuang.hu@kernel.org,
 p.zabel@pengutronix.de, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20240322092845.381313-1-angelogioacchino.delregno@collabora.com>
 <20240322092845.381313-2-angelogioacchino.delregno@collabora.com>
 <20240322-lugged-tabloid-3d5a85dc58d0@spud>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240322-lugged-tabloid-3d5a85dc58d0@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 22/03/24 18:42, Conor Dooley ha scritto:
> On Fri, Mar 22, 2024 at 10:28:42AM +0100, AngeloGioacchino Del Regno wrote:
>> Add compatible for MT8188 VPP mutex.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> You should at least mention the difference between this any anything
> else.
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

It's exactly always the same difference for MuteX blocks: different bits to
activate mute for some IP ... but yeah, you're right, I'll shoot a word about
this in the commit description on v2 (waiting a bit before doing that anyway).

Thank you!

Cheers,
Angelo

> 
> Thanks,
> Conor.
> 
>> ---
>>   .../devicetree/bindings/soc/mediatek/mediatek,mutex.yaml         | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
>> index ba2014a8725c..a10326a9683d 100644
>> --- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
>> +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
>> @@ -33,6 +33,7 @@ properties:
>>         - mediatek,mt8186-disp-mutex
>>         - mediatek,mt8186-mdp3-mutex
>>         - mediatek,mt8188-disp-mutex
>> +      - mediatek,mt8188-vpp-mutex
>>         - mediatek,mt8192-disp-mutex
>>         - mediatek,mt8195-disp-mutex
>>         - mediatek,mt8195-vpp-mutex
>> -- 
>> 2.44.0
>>



