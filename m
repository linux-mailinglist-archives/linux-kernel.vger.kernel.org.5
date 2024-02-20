Return-Path: <linux-kernel+bounces-72976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A42AF85BB5B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71B81C20B28
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FCE67C5C;
	Tue, 20 Feb 2024 12:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgQBv/nX"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2208D67C49;
	Tue, 20 Feb 2024 12:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708430681; cv=none; b=hA6VJNt/9xx0QHLIHDkwXNDlBE1Ygg4QPKNmi+r0tkRBRvyPaz9dyffPt3XbQc9H8IX19kv2QzRcgDtTm1oW5dfk4BKPG6WHXl16tyUd5esDDKyy+c4JiTirU+Gp+MZgtIHbg8TgJj1rdlCm0MYEGsPA5ArT8SyeljODOgghHoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708430681; c=relaxed/simple;
	bh=NMxXY8qLWUFDFPDwVo2AoNEULzAuOWuCJ+7a6zWgKP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVIgBw3pm3O9bHlRiMTqZ2iFaP+OY7rJ6s6I0oxqEZvJyUp+sqIwEMW/KGmV8mC658LupZh7/ypOZW4DHOEvEp9vbzlXYF4MnmeMZDcUsSM6IHwmv7DEqj/JfP1y3ZY1DbkP5uofXH78pEqlFzV2hlWeUtKmqiL5lZoESgWlGx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgQBv/nX; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so3768241a12.3;
        Tue, 20 Feb 2024 04:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708430679; x=1709035479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDBRaKbHpejHAGpTHH0nWNbFRLIF5jgQi6ysnBvVmt0=;
        b=fgQBv/nX1orVhX9DcNsIROKrM4zk3urJHmTp36jCg2NIgMfM32iV/rTXya4UoFAI86
         isGtDRetRXJklJyzWXUZ3YjWWmqOqUSTanGRvxPoOuZOdLiRJAAcok8cqn/msrjsd2S6
         o0gcvGO02CLdE0yEe0UiskT7fq05JPw/dIvd7eoKUNzyVGx10hyTH5W9k93L7RJlTk4R
         3uKqApT2u6Eh+yY+0GfxyflQFImYn9Y+BlRKg2VR7HT2npHWo2JXlklrfwdOenNwMkZw
         gqAAwGOj+wGq3YAIgLdGzqGVK7hqT3H2tXSR5XV7WKiUyzRmHpMuKlKkg2M+C+Og8V1f
         ijgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708430679; x=1709035479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDBRaKbHpejHAGpTHH0nWNbFRLIF5jgQi6ysnBvVmt0=;
        b=PtJpnQvoxbnUl4+bKwlGsNQya6MWwaFItErpJ6rMio8sGmZcLigTXUUt1Rsz1n3Y63
         gg7Hn0LwC3c021hONCnWVaBm33UM1ujaCyQy/Em9wRsTNJRQWy2AdcDCIYiPabyQxLyh
         zhIZKN7s6nQiD5MJ+oulvBgB/s8ct6pucPICi8XDlZqa61gq7wClyBkaffDcs8FVTZxE
         KJv7lp3BtUgwh7JZybWSva/yKpJHm5qXRETlhUQorYs8FKllQjpy44b2Aiob1uCuJL7W
         uHd/Xm2XfVP5zNHGV5amxnEyCxQDYgt5vt52DUwpn2yrKBCSESY0EvLVE0qlWPLGl0dd
         sX6A==
X-Forwarded-Encrypted: i=1; AJvYcCXeiHx5nVA7eeX+K8Gesq6oTqwtxDTSgRlgjBfOxTeXI5HvZLjsmeOaLftrMKISLiO+rLPksZrOVykeLrrS793LCq/IPVicTyr8F0pdBNbFepopo5S9dijI275L7JJquW0olQ7Ho0jo09YyeXD+OeA=
X-Gm-Message-State: AOJu0YwvkoXp0NLMxRXlNsZwNPD7hhTd/ZjGbmfqZRm99X3H1hTcW3DC
	M7Anehzid3vVbPVmKIc6tkz53HIF1las842UefbUlMGI+LzDte5qrlmigN1IFRhfIEVhwFMYMqK
	8giH4uWQh7tjhDvVXnx1iM7yfDvA=
