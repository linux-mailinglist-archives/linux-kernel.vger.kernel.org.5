Return-Path: <linux-kernel+bounces-107442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C06087FC97
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E0B282A30
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330327E593;
	Tue, 19 Mar 2024 11:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rWyGfBz6"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F6E7CF03;
	Tue, 19 Mar 2024 11:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710846687; cv=none; b=RqUlsrNaxL1wM2qzlEY2Erdr0zqpKoeVDD29E5svbS6hUGi1ZwyCKJhPog5x8nAk7FxuW0ESrzmbQg93My/Tk/N/nkB8flnue4ba0rr1yMKYbaBU1gP8UWmeicDwlcU90XH5EH/oVUd4QqaqOETi2AkD4JlENpRtCIEGwdlGJwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710846687; c=relaxed/simple;
	bh=XLZQhDlAD4mGZyqkQQ7Cw1CYIVAv0BwYXJwNdutyW+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nc8quOtcZ4XZYN3C+ejikdE0P6Vkc3Ws1dov6Wpo7Im85DdpGOCgALwFAlWoIfx+J1yJA7Dc//9ZmaOBU4KROxCckW78y/VknCNRfRepwRtRH4gDG3r6DogYFrDY9IsH4xHL0auhRTSwjtzvpQ46RaH3mwHyR/IjICeXyDTimxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=rWyGfBz6; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710846684;
	bh=XLZQhDlAD4mGZyqkQQ7Cw1CYIVAv0BwYXJwNdutyW+w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rWyGfBz6jTgE+fURzrNGsS7ysMw8I5U/In6BKGLLjVfYalulyLenSkuyYURO6jXeZ
	 Ld7G5G2xqGjDDkj0tftXN0xBgjbBSeXAKLoO05hHh9HfPFzQU1t2KNSgvEHUzzhqLr
	 Fm/PNlzxa5SxE+zmy6MH/nwlZ83U+G6KkX8E6P+G6GrpdRcS9JYGVIRYqwStOAFKBA
	 7+aut8iY5HF4hkfuqXDka3I7f3n9XyjIFIllrrgyR0WQUJn3F85Pss0Fi7g13iGucJ
	 TV7dmVB03XNM/AsfUL7Gbs8qKCO4vYLSMxOFl1AvDy9ZLtsQmAKio+rTKHye/NFfuP
	 EQbHcSbOo5V1Q==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6F7E7378149B;
	Tue, 19 Mar 2024 11:11:23 +0000 (UTC)
Message-ID: <4c2ffd1c-d059-4448-9b2d-142ea87d6bd8@collabora.com>
Date: Tue, 19 Mar 2024 12:11:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] drm/mediatek: Rename "mtk_drm_ddp_comp" to
 "mtk_ddp_comp"
Content-Language: en-US
To: Shawn Sung <shawn.sung@mediatek.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
References: <20240319070257.6443-1-shawn.sung@mediatek.com>
 <20240319070257.6443-3-shawn.sung@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240319070257.6443-3-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 19/03/24 08:02, Shawn Sung ha scritto:
> From: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
> 
> Rename all "mtk_drm_ddp_comp" to "mtk_ddp_comp":
> - To align the naming rule
> - To reduce the code size
> 
> Reviewed-by: AngeloGiaocchino Del Regno <angelogioacchino.delregno@collabora.com>

Shawn, I don't know if I typoed my own name (which is actually possible, since
I write the tags by hand), or what actually happened to my Reviewed-by tags on
the entire series.

Can you please fix the typo in the tag?

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Use this one, please.

Thanks,
Angelo


> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>


