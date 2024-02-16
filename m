Return-Path: <linux-kernel+bounces-69177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF97D858569
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2C661C20BE3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782E4135A48;
	Fri, 16 Feb 2024 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBksYlYq"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66221353FF;
	Fri, 16 Feb 2024 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108804; cv=none; b=eDfd3o27nWXUOml32iDca168YMjEJ3snUy7HNlNm5+7EvoAksXNw76vX5R+KkwJy+R/tZC43Cf65RU7oR6TdLrUmU2R9glGngNGk0rMBI69QfyYckCzkygpaRIH1XpDzU86x8n7TVdgGGDeMGZexR1uPkZCvcrZUjbGp4XrHR0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108804; c=relaxed/simple;
	bh=KFXs/nTuMM+dWIefmFTAjCBQ7XDB+JXn9nNipT7JTdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptdOKv957LqwlGRg5DRC+qHNMklKuaqU1F7W4XrCIzLnwnt6/4bWMm7Y5+29KF6UHuX3tb2omtTjxiT0KuEPGyIQ6A+D3g6nRpcLUYDjFwu0fW6Dji/xkWwxGMn9bftLTouLsR5wx+cWm/1Fz+Gm7O4BXASOowXhbh1a1uGyP18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBksYlYq; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d21a68dd3bso10833201fa.1;
        Fri, 16 Feb 2024 10:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708108801; x=1708713601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=78yCkR98MtM+p4wYvsxZI+i3GmUiyMdPBkkAbm+jo8c=;
        b=ZBksYlYqd0qX38Ohl63ZfywnHOxEVFKtzXVffHLhTQ4g+1iZyCfcwl6iYlzMUIbpi8
         E5y0IhgRIAy2ashQkIFhP2UmCo4kJF3W7Q0mcfoVAFwhosL6CnW5QlN4zBFY3HZ41gpq
         wVHsMHV5l0ypYViGffoRgmHtjqWAV+zihMcS99scjjRfLxnOD+uls16qi6JrMh6zHa8f
         OdJE6uLW7pngQg3HZ6aK0AC7UpMz0Thj+7wr4/8aTmb7VqiCjkkpU+Iw6qOQXvHMvV28
         0n/kFnK1ZEPa1elqjpau2YJY3XFHVXMKTjmMEApemQwxbjbSLWSRmq8ZsFjb950VP2dT
         n4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708108801; x=1708713601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78yCkR98MtM+p4wYvsxZI+i3GmUiyMdPBkkAbm+jo8c=;
        b=TzUt1ffT1eTEZ+KSWRJnZ397wZlBx5dq8OmWzqXdrBwPQzd1Ea1ho2NGlCw64Vdxa6
         jEkjiiIxLmYpn4OujZ5Ny8edGZZyU4kt87d/Re8oxUd821SJ7QEKGomTOzTa159iVYuj
         Llo/v2eeu38aT80y792qJSvoo2MIl2cfYwtJpOA23jOdSvFddXxOsKs6/RKnADwW8eIc
         RdbsRWUCF5YE6v73qOQrCwDJeuO6EBiGNiRWfcL/0PoI793h2SpZnsfV9+IXRPrccZb8
         glB5XNlQuB7FU9x5ZX5rtk/Hnzid/56bLiJMr8ni8lTzYifyMqqvufr2b7nOMN2wnblo
         VS3w==
X-Forwarded-Encrypted: i=1; AJvYcCW3sQNTguPEXn2YuekWPJwFekgK07yiat8ehvr8sCiC7G1B0aZ/3C5DS4Otbpkb26VzroCd4oQERZVSYm8oTs1cceFs9/ut8fjOgXiDN/qwXaFV1yGN3RJYc9tOc7vkfX1h4NNb
X-Gm-Message-State: AOJu0YzuOnYg9cQSz/TKOHfYJuHZ8+j4wrxzY8BTq63jm9Wakxza91ti
	CUqCbBVZFg2QkTKWSZZ2a7SSqybVkyXEzwxg/1YCkVBkXfR0bzpekqQJaBvK9/o=
X-Google-Smtp-Source: AGHT+IEvHkxvQ6cNkCmZuYs+2CZMXFD63NlZarr3kAV6W5xtYY+lZFIlRQZFKvqM4Pp1UmjhNiMPnA==
X-Received: by 2002:ac2:5197:0:b0:512:851d:82c5 with SMTP id u23-20020ac25197000000b00512851d82c5mr3905235lfi.0.1708108800548;
        Fri, 16 Feb 2024 10:40:00 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id x8-20020ac24888000000b005129e5d7f11sm39651lfc.125.2024.02.16.10.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:40:00 -0800 (PST)
