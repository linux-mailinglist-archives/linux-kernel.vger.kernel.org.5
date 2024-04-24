Return-Path: <linux-kernel+bounces-156609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D7E8B058F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10739282364
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7D6158A3A;
	Wed, 24 Apr 2024 09:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wJhiCAPy"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D5AD29E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713949957; cv=none; b=pJKxnlUFMaMivOwbhNQWmgCsctiPhJfOl9syY3gNnm0fKfxc7jWve3jkNkquv64mPl9TYVC7Bi+e6Ie99yAyed1RN9OBg7hL5QQV+ZextkIj/vo3NbB67ZUHcm181+LxDCzhS+a5LFz4bQgkTAA7d/22AnfxD4D6NNGV8nO2kf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713949957; c=relaxed/simple;
	bh=cTM1JX4LQrY1bHjQ8gSTw9GRe2RxR5PGQimFMk5abb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGGbOOjbezfREIzPxuPX0dGQvLns5M+XW3DRp3TEvuJLwzD+reu+RSfjNqk+VezFa0aNt4FeTFxQTHahXGG/d6Wk8gG0K5+FwoQIAv2T6NVaQspPlG2aklQfTwcLY07IteW0b4hLAKLzTfQG/hKdt4CYDWpvEbgWh99X3py0ZQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wJhiCAPy; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51bab51e963so1937106e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 02:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713949954; x=1714554754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RrfmU0/3on4qHkOzvcKXO2sa516NNjuhFePsPArraFw=;
        b=wJhiCAPyaHMl/692EV3e+4jQ914i6Q/k3VXkANDtQpVuow23UR6o6ytRzI3ogxkcou
         idPR/IZPODftiT7sKtMTs873EkmBxlkL/xB6+1Z+QJe4q6hhTCiNrp2z6KdXYeJUqLVJ
         8U72D9m3AjCUoIdNATc16521Q6rNMwwwvwRtxZ/enAguOjlr3lTDp8fFyX0wvvMmEj5X
         wNCjjPJomSH5tRJqL/cKAjRwFk5WloOjT9UgxnCon6ELe3Z92ddZmuQLe0HU/+BecP1N
         MNmZnY8bseoLrqPwVzZ7yY6j76Mdt9y+bd+JN116ZD3m3rtxx5OJfDMCHJ8dj+Zj8OcX
         StOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713949954; x=1714554754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrfmU0/3on4qHkOzvcKXO2sa516NNjuhFePsPArraFw=;
        b=fzeDVghQkCAHtjOo+7qrfvmtg4T3vO6vQCl92tqA+l/71lnaDszb2z/JlwflmeZFom
         lG+7TF5JwOacNEOWNuzJnWP6MdzP4eL8mLbZfj7Z0arfJuGLp5lMVSUjJ7HnLHyHHilk
         JG4FlTYdLIj0EJ3zDtYTaJ6dlVNaDX/VWVIoilr2W4E2Uw/WLouizaFlqqX2xEHaeYyk
         f6QDHAgzPX5Kr0hdp1jNim1o+wNGZW/q1d+5j9QnZSQvWM74J6nvXIEKZdqNQEAYP7mf
         ycKjVRtarWkqopwuglBC8R3geWQpnva2a7qLOZgUeWD/013ao1NTKuO8IrLVNDQIK0A8
         xuag==
X-Forwarded-Encrypted: i=1; AJvYcCWWhg+f1c+noGoYFHS/eIGjljMX9CAKUvOA8ov1qbEdYVStHqoIS8lSfxJHfYw2nRby/rBwmzLAiKyvWW+Y1L8SHWkkRnl1acujBYjq
X-Gm-Message-State: AOJu0YzIXDShISne9jVfUz6kg/OWhJkltpMezrYx5fd38C1kKiJx89XR
	jeqKQlF0qy6mkAI33ozpBv1u5HXIi0xZhf78tDQXhStWXoEB6loR9coLtVoa/OI=
X-Google-Smtp-Source: AGHT+IFq9MwQWs6wIXZlmD/rppELkT80yR7wTKRpkz/G+3+KsK01cWL4l5tBm2fA+XqurmzkT8QgXA==
X-Received: by 2002:a05:6512:3ca2:b0:515:bba3:745b with SMTP id h34-20020a0565123ca200b00515bba3745bmr2008856lfv.33.1713949953939;
        Wed, 24 Apr 2024 02:12:33 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id u8-20020a05651206c800b0051b458ac8ffsm848541lff.93.2024.04.24.02.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 02:12:33 -0700 (PDT)
Date: Wed, 24 Apr 2024 12:12:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/bridge: chipone-icn6211: drop driver owner
 assignment
Message-ID: <ul5vzz54kppxo6zkr7k6seejmmlgp3d4dqfzjlj5la3e5ltolo@ug5dtoknkibu>
References: <20240330202741.83867-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240330202741.83867-1-krzysztof.kozlowski@linaro.org>

On Sat, Mar 30, 2024 at 09:27:40PM +0100, Krzysztof Kozlowski wrote:
> Core in mipi_dsi_driver_register() already sets the .owner, so driver
> does not need to.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/gpu/drm/bridge/chipone-icn6211.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

