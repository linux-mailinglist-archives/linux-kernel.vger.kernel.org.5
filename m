Return-Path: <linux-kernel+bounces-9594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D373281C822
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740891F255D6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D9612B65;
	Fri, 22 Dec 2023 10:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T9kFsVta"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258A31171B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 10:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-35fe06eaa98so1072875ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 02:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703240973; x=1703845773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brq1T/lyerRADPyPeuRz+yr9zN9tHk+LiXSNCxx5F14=;
        b=T9kFsVtaKth+COG+Rq2lKFvDzDEFyergW5AufQqcQhivKnwKtePiVgY95Zy5hyvXGp
         3MXswS57AnqeCSzj3QqJKjixzbhp7hWEJVa+Hlu8qxZoiWALl9pYBjfNY83NFhwh5B4v
         vAB/f7YpQ8dJN7IoIs8Yl3eBQTG6ioADE1nFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703240973; x=1703845773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brq1T/lyerRADPyPeuRz+yr9zN9tHk+LiXSNCxx5F14=;
        b=FOmEawClq3kSo0mZOBapaZuftKNbNjOqLjDTj2hNNTAYgoEATBnbINguVKNXv7fF10
         QEfOiXt/JGatqTMB04BDMAo4DxR5XRZR8swaWmJTtsM8TxxOsFeBNoOBFC+CjJGapF4k
         NBda1hrmzQeiB+G86TwoRrEgs/Xb8x1wSg9sypVpTv9xCFAkAAtBeNVvNzumG2D1OEPq
         Lof/sGcnKVClhfStatg5KVFbWiSDNODGgaKgE3pqIAYg4S4i08NYS2BTP0UYqAUYApW4
         UlSzAAhCWDBQb7Iuw5igkvCN4I6f32GxVJZGn7ySgKlqV45+p0sNif2hIJTlh+ZYH1bl
         85wg==
X-Gm-Message-State: AOJu0YwNThl3f7gj1/g/FI77PTdQxDdi/uqNkqsVaMbt2oa12475k5XY
	0FqMPD874W9SB/q8+AL0bUQwGMUZIkMmqXefSOlHy71oNxiF
X-Google-Smtp-Source: AGHT+IGvrKFDeGj25WNuCS4lB0+NQrxaQYKp7xXqCv5+JXzuRUdQd0UcrSJMJKObEXgx5sd0qBDQHdtXf67CF1+t2Bg=
X-Received: by 2002:a05:6e02:1a09:b0:35f:b3d8:4568 with SMTP id
 s9-20020a056e021a0900b0035fb3d84568mr1279180ild.20.1703240973184; Fri, 22 Dec
 2023 02:29:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221135548.1.I10f326a9305d57ad32cee7f8d9c60518c8be20fb@changeid>
In-Reply-To: <20231221135548.1.I10f326a9305d57ad32cee7f8d9c60518c8be20fb@changeid>
From: Pin-yen Lin <treapking@chromium.org>
Date: Fri, 22 Dec 2023 18:29:22 +0800
Message-ID: <CAEXTbpdUjCvLE+m3d1vSvsE2njRSk1Ou3bZZGEvD_7oYt4+k4Q@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: parade-ps8640: Wait for HPD when doing an AUX transfer
To: Douglas Anderson <dianders@chromium.org>
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

Hi Douglas,

On Fri, Dec 22, 2023 at 5:56=E2=80=AFAM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> Unlike what is claimed in commit f5aa7d46b0ee ("drm/bridge:
> parade-ps8640: Provide wait_hpd_asserted() in struct drm_dp_aux"), if
> someone manually tries to do an AUX transfer (like via `i2cdump ${bus}
> 0x50 i`) while the panel is off we don't just get a simple transfer
> error. Instead, the whole ps8640 gets thrown for a loop and goes into
> a bad state.
>
> Let's put the function to wait for the HPD (and the magical 50 ms
> after first reset) back in when we're doing an AUX transfer. This
> shouldn't actually make things much slower (assuming the panel is on)
> because we should immediately poll and see the HPD high. Mostly this
> is just an extra i2c transfer to the bridge.
>
> Fixes: f5aa7d46b0ee ("drm/bridge: parade-ps8640: Provide wait_hpd_asserte=
d() in struct drm_dp_aux")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/gpu/drm/bridge/parade-ps8640.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bri=
dge/parade-ps8640.c
> index 541e4f5afc4c..fb5e9ae9ad81 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -346,6 +346,11 @@ static ssize_t ps8640_aux_transfer(struct drm_dp_aux=
 *aux,
>         int ret;
>
>         pm_runtime_get_sync(dev);
> +       ret =3D _ps8640_wait_hpd_asserted(ps_bridge, 200 * 1000);
> +       if (ret) {
> +               pm_runtime_put_sync_suspend(dev);
> +               return ret;
> +       }
>         ret =3D ps8640_aux_transfer_msg(aux, msg);
>         pm_runtime_mark_last_busy(dev);
>         pm_runtime_put_autosuspend(dev);
> --
> 2.43.0.472.g3155946c3a-goog
>

I think commit 9294914dd550 ("drm/bridge: parade-ps8640: Link device
to ensure suspend/resume order")  is trying to address the same
problem, but we see this issue here because the device link is missing
DL_FLAG_PM_RUNTIME. I prefer to add DL_FLAG_PM_RUNTIME here so we
don't need to add a _ps8640_wait_hpd_asserted() after every
pm_runtime_get_*() call.

As a side note, I've verified both this patch and DL_FLAG_PM_RUNTIME
in our downstream v5.15 kernel and panel-edp driver. Both of them
successfully wait for HPD asserted when the timeout used to happen,
but the panel is black in that situation. That being said, this patch
still brings us to a better state. Originally, panel_edp_resume()
would return an error when the timeout occurs, so the panel-edp driver
is stuck at an unexpected state. With this patch or
DL_FLAG_PM_RUNTIME, the runtime PM callbacks won't fail and a system
suspend/resume brings the panel back.

Regards,
Pin-yen

