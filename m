Return-Path: <linux-kernel+bounces-72644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD02B85B6A2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B8C28B343
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630D75F567;
	Tue, 20 Feb 2024 09:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="tK+lxaPH"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353025E3A0
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419832; cv=none; b=Gyf/MvOaFAP2G4X3I+JiJevo06C//Wjlsg+YNBxAjVcgmxmFljK9QtEnwTtZ8UO1pQ++qelT+dNS6fW5o/ZuBQY7+hOVpT+pNHt1PP1sycb6Sv8gJm8LFOM+lAmE8zKBvasaZBaOkJq9yMShIbYAQk9Q1WDuzH+pIX7MWE5h5oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419832; c=relaxed/simple;
	bh=CbuUipgN3x0OtOMVl+Qzmre0d9c7fvRwbaMamF0Y22E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gaorNKBE5qFQBFh0hCBfZbiW/2wWZ5jPufa0N/JHTrrFTY/Kzpll4V0n0oLsVYQlTmrKysadGfAJtd+hQUiMrvCtshL4R5VUbFlwa/1WwP8SZCJLXUHAGa3W+S2qjQEoIyBO8mo9hS93DPVI1AM6gZJnjUTN1mo82DRJ8G4G3vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=tK+lxaPH; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708419829;
	bh=CbuUipgN3x0OtOMVl+Qzmre0d9c7fvRwbaMamF0Y22E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tK+lxaPHpL7Vvwdd6Xf18pxAWv5XkHGIMP3RkL6KD+TeHZ5FIMEkzraxOQLUuoIkM
	 fWdG3WYWYMw14SmZ4Wv1aoFkmKet4y7tM8zGjhEiZh6js3OmX0R6TwYpRw6jjpvviU
	 vyMC07vHIuIWiilcF0ivZDeSX/5nr6K1Hl6avCjdhA820/jeIQQ8SztJFDLJmMqih1
	 txaXfunCOYKFdUDxLWxQi/epLwy5R3zSlVAT79U0VMvAujSblcfVy/YgTXBj3RKp6Y
	 Ueya6oQxkly9T4xCm5Uemwj3JM2MFqWnRUz8xxG92UP/n84GZjIzudkzJBEZcnCN0H
	 zQxc2jIivH42Q==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D592F37813DF;
	Tue, 20 Feb 2024 09:03:48 +0000 (UTC)
Message-ID: <ab809d89-339a-44fc-8a5a-ac667d220ce1@collabora.com>
Date: Tue, 20 Feb 2024 10:03:48 +0100
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
 <f1fc67d4-f979-4c3e-988f-a803b7b11c46@collabora.com>
 <CAGXv+5Gxc3OP8nE681C6YQbDMUNmFDf21BfSvJZPBFgoncve=A@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5Gxc3OP8nE681C6YQbDMUNmFDf21BfSvJZPBFgoncve=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 20/02/24 10:03, Chen-Yu Tsai ha scritto:
> On Tue, Feb 20, 2024 at 4:56 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 20/02/24 07:40, Chen-Yu Tsai ha scritto:
>>> On Thu, Feb 8, 2024 at 1:43 AM Daniel Golle <daniel@makrotopia.org> wrote:
>>>>
>>>> The mtk-socinfo driver uses symbols 'soc_device_register' and
>>>> 'soc_device_unregister' which are part of the bus driver for
>>>> System-on-Chip devices.
>>>>
>>>> Select SOC_BUS to make sure that driver is built and the symbols are
>>>> available.
>>>>
>>>> Fixes: 423a54da3c7e ("soc: mediatek: mtk-socinfo: Add driver for getting chip information")
>>>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>>>
>>> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
>>>
>>> Angelo, I believe this should be picked up for -next?
>>>
>>
>> I'll pick this up for fixes, as I've already sent the PRs for v6.9.
> 
> The socinfo driver is in -next, so I guess you could pick it up as a fix
> for v6.9.
> 

Of course! :-)

Cheers,
Angelo

> ChenYu
> 
>>> Also, mediatek/v6.8-next/soc is missing from mediatek/for-next in today's
>>> linux-next.
>>>
>>
>> Fixing immediately.
>>
>>>> ---
>>>>    drivers/soc/mediatek/Kconfig | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
>>>> index 50c664b65f4d4..1b7afb19ccd63 100644
>>>> --- a/drivers/soc/mediatek/Kconfig
>>>> +++ b/drivers/soc/mediatek/Kconfig
>>>> @@ -72,6 +72,7 @@ config MTK_SOCINFO
>>>>           tristate "MediaTek SoC Information"
>>>>           default y
>>>>           depends on NVMEM_MTK_EFUSE
>>>> +       select SOC_BUS
>>>>           help
>>>>             The MediaTek SoC Information (mtk-socinfo) driver provides
>>>>             information about the SoC to the userspace including the
>>>> --
>>>> 2.43.0
>>>>
>>>>
>>
>>



