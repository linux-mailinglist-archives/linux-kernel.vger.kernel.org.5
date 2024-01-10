Return-Path: <linux-kernel+bounces-22213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3367A829AEF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1D971F2245F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB76487A0;
	Wed, 10 Jan 2024 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CZDHJCE8"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F464879C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 13:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bbe78dbd1aso491458b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 05:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1704892184; x=1705496984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axpQS9mt6EONwc4UHXjuYA8cIAmRvc0FbgaFcTL7424=;
        b=CZDHJCE8ZB+AD/6LaUFMY0Mi0AX6ijQi+oiTxli9TXwIhBfsEOcl/sZ43uCi/hqxMi
         DKYMiVZN+40wH1B3p9SnOStpE3xlYuWD1H1m6xRHMyiWtGaeE8XPuXvbvC7yULZWOqYm
         dhI0U+FkhXnPOE/EKiC20K2/3wZAi6s2fZCUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704892184; x=1705496984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axpQS9mt6EONwc4UHXjuYA8cIAmRvc0FbgaFcTL7424=;
        b=at7H/ySxP0n+bK6EM2DbAeEw0actS/4fQsO1nP5ACp41c7YzKIww4PXvTKbEGqn2+L
         u3EsKD+klXldYKBFNHg2laq9mo0vY50SY5bXLYlmSe0Bc6vZFH1lIPCMv4UECyWHrvAK
         Ii4xVhkenShDtnhChWyMrlwb/YuMpDAD40B/FuJn6crByCEceQ+GD2NkHYQlIjjefTJK
         marN160OBVPijB4EA2e3x8qpEcTF/DYG3QBkzUKIA54nv71FAxl8lpF3dW+Lodhhd7Vl
         Q7/LobhxdziYGykPgyGdtP2quOIa6EIZcniyp9oEx9lSHiD9+6oLJxICQY8QcsEpy78t
         xS8w==
X-Gm-Message-State: AOJu0YxKL21nNhF7y8j9OktofhhFtATsVia1kiP07YpkGPqOqArxRAmO
	g0BYd4mFWi3pJgGV3MQJ08y+f55VSTrMyg/BQ6jZ/jQ7Ih7flA==
X-Google-Smtp-Source: AGHT+IH5PhKcQx1VfacgvsFkwrC19+V2RZMkdswfiLwrvrDfWNWWbhwatQpHwBl6QNABwcTT8HQd0hYsSvkAKtaiOtQ=
X-Received: by 2002:a05:6870:4304:b0:206:7561:280a with SMTP id
 w4-20020a056870430400b002067561280amr1694852oah.4.1704892183803; Wed, 10 Jan
 2024 05:09:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109181104.1670304-1-andri@yngvason.is> <20240109181104.1670304-4-andri@yngvason.is>
 <ZZ57Nl3CnRMPcfbj@phenom.ffwll.local> <CAFNQBQzo17cK4M-S=Mje8Lxub9Y74xFGj7iEq57vKJr47oiz5Q@mail.gmail.com>
In-Reply-To: <CAFNQBQzo17cK4M-S=Mje8Lxub9Y74xFGj7iEq57vKJr47oiz5Q@mail.gmail.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 10 Jan 2024 14:09:32 +0100
Message-ID: <CAKMK7uGhMCwbztGdEmG4gFgpyhw6j-JFow-AaprFxcX710=qXA@mail.gmail.com>
Subject: Re: [PATCH 3/7] drm/amd/display: Add handling for new "active color
 format" property
To: Andri Yngvason <andri@yngvason.is>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, Simon Ser <contact@emersion.fr>, 
	Werner Sembach <wse@tuxedocomputers.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Jan 2024 at 13:53, Andri Yngvason <andri@yngvason.is> wrote:
>
> mi=C3=B0., 10. jan. 2024 kl. 11:10 skrifa=C3=B0i Daniel Vetter <daniel@ff=
wll.ch>:
> >
> > On Tue, Jan 09, 2024 at 06:11:00PM +0000, Andri Yngvason wrote:
> > > +     /* Extract information from crtc to communicate it to userspace=
 as connector properties */
> > > +     for_each_new_connector_in_state(state, connector, new_con_state=
, i) {
> > > +             struct drm_crtc *crtc =3D new_con_state->crtc;
> > > +             struct dc_stream_state *stream;
> > > +
> > > +             if (crtc) {
> > > +                     new_crtc_state =3D drm_atomic_get_new_crtc_stat=
e(state, crtc);
> > > +                     dm_new_crtc_state =3D to_dm_crtc_state(new_crtc=
_state);
> > > +                     stream =3D dm_new_crtc_state->stream;
> > > +
> > > +                     if (stream) {
> > > +                             drm_connector_set_active_color_format_p=
roperty(connector,
> > > +                                     convert_dc_pixel_encoding_into_=
drm_color_format(
> > > +                                             dm_new_crtc_state->stre=
am->timing.pixel_encoding));
> > > +                     }
> > > +             } else {
> > > +                     drm_connector_set_active_color_format_property(=
connector, 0);
> >
> > Just realized an even bigger reason why your current design doesn't wor=
k:
> > You don't have locking here.
> >
> > And you cannot grab the required lock, which is
> > drm_dev->mode_config.mutex, because that would result in deadlocks. So
> > this really needs to use the atomic state based design I've described.
> >
>
> Maybe we should just drop "actual color format" and instead fail the
> modeset if the "preferred color format" property cannot be satisfied?
> It seems like the simplest thing to do here, though it is perhaps less
> convenient for userspace. In that case, the "preferred color format"
> property should just be called "color format".

Yeah that's more in line with how other atomic properties work. This
way userspace can figure out what works with a TEST_ONLY commit too.
And for this to work you probably want to have an "automatic" setting
too.
-Sima
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

