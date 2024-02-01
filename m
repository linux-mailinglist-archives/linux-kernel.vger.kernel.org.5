Return-Path: <linux-kernel+bounces-47939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 861C78454DD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18E57B25102
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD54C15B101;
	Thu,  1 Feb 2024 10:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Z86UnYCO"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9944DA05;
	Thu,  1 Feb 2024 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706782126; cv=none; b=HDToFPwC6BIKASiMdCDBcdzwAT0xEn1eU8QMTMopzZy5/aNSBTt/eVwoZbrlBrW2t+1qteSjRcjZIA40rNrS0XJiWvlAjdKuI2tDonFK7unSBrZUM0kvQMrdxIhajsss9f9Jz6VMqMG51Q1/ks/hZI+zWoPOL5gIczNEdBnRo48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706782126; c=relaxed/simple;
	bh=Zbw1duyIkUff9kk8iVE8KbWbqATyvr/EHkllKd6B7Ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=haX6GbYJtVWDhFLtT2bmZqeV5njgJDONmM+bBIj1Wg5CjCDaqUGkc0McshjMHtUZqEmYKoC1ukmN/yblawy/Al7mmjmF5wCnjW0qZBy6iynnLcdANvlcWeHsI4Gf25nrjCNcV1Ce7ao4xdkcO3Wn5xQFpcenbQcXn85n19Z5+dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Z86UnYCO; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706782122;
	bh=Zbw1duyIkUff9kk8iVE8KbWbqATyvr/EHkllKd6B7Ow=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z86UnYCO3n19Iz57kNWMmT0uZdLi3ScTKbcJBmq+uANG3S3GFbOPzIJkYnPiv7imu
	 lUc7yeFkPdCt1D4SWAlRkJ8B/BsZD6IYrfSd+xZBOlFrLQ816gy5lOIt941oiRm0Ir
	 ZfDcRnAIDX5dU+tz1hR7gRSy2AOHRMOM63MJ5/Z4ih8wod/lPXx0uf9/3kfepJA2gJ
	 Z5qbo6PXrGxXuqUMFy63bWX4u+24WaAd50oE9I+koZVzdR+b9VjNd6jR7nx4l9dMTI
	 ad35+HPNKXoUiFt6v0zKjmmEKsRK/ewKAWOoey7c5HZApJ8cwmxuVO+bhpWWyUsytp
	 8eGV6rRexID+g==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A3A5B3782081;
	Thu,  1 Feb 2024 10:08:41 +0000 (UTC)
Message-ID: <cace3472-7ee3-459b-ab2c-51764db99bd7@collabora.com>
Date: Thu, 1 Feb 2024 11:08:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] ASoC: mediatek: AFE drivers cleanups
Content-Language: en-US
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, matthias.bgg@gmail.com,
 ribalda@chromium.org, nicolas.ferre@microchip.com,
 u.kleine-koenig@pengutronix.de, kuninori.morimoto.gx@renesas.com,
 nfraprado@collabora.com, alsa-devel@alsa-project.org,
 trevor.wu@mediatek.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, lgirdwood@gmail.com
References: <20240111105247.117766-1-angelogioacchino.delregno@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240111105247.117766-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 11/01/24 11:52, AngeloGioacchino Del Regno ha scritto:
> This series converts MediaTek AFE drivers' probe functions to use
> dev_err_probe() and devm functions where possible and, in some
> cases, dropping the .remove_new() callback, reducing the size.
> 
> Cheers!

Gentle ping for this series, afraid that went out of the radar :-)

Cheers,
Angelo

> 
> AngeloGioacchino Del Regno (7):
>    ASoC: mediatek: mt8173-afe-pcm: Convert to devm_pm_runtime_enable()
>    ASoC: mediatek: mt8173-afe-pcm: Use devm_snd_soc_register_component()
>    ASoC: mediatek: mt8183-afe-pcm: Convert to devm_pm_runtime_enable()
>    ASoC: mediatek: mt8183-afe-pcm: Simplify with dev_err_probe()
>    ASoC: mediatek: mt8192-afe-pcm: Convert to devm_pm_runtime_enable()
>    ASoC: mediatek: mt8192-afe-pcm: Simplify with dev_err_probe()
>    ASoC: mediatek: mt8195-afe-pcm: Drop .remove_new() callback
> 
>   sound/soc/mediatek/mt8173/mt8173-afe-pcm.c |  78 +++------------
>   sound/soc/mediatek/mt8183/mt8183-afe-pcm.c | 108 +++++++--------------
>   sound/soc/mediatek/mt8192/mt8192-afe-pcm.c |  95 ++++++------------
>   sound/soc/mediatek/mt8195/mt8195-afe-pcm.c |  12 +--
>   4 files changed, 81 insertions(+), 212 deletions(-)
> 


