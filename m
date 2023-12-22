Return-Path: <linux-kernel+bounces-9844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8901681CC48
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18BD41F22405
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A734823774;
	Fri, 22 Dec 2023 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dF5I1J3t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4825D23768
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2330a92ae6so249173466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 07:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703259247; x=1703864047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucQpKyhkJH6aCcPXYD2Sb2IO6f28+WRJaLTnE9HJbWo=;
        b=dF5I1J3t17gOl3ijfs4UR7OCs0gFXy3bG0Cc8h34O9b8S+tVHylSkDzIDMosWh0FYH
         fu4b4f7uCleVEO0Pzwp53/GQ9OuFUrM9qxDmguK+Fj/+70/L1jJu5OIY2RPv92WTMrJh
         5Y9Sl9hKm2y+zZ9l83FgNMr/0Xtu9sjnEeVzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703259247; x=1703864047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucQpKyhkJH6aCcPXYD2Sb2IO6f28+WRJaLTnE9HJbWo=;
        b=szFr2M3UeGUisxaa3OZyVSg6KpkiVTVjWFVQKcEMHc141N48xe3uyYJzcNpOuqnYyp
         ZaU4TSn2CWYmTXheLdC3zVYCRPVknjMbsGkT1xVQMml8p7PrELA9tWFgYHak5QHnjGwm
         FsRU8Yq6HAw+ZGpUfTMVS70AEqx8PTr0Mw4LNDPi8tXkhyiIs/8tB1M3+f4ASgi6NGTd
         CETcNrkbn2iQu2u/o4ZN7W2JAmSkBUahWARBICbmRiHZ50AJsrsdeGGcjRmu+rL8Q6mR
         qYH/ac/hJqipfmNpZyzVc30C7W1tATNMbtXQnKevdHjwG+ImRE8f6M/P5a7D5qgo1HST
         89Mw==
X-Gm-Message-State: AOJu0Yy8XhKMHZH/FGJl3kKiGpWobgF1LvHGX6farOehv77ThY49ZPCv
	2wIyiOSu4BC0Df5cIGSsQqG79DY3tXLXUo/6Z726JEFFL8Ri
X-Google-Smtp-Source: AGHT+IHOWykweNm2fdFim3B7wYDMQs1cnkjwpBTjx4+1pc0N9FbG77g/oExWfn7IW5SEV2cC3Nlqzw==
X-Received: by 2002:a17:906:5901:b0:a26:af1a:2bb6 with SMTP id h1-20020a170906590100b00a26af1a2bb6mr863748ejq.3.1703259246899;
        Fri, 22 Dec 2023 07:34:06 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id x22-20020a170906135600b00a235f3b8259sm2122632ejb.186.2023.12.22.07.34.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Dec 2023 07:34:06 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d3b2c8517so48545e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 07:34:05 -0800 (PST)
X-Received: by 2002:a05:600c:210d:b0:40d:3ab7:86e0 with SMTP id
 u13-20020a05600c210d00b0040d3ab786e0mr104331wml.3.1703259244872; Fri, 22 Dec
 2023 07:34:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221135548.1.I10f326a9305d57ad32cee7f8d9c60518c8be20fb@changeid>
 <CAEXTbpdUjCvLE+m3d1vSvsE2njRSk1Ou3bZZGEvD_7oYt4+k4Q@mail.gmail.com>
