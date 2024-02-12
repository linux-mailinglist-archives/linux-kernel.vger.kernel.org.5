Return-Path: <linux-kernel+bounces-61216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473E2850F0C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F26EF2820B7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EABF9E4;
	Mon, 12 Feb 2024 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fJryANDE"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB8CF50D;
	Mon, 12 Feb 2024 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707727537; cv=none; b=jM8iO5HmIhQrxARcZ97hWGtCFyiILN6BNAV5vk0TT7UaoRTBGPgGN7gbHlytcg0MyqorXMbIMcWcV21H82no+hWzhcDIOA2IXkPMOWHD6bMsn/U6ensOM3yk96eebwpwTYzLy+mVoq9ZeyxoaRY8Vusk9ypHNawEom0vt/02AE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707727537; c=relaxed/simple;
	bh=37r0uDvHoWoAoOBklJ4SqXVIYvqKxmwZ/Tk0SnZaf+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGHv07Y9seel8BmJPrgE822RJF7IIf3lGGXgm1G/3VFacdw65gQZ3jw5ZT0QL/KVdekRHV8rd6WbxQi0T+pspcTKxnaIIAwsR9058KirvHLyf0JnG1CSgqFA44fekwRVTTUNz9GbOBkWJytqTOIKlglFcGNen+uX3iBLMs5/umU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fJryANDE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707727533;
	bh=37r0uDvHoWoAoOBklJ4SqXVIYvqKxmwZ/Tk0SnZaf+U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fJryANDEDkxFcOEd3TUe/SVHBoEa5dLt4yiSEQeu9fSuLMqXZx/6Z9AjuSgr0sb0w
	 94y230CFIf0xaLG3dnGvej3PBfhS9NflyU/kD0wV1qHYnJlfYfkO0GogZ5VLMxeZem
	 g6FAGJch+wn9KMso8OvF9ENAObto1qxsi4WbPxjFP31pNeXZEKTUyS1oYD7rtUrmae
	 afznMbX52hgVfgCaJY1qjZO83Q9pEP+S6SwrTpYHHIo8hocnoX8QkmzmZBUyz+MgUx
	 AsYpfxfSkwKKjMCMgpab6htGn5oNB6f3QdaUq3GFXX6G/4NcvmIJMFIshQ26BWe+g9
	 v83F7VlTTi9WA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7ABC2378203F;
	Mon, 12 Feb 2024 08:45:32 +0000 (UTC)
Message-ID: <5cd419e6-2585-4f9e-b814-b928ebdb18f2@collabora.com>
Date: Mon, 12 Feb 2024 09:45:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: rawnand: Prefer struct_size over open coded
 arithmetic
To: Erick Archer <erick.archer@gmx.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Heiko Stuebner <heiko@sntech.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Rob Herring <robh@kernel.org>,
 Li Zetao <lizetao1@huawei.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Kees Cook <keescook@chromium.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-hardening@vger.kernel.org
References: <20240210161619.12656-1-erick.archer@gmx.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240210161619.12656-1-erick.archer@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 10/02/24 17:16, Erick Archer ha scritto:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1].
> 
> As the "chip" variable is a pointer to "struct mtk_nfc_nand_chip" and
> this structure ends in a flexible array:
> 
> struct mtk_nfc_nand_chip {
> 	[...]
> 	u8 sels[] __counted_by(nsels);
> };
> 
> the preferred way in the kernel is to use the struct_size() helper to
> do the arithmetic instead of the argument "size + count * size" in the
> devm_kzalloc() function.
> 
> This way, the code is more readable and more safer.

This way, the code is more readable and safer.

Apart from that,
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/160 [2]
> Signed-off-by: Erick Archer <erick.archer@gmx.com>
> ---
>   drivers/mtd/nand/raw/mtk_nand.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/mtk_nand.c b/drivers/mtd/nand/raw/mtk_nand.c
> index 60198e33d2d5..17477bb2d48f 100644
> --- a/drivers/mtd/nand/raw/mtk_nand.c
> +++ b/drivers/mtd/nand/raw/mtk_nand.c
> @@ -1356,7 +1356,7 @@ static int mtk_nfc_nand_chip_init(struct device *dev, struct mtk_nfc *nfc,
>   		return -EINVAL;
>   	}
> 
> -	chip = devm_kzalloc(dev, sizeof(*chip) + nsels * sizeof(u8),
> +	chip = devm_kzalloc(dev, struct_size(chip, sels, nsels),
>   			    GFP_KERNEL);
>   	if (!chip)
>   		return -ENOMEM;
> --
> 2.25.1
> 



