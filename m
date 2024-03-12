Return-Path: <linux-kernel+bounces-100246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDFB8793F6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA95285996
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701A27A142;
	Tue, 12 Mar 2024 12:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="adYU1hc0"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02954BA28;
	Tue, 12 Mar 2024 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710245760; cv=none; b=IJ2yGI64RTxEct3IXTJu8hASuDsMxeGusWZ4Gdpt+YFipFBy0Bf3YxoxeTfIHY7rD3p+P4SJaKyqFQxUcdwn9eK4L+JGN0eKCZA/8NOTGXaR/WLWFaS7Z1brULfVdDMZ4rs5pYAkCjLXZHNs/eQsAK2kTbj4HQgXlpXY1Bs6mn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710245760; c=relaxed/simple;
	bh=eWOfUZKmPNZhyLKzOWRxcFwX/pcgSuoNoaDv6gFnoaY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G71mb3/MHPbc53GrwJBAFz8uidxymiiQ0oQp8S9o/EqDLoV7XnXe0e5vq0siuQJg/g2rRCSZbW/8quqbr4+fdcyE+l3l4sOHoXHDO18lFrBEjYbL4RIKwXXqIGBtiDKmSrc9lXKcd6jFLC2JoOYf1RqR8WQCWwORxFXnV4qbvac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=adYU1hc0; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710245756;
	bh=eWOfUZKmPNZhyLKzOWRxcFwX/pcgSuoNoaDv6gFnoaY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=adYU1hc0/HUIwUycHrtd4GegMyOYxLD39anPc8saT3TETvOqtNyQ1llQF2VUsLSr7
	 7GeJ+1fEoSnY9Hm3uUOvfQWEoit6kSpS3/72J3TcBaVhHpu2qgZROsZcIgS0vv0xGd
	 wBS69XgiEJRrrZIJ4abtOSNXdr2i8lmsR4hMzIVt1b1S5Ns7pwZisRAXt29+Z2OsHe
	 ASDxfuus5r7Mm0Wmlt0btj7g0xR+3wE7Ki0Xj+x3DIrXKuf/KoQxi9+E0sQrT3ZfhR
	 XMtJnwEj6Ql9qIpQHQ5PwM/rfWFjH3ngRjtEGLwPNFZsgsjczDJqL40bY2jUv1/Wkt
	 6HgrTtkgafApw==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0E2D3378207B;
	Tue, 12 Mar 2024 12:15:53 +0000 (UTC)
Message-ID: <d690b7d7-2568-4a47-a653-eb25671fb138@collabora.com>
Date: Tue, 12 Mar 2024 17:16:23 +0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, kernel@collabora.com,
 kernel-janitors@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: spi-nor: core: correct type of i
Content-Language: en-US
To: Pratyush Yadav <pratyush@kernel.org>
References: <20240304090103.818092-1-usama.anjum@collabora.com>
 <865fc24b-ae27-4084-893b-c5c389480a09@collabora.com>
 <mafs0r0gf8x6c.fsf@kernel.org>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <mafs0r0gf8x6c.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/24 5:14 PM, Pratyush Yadav wrote:
> Hi,
> 
> On Mon, Mar 11 2024, Muhammad Usama Anjum wrote:
> 
>> Soft reminder
> 
> Miquel should pick up the patch when sending out his pull request [0].
> 
> [0] https://lore.kernel.org/linux-mtd/20240307180919.4cb7a4cb@xps-13/
Thanks Pratyush!

> 
>>
>> On 3/4/24 2:01 PM, Muhammad Usama Anjum wrote:
>>> The i should be signed to find out the end of the loop. Otherwise,
>>> i >= 0 is always true and loop becomes infinite. Make its type to be
>>> int.
>>>
>>> Fixes: 6a9eda34418f ("mtd: spi-nor: core: set mtd->eraseregions for non-uniform erase map")
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>> Changes since v1:
>>> - Make i int instead of u8
>>> ---
>>>  drivers/mtd/spi-nor/core.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>>> index 65b32ea59afc6..3e1f1913536bf 100644
>>> --- a/drivers/mtd/spi-nor/core.c
>>> +++ b/drivers/mtd/spi-nor/core.c
>>> @@ -3373,7 +3373,7 @@ static u32
>>>  spi_nor_get_region_erasesize(const struct spi_nor_erase_region *region,
>>>  			     const struct spi_nor_erase_type *erase_type)
>>>  {
>>> -	u8 i;
>>> +	int i;
>>>  
>>>  	if (region->overlaid)
>>>  		return region->size;
> 

-- 
BR,
Muhammad Usama Anjum