Date: Fri, 16 Feb 2024 21:39:57 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Pavel Sakharov <p.sakharov@ispras.ru>
Cc: Simon Horman <horms@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, 
	Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: Re: [PATCH net v2] net: stmmac: Fix incorrect dereference in
 interrupt handlers
Message-ID: <52l2oudptsknq7tkorvz6o3h2t2gzstkk34oorks3eul5k22br@kqm674m5cwyy>
References: <20240206150704.GD1104779@kernel.org>
 <20240214092718.331891-1-p.sakharov@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214092718.331891-1-p.sakharov@ispras.ru>

On Wed, Feb 14, 2024 at 12:27:17PM +0300, Pavel Sakharov wrote:
> If 'dev' or 'data' is NULL, the 'priv' variable has an incorrect address
> when dereferencing calling netdev_err().
> 
> Since we get as 'dev_id' or 'data' what was passed as the 'dev' argument
> to request_irq() during interrupt initialization (that is, the net_device
> and rx/tx queue pointers initialized at the time of the call) and since
> there are usually no checks for the 'dev_id' argument in such handlers
> in other drivers, remove these checks from the handlers in stmmac driver.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

LGTM. Thanks!

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Fixes: 8532f613bc78 ("net: stmmac: introduce MSI Interrupt routines for mac, safety, RX & TX")
> Signed-off-by: Pavel Sakharov <p.sakharov@ispras.ru>
> ---
> v2: Drop the second argument checks in the handlers as suggested by Serge Semin <fancer.lancer@gmail.com>.
> 
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 20 -------------------
>  1 file changed, 20 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 75d029704503..e80d77bd9f1f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -6059,11 +6059,6 @@ static irqreturn_t stmmac_mac_interrupt(int irq, void *dev_id)
>  	struct net_device *dev = (struct net_device *)dev_id;
>  	struct stmmac_priv *priv = netdev_priv(dev);
>  
> -	if (unlikely(!dev)) {
> -		netdev_err(priv->dev, "%s: invalid dev pointer\n", __func__);
> -		return IRQ_NONE;
> -	}
> -
>  	/* Check if adapter is up */
>  	if (test_bit(STMMAC_DOWN, &priv->state))
>  		return IRQ_HANDLED;
> @@ -6079,11 +6074,6 @@ static irqreturn_t stmmac_safety_interrupt(int irq, void *dev_id)
>  	struct net_device *dev = (struct net_device *)dev_id;
>  	struct stmmac_priv *priv = netdev_priv(dev);
>  
> -	if (unlikely(!dev)) {
> -		netdev_err(priv->dev, "%s: invalid dev pointer\n", __func__);
> -		return IRQ_NONE;
> -	}
> -
>  	/* Check if adapter is up */
>  	if (test_bit(STMMAC_DOWN, &priv->state))
>  		return IRQ_HANDLED;
> @@ -6105,11 +6095,6 @@ static irqreturn_t stmmac_msi_intr_tx(int irq, void *data)
>  	dma_conf = container_of(tx_q, struct stmmac_dma_conf, tx_queue[chan]);
>  	priv = container_of(dma_conf, struct stmmac_priv, dma_conf);
>  
> -	if (unlikely(!data)) {
> -		netdev_err(priv->dev, "%s: invalid dev pointer\n", __func__);
> -		return IRQ_NONE;
> -	}
> -
>  	/* Check if adapter is up */
>  	if (test_bit(STMMAC_DOWN, &priv->state))
>  		return IRQ_HANDLED;
> @@ -6136,11 +6121,6 @@ static irqreturn_t stmmac_msi_intr_rx(int irq, void *data)
>  	dma_conf = container_of(rx_q, struct stmmac_dma_conf, rx_queue[chan]);
>  	priv = container_of(dma_conf, struct stmmac_priv, dma_conf);
>  
> -	if (unlikely(!data)) {
> -		netdev_err(priv->dev, "%s: invalid dev pointer\n", __func__);
> -		return IRQ_NONE;
> -	}
> -
>  	/* Check if adapter is up */
>  	if (test_bit(STMMAC_DOWN, &priv->state))
>  		return IRQ_HANDLED;
> -- 
> 2.43.0
> 

