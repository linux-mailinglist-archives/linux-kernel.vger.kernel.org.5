Return-Path: <linux-kernel+bounces-20809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 497AA828580
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC88428757C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAD4374EF;
	Tue,  9 Jan 2024 11:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P8vOk6nd"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E33B374DA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 11:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-36074b286d8so16773775ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 03:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704801096; x=1705405896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlbBXaJ6QChQt8nzvFhN1UrWQRmEjHRHlNEfK3vCyiA=;
        b=P8vOk6ndu33X0gIwHWcPRSSBuw+R0ErKCx/uOMIFDfaOrAvI5eMfgwSfBXN2LstG6P
         xBlCkHUVE/Zo+SjXnG0faQrWkQ0VCf+YDpYS/wmgt05aDl+AH72oc5IADEyEIbth1Mj8
         UI6u+sAfWOhKjjJ+uLlQSX6F6RDlEz8NOd2Ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704801096; x=1705405896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QlbBXaJ6QChQt8nzvFhN1UrWQRmEjHRHlNEfK3vCyiA=;
        b=DNUJhZc/w9WHAkZ/7WkEHvIWpBefzT/0Ee0SvLkSnJOg4hst+WZ+GTL2Ct4zxrTndS
         OXr3mOMHKwevJ1AV0d/L7Vjc4YCFy+Z1RiKuoC7BcvozsZfJXoaiPh6UOg4OiiW4J3td
         MbqblLhUuWR7YgV/nyU8Hpj7VY5jSmoSvXb8VB4XM4ZQp/X8oxhouS/166proZMS3p6H
         FmKuWa6INJJVfjp2USIg5ZPE9AXjWarGcuO4s35/hb/6k4KAkqHeD9OPMedD3YqMfI4g
         J6UWDMKMOvMZjxMIp9FyF7YPzfZ7ibsNuma4U7Wu51b9ezLO9nF5Yy1sU9ZWOck2s6aY
         Cpeg==
X-Gm-Message-State: AOJu0YzZy3PA2fz7ETW1xOSuZ6Y1G/hUQu66AkQx73J+PDjFjKmxF5Xz
	xh+epcp5unLIHe6bpAKQ2PZdUYQoefbBZ4MdWXEPVDHDiCg2
X-Google-Smtp-Source: AGHT+IHRwiVkHQh7SIX/3ly4K5QyIfRTw+mMqjEYhSXlsigfyCwTnTznpzS7qg1nRmeOf6u2xNSfwd3Ho+G/zv51xUQ=
X-Received: by 2002:a92:c243:0:b0:35f:eb24:6bbe with SMTP id
 k3-20020a92c243000000b0035feb246bbemr7884021ilo.41.1704801096603; Tue, 09 Jan
 2024 03:51:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231227104324.2457378-1-treapking@chromium.org> <CAD=FV=XjpSbqJ=qb0BiuUCAww6=OLHuxxSot6o_u_vKYBYQ57w@mail.gmail.com>
In-Reply-To: <CAD=FV=XjpSbqJ=qb0BiuUCAww6=OLHuxxSot6o_u_vKYBYQ57w@mail.gmail.com>
From: Pin-yen Lin <treapking@chromium.org>
Date: Tue, 9 Jan 2024 19:51:25 +0800
Message-ID: <CAEXTbpdrjSGczw12CB7=GGKRywpROWvS73SdgYEq5o4kQTSk9w@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: parade-ps8640: Ensure bridge is suspended in .post_disable()
To: Doug Anderson <dianders@chromium.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Doug,

