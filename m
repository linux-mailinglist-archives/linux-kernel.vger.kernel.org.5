Return-Path: <linux-kernel+bounces-162132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 879BE8B565D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481A2282C09
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E633FB9B;
	Mon, 29 Apr 2024 11:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l8pkA5MB"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0744D3DB8E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389607; cv=none; b=I+VKLZYMBpIkdralgpyAfldqLfPQ/bYbmcnSIY/xxF1AcmfZUdiksTL6aR8TgczzPnvdgh7NB85cd3DgmLVaUMxnThcIst2Fsgej2IvcCkktXaOIR0U2g+0EXFtLl+u1qly1aOQuzT6lQFssoCHFBndeTTP2qfkSV0KEwUnmhRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389607; c=relaxed/simple;
	bh=OTwKdMEJbzVq4mX9xEUWowBAjhrYsUUqQLDG/udZeKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URH5IaWK6v506vQcqIgDzLs5E3MZjs4LCwXnw32UW6fxf7q/ghgVn9OP2VNw/xCYXnurCPR2W+Upqmp7C60861GBOT8LtoXC6gIE/XL3bC1+8GKAS4abnRp2q0Wa4tK5+9qgNpA8qNva2QenMoIpRryga1Tn7refc6+OIBDt+IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l8pkA5MB; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51967f75763so5000726e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 04:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714389604; x=1714994404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8jsHr1i+3e2shTV7drwyDmrC6kyp1zvUUgs5PDdl9uw=;
        b=l8pkA5MBm/JSzgTAWuNDe+c8DPMB6V/Cim0obFWfUSRL7mKDRF9UIJB2C+AeRfj1JY
         ifMFXP8cgP5qnmyCXq22B1BvKixQIPDbI/8NkomdPTWQxo+CTfzjiwzIVuC4UIJ0CWhP
         3PO+5VbLHhl3DyHypT2KHuoCSP8zbmmWoW27htYeEqBzzYGkGMZ2UZviak+Ke9Q3N2YL
         DrqMlp2zJTMNg/GxJlDSMRFMC0b7M/jZff5+eoej6GxwcK68vy71MiwHy/M/cMwhv0OF
         gES0I6c83c1AHI1eDt0qkXwvaHR7lxHeDsFxmXsBDGzpRQdixOlm+JwQl3vad8Niourp
         4ukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714389604; x=1714994404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jsHr1i+3e2shTV7drwyDmrC6kyp1zvUUgs5PDdl9uw=;
        b=o/6ndbwPkvFL6FNCkkx3VoowCiSD2fmw+NvDxL0kc1KRKt0Mx2zBFu5DcUyUlo1qq4
         x9t6KJqpPTsSZ9jqDTCLL7vJ2ml43VgOKnaY6RLOTMcUDNcXectZgjfiVfizwuUXfu/v
         /oJv7I/bVoNAY1PNk2ur6ysFXnLzLDqOpKyr6b6zp+ILHz8NlgzpNFxcITpZ2ql8Ijya
         AwZzVhTFH+PjfSll9g97Kz6e8ldgmYTfzWo0V3bzG22T7nofrROfYRG3yJ6BloMzii2Y
         vNAGKjbrY8/kILjz47rQFhY9VyNFM0uYFxArijX8GQ3tzyqzl8FP7n7bA383Rt2FbQE8
         QGaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg8u+WsGqiYYByVy8LqWvykzIImFpyXaNBSd2yLJMJ+nzwHNOFQgJk89pjuaeMoKMp9fjrg55l5GapurNiVC0IBCtPApsmBbGADgTY
X-Gm-Message-State: AOJu0YwuENMoAZ6RHlC1AtUnUqcbup2MrxuOdxWrVoBwtUrwrNhp28GV
	53CyuoeTxVreXIOP2eEWRXGez+UF2lp05JOxvWzlMbza9utNkPhMkJnpVvU9cDH0uWpgrxUBqfW
	U
X-Google-Smtp-Source: AGHT+IEWhb8KSCrCjZUpJ0cIBjaXZi2tC5MyhxWNHeFV7fufH48LCXzuUsSc4zQPDOo03dyk+2X78Q==
X-Received: by 2002:a05:6512:1112:b0:51d:a1ca:5f26 with SMTP id l18-20020a056512111200b0051da1ca5f26mr2737330lfg.20.1714389604215;
        Mon, 29 Apr 2024 04:20:04 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id h37-20020a0565123ca500b0051c4e9ebc71sm1509704lfv.210.2024.04.29.04.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 04:20:03 -0700 (PDT)
Date: Mon, 29 Apr 2024 14:20:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Douglas Anderson <dianders@chromium.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/debugfs: Drop conditionals around of_node pointers
Message-ID: <5zckqabn6oay3wlq7dlvcydbmgio5ktjg3ovia5qpmknpsibi4@b3nkhnrjqtql>
References: <20240321222258.1440130-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321222258.1440130-1-sui.jingfeng@linux.dev>

On Fri, Mar 22, 2024 at 06:22:58AM +0800, Sui Jingfeng wrote:
> Having conditional around the of_node pointer of the drm_bridge structure
> turns out to make driver code use ugly #ifdef blocks. Drop the conditionals
> to simplify debugfs.
> 
> Fixes: d8dfccde2709 ("drm/bridge: Drop conditionals around of_node pointers")
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
>  drivers/gpu/drm/drm_debugfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

