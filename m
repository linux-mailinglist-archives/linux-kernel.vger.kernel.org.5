Return-Path: <linux-kernel+bounces-27457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9197B82F056
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08304B21437
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB111BF46;
	Tue, 16 Jan 2024 14:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yngvason.is header.i=@yngvason.is header.b="XIIFNFPd"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7F61BF36
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yngvason.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yngvason.is
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-db3a09e96daso7830095276.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 06:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yngvason.is; s=google; t=1705414340; x=1706019140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gCKsoJIp890TMevRWkiJ5yhUQIvz900NU/IXPPBb5k=;
        b=XIIFNFPd2SSB3BFqh/xSBIA2EFwuQpmUD0kcTskx8DH0iffotd+MEwEi0lmQAFUuDt
         LL2aLDKXbYyLtlzG+FUOtkaW7F9jADi7KyQKvrq5uNnVF/5YWVgqkmsqDuyLLdp2HxPR
         lwI3kxqXj1/NrAWfKHqRrlFsV9C2xf6hgwiEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705414340; x=1706019140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gCKsoJIp890TMevRWkiJ5yhUQIvz900NU/IXPPBb5k=;
        b=S/gxCzSqutI5N3nvgF973mTT8B9ybcpr7FS028VL/AYzE59sW91qVvksBoSRTEkIfJ
         zu6feudoV396PH1obsLgySatFx/IPm61gfWyQdxTO/jnRfjSbnnvvBsYLOy6TOBJTi2e
         JbBb2RIfSUC7No2F20XGt7L6bkM7Xlv7e8o+ia3dlAOLZOJXUBBN3F6nAR9ik3R8b4vI
         Gwo6NRBvGr5/41sPAssJtYIUC9UqMD5hpenmZuvY0MkCTilGmeLasaubLu5g6Ajitb/Q
         4XUqLf+cx+3bKYMNgPjB6kj4r8FajFRiAjaesyXSnA+zWc9WeIghIxx73tYUe4JOw0XQ
         wXog==
X-Gm-Message-State: AOJu0YzrLjjSD0Y6s7EnxMvoc52DyLjIhf+kPUBjH3inRiIBcNuPcDbn
	jJOeuVq+LgajW53Xt3gVb+Qgid1TNOC++bx5Zr16EtiPWUXrcg==
X-Google-Smtp-Source: AGHT+IE41A58zXOP4mN6YBTW2CozoInidfluxDAZAPGf3XWYIJx5iW5A7pw47X0/O2DADgCiiAJSZrcdEWBROikbKfY=
X-Received: by 2002:a05:6902:511:b0:dbd:231:1d67 with SMTP id
 x17-20020a056902051100b00dbd02311d67mr3842729ybs.104.1705414339805; Tue, 16
 Jan 2024 06:12:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115160554.720247-1-andri@yngvason.is> <20240115160554.720247-3-andri@yngvason.is>
 <20240116114235.GA311990@toolbox> <CAFNQBQz3TNj_7BSmFw4CFMNuR4B+1d+y3f058s+rzTuzdYogqA@mail.gmail.com>
 <20240116132918.GB311990@toolbox>
In-Reply-To: <20240116132918.GB311990@toolbox>
From: Andri Yngvason <andri@yngvason.is>
Date: Tue, 16 Jan 2024 14:11:43 +0000
Message-ID: <CAFNQBQyfWmfu5T7bgZDZFGfyhsxQi7YXmY_wPc9Y+mm5iSspXQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] drm/uAPI: Add "force color format" drm property as
 setting for userspace
