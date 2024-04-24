Return-Path: <linux-kernel+bounces-156611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665838B05A0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F112882A7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FABC158A39;
	Wed, 24 Apr 2024 09:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NTxPEmmY"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDAE158A24
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713950022; cv=none; b=mF5eVzkvCqQEaJc65V9OvpSELCL412Tre0BuPMuOEz5pb6aXWdsfKz4UTZh9CPpM572MLNsgtEod1WiTPmcLkv1gybHw0cUtoHbcPR7DV3BFBpVOQGOM0V6C+bQtZJ/7d07nDsyP1XTQ9yImn09pn0PRz/62ASkwDSDu/QRHtJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713950022; c=relaxed/simple;
	bh=YOwcHZZUsiHoO5pCDD+f5fKSeVpcwJRSQ8bCPZVkdX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCS3HaUsCWR6KZTYwwWxbGNixHnGhkFSBH1qFqVSEcXe7HX3thjWG119ITncu919/FGPK8QD1rojIp+0OBvsjjdRPv3/c+4a4JKOrIkHvw1dY2YzHuz7SVE0gVjL1S+MGTCQNl7CUzQjvMXQAZaaNqPrrsGKMCcQMqYsu4XVRNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NTxPEmmY; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2da0f8f7b24so8288201fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 02:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713950019; x=1714554819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dyu/qfLUKMUVy9ySNB9uAE6ofOvsG4ON8Bs9Mq4sTeg=;
        b=NTxPEmmY1GsnWMY25oxl+pbayyB9jotIgGO4X7QfIsj8drM3HXVjuK0QKph5X/f6wm
         4A1Az+HCAcpIgPzKj8Inq8NR3lx1DBM5Ad4lELiJYqMGrCHPo6rtvsJFL2ZWUf0tvDcm
         smyGMA1LZ5Kjg7NNvbajrthCI+eJKSHq+bk10674ESE+YIvHFfnbK50yx3q1sl6UEweI
         xQz9uRbHqA/qX8LIff8hpV5yrfLznlbJ1pZa2rObE68MOv9fasHj6RqRNRDpeDSb4Zua
         ixwTpMfWaQ7cTnpm6aq49JMgXMffJSZUdGkvqGoI5GTdodiNFf2LPOMwYoT8pFIkitSj
         jqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713950019; x=1714554819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyu/qfLUKMUVy9ySNB9uAE6ofOvsG4ON8Bs9Mq4sTeg=;
        b=INjuqpDsvIa+SMW2KEG9nplboAii/WtrNLTurisa9avBqFnMNbFOeAm7C03PzXQqe8
         yzX7Mg24tH5Sk7+Q27LQCxKMZwCgNBp0tw00NCltxAKS1kxjnjp0pP8n9Z7JWxPsEC2V
         r9fJl1ACj/eUPWdgJTpy+wpjzTB9T/OCCuIup9JS0UYvO8eC1kOaBWhE7iqFQGn61Y4x
         3fhV1DKtm0EDdQR4jkAQkHsaEFc8/mQrXlGXV5aDvELFhMrhi9aBiPfPLO6LzspL385h
         28PPFCJgvlHWV2GaVUNpqqf48Hc/JiKYA4K/fxogCDVoT59/kg30yVh2KWm64dqSRQHp
         ynAg==
X-Forwarded-Encrypted: i=1; AJvYcCWN7okZHLq26vkY5K4wyywlw7OPV7IvFCJ1lEO47DV2bLTrfD69Eo+eIMsRdK4UWJNLtSnYMbUPx4oKQBAtx0tAYrdGpuyFKtznwmCz
X-Gm-Message-State: AOJu0Yyez9jmDvbfAl/+cRFylQzlKs5zeQPk2ywC+kHzQvLUKshiuoqv
	YVIqfLG3j/qsLzVlaQy/pvENCBe8jBkD/gb29KtVilz4PZAYQCON3P3N/T3NySI=
X-Google-Smtp-Source: AGHT+IF7tGhQQ19VTK/0hLGwx3/fVCmQHC9hfOw/q63KO27oX2rwhIc6Wd2UFQ1XMV0Hpj7/jLMDRQ==
X-Received: by 2002:a2e:a715:0:b0:2dd:f725:765d with SMTP id s21-20020a2ea715000000b002ddf725765dmr1673160lje.4.1713950019113;
        Wed, 24 Apr 2024 02:13:39 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id n14-20020a2e86ce000000b002d2191e20e1sm1948403ljj.92.2024.04.24.02.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 02:13:38 -0700 (PDT)
Date: Wed, 24 Apr 2024 12:13:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/bridge: tc358764: drop driver owner assignment
Message-ID: <qmvi2dpwbkpbyyyqlugyqa6ljrpzodp64uwnfzi42oqw73q5zl@eoqmzkufxhvf>
References: <20240330202741.83867-1-krzysztof.kozlowski@linaro.org>
 <20240330202741.83867-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240330202741.83867-2-krzysztof.kozlowski@linaro.org>

On Sat, Mar 30, 2024 at 09:27:41PM +0100, Krzysztof Kozlowski wrote:
> Core in mipi_dsi_driver_register() already sets the .owner, so driver
> does not need to.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/gpu/drm/bridge/tc358764.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

