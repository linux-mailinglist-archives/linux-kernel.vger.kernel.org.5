Return-Path: <linux-kernel+bounces-92465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBF38720B2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEF8AB212C0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0701685C7B;
	Tue,  5 Mar 2024 13:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvxHncYk"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42958593E;
	Tue,  5 Mar 2024 13:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709646456; cv=none; b=p1qf/Wgd12Il4iPUkhtWJiwE24/bzw0DxVLe+MR81l8lDBqlcfNnqyo1Rj+w57Aie0O2FISq/RayNiDHkawiBX7awKqwlf4g44Hg6SxanNPp3t63uOGanGsJk3/K6wCO0c5yYv3EGA655MOvdBYqnCinIgCOV/FsLJTU1kNLu/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709646456; c=relaxed/simple;
	bh=S5ZNv7E8RgnA9nV9q0H3S6osZ6ssuaeHV9OzVm1dFFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cnqVEiRM9r+j5nTXRkRhxadh0SbOOGJjNjL2SKkvsuRd/eybMkv+TBgGUpDLsTrLZ2G54nZmOwX1vFGAUxTilSFwhyP8guJQqdBy4Y8elqhsfB/eqoP/jjH/+iVwU5OabQWU0HFdhRUBxfUi7Gbp4kiCpV1joPBYYCX259PLgSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvxHncYk; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d3907ff128so5532918a12.3;
        Tue, 05 Mar 2024 05:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709646454; x=1710251254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdMAZiRIAHsJUc1Mjq85NsXecYABbu9svdLTciq/OhY=;
        b=UvxHncYk8g9gYclCWu6+WJ0YfIESBUGAfXLOPTzGrMzb96ZJTh8WjIcoNso+4o716O
         vPXOMHLbyPAik5cncIgLfkBnl4Urlbclqh7rpqzd8Aa8FB+PEJ7xjCBg1H8BNXBESyrT
         czratn4oUa6bTZd96tUiorray17uM8YGjlQT0dIG/d6Hb9Ax4Ashb7FBCQ6h/PUmm5Xm
         Y00Jv+br8ogtoD9ux1BvP+Ilc8+9sJx+KRme04ViZmh4gCYUxRvD6L3ovmi2NZB5Zky3
         b0Ffb0uXTFoC8phcO76H4As80+ucLQVjuDgT1d3MdtDAJPKjycONXbMY9FwXIpR0wd65
         Kf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709646454; x=1710251254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NdMAZiRIAHsJUc1Mjq85NsXecYABbu9svdLTciq/OhY=;
        b=mo26yhWPQvDjuyAzEIL8d80Yn5yaFXDz2hMf8jvHj6GympEhgn1euTX+84kjm+PdNG
         dArtRqksPExfCCaxRC5z3q+vfPX067vZLPLciNtsZ0D2uyBUrod6SzXwxanFJKKU1oSO
         cxADsT2J2FrWP3LpUOUtDDaV3KZuZWtDm0JGvCVt9s3zozOZlf1kn0ooqRMIJDcZmnOA
         1nGGp9fOi2aKJXr0y4GXgkxFd2JVGgfn64AHXRL1k2dAP9aUJ1bIJSpxdkS5naDE/elZ
         aJhH0Q96UcbJ4jkykUTdoX8GcIXVn4TenU9Aclv26e45LHaK2lPmEVWOGFlrBVIVNR2F
         VB1g==
X-Forwarded-Encrypted: i=1; AJvYcCUvNIA9E19VKV+5BTJsTIT0EvQxBHl7XStAT4GlIKE/M/lTLgfa1bMNov0JeYZgMXqIBhTkR9KjDt7CS3Tz+RxgNF20udm9pD208wPe14i8ZG8oyfhLs5BK4/dwEVEb8Toig9c/pNXZc62g2+J0ghw=
X-Gm-Message-State: AOJu0Yzs3hC2Vbd42uhwDgS5Et3q6y5JWDXsvOvoIb7BIHH5iJpKuVNh
	V1pOnYzfrwZQa0kyMHTtq1jjSJax8tkSdcVXmPFtwICeUxfF/Go5wJJ0ewzRMKfOrwQqu16FNZf
	h/YiT4R9kIBzGiR/I6W0zMlZSn7Y=
X-Google-Smtp-Source: AGHT+IFIyTA9lyBuwaMRD+Ynxt5VrqnElevZJi9yhFl7HItD+Z67hgXbxvk0yLdnGIfu0In26xytbWEI6KxA1jrOO28=
X-Received: by 2002:a17:90a:f191:b0:29b:2a8:9a89 with SMTP id
 bv17-20020a17090af19100b0029b02a89a89mr10234445pjb.21.1709646453778; Tue, 05
 Mar 2024 05:47:33 -0800 (PST)
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
 <CAHCN7x+EnSU8qk5dBFco=0vkeknGq18qEN7vFmZs0_q83T_3+w@mail.gmail.com> <76065296ad514898e2b8c29cd921c104b3692ae0.camel@imgtec.com>
In-Reply-To: <76065296ad514898e2b8c29cd921c104b3692ae0.camel@imgtec.com>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 5 Mar 2024 07:47:22 -0600
Message-ID: <CAHCN7xJ6uEghqDcUTKKQg7Lcg8uF55rz=vEHF=1xHRYfsDNGsA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/imagination: DRM_POWERVR should depend on ARCH_K3
To: Frank Binns <Frank.Binns@imgtec.com>
Cc: "geert@linux-m68k.org" <geert@linux-m68k.org>, 
	"marek.vasut@mailbox.org" <marek.vasut@mailbox.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>, 
	Matt Coster <Matt.Coster@imgtec.com>, "javierm@redhat.com" <javierm@redhat.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "airlied@gmail.com" <airlied@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "nm@ti.com" <nm@ti.com>, 
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, Sarah Walker <Sarah.Walker@imgtec.com>, 
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "mripard@kernel.org" <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 5:58=E2=80=AFAM Frank Binns <Frank.Binns@imgtec.com>=
 wrote:
