Return-Path: <linux-kernel+bounces-36549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F86883A2F2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F88428928D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA3A168D0;
	Wed, 24 Jan 2024 07:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hg+uUpCP"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CBF16429;
	Wed, 24 Jan 2024 07:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706081453; cv=none; b=IRxKkPTGY15lrPOQxIzrHCOFwPOhmbo9qyWecY9ItDVx4ffsdIviA+DG+EoZC7A+MxHaVZDmHRSrRlXjFh9MuKABmalIM053TAY/XEtzImlPnJb76Gx8E5qbyHAuz+U2lQb2evja2jU1DiJe9lX3jj8V90iuVb+tk8XdpHo7qUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706081453; c=relaxed/simple;
	bh=zcuTBnSpR8a5t/QEYSRtGuCgQG6oo8zB7awoq0F0Efg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=leE8y0X0X3wr2tF1wk31WsvKa10oR4i4VJg1whtgrpNMmdVf4lbx2o7HH74ULF8tnh6TwSxsagrh6nQMFZPkb1Ff5WzY4AH+1wOjcgikZ9NsF7n52nYBnOdHtoccutLDkz+u+oY1WCkcTQNZ1GSD18fK8aeoakHo5bTizjJyGtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hg+uUpCP; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e80046264so64802155e9.0;
        Tue, 23 Jan 2024 23:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706081450; x=1706686250; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3q1o6aAekTHAGtHaTxP4kjBlXWWUej4AyBNrNnh309M=;
        b=Hg+uUpCPOF+2+QtvsauJnKFCxRX56WPMIrLJX4oo7wUbRJemdGUrSJqK/ReDAUZGjI
         QsFEQaY+WkP8zVW35MuTxlPeEqs9efzy3SsEjJsW0FDNp9AQbneRF5pAeP8V1TQ0hyNo
         CxVhvszF4JkzwGUWa0uDZeegx1f/rErq/2mCvuQWvdN509IdP1+MhQXtcN6KKQQybRJY
         aJu/Gkgo2h8dK7p6M21DiDF5dUY7GrBSXKIG/r6YRIpFtWXq6pNQUoiuvDwKA6knkaS8
         CSvkKQHJ9SpdkenYuVwC/khNMCvw4sHJRKUHEkPNn3PYm5huDhHHjO8G9YMGu4ytDlCx
         St3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706081450; x=1706686250;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3q1o6aAekTHAGtHaTxP4kjBlXWWUej4AyBNrNnh309M=;
        b=BuA1girzLuB6rIvBPmhNqgGVxf2KnWs6Eni2udCYNuoQGJ9NkF8o6ZCl9nLWtXkkhC
         X2VDKb+0OFgHCBYxZ8mwJ1Zec2PgY5L0H3qTNIOP08oaOlhT4bE8OgRXD6dRTVAbH7GR
         mijskF/Gnip0/jpMvqOKj4GulCCbquoEa63zwopIFtMoKdilBrkjDyzfwYhVrFWAAY9n
         4iv9o7vB/ZJClP/VVhHLwHCKs4+hOXJToV4UoF7LuZNuogz15dqNv+w9ZN43XpPMUpFI
         l4g71fsADbYR1pAx55EF5EAu6wzLZKSTO5+QyWDe8fnBWocRO7B36XTQDt7eCzhppxba
         32wQ==
X-Gm-Message-State: AOJu0YyfAwSZbgR7EbBOCw4WJbJwxxAOEaS4znfkw5kUg9Az7jNV+VX+
	pbYohlcbOJgDwdVZ9oe1csCZfyuhrD28K9nasneA2PEUUPkU9IGk
X-Google-Smtp-Source: AGHT+IFgs85NIjlXfM9SBtUmGybQ1WPXBV4OIlQceBFmgtfQOL0aW4ydBfYNlu7dBZ7BJKo1rSz6Hw==
X-Received: by 2002:a05:600c:4514:b0:40e:4a58:2a85 with SMTP id t20-20020a05600c451400b0040e4a582a85mr853492wmo.99.1706081450216;
        Tue, 23 Jan 2024 23:30:50 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id ek15-20020a05600c3ecf00b0040e8e358f82sm21572528wmb.19.2024.01.23.23.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 23:30:50 -0800 (PST)