On Tue, Jan 9, 2024 at 6:46=E2=80=AFAM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Wed, Dec 27, 2023 at 2:43=E2=80=AFAM Pin-yen Lin <treapking@chromium.o=
rg> wrote:
> >
> > Disable the autosuspend of runtime PM and use completion to make sure
> > ps8640_suspend() is called in ps8640_atomic_post_disable().
> >
> > The ps8640 bridge seems to expect everything to be power cycled at the
> > disable process, but sometimes ps8640_aux_transfer() holds the runtime
> > PM reference and prevents the bridge from suspend.
> >
> > Instead of force powering off the bridge and taking the risk of breakin=
g
> > the AUX communication, disable the autosuspend and wait for
> > ps8640_suspend() being called here, and re-enable the autosuspend
> > afterwards.  With this approach, the bridge should be suspended after
> > the current ps8640_aux_transfer() completes.
> >
> > Fixes: 826cff3f7ebb ("drm/bridge: parade-ps8640: Enable runtime power m=
anagement")
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > ---
> >
> >  drivers/gpu/drm/bridge/parade-ps8640.c | 33 +++++++++++++++++++++++++-
> >  1 file changed, 32 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/b=
ridge/parade-ps8640.c
> > index 8161b1a1a4b1..f8ea486a76fd 100644
> > --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> > +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> > @@ -107,6 +107,7 @@ struct ps8640 {
> >         struct device_link *link;
> >         bool pre_enabled;
> >         bool need_post_hpd_delay;
> > +       struct completion suspend_completion;
> >  };
> >
> >  static const struct regmap_config ps8640_regmap_config[] =3D {
> > @@ -417,6 +418,8 @@ static int __maybe_unused ps8640_suspend(struct dev=
ice *dev)
> >         if (ret < 0)
> >                 dev_err(dev, "cannot disable regulators %d\n", ret);
> >
> > +       complete_all(&ps_bridge->suspend_completion);
> > +
> >         return ret;
> >  }
> >
> > @@ -465,11 +468,37 @@ static void ps8640_atomic_post_disable(struct drm=
_bridge *bridge,
> >                                        struct drm_bridge_state *old_bri=
dge_state)
> >  {
> >         struct ps8640 *ps_bridge =3D bridge_to_ps8640(bridge);
> > +       struct device *dev =3D &ps_bridge->page[PAGE0_DP_CNTL]->dev;
> >
> >         ps_bridge->pre_enabled =3D false;
> >
> >         ps8640_bridge_vdo_control(ps_bridge, DISABLE);
> > -       pm_runtime_put_sync_suspend(&ps_bridge->page[PAGE0_DP_CNTL]->de=
v);
> > +
> > +       /*
> > +        * The ps8640 bridge seems to expect everything to be power cyc=
led at
> > +        * the disable process, but sometimes ps8640_aux_transfer() hol=
ds the
> > +        * runtime PM reference and prevents the bridge from suspend.
> > +        * Instead of force powering off the bridge and taking the risk=
 of
> > +        * breaking the AUX communication, disable the autosuspend and =
wait for
> > +        * ps8640_suspend() being called here, and re-enable the autosu=
spend
> > +        * afterwards.  With this approach, the bridge should be suspen=
ded after
> > +        * the current ps8640_aux_transfer() completes.
> > +        */
> > +       reinit_completion(&ps_bridge->suspend_completion);
> > +       pm_runtime_dont_use_autosuspend(dev);
> > +       pm_runtime_put_sync_suspend(dev);
> > +
> > +       /*
> > +        * Mostly the suspend completes under 10 ms, but sometimes it c=
ould
> > +        * take 708 ms to complete.  Set the timeout to 2000 ms here to=
 be
> > +        * extra safe.
> > +        */
> > +       if (!wait_for_completion_timeout(&ps_bridge->suspend_completion=
,
> > +                                        msecs_to_jiffies(2000))) {
> > +               dev_warn(dev, "Failed to wait for the suspend completio=
n\n");
> > +       }
> > +
> > +       pm_runtime_use_autosuspend(dev);
>
> Thanks for tracking this down! I agree with your analysis and it seems
> like we've got to do something about it.
>
> I spent a little time trying to think about a cleaner way. What do you
> think about adding a "aux_transfer" mutex? You'd grab this mutex for
> the entire duration of ps8640_aux_transfer() and
> ps8640_atomic_post_disable(). That way you don't need the weird
> completion / timeout and don't need to hackily turn off/on
> autosuspend. You shouldn't need the mutex in
> ps8640_wait_hpd_asserted() because that will never be called at the
> same time as ps8640_atomic_post_disable().
>
> -Doug

Hi Doug,

Thanks for the suggestion! I tried that approach and it fixes the issue as =
well.

I'll send out another patch with that approach.

Regards,
Pin-yen

