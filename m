Return-Path: <linux-kernel+bounces-61922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D1785186E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65D9C1C2216B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4D33CF68;
	Mon, 12 Feb 2024 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvwmNzT0"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF263CF45;
	Mon, 12 Feb 2024 15:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707753060; cv=none; b=ouYg03WXzA4dbgHwKgfoJB/M4LG96Dl8GnX0IZf5p1fZGp6ap/nZG8Yl6L02B1mP//9DdCA3qoJToLkXMtk5fzmjxx3Cq53U6CbaM4MCuIeyYOW3DvUFSMM/xPg7rN2wsFMQfYLfnlbPbUeEAdOVghNfqSs/tCZq3KeqP3kHvsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707753060; c=relaxed/simple;
	bh=xGPVBigagNRNZsOr8Us5qwixX890ZDiKv3BG7ESfd8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aj9wDoZuzsPfaV1CYNdpOagGZjNClJTdTl+CSElqY/oBZhJLpwdIrJeO/ZuT66uoR3bNaxCLO+Tk0Smn1rWu0n/ojB6gL3HIzzzfItDLunA24wfasLsUwQkrbm/ZmxPPqiZrevhGqXdwDMRJp1p3CUJGd/MB8Mfrvz+z2Ulwc04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvwmNzT0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-411a6ceada8so2430815e9.3;
        Mon, 12 Feb 2024 07:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707753056; x=1708357856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DKJbvwlkOP1SRi/Z77aD8twgFDCEOZM6sW2cKw9vfP8=;
        b=SvwmNzT0RA9ei8qM5L3z82b1PaJeGy8sT76VQmIY/qkg5unByyq+C4R4Yj05kPBdtU
         I4yEvicgtx/gFjmh01DWMcQcH+XNI6u2G9I7IbiGJsd3P762yqYYdfvnHXVhJz/FyKfG
         HxFuLAv11hYIugqm62tdDia74c32mJMHKJjpylue1UOUrXxs/gLqtRFvFKdRs/yjLpxh
         rW9a75f6O8UAOLGx0x1ixZRq1UgaasHcinr5vMimoxDE4WepUoqgHWE44FfcYIsjTK58
         aSKJMU98eEAA+4n8XsTbmPP3SG3FgPHMFaWGSBrFdWeQc/Jq4UQHyJu1I6Uq+D8Mik3t
         iE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707753056; x=1708357856;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DKJbvwlkOP1SRi/Z77aD8twgFDCEOZM6sW2cKw9vfP8=;
        b=LSaKoK50VVx+TAXnMSfHX5EPU7DaEMCoPGqSk1I+Az5L3QNPQLkGIyqW7vBYNTccfB
         zxYpHL9CD2fLMjFOqk88sRTTkEzy3JBSKrEA4wTHfl5aJb3zIocVwSMyfJ/jWLknr7eW
         QUXl5MS8Q7nUzKCraz6yi4JBg3b+Vn8pTBjIvfGxILdFSOp0ls2g7hJPYlubIdfyrg/i
         hydUZaZeqLJfGzB9K76vqjUL5HHkQ2eB+PbhZhPhtNd9paTdPlQarBlGc4ow+eqzblCn
         kPrT7o1vmvQ9AS2DiABMbeQvZf9tT15LiYetWXRs2MHBGIJiAvOBk9NgUrbB3RgTw2tX
         xHQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtDDd1vuRU6Qlko9Ohlk9y9RWmQOVxZ8t0twa2avyrANKGNGupu1vzMVzoMQ+7RwsY41QJwdMcdkt7t79ZnJjveoz3sz5Xyw10Aen3NBrFxUkOgcgJvuvvYcHHSzkepl+bY1/F+C95+MIQ3CND
X-Gm-Message-State: AOJu0Yy1635NpQKf2U7ehM10np7Xb9UewFQ7wWINvpGTruaC3xTOXRp8
	r0XmxIKYSmN7ehMVVRf+7SyuR9X3tXESDHxBR3PuaCIj4jFAMv3E
X-Google-Smtp-Source: AGHT+IEc+c8gZb2UL13KcPyzSt4NGhKYck2YJGye4943wMZe7LgW/jeKFsFr17NDmh3SEL0rg8X6Gg==
X-Received: by 2002:a05:600c:4f8e:b0:410:7897:6c68 with SMTP id n14-20020a05600c4f8e00b0041078976c68mr5816893wmq.3.1707753056342;
        Mon, 12 Feb 2024 07:50:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXD8geSAWQRDN9wEm603b2P2I5b3hHLLwQxozbSbN9lQC3GeJ1rtH2ArXvmkp3fKlw5svrA2kzag1dDitt1chiYFYYX3/ScuD+vNzYTtZceStz9yc+uZQQUcSqUD4QbIkxT/xnW5F2FDIV/1+TZR8yqPfh3ZyX76+NeuMne3GylIBnKfnWvtuqLfjbUBQsYp8ZIrpGbBieEQ760H/W9k5dLtJWVtGxsMeaZWV+AAqO7eQexjgKwBTwyEG6SW70VB2GIjgL0Y5+7YjcwhWrdlupeCsVeyXHsVcO3jWJ5+kOhwBMYShVe6O7QjfUgjIO8oj7YOiNqtm16Ro3wG3hDmGzF8WBUj0rvGe8voETzjsYfm5cbaXYCY9qGW7XvnMsp3SQp+q5A0BerKef3Ugsq+wPxsB1ftqw48DL4VCiuuWwDfUFo5DvfAXbUt9Pi+QD8tw0E1oDbOw6nlZwrL1WOcNCQYkapgZzda8W/GkUv/uDIR1bjXlOyx1j6afEPPLP0B3Ow0UIkzH73CFIyOSfw+9QzTaRGIVXsmBPWMtfDX39CUh2a3FFHkX6QYNZ2tO7/WYtXgZ1tNK0zakRtRto20y0HXrJVOn8HIxl036q0xjzwI7BmsgWy7Kyt
Received: from [192.168.1.135] ([207.188.161.188])
        by smtp.gmail.com with ESMTPSA id j36-20020a05600c1c2400b00410833555d5sm8461390wms.21.2024.02.12.07.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 07:50:52 -0800 (PST)
Message-ID: <f5ea54f4-9176-4fde-89bf-71b1771e47c3@gmail.com>
Date: Mon, 12 Feb 2024 16:50:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: rawnand: Prefer struct_size over open coded
 arithmetic
Content-Language: en-US, ca-ES, es-ES
To: Erick Archer <erick.archer@gmx.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
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
References: <20240211091633.4545-1-erick.archer@gmx.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20240211091633.4545-1-erick.archer@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/02/2024 10:16, Erick Archer wrote:
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
> This way, the code is more readable and safer.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/160 [2]
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
> Changes in v2:
> - Add the "Reviewed-by:" tag.
> - Fix a spelling error in the commit message. Change "more safer" for
>    "safer" (Uwe Kleine-König)
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

