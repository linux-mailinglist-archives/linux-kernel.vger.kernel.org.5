Return-Path: <linux-kernel+bounces-135561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B7589C797
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FCAD1F22BB6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA36513F456;
	Mon,  8 Apr 2024 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UY1JEUri"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E5213F442
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 14:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712588145; cv=none; b=kQO8MzbWcgU4arDne/7DXfB0wvzC6vTVGrINWoH7y+r0+u33gDdarP0VfToaQaPYsPMcI/4jba4FkTLhk93beAf6BOwPMpQbr+axRKG64wIzvliSKMISxA9VdhzQWuF8t/Tx0tWs8ERjHG1cssJ5OlzPMExAMRoF6YXvFsvYrAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712588145; c=relaxed/simple;
	bh=8ixhDcDmRfYWm6cJvXx1rMiBFBKX7dAZIjKBVgAAibo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K2ZTzI3DLvRFvBBJx13MbG46j5Nplt/cGH8G6Do2fa389ZhFJFA1co56FnyUw5p+dd/4ZBgjQiv4WDpKvVNuPoWmsDraVf5+Sa9fWaYOZGvY74XBp8H7wSFZv5KHD5ccZDt62bZrmUnmcdOvje/Kv9IXvw066dFZxpChRTn67ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UY1JEUri; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712588141;
	bh=8ixhDcDmRfYWm6cJvXx1rMiBFBKX7dAZIjKBVgAAibo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UY1JEUrimRA0o/tOLLf1B9XqrzwKdBym7ujw+wQmPRF27rQSSvefyT1VXKWPiA4Vb
	 nrNHd6GyFZVfIxDD713W83E6CS/IMLTTxTgOXzQXUCbj+zu3JwrFiv1IOOHUzqpJTh
	 B4/ecK4Bh7FUYmBeMY+ioThPFU5B5DbJvcniTZgaXrleMg7LcofijyBqHDRuFygzAs
	 oZT6hh0o905IDGt8qGASHfBx7aDBSc5EOKt+94K1PBa1Duqr3uA+YYfJeVog4yiVbo
	 Br/E8/p/vQ2hoTzx6igY0MLO9TZ2eTGI5ZOhxOU/Tf2nyqkIM1RZwIClV6wEGytm3I
	 Ova4zrD4Aoe3w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A247F3780C39;
	Mon,  8 Apr 2024 14:55:40 +0000 (UTC)
Message-ID: <23d98db0-a4a8-4453-95be-1a0982dd66a0@collabora.com>
Date: Mon, 8 Apr 2024 16:55:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: mediatek: mtk-socinfo: select CONFIG_SOC_BUS
To: Daniel Golle <daniel@makrotopia.org>, Arnd Bergmann <arnd@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
 William-tw Lin <william-tw.lin@mediatek.com>, Arnd Bergmann <arnd@arndb.de>,
 Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240408125506.1594257-1-arnd@kernel.org>
 <ZhPqLGYxK3NRCSXl@makrotopia.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <ZhPqLGYxK3NRCSXl@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/04/24 14:59, Daniel Golle ha scritto:
> Hi,
> 
> On Mon, Apr 08, 2024 at 02:55:00PM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> This is needed to avoid a link failure:
>>
>> ERROR: modpost: "soc_device_register" [drivers/soc/mediatek/mtk-socinfo.ko] undefined!
>> ERROR: modpost: "soc_device_unregister" [drivers/soc/mediatek/mtk-socinfo.ko] undefined!
>>
> 
> I've tried to take care of this in the exact same way a long time
> ago. Don't ask me why it didn't find it's way into stable yet
> 
> https://patchwork.kernel.org/project/linux-mediatek/patch/cc8f7f7da5bdccce514a320e0ae7468659cf7346.1707327680.git.daniel@makrotopia.org/
> 
> 

Sorry, went out of my radar for reasons.
Your commit should take precedence.

Angelo

> Cheers
> 
> 
> Daniel
> 
>> Fixes: 423a54da3c7e ("soc: mediatek: mtk-socinfo: Add driver for getting chip information")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>   drivers/soc/mediatek/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
>> index 50c664b65f4d..1b7afb19ccd6 100644
>> --- a/drivers/soc/mediatek/Kconfig
>> +++ b/drivers/soc/mediatek/Kconfig
>> @@ -72,6 +72,7 @@ config MTK_SOCINFO
>>   	tristate "MediaTek SoC Information"
>>   	default y
>>   	depends on NVMEM_MTK_EFUSE
>> +	select SOC_BUS
>>   	help
>>   	  The MediaTek SoC Information (mtk-socinfo) driver provides
>>   	  information about the SoC to the userspace including the
>> -- 
>> 2.39.2
>>
>>


