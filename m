Return-Path: <linux-kernel+bounces-146436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1553E8A653C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 392941C21831
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCBF84D3C;
	Tue, 16 Apr 2024 07:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b9+WlSdS"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6923D71B50
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 07:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713253043; cv=none; b=nmWI6JZQt8aKF/ot590ozgeMEbyy7WjBxFm57zHq4ZTkUxjAdVybU0+f4LPAyhEz4YEstYmGkCzaTwNug335CPk5s8D+QOtsFaB4VuMfOzKzzqK7MF6kqdqA27wlEOd2ejNBryRI3bs/nk19Fk6vd2jiBKeMsHzzp2Tpy9HBV8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713253043; c=relaxed/simple;
	bh=BIpOJSTxOK0JfNqFwhleSJ0Efyt0sHPGszihSmkHs2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y40M+CWQf1oe6euKdU68vlrgXUDILpMXEqCTWv/Hn+gC925PenoYfl7RDDpHphlyTr5KLPaPy6EoS8WKH7jy9CATAjQvVVf+8P/2NPBgWEtQcoqkYfxOjj7mGCGpEbdKYz6d0ohkMggmN7zKJ5DQ0Ab/BsX5pQksc6JglS/H8YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b9+WlSdS; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a51a1c8d931so516666266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 00:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713253039; x=1713857839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vz5EFUG61C/PsBsUPlDK2q+AUqaXZYNi38q3WlwiS3E=;
        b=b9+WlSdSiA5XyauSwQE5H9UMIrdQO+qgy9vXhMooxlkNWj7lPNWRENP1vRvJTZ48Jv
         Cmz3hPo4dfQoMFwERWiBfSnjJGHOf1O41S/J7g/ExXuusCXjX85bP8l1CfojFRt080Q+
         Ebt18aRnezj5aZdTWSNNjdALJ97ZEO3hyXgqBJx9CwbgU1TxaTBFw9YySmRzVCXtz4lG
         ye9WtUzkRUFrAJjYUnTAXeSH+VnbhKKwZ4Z0+QM7cRMj9DiehaeGohhS8IB1DTtIxf9l
         rBH5F9j2PkVWOUDer8bH+oKBql3Vc0AyQH7Yq2qg9aztgmQ8nluh0roA5IGZN8dBWW2Y
         iAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713253039; x=1713857839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vz5EFUG61C/PsBsUPlDK2q+AUqaXZYNi38q3WlwiS3E=;
        b=etjJYf+Gh3OYytbn5JExvGrB1oSxgWM4T0Iu9440kd7HuYIpJSC/DDPh0EJsTE2S5R
         GW7TTgDhBcn64b+zPbmDVAb+TPcOS7mWlMYsuy7x/4f33bjxlwmmGbo5b54e0X5elwMU
         NE1p9ED8ppkPDf7QAtA7Hv8P4TSgKmzyTHAV3xsC8LAz74FLK7GB/NdvRm8j00dxtnYX
         /7nxTYEb+yrkdm9YiKyyBaIYLnpn/V8HRG5YtpeOTWCKxN0gI9PtjouvFkiebg7C4/UK
         ZAacIN+1tKFqV4paT7uEBhXp6qfHgPoYA9v49dHBr4aIQNjzOw9X5xRra3CK8V+diNlH
         nYaA==
X-Forwarded-Encrypted: i=1; AJvYcCVeN7pn0dU09pvoME8v5vGqO4dO5l59DdgxO2jpvD60U0ij4HWdxC41qYmDKw7eGdSgb/pl0fo5+gwTNnwfWm4ZAY8ZqQ52qqG9Strz
X-Gm-Message-State: AOJu0YwEuGtULObOMBw0P/NThsoywdKmIy5xKRI0DkVMAu+x4WhRF0nc
	LLi2JS4Jrfqter988u3Cb7ArMfRuJA3Nws8X8D7i09reA/k1ArJHhcXWGPak3Vk=
X-Google-Smtp-Source: AGHT+IF7djK9Gp7QvHWuOZzhp3iyt4a4kh6gE+5Chee7fTPBiXusYHzH5iP8LrBy89Sq7/Zoad7L6g==
X-Received: by 2002:a17:906:3488:b0:a52:e86:ae62 with SMTP id g8-20020a170906348800b00a520e86ae62mr7767532ejb.54.1713253038496;
        Tue, 16 Apr 2024 00:37:18 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id gt43-20020a1709072dab00b00a5242ec4573sm4507206ejc.29.2024.04.16.00.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 00:37:18 -0700 (PDT)
Date: Tue, 16 Apr 2024 10:37:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Martin Tuma <martin.tuma@digiteqautomotive.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Hugues Fruchet <hugues.fruchet@foss.st.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hans Verkuil <hverkuil@xs4all.nl>, Sergey Kozlov <serjk@netup.ru>,
	Abylay Ospan <aospan@netup.ru>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Dmitry Osipenko <digetx@gmail.com>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
	Sylvain Petinot <sylvain.petinot@foss.st.com>,
	Jacopo Mondi <jacopo+renesas@jmondi.org>,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Pavel Machek <pavel@ucw.cz>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 07/35] media: staging: sun6i-isp: Remove redundant printk
Message-ID: <b8a5cc23-240f-4fe9-9b25-b534f618506e@moroto.mountain>
References: <20240415-fix-cocci-v1-0-477afb23728b@chromium.org>
 <20240415-fix-cocci-v1-7-477afb23728b@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415-fix-cocci-v1-7-477afb23728b@chromium.org>

On Mon, Apr 15, 2024 at 07:34:24PM +0000, Ricardo Ribalda wrote:
> platform_get_irq() already prints an error for us.
> 
> Found by cocci:
> drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.c:389:2-9: line 389 is redundant because platform_get_irq() already prints an error
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.c b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.c
> index 5c0a45394cba..a6424fe7023b 100644
> --- a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.c
> +++ b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.c
> @@ -386,7 +386,6 @@ static int sun6i_isp_resources_setup(struct sun6i_isp_device *isp_dev,
>  
>  	irq = platform_get_irq(platform_dev, 0);
>  	if (irq < 0) {
> -		dev_err(dev, "failed to get interrupt\n");
>  		ret = -ENXIO;

This is more fall out from when irq functions used to return zero (16
years ago).  Instead of ret = -ENXIO, set ret = irq.

regards,
dan carpenter

