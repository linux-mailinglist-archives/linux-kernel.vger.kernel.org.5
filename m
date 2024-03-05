Return-Path: <linux-kernel+bounces-91484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F4C871238
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F54D283C4B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E62125C7;
	Tue,  5 Mar 2024 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCC89Wav"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2372CFC0A;
	Tue,  5 Mar 2024 01:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709601026; cv=none; b=MvJ7JK9w2exdvERuKqgDtpbUlkWzJ4993rNGs2Vh9BMJtsqcKWrDWL8hIv6ICq5FQ+8NLb5kTJvKZ1GG0FoWk8gMvv2/8+LWxyxtIsY4XBU8eO7Hn1WxOCf2qLDlKLX4e/tlGSMW+EB+xRXJxwVu9xvwyQ3KDJYvXE1VxN/ptvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709601026; c=relaxed/simple;
	bh=JaO4U2AzZDz6iZEvD1/kV2ylA7u2AVftNFacZdl8sX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZGIn4e8lOQ5UQOtAqCiBaGTumRqEmVoyhYDMjK3cNz+/rQGMsB/KOBLhwt2QYDuiqgfjZerchqKJ7Gic7zZjjY/GdZXn1TrzulrDILNBxkG1/sFFNVWHc73QxvYdwLmKS0tq8GRhLQdpMHpa+8R3Xj3NkUFZXuyKWK6l1+bCU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCC89Wav; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dd10ae77d8so12524645ad.0;
        Mon, 04 Mar 2024 17:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709601024; x=1710205824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eAgT5gjHKKVhhqkTy/NqFbUddc7Qxj55xxgIVvsYtdY=;
        b=LCC89WavSjZM3UAI7+mOzRP2X6ESyN1dh71MAk2RrZXVaYBGxjNsBGKSeAtaNOSWgB
         LOWp6JZkIbmN62sKAKF8ed8JFYQmx7kHiaPSHqwHCZtJd40p1QaXURWrOi1wi9w5W1Zu
         GVhWb6IbW7SI9+H4YgmjFiFJxHnLCyxE7bL/MuwvlEaqsXbr3LMR12JUtfUvgKL/vWgZ
         aL1eGhcctZE7zdK6dcYNlbL+EHBj4EOujXrd7Aq4OpGgPeJfLcTr2DkHbjOWU0i7TJfV
         y90VaAbViLh7dM53fEfhKQP45UL2+e3CaufMuuDjvot4as7aDllzNK+o4pba0cSkXAfS
         cbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709601024; x=1710205824;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eAgT5gjHKKVhhqkTy/NqFbUddc7Qxj55xxgIVvsYtdY=;
        b=Y7hP1glqP2YymUBypgRDEx5sXdUi3Rz3Uc79hHUr5ERQSC+MOGbC/rK7PuPgwer/vZ
         DMfbBhNOICYqPgG62q0tjbj4UBpE9BqRo3fPfGVX7mjsKdLMzOMaCDkAPo65dpDw9o43
         wD4mbSIHA+I8FO88XdPU12wZ/RWeEWC7YKp7Djv0Zvq1Yo0iaGnbcokiXuc8VopbQgsA
         izdXpSxJUa4fiBonkfk3ymzm9kDoS7lW1NsCQZ5WfpOpeonbOaEYNjR4fLu6bblpLqKg
         7f7yYCfyCMTwfM+DHEQmaRPpPWKAjohCpYndSLo8Y0Lw1ZjAwlFS1Ta7hewgouWa/UQ4
         zexA==
X-Forwarded-Encrypted: i=1; AJvYcCV7wlgx9UFdDUoE1ReiHeClusG22w+Nnt/atQGEL1q0rg6Hx2SWT1nt9SafAxtD/xXfL1a1rARkEGy9tnzxuG7v4if9cRKA+sBvePuOYoiE6TUTCNFUFPXNMkdKeEt55itOLFG1lQnTakdplB87
X-Gm-Message-State: AOJu0YxUrhogP9Q7jmlx8ykQQ+5cEihyubXyRYZ8KxECgP3zzyYUSk0l
	8t6QhWDitI4jClYWle8tK9vEpOA1Mumf2yitvRHFSFMH3QS9gJmg
X-Google-Smtp-Source: AGHT+IH/HvrX+GE5jUYMo3nzDfigukx8hBYlI+mfGQ9w5xdleZXK4fK3hZZRv9RdU3a28BezP8jlUw==
X-Received: by 2002:a17:903:1249:b0:1db:4419:e925 with SMTP id u9-20020a170903124900b001db4419e925mr550700plh.1.1709601024432;
        Mon, 04 Mar 2024 17:10:24 -0800 (PST)
Received: from [192.168.0.9] (KD106168128197.ppp-bb.dion.ne.jp. [106.168.128.197])
        by smtp.gmail.com with ESMTPSA id j14-20020a170902da8e00b001dc8d6a9d40sm9151662plx.144.2024.03.04.17.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 17:10:23 -0800 (PST)
Message-ID: <55e95ba4-419c-4e53-b947-5ee209e43fc4@gmail.com>
Date: Tue, 5 Mar 2024 10:10:19 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: spi-nor: core: correct type of i
Content-Language: en-US
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Cc: kernel@collabora.com, kernel-janitors@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240304090103.818092-1-usama.anjum@collabora.com>
From: Takahiro Kuwano <tkuw584924@gmail.com>
In-Reply-To: <20240304090103.818092-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Thanks for pointing out and fixing this.

Takahiro

On 3/4/2024 6:01 PM, Muhammad Usama Anjum wrote:
> The i should be signed to find out the end of the loop. Otherwise,
> i >= 0 is always true and loop becomes infinite. Make its type to be
> int.
> 
> Fixes: 6a9eda34418f ("mtd: spi-nor: core: set mtd->eraseregions for non-uniform erase map")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Make i int instead of u8
> ---
>  drivers/mtd/spi-nor/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 65b32ea59afc6..3e1f1913536bf 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3373,7 +3373,7 @@ static u32
>  spi_nor_get_region_erasesize(const struct spi_nor_erase_region *region,
>  			     const struct spi_nor_erase_type *erase_type)
>  {
> -	u8 i;
> +	int i;
>  
>  	if (region->overlaid)
>  		return region->size;

