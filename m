Return-Path: <linux-kernel+bounces-136806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF9589D85D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1298EB2960E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B253A12A14F;
	Tue,  9 Apr 2024 11:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="w3c2kQFO"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681A486AF4;
	Tue,  9 Apr 2024 11:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712663146; cv=none; b=Dxzcw0zeBQc6+sOuGZwSiyGxangfBNuPmeY9ctrh3PAZlkzw+r4JFzLCTS97bEcLICCPg3UvrgQxBWbmqeMzLKSSsXE7kVxtxRaZXJtszO7mMy7Wun5ZYZYMTz6ZxAIj8Hika9EGmuDCbOSuOd/KLL7frT8R61yKxu3Z5/wKde4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712663146; c=relaxed/simple;
	bh=lC4EWcyFhRfCmq02OzOhjC6dK5sQhjYXtXyu0Z/pVO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y849mvezmQqkhDebljdhPA6nqjUhGyDeU4I16abCo8HRJ806v7Z+r0cciYZXGWYkak5OsFEKKqhJJ927kpl9iyGpvvHpAXUlrHfqIWyou9qUDJfZFv+xxTaic+N4vHy28kvVrPK0XB5GDsbsooT2bx4GrilK+y4X1ThYdKc7So4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=w3c2kQFO; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712663142;
	bh=lC4EWcyFhRfCmq02OzOhjC6dK5sQhjYXtXyu0Z/pVO8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=w3c2kQFOB9CvuYyVBDEo7ncdVlz3Zt9JgxPdIIBosC8qcLaa0fP2yD2eKN4eGtn0J
	 Uiu5m97KAjMcXiRPcc1XSZU9gtEdOpf2lACGTOibkpHatkd7aH0LOn914CkjBpm30M
	 /VPO9c6ORB8uqvHl27IOmsB55KdiiH12cgbfZ2GYL2Ag6WDsck244+j+pmCQAjAn1H
	 rWX02LNgggpNu9ExU7PMayxgB2nZh+1yujFm/W/VX2s3yYVyetuRVnd2l8au+MMCc3
	 ioJTAjRb/nGm5yulnao+dR9u1V+URfC+eCL11sGhJt4f64X9pUlr8jJbWnkIqX3hz8
	 RV4QuRAowgY7w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DDAEB37820F5;
	Tue,  9 Apr 2024 11:45:41 +0000 (UTC)
Message-ID: <c98ea7c9-6c9b-466d-bc49-ec76874ac6da@collabora.com>
Date: Tue, 9 Apr 2024 13:45:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] leds: mt6360: Fix the second LED can not enable torch
 mode by V4L2
To: ChiaEn Wu <chiaen_wu@richtek.com>, pavel@ucw.cz, lee@kernel.org,
 matthias.bgg@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 peterwu.pub@gmail.com, cy_huang@richtek.com
References: <d1d1419bb322e2b0f40d34edd3a66979015b668c.1712657386.git.chiaen_wu@richtek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <d1d1419bb322e2b0f40d34edd3a66979015b668c.1712657386.git.chiaen_wu@richtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 09/04/24 12:21, ChiaEn Wu ha scritto:
> V4L2 will disable strobe mode of the LED device when enable torch mode,
> but this logic will conflict with the "priv->fled_torch_used"
> in "mt6360_strobe_set()". So after enabling torch mode of the first
> LED, the second LED will not be able to enable torch mode correctly.
> 
> Therefore, at the beginning of "mt6360_strobe_set()", check whether the
> state of the upcoming change and the current LED device state are the
> same, so as to avoid the above problem.
> 
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> ---
>   drivers/leds/flash/leds-mt6360.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/leds/flash/leds-mt6360.c b/drivers/leds/flash/leds-mt6360.c
> index a90de82f4568..1b75b4d36834 100644
> --- a/drivers/leds/flash/leds-mt6360.c
> +++ b/drivers/leds/flash/leds-mt6360.c
> @@ -241,10 +241,20 @@ static int mt6360_strobe_set(struct led_classdev_flash *fl_cdev, bool state)
>   	u32 enable_mask = MT6360_STROBEN_MASK | MT6360_FLCSEN_MASK(led->led_no);
>   	u32 val = state ? MT6360_FLCSEN_MASK(led->led_no) : 0;
>   	u32 prev = priv->fled_strobe_used, curr;
> -	int ret;
> +	int ret = 0;

I prefer that you leave ret uninitialized here, and...

>   
>   	mutex_lock(&priv->lock);
>   
> +	/*
> +	 * If the state of the upcoming change is the same as the current LED
> +	 * device state, then skip the subsequent code to avoid conflict
> +	 * with the flow of turning on LED torch mode in V4L2.
> +	 */
> +	if (state == !!(BIT(led->led_no) & prev)) {
> +		dev_info(lcdev->dev, "No change in strobe state [0x%x]\n", prev);

..that you do here, instead

		ret = 0;
		goto unlock;

With that addressed,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collaobra.com>



