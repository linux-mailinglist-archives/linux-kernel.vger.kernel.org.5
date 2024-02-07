Return-Path: <linux-kernel+bounces-56683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C44684CD8A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6B21C25C66
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A21B7F7EA;
	Wed,  7 Feb 2024 15:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ox5b70PW"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FEF76C6F;
	Wed,  7 Feb 2024 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707318057; cv=none; b=BjREINhizClBC27ZNpb6bpoXgkoDrJMZzk0hhrdnCyUrRQYoX9qymFXTJQA+aoEhbOS48dbx8lUx/U3FZP/QEBcn7Siojsd3vD1R+pdy0TsC5TjzfvFqd4dNd8P9nDkS0xVhXGm9O0oSR9e5ZlKBfD9G0sW1Xin+d8wB+NZEiAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707318057; c=relaxed/simple;
	bh=XXFDvBkeGOfbwZKGPocdQlFeqLv49I9NlaKKBdpBvqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i8eWGQlrShymc0N5OjWdRX5tge0rgivLxdYGrLcoY9XZEdD0jrPZgRceqCwp3obFyMqx/qKpV6uan+ufwgJcOus86VbtXQeuj/zhNyI9W02tc1dWSULtpVyV7sn7IyPdxfwgXxcUF7HV9bXvrIpIsaw/UOS6AfVXt9uurd1q+pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ox5b70PW; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707318053;
	bh=XXFDvBkeGOfbwZKGPocdQlFeqLv49I9NlaKKBdpBvqY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ox5b70PWQW1WjQ+6JuWbrICh02r2vS3PgbKIo6AknU+m1Z5Wpqdwr5BRPssr5ff+Q
	 aDnC/vkmoztrwKefMm9rM240l9btCIzLDT5Bo2xunfeNemN/2WrImCHHnMlXe3li2L
	 UvtK69YeUVcP0Pw77JSKFOEanmDPPjne/xoTVhw7k2e+koUe9qTVdB+RLFnfhYvsXH
	 Qq7TqQ0vx32nN/y0Qhj+Z7gHd/2RC5VC6TtyZZ4o6ceIZonPBvmw71I1HV0wLiPpVB
	 w7Ys3QiryqlGKrsoThwDskrrakbB4xpznlGcBs6bODS8FzpceySMfyaalFXGKRPTQF
	 umMZ/cafheGYw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E0A1A3782072;
	Wed,  7 Feb 2024 15:00:52 +0000 (UTC)
Message-ID: <2b91bd5e-9e66-402e-87fe-c2894e5a1d5a@collabora.com>
Date: Wed, 7 Feb 2024 16:00:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] mt76: Remove redundant assignment to variable tidno
Content-Language: en-US
To: Colin Ian King <colin.i.king@gmail.com>, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240207131113.2450297-1-colin.i.king@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240207131113.2450297-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/02/24 14:11, Colin Ian King ha scritto:
> The variable tidno is being assigned a value that is not being read
> and is being re-assigned a new value a few statements later.
> The assignment is redundant and can be removed.
> 
> Cleans up clang scan warning:
> drivers/net/wireless/mediatek/mt76/agg-rx.c:125:5: warning: Value stored
> to 'tidno' during its initialization is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/net/wireless/mediatek/mt76/agg-rx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/agg-rx.c b/drivers/net/wireless/mediatek/mt76/agg-rx.c
> index 10cbd9e560e7..07c386c7b4d0 100644
> --- a/drivers/net/wireless/mediatek/mt76/agg-rx.c
> +++ b/drivers/net/wireless/mediatek/mt76/agg-rx.c
> @@ -122,7 +122,7 @@ mt76_rx_aggr_check_ctl(struct sk_buff *skb, struct sk_buff_head *frames)
>   	struct ieee80211_bar *bar = mt76_skb_get_hdr(skb);
>   	struct mt76_wcid *wcid = status->wcid;
>   	struct mt76_rx_tid *tid;
> -	u8 tidno = status->qos_ctl & IEEE80211_QOS_CTL_TID_MASK;
> +	u8 tidno;
>   	u16 seqno;
>   
>   	if (!ieee80211_is_ctl(bar->frame_control))



