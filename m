Return-Path: <linux-kernel+bounces-132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C17FC813C9E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3571F227A9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAFC697B1;
	Thu, 14 Dec 2023 21:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JMWmbv94"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09206DCE5
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-425928c24easo88981cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 13:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702589338; x=1703194138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ah2gK9Uj0gVfSzL+u/hE078nNe1nFkMMAMYpMKEH2ZU=;
        b=JMWmbv947Bdl2I4/Bbu2xSKwq6xrNTzb6GOQJN37wCWcPBrYrZphF2NGXO7Mp5D0M4
         cyO7Y46VCWEnRMDfGszcoiGpkbar7Wn3092acEOZFBwNk+fru7FxlSTOTdt6YSGg26fX
         83PHI3l+o6U8/2wYo+eKYHZ83bqkeWIt+FjMyGTFYS5UneVi6wwXsXE/CFaKTePSbILm
         59joqfvMAX9Z9YTviOk0Hm2GXD6HoAHpmObOmhOncJf1hR2wnql5NHEPOXDcafPo8vRZ
         qJJfGWqZOJPCtYefkzoSNK+hfdyO5l58Zvk0PW+VV3ykQv5Auoj5Mdqoh6AugdJhqJbx
         GUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702589338; x=1703194138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ah2gK9Uj0gVfSzL+u/hE078nNe1nFkMMAMYpMKEH2ZU=;
        b=JBTXCXaJGmzNQ0CXFiARnyfFN0l2TmcNWOMFEN3UbTSm7bilRKPPb0GIL0CQaOth3S
         5mWlIsNsu1w1Oy8WPqMZ9GQO7mioUP/c8q1adx7z2SZlh3RRAR/f3PFWCzP9iH0tv04F
         5uHyI5+GwXn5Ri50Mkeql9+6QBj5U1dpRgvINoH+DMfKQ1RuO3ifWVXs+NqxjH5DQL3q
         7EfO7vpAiwmIhZMzMsgEGk0H3jOgFklZNiM9w/K3mWhB4l/Qr/8GPdPXgm283kjyjpH/
         0pQ1SVmpqjcmT1+mP3vPp2c0wWySbwy83lWWOKp+cgUnoYBCitR63+74mdO3Uq5uvclx
         CwRg==
X-Gm-Message-State: AOJu0YxQkYPqeM4E7E6uLrKAcF52dyaQK7WQUMH3J5DPGFzPCJ0+mD2t
	Okc5McxgFVoD5QXk3j0xbMd2uvOP2eV2HGaxjD4f+g==
X-Google-Smtp-Source: AGHT+IGsgqscYuF5hH9ltzFa1Bxwwapx6LhlySDEegatFrOZV15dVK4icP+0aT/U3BK3Vw6AJOZGGmMq7pwL8YnU/oU=
X-Received: by 2002:a05:622a:19a9:b0:425:9771:a5f3 with SMTP id
 u41-20020a05622a19a900b004259771a5f3mr1882119qtc.10.1702589338237; Thu, 14
 Dec 2023 13:28:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214123752.v3.1.I9d1afcaad76a3e2c0ca046dc4adbc2b632c22eda@changeid>
 <20231214123752.v3.2.I7b83c0f31aeedc6b1dc98c7c741d3e1f94f040f8@changeid>
In-Reply-To: <20231214123752.v3.2.I7b83c0f31aeedc6b1dc98c7c741d3e1f94f040f8@changeid>
From: Guenter Roeck <groeck@google.com>
Date: Thu, 14 Dec 2023 13:28:47 -0800
Message-ID: <CABXOdTdfuw5e4QKb07-yuTAwx0JxLDJKmVVg3pfpoLi2sWq0-w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/bridge: ti-sn65dsi86: Never store more than
 msg->size bytes in AUX xfer
To: Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Guenter Roeck <groeck@chromium.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Sam Ravnborg <sam@ravnborg.org>, Stephen Boyd <swboyd@chromium.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 12:38=E2=80=AFPM Douglas Anderson <dianders@chromiu=
m.org> wrote:
>
> For aux reads, the value `msg->size` indicates the size of the buffer
> provided by `msg->buffer`. We should never in any circumstances write
> more bytes to the buffer since it may overflow the buffer.
>
> In the ti-sn65dsi86 driver there is one code path that reads the
> transfer length from hardware. Even though it's never been seen to be
> a problem, we should make extra sure that the hardware isn't
> increasing the length since doing so would cause us to overrun the
> buffer.
>
> Fixes: 982f589bde7a ("drm/bridge: ti-sn65dsi86: Update reply on aux failu=
res")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Updated patch subject to match ps8640 patch.
>
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi86.c
> index 9095d1453710..62cc3893dca5 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -527,6 +527,7 @@ static ssize_t ti_sn_aux_transfer(struct drm_dp_aux *=
aux,
>         u32 request_val =3D AUX_CMD_REQ(msg->request);
>         u8 *buf =3D msg->buffer;
>         unsigned int len =3D msg->size;
> +       unsigned int short_len;
>         unsigned int val;
>         int ret;
>         u8 addr_len[SN_AUX_LENGTH_REG + 1 - SN_AUX_ADDR_19_16_REG];
> @@ -600,7 +601,8 @@ static ssize_t ti_sn_aux_transfer(struct drm_dp_aux *=
aux,
>         }
>
>         if (val & AUX_IRQ_STATUS_AUX_SHORT) {
> -               ret =3D regmap_read(pdata->regmap, SN_AUX_LENGTH_REG, &le=
n);
> +               ret =3D regmap_read(pdata->regmap, SN_AUX_LENGTH_REG, &sh=
ort_len);
> +               len =3D min(len, short_len);
>                 if (ret)
>                         goto exit;
>         } else if (val & AUX_IRQ_STATUS_NAT_I2C_FAIL) {
> --
> 2.43.0.472.g3155946c3a-goog
>

