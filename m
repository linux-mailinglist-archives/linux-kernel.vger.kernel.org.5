Return-Path: <linux-kernel+bounces-145885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E988A5C57
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC08F1C22163
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF0B156987;
	Mon, 15 Apr 2024 20:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktceOmyU"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EDD82D93;
	Mon, 15 Apr 2024 20:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713213840; cv=none; b=g3VHtTIUoBjmu7HIqlZGVXjz/2F7cGWePxBVMIksiDc8t4+20i0piItS2/Yryk9AV22nA9nBo3IgWahyOcTS1u9jxKMVPaXXxu+b/Ha8C4RTPoYIhNXxrKm+gsDEqxLNy5aEvPEGf8KGq5XSNoFb3PkfuU3X6oryblEDgfy1YSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713213840; c=relaxed/simple;
	bh=8dKuQacnGwje5yJMb2wAv3rYTCPMQu0D4XlkBWR3Ilg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N2uZWlMW+Hc0XqZBGgcPY78L6QIVNBnloHNr5AJ6JfUgl9lbbKBUOgSgmzw9/nA+vhCejvV87eQc9+NzJOGcFXVxHOz0P7efM9yuZwiY/DjeBHJbrYvvGiiMCDY1fxlZ+89Tg3Knl7m3bI7Gjcfeq/JKJECen79VQnTdD93xGKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktceOmyU; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d4a8bddc21so43006521fa.0;
        Mon, 15 Apr 2024 13:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713213837; x=1713818637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vh4G/AjMszS/t0HRqrjwJOahq/7qZsmwbbcrIjf8WJY=;
        b=ktceOmyUdoQ121HG73pYew1iOfvSSgjxbGtUazsGdpnWdU4F7FMYr23Uj6JQXdLD3c
         9Obgi4/KPp3FNGKBRLkWg59WSTKNugonenj06tLEEFg0jZGOrrf5iUmTg4stJwJVBVUS
         rpTa07C+KHlZe85vQglbhw1eEdwExJQ5rBCvqUNQ3ZTepV6Bjwmx01gAijz+9uDY5wIP
         HV0tIBDYFwoCP+mRS08bWLSD+GGuQjU+rjCLrkHy3wyxRzS/3TBXMQq4Zc1nAM1jpyq0
         Xt2Epe04ABP9B7fUKc2EUZFS6cXTwwKi3qQndmK0p/E5FTwZpPTyYvMd8UnQCX7jWB21
         g7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713213837; x=1713818637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vh4G/AjMszS/t0HRqrjwJOahq/7qZsmwbbcrIjf8WJY=;
        b=sbcf/2gJK7Lpkxn7WU7+qTekqpIZFhpRACtCJhwM1lJYwJrHgXBsW7LLv7c29GUyoR
         j7K3j2K9aI1kmcu//i0MKZU6eH6Aq/ia+bHVlyedxm35lVVQSY0vOMxSNdJ8Uo/zi68Y
         tvBh3sQ7IyLP7KaFDsuoc8FQLcPwC3ehvONG05aCrJ00CqiywiVk4zM0AHQJgbyijati
         8dp/5KG7twXRbVIxy0chrpXwopOEbDDwOraxpYJu/XRWMSyKkb7HWBVRQsDKGU06w80X
         VXvAvWXQ4c1frR5dgCgn8qykPezxzxCoI4+kFnLQ39Onz20E4aAtMjxP3gf12xkIoDSP
         Fc2w==
X-Forwarded-Encrypted: i=1; AJvYcCUAMK3Vgt69K1fStcIPsMZTRghK43Vs2STpOOUTPb4Qx1kaFJKGFz1U47KqqXas9xGYMJX78YXW9y6DKNmbXK35T0PetzdL1Y13YmjcGi+Vb3ngT8+bptWpscNR1NWPGvZsAu/sGU5u0LnzjnWogO+BTpVZcG0WO/rt29UFZlzjZ2nHvFmeic2n
X-Gm-Message-State: AOJu0YyIcivoJR9rk/x8LwbI8mQ5LT+URkw10qbzRT1OOMpLqBS8nSL8
	Ty88VPZdyfFIkFKYE+beho4DzyfMD3NH5sdbWtOpoHHWOI3u+2bj
X-Google-Smtp-Source: AGHT+IHuk+bIjnHF/M32DBBym4XM02bSBQeXa2Xi9niRXZxUmLjNJbCmeAfQcyqxYAWLBytnQmudbw==
X-Received: by 2002:a2e:bc09:0:b0:2d8:97f:451e with SMTP id b9-20020a2ebc09000000b002d8097f451emr8116687ljf.37.1713213836997;
        Mon, 15 Apr 2024 13:43:56 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id i11-20020a5d630b000000b0034659d971a6sm12976964wru.26.2024.04.15.13.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 13:43:56 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Martin Tuma <martin.tuma@digiteqautomotive.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Hugues Fruchet <hugues.fruchet@foss.st.com>,
 Alain Volmat <alain.volmat@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
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
 Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Pavel Machek <pavel@ucw.cz>, Ricardo Ribalda <ribalda@chromium.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 Ricardo Ribalda <ribalda@chromium.org>
Subject: Re: [PATCH 07/35] media: staging: sun6i-isp: Remove redundant printk
Date: Mon, 15 Apr 2024 22:43:54 +0200
Message-ID: <4910185.31r3eYUQgx@jernej-laptop>
In-Reply-To: <20240415-fix-cocci-v1-7-477afb23728b@chromium.org>
References:
 <20240415-fix-cocci-v1-0-477afb23728b@chromium.org>
 <20240415-fix-cocci-v1-7-477afb23728b@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne ponedeljek, 15. april 2024 ob 21:34:24 GMT +2 je Ricardo Ribalda napisal(a):
> platform_get_irq() already prints an error for us.
> 
> Found by cocci:
> drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.c:389:2-9: line 389 is redundant because platform_get_irq() already prints an error
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

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
>  		goto error_clock_rate_exclusive;
>  	}
> 
> 