>
> Hi Adam,
>
> Sorry for not responding sooner. I've recently just returned from paterni=
ty
> leave, so just catching up on everything.

Congratulations!

>
> On Thu, 2024-02-15 at 11:22 -0600, Adam Ford wrote:
> > On Thu, Feb 15, 2024 at 11:10=E2=80=AFAM Adam Ford <aford173@gmail.com>=
 wrote:
> > > On Thu, Feb 15, 2024 at 10:54=E2=80=AFAM Geert Uytterhoeven
> > > <geert@linux-m68k.org> wrote:
> > > > Hi Maxime,
> > > >
> > > > On Thu, Feb 15, 2024 at 5:18=E2=80=AFPM Maxime Ripard <mripard@kern=
el.org> wrote:
> > > > > On Thu, Feb 15, 2024 at 01:50:09PM +0100, Geert Uytterhoeven wrot=
e:
> > > > > > Using the Imagination Technologies PowerVR Series 6 GPU require=
s a
> > > > > > proprietary firmware image, which is currently only available f=
or Texas
> > > > > > Instruments K3 AM62x SoCs.  Hence add a dependency on ARCH_K3, =
to
> > > > > > prevent asking the user about this driver when configuring a ke=
rnel
> > > > > > without Texas Instruments K3 Multicore SoC support.
> > > > >
> > > > > This wasn't making sense the first time you sent it, and now that=
 commit
> > > > > log is just plain wrong. We have firmwares for the G6110, GX6250,
> > > > > GX6650, BXE-4-32, and BXS-4-64 models, which can be found on (at =
least)
> > > > > Renesas, Mediatek, Rockchip, TI and StarFive, so across three
> > > >
> > > > I am so happy to be proven wrong!
> > > > Yeah, GX6650 is found on e.g. R-Car H3, and GX6250 on e.g. R-Car M3=
-W.
> > > >
> > > > > architectures and 5 platforms. In two months.
> > > >
> > > > That sounds like great progress, thanks a lot!
> > > >
> > > Geert,
> > >
> > > > Where can I find these firmwares? Linux-firmware[1] seems to lack a=
ll
> > > > but the original K3 AM62x one.
> > >
> > > I think PowerVR has a repo [1], but the last time I checked it, the
> > > BVNC for the firmware didn't match what was necessary for the GX6250
> > > on the RZ/G2M.  I can't remember what the corresponding R-Car3 model
> > > is.  I haven't tried recently because I was told more documentation
> > > for firmware porting would be delayed until everything was pushed int=
o
> > > the kernel and Mesa.  Maybe there is a better repo and/or newer
> > > firmware somewhere else.
> > >
> > I should have doubled checked the repo contents before I sent my last
> > e-mail , but it appears the firmware  [2] for the RZ/G2M, might be
> > present now. I don't know if there are driver updates necessary. I
> > checked my e-mails, but I didn't see any notification, or I would have
> > tried it earlier.  Either way, thank you Frank for adding it.  I'll
> > try to test when I have some time.
> >
>
> You may have noticed from one of Matt's emails that we now have a set of =
repos
> (linux, linux-firmware and Mesa) in our own area on freedesktop.org GitLa=
b:
> https://gitlab.freedesktop.org/imagination/
>
> We'll be using this as a staging area for work that isn't ready to be ups=
treamed
> yet (including firmware binaries).
>

I tried to play with these a little, but it seems like there is still
a fair amount of work to be done on the 6XT series. I tried to add the
device tree support for several Renesas boards, but the series was
NAK'd due to an inability to test it.
>
> > > adam
> > >
> > > [1] https://gitlab.freedesktop.org/frankbinns/linux-firmware/-/tree/p=
owervr/powervr?ref_type=3Dheads
> >
> > [2] - https://gitlab.freedesktop.org/frankbinns/linux-firmware/-/commit=
/fecb3caebf29f37221fe0a20236e5e1415d39d0b
> >
>
> This is now the place to get the firmware for devices that aren't yet sup=
ported
> upstream:
> https://gitlab.freedesktop.org/imagination/linux-firmware/-/commits/power=
vr/?ref_type=3DHEADS
>
I've been following several of these repos and checking for software
updates in both the Firmware, driver and userspace layers.

> With the firmware for the Renesas variant of GX6250 being found in this c=
ommit:
> https://gitlab.freedesktop.org/imagination/linux-firmware/-/commit/fecb3c=
aebf29f37221fe0a20236e5e1415d39d0b
>

If your group thinks they have stuff they want tested, I am willing to
test them on the two platforms I have if I am CC'd on anything.

Thanks for the work your group has done so far.  It'll be nice to see the w=
ork.

adam

> Thanks
> Frank
>
> > >
> > > > Thanks again!
> > > >
> > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-=
firmware.git/
> > > >
> > > > Gr{oetje,eeting}s,
> > > >
> > > >                         Geert
> > > >
> > > > --
> > > > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@li=
nux-m68k.org
> > > >
> > > > In personal conversations with technical people, I call myself a ha=
cker. But
> > > > when I'm talking to journalists I just say "programmer" or somethin=
g like that.
> > > >                                 -- Linus Torvalds

