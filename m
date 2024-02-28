Return-Path: <linux-kernel+bounces-85105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4F686B07F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D926B273CE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A3014E2D9;
	Wed, 28 Feb 2024 13:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APWU8rZM"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2536F14AD07;
	Wed, 28 Feb 2024 13:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127477; cv=none; b=WGuor1psIn3zRHmH+kiBC4a/xvSjFqOdjWoFrISnf0Mga6Ae2DHEGRZgaUB+TpoGTYbC6vAlkR45as5Mk3v59o+A72lrcDr6vYr2Bk6ilZ7CrMTE2eZNQfS/dTs1huMatVCO8fQPpZclHgv/Jozl5cNgC9MHBkczZOtdiB8zrBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127477; c=relaxed/simple;
	bh=ZrIig3MM4Z+bo/sqJIChCKj/Pje7QWTe1w+LQ7AYd7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3C5wje0ZBAMHkEDJvs/QqxLp7xj68H4AxADUJ30bVqnq/zL3/dwYb+lQ4TbFyRpFNJfLWwzOw7KwwSdLSUoX1A7HWEHru0gsSY9JOpKCY0hXAYR4ZMw0wqPWlPswHAHJOgW+0TMSo4ap3UvhrqzFGetE3VXcmMG5EFQROzjmw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APWU8rZM; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d21cdbc85bso84619211fa.2;
        Wed, 28 Feb 2024 05:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709127474; x=1709732274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxWgL4sElI1B0/tx2GgHOxLa5Q0889pBGSF5c/6AjSo=;
        b=APWU8rZMSd44oQK4cQwmDyD10Bati7iN4EYq2cFJf/V1ausdaVI0S7ZjOw/vMsnBRs
         vuaSteWGsJjghSjwCoFIInKuskyETVmni6mymCmQ+EkMnHpVJmHFB3VmbTGDQUH5uVdy
         LMyjr2UQddYb9ilHugc46oTLuxy+zyr3VgEnMH0XRl5vzQCEMB2WY1O4+dYVTtBn3oEQ
         21qUR6CUxggCQaOU1EVUv6oR65e2On0zkmsdyv9nOe8CI1Mnq/xMd8rrK8hz/an8Iv57
         ESdhQF/ktOUnINjlQTMdCG655Q/E4E35Y9WzLS393DhvubtnnRYYqJ3nEK/X9FGEQM50
         S88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709127474; x=1709732274;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SxWgL4sElI1B0/tx2GgHOxLa5Q0889pBGSF5c/6AjSo=;
        b=VY91DAgGmj4xy6cWHWafm6sXi3ULU/y5c2HQbT2VSny1jOzBRcEJ1mq1gy8QInJMh0
         uJv8iRrqZ0E8a9tv66LVFhKrQDvUAiz0mKkBIdffJr6UUr+xuNwrOcyRS3Tugb94Xm6P
         /aYUZe4ccKuLG+Km4Bc1LVcq0zcRVQ32+DzHa2nDeJQ2bYCzOW9YWjqGHEGmn4DxoLrE
         PQIXvzrbDvEm8jteDyJSjmbiKDMRDUJ93w1/S9OHOOkrKTi7gVvqZg7hQIzGrP8YH91L
         m/3Op4tM0O4awnEXvOyQ/j1Xzd50YTh4AIfC6SETtDcrG/fsP9UOUYnrcG1qLqP6tf9P
         AOig==
X-Forwarded-Encrypted: i=1; AJvYcCXAK/oy7uXDCa+avjP2kvJT4XQg4eEoz3fJ4OaHQtjI0EeDpgyw1XjhWm8u+7aWAsJ5XGTWmZumgC6nni2bApivkZAjkhuMsZtkdlshf7Me3xLtOXeX9+rCGy+7lZvPqWM5b7zoNe1I2iYT
X-Gm-Message-State: AOJu0YyRLeHfdObX//0GiDh/Ik5rlTBNGFCD5q4YEW6M6hbAD+wZ0z/z
	VV6Oi74J+q8r6+33tS+y3y04BK8GwIZMSLs3rx2CBNicuOF9PcAf
X-Google-Smtp-Source: AGHT+IEGAbjhr46EhXX778kptGTzCsJXZVuCDdfQgon6/ZXpJpBpqXYL2Ir2C0Xs3h1Pus1GVC1Ojw==
X-Received: by 2002:a05:6512:21b1:b0:512:f733:9eb with SMTP id c17-20020a05651221b100b00512f73309ebmr5671413lft.11.1709127473910;
        Wed, 28 Feb 2024 05:37:53 -0800 (PST)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id o11-20020ac2494b000000b005131434454bsm433619lfi.228.2024.02.28.05.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:37:53 -0800 (PST)
Date: Wed, 28 Feb 2024 16:35:39 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Ovidiu Panait <ovidiu.panait@windriver.com>,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: Re: [PATCH] crypto: rk3288 - Fix use after free in unprepare
Message-ID: <Zd82q8lw_qH7KLCs@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Corentin Labbe <clabbe.montjoie@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Ovidiu Panait <ovidiu.panait@windriver.com>,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>
References: <20240226215358.555234-1-andrej.skvortzov@gmail.com>
 <Zd75LLhzlJx4nJiP@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zd75LLhzlJx4nJiP@gondor.apana.org.au>

On 24-02-28 17:13, Herbert Xu wrote:
> The unprepare call must be carried out before the finalize call
> as the latter can free the request.
> 
> Fixes: c66c17a0f69b ("crypto: rk3288 - Remove prepare/unprepare request")
> Reported-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> diff --git a/drivers/crypto/rockchip/rk3288_crypto_ahash.c b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
> index 1b13b4aa16ec..a235e6c300f1 100644
> --- a/drivers/crypto/rockchip/rk3288_crypto_ahash.c
> +++ b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
> @@ -332,12 +332,12 @@ static int rk_hash_run(struct crypto_engine *engine, void *breq)
>  theend:
>  	pm_runtime_put_autosuspend(rkc->dev);
>  
> +	rk_hash_unprepare(engine, breq);
> +
>  	local_bh_disable();
>  	crypto_finalize_hash_request(engine, breq, err);
>  	local_bh_enable();
>  
> -	rk_hash_unprepare(engine, breq);
> -
>  	return 0;
>  }
>  
Thanks, that was quick. I had locally the same change.

Reviewed-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>

-- 
Best regards,
Andrey Skvortsov

