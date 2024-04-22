Return-Path: <linux-kernel+bounces-152765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3263A8AC3F8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905BA2827E1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960CD18645;
	Mon, 22 Apr 2024 06:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kmIieH3s"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EFB1759F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713765602; cv=none; b=iIYTvIZzG5RA6Dzhn/LuheIPKwv/JLmrHXrGqugRP9e4lyLpejcguqlx+Loi++upJaODh7qLW2a78GyOnTXbBjebH4b8DcDV25Eczv8ts/vq8dCB//u26XgvUHMnO1QDe77J2gHWXub5oouA7i7Fr74C8UZd57WmVVJw9gSYR94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713765602; c=relaxed/simple;
	bh=5QrXklVTcuj9DlPCXZ0d2CTRpnsxXaYqy3W+YWV5oT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MkVRpvPRkKpP3jA7kjCnT6/RLlN6IN4nLzRKcw0etuux+lwwL4N3SSls2dB42qgbm5xx/Ovyi1uyg71lO8qinPrcAMSrMoBJqX42Tg4FKDA2IQstp1vY28l5VPROzucDl4sQ0i2b1x+TP+RPRpTO3b5ngIm3PLlSeA4TRwM91EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kmIieH3s; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a51a7d4466bso419831066b.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 23:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713765599; x=1714370399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mTIk2hkxt9Gsft4fGJNtwxU+haKYdo2o58nLmGxDOIE=;
        b=kmIieH3s81KkT+ehq2/vq6JSuz4u1ca9VPWxXb8OyEAjy/Yx+/Iv1P9sh4opiUVmaR
         hdESp+coSSkFgWONPN8zlscFfJIsbSSEUXub74TG7DxLPT5p/6EPah1luAw3a/WuqYZc
         DVZTwMDLAmxzu58poU7hvP2QAMn/PEcGZFeepCQfyWvX1TK4unwObnASrlxXPR0D6zbV
         YYOg8bdYnJ4bh9zx4otrG0WHHahcld3KyWK4DuOwCkEfoTa2RXc2NAC0mCS7UTQJFnDn
         v/pMtde8ZPFidBmKeItJcaG6Hk3kvVERIpd6fZ6qDuayiUgfUo9jbvMXG6OA7pq3F82L
         TWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713765599; x=1714370399;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mTIk2hkxt9Gsft4fGJNtwxU+haKYdo2o58nLmGxDOIE=;
        b=azmtmTaLolw9fZAx8pwIze4XTi3fGvrPZLgmREDrc3x5XVXXFg4QY+/9rE9vWGvP42
         WLacCZlJP7vYI7PhA/cTkPZujTivNiIxVkdbDoMvmwRMDPJtPUwZC4PaUdsqaxj8qDuU
         nJm2FCxnTI5Cv+QVBqqLZY4+oRr0BGWx30HvGQ3N6Elvjx6sA2LTvDFjd7T3OZAcerVO
         8Bgw7ZP5wd3dzipjYap0wp43nZsOL5VimV2gFYlLGLYpgR/HwTnwGmRYBngfPD+lAn3D
         xUIANZoBtakv/LTgufkG/RRb4NA7SEZ1O34nHkd8Q3jLTBoEZaYjdoGW50NBSr9td3O8
         wUKg==
X-Forwarded-Encrypted: i=1; AJvYcCU5PwCIsxWrEusAPSTvVbwYDI8npve08P6hqFlx74iISyFmXRU9d4/r2XWWm1jra/xrw7sGj66gOoUkZ21ZH2WxcLCVWC7o/PcR/pvm
X-Gm-Message-State: AOJu0Yx1UzViBf78QhHqxUMzIAxLozb4CcTLkXj1tDCL3D/HFLfqpk1s
	ffBi872+ujd8Etf0btgQMdgVIoPoUq59PYJ0oJKMrtiqS/1rF+igHnGeg/wyucM=
X-Google-Smtp-Source: AGHT+IG7f3ifbTeMgZnG7rk32T3DsVAkEUJPoKtCdKMlkL6tqRi+EelXsEJKjxibUYG/0MKJtMxVEg==
X-Received: by 2002:a17:906:2a4b:b0:a52:1770:965 with SMTP id k11-20020a1709062a4b00b00a5217700965mr4928859eje.42.1713765599507;
        Sun, 21 Apr 2024 22:59:59 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.100])
        by smtp.gmail.com with ESMTPSA id bi14-20020a170907368e00b00a5588ed8fa2sm3785331ejc.113.2024.04.21.22.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 22:59:59 -0700 (PDT)
Message-ID: <494daaab-a93c-44cd-a437-d306a8269251@linaro.org>
Date: Mon, 22 Apr 2024 06:59:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] mtd: spi-nor: get rid of SPI_NOR_NO_FR
To: Michael Walle <mwalle@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Ricardo Ribalda <ribalda@kernel.org>, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20240419141249.609534-1-mwalle@kernel.org>
 <20240419141249.609534-5-mwalle@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240419141249.609534-5-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/19/24 15:12, Michael Walle wrote:
> The evervision FRAM devices are the only user of the NO_FR flag. Dro

everspin is evervision?

> the global flag and instead use a manufacturer fixup for the evervision
> flashes to drop the fast read support.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
> Please note, that the fast read opcode will still be set in
> spi_nor_init_default_params(), but the selection of the read opcodes
> just depends on the mask.
> 
> That is also something I want to fix soon: the opcodes can always
> be set and the drivers/SFDP will only set the mask. Opcodes then can be
> switched between 3b and 4b ones if necessary.
> ---
>  drivers/mtd/spi-nor/core.c     |  9 ++-------
>  drivers/mtd/spi-nor/core.h     |  2 --
>  drivers/mtd/spi-nor/everspin.c | 19 +++++++++++++++----
>  3 files changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index f4c0b5185818..4e2ae6642d4c 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2923,15 +2923,10 @@ static void spi_nor_init_default_params(struct spi_nor *nor)
>  	params->page_size = info->page_size ?: SPI_NOR_DEFAULT_PAGE_SIZE;
>  	params->n_banks = info->n_banks ?: SPI_NOR_DEFAULT_N_BANKS;
>  
> -	if (!(info->flags & SPI_NOR_NO_FR)) {
> -		/* Default to Fast Read for DT and non-DT platform devices. */
> +	/* Default to Fast Read for non-DT and enable it if requested by DT. */
> +	if (!np || of_property_read_bool(np, "m25p,fast-read"))
>  		params->hwcaps.mask |= SNOR_HWCAPS_READ_FAST;
>  
> -		/* Mask out Fast Read if not requested at DT instantiation. */
> -		if (np && !of_property_read_bool(np, "m25p,fast-read"))
> -			params->hwcaps.mask &= ~SNOR_HWCAPS_READ_FAST;
> -	}
> -

You could do this in a dedicated patch, but I'm fine either way.

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

