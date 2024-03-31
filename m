Return-Path: <linux-kernel+bounces-125991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 518F1892F02
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 10:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5E7C1F2171D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 08:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BF08BE7;
	Sun, 31 Mar 2024 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QDlQrJbB"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D2E17FD;
	Sun, 31 Mar 2024 08:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711874109; cv=none; b=Xd/ukMcdqqB2Hr1jDEGVoaOnOjdtNyKGxMEt5w6P05czVvIALJoLXPjEQ+NlflPn+qIq92pLtt2OJk/kCAEwAjLdvnDC2guZv0MwzfrApg0lxz3dGjCoYgWNWvCaYfi+GXuByQ6t+4EvRMz7vGtdnY9K/EpxGYPjG+sfJd/Ghd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711874109; c=relaxed/simple;
	bh=FU1iUMK1xEoF4Bl2waDD/jKVQRep5KrFZ997RuWZlbA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rDb3OxkMjJDjaWPjxROY4A+TxmkhcwYbzahpJaxxI7zdBF+5XetCDzsRyZbtF9k+qUO2kk3xP3V7xJEUxjWzlQDs00us36LiOI8b/PjnTZkVkjzDP7YMwDfeUFYDV044XBHtYUuigXDD4LltbHhBAfpp+KS9FbfS1w4XmZuHpwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QDlQrJbB; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CDE87FF802;
	Sun, 31 Mar 2024 08:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711874099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bkZCTZa2SatyGqLS+NTU0GDbJQ+zI3N+D0QKibBZfFo=;
	b=QDlQrJbB2rfbs4C1sU9IDLdaWQ07Bwzdr9P4B5RCC+MWQIfcjVBaFGtDuBHlw0Dnmdc8iB
	qZFFdLSLc8dlSfJR9Xwkb5vLq4l37Lu4sDOycMhDCjE/ANGx8jXtnirdOd60VPGdJP1i9y
	KWZY7shJ0cUKpD1Hc1FpmWk5JMXFawMxeIhWPE/3wIVCQ8AVym5wGmRiVfMZwwwkwVU8z4
	ftsot8rUb4bMoRVoYTuGKJkASlmJCri07zpmxPFP3h1NpijrAM2k4q+HLh2aXeWYC4vsH5
	vGJf+6vwi54D5xqpg6hc2+CeFSc3dLitXSb/uQkZIlPKbpuoTsFCaV0Z93GWfg==
Date: Sun, 31 Mar 2024 10:35:32 +0200 (CEST)
From: Romain Gantois <romain.gantois@bootlin.com>
To: Cathy Cai <cathy.cai@unisoc.com>
cc: cathycai0714@gmail.com, davem@davemloft.net, edumazet@google.com, 
    kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com, 
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
    xuewen.yan94@gmail.com, cixi.geng1@unisoc.com, wade.shu@unisoc.com, 
    zhiguo.niu@unisoc.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
    linux-stm32@st-md-mailman.stormreply.com, 
    linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] net: stmmac: Fix the problem about interrupt storm
In-Reply-To: <20240327110142.159851-1-cathy.cai@unisoc.com>
Message-ID: <d1da7fdb-10f6-7f69-4820-520469c0193c@bootlin.com>
References: <20240327110142.159851-1-cathy.cai@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com

Hello Cathy,

On Wed, 27 Mar 2024, Cathy Cai wrote:

> Tx queue time out then reset adapter. When reset the adapter, stmmac driver
> sets the state to STMMAC_DOWN and calls dev_close() function. If an interrupt
> is triggered at this instant after setting state to STMMAC_DOWN, before the
> dev_close() call.
> 
..
> -	set_bit(STMMAC_DOWN, &priv->state);
>  	dev_close(priv->dev);
> +	set_bit(STMMAC_DOWN, &priv->state);
>  	dev_open(priv->dev, NULL);
>  	clear_bit(STMMAC_DOWN, &priv->state);
>  	clear_bit(STMMAC_RESETING, &priv->state);

If this IRQ issue can happen whenever STMMAC_DOWN is set while the net device is 
open, then it could also happen between the dev_open() and 
clear_bit(STMMAC_DOWN) calls right? So you'd have to clear STMMAC_DOWN before 
calling dev_open() but then I don't see the usefulness of setting STMMAC_DOWN 
and clearing it immediately. Maybe closing and opening the net device should be 
enough?

Moreover, it seems strange to me that stmmac_interrupt() unconditionnally 
ignores interrupts when the driver is in STMMAC_DOWN state. This seems like 
dangerous behaviour, since it could cause IRQ storm issues whenever something 
in the driver sets this state. I'm not too familiar with the interrupt handling 
in this driver, but maybe stmmac_interrupt() could clear interrupts 
unconditionnally in the STMMAC_DOWN state?

Best Regards,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

