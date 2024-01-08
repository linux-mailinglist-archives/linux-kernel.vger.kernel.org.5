Return-Path: <linux-kernel+bounces-20163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D97827AD6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 23:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B542EB22F5B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 22:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093415476B;
	Mon,  8 Jan 2024 22:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XbwONi9/"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B0F537E0
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 22:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a26fa294e56so226880166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 14:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704754017; x=1705358817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Un2/baPM1eoyR6xBkggDdw0l2aptAfl7q01gFgzCYH8=;
        b=XbwONi9/uH6GSmlipZlR7TeypACE3CwLECzL/4Gkuo2sQPmsRwflMR1syGvxsEiC/n
         ak33W402r+QDzSMM2qpsCc7SrJfWAZPO3jiYppdRIUYCZVmHYgaXYEIhWZ2wvocIuPB7
         z+lypyBKeV4vQnYi5mGDc12onVaSs4jlgAFf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704754017; x=1705358817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Un2/baPM1eoyR6xBkggDdw0l2aptAfl7q01gFgzCYH8=;
        b=CCbodbg9qtCzD8HMC+hH0kTJwanfSf1Th6di+0QPCGCpd4ShNSrvK1zjHGij9OmX61
         6WqAr8zobo3yCLyqHn7l0z2BE6PKkw5vP+q9hCa50gPAsSwgcTUqCX2wWKDR6EJkbg/B
         yj1rax/UJmbChsUACr4jMh3Kg3cwIHLa5Qwy0OEhFYUdAkgzTJEdLCKoU3ETEiqiABJl
         8cimp0z4j5K2XM/6Es08vdFmnYhm9CGVGNwhGLxLta925Vt4gaprHTDfQObOz13BAkLX
         3/QOoPZZaGK1uaxWLSBv/QH6BokY9KMmg6mb/sfBqrlZll9rpxYKWEEIfc1/CEd+2T21
         iU2A==
X-Gm-Message-State: AOJu0Ywe6d92pc3M9V7zICIZwRx13hT6Pm7LU7Vsv9VjrI5CHQeR7Q5F
	B+x4q6mck1lE6ztDacRVuUbVFE5vx9Hrj6v58tTawwjVeb06V8c=
X-Google-Smtp-Source: AGHT+IEPzwHngWayjaBOuk/3gWa5J5oaIed3b52AOu5EtGm4ns5WkiK7MXd6SxG/FziTS20avnaR2g==
X-Received: by 2002:a17:906:af89:b0:a28:a8dc:67a8 with SMTP id mj9-20020a170906af8900b00a28a8dc67a8mr53551ejb.89.1704754017083;
        Mon, 08 Jan 2024 14:46:57 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id l13-20020a17090612cd00b00a281f88f2ebsm333405ejb.38.2024.01.08.14.46.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 14:46:56 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e4afe9ea7so6155e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 14:46:56 -0800 (PST)
X-Received: by 2002:a05:600c:600a:b0:40e:4686:7c95 with SMTP id
 az10-20020a05600c600a00b0040e46867c95mr10764wmb.1.1704754016032; Mon, 08 Jan
 2024 14:46:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231227104324.2457378-1-treapking@chromium.org>
