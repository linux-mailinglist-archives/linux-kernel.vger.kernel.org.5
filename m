Return-Path: <linux-kernel+bounces-84218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B98686A3B1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D36928C6E9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393475B200;
	Tue, 27 Feb 2024 23:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KHPXIVoG"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FAB5B03A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 23:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709076393; cv=none; b=Gg4pidfwMo8Hqj0x/3MhINK7xTM/6LEf5F1Mb99iASp3VfLbbYO+avu1deO/9qXYfRvTVBNJW2gN70qxQSu/TfLNW4zm8a1nLhIEE8KhLmviUoArThT2WmAO/Fz58RicALKBIB8f96pnOE8BPOBmnC9TtlRHX7DKdXN83gvkPOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709076393; c=relaxed/simple;
	bh=dI2OHDtMlhwBaqpIrN50iD+P9Ph53KFLFHOsjecALOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RoRCufAbeSWXzO5eD2Q8RRzaq8rq9g0gMDE+P5k2e8rsEbsjOLQbG89vskw7muB9muW2RAwot7XkkuXVRrjzlu1+qQ0vyOAxs2VnoeRmswFd9gu0CEuEjZO88VG+sBvVsDsGf39LYJnAjaAMx1QleKuBT4/od/uaLgvV2fTMz5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KHPXIVoG; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso4082146276.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709076390; x=1709681190; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BVBbYCFm8xr3sv+kzZJvqh1w9VqUrbToySZUueJGefY=;
        b=KHPXIVoGFwSnJzEqaReakinB1IVx80pII1NPYVAeGVyHNK6WY++E8gCxd81UAvRXRb
         aiELLHjSrBiRrknT2ylgcOOK0LF+mFq9zV55aRJ/I5MG/gYbHEa37u4PViIrya6C+erJ
         J56JmiRaGFYBCl70matw/HbbosG/WViPPV9okKQwITEs2YG0z0BHd/WrJCg+khalW7iv
         N/G8tkYJaEDwuCecaYPyOuegItTcDZK1YJu67/iqkeTadVgfgYPO/rM6FSBLLPN5VsI6
         wmQtXtIhFoFBqmmSlh+TidOjFsBts0vf265iDWyM6BDU2rgCCk9cGT+B1pfhYGqpmjKQ
         wxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709076390; x=1709681190;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BVBbYCFm8xr3sv+kzZJvqh1w9VqUrbToySZUueJGefY=;
        b=GUsMPqATmJSKHHLMaVcs6gS5uOEC5zz+7p5r9l5LU4Fv1jhsEgAJvTOA8Lg4XzYe4e
         bHKfqzyLZI/avWIZBFzOtZFwIHA9ve3XqmU2j0KuDjAwYXtVW+W5hpf/idKu3h2ASKkp
         66054v4Ip2BO8Nl/w/CiPcW3acBG1gPrE1y1t8bJR1C2OhXMmId16Z2I5o7vryqpCvyg
         C5BU/BYQY8wZyUN8NOwDZ0+0az6VZk/wyT1JpksPQB1AbDwjO96FoEnCkcOIBZIdOxtJ
         YR5746A/fAn1TzdXIcRIi+EvYmUsvXFWc6Dgw1F4UhPuCxZCcx19VGM2iSKiVbQs1X6b
         YIQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhAam/ENXaSXaU1eWaACidwNj8p4TFn22xyM919vBoEVVRN5HEXo5ya9SuxNW5nVCfd4QLGg44Kw9SYOyyW0WjAIAf1lPpwDtrIZq5
X-Gm-Message-State: AOJu0YwC7fHVLYmybrdpgdlmO+GZzCCX+fBtsqCp/np6OVmmVIJDnirN
	Netc8SLY7col+EIDrfh4t4Bri837ngI5KanV++vEsDy3+2jPfbF1btwQnKxniZq/sQ0rEdkRv7N
	IXGVkgeqE3rkryfXr5LEGTmC6oMVa4Pk160qIlg==
X-Google-Smtp-Source: AGHT+IENq+Z2eNW1wAYtx3jcYc0DCa1qzovnKAILy5xMkbCWx5AIdIffMtBPby/y+fF9qj55pcq7eXqn7KKIej1xoAQ=
X-Received: by 2002:a05:6902:1b88:b0:dcb:fb49:cb93 with SMTP id
 ei8-20020a0569021b8800b00dcbfb49cb93mr1087639ybb.45.1709076390718; Tue, 27
 Feb 2024 15:26:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227141928.1.I24ac8d51544e4624b7e9d438d95880c4283e611b@changeid>
In-Reply-To: <20240227141928.1.I24ac8d51544e4624b7e9d438d95880c4283e611b@changeid>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 28 Feb 2024 01:26:19 +0200
Message-ID: <CAA8EJppQYQCGL8UCX28JwrkX7Nb4pQStboXbyaEw=T+D6F-OAQ@mail.gmail.com>
Subject: Re: [PATCH] drm/udl: Add ARGB8888 as a format
To: Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>, 
	Javier Martinez Canillas <javierm@redhat.com>, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>, 
	David Airlie <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Sean Paul <sean@poorly.run>, Thomas Zimmermann <tzimmermann@suse.de>, 
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 00:19, Douglas Anderson <dianders@chromium.org> wrote:
>
> Even though the UDL driver converts to RGB565 internally (see
> pixel32_to_be16() in udl_transfer.c), it advertises XRGB8888 for
> compatibility. Let's add ARGB8888 to that list.
>
> This makes UDL devices work on ChromeOS again after commit
> c91acda3a380 ("drm/gem: Check for valid formats"). Prior to that
> commit things were "working" because we'd silently treat the ARGB8888
> that ChromeOS wanted as XRGB8888.
>
> Fixes: c91acda3a380 ("drm/gem: Check for valid formats")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/gpu/drm/udl/udl_modeset.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

