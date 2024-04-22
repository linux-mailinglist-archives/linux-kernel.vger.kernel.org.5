Return-Path: <linux-kernel+bounces-153763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6E68AD2DB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A103F281F0B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727E6153833;
	Mon, 22 Apr 2024 16:58:39 +0000 (UTC)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58171DDE9;
	Mon, 22 Apr 2024 16:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805119; cv=none; b=YZWI0b9DAyunRLUl6YEQ0v5Aw1QQBYqMwiII8YmJhEHSz7uSHqn8oC8IXD6de+ox1/xujrRrSvreUQ+7nhFdCJ0BzInhqZaHrH1QwmI2jynbtoXY8zlAM1DL17Ck++DKvLnZyjf0Gji1YrGDNANBGrOG2Vj59yq6oeMsI3Glgoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805119; c=relaxed/simple;
	bh=2MM87vb1RriR8f7HL8tf1uYoQdwU6zKEoIT1IrsLPvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rq8bxpPHk2/cla+Zt23rk60G+ZhezAT540njzDjfzpMSjCOiGj956slqoIkZVh8M6xZouIkaECOssZjns8b2mO1+V7+1Yu0TtO8DkRDMPlpxyNMLaBcj8DWzVNw27ow1ISmnwWmpztBv7jDGXHStEKsQZ0EqPwiwvJ1UQwOzBn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-de45e5c3c68so5000526276.0;
        Mon, 22 Apr 2024 09:58:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713805115; x=1714409915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXJbCXLErVWaJBLn0gFAgxou+WnOajhqe1V1IAmICA4=;
        b=W3QfRIKDvC4EaODIGE2M5ULOnuaDoIAut1kJ7Iy8uyU2s4/VeLzluarABaI2sXWYX5
         9BFprf0ik9PDFuHLHHxNTMtRh36/7MqeySRDVTS393M4kt/NZluzUoJA9gZ1dUDeEFaY
         /A0uFii24qmGebPX75lZJvp2Imcwbv3F2KNb8tK+ZeE/60m41AaqrUXCphhYzV1fCnTy
         nIFHDajph2Bf9HEAKndhvVexpJw9Ne2+KjuZP6A1MQ7UQVKQALoaMRx8gFYWrlXf+Kr0
         b/CoJgeXdqGDYK7jgY/o9p4sAMA5+zDnQ7XY/DGdlEtsi5Eu6FDfeVE07CJe2wvWOg6z
         mOoA==
X-Forwarded-Encrypted: i=1; AJvYcCW0EuFbDUC6frF9jSjMaQjwPGyvHqDhjgQ33g5mVspolBSeNZa/J8I8W5FSZqV+1Y3V7KcA4pzVtGlbX8McI6tGF9uH7UQn3EvhjUCr7W5RJrGPzj1wUVphnBTUj8SbymgTh4WsqVuu8CCntUvPp0KiMq1yluCa1bBdK0m0DDKYEPnf5hPsEzNUddR10qI=
X-Gm-Message-State: AOJu0YyuHFnGT5echqwJIA2qEfT0XMYoO7yzloRqQCT+QGUgcZ3fkx9P
	7kQWntFgMFVU7TOec9DZWBxn35tuYPHqI7UpYAhRc2lfAyRuQvP2h3pIzrIU
X-Google-Smtp-Source: AGHT+IEVSiqwfgzLYa3jXG1W9lHYUc/Gt3hNKRLN+rKTFRSjy/yMtSAheFb9y5lO47W8eDl0AsnMVA==
X-Received: by 2002:a25:b21b:0:b0:dc6:bbbd:d4f4 with SMTP id i27-20020a25b21b000000b00dc6bbbdd4f4mr10636291ybj.33.1713805114799;
        Mon, 22 Apr 2024 09:58:34 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id l5-20020a056902072500b00de4f779bb2dsm1204462ybt.6.2024.04.22.09.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 09:58:34 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dbed0710c74so4097831276.1;
        Mon, 22 Apr 2024 09:58:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUcqOAkNu8gnGeKdnGPqWQOLBhc119bZ08GmYIoaxLJQhmLWq1Mlx2OyTABA6WgboHCArH/IV4R0Vi5Hn4J9u1m5wJlZXxirezLS1g7ycxnyv+lQPgxk+XU6ur7J/IKN6iVPA7svORwHuo2zLsh6SnK0gxpTmnHwWHBPhKetlo2QxkzMXMlLlEzYG08eFM=