Date: Wed, 24 Jan 2024 08:30:48 +0100
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: neil.armstrong@linaro.org, clabbe@baylibre.com,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, khilman@baylibre.com, jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com, linux-crypto@vger.kernel.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@salutedevices.com
Subject: Re: [PATCH v2 03/20] drviers: crypto: meson: add platform data
Message-ID: <ZbC8qLXogjxJD8LD@Red>
References: <20240123165831.970023-1-avromanov@salutedevices.com>
 <20240123165831.970023-4-avromanov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240123165831.970023-4-avromanov@salutedevices.com>

Le Tue, Jan 23, 2024 at 07:58:14PM +0300, Alexey Romanov a écrit :
> To support other Amlogic SoC's we have to
> use platform data: descriptors and status registers
> offsets are individual for each SoC series.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  drivers/crypto/amlogic/amlogic-gxl-cipher.c |  2 +-
>  drivers/crypto/amlogic/amlogic-gxl-core.c   | 31 +++++++++++++++------
>  drivers/crypto/amlogic/amlogic-gxl.h        | 11 ++++++++
>  3 files changed, 35 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/crypto/amlogic/amlogic-gxl-cipher.c b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> index b19032f92415..7eff3ae7356f 100644
> --- a/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> +++ b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> @@ -225,7 +225,7 @@ static int meson_cipher(struct skcipher_request *areq)
>  
>  	reinit_completion(&mc->chanlist[flow].complete);
>  	mc->chanlist[flow].status = 0;
> -	writel(mc->chanlist[flow].t_phy | 2, mc->base + (flow << 2));
> +	writel(mc->chanlist[flow].t_phy | 2, mc->base + ((mc->pdata->descs_reg + flow) << 2));
>  	wait_for_completion_interruptible_timeout(&mc->chanlist[flow].complete,
>  						  msecs_to_jiffies(500));
>  	if (mc->chanlist[flow].status == 0) {
> diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
> index a58644be76e9..2be381e157c4 100644
> --- a/drivers/crypto/amlogic/amlogic-gxl-core.c
> +++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
> @@ -18,6 +18,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  
>  #include "amlogic-gxl.h"
> @@ -30,9 +31,10 @@ static irqreturn_t meson_irq_handler(int irq, void *data)
>  
>  	for (flow = 0; flow < mc->flow_cnt; flow++) {
>  		if (mc->chanlist[flow].irq == irq) {
> -			p = readl(mc->base + ((0x04 + flow) << 2));
> +			p = readl(mc->base + ((mc->pdata->status_reg + flow) << 2));
>  			if (p) {
> -				writel_relaxed(0xF, mc->base + ((0x4 + flow) << 2));
> +				writel_relaxed(0xF, mc->base +
> +					      ((mc->pdata->status_reg + flow) << 2));
>  				mc->chanlist[flow].status = 1;
>  				complete(&mc->chanlist[flow].complete);
>  				return IRQ_HANDLED;
> @@ -245,15 +247,34 @@ static void meson_unregister_algs(struct meson_dev *mc)
>  	}
>  }
>  
> +static const struct meson_pdata meson_gxl_pdata = {
> +	.descs_reg = 0x0,
> +	.status_reg = 0x4,
> +};
> +
> +static const struct of_device_id meson_crypto_of_match_table[] = {
> +	{
> +		.compatible = "amlogic,gxl-crypto",
> +		.data = &meson_gxl_pdata,
> +	},
> +	{},
> +};
> +
>  static int meson_crypto_probe(struct platform_device *pdev)
>  {
> +	const struct of_device_id *match;
>  	struct meson_dev *mc;
>  	int err;
>  
> +	match = of_match_device(meson_crypto_of_match_table, &pdev->dev);
> +	if (!match)
> +		return -EINVAL;
> +
>  	mc = devm_kzalloc(&pdev->dev, sizeof(*mc), GFP_KERNEL);
>  	if (!mc)
>  		return -ENOMEM;
>  
> +	mc->pdata = match->data;
>  	mc->dev = &pdev->dev;
>  	platform_set_drvdata(pdev, mc);
>  
> @@ -312,12 +333,6 @@ static void meson_crypto_remove(struct platform_device *pdev)
>  	clk_disable_unprepare(mc->busclk);
>  }
>  
> -static const struct of_device_id meson_crypto_of_match_table[] = {
> -	{ .compatible = "amlogic,gxl-crypto", },
> -	{}
> -};
> -MODULE_DEVICE_TABLE(of, meson_crypto_of_match_table);

Hello

This patch breaks bisection, since it removes MODULE_DEVICE_TABLE.
After applying patchs 1,2,3 the driver does not load anymore on lepotato board.

Regards

