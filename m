Return-Path: <linux-kernel+bounces-67377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E83B856AA2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4EE289959
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB2B13666C;
	Thu, 15 Feb 2024 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h38gei+/"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186F912882C;
	Thu, 15 Feb 2024 17:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017070; cv=none; b=Dgdqb4ifnYejOCdXoObaHmDj7fUniQSFaNgstZ12loP1FHXJ5uT3ntgZEzYUJT9PK5P+Ry2p9JUkg4+4HHst1D9jsHvXrYfqy8aTq8NDxiJFxDNltDkRAfC1+Bi34aEwMCA58NQZCYE2+9HXxHUzvU3H5Wsi//bewB43/QIVr/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017070; c=relaxed/simple;
	bh=gC+t2i256ykTcnHpx473rhoC/ucu3wfi27zhFVBPnqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HiRTKjp1+9ldVmHogMPy6zOwkYWcCscAYhZkvdswiE3n9ZNnYGreq6mqQ1temb0egsDwCe9uTDuiOuGt2IF/dvQQkguy23b1vkFnrufWKiXs5lvnR18you2o+He7zRKcEnI/nCB0CFAT8xhuvG1/cIhpl9xSj/wz32XIwCv4t3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h38gei+/; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-296dc0cab6aso844711a91.1;
        Thu, 15 Feb 2024 09:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708017068; x=1708621868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HekLMrN4IhGy3pTTRw+JGzYq2fN0XC4oPQXiFTIzT+U=;
        b=h38gei+/qyr+8v+jyyVCmJ+7Uvnya3ZGgGdAnEX3r8PfQ3a/5GYd1rURmURDJzn/vT
         FzvlC6dfU8e1dPZ0UxOu4phcWVcRn44E36/xyDXNRFyUTApBBE0SjazGIQlkVJpU5gXn
         RUP/erxHSLsM5I75N3Rkixwvq/PS09KZ8S/D/SkHFIRoQcizp78rZNwdyVJZaqlspgr/
         xlfAAApSr7CyrBq8TK8txqWabjaOw4S4o0mgvSpu4yW6GyBAw2e4QvBsPctTJi+ILI7w
         n0jb2oud+tuuc+ZubyuJACmtA59RePTzCXNO258PAm7BnQFLCcWkUuETqzXWH4DhrCPE
         J2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708017068; x=1708621868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HekLMrN4IhGy3pTTRw+JGzYq2fN0XC4oPQXiFTIzT+U=;
        b=Pgr9dTbRQqa/JdKQKRzxZHNedTpTjuALeJuJ1NPHQe3Vyv8VpWmU8GUHsMFuJ5xNhU
         AD6RZOBDz+VXLAMTVT1/yLROjtrG34sTknJAlcN+XvqV8Luz+jNUWkw+Rj9e1HuYjKwe
         Q1WXGH/N+Al6b965auDmbIF2xqDdgwnN1rDymW8w/ksTVSa39t3TjiccunhUSr/R0N6s
         z4MaU4uPbeqeDNH00JKrTdFKe0UsErzBHiS5EpQmBIXl18TDc9Dl177gVthAwpPqzFSO
         MgmQDP9ary9oQHcEjA/8N99tki6KspUbTxHvdvrGx8/bA0zbfInqqWxp3MtoYxqsqD4O
         QzLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi7dGB3XSasJ9VowJoTCgJrE2N4ELXt5e0d0EC4qerjCuGlcLgzonkPtT4yQ4zqq6V2/hb1QkMhlW65xBXIrmCtv4H/cG0GYsjRDma/KrXTBQXWNtf30bHyR1npph/YTCu1ZBo9Zdfpk5VtJT7cJw=
X-Gm-Message-State: AOJu0YwDk1JmqknYUc8VNp7A6CgQpzYqPf8XqBPe9yv870HgtSfGz4Uw
	ovKLjuRpHlpyQhCACf0asUAR8H7GGeFPwykGTWbZy2PJlgu9e7E1UefHtiROhkoRDX8zgzkmsxd
	tQv2nLpy5YPOasIWNHuYfLtd+fjk=