X-Received: by 2002:a25:292:0:b0:de3:cce6:5dce with SMTP id
 140-20020a250292000000b00de3cce65dcemr11262187ybc.36.1713805113975; Mon, 22
 Apr 2024 09:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713780345.git.geert+renesas@glider.be> <87il09ty4u.fsf@intel.com>
 <ff4f9e8f-0825-4421-adf9-e3914b108da7@app.fastmail.com> <875xw9ttl6.fsf@intel.com>
 <af6e26d1-1402-4ed2-a650-b58eae77273e@app.fastmail.com>
In-Reply-To: <af6e26d1-1402-4ed2-a650-b58eae77273e@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Apr 2024 18:58:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXCL-gbKr6mUBPWONtRjz=X0vZQgiS=02WXXSFf67yBww@mail.gmail.com>
Message-ID: <CAMuHMdXCL-gbKr6mUBPWONtRjz=X0vZQgiS=02WXXSFf67yBww@mail.gmail.com>
Subject: Re: [PATCH 00/11] drm: Restore helper usability
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	linux-kbuild <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

CC kbuild

On Mon, Apr 22, 2024 at 3:55=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
> On Mon, Apr 22, 2024, at 15:28, Jani Nikula wrote:
> > On Mon, 22 Apr 2024, "Arnd Bergmann" <arnd@arndb.de> wrote:
> >> 2. Using "select" on user visible symbols that have dependencies
> >>    is a common source for bugs, and this is is a problem in
> >>    drivers/gpu/drm more than elsewhere in the kernel, as these
> >>    drivers traditionally select entire subsystems or drivers
> >>    (I2C, VIRTIO, INPUT, ACPI_WMI, BACKLIGHT_CLASS_DEVICE,
> >>    POWER_SUPPLY, SND_PCM, INTERCONNECT, ...). This regularly
> >>    leads to circular dependencies and we should fix all of them.
> >
> > What annoys me is that the fixes tend to fall in two categories:
> >
> > - Play catch with selecting the dependencies of the selected
> >   symbols. "depends on" handles this recursively, while select does
> >   not.
>
> I'm not sure where this misunderstanding comes from, as you
> seem to be repeating the same incorrect assumption about
> how select works that Maxime wrote in his changelog. To clarify,
> this works exactly as one would expect:
>
> config HELPER_A
>        tristate
>
> config HELPER_B
>        tristate
>        select HELPER_A
>
> config DRIVER
>        tristate "Turn on the driver and the helpers it uses"
>        select HELPER_B # this recursively selects HELPER_A
>
> Whereas this one is broken:
>
> config FEATURE_A
>        tristate "user visible if I2C is enabled"
>        depends on I2C
>
> config HELPER_B
>        tristate # hidden
>        select FEATURE_A
>
> config DRIVER
>        tristate "This driver is broken if I2C is disabled"
>        select HELPER_B

So the DRIVER section should gain a "depends on I2C" statement.

Yamada-san: would it be difficult to modify Kconfig to ignore symbols
like DRIVER that select other symbols with unmet dependencies?
Currently it already warns about that.

Handling this implicitly (instead of the current explict "depends
on") would have the disadvantage though: a user who is not aware of
the implicit dependency may wonder why DRIVER is invisible in his
config interface.

>
> >   There is no end to this, it just goes on and on, as the
> >   dependencies of the selected symbols change over time. Often the
> >   selects require unintuitive if patterns that are about the
> >   implementation details of the symbol being selected.
>
> Agreed, that is the problem I frequently face with drivers/gpu/drm,
> and most of the time it can only be solved by rewriting the whole
> system to not select user-visible symbol at all.

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

