Return-Path: <linux-kernel+bounces-72956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 003D085BB17
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E805B26782
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107E267C6C;
	Tue, 20 Feb 2024 11:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lD/wbnZ0"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994AA67A13;
	Tue, 20 Feb 2024 11:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708430146; cv=none; b=EEU49hLfhokAB8wX3q7rc9ZHqVpN8sEXPOGGLw/0yp/A+da/13SYKST/0gNHIbEaKT9fFQycxkUI6iIUXzquNHFNSmg/2SrNPHI8VW0unhTrTPH2qOM5QPctZaeu7mI5kSoNMQ1DjtMrKYo4oK6wa4JLiya0tI0VJ8PoWkpuRy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708430146; c=relaxed/simple;
	bh=RlzLyIaBIPYhIIJ+Cv0QTiGGtwgWgSS7chPV9swd+q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fLY89TdTxHgA+IawtBE8gBJA4nXhBsUyTLVZ3BApjyHZIF/ZBA3dkrS2WarP9ph45ayQVcUo/igJSZ9KvoDhkB0LU0U1wSz6GkuI7k6IdwnRTz+PdAWO6lXbRNik57IXQ2LTWCBW3moKnkwfyJHJISf7zqFOBC/riquK9MkJOiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lD/wbnZ0; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51197ca63f5so5551383e87.1;
        Tue, 20 Feb 2024 03:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708430143; x=1709034943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yl0M7CLKZiWg66boULSo73wijfnxqf7U3kAkpRW4/4=;
        b=lD/wbnZ0vUceaC6k1FLUELjB9e8jAWo5XTbRGBs5efgbV7YrDZ8tLSuFN3am1UEHLQ
         rWkGs/1/rAxbDxl+qZaszfnCTpGQolKAiHOmZ5BgJZLdDfxSaF5A4ZJ0BJbbpnql3Kuj
         mHC5HZFeyNzg9nFeJPGuDqzqLmAddmCb0/tQZ/pkKy5Mp6QRLIpLTbKj8xQhmlEZOgg9
         iSMGt0InIz5Xz6AUCmbwuezQ1DihUZbRX+XALpj1FrzL27fGPE6Iyp4nYa9RNjUj1H5t
         gHOGqkdH/TK8hoD6gr5zwJ9dPIJ0dnezQPqrRUWWxx7AIXb449bZNYD08UyqpKCdUdyT
         wMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708430143; x=1709034943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3yl0M7CLKZiWg66boULSo73wijfnxqf7U3kAkpRW4/4=;
        b=A5cndOWVtPIQrcnmHeOLwyUuxspu0RiXjxNu6TVgFsrX8JR3gvQOAeu4BEckrgUN69
         Nm8mrUw1YRZ57bfWfFIm7omnFUAeh1InRTGYL0qcagV+GaSpbbKON5Xg1Vww7N/Cdlbg
         xWDlXUOKmzvmTBSa+a41dIKZfafsS2ij0sbKkAXHVHHPKaD0+MKZo0B7G/3lqfuXXl3A
         ULZHvqQf7tJz4smJ6b6/OoibIw5R56K3nDL5W3oYrtbI+OzjAOiyWIiW6+amIhkGdkQp
         6pBeiiq7GGmpeuRmjTZ1kE8fefPC/fQ37ZM/C4/TpliBZK1pY3+8508bVpSETdAog9rg
         JMAg==
X-Forwarded-Encrypted: i=1; AJvYcCXPmkOI7Lc7TPWbR1U5gAw7HZDmSXqXIDvoVUJ0BVzBHQ+w1l+2QZG0t+tIoKJWRueOtM6Row7IDhTNATUpJfVy4yMiMf1PzZGv7Bofzpj5bswNAHxHFNkX/cGiKnwFLUaZnwjKT/AJw9wdASEx1Eo=
X-Gm-Message-State: AOJu0YxakNVhFx8oZu6YqbErYX/WoaGdHbXFnaObffhEmPfBbZsjAd6F
	o8CxabGpo/h3ScrBWR3UpGeUyXjd+ragP+kwxck15UNrnaCfbKJ5giqC6Z5E+81b/SROOy7w5lG
	XQNir3WN+OvMY1SDppjc5JwM17jU=
X-Google-Smtp-Source: AGHT+IFBAgJPIT1xKrmwp1gHK45l1q76tE8uzVZZZAV8JcaYwkzwtiN/zQeC6JUtGsdfPOZzl8wLMrd2rpBnjFv0ejc=
X-Received: by 2002:a05:6512:3ba2:b0:512:a2c7:e44c with SMTP id
 g34-20020a0565123ba200b00512a2c7e44cmr6617160lfv.20.1708430142565; Tue, 20
 Feb 2024 03:55:42 -0800 (PST)
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
In-Reply-To: <CAHCN7xJ0TTS_-PA3Ox_RCpfyHJFk-s=-zs8W1Zm3dQTUAoqbpg@mail.gmail.com>
From: Erico Nunes <nunes.erico@gmail.com>
Date: Tue, 20 Feb 2024 12:55:29 +0100
Message-ID: <CAK4VdL3o+oS3hqwATb8wbv=qOVojWz270r0bUhaBJOw6+tKbxg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/imagination: DRM_POWERVR should depend on ARCH_K3
To: Adam Ford <aford173@gmail.com>
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

Hi,

On Mon, Feb 19, 2024 at 9:38=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
> /usr/share/vulkan/explicit_layer.d/VkLayer_MESA_overlay.json
> ERROR:            loader_validate_instance_extensions: Instance
> extension VK_KHR_wayland_surface not supported by available ICDs or
> enabled layers.
> Failed to create Vulkan instance.
>
> I have tried running in X.org mode instead of Wayland, but I get a
> different set of errors:
>
> [ 11102.013] (II) Loading /usr/lib/xorg/modules/libfbdevhw.so
> [ 11102.014] (II) Module fbdevhw: vendor=3D"X.Org Foundation"
> [ 11102.014]    compiled for 1.21.1.7, module version =3D 0.0.2
> [ 11102.014]    ABI class: X.Org Video Driver, version 25.2
> [ 11102.015] (II) FBDEV(0): using default device
> [ 11102.016] (II) modeset(G0): using drv /dev/dri/card1
> [ 11102.016] (EE)
> Fatal server error:
> or all framebuffer devices
> [ 11102.016] (EE)
> [ 11102.017] (EE)
> Please consult the The X.Org Foundation support at http://wiki.x.org  for=
 help.


The wayland and xcb extensions are not really supported at the moment
in Mesa for powervr, so this kind of use case does not really work
yet. For a first test, indeed the Sascha Willems triangle with
-DUSE_D2D_WSI=3DON is probably best.

One thing I can add is that most Wayland compositors use OpenGL for
rendering and will only expose linux dmabuf capability if accelerated
OpenGL support is found by the compositor. So even if you manage to
hack some WSI functionality to be exposed by the Vulkan driver, it
still won't work out of the box with regular compositors since there
is no zink/OpenGL support yet. There is some experimental Vulkan
renderer support in some compositors but last time I tried they hit
other limitations due to the early state of powervr Vulkan in Mesa.

I did some work related to this and managed to run a Vulkan triangle
with Wayland and a modified compositor so far. So at least we could
get the client side out of the way soon. But that depends on a Mesa
development branch from Imagination which is being heavily reworked,
so we need to wait for that rework to make its way into upstream Mesa
before making progress on that work being upstreamed.


Erico

