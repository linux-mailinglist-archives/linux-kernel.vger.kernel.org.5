Return-Path: <linux-kernel+bounces-63614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CCD853244
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 339181F22B48
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6E957310;
	Tue, 13 Feb 2024 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KsdzPRbb"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA7457300
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707832252; cv=none; b=NDoEBeu6GiA84sAlShbxClBWqSjCk07L+PEXUEQcyY75YD/mgaNCnrinBwhIyFBO1R3uVasz9eCf/I7jEKwa3jUj3M36ruuogU4tvaR2wVayFB70p0nvK6hhfhPDb77Qmq6RZRHLHDckrK1lSWWnW1yQRCoM6Ft0beQzpN/Mivw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707832252; c=relaxed/simple;
	bh=H4d6QiW+KpjBQZm2ut/bIJWaNIg+UBqfjjJNfS+sVhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5t4ImWjz6jDkHS3VI4VzOSfDFp5j/1I/YcCOpGziHYtDes2f2PYb7deZn3TJhR9JBxyplvH00KZdFZ1PuqtJv3e0j1tE/e9SSxA5+MZKhp/XoxsC2rfaXDxXmx4Rmfuc5n0CN2YtR7S40b7aRrnf+G3G5ks8tc06jJVh1tJjd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KsdzPRbb; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so3114499276.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707832250; x=1708437050; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EJDZaN3+N6WSLw4IYEvxsp0tQKnp1DRHMOiyVaOY74w=;
        b=KsdzPRbbAq/nAnEYZ/+A3Lm+8sNfNPqcCgWfTrlB8D7TZrKEA+90Xk+PYTgz/B2Pb3
         CXb0mNFOsB1HOu2VzBqbTuSknbDSPtHG+o+bMoK1UfHmDObf/qja5orWk2ORdk165raX
         tt9X712cCYsLsp9uBdUyD3uXz8O58mPHliJHFWqKPAy2/e8L3it2J7zryaj9QmRWoJpj
         Atm7ZQ9QL0rz7NfAmakaqFBzh2IXLJnNBAAOvm7/jqgRtXJwZDxh9YG4jx7xz2YusKLw
         lq58CDJpciTGiOHr/geh6p9sp1OCKYeO9TEkOusliqeJ6alkv/7FhmO1RXJU13oqDuc9
         cQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707832250; x=1708437050;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EJDZaN3+N6WSLw4IYEvxsp0tQKnp1DRHMOiyVaOY74w=;
        b=pOXjP7ClwCnWypUS/KbLOT7dQTWH55nUV4CRN84Y4bfi7CNg28e946ufxwK+ZEYoc3
         NQf90SIfVF3HorT4R/9iJ8OGHA3fZL5mel2OMIm27Lub7lP/R73tGWDqrQsI1BHeSlQS
         J/ezl5HpihYy8biQp62yE88YSdwq+02FKCyiDuvbM/ziPh9O/acbh3k9ID6ChabcxJBQ
         IyzgbBBnfEtQcHZ6YzFlZ7/sfXzbaNItTLrFhYULjJ8kwyGL0lT05OVAmh411/iHsehg
         iXHSqHPIvmnrzhde3UHDIU8kSWYECmq5Eli1Kwgpi2ftfhu10Ttdii1NrkB0uAYBcBwx
         b8Xw==
X-Forwarded-Encrypted: i=1; AJvYcCX50kWFgttisBWDN0KpMJSA8objGMCybsI+x/mnzsZsoBZcd7L613kcpxOph198Te0a2kyMgvpcA5b3pNxrGP3BufKN6hTsLwHyU3Mm
X-Gm-Message-State: AOJu0YxEjenCkUwgGYbD1NrWPdZQlk7nLphFhjtOCPya8ar5/ONpLGs2
	aY3VWu8a/o5hsHrPP3cIZhT4+qlpeW4nXc668asL3/thXrwhOZaP7hS2T8O23LfZUznAdz8+OHG
	5zhc4oSjOaAuxhCKcb5dvxkhmAykZ+xvl7XBikA==
X-Google-Smtp-Source: AGHT+IH//JrMrAcncgTbPsl96Zl5MVioD7SaPlvEvcAaeg5x1AezZYU2/UzHtnwmWGxuuLdzzWCZmu9OEPWluIHoQA8=
X-Received: by 2002:a25:dbc8:0:b0:dcc:a58:63d9 with SMTP id
 g191-20020a25dbc8000000b00dcc0a5863d9mr2949330ybf.44.1707832249951; Tue, 13
 Feb 2024 05:50:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212215534.190682-1-robdclark@gmail.com>
In-Reply-To: <20240212215534.190682-1-robdclark@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 13 Feb 2024 15:50:38 +0200
Message-ID: <CAA8EJpofXjwFG3NhwSJQadoe6eR0vkX2Y4knC55b7qGn46UA_g@mail.gmail.com>
Subject: Re: [PATCH] drm/crtc: fix uninitialized variable use even harder
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jani Nikula <jani.nikula@intel.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Feb 2024 at 23:55, Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> DRM_MODESET_LOCK_ALL_BEGIN() has a hidden trap-door (aka retry loop),
> which means we can't rely too much on variable initializers.
>
> Fixes: 6e455f5dcdd1 ("drm/crtc: fix uninitialized variable use")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
> I have mixed feelings about DRM_MODESET_LOCK_ALL_BEGIN() (and friends)
> magic.  On one hand it simplifies the deadlock/back dance.  OTOH it
> conceals a nasty sharp edge.  Maybe it is better to have the complicated
> restart path a bit more explicit, like it was originally.
>
>  drivers/gpu/drm/drm_crtc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
> index cb90e70d85e8..65f9f66933bb 100644
> --- a/drivers/gpu/drm/drm_crtc.c
> +++ b/drivers/gpu/drm/drm_crtc.c
> @@ -904,6 +904,7 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
>         connector_set = NULL;
>         fb = NULL;
>         mode = NULL;
> +       num_connectors = 0;

Nit: I think we should move all this next to the
DRM_MODESET_LOCK_ALL_BEGIN() and drop initialisation from the prologue
of the function, but it's definitely a separate and more intrusive
story.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>         DRM_MODESET_LOCK_ALL_END(dev, ctx, ret);


-- 
With best wishes
Dmitry

