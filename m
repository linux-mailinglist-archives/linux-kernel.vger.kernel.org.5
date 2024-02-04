Return-Path: <linux-kernel+bounces-51841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 274B0848FE5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 19:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A4791C21163
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 18:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6C124A0F;
	Sun,  4 Feb 2024 18:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/eAUi8v"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60109249EA;
	Sun,  4 Feb 2024 18:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707071064; cv=none; b=dwCgYJw3tchY8ehDuItOXx6k3L3aOk0RNAGhbOKjo5BNa3dFUJ0vGv9JAMksza7fyStfcB4LJ5eHuY5yfanTh5Cp7Hg1Y+F0j4RFycjPL5B5WwfS9LsnR29bXMhWP1h0trwJpaePFHhBODzIYYtdbXKGVX3NUBruZss7o0CXGIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707071064; c=relaxed/simple;
	bh=1WR+U8Jp/2d0Ltne3o8Z3XtZJ45PE2C5pj/yv5w5UZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CK9Z1X9DmOh4dwp0rJBCbACfjm45jOmNirnM3VaG4wRjxEbhqWFVBFYlmrDatOo5Em8FYA439rHQ3ONcjhgsXH6gd13sYg+8DAKjO3JqkwgSBXi73nC+s0mQk/yYh0H9xjADjb5+k8DKM/Y74Y4ecZZHUk9yIzZhtV+RBpnECQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/eAUi8v; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a370328e8b8so288517466b.3;
        Sun, 04 Feb 2024 10:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707071060; x=1707675860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hZdlkqzLPaHnE194T7Y8rNFin3HCPquSoKmGOrKBkyA=;
        b=a/eAUi8vFCfvBgIzOQNXyrrN0hD51KN+CKI/RoevDK3tUoN1p40vOgztEzii8pU3z2
         A0PlFJi2G7Dpw5dxfkvXyzKUvsyp9+S+R0zr/yfT1zDAe6kk32PLlXHCm83lRppCMehk
         MmQ7ffvj2V6pL9He3WtMvTqXo4mxB7w4pjSONNS6ktNquk5Bs013isBeOJAPgYoFL2fX
         JFPTJ/mo8bt68RZg2LpZD+vt8LP6IqGRCammznCSYVTwclvkmEpIPVn7Evj4iWbR7rbh
         ji/4iJftPp5teIt/t6PEn3P1kV7rhMCuG28RLT3NmMnKAeXSb449X2TENIjHiJBfOMRv
         NLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707071060; x=1707675860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZdlkqzLPaHnE194T7Y8rNFin3HCPquSoKmGOrKBkyA=;
        b=YkG0CYDCvJF5EWO+zB4BRp8xb1/1/cq/DgBjq51Xs2yQ/SZJixFgeV72+ldBSdfG5N
         Rb4Qrj8R/iPox7MtuaDIoLw3DTafNvUGyBK1JbOJH/23m7Ao4qQLDKT3/uU45lbZzOI8
         r5F4RfMcWRX3+xLo3qVV55UdXMclnv2pq30A2j2oN44AWDoH55gMHbS0UrRoQ/LkhpX+
         EeLKBMJ8KYf6aaz0rdOnG3LuzOdouGLOANEDelaH8yzue4vi3n5EDxFnIM0JOf3DnAlL
         hDyfMz4cOxXF6rxWQhpZY9xKKjjz3ekF6VGB2FpY6/N8R1jB5nGDkuMIKIly9u44q9nM
         wvzA==
X-Gm-Message-State: AOJu0YxfKBohrLxM2+QUG60AvElx+1mzKP9//eW1hRZa1bYFmf+2IQnQ
	aWxlWWxxjZNP9dL/d/kOmmefb8VYv+Dr6LShZ5ml54js7+5zIqzfZ2ka5RnTIMg=