X-Google-Smtp-Source: AGHT+IE+xNffM8hIAHyiibi9RnqLVskBkXY85ndUTCPz4ZsN3JK4L6DHi+NGk+WmCf5wE0DfCBLkrrwZHjEe0ZaCeyY=
X-Received: by 2002:a05:6a21:8183:b0:19e:9143:2ab5 with SMTP id
 pd3-20020a056a21818300b0019e91432ab5mr9769195pzb.25.1708430669536; Tue, 20
 Feb 2024 04:04:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6be2558b8462fc08095c24c9257563ab5f3ae013.1708001398.git.geert+renesas@glider.be>
 <kycepdxukfsww3tnxoo5hoiuo3vcgpqqmynokzhtl4vodgm6zc@ih4uhw7gz4jh>
 <CAMuHMdVf7ophCwKt-n_N-LBHV4+t14Gjb4d1O0T8FDk_9xMFtA@mail.gmail.com>
 <CAHCN7xJ65RP8TO7cS0p5DwE6zru5NEF0_JA+8siT_OpSeLD7pA@mail.gmail.com>
 <CAHCN7x+EnSU8qk5dBFco=0vkeknGq18qEN7vFmZs0_q83T_3+w@mail.gmail.com>
 <CAHCN7xKffJ29zyjoJVAcy3b_d=-zkFzbL=URj4yWJWzYvRdB_Q@mail.gmail.com>
 <TYCPR01MB11269CBE8429A31DE5002A5A5864C2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <nzrkujogauvn262ucxippwidyub6ikcohcjpbpn4hzj7rymctm@4owntgrmcquf>
 <TYCPR01MB11269CBAA20275E11D9AD6500864C2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <wxwad77x2mxhhwdsbgiytzn6x54t4sywodjhzefwldo277njiz@ru7z54wxgelu>
 <CAHCN7xJi-6W6x+OJmkNwOX45SM4WHD5zkN42ZOp8ZxFnp3YL5w@mail.gmail.com>
 <1ff513b9-d4fd-4663-b46b-bb9662e3881c@imgtec.com> <CAHCN7xJ0TTS_-PA3Ox_RCpfyHJFk-s=-zs8W1Zm3dQTUAoqbpg@mail.gmail.com>
 <CAK4VdL3o+oS3hqwATb8wbv=qOVojWz270r0bUhaBJOw6+tKbxg@mail.gmail.com>
In-Reply-To: <CAK4VdL3o+oS3hqwATb8wbv=qOVojWz270r0bUhaBJOw6+tKbxg@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 20 Feb 2024 06:04:17 -0600
Message-ID: <CAHCN7xKk5N99eAN0HJHU9ppbPWJpE1cv1Xz2cg1nLtJLW8Y6UA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/imagination: DRM_POWERVR should depend on ARCH_K3
To: Erico Nunes <nunes.erico@gmail.com>
Cc: Matt Coster <Matt.Coster@imgtec.com>, Maxime Ripard <mripard@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Frank Binns <Frank.Binns@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sarah Walker <Sarah.Walker@imgtec.com>, Javier Martinez Canillas <javierm@redhat.com>, Nishanth Menon <nm@ti.com>, 
	Marek Vasut <marek.vasut@mailbox.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 5:55=E2=80=AFAM Erico Nunes <nunes.erico@gmail.com>=
 wrote:
>
> Hi,
>
> On Mon, Feb 19, 2024 at 9:38=E2=80=AFPM Adam Ford <aford173@gmail.com> wr=
ote:
> > /usr/share/vulkan/explicit_layer.d/VkLayer_MESA_overlay.json
> > ERROR:            loader_validate_instance_extensions: Instance
> > extension VK_KHR_wayland_surface not supported by available ICDs or
> > enabled layers.
> > Failed to create Vulkan instance.
> >
> > I have tried running in X.org mode instead of Wayland, but I get a
> > different set of errors:
> >
> > [ 11102.013] (II) Loading /usr/lib/xorg/modules/libfbdevhw.so
> > [ 11102.014] (II) Module fbdevhw: vendor=3D"X.Org Foundation"
> > [ 11102.014]    compiled for 1.21.1.7, module version =3D 0.0.2
> > [ 11102.014]    ABI class: X.Org Video Driver, version 25.2
> > [ 11102.015] (II) FBDEV(0): using default device
> > [ 11102.016] (II) modeset(G0): using drv /dev/dri/card1
> > [ 11102.016] (EE)
> > Fatal server error:
> > or all framebuffer devices
> > [ 11102.016] (EE)
> > [ 11102.017] (EE)
> > Please consult the The X.Org Foundation support at http://wiki.x.org  f=
or help.
>
>
> The wayland and xcb extensions are not really supported at the moment
> in Mesa for powervr, so this kind of use case does not really work
> yet. For a first test, indeed the Sascha Willems triangle with
> -DUSE_D2D_WSI=3DON is probably best.
>
> One thing I can add is that most Wayland compositors use OpenGL for
> rendering and will only expose linux dmabuf capability if accelerated
> OpenGL support is found by the compositor. So even if you manage to
> hack some WSI functionality to be exposed by the Vulkan driver, it
> still won't work out of the box with regular compositors since there
> is no zink/OpenGL support yet. There is some experimental Vulkan
> renderer support in some compositors but last time I tried they hit
> other limitations due to the early state of powervr Vulkan in Mesa.

If I disable the GUI, do you think it would render via kms/drm?  I was
having issues starting Ubuntu with X11.

>
> I did some work related to this and managed to run a Vulkan triangle
> with Wayland and a modified compositor so far. So at least we could
> get the client side out of the way soon. But that depends on a Mesa
> development branch from Imagination which is being heavily reworked,
> so we need to wait for that rework to make its way into upstream Mesa
> before making progress on that work being upstreamed.

OK.  I won't spend any more time on it.  I knew the driver was in its
infancy, but I didn't realize how much.

I'll likely push my existing device tree changes to the Geert's
Renesas tree so the GPU node can be added which should make this
easier in the future.  I can push my tweak via gitlab, adding
DEF_CONFIG("renesas,r8a774a1-gpu", "renesas,du-r8a774a1"), if you
think that would be accepted.

adam
>
>
> Erico