X-Google-Smtp-Source: AGHT+IF+AijmxPlf0oEgl3y8FZCm0Lp7Rq+Yck8Vi4VKLU1sZ5qsFq9HhSGu9Xq/nlmjtMYq5gCJtPAQVwKcSdWVWyY=
X-Received: by 2002:a17:90a:5e09:b0:298:9d78:b2c9 with SMTP id
 w9-20020a17090a5e0900b002989d78b2c9mr3444668pjf.8.1708017067884; Thu, 15 Feb
 2024 09:11:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6be2558b8462fc08095c24c9257563ab5f3ae013.1708001398.git.geert+renesas@glider.be>
 <kycepdxukfsww3tnxoo5hoiuo3vcgpqqmynokzhtl4vodgm6zc@ih4uhw7gz4jh> <CAMuHMdVf7ophCwKt-n_N-LBHV4+t14Gjb4d1O0T8FDk_9xMFtA@mail.gmail.com>
In-Reply-To: <CAMuHMdVf7ophCwKt-n_N-LBHV4+t14Gjb4d1O0T8FDk_9xMFtA@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 15 Feb 2024 11:10:56 -0600
Message-ID: <CAHCN7xJ65RP8TO7cS0p5DwE6zru5NEF0_JA+8siT_OpSeLD7pA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/imagination: DRM_POWERVR should depend on ARCH_K3
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Maxime Ripard <mripard@kernel.org>, Frank Binns <frank.binns@imgtec.com>, 
	Matt Coster <matt.coster@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sarah Walker <sarah.walker@imgtec.com>, Donald Robson <donald.robson@imgtec.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Javier Martinez Canillas <javierm@redhat.com>, Nishanth Menon <nm@ti.com>, Marek Vasut <marek.vasut@mailbox.org>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 10:54=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Maxime,
>
> On Thu, Feb 15, 2024 at 5:18=E2=80=AFPM Maxime Ripard <mripard@kernel.org=
> wrote:
> > On Thu, Feb 15, 2024 at 01:50:09PM +0100, Geert Uytterhoeven wrote:
> > > Using the Imagination Technologies PowerVR Series 6 GPU requires a
> > > proprietary firmware image, which is currently only available for Tex=
as
> > > Instruments K3 AM62x SoCs.  Hence add a dependency on ARCH_K3, to
> > > prevent asking the user about this driver when configuring a kernel
> > > without Texas Instruments K3 Multicore SoC support.
> >
> > This wasn't making sense the first time you sent it, and now that commi=
t
> > log is just plain wrong. We have firmwares for the G6110, GX6250,
> > GX6650, BXE-4-32, and BXS-4-64 models, which can be found on (at least)
> > Renesas, Mediatek, Rockchip, TI and StarFive, so across three
>
> I am so happy to be proven wrong!
> Yeah, GX6650 is found on e.g. R-Car H3, and GX6250 on e.g. R-Car M3-W.
>
> > architectures and 5 platforms. In two months.
>
> That sounds like great progress, thanks a lot!
>
Geert,

> Where can I find these firmwares? Linux-firmware[1] seems to lack all
> but the original K3 AM62x one.

I think PowerVR has a repo [1], but the last time I checked it, the
BVNC for the firmware didn't match what was necessary for the GX6250
on the RZ/G2M.  I can't remember what the corresponding R-Car3 model
is.  I haven't tried recently because I was told more documentation
for firmware porting would be delayed until everything was pushed into
the kernel and Mesa.  Maybe there is a better repo and/or newer
firmware somewhere else.

adam

[1] https://gitlab.freedesktop.org/frankbinns/linux-firmware/-/tree/powervr=
/powervr?ref_type=3Dheads


>
> Thanks again!
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmwa=
re.git/
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

