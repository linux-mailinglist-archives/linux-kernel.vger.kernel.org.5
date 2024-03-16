Return-Path: <linux-kernel+bounces-105255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C0687DB1D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 18:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D0871F221EF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 17:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9066F1BDEB;
	Sat, 16 Mar 2024 17:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nu+CBkBJ"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246C818EA1
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 17:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710611031; cv=none; b=s1OLdeOxm8zEJXjW6oNwwSnErYA44Q3TzGsyHRdruUsNhPgRLHU+MllB86yYvRkIqIDWOslayQnfVovTqWw57V76im6xqun8e5xsr0C5fvVwtV6mcOltHTFh6db6Dze2quUt+BweU05snJNSOnySjW7K2GH3U6CGroY7eJkhSdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710611031; c=relaxed/simple;
	bh=KnVh0antMVP/NJIgLPhohZuiNeYobVCeD+9LoJish3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pV7URLbine9HQLCGb2ETDskRmqRhFs33jzxJXeqdi2UVUt+4B2WYq6IZ2EFbcYx2GSBGe3ED6vHmgVGcf1sIikhGNxQYli2eIbC/J4ZNdqrvln2NUknWckThvCAyx4y6wYXDCf7zA9mstqmGROJiTIsU8qEeDtPTMdXccIlDP1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nu+CBkBJ; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-609f1b77728so32583257b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 10:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710611029; x=1711215829; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gsWeHMlsnmIiCcbXCi3cYyDcgMUZ5WgQ1aeiRyvL3ME=;
        b=Nu+CBkBJ3Tw0Jz1O8EGN/r2x/XRyPlC81dDwc6CYWZueoO2xZMDmLESn+OmPvFKbWE
         Q+s1BmAl+RJQODcvgzaAeIdzeCKrg9xFY4KBKkI4QpgbxyfaFSl77MUJiY/ko+x4KBdf
         rXLybai27Vi+7yynUP3VWw6MMZ8HqafVJSbUCCOjP8TYITDdn0Vl4ijRaGtMv/jngEX6
         HXDQnrj5weXcDVoEHF6n17o1FxKyTVJ7VjRVzxI4+/iwZi0A/6ZaAh4pp/c1pJPelbCL
         sErm+ykjRmlaGmhAWMMMmGh66mAvLBAA9fEaUjZgN9eQWeM+1JVph+bLxsZYre/IzM7Y
         eQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710611029; x=1711215829;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gsWeHMlsnmIiCcbXCi3cYyDcgMUZ5WgQ1aeiRyvL3ME=;
        b=qFzdqSADEBxYR5KGxbxYPzzvUegDQz8hCeVW98kJ3YR2rRSWh5W+hxmNd0SIUg6noU
         JlGLWdtCtFoyNy/c+u8sMKMGa3ulPPevtk4Bb686ZUiE1FAP7bIHobxemNb74cBhzh52
         sMndpk371mF0xGAnXNWnasEfu/4TmviTrAY5fB48VsAU33qUJXBUnUWWRKsS5RsZHeJI
         ZlujuZQyEbqUDwM5P2bNk/KCnmlpmsGgReTG6IFMdrL9Xv6m7S8psqardlbtVqGsE0VB
         UyzqxxArQEjtToFY9TXcvYdvekKaVQ5vgcalthnzh7jQ+6w90ukxGh8jXMIPUhSYZqq/
         cB+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqE5jy2s/3w3cxjsmo8OQHjOBHFbT6KkmYYcjVvs0Czv4lWj3Gmunh9Uypt/SDc1y0Se+EAYFshtuuJagLTHnz0+iOCvDA7xYhIBVq
X-Gm-Message-State: AOJu0YyfNQivqZj6t/jIQ+0wp+RC49fD0YYQmANPrPLNgzWwFWGHOpz3
	C67Bu47mtgLr5R8qixzZ4tgGH3Txc1rZxQ0mmPyRcTSEs4Guu74Nl63uzEQrXnJiTuKEj+Ymsju
	bfA9Uo+P9Qmu3W5mXcZWZxyexzBMEuhqCrgL2EQ==
X-Google-Smtp-Source: AGHT+IExfdO9jSTPxrxe8vINHAoaba+5RLEb/CrwPMl9w8ov4NbY1H+y62jLbRWoO2ccMbuLU5wzdF45WLhfwGzGacc=
X-Received: by 2002:a81:8002:0:b0:609:fc7f:1e0d with SMTP id
 q2-20020a818002000000b00609fc7f1e0dmr8150472ywf.30.1710611029128; Sat, 16 Mar
 2024 10:43:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240316160536.1051513-1-sui.jingfeng@linux.dev>
In-Reply-To: <20240316160536.1051513-1-sui.jingfeng@linux.dev>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 16 Mar 2024 19:43:37 +0200
Message-ID: <CAA8EJpodZhJQER+CEXHUD2H8nB4A4Z-u_ev1QOY-6xR-5GgvfQ@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ite66121: Register HPD interrupt handler only
 when 'client->irq > 0'
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Phong LE <ple@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 16 Mar 2024 at 18:05, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>
> If a specific design doesn't wire IT66121's interrupt signal output pin up
> to the display controller side, then we should not register the interrupt
> handler. Such a decision is valid usage, as we can fall back to polling
> mode. So, don't make the assumption that a specific board always supports
> HPD. Carry out a sanity check on 'client->irq' before using it, fall back
> to polling mode if client->irq < 0 is true. Such a design increases the
> overall flexibility.
>
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
>  drivers/gpu/drm/bridge/ite-it66121.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

