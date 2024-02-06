Return-Path: <linux-kernel+bounces-55281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A0084BA2D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4087285BD4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF098134728;
	Tue,  6 Feb 2024 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="V7K5QaTF"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CCE134CCC
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707234841; cv=none; b=ckLP4zSFe1xTtBn8egAoHVeNKMgVkC5GJKu95H4u0zqDUPgqbxJuqFNBlbXSz9yAgb75NKbtqGGy87UjdFkhRLM9SWHmLM3nbxcHUxdQXGm5E9KevPAZi/qhnqd9/QNvZ+xto4739jvxFHgEnMRrWtY9jOXX70B/maEsv7DG4qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707234841; c=relaxed/simple;
	bh=ocHaZpvDjxc0rwWNi54f+f6bams80D+RxoX1ovTeVl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eN+ynpH4vegPI86e7QMp9dYrXYW0gfmSe2qBs+qNmItkUsNQ4eywf4A3hFvRuyTYJA9ltflpfk1rgyF+1BfMIXOC2KTtlPIT4VAx77e1ZVOCm0JoRE1/++dN29e3lMAt1bXM0aj7vXebAYDxaRUEzIdil/0pHhdyUBXuRJxO+sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=V7K5QaTF; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707234837;
	bh=ocHaZpvDjxc0rwWNi54f+f6bams80D+RxoX1ovTeVl4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V7K5QaTFmBBj0jF9OBR5noaRpQTZDw9Xl5i1A050PYI1Pv9NppAiV7yHeTBDp5nEN
	 7LckCp+WWAF8/QJQrikGSGvJydLGMjuSlmFWBQa804UzNxojOI2zARlmeMuiejyzcf
	 Gt8wNMvbT7i5xT5flazIdXjg50s6SaJe6ngZnwVVyF9vZyZ76G+lYlbBHypn5L2f3b
	 E+jvFsHCXt/eiaKk8Dt+Ey6G/tsgL0FR58ISC5cJO9vie0l5n9oGkt0XMDUnBqNuS3
	 gc4WgpIO2qQxYRqTR0yVI2BtKWCjnQnbgqwGiqxAMdTot8z9h/xbKNxZTN9lt+0g1d
	 QsBZ3YcbvWHqQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D92CF37803EE;
	Tue,  6 Feb 2024 15:53:56 +0000 (UTC)
Message-ID: <c1e2c380-21b5-47c1-b83b-f7f2b481df21@collabora.com>
Date: Tue, 6 Feb 2024 16:53:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] drm/mediatek: dsi: Use GENMASK() for register mask
 definitions
Content-Language: en-US
To: Alexandre Mergnat <amergnat@baylibre.com>, chunkuang.hu@kernel.org
Cc: fshao@chromium.org, p.zabel@pengutronix.de, airlied@gmail.com,
 daniel@ffwll.ch, matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20240206120748.136610-1-angelogioacchino.delregno@collabora.com>
 <20240206120748.136610-2-angelogioacchino.delregno@collabora.com>
 <f91db779-ad94-4c18-9a06-1029da4edaab@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <f91db779-ad94-4c18-9a06-1029da4edaab@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 06/02/24 15:47, Alexandre Mergnat ha scritto:
> 
> 
> On 06/02/2024 13:07, AngeloGioacchino Del Regno wrote:
>> Change magic numerical masks with usage of the GENMASK() macro
>> to improve readability.
>>
>> While at it, also fix the DSI_PS_SEL mask to include all bits instead
>> of just a subset of them.
>>
>> This commit brings no functional changes.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/gpu/drm/mediatek/mtk_dsi.c | 45 +++++++++++++++---------------
>>   1 file changed, 23 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
>> index a2fdfc8ddb15..3b7392c03b4d 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
>> @@ -58,18 +58,18 @@
> 
> ...snip...
> 
>>   #define DSI_PSCTRL        0x1c
>> -#define DSI_PS_WC            0x3fff
>> -#define DSI_PS_SEL            (3 << 16)
>> +#define DSI_PS_WC            GENMASK(14, 0)
>> +#define DSI_PS_SEL            GENMASK(19, 16)
> 
> 0011 0000 0000 0000 0000 => GENMASK(17, 16)

Alexandre, the reason for that is in the commit description :-P

"While at it, also fix the DSI_PS_SEL mask to include all bits instead
of just a subset of them."

Thanks for the reviews, btw!

Cheers!
Angelo

> 
>>   #define PACKED_PS_16BIT_RGB565        (0 << 16)
>>   #define LOOSELY_PS_18BIT_RGB666        (1 << 16)
>>   #define PACKED_PS_18BIT_RGB666        (2 << 16)
>> @@ -109,26 +109,26 @@
>>   #define LD0_WAKEUP_EN            BIT(2)
> 


