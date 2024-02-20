Return-Path: <linux-kernel+bounces-72624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D8685B65D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D0D3B24EC3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DA95FEF9;
	Tue, 20 Feb 2024 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ECln5RxC"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C1C5F545
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419370; cv=none; b=BHtgTPnl0bd14jshP1eT0inL1joWAGD/HZOVq8Zt9XR9WnPN8D4cIBq+PtO998pGbJ/0eEFwTutqJ14nIOkMVOQwzsPv7rGspcGrfjGYMz/J+sV1GZWX5lfCfHiz7OTwNUmjliSkOpb8ZoBG5YIvmj2sAW3t5ivFXmntsmb026o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419370; c=relaxed/simple;
	bh=6LN+anVhIs46gCoUM3PrXmdfnXZO8f3moMRt0c1d/S8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WzIWdFoDTJjF4Qa+zRfqUHPNuzzZGhbR1sFli+F+BlLLKW71A/PheG9rEtfdf1CiGCBEPJuPBt0Elvt8b6QBVfFMZYx/NR2eswDT8Ecd/8BN0XnM6x0/821wHklJfWixhVacSvD87yKocnG/Kd0bMOSq78Xki3Bm0LKSOvPEtu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ECln5RxC; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708419367;
	bh=6LN+anVhIs46gCoUM3PrXmdfnXZO8f3moMRt0c1d/S8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ECln5RxCydHLZFsD2Msh8x4Dpp5/8+AsnlAH0tcpHO7bRU+fcbo2MQ0mQm3WhJPtk
	 4K6OcR3vjMYPZ70GlSdExViGFtnCRHYa/kMFq7qGfBcm8HW+qlz8UUcXBKKIx1RJnq
	 igS+6xw/qUZ5UtAvj2jCW6iLIlPOWvGZVqfpOUYIbo5B9wRQuFpglpVMrJWITbY5wd
	 72E5OtOLbA6qTVUrkMH9fJAXNVXEgypOEdnOSNw9RAkaJzMw9OIL9GjD96DTjjWdbB
	 JZLkPe8Rni+AoB2nLwS7ZjKkyE+6NOCruKMk3F/HmR+HlsESwS/+ajnbLFJibOqUBE
	 tLFSwdFA23f3g==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8897C3781FD9;
	Tue, 20 Feb 2024 08:56:06 +0000 (UTC)
Message-ID: <f1fc67d4-f979-4c3e-988f-a803b7b11c46@collabora.com>
Date: Tue, 20 Feb 2024 09:56:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: mediatek: mtk-socinfo: depends on CONFIG_SOC_BUS
Content-Language: en-US
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Daniel Golle <daniel@makrotopia.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 William-tw Lin <william-tw.lin@mediatek.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <cc8f7f7da5bdccce514a320e0ae7468659cf7346.1707327680.git.daniel@makrotopia.org>
 <CAGXv+5EKCrvsvZwc2zYiMWAeT9vqvU0JnDrz=WBoebBBbcgp0g@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5EKCrvsvZwc2zYiMWAeT9vqvU0JnDrz=WBoebBBbcgp0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 20/02/24 07:40, Chen-Yu Tsai ha scritto:
> On Thu, Feb 8, 2024 at 1:43 AM Daniel Golle <daniel@makrotopia.org> wrote:
>>
>> The mtk-socinfo driver uses symbols 'soc_device_register' and
>> 'soc_device_unregister' which are part of the bus driver for
>> System-on-Chip devices.
>>
>> Select SOC_BUS to make sure that driver is built and the symbols are
>> available.
>>
>> Fixes: 423a54da3c7e ("soc: mediatek: mtk-socinfo: Add driver for getting chip information")
>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> 
> Angelo, I believe this should be picked up for -next?
> 

I'll pick this up for fixes, as I've already sent the PRs for v6.9.

> Also, mediatek/v6.8-next/soc is missing from mediatek/for-next in today's
> linux-next.
> 

Fixing immediately.

>> ---
>>   drivers/soc/mediatek/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
>> index 50c664b65f4d4..1b7afb19ccd63 100644
>> --- a/drivers/soc/mediatek/Kconfig
>> +++ b/drivers/soc/mediatek/Kconfig
>> @@ -72,6 +72,7 @@ config MTK_SOCINFO
>>          tristate "MediaTek SoC Information"
>>          default y
>>          depends on NVMEM_MTK_EFUSE
>> +       select SOC_BUS
>>          help
>>            The MediaTek SoC Information (mtk-socinfo) driver provides
>>            information about the SoC to the userspace including the
>> --
>> 2.43.0
>>
>>



