Return-Path: <linux-kernel+bounces-53171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C9484A1AF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DDF3B20A94
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D17447794;
	Mon,  5 Feb 2024 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlysB1YJ"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9616547F59;
	Mon,  5 Feb 2024 17:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155957; cv=none; b=sXur2vmJ7TNEXIChHErh77RSU0KRMTviX2APg8w1ijAb+J6V1NSF6b2JahwyPn3u59TDcPDvlpHrpDhs9nf45kiS20yprkGN86b9P1BfV9YVXEQM3lReFU/76fX0zdUB0RN3RU3Mw3FwF3rAfcAVTlOoDeFY9u8oZy4o7OhiXGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155957; c=relaxed/simple;
	bh=iENWrZku65hAa8Tz2gQfbHCsXLTOVZAomEQlg6Oanw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CI/+ByrJB9FpPqRhDqx64BTaKT/TeQ0hlEkuRE10s4bQ9KGRVu8I5sE/7VNwOEnCq+YCwmMgeazJd5M6qE4HaXEEgbQE4v+E3yn1AqlAH//YBU03qbwRwE+chejtonP+cIivDk4HxLci1XplKeRhAQobtMKuGf5MTbN5VFBwXfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlysB1YJ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40fb94d42e4so37731075e9.2;
        Mon, 05 Feb 2024 09:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707155954; x=1707760754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/C76pIYyE7acYLURd95YZ9JvqXFzoendTPcs1BJgd4E=;
        b=WlysB1YJ6g3tQgpifq8XHEEzk2AR/w3c2pDbbfk6+C/5aezUpazqq0GChlITvEC58l
         VWFDAJ1tU7fN8Wz4sWgh06hiO0I9jWjku4krxTdkutgbJRKofbkaz55NotlBejQx17P+
         buOUGwg+mNhA5apNEDOlRPHF1M5wjGAmWdYUyVZ0GzhVOiqXTPS3lufuntb/XvwrsuPi
         514+60jX6PPqPcLA8+Mxi0ihm09BdIuAZXd9cpVeCEJ3/VGVU3ftOjKdTiYeE3hPA3j0
         aTPoBBT+L9SLWYysNS8GD3S3VAlcIYLOLdN5wE6adq8dVsOPmG2nN0lMsKgGodZilUWj
         NUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707155954; x=1707760754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/C76pIYyE7acYLURd95YZ9JvqXFzoendTPcs1BJgd4E=;
        b=ClpFqxKQnJV3N7ClvoN6t/01q4aWQhWUO+jhkVifANGy5+U0oKFoa8dL0gMyDHNLaw
         AIUW0VctWW2PXjVOYb4xNs/IuYdoLlsWVX/F3Uxn/6HcUiOybDBzVDS4XdWoYIF2k4AD
         ZlLwxfI3vDSfRd7MvDTeo9ZX+6UZVtMOj2vsrJcViQUUxGABy8tdtOrDKSD/zd5XyDy/
         +nc7cz6X3ra7xvcO821W009sONZ34aSdP5whaZy6arQTdfjQd7/t7o/rd73vx5h0jAB4
         zr21KkD7KHp6KcigIynFFxc31bcmsvE0ehUTkJXP331A9fYFOd+XWnlEkRTsyzvNmzLh
         LP3A==
X-Gm-Message-State: AOJu0YymZdkmpV0jGx8ywr6CL5XTqH4IcclJ2MzfJ0LiBmeO7SLPgGSe
	6138GBwOlx11zCe3aNOj3W9xzz5RaWA6W0HdEt04V3nNBat1nrAh
X-Google-Smtp-Source: AGHT+IFDfuNn+dprW7ssb+MdCy5jmgRJzkLpuJk9Jj3FJq01fEAA1ewSEAVDfj9a3mttC9NNW39/qQ==
X-Received: by 2002:a05:600c:1f84:b0:40f:b69e:aa20 with SMTP id je4-20020a05600c1f8400b0040fb69eaa20mr367170wmb.11.1707155953740;
        Mon, 05 Feb 2024 09:59:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXLGxFNA/76SPYxu2gToiQ41JQj1r64t0+xMs6T6ok0+J1kX7Lo3HRGsUqaghaMGWDQKL6PXq6NGNLqkkIL6fSH+q/R9n/7nX8t2HjGfS3xy3tDno+jNBpq3yhdlwMv0JwIiWGHs7pPMDmY3tppwuh007wlxUZZNFKoz77/2ORkHBIoHDnI/ufPPjYSKeEjDHiim+gWsQfvUDhYaX4z4mypzFDUcevPha6r2x7iWsfup6Oiqst2nvuH9rdJU+46xkyCnn4/ivUw8S9IVKnsMGJMg7qLChe9iXwNVF4SCU8JxeoTjvXi+r+Z7MWS7ud6I6MU3beXQxs2GYwHrSALeZRdfuLoAOymERlSPSMKGdcDcx94TlN6SAedrWcdATopdC7sw+tGASkr4zKKwBMRUJe1wqriolatAq9Krhbe2ZvlAVP8+Zy9nmXh5532Nn2rGu603uvVkCKmx1uBEh3bNT/W3C96U2wkhKAwy+zzb0/Hryn9kMrnc5Zde3M5KIM1PCxu3jMYbICJMCjqOU3GXYf/+aNklvlAAL7wlqEid1ZvQbER77q+Sl3cnYa2OWdgpqgT93pkXJ5ey7ataDjI4ghXTLkxxVsmaktCslsYlt9Ju6YQORWFaRAX9Z/+h/vH5qsTw8NvtUZlaj6372xbn8YDKQpN3d3WD4PqIgRvAa0bGxQ6j1r+SY0ebh56EgW/cmCqa02ZWncBwHOt/d33kTfrgMWYlRohrPyqeEHjhi/B1UjcLy/CNW+Bqv7keb9iJQ0cLjehkuUPyw==
