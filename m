Return-Path: <linux-kernel+bounces-161896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E338B52E3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29031C20D72
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B723A17559;
	Mon, 29 Apr 2024 08:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Vg1xro7D"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E9415E8B;
	Mon, 29 Apr 2024 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714378427; cv=none; b=VkDodR6QUJqCb9vLPNQgoet4ZnLY6PTqLq1BooZ07EOY3ucSpdujitYwwDinGMbANlTrxSeq32kDLPcWgYG6xk1YnwiRA3rBT/Hx4uXdBU9SCIdp8pgQfKOG7SYeBnjpLuRitnBiwolU172SahwRD3NmVY8hxkS4cgngA5CZiJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714378427; c=relaxed/simple;
	bh=b1SZPFe+NuDhrNOpdqekcjo4NtR3t0eI9LUZWGBoZ2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h68dIK0sbdgJfhWQLp7agIkmneqInIU7tjHoQnu64+j/JkrVCVavaIj+MdtuR/7SM8pw0LyyJ1atMDv2N3KwD4SSC2i4HJbPqXvkzZRQxxGm6hyzfbQb1cif1BiF4rG5xzJ/g8OhIDH8yu0dj2chessMa6ECVmCf4iQrL+tfirc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Vg1xro7D; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714378423;
	bh=b1SZPFe+NuDhrNOpdqekcjo4NtR3t0eI9LUZWGBoZ2U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vg1xro7DPLUieeWf4MObveLWKyTiikAkK/pIXlJjlaVz1tL7cQAaQZ/D4oqAM4zxl
	 r8HgExOz8TWgAjPjIxNuvBgu4ocTRCXoe8gtXqDUEARqmN+YrYdXZLXI9l8ql1MN+8
	 1UdT9QCggwJOAhtCkRKpui32Xh+CIYbhY6sVlUF67I1mH0QdznTYVqDkbvnoXSwpxK
	 zujgqfYEcjqfs0nQnJuNXOWJcbALcZY3vPvko8QDLBQb63YNEE57FZZNhUPaL1OujJ
	 ZJJgXw9809tFTIFZQUI5dJ5p6oLHAZnuPjwxMfyIY/I6AgKlJdGDNkurH9MsNO9/P9
	 S8lBqPVKa4y1Q==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1BBF6378134F;
	Mon, 29 Apr 2024 08:13:43 +0000 (UTC)
Message-ID: <16df315e-8a05-49a4-ac07-d1ed150c9317@collabora.com>
Date: Mon, 29 Apr 2024 10:13:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] leds: mt6370: Remove an unused field in struct
 mt6370_priv
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <e389be5e1012dc05fc2641123883ca3b0747525a.1714328839.git.christophe.jaillet@wanadoo.fr>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <e389be5e1012dc05fc2641123883ca3b0747525a.1714328839.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 28/04/24 20:27, Christophe JAILLET ha scritto:
> In "struct mt6370_priv", the 'reg_cfgs' field is unused.
> 
> Moreover the "struct reg_cfg" is defined nowhere. Neither in this file, nor
> in a global .h file, so it is completely pointless.
> 
> Remove it.

Sure

> 
> Found with cppcheck, unusedStructMember.
> 
> So, remove it.

Again?! :-P

> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


Anyway, this commit misses a Fixes tag; please add the relevant one, after which,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> Compile tested only.
> ---
>   drivers/leds/rgb/leds-mt6370-rgb.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/leds/rgb/leds-mt6370-rgb.c b/drivers/leds/rgb/leds-mt6370-rgb.c
> index 448d0da11848..359ef00498b4 100644
> --- a/drivers/leds/rgb/leds-mt6370-rgb.c
> +++ b/drivers/leds/rgb/leds-mt6370-rgb.c
> @@ -149,7 +149,6 @@ struct mt6370_priv {
>   	struct regmap_field *fields[F_MAX_FIELDS];
>   	const struct reg_field *reg_fields;
>   	const struct linear_range *ranges;
> -	struct reg_cfg *reg_cfgs;
>   	const struct mt6370_pdata *pdata;
>   	unsigned int leds_count;
>   	unsigned int leds_active;