To: Sebastian Wick <sebastian.wick@redhat.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, amd-gfx@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Werner Sembach <wse@tuxedocomputers.com>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BEri., 16. jan. 2024 kl. 13:29 skrifa=C3=B0i Sebastian Wick
<sebastian.wick@redhat.com>:
>
> On Tue, Jan 16, 2024 at 01:13:13PM +0000, Andri Yngvason wrote:
[...]
> > =C5=9Fri., 16. jan. 2024 kl. 11:42 skrifa=C4=9Fi Sebastian Wick
> > <sebastian.wick@redhat.com>:
> > >
> > > On Mon, Jan 15, 2024 at 04:05:52PM +0000, Andri Yngvason wrote:
> > > > From: Werner Sembach <wse@tuxedocomputers.com>
> > > >
> > > > Add a new general drm property "force color format" which can be us=
ed
> > > > by userspace to tell the graphics driver which color format to use.
> > >
> > > I don't like the "force" in the name. This just selects the color
> > > format, let's just call it "color format" then.
> > >
> >
> > In previous revisions, this was "preferred color format" and "actual
> > color format", of which the latter has been dropped. I recommend
> > reading the discussion for previous revisions.
>
> Please don't imply that I didn't read the thread I'm answering to.
>
> > There are arguments for adding "actual color format" later and if it
> > is added later, we'd end up with "color format" and "actual color
> > format", which might be confusing, and it is why I chose to call it
> > "force color format" because it clearly communicates intent and
> > disambiguates it from "actual color format".
>
> There is no such thing as "actual color format" in upstream though.
> Basing your naming on discarded ideas is not useful. The thing that sets
> the color space for example is called "Colorspace", not "force
> colorspace".
>

Sure, I'm happy with calling it whatever people want. Maybe we can
have a vote on it?

> > [...]
> > > > @@ -1396,6 +1404,15 @@ static const u32 dp_colorspaces =3D
> > > >   *   drm_connector_attach_max_bpc_property() to create and attach =
the
> > > >   *   property to the connector during initialization.
> > > >   *
> > > > + * force color format:
> > > > + *   This property is used by userspace to change the used color f=
ormat. When
> > > > + *   used the driver will use the selected format if valid for the=
 hardware,
> > >
> > > All properties are always "used", they just can have different values=
.
> > > You probably want to talk about the auto mode here.
> >
> > Maybe we can say something like: If userspace does not set the
> > property or if it is explicitly set to zero, the driver will select
> > the appropriate color format based on other constraints.
>
> The property can be in any state without involvement from user space.
> Don't talk about setting it, talk about the state it is in:
>
>   When the color format is auto, the driver will select a format.
>

Ok.

> > >
> > > > + *   sink, and current resolution and refresh rate combination. Dr=
ivers to
> > >
> > > If valid? So when a value is not actually supported user space can st=
ill
> > > set it? What happens then? How should user space figure out if the
> > > driver and the sink support the format?
> >
> > The kernel does not expose this property unless it's implemented in the=
 driver.
>
> If the driver simply doesn't support *one format*, the enum value for
> that format should not be exposed, period. This isn't about the property
> on its own.

Right, understood. You mean that enum should only contain values that
are supported by the driver.

>
> > This was originally "preferred color format". Perhaps the
> > documentation should better reflect that it is now a mandatory
> > constraint which fails the modeset if not satisfied.
>
> That would definitely help.
>
> > >
> > > For the Colorspace prop, the kernel just exposes all formats it suppo=
rts
> > > (independent of the sink) and then makes it the job of user space to
> > > figure out if the sink supports it.
> > >
> > > The same could be done here. Property value is exposed if the driver
> > > supports it in general, commits can fail if the driver can't support =
it
> > > for a specific commit because e.g. the resolution or refresh rate. Us=
er
> > > space must look at the EDID/DisplayID/mode to figure out the supporte=
d
> > > format for the sink.
> >
> > Yes, we can make it possible for userspace to discover which modes are
> > supported by the monitor, but there are other constraints that need to
> > be satisfied. This was discussed in the previous revision.
>
> I mean, yes, that's what I said. User space would then only be
> responsible for checking the sink capabilities and the atomic check
> would take into account other (non-sink) constraints.

Since we need to probe using TEST_ONLY anyway, we'll end up with two
mechanisms to do the same thing where one of them depends on the other
for completeness.

>
> > In any case, these things can be added later and need not be a part of
> > this change set.
>
> No, this is the contract between the kernel and user space and has to be
> figured out before we can merge new uAPI.
>
> >
> > [...]
> >

Thanks,
Andri

