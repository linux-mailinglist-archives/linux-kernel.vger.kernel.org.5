Return-Path: <linux-kernel+bounces-81797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F9C867A2E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667F52967AA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05DE12BE84;
	Mon, 26 Feb 2024 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="wpAj+S2V"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91C712B17F;
	Mon, 26 Feb 2024 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961173; cv=none; b=FyZPGCeMbHkLS79vs25L0ZGKKX8IuDmuSJrh2l1MZBJG7z3kLCorJRblAvDxtejDUojLwP8IUjPQ21upVlNlyBjDgxWKdFZ9FlwD9qD3kulJSQ7lQ0cf4AiATRNOyIr8vKxneMwYiYf6ZdkgjDzVFCFyRb0YlpwDNHhj1NDNV2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961173; c=relaxed/simple;
	bh=BGtrotZCxe9YdvKz5MvCySGTf7PW9GlLNALwLZ9BjU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ih/aVeHKxfElAtMMwXfIkWOa0G6ICGlSD25CZhMyyBryb8NVqoMOWKgIImQ7HkQI3WQjHVf61TTNN1Zf6DjluWBNuUybdffZTdqOJ8DC4/9XLuDkyv5aGh2bi27wzyYSAiFpn4D05Wya0IGoc14Erz7V5YHrchhsar+Y8Mw/o4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=wpAj+S2V; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708961170;
	bh=BGtrotZCxe9YdvKz5MvCySGTf7PW9GlLNALwLZ9BjU4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=wpAj+S2VxraYD5Zf+Qnw39b+gY+qm4td3h7VT+Kh1Vh1Y/7BFOu+qrrLXIKmFpuP4
	 19HVXvZj6iDi1LJq234qe98XlAqHxRfv/yuh1U0AP9HuvNxc9ld3EoaqalxOWmoN2H
	 dCo/Rowu/7xtCH8JuIBkU2+2EU4RdM8J9uObf7/NwvKGqeXQk98fDZOWmmP+TCN2HE
	 3/X2Cwf+ESqbNpQFwJcvAFiLZsQL15yABc4eYLI1qKV7HS/OvvhyH31iMjZUWeeLBP
	 9Penc6a61I5BbJItAStwVigwq/Iv5c21SwBI1z6lBbBq5L5MCEiGoVjolaitui7pPb
	 8Asf93ze/gB5w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 862E737820CB;
	Mon, 26 Feb 2024 15:26:08 +0000 (UTC)
Message-ID: <31c732dd-21cf-4961-afb8-6c757eef0eeb@collabora.com>
Date: Mon, 26 Feb 2024 16:26:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/18] mfd: mt6397-core: register mt6357 sound codec
Content-Language: en-US
To: amergnat@baylibre.com, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Lee Jones <lee@kernel.org>,
 Flora Fu <flora.fu@mediatek.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Fabien Parent <fparent@baylibre.com>
References: <20240226-audio-i350-v1-0-4fa1cea1667f@baylibre.com>
 <20240226-audio-i350-v1-13-4fa1cea1667f@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240226-audio-i350-v1-13-4fa1cea1667f@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/02/24 15:01, amergnat@baylibre.com ha scritto:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add MT6357 codec entry in the MFD driver.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/mfd/mt6397-core.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> index 4449dde05021..4fd4a2da5ad7 100644
> --- a/drivers/mfd/mt6397-core.c
> +++ b/drivers/mfd/mt6397-core.c
> @@ -141,6 +141,9 @@ static const struct mfd_cell mt6357_devs[] = {
>   		.num_resources = ARRAY_SIZE(mt6357_rtc_resources),
>   		.resources = mt6357_rtc_resources,
>   		.of_compatible = "mediatek,mt6357-rtc",
> +	}, {
> +		.name = "mt6357-sound",
> +		.of_compatible = "mediatek,mt6357-sound"
>   	}, {
>   		.name = "mtk-pmic-keys",
>   		.num_resources = ARRAY_SIZE(mt6357_keys_resources),
> 