In-Reply-To: <CAEXTbpdUjCvLE+m3d1vSvsE2njRSk1Ou3bZZGEvD_7oYt4+k4Q@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 22 Dec 2023 07:33:48 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WDb7y-9dRgb0D=VxVB6EjUkcOJ+9D0Mp0-vw6wuKUHEg@mail.gmail.com>
Message-ID: <CAD=FV=WDb7y-9dRgb0D=VxVB6EjUkcOJ+9D0Mp0-vw6wuKUHEg@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: parade-ps8640: Wait for HPD when doing an AUX transfer
To: Pin-yen Lin <treapking@chromium.org>
Cc: dri-devel@lists.freedesktop.org, hsinyi@chromium.org, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 22, 2023 at 2:29=E2=80=AFAM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> Hi Douglas,
>
> On Fri, Dec 22, 2023 at 5:56=E2=80=AFAM Douglas Anderson <dianders@chromi=
um.org> wrote:
> >
> > Unlike what is claimed in commit f5aa7d46b0ee ("drm/bridge:
> > parade-ps8640: Provide wait_hpd_asserted() in struct drm_dp_aux"), if
> > someone manually tries to do an AUX transfer (like via `i2cdump ${bus}
> > 0x50 i`) while the panel is off we don't just get a simple transfer
> > error. Instead, the whole ps8640 gets thrown for a loop and goes into
> > a bad state.
> >
> > Let's put the function to wait for the HPD (and the magical 50 ms
> > after first reset) back in when we're doing an AUX transfer. This
> > shouldn't actually make things much slower (assuming the panel is on)
> > because we should immediately poll and see the HPD high. Mostly this
> > is just an extra i2c transfer to the bridge.
> >
> > Fixes: f5aa7d46b0ee ("drm/bridge: parade-ps8640: Provide wait_hpd_asser=
ted() in struct drm_dp_aux")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  drivers/gpu/drm/bridge/parade-ps8640.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/b=
ridge/parade-ps8640.c
> > index 541e4f5afc4c..fb5e9ae9ad81 100644
> > --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> > +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> > @@ -346,6 +346,11 @@ static ssize_t ps8640_aux_transfer(struct drm_dp_a=
ux *aux,
> >         int ret;
> >
> >         pm_runtime_get_sync(dev);
> > +       ret =3D _ps8640_wait_hpd_asserted(ps_bridge, 200 * 1000);
> > +       if (ret) {
> > +               pm_runtime_put_sync_suspend(dev);
> > +               return ret;
> > +       }
> >         ret =3D ps8640_aux_transfer_msg(aux, msg);
> >         pm_runtime_mark_last_busy(dev);
> >         pm_runtime_put_autosuspend(dev);
> > --
> > 2.43.0.472.g3155946c3a-goog
> >
>
> I think commit 9294914dd550 ("drm/bridge: parade-ps8640: Link device
> to ensure suspend/resume order")  is trying to address the same
> problem, but we see this issue here because the device link is missing
> DL_FLAG_PM_RUNTIME. I prefer to add DL_FLAG_PM_RUNTIME here so we
> don't need to add a _ps8640_wait_hpd_asserted() after every
> pm_runtime_get_*() call.

I disagree. We've had several discussions on the lists about this
topic before, though since I'm technically on vacation right now I'm
not going to go look them up. In general "pm_runtime" is not
sufficient for powering up DRM components. While DRM components can
use pm_runtime themselves (as we are doing here), powering up another
DRM component by grabbing a pm_runtime reference isn't right. There is
a reason for the complexity of the DRM prepare/enable and all the
current debates about the right order to call components in prepare()
just demonstrates further that a simple pm_runtime reference isn't
enough.

It can be noted that, with ${SUBJECT} patch we _aren't_ powering up
the panel. I actually tested two cases on sc7180-lazor. In one case I
just closed the lid, which powered off the panel, but the touchscreen
kept the panel power rail on. In this case with my patch I could still
read the panel EDID. I then hacked the touchscreen off. Now when I
closed the lid I'd get a timeout. This is different than if we tried
to get a pm_runtime reference to the panel.


> As a side note, I've verified both this patch and DL_FLAG_PM_RUNTIME
> in our downstream v5.15 kernel and panel-edp driver. Both of them
> successfully wait for HPD asserted when the timeout used to happen,
> but the panel is black in that situation. That being said, this patch
> still brings us to a better state. Originally, panel_edp_resume()
> would return an error when the timeout occurs, so the panel-edp driver
> is stuck at an unexpected state. With this patch or
> DL_FLAG_PM_RUNTIME, the runtime PM callbacks won't fail and a system
> suspend/resume brings the panel back.

OK. I'm going to shut off email for real this time while I enjoy some
time off. Hopefully the above convinces you. Otherwise I guess we can
continue to debate in mid-January.

-Doug

