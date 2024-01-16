Return-Path: <linux-kernel+bounces-27408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F3082EF8F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5271EB227B1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FBD1BC4C;
	Tue, 16 Jan 2024 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yngvason.is header.i=@yngvason.is header.b="D4P+zVbt"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B310C1BC35
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yngvason.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yngvason.is
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5f70c085d64so81511327b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 05:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yngvason.is; s=google; t=1705410829; x=1706015629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgTAJrFpfpXZ14LoeYBV9hYTfaqdy6WXEoOHL8FEBp0=;
        b=D4P+zVbtPoNK15NdhqGbHk8P30ybrfs3y42ZyIo3CdFU1ZNkcpdPS+XpNhx4lcu0jI
         I91qGB0jriSX+6sH+L3d/jfroOo0+cRcYmKxQVXkw8kDrwHUET0pJ4NCxjHt8OLMNuKS
         WrKfwZzkL+9x84vQKqGsUtGhqrge9S3vBQhOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705410829; x=1706015629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgTAJrFpfpXZ14LoeYBV9hYTfaqdy6WXEoOHL8FEBp0=;
        b=oQRkDslhN6PdHUVZ1NpaxK6L4dldZHqj/X5e5mzMFnh0OTQuEUq24J5wNAi+y+UzYh
         8uZSfapIyRCF8qM9sD23NOv2FU2YxlvQFpsy6arBoqZaBlQCrjPmcLKzwGeY5YCNNhG+
         L8CCYT677jHZatDB0wQC2Cy2GVkeoMXm6lWiMYBmaCy3C+9DtRcEbjIt3CnTU6duRQtt
         cxUsOoj4s14HUcZcs/K2b+//Ur6exG8Ud8Lsc2JEUMiFKA7rPVYCGXASAKH6fri+G5Rf
         PGhy76XKp6sfinh6fSQLgeciYrQM1818TYwBoNniMOxi72hUdu1mFru0WgCPqz1U7QMc
         WmYg==
X-Gm-Message-State: AOJu0YyDlnPD7056zeMS1BlqVo13C4sn4k0fH395YNROij4CfhWlfFAa
	D3XteE7uG8PLlBLC9JbyXF36mBQiUDUCb7DcRp1KRw7+xCF7ZQ==
X-Google-Smtp-Source: AGHT+IEvdpYZdLrjqLdLASniLaW/kxSkHhZUqkufoy5Z1zACRc4GGJ9S1JofmV/XOTAVZvZZlMpmt5VXIRxTmGkzFoQ=
X-Received: by 2002:a81:400f:0:b0:5f7:d06c:7464 with SMTP id
 l15-20020a81400f000000b005f7d06c7464mr4994438ywn.61.1705410829635; Tue, 16
 Jan 2024 05:13:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115160554.720247-1-andri@yngvason.is> <20240115160554.720247-3-andri@yngvason.is>
 <20240116114235.GA311990@toolbox>
In-Reply-To: <20240116114235.GA311990@toolbox>
From: Andri Yngvason <andri@yngvason.is>
Date: Tue, 16 Jan 2024 13:13:13 +0000
Message-ID: <CAFNQBQz3TNj_7BSmFw4CFMNuR4B+1d+y3f058s+rzTuzdYogqA@mail.gmail.com>
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

Hi Sebastian,

=C3=BEri., 16. jan. 2024 kl. 11:42 skrifa=C3=B0i Sebastian Wick
<sebastian.wick@redhat.com>:
>
> On Mon, Jan 15, 2024 at 04:05:52PM +0000, Andri Yngvason wrote:
> > From: Werner Sembach <wse@tuxedocomputers.com>
> >
> > Add a new general drm property "force color format" which can be used
> > by userspace to tell the graphics driver which color format to use.
>
> I don't like the "force" in the name. This just selects the color
> format, let's just call it "color format" then.
>

In previous revisions, this was "preferred color format" and "actual
color format", of which the latter has been dropped. I recommend
reading the discussion for previous revisions.

There are arguments for adding "actual color format" later and if it
is added later, we'd end up with "color format" and "actual color
format", which might be confusing, and it is why I chose to call it
"force color format" because it clearly communicates intent and
disambiguates it from "actual color format".

[...]
> > @@ -1396,6 +1404,15 @@ static const u32 dp_colorspaces =3D
> >   *   drm_connector_attach_max_bpc_property() to create and attach the
> >   *   property to the connector during initialization.
> >   *
> > + * force color format:
> > + *   This property is used by userspace to change the used color forma=
t. When
> > + *   used the driver will use the selected format if valid for the har=
dware,
>
> All properties are always "used", they just can have different values.
> You probably want to talk about the auto mode here.

Maybe we can say something like: If userspace does not set the
property or if it is explicitly set to zero, the driver will select
the appropriate color format based on other constraints.

>
> > + *   sink, and current resolution and refresh rate combination. Driver=
s to
>
> If valid? So when a value is not actually supported user space can still
> set it? What happens then? How should user space figure out if the
> driver and the sink support the format?

The kernel does not expose this property unless it's implemented in the dri=
ver.

This was originally "preferred color format". Perhaps the
documentation should better reflect that it is now a mandatory
constraint which fails the modeset if not satisfied.

>
> For the Colorspace prop, the kernel just exposes all formats it supports
> (independent of the sink) and then makes it the job of user space to
> figure out if the sink supports it.
>
> The same could be done here. Property value is exposed if the driver
> supports it in general, commits can fail if the driver can't support it
> for a specific commit because e.g. the resolution or refresh rate. User
> space must look at the EDID/DisplayID/mode to figure out the supported
> format for the sink.

Yes, we can make it possible for userspace to discover which modes are
supported by the monitor, but there are other constraints that need to
be satisfied. This was discussed in the previous revision.

In any case, these things can be added later and need not be a part of
this change set.

[...]

Regards,
Andri

