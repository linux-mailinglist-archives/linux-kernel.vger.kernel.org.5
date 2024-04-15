Return-Path: <linux-kernel+bounces-144904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E03148A4C70
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DEAC1C21D2A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED84652F8A;
	Mon, 15 Apr 2024 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCaqm7Xz"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39D947F50;
	Mon, 15 Apr 2024 10:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713176430; cv=none; b=amCYB86JAhllEJi/B2GZUGz6TJZEonYae9ez/RVDNF1aCWijlTE9kxfysSjz0Kv9F1KW2PG55c/J7XOYEEEhiu/BQEOCvWYvHThNYkUrSrISG+QwtLw8dvj3wdtCm3hspmgWAEIQYw8D9lLoVQPVovEe0Jsa+IXOpC30X+009MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713176430; c=relaxed/simple;
	bh=vIKidPQenfmOzPpfp62FETcxxyAg9ci26O70YTcR+E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgqDFzPRgSW9vFgPsnBQWfPH/jVw0qhPVZmYTqoQSSF3zfrq52jnYIzGTxGC6vpaRzTrCLWTxiTfTRY8LXfwTiOjDej2P7mzJV+4hV8xbsIFOSqP2AwqTjeqD6RoUsAhjrfcJMJMk5Hup8sHeByBxTeAP7YWDfT+EfrgqmNvtMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCaqm7Xz; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d718ee7344so29693721fa.2;
        Mon, 15 Apr 2024 03:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713176427; x=1713781227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B5eNuM2M/mJ6hFGK3SsN3a0/R6uO67DQxbTuQIItHfE=;
        b=dCaqm7Xz/yvEk1Fj/61VcUVZIDUvlYp23HcvHdbJ1o7o0pN/SNch++K5qkKnxvDC3C
         B9w194XrIFH54Jz8mHpQP7kdP2WaB9sUUR6TRq5BXyjDGA+FLH/mQKT8+gvM/OMvlGLq
         Dlyh3cTzwN6TfvJb0HXZ2FW9XN3x+85GaR9mHKQCr5FnWbdSa3hjeS8VapEQndkD+eRW
         0BwTcyAWfWKR2LhHtIAZRVWNytOx3qddsmWH/YPl3YtnMXHe5JVUJ8vFpic3UmPo5bPw
         SHxDodWOlKFN5Uq8iHoxGaRZ7pQOihjNXhKyIUgbMnZiWYaVrF2dy04Tsviw7mGVAyBE
         2bBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713176427; x=1713781227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5eNuM2M/mJ6hFGK3SsN3a0/R6uO67DQxbTuQIItHfE=;
        b=G2I5tyaJ1+wV3WwUs6vF1qC/DjVluruAgJelG6+HHYRaNZoz3cT2Xaf9ag1NlXB3X9
         RbcGqoFwoukHcFxt0jhRIVayfQ5hJ9Kf3+mtL5zlFoElZUiRfVxr+nEYXTOAap/Pr0Zg
         7JVYltwtcgXW+ygzif5eUO4GcfcV6TnCCjsH/eyULO7GxJQxt5iG0mGDmle9hQnPeddZ
         Oykii8x/p81c/jQyIfgBOs4fDD6RekMVN6hPR1JJEN6JNAFys2kuq8djc5v4/QJEI4eg
         9qRHn87AE87QfwC+JT10wwk79mmo/x2ssbeoqWjFDCsElgl+fj60npKAqTXVbkXVUN6O
         GcwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi5yoq8Y0+gXCvQ7CO+h2i1Uw+UiRq8xzYvLXkrNDwELtEB9YhGaK2dKqorpCm+ocjS8zAuTvBkjJGqp/XhOGcvcrbSVlE/JRpyIuzxcSiK1dA7GYTyubpzbpB+jJhZxtFLwL4
X-Gm-Message-State: AOJu0YyjlXenIhiPietxTUn+J4INMRh5W/kHvakH5FCWIXRW/roUi5Jb
	rAtS+x20Cdis01vkWSVf++t21hryYxeYTuIX6Jmy6Oquy0AbOXio
X-Google-Smtp-Source: AGHT+IEYuIuzFDVDOLhg3dcojnVrUNk4IVc/mSwzpskHOfYngGgMwk1IHbL93IqzS9uP3jdhK75ZsA==
X-Received: by 2002:a2e:900f:0:b0:2d5:6b1c:b180 with SMTP id h15-20020a2e900f000000b002d56b1cb180mr6076371ljg.8.1713176426540;
        Mon, 15 Apr 2024 03:20:26 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d108:9b00:f547:f722:ecdd:8689])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c3b1200b0041668162b45sm18909742wms.26.2024.04.15.03.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 03:20:25 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:20:23 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: microchip: drop unneeded MODULE_ALIAS
Message-ID: <20240415102023.mmkkrvuh7sulelyn@skbuf>
References: <20240414154929.127045-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414154929.127045-1-krzk@kernel.org>

On Sun, Apr 14, 2024 at 05:49:29PM +0200, Krzysztof Kozlowski wrote:
> The ID table already has respective entry and MODULE_DEVICE_TABLE and
> creates proper alias for SPI driver.  Having another MODULE_ALIAS causes
> the alias to be duplicated.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/net/dsa/microchip/ksz_spi.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchip/ksz_spi.c
> index c8166fb440ab..cdc4add5f5b5 100644
> --- a/drivers/net/dsa/microchip/ksz_spi.c
> +++ b/drivers/net/dsa/microchip/ksz_spi.c
> @@ -233,13 +233,6 @@ static struct spi_driver ksz_spi_driver = {
>  
>  module_spi_driver(ksz_spi_driver);
>  
> -MODULE_ALIAS("spi:ksz9477");
> -MODULE_ALIAS("spi:ksz9896");
> -MODULE_ALIAS("spi:ksz9897");
> -MODULE_ALIAS("spi:ksz9893");
> -MODULE_ALIAS("spi:ksz9563");
> -MODULE_ALIAS("spi:ksz8563");
> -MODULE_ALIAS("spi:ksz9567");
>  MODULE_ALIAS("spi:lan937x");

The spi:lan937x alias is bogus, right? LAN937x switches are covered by
these entries in ksz_spi_ids[]:

	{ "lan9370" },
	{ "lan9371" },
	{ "lan9372" },
	{ "lan9373" },
	{ "lan9374" },

>  MODULE_AUTHOR("Tristram Ha <Tristram.Ha@microchip.com>");
>  MODULE_DESCRIPTION("Microchip ksz Series Switch SPI Driver");
> -- 
> 2.34.1
> 

