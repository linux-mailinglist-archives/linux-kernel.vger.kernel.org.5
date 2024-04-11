Return-Path: <linux-kernel+bounces-140743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2635A8A189B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 613F31C229F6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A077119BBA;
	Thu, 11 Apr 2024 15:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ori8kAhp"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E01A134B0;
	Thu, 11 Apr 2024 15:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849020; cv=none; b=bDGHwI4vStzZBnZ0FnfbHESVV/+tuSXPp3zV3yZu5/XoKi3ShF2T6e2UH7ToCzVLyMwMLwnuC1SL85gz5NEewVjYawB8GvZMtJ29S83KES5Wgz5aLMFQjZlGe0QmiCXtksHVqY6sMF7S0IIP/qKXsHo2vIlqe/DKY+8Y5Bjpc8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849020; c=relaxed/simple;
	bh=Izm5X0JHoxEV2++y1yn48NkTsf5UKs+w87DaG8fikmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4tjZyvc32XPtMqtkpHG+eRn3wKnDlO9LFPY2GOv7W7EhtX3sKJNlXKoiaBtLsG+vA6Kkv8sn1JKNmsCwmOZM1Et9cf16GjlF17SbGJPfxQekNCRWhSqp0jIOvQ1nLyYakSyVqw6f6taUvwqIas9qIRqG+rG1UeqNEgcKscXCuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ori8kAhp; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712849017;
	bh=Izm5X0JHoxEV2++y1yn48NkTsf5UKs+w87DaG8fikmY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ori8kAhpjW95rzthQLl+EWqvlslOBuNBZGGCvI7aPQKBOndnzaByi/IbYumY+3GLz
	 d1QVR7lOi09WnHCCCF9r6ECF8dr/7rki3kJAocAoFWvgtIi5jpJNPdu79SkNJesgBn
	 qFMH4tMot6p2c4RdTeCEfMBjuLH5Pv1FdXiP37O5fu0JuL4FyaBfUMMgm+ziGllV8U
	 FXuxPlw3Wm3OBgG38+uNLpwc+p8UX62DpRU8QJ/HFBX5okjxbfx0JNjfpTK1Cj0QpE
	 BmWuh8yiSXLfkVNYncoChY3yKop9z3Dc2qRg1I5fRZzD58VuprZFWiO9r/3NHJ63xV
	 wGYku57T8cSCw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 46D783780C13;
	Thu, 11 Apr 2024 15:23:36 +0000 (UTC)
Message-ID: <229eeabc-7e70-4b09-997f-356e85e748dc@collabora.com>
Date: Thu, 11 Apr 2024 17:23:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] dt-bindings: ufs: mediatek,ufs: Document
 additional clocks
To: Conor Dooley <conor@kernel.org>
Cc: linux-scsi@vger.kernel.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
 bvanassche@acm.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, peter.wang@mediatek.com, chu.stanley@gmail.com,
 jejb@linux.ibm.com, martin.petersen@oracle.com, lgirdwood@gmail.com,
 broonie@kernel.org, matthias.bgg@gmail.com, stanley.chu@mediatek.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20240411114300.169055-1-angelogioacchino.delregno@collabora.com>
 <20240411114300.169055-8-angelogioacchino.delregno@collabora.com>
 <20240411-filth-trekker-8a8c185d589b@spud>
 <f7fcbae7-fd54-4ad5-8dc6-4deb80088b79@collabora.com>
 <20240411-curvy-satirical-8c50cf79d703@spud>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240411-curvy-satirical-8c50cf79d703@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 11/04/24 17:18, Conor Dooley ha scritto:
> On Thu, Apr 11, 2024 at 05:14:34PM +0200, AngeloGioacchino Del Regno wrote:
>> Il 11/04/24 17:10, Conor Dooley ha scritto:
>>> On Thu, Apr 11, 2024 at 01:42:59PM +0200, AngeloGioacchino Del Regno wrote:
>>>> Add additional clocks, used on all MediaTek SoCs' UFSHCI controllers:
>>>
>>> I appreciate being told they're on all, rather than it being unsaid and
>>> having to ask.
>>>
>>
>> You're welcome :-)
>>
>>>> some of these clocks are optional and used only for scaling purposes
>>>> to save power, or to improve performance in the case of the crypt
>>>> clocks.
>>>>
>>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>> ---
>>>>    .../devicetree/bindings/ufs/mediatek,ufs.yaml      | 14 +++++++++++++-
>>>>    1 file changed, 13 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
>>>> index e2c276da3f2c..21b038db100c 100644
>>>> --- a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
>>>> +++ b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
>>>> @@ -26,11 +26,23 @@ properties:
>>>>              - const: mediatek,mt8183-ufshci
>>>>      clocks:
>>>> -    maxItems: 1
>>>> +    minItems: 1
>>>
>>> Could you add an itemised list to the clocks property please?
>>>
>>
>> Not really... Honestly, I'm not confident that the description will be 100%
>> correct for all of them... can we do that at a later time, when I will be
>> really that much confident in writing down a proper description for each
>> of them?
>>
>> The only thing that I'm really sure of is exactly what I wrote in this commit,
>> nothing less, nothing more... for now :')
> 
> fwiw, my motivation here was a better explanation for what "ufs" means
> as a clock. When the block has some "ufs" clock and a "axi" clock it's
> kinda clear what they do, but with 7 ufs clocks now, it's not really
> clear what the bare "ufs" one actually does.
> 
> If you can't provide an itemised list, please set maxitems.
>   

Not exactly right now, as I said. I will set maxItems instead.

By the way, "ufs" == "core", I didn't want to rename that one to avoid
breaking changes, of course.


>>>>      clock-names:
>>>> +    minItems: 1
>>>>        items:
>>>>          - const: ufs
>>>> +      - const: ufs-aes
>>>
>>>
>>>> +      - const: ufs-tick
>>>> +      - const: unipro-sys
>>>> +      - const: unipro-tick
>>>> +      - const: ufs-sap
>>>> +      - const: ufs-tx-symbol
>>>> +      - const: ufs-rx-symbol
>>>> +      - const: ufs-mem
>>>> +      - const: crypt-mux
>>>> +      - const: crypt-lp
>>>> +      - const: crypt-perf
>>>>      phys:
>>>>        maxItems: 1
>>>> -- 
>>>> 2.44.0
>>>>
>>



