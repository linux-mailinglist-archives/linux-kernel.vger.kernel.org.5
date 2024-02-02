Return-Path: <linux-kernel+bounces-49731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C47846EAB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFD01288D03
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6F7137C2B;
	Fri,  2 Feb 2024 11:08:00 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D2E2B9C5
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 11:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706872079; cv=none; b=hjp9O41ThqAWMiwpbQRd8wJZwby+K0ItkAWQzTe0me0zqa4EB2IUbtFgM9cLedySTBwkiBiHMsM+bknQH5Oui1E7cJDvv7Ss/gAP98LN45lRsNRtxbtYLzaqZjH8ZqNe946F3nr/fycEtGCMBeDHo9fY6QumB8ZsJF+78OC4ALA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706872079; c=relaxed/simple;
	bh=iGtOxvK1AW1BPmTTHbdgo3W+QEBoeTpB7tEwx5I2mFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFH3xmqKTcoes8vT5bCz7Fda+kvOAJliz2I5D1uSnjlsZX9kPjuCSnSp0eLJyvYGOGSAs+jVnTR4l2gc3cyC62J7S4v8OJ/TI8nqn7svXwqC4hJ9jEiTr+3vvBYjPvjVBJHHp66CX2I2l6jZunVT95uE4QrxST80BZKdByA6/DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6040a879e1eso21185737b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 03:07:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706872076; x=1707476876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jfv2qKejWElyCs3KRimHnaJxDJDdphdyezyPkNwX/u0=;
        b=wlT2OdXhAZe7EDcBLP9ljUD1BxLlo7pHLlkt078s/6Wmqu1R229tkmJI9xC2t+bJW6
         6cN/2oBx24pEFcT/v8MOxH5vGkrGqiOoYNrn8QvEB2iRKFhHAI7bFEMf7oJvFi0wOb3a
         DObMknS3pzs9gaQ2uEPV27boqrDBlLbHZtyLSWmCmqwiOqBwbgW0ChKKa9pV8Ihog2I0
         JpNwkLT6tU0qV5SzvKTPVyL72xoofmfM3FOBu4WXUy0WoMAcDBC4qHGYePrDLEr0DB2y
         tMHeQeFuzacIxM9RaTkmRVE/JN6VW5wN3UXS1KUxynonXbMjPIyWeq8Lh62fSlX4FJKe
         txmg==
X-Gm-Message-State: AOJu0YyVVfApR7z9UkxRj2rCMVz+Lq3KcJaBxRQiMIdEzlyJhDr1dZYO
	Gv0YHzQelVn3avRz3npqW5piYPh+74UBTOJHIfMMcPPZKWVJx0pdE42ynT6CIfU=
X-Google-Smtp-Source: AGHT+IEOO3IOiFfdkyfQdMXROagFHjTw88Ka/z3YvGW8fNVAp26UdevIhkRvb4hNlDaMOQQQ3IdYVQ==
X-Received: by 2002:a0d:d611:0:b0:604:e15:81a with SMTP id y17-20020a0dd611000000b006040e15081amr6988313ywd.52.1706872076225;
        Fri, 02 Feb 2024 03:07:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX1MAHjVlBBwdeEaT2O/uGpQfOi36xgPA56LX1fdcyJzTioc3tyRgGynHSfsbUF3o2kPsHg39LqeNWOGjdo33lq+kbvIS9md0bF6yuh
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id n12-20020a819c4c000000b006040ee6289dsm352778ywa.137.2024.02.02.03.07.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 03:07:56 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-603fdc46852so20316727b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 03:07:55 -0800 (PST)
X-Received: by 2002:a81:b608:0:b0:5ff:b07b:fb0b with SMTP id
 u8-20020a81b608000000b005ffb07bfb0bmr7753792ywh.49.1706872075811; Fri, 02 Feb
 2024 03:07:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240202095104eucas1p2df4522cc4a7ee29540db1fb61d8e19fc@eucas1p2.samsung.com>
 <20240202095044.1980696-1-m.szyprowski@samsung.com>
In-Reply-To: <20240202095044.1980696-1-m.szyprowski@samsung.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 2 Feb 2024 12:07:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVk0YOUFKy-ZjMHWCGkNMeBGU5Zs6VxtNH38emBnAR9xA@mail.gmail.com>
Message-ID: <CAMuHMdVk0YOUFKy-ZjMHWCGkNMeBGU5Zs6VxtNH38emBnAR9xA@mail.gmail.com>
Subject: Re: [PATCH] ARM: multi_v7_defconfig: Enable BACKLIGHT_CLASS_DEVICE
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Russell King <linux@armlinux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Davis <afd@ti.com>, 
	Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>, 
	Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marek,

On Fri, Feb 2, 2024 at 10:51=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Commit 72fee6b0a3a4 ("fbdev: Restrict FB_SH_MOBILE_LCDC to SuperH")
> disabled availablity of the SH_MOBILE_LCDC driver on the RENESAS arch.
> This innocent change has a significant side-effect on the ARM's
> multi_v7_defconfig, because FB_BACKLIGHT symbol is no longer selected,
> what in turn leaves BACKLIGHT_CLASS_DEVICE symbol selected only as
> a module. The latter disables some backlight related code in the DRM

Oops, sorry for that.

> core, because the DRM core is set to be compiled-in in this defconfig.
> This leaves all DRM display panels without integrated backlight control,
> even if the needed modules have been properly loaded and probed.

Hmm, that's bad.

Is there any way to fix this in DRM?
A quick grep shows that DRM is using the full monty of
IS_{BUILTIN,ENABLED,MODULE,REACHABLE}(CONFIG_BACKLIGHT_CLASS_DEVICE).
Probably not all of them are in perfect sync?

Several DRM drivers do select BACKLIGHT_CLASS_DEVICE, but if that
does not work in the modular case, it should be fixed.

> Fix this by selecting BACKLIGHT_CLASS_DEVICE to be compiled-in in
> multi_v7_defconfig.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Sounds like a good interim solution.

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