In-Reply-To: <20231227104324.2457378-1-treapking@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 8 Jan 2024 14:46:40 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XjpSbqJ=qb0BiuUCAww6=OLHuxxSot6o_u_vKYBYQ57w@mail.gmail.com>
Message-ID: <CAD=FV=XjpSbqJ=qb0BiuUCAww6=OLHuxxSot6o_u_vKYBYQ57w@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: parade-ps8640: Ensure bridge is suspended in .post_disable()
To: Pin-yen Lin <treapking@chromium.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 27, 2023 at 2:43=E2=80=AFAM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> Disable the autosuspend of runtime PM and use completion to make sure
> ps8640_suspend() is called in ps8640_atomic_post_disable().
>
> The ps8640 bridge seems to expect everything to be power cycled at the
> disable process, but sometimes ps8640_aux_transfer() holds the runtime
> PM reference and prevents the bridge from suspend.
>
> Instead of force powering off the bridge and taking the risk of breaking
> the AUX communication, disable the autosuspend and wait for
> ps8640_suspend() being called here, and re-enable the autosuspend
> afterwards.  With this approach, the bridge should be suspended after
> the current ps8640_aux_transfer() completes.
>
> Fixes: 826cff3f7ebb ("drm/bridge: parade-ps8640: Enable runtime power man=
agement")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> ---
>
>  drivers/gpu/drm/bridge/parade-ps8640.c | 33 +++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bri=
dge/parade-ps8640.c
> index 8161b1a1a4b1..f8ea486a76fd 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -107,6 +107,7 @@ struct ps8640 {
>         struct device_link *link;
>         bool pre_enabled;
>         bool need_post_hpd_delay;
> +       struct completion suspend_completion;
>  };
>
>  static const struct regmap_config ps8640_regmap_config[] =3D {
> @@ -417,6 +418,8 @@ static int __maybe_unused ps8640_suspend(struct devic=
e *dev)
>         if (ret < 0)
>                 dev_err(dev, "cannot disable regulators %d\n", ret);
>
> +       complete_all(&ps_bridge->suspend_completion);
> +
>         return ret;
>  }
>
> @@ -465,11 +468,37 @@ static void ps8640_atomic_post_disable(struct drm_b=
ridge *bridge,
>                                        struct drm_bridge_state *old_bridg=
e_state)
>  {
>         struct ps8640 *ps_bridge =3D bridge_to_ps8640(bridge);
> +       struct device *dev =3D &ps_bridge->page[PAGE0_DP_CNTL]->dev;
>
>         ps_bridge->pre_enabled =3D false;
>
>         ps8640_bridge_vdo_control(ps_bridge, DISABLE);
> -       pm_runtime_put_sync_suspend(&ps_bridge->page[PAGE0_DP_CNTL]->dev)=
;
> +
> +       /*
> +        * The ps8640 bridge seems to expect everything to be power cycle=
d at
> +        * the disable process, but sometimes ps8640_aux_transfer() holds=
 the
> +        * runtime PM reference and prevents the bridge from suspend.
> +        * Instead of force powering off the bridge and taking the risk o=
f
> +        * breaking the AUX communication, disable the autosuspend and wa=
it for
> +        * ps8640_suspend() being called here, and re-enable the autosusp=
end
> +        * afterwards.  With this approach, the bridge should be suspende=
d after
> +        * the current ps8640_aux_transfer() completes.
> +        */
> +       reinit_completion(&ps_bridge->suspend_completion);
> +       pm_runtime_dont_use_autosuspend(dev);
> +       pm_runtime_put_sync_suspend(dev);
> +
> +       /*
> +        * Mostly the suspend completes under 10 ms, but sometimes it cou=
ld
> +        * take 708 ms to complete.  Set the timeout to 2000 ms here to b=
e
> +        * extra safe.
> +        */
> +       if (!wait_for_completion_timeout(&ps_bridge->suspend_completion,
> +                                        msecs_to_jiffies(2000))) {
> +               dev_warn(dev, "Failed to wait for the suspend completion\=
n");
> +       }
> +
> +       pm_runtime_use_autosuspend(dev);

Thanks for tracking this down! I agree with your analysis and it seems
like we've got to do something about it.

I spent a little time trying to think about a cleaner way. What do you
think about adding a "aux_transfer" mutex? You'd grab this mutex for
the entire duration of ps8640_aux_transfer() and
ps8640_atomic_post_disable(). That way you don't need the weird
completion / timeout and don't need to hackily turn off/on
autosuspend. You shouldn't need the mutex in
ps8640_wait_hpd_asserted() because that will never be called at the
same time as ps8640_atomic_post_disable().

-Doug

