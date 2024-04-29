Return-Path: <linux-kernel+bounces-162565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE6B8B5D6F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE47282312
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E2A86279;
	Mon, 29 Apr 2024 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsswpeGO"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ED88172A;
	Mon, 29 Apr 2024 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714404021; cv=none; b=eR0lPHkGr+DFZ8DpVyjCsenkSJE0rXPePoT7tSVwMPh1T8e5a/mzoQWtc/TW+rjOymHFge7MQ9FbVRjnox1oqga1GnpQwoyZguRRE66vB2tBoRvjyRfnskWxchYPyYa731H+BcoYUjNXU8nhaZm8f9MfdEqkb/0H3oMrIjSP+HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714404021; c=relaxed/simple;
	bh=GNdq7quKix1GhDkO/nl+wtPP19OpIPRbiguVR/qjUAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TRwx1uJlfMs/OTZbCB35ZVRW9t5QSLcETsox2SaQlcfRnzoW5R5/2sR5zLCFvjIOAdKfICchAt4cyLy5jueGPpH8ELWpDzcoExdrdHSk+3EeWXkneRZQbkeFAIlQDOznuSDs4d6MvJGfZrHXDIj+szM1zSDhgt4LI4zPypt7Ou0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsswpeGO; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a51addddbd4so505337566b.0;
        Mon, 29 Apr 2024 08:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714404016; x=1715008816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xestw1QNtEj/9cyE5NFVKambADQI6O/71HDnKGCInV8=;
        b=dsswpeGOvbMx3eL5KbdfYMR5Gr1KQE06DcsNXXfzPz5Og7EUoG3T6rYHEmPg+LAzYP
         i1IjmBBEM4EByvXjKjd1e8bQ2oLkXbpOY/2rCO8eTK+ko/KKUw/pCmtB2FiUlz363Pp7
         i/nVMCQyvG76F4iGkaF4MnjyGNHPflbJV5G14CFi0JQOzRXNgnb+cUDkWvYkAyFDb0PL
         TMqAJQMA5CkevHh38aqXEm5/rXiS5uxJf82LijotLDcFTQA81Nfv69QT7Fr2iRcRQeFw
         zrWwAYv6xZijIoJBwlZLThX6ar/0MqhGgL9DEirrZxflS9C6UpKhiBigckdbOCb/6Mbv
         xZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714404016; x=1715008816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xestw1QNtEj/9cyE5NFVKambADQI6O/71HDnKGCInV8=;
        b=v4DZXMdrMJlpCVGpT961tngtzQMIshNnpLMdgZ3IEWDH0gdf9YVfjSYGpkMkz2Zn+t
         wf0D8Y10I0OoK0gQ6ea0p9smDyLo2daDepwdewJv0TrtojGHAgebTmzJCiujuv3/dxXU
         1YTXNMlsbJ9WLoHNFUPYJ37oDAu2NdZpcvMm6VbKQh6kZ9LfxOb/bomfWRYw/+hIjfdJ
         cEoVFeme8uiLXr2fDmpSxxP+8U/gIkgyAa0pVuOL6X1v8jni/9w0CLgUq22TiEDOPJFE
         waAK8IP9xWaHBAg0a+xYrEo9l/VKgBPxKF86Uua4ZOl5Bq0PnRD/B/+JSwXR3tAJck+4
         91SQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsCxp2VOZAKSmH90KY8b12ZoEMc1QEmjuvzemkXbN1xV/KSwHGRVFmcUNSYSanGuEdt813LRhXpOrdqSqEACCmuZM2oxSWxhTFoMsH
X-Gm-Message-State: AOJu0Yyx8Q98FHBJkaER7A1Wu6W6ljdmztYlVn7hy1CDv7DudAzRgaDn
	XokZAkO8jWIBmqw0T7USaZPYIA9yV0vQ8SKBOJo4bTwkSyFmzCsndkZO9Wr/
X-Google-Smtp-Source: AGHT+IFv2yQ+ISFsWoxWBWHT/F9qtbk97DzSDaqfb1LCDyJmZc2vAJwQngftmAeom2YpKJaF4blgng==
X-Received: by 2002:a17:906:f9d6:b0:a58:f186:192 with SMTP id lj22-20020a170906f9d600b00a58f1860192mr3955858ejb.0.1714404016298;
        Mon, 29 Apr 2024 08:20:16 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id s8-20020a170906500800b00a4e24d259edsm13916302ejj.167.2024.04.29.08.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:20:16 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-spi@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 7/8] spi: sun6i: use 'time_left' variable with
 wait_for_completion_timeout()
Date: Mon, 29 Apr 2024 17:20:14 +0200
Message-ID: <4885599.GXAFRqVoOG@jernej-laptop>
In-Reply-To: <20240429112843.67628-8-wsa+renesas@sang-engineering.com>
References:
 <20240429112843.67628-1-wsa+renesas@sang-engineering.com>
 <20240429112843.67628-8-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne ponedeljek, 29. april 2024 ob 13:28:40 GMT +2 je Wolfram Sang napisal(a):
> There is a confusing pattern in the kernel to use a variable named 'timeout' to
> store the result of wait_for_completion_timeout() causing patterns like:
> 
> 	timeout = wait_for_completion_timeout(...)
> 	if (!timeout) return -ETIMEDOUT;
> 
> with all kinds of permutations. Use 'time_left' as a variable to make the code
> self explaining.
> 
> Fix to the proper variable type 'unsigned long' while here.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/spi/spi-sun6i.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> index cd018ea1abf1..7bbe7ea0d66a 100644
> --- a/drivers/spi/spi-sun6i.c
> +++ b/drivers/spi/spi-sun6i.c
> @@ -277,7 +277,8 @@ static int sun6i_spi_transfer_one(struct spi_controller *host,
>  				  struct spi_transfer *tfr)
>  {
>  	struct sun6i_spi *sspi = spi_controller_get_devdata(host);
> -	unsigned int div, div_cdr1, div_cdr2, timeout;
> +	unsigned int div, div_cdr1, div_cdr2;
> +	unsigned long time_left;
>  	unsigned int start, end, tx_time;
>  	unsigned int trig_level;
>  	unsigned int tx_len = 0, rx_len = 0, nbits = 0;
> @@ -488,26 +489,26 @@ static int sun6i_spi_transfer_one(struct spi_controller *host,
>  
>  	tx_time = spi_controller_xfer_timeout(host, tfr);
>  	start = jiffies;
> -	timeout = wait_for_completion_timeout(&sspi->done,
> -					      msecs_to_jiffies(tx_time));
> +	time_left = wait_for_completion_timeout(&sspi->done,
> +						msecs_to_jiffies(tx_time));
>  
>  	if (!use_dma) {
>  		sun6i_spi_drain_fifo(sspi);
>  	} else {
> -		if (timeout && rx_len) {
> +		if (time_left && rx_len) {
>  			/*
>  			 * Even though RX on the peripheral side has finished
>  			 * RX DMA might still be in flight
>  			 */
> -			timeout = wait_for_completion_timeout(&sspi->dma_rx_done,
> -							      timeout);
> -			if (!timeout)
> +			time_left = wait_for_completion_timeout(&sspi->dma_rx_done,
> +							      time_left);
> +			if (!time_left)
>  				dev_warn(&host->dev, "RX DMA timeout\n");
>  		}
>  	}
>  
>  	end = jiffies;
> -	if (!timeout) {
> +	if (!time_left) {
>  		dev_warn(&host->dev,
>  			 "%s: timeout transferring %u bytes@%iHz for %i(%i)ms",
>  			 dev_name(&spi->dev), tfr->len, tfr->speed_hz,
> 





