Return-Path: <linux-kernel+bounces-90278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A3986FCCD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F6C2843EE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED9E22071;
	Mon,  4 Mar 2024 09:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wle3JIf2"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070611BDEE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709543467; cv=none; b=pdPyYi9XMSzSZvVTOTSpJ/0JLfpWaJoy9VeJTPWyV9bGUaBSi2mowYyoI6qifeq1K3bEKclvScP1U4X69nBNNijItijX4Y0/VWAjc8j0MtJjPWfEP0c1Z3bZkLoJFC6X1mfHjjjZXJl9Rhsspv6r8XYiP3Sh7AeQ0VkGdbBnClA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709543467; c=relaxed/simple;
	bh=CUtZhKapsZY/xavUkp55/c+tMUGvUPzfYmx4hsetBuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K5L/mldskj4NIgwfm+R4whwN0iWEfaWkngowBIriz2kRr83EqB+hCWiS5l7Ol/WLuM6BSIQ1k1Rv+Ks/0AzvS9zs01cYCH/ZTHNa2xUXAc2eDaioA3VSgIgSexCgi6W1sLc7TvQOq4NbaBjdIH+9YQpdyVS+K37a3QDfi6p9v4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wle3JIf2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412ddef6f83so7347345e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 01:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709543464; x=1710148264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MAS4NfgNmP0HvgF3U0o9wHMePf9MEveoKdtR6KEo+dA=;
        b=Wle3JIf2cCXXveWmsO+XQsfI6Wp0LQTBv0yAv9UfmuNDPSrpLITeSQRpdGphXW6PXv
         LzfdKadXWFohNf5bpwLXbu3iJv+winXnVqwnXi8LZ5CfbzS3KcR/uNIpxZpwHm/0m9nP
         xCdB1CPe5S4tOkrY40GLX2QT2K+F5OdHZIbjEZ6GZOep7AAEsT+qV19qxiyYONHZFrrz
         4AKI5/xgg1/9cu/uvH/Wc+wVyNMI3Xb+3zSQeWMZMiTKWz+MSyfRpZE0zo63el3vjBiX
         9/FoK2Yt/KGK56Y3aeiBW8z+NAonX2nPQfQx77Fa7acZFxOCxqemWX3w1S1MWpTKtE9e
         be/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709543464; x=1710148264;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MAS4NfgNmP0HvgF3U0o9wHMePf9MEveoKdtR6KEo+dA=;
        b=SqK/95UvqhClm4fDSLJPZPL+S0X7DTLR1soCYImfXX9f0czd5J+eC5eaC2WDpMKfFB
         HuhPdRSFfBOviP+gNoO6aryVoOwiSGSo4u7G59Mt05VCrUAZkP0WDdb1MMJOR+aktCCf
         /2ooMLcEsm5B4zq0a79pnPu5f3phzRQRSrx4qWP8jc/bGBhpcjMjxYnQBHjv5CJvqyZh
         tJkm7h2au88fzVmRLtgZ8ev+3xSd10vHOI3qFWvitVHBsMfPyYjHc19gQrQEPEQBDbeT
         UidJxEvXiME+a/8NiIUQZMnEvhntJl3RK1Y4LheiAd1ruwafDvqDwGH+ybFujPXaE+st
         eRUg==
X-Forwarded-Encrypted: i=1; AJvYcCW/d4ojr5N/+BAK15jxEJ38aYWrFLAbx+7EiXglzqRXdPVHVjjJsCR7pFXt6I3f7hKj78roCbWrutAa7DThLV/MBH2XM4nttIvCdGjB
X-Gm-Message-State: AOJu0YycI6NizZsEIYBH9hD96ZZYb5S8T4Gamlf66yvFi4j825UR8Ol+
	2mKJ7PbCojuIMdfriZ7A6OhnacIFsVR6aMnUqYYd23802jw7dJ0Tg2n9uaMPVJ0=
X-Google-Smtp-Source: AGHT+IFEmXB1YdPhR2t7PE+oBbpNOs7QcDk2q6Z7v8XjJnD94Ikv7TDFwaNIEDds2pPVHP4cpZUn0g==
X-Received: by 2002:a05:600c:3d91:b0:412:e555:f90e with SMTP id bi17-20020a05600c3d9100b00412e555f90emr938804wmb.35.1709543464434;
        Mon, 04 Mar 2024 01:11:04 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.35])
        by smtp.gmail.com with ESMTPSA id j11-20020a5d604b000000b0033d9ee09b7asm11634328wrt.107.2024.03.04.01.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 01:11:04 -0800 (PST)
Message-ID: <9e4461ec-2207-42bb-a3a9-826eac1757da@linaro.org>
Date: Mon, 4 Mar 2024 09:11:02 +0000
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
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Cc: kernel@collabora.com, kernel-janitors@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240304090103.818092-1-usama.anjum@collabora.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240304090103.818092-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Miquel,

Can you please queue this to mtd/next after you pull in the SPI NOR
changes? Thanks!

ta

On 3/4/24 09:01, Muhammad Usama Anjum wrote:
> The i should be signed to find out the end of the loop. Otherwise,
> i >= 0 is always true and loop becomes infinite. Make its type to be
> int.
> 
> Fixes: 6a9eda34418f ("mtd: spi-nor: core: set mtd->eraseregions for non-uniform erase map")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

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

