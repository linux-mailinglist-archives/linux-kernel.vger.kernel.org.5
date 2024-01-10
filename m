Return-Path: <linux-kernel+bounces-22192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 837B4829AAB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D751C25B2F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C6B48787;
	Wed, 10 Jan 2024 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yngvason.is header.i=@yngvason.is header.b="IqRXXl4p"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1802048780
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 12:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yngvason.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yngvason.is
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dbe39a45e8eso2940409276.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 04:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yngvason.is; s=google; t=1704891202; x=1705496002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tumM7ZgHm0hfd7iZgxyi6dhv3yMhPnlkKGS30wXR09c=;
        b=IqRXXl4pv94gOS74wEI3cDtxP/gAa4J0U542ZQJOWIpJr34b6w7r/EZrhgJB252a+d
         GNw9F7iMji8KXGJXBKBnRGkN07eXjF5SXtwTFtsJlFejJ9DYTB++aWd//RcFhmky7veN
         8DLAO2x/1RpBx5kTcSTS34BMcvc3xnXLNlmzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704891202; x=1705496002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tumM7ZgHm0hfd7iZgxyi6dhv3yMhPnlkKGS30wXR09c=;
        b=lO6cF6A2mQhVYlRHVB/Ql3CxoX2LcJZ6apaRbkktopYXP/nOqrJzm0YeYfBj6ch8Oz
         Nj0ucwD5FJiqgq3KjZzImfA8hLgf7OO+RYc5tc9kLGCfRG5RJJXBtO+aoG/mPNzBeC99
         2kdChNk+7W1/49Ocvq3KdlhdBLEbLdwSUKgOdp0fKQeKFcQOiTCW5aa+Jx5ncsh29ASW
         QsLX+YbubfMQi9wXLgQV6Oew5EQJU7UnYggZQvCPXCUpKqEsYe9qP0JQJBVSa6iSVKMZ
         qACir5B5Z7LHVlRZEoJRvsdIbpcVWkyBkDtzbURuvQppGUDAclKx48CLVho839c9hnD2
         F0CQ==
X-Gm-Message-State: AOJu0YxOkhHbuo94ocXnpapJStnQX5zQ0lvxDkSZqjO1UsgDRDWxlxCv
	OqADZLbgz3ot9mnXc4xjtOlybaZV5PKCl4uFJlJVFMLOb5KY7Q==
X-Google-Smtp-Source: AGHT+IEdEju6g56OensZJBuTZt9it0HPqzyt0o4DWwDRHwkW6tKsf3VmrtAhshl6Dqs1AQIYgIHNU9Hnp9bHW2jrsSo=
X-Received: by 2002:a5b:d51:0:b0:dbd:ab70:4e8f with SMTP id
 f17-20020a5b0d51000000b00dbdab704e8fmr625799ybr.4.1704891201874; Wed, 10 Jan
 2024 04:53:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109181104.1670304-1-andri@yngvason.is> <20240109181104.1670304-4-andri@yngvason.is>
 <ZZ57Nl3CnRMPcfbj@phenom.ffwll.local>
In-Reply-To: <ZZ57Nl3CnRMPcfbj@phenom.ffwll.local>
From: Andri Yngvason <andri@yngvason.is>
Date: Wed, 10 Jan 2024 12:52:46 +0000
Message-ID: <CAFNQBQzo17cK4M-S=Mje8Lxub9Y74xFGj7iEq57vKJr47oiz5Q@mail.gmail.com>
Subject: Re: [PATCH 3/7] drm/amd/display: Add handling for new "active color
 format" property
To: Andri Yngvason <andri@yngvason.is>, Harry Wentland <harry.wentland@amd.com>, 
	Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, Simon Ser <contact@emersion.fr>, 
	Werner Sembach <wse@tuxedocomputers.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

mi=C3=B0., 10. jan. 2024 kl. 11:10 skrifa=C3=B0i Daniel Vetter <daniel@ffwl=
l.ch>:
>
> On Tue, Jan 09, 2024 at 06:11:00PM +0000, Andri Yngvason wrote:
> > +     /* Extract information from crtc to communicate it to userspace a=
s connector properties */
> > +     for_each_new_connector_in_state(state, connector, new_con_state, =
i) {
> > +             struct drm_crtc *crtc =3D new_con_state->crtc;
> > +             struct dc_stream_state *stream;
> > +
> > +             if (crtc) {
> > +                     new_crtc_state =3D drm_atomic_get_new_crtc_state(=
state, crtc);
> > +                     dm_new_crtc_state =3D to_dm_crtc_state(new_crtc_s=
tate);
> > +                     stream =3D dm_new_crtc_state->stream;
> > +
> > +                     if (stream) {
> > +                             drm_connector_set_active_color_format_pro=
perty(connector,
> > +                                     convert_dc_pixel_encoding_into_dr=
m_color_format(
> > +                                             dm_new_crtc_state->stream=
->timing.pixel_encoding));
> > +                     }
> > +             } else {
> > +                     drm_connector_set_active_color_format_property(co=
nnector, 0);
>
> Just realized an even bigger reason why your current design doesn't work:
> You don't have locking here.
>
> And you cannot grab the required lock, which is
> drm_dev->mode_config.mutex, because that would result in deadlocks. So
> this really needs to use the atomic state based design I've described.
>

Maybe we should just drop "actual color format" and instead fail the
modeset if the "preferred color format" property cannot be satisfied?
It seems like the simplest thing to do here, though it is perhaps less
convenient for userspace. In that case, the "preferred color format"
property should just be called "color format".

Thanks,
Andri

