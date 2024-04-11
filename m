Return-Path: <linux-kernel+bounces-140730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D6C8A1865
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 664041C234F4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2433315AE0;
	Thu, 11 Apr 2024 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZkXHfrn8"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154DEFBEF;
	Thu, 11 Apr 2024 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712848479; cv=none; b=P1+9R9lW/BZTp/zmkHlbkNj76IJSWHTcYVdfLVn2iXUS7uH6pZfOThdwDk31jyySjAPP0qvKKJo4qqeMzrIAZ0I5XlC6SUdQ9pYecDY7c+ic+M2UCssWS6Zomtq2fofH5omOoJNNqh9/5EtFoAWX7e4cJP43xsCh2QDmOpnlNrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712848479; c=relaxed/simple;
	bh=uOpSXnhxv2OHawhHyAEzb/JljiqQBa6kpiy/MPdPczU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+4k3r/GTF6QLsSX/9I5oDf9VJj6dChbGphm7gL200dSKw4c/ebspWOCRaMMMTiYdhKqJcd98xZlXpxcOb/zOa+n45IWwfUCSULK8guHLSJ0s3B1S9MEwO+M/RtE1TOXqIjdTTkUOr+mUR3/isxsUg8keAeHQiwhnyNsOO+oxiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZkXHfrn8; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712848476;
	bh=uOpSXnhxv2OHawhHyAEzb/JljiqQBa6kpiy/MPdPczU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZkXHfrn8RIBm5pjCFyk7iuukhhhPGZ1yL/8DNBa5B9pIf0xN3Aqc4LVy9lgy6tlmI
	 y3dSZvS/gjlrVmmTDtJhX/kHFD2PNHTgWpHW60pxjG3V36NXiOT3Cy5epyHpPS8iLZ
	 cwj0ya/578AqYLQRsOyWCH9GlIp8SqBILrzkw7SrECMAB5+WUAJvmAaO+DQdQG5gUp
	 ania2AcQ7rCppjv7a4rpv2l2O3KnIegc9lMrFALU0wBjDDGMG36P6nTaMFyGpZ0Y8l
	 0302z/HUP1ClfH/2at5P3TqZelQ5Xd5t89yxsm0qQ/z5lA/SMqqMBEFxuIR8gcEltO
	 oP1bTGDYJ0hIg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 198D137813C0;
	Thu, 11 Apr 2024 15:14:35 +0000 (UTC)
Message-ID: <f7fcbae7-fd54-4ad5-8dc6-4deb80088b79@collabora.com>
Date: Thu, 11 Apr 2024 17:14:34 +0200
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
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240411-filth-trekker-8a8c185d589b@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 11/04/24 17:10, Conor Dooley ha scritto:
> On Thu, Apr 11, 2024 at 01:42:59PM +0200, AngeloGioacchino Del Regno wrote:
>> Add additional clocks, used on all MediaTek SoCs' UFSHCI controllers:
> 
> I appreciate being told they're on all, rather than it being unsaid and
> having to ask.
> 

You're welcome :-)

>> some of these clocks are optional and used only for scaling purposes
>> to save power, or to improve performance in the case of the crypt
>> clocks.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../devicetree/bindings/ufs/mediatek,ufs.yaml      | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
>> index e2c276da3f2c..21b038db100c 100644
>> --- a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
>> +++ b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
>> @@ -26,11 +26,23 @@ properties:
>>             - const: mediatek,mt8183-ufshci
>>   
>>     clocks:
>> -    maxItems: 1
>> +    minItems: 1
> 
> Could you add an itemised list to the clocks property please?
> 

Not really... Honestly, I'm not confident that the description will be 100%
correct for all of them... can we do that at a later time, when I will be
really that much confident in writing down a proper description for each
of them?

The only thing that I'm really sure of is exactly what I wrote in this commit,
nothing less, nothing more... for now :')

Cheers,
Angelo

>>   
>>     clock-names:
>> +    minItems: 1
>>       items:
>>         - const: ufs
>> +      - const: ufs-aes
> 
> 
>> +      - const: ufs-tick
>> +      - const: unipro-sys
>> +      - const: unipro-tick
>> +      - const: ufs-sap
>> +      - const: ufs-tx-symbol
>> +      - const: ufs-rx-symbol
>> +      - const: ufs-mem
>> +      - const: crypt-mux
>> +      - const: crypt-lp
>> +      - const: crypt-perf
>>   
>>     phys:
>>       maxItems: 1
>> -- 
>> 2.44.0
>>