Received: from jernej-laptop.localnet (82-149-13-182.dynamic.telemach.net. [82.149.13.182])
        by smtp.gmail.com with ESMTPSA id v8-20020a05600c444800b0040fddd8de88sm2013072wmn.15.2024.02.05.09.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:59:13 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
 Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Oltmanns <frank@oltmanns.dev>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 Frank Oltmanns <frank@oltmanns.dev>
Subject:
 Re: [PATCH v2 5/6] drm/panel: st7703: Drive XBD599 panel at higher clock rate
Date: Mon, 05 Feb 2024 18:59:11 +0100
Message-ID: <13445659.uLZWGnKmhe@jernej-laptop>
In-Reply-To: <20240205-pinephone-pll-fixes-v2-5-96a46a2d8c9b@oltmanns.dev>
References:
 <20240205-pinephone-pll-fixes-v2-0-96a46a2d8c9b@oltmanns.dev>
 <20240205-pinephone-pll-fixes-v2-5-96a46a2d8c9b@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne ponedeljek, 05. februar 2024 ob 16:22:28 CET je Frank Oltmanns napisal(a):
> This panel is used in the pinephone that runs on a Allwinner A64 SOC.
> The SOC requires pll-mipi to run at more than 500 MHz.
> 
> This is the relevant clock tree:
>  pll-mipi
>     tcon0
>        tcon-data-clock
> 
> tcon-data-clock has to run at 1/4 the DSI per-lane bit rate. The XBD599
> has 24 bpp and 4 lanes. Therefore, the resulting requested
> tcon-data-clock rate is:
>     crtc_clock * 1000 * (24 / 4) / 4
> 
> tcon-data-clock runs at tcon0 / 4 (fixed divisor), so it requests a
> parent rate of
>     4 * (crtc_clock * 1000 * (24 / 4) / 4)
> 
> Since tcon0 is a ccu_mux, the rate of tcon0 equals the rate of pll-mipi.
> 
> pll-mipi's constraint to run at 500MHz or higher forces us to have a
> crtc_clock >= 83333 kHz if we want a 60 Hz vertical refresh rate.
> 
> Change [hv]sync_(start|end) so that we reach a clock rate of 83502 kHz
> so that it is high enough to align with pll-pipi limits.

Typo: pll-pipi -> pll-mipi

Best regards,
Jernej

> 
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> ---
>  drivers/gpu/drm/panel/panel-sitronix-st7703.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> index b55bafd1a8be..6886fd7f765e 100644
> --- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> @@ -320,14 +320,14 @@ static int xbd599_init_sequence(struct st7703 *ctx)
>  
>  static const struct drm_display_mode xbd599_mode = {
>  	.hdisplay    = 720,
> -	.hsync_start = 720 + 40,
> -	.hsync_end   = 720 + 40 + 40,
> -	.htotal	     = 720 + 40 + 40 + 40,
> +	.hsync_start = 720 + 65,
> +	.hsync_end   = 720 + 65 + 65,
> +	.htotal      = 720 + 65 + 65 + 65,
>  	.vdisplay    = 1440,
> -	.vsync_start = 1440 + 18,
> -	.vsync_end   = 1440 + 18 + 10,
> -	.vtotal	     = 1440 + 18 + 10 + 17,
> -	.clock	     = 69000,
> +	.vsync_start = 1440 + 30,
> +	.vsync_end   = 1440 + 30 + 22,
> +	.vtotal	     = 1440 + 30 + 22 + 29,
> +	.clock	     = (720 + 65 + 65 + 65) * (1440 + 30 + 22 + 29) * 60 / 1000,
>  	.flags	     = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
>  	.width_mm    = 68,
>  	.height_mm   = 136,
> 
> 





