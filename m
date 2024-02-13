Return-Path: <linux-kernel+bounces-63847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BF985356E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49B6F1F21A9A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36985F547;
	Tue, 13 Feb 2024 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y9lcql66"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79145F476
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839893; cv=none; b=D9XYDD9v8SsUE8XGRF89wsaIned83gN5dbXwN57J0VCF26bT/CpTo7iu+X8x7Oy/M9foXy/dRTU90t4XJVvKY/zm23bhgnCTZ59nwW/iDlj9puI0moBIYFTSAGdYqF7Z6obt3IVCsnFRZnMHii9dV2SNTk632rNIXVjqiPTFFwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839893; c=relaxed/simple;
	bh=kLvA9F8Q8hMJy8VB32vgxuqt0GnA5jwxo56+WSiABbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1D8iyiSRjSLml8Pub7zdCHAWDA/cePsCEFdCtQK1jhs1KsLWJErNko4yfIem0RlOmuEateEzLZUE+rGiRpIrmEVzm5puWUBnNryrjTpimDK6IWf81jS37qY/oPxMyadJEEJUXDURbPHsZXlE0pHgsAgXJglxPmQ5lVSe/YyOnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y9lcql66; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc742543119so3801194276.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 07:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707839890; x=1708444690; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbboQjtqJl0kRKVmT9324agg2n3TuIJm0CfegMAaP2Q=;
        b=Y9lcql661sbMjDGa1J4VNDPMHa3OqwV0NJ0l4RT+Fug1giYT5C39RgXKjSM7nBmV26
         lFA8NJAQ+5TQrnRYhV/FgZlY9lrrEiRO7EbduznIxV7N5q82uqkYbrckg8yGset1EXJL
         ug/PkKjvyHoTQRijxxwdLJVPeYVEWVd5S9afU4hlqerhK3pzLqSs8qIQLfEuaps4OMlD
         rBtreWa9urLgmQK6Xz4JmyTKKH230MKCBJs9k3UWr32P8byL9b25vMBKiCiZ0WoDI6Lv
         q+qm/Fiqzq71S8vPomx2weRZ4OfZrdUii7aU/8gztK3e+Hf3Ss6wc5xr/dHhbv71fEah
         XUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707839890; x=1708444690;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZbboQjtqJl0kRKVmT9324agg2n3TuIJm0CfegMAaP2Q=;
        b=GQs/T1mrFqSarAwLbdUPpsnr4ag97Wvt83/iyjEAApOqItCPqgMtqe36il+G5WeQxz
         5eGgroDtOfMSAiQY2jleG1SFut/HXbG+7suci34QAAPIRLDlhvXbpG3jnips/1sd5PXi
         dPLHjG7ii0eCM4HOvsiB690YQmnmS6jcn8L7hTUeOzLQZmYjuMC+4tU4uv0d/tHSyyAC
         imRsT5FXyPX0O6xfIKz+qz2T3SXgJZPA2ohGtM4Xm00Myb0IvqqWLrNtgz3mbmadkH5Y
         uyEkeccfkHslSWxyUjQQ4srKRkwGJPSVr2KhMR5NnEO9iSmV5b6W3jxGe/xT5zXq013O
         44vg==
X-Forwarded-Encrypted: i=1; AJvYcCVxGHt3QNPgBE8HoWYfxkagieEGZKHa9caVLOt+/wo1vIwIl8D1UD9vI3lXQBC+Gy3wu7wvrvIb+Z4s1jyBfKrpauXkVKApNIN/bPpR
X-Gm-Message-State: AOJu0YyteKUGaaU6JohW0ThTK0QqT2Vog7bhrrC0N/N5Sf6WIgYSh9JY
	nSSoZaRFFd7+UQPILHv4k4MBLxfm7dEaxc/2/KCpWGTyBVGOmPUcvfrFLCsL1Wfz9sZBHDRx/LF
	SmscDSNmwZaI0vKmikP55B89cVguBJq7ZZP0GrmOX5OzOOjLkLbo=
X-Google-Smtp-Source: AGHT+IFmnTkXNu4JoaaOCNlItjkMQBcNvs9jrCwoCXuPdjvF/qGzXg3CtaGd1xcEuKgEnfJ2PjsPUbYu9BbM9Oi6unI=
X-Received: by 2002:a5b:c4a:0:b0:dc6:e75d:d828 with SMTP id
 d10-20020a5b0c4a000000b00dc6e75dd828mr6861944ybr.18.1707839890663; Tue, 13
 Feb 2024 07:58:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212215534.190682-1-robdclark@gmail.com> <CAA8EJpofXjwFG3NhwSJQadoe6eR0vkX2Y4knC55b7qGn46UA_g@mail.gmail.com>
In-Reply-To: <CAA8EJpofXjwFG3NhwSJQadoe6eR0vkX2Y4knC55b7qGn46UA_g@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 13 Feb 2024 17:57:59 +0200
Message-ID: <CAA8EJppJhfbctBE_mdsPikpsLQ-6o2oXGO7bFpUXD8q3YxSSeg@mail.gmail.com>
Subject: Re: [PATCH] drm/crtc: fix uninitialized variable use even harder
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jani Nikula <jani.nikula@intel.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Feb 2024 at 15:50, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Mon, 12 Feb 2024 at 23:55, Rob Clark <robdclark@gmail.com> wrote:
> >
> > From: Rob Clark <robdclark@chromium.org>
> >
> > DRM_MODESET_LOCK_ALL_BEGIN() has a hidden trap-door (aka retry loop),
> > which means we can't rely too much on variable initializers.
> >
> > Fixes: 6e455f5dcdd1 ("drm/crtc: fix uninitialized variable use")
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> > I have mixed feelings about DRM_MODESET_LOCK_ALL_BEGIN() (and friends)
> > magic.  On one hand it simplifies the deadlock/back dance.  OTOH it
> > conceals a nasty sharp edge.  Maybe it is better to have the complicated
> > restart path a bit more explicit, like it was originally.
> >
> >  drivers/gpu/drm/drm_crtc.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
> > index cb90e70d85e8..65f9f66933bb 100644
> > --- a/drivers/gpu/drm/drm_crtc.c
> > +++ b/drivers/gpu/drm/drm_crtc.c
> > @@ -904,6 +904,7 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
> >         connector_set = NULL;
> >         fb = NULL;
> >         mode = NULL;
> > +       num_connectors = 0;
>
> Nit: I think we should move all this next to the
> DRM_MODESET_LOCK_ALL_BEGIN() and drop initialisation from the prologue
> of the function, but it's definitely a separate and more intrusive
> story.
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

After running this through CI:

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> #sc7180, sdm845

> >         DRM_MODESET_LOCK_ALL_END(dev, ctx, ret);
>
>
> --
> With best wishes
> Dmitry



-- 
With best wishes
Dmitry