X-Google-Smtp-Source: AGHT+IGWIYRKHxR9TZX9UEm5hhY8zAldRusE/133F+X0x1lzAgY3NQd/IejfrcCcnuXOI6X8iVDL6w==
X-Received: by 2002:a17:906:15d8:b0:a31:f7e:8a53 with SMTP id l24-20020a17090615d800b00a310f7e8a53mr5760953ejd.26.1707071059999;
        Sun, 04 Feb 2024 10:24:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVnKjaM80QjNCR+0rlKzGF5WUrnYaVdbDBmzxpMOMv1krU14TmouzxEa/18L2Dt2fVRRhh+WrZBdRFdbDedW3nPTi30kYM/V64pmfZ2eXdTacY2b/8FQ8QFNHQyJVabs1CGuRM7T4SxgiTg+8ePppK6ZLMUCR9TUC9bjA==
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id ty13-20020a170907c70d00b00a3715be38c4sm2954174ejc.210.2024.02.04.10.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 10:24:19 -0800 (PST)
Date: Sun, 4 Feb 2024 20:24:17 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: andy.shevchenko@gmail.com
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Minjie Du <duminjie@vivo.com>
Subject: Re: [PATCH v1 1/1] spi: fsl-dspi: Unify error messaging in
 dspi_request_dma()
Message-ID: <20240204182417.jnw4iuqgghxynq3v@skbuf>
References: <20240204162106.1179621-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204162106.1179621-1-andy.shevchenko@gmail.com>

On Sun, Feb 04, 2024 at 06:21:06PM +0200, andy.shevchenko@gmail.com wrote:
> Use `ret = dev_err_probe(...);` pattern for all messages in dspi_request_dma()
> for the sake of uniforming them. While at it, fix indentation issue reported
> by Vladimir Oltean.

When did I do that? This is v1.

> 
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/spi/spi-fsl-dspi.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index c9eae046f66c..e0832f1f10bd 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -502,15 +502,12 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
>  		return -ENOMEM;
>  
>  	dma->chan_rx = dma_request_chan(dev, "rx");
> -	if (IS_ERR(dma->chan_rx)) {
> -		return dev_err_probe(dev, PTR_ERR(dma->chan_rx),
> -			"rx dma channel not available\n");
> -	}
> +	if (IS_ERR(dma->chan_rx))
> +		return dev_err_probe(dev, PTR_ERR(dma->chan_rx), "rx dma channel not available\n");
>  
>  	dma->chan_tx = dma_request_chan(dev, "tx");
>  	if (IS_ERR(dma->chan_tx)) {
> -		ret = PTR_ERR(dma->chan_tx);
> -		dev_err_probe(dev, ret, "tx dma channel not available\n");
> +		ret = dev_err_probe(dev, PTR_ERR(dma->chan_tx), "tx dma channel not available\n");
>  		goto err_tx_channel;
>  	}
>  
> @@ -541,16 +538,14 @@ static int dspi_request_dma(struct fsl_dspi *dspi, phys_addr_t phy_addr)
>  	cfg.direction = DMA_DEV_TO_MEM;
>  	ret = dmaengine_slave_config(dma->chan_rx, &cfg);
>  	if (ret) {
> -		dev_err(dev, "can't configure rx dma channel\n");
> -		ret = -EINVAL;
> +		ret = dev_err_probe(dev, -EINVAL, "can't configure rx dma channel\n");

Passing -EINVAL to dev_err_probe() here doesn't work. It overwrites the "ret"
from dmaengine_slave_config().

int dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
{
	struct va_format vaf;
	va_list args;

	va_start(args, fmt);
	vaf.fmt = fmt;
	vaf.va = &args;

	if (err != -EPROBE_DEFER) { // <-------- always true
		dev_err(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
	} else {
		device_set_deferred_probe_reason(dev, &vaf);
		dev_dbg(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
	}

	va_end(args);

	return err;
}

>  		goto err_slave_config;
>  	}
>  
>  	cfg.direction = DMA_MEM_TO_DEV;
>  	ret = dmaengine_slave_config(dma->chan_tx, &cfg);
>  	if (ret) {
> -		dev_err(dev, "can't configure tx dma channel\n");
> -		ret = -EINVAL;
> +		ret = dev_err_probe(dev, -EINVAL, "can't configure tx dma channel\n");

Same here.

>  		goto err_slave_config;
>  	}
>  
> -- 
> 2.43.0
> 
> 

