Return-Path: <linux-kernel+bounces-77222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8B3860267
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5086B2F46F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E1A6AFB8;
	Thu, 22 Feb 2024 19:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="at+/eijH"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2646AAD;
	Thu, 22 Feb 2024 19:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708628944; cv=none; b=uoMRybqwzgM3UeaoXaq9r3dXNuhl3BFy3JbwOm5Ijkby/gkdZ80ham/mzZGU2RzX5rBmFcv7uFqB51WHtSw+1W9kmi7m/ykFc0UsYHm0T091i3H/LVHvTgs0aA4e2St2j/56UFbctsz3JJRtutdalLBloWB8tYLL4xS1F59shY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708628944; c=relaxed/simple;
	bh=RJ0wnZP3bPYHw5LH8oH4Ou1+0h6qBwHl/euNr1MM60c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pKPQj1iinX4+HQq3B2o8qYiOZU62mxHQT0H3lP5K15MiTzMWhFuBHz9Zr1cGDLvyXDC8Gi9SbvSdImlBIrh07n5AEoQ/FvNKPCD0UeEUup+TpaBba5w8vOktU2GgXPB303EKO3tmBaQPSyjQpS3nnDrSS+7nnfrXxvDoSxMzuRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=at+/eijH; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d22b8801b9so2252601fa.0;
        Thu, 22 Feb 2024 11:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708628941; x=1709233741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gj4OdywnDrbhFJ8ybCj43LZc89cJ1Nm8au4Dqi6GFss=;
        b=at+/eijH+MZcw/2iI9hvboXH0p1EI6ISd9cK5gdaLGWVCkhrhG0eWXRB1gfrUrP8RA
         apI4UmqUWR4/IsNbMm5ZkGmS/9CdphdfDRRnHykbOd4dKNtZ3N4ELs92fuXm32MFn2q+
         SeKlL8RC0xjXLw4fpDWs5/QrFRWWapUq63CbMcJOndg8CKjbD65mf5f+GFluVRGde+Zb
         P8cN8StmzliYmKUzzlOlajTjSiZGUaeZKbeiIVFI4xTuZqBX8yiBbrrtVZTmdg6mcl2Y
         9x7/VxuqgZm6rPZvQm3PSgrxeQe0zw9Ux6yON0BePUquWihIJWYhOBaW22HZpelUuJAg
         9kUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708628941; x=1709233741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gj4OdywnDrbhFJ8ybCj43LZc89cJ1Nm8au4Dqi6GFss=;
        b=OHqfEyLGHHTnJRt88EnTimmmG3M1zYVY2XHl5hoyqTXUMTmgRus4Z6D6Di56pbCBeO
         M4DopVz9tqtIrTtyKXiSKjoTxCxqTK652AfghpvWYsOHC6cBMHWL/XmCtKsTjtOaL7Mc
         dbeBv+WCKY9F6dp4EkcZOnmMIQt3G6VlCULjWK2r4OWVq18b7E9Tt1j1H6hBqGytKi7R
         Nm7za8yGRvos4YuI/+5vYdocQ7eOvhwhi4oCaOKGOTAxA5M888hMxpu7Cseds1GO+zQA
         5MBRg618f+7qrQKBNueURkt3Og1zX4PkC8wF0BUO8z5UPr7BItr04jD1o3Zzga6oALE8
         5TIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBo5E8Uv+vxuWeAP33TF1Rf01z/ov+RzvI7k4c4jQMatOu8NC5WXDc51gTdMP8j8YUySBlGnJNq7/glLLn/D4hPHu5sTmqfpoh/SMIL3RqONo32bZTDLkEsBl0UVoISeMFumKajuIJ1f6tYQyRB3iZKItsgHuJuIfkrySxvx5tBiNYXog=
X-Gm-Message-State: AOJu0YyW2TZX3VEMK8kD+vkmu+0Uuy81jEX6NWVqXPwHqh8MHMKNlJAs
	fA9ZdXlaIvrB6IIjLJX25nTRbtXX0ukCUx9vSr2nHswesOtPM4N6
X-Google-Smtp-Source: AGHT+IHe4b3hq/UBTGy8TGAsD8s1quxqZkNvTf7s10vKGsFhX0a+cS0Vaxi79AU03ziWQo+MQ29JhA==
X-Received: by 2002:a05:651c:210f:b0:2d2:6574:4011 with SMTP id a15-20020a05651c210f00b002d265744011mr1451054ljq.30.1708628940711;
        Thu, 22 Feb 2024 11:09:00 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id g14-20020a056402428e00b005642bcfed99sm5293270edc.23.2024.02.22.11.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 11:09:00 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Maxime Ripard <mripard@kernel.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>,
 Sebastian Wick <sebastian.wick@redhat.com>,
 Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-sunxi@lists.linux.dev, Maxime Ripard <mripard@kernel.org>,
 Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: Re: [PATCH v7 34/36] drm/sun4i: hdmi: Switch to container_of_const
Date: Thu, 22 Feb 2024 20:08:58 +0100
Message-ID: <2172115.irdbgypaU6@jernej-laptop>
In-Reply-To: <20240222-kms-hdmi-connector-state-v7-34-8f4af575fce2@kernel.org>
References:
 <20240222-kms-hdmi-connector-state-v7-0-8f4af575fce2@kernel.org>
 <20240222-kms-hdmi-connector-state-v7-34-8f4af575fce2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Dne =C4=8Detrtek, 22. februar 2024 ob 19:14:20 CET je Maxime Ripard napisal=
(a):
> container_of_const() allows to preserve the pointer constness and is
> thus more flexible than inline functions.
>=20
> Let's switch all our instances of container_of() to container_of_const().
>=20
> Reviewed-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun=
4i/sun4i_hdmi_enc.c
> index bae69d696765..c276d984da6b 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> @@ -30,19 +30,11 @@
>  #include "sun4i_drv.h"
>  #include "sun4i_hdmi.h"
> =20
> -static inline struct sun4i_hdmi *
> -drm_encoder_to_sun4i_hdmi(struct drm_encoder *encoder)
> -{
> -	return container_of(encoder, struct sun4i_hdmi,
> -			    encoder);
> -}
> +#define drm_encoder_to_sun4i_hdmi(e)		\
> +	container_of_const(e, struct sun4i_hdmi, encoder)
> =20
> -static inline struct sun4i_hdmi *
> -drm_connector_to_sun4i_hdmi(struct drm_connector *connector)
> -{
> -	return container_of(connector, struct sun4i_hdmi,
> -			    connector);
> -}
> +#define drm_connector_to_sun4i_hdmi(c)		\
> +	container_of_const(c, struct sun4i_hdmi, connector)
> =20
>  static int sun4i_hdmi_setup_avi_infoframes(struct sun4i_hdmi *hdmi,
>  					   struct drm_display_mode *mode)
>=20
>=20





