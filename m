Return-Path: <linux-kernel+bounces-155672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D674C8AF576
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 036131C23E57
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75ED13DDA5;
	Tue, 23 Apr 2024 17:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k22lnWvI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C38A1BC23;
	Tue, 23 Apr 2024 17:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713893126; cv=none; b=o/h0lIUiurRp/fGSPVm1b++Ms+HZV8UFLWfjYie3ViHifPEncVUm/OK3svFvkFPzK0yQ6T6oXSpd5JTbCkgsWhozpTjBgL0jE0obBrWtmo0ccOT6Ml6cN2NSyZe5oaOVyhgnDiMo/+2q//TnMYDtzEgLmLF8RIZHQCa933wIOzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713893126; c=relaxed/simple;
	bh=EGjmphNer7Ut89RHQco8gQbleBGKa1F+SeEnuAdzC24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbirrtKdXhjaiolWHSYB+NM5MVFr/9C/9MV3ge2nYBEWal39fOlalseB6Jtnx8LFA08bAQEV+ykJj9175m2LMTVzKX2pxwrJHBGnA2MYUmTdIdveVntCCoE7O6sm+MdGt4Iwkdq7Mm98JNiBAIauGM9K+lzYB1IV2IYBmNvSLNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k22lnWvI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F332C2BD10;
	Tue, 23 Apr 2024 17:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713893125;
	bh=EGjmphNer7Ut89RHQco8gQbleBGKa1F+SeEnuAdzC24=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k22lnWvIHWfC5t8/0g/3eAEkJcSNnmFt1OpkOvuimGoblpA3kch0W+g6RzLrpg8Jp
	 IHwtEnzpvB9eytvhS1Ks+pLqm9CAXX9aSdpVPdBCXCffw3yxXpg7Sj/9BYAA9Puaau
	 acqj8jnQ4cD5IVYwNu5CMnF8CwWnEQWUQRWYcQ3ODHcNDn5P9JVhaCed6/hu4j+GV4
	 lE9JzMXgAqHl7Ar1P7Y7kS8Q5Ju19GSVBXlZczAKqNRW/WhRoeu9xZVy3judeUwKkq
	 tVgHdouctS30RMO9L7+BgT3Zc0Wc5+5QqNomwRc2mDnXtTvnMHI2/+tmtllsC6loB2
	 H/ccHATd9rwmQ==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5ac4470de3bso391192eaf.0;
        Tue, 23 Apr 2024 10:25:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWq9v0B36wTDjs8BU2admfzYfoLynN0IxF8SW20v7RYVQyLqdRk22wUkyho2TgJuNQBzrE1ANJ5jQt1QCRQvhDZL3DGMWt+FyhRwUIufPId7+HyVPxhf3Rc8oikQvj0vn37bDgy8m4=
X-Gm-Message-State: AOJu0YzbBYig3ENeZHk1ROC4N2RUIkk9gU1O0mzwLfXT+C/C1futHwyh
	fi2+qTxS1Pt8Q+rYSpRy9mZDrdrG9lqKmJR6HDRBxPvkMXkzQddmrEm21mwOdi7Ys4bg5xr4OAS
	dCgEhHClJSZXmXpFiHXVAL0uTRSI=
X-Google-Smtp-Source: AGHT+IHZxfeMtLSsuNfLejJaIatSEGXfCBwgH4JQL9mfxOr8xiNXNEX1OrWc7uAcwyRIlh2nOSrXHucgRPZgEQeePiw=
X-Received: by 2002:a05:6870:d68c:b0:22e:77b6:4f9d with SMTP id
 z12-20020a056870d68c00b0022e77b64f9dmr17161055oap.3.1713893124960; Tue, 23
 Apr 2024 10:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13515747.uLZWGnKmhe@kreacher> <2009494.usQuhbGJ8B@kreacher> <9f45fd2d-f1de-437f-ae8a-75ad51a5c061@linaro.org>
In-Reply-To: <9f45fd2d-f1de-437f-ae8a-75ad51a5c061@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Apr 2024 19:25:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ggUSk43LGgXLU08svxtdUDbAvX+4Ca0DNTAH0H85i7Rg@mail.gmail.com>
Message-ID: <CAJZ5v0ggUSk43LGgXLU08svxtdUDbAvX+4Ca0DNTAH0H85i7Rg@mail.gmail.com>
Subject: Re: [PATCH v1 01/16] thermal: core: Introduce .trip_crossed()
 callback for thermal governors
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 7:14=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 10/04/2024 18:10, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Introduce a new thermal governor callback called .trip_crossed()
> > that will be invoked whenever a trip point is crossed by the zone
> > temperature, either on the way up or on the way down.
> >
> > The trip crossing direction information will be passed to it and if
> > multiple trips are crossed in the same direction during one thermal zon=
e
> > update, the new callback will be invoked for them in temperature order,
> > either ascending or descending, depending on the trip crossing
> > direction.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/thermal/thermal_core.c |   19 +++++++++++++++++--
> >   drivers/thermal/thermal_core.h |    4 ++++
> >   2 files changed, 21 insertions(+), 2 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/thermal_core.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_core.c
> > +++ linux-pm/drivers/thermal/thermal_core.c
> > @@ -302,11 +302,21 @@ static void monitor_thermal_zone(struct
> >               thermal_zone_device_set_polling(tz, tz->polling_delay_jif=
fies);
> >   }
> >
> > +static struct thermal_governor *thermal_get_tz_governor(struct thermal=
_zone_device *tz)
> > +{
> > +     if (tz->governor)
> > +             return tz->governor;
> > +
> > +     return def_governor;
> > +}
> > +
> >   static void handle_non_critical_trips(struct thermal_zone_device *tz,
> >                                     const struct thermal_trip *trip)
> >   {
> > -     tz->governor ? tz->governor->throttle(tz, trip) :
> > -                    def_governor->throttle(tz, trip);
> > +     struct thermal_governor *governor =3D thermal_get_tz_governor(tz)=
;
> > +
> > +     if (governor->throttle)
> > +             governor->throttle(tz, trip);
> >   }
> >
> >   void thermal_governor_update_tz(struct thermal_zone_device *tz,
> > @@ -470,6 +480,7 @@ static int thermal_trip_notify_cmp(void
> >   void __thermal_zone_device_update(struct thermal_zone_device *tz,
> >                                 enum thermal_notify_event event)
> >   {
> > +     struct thermal_governor *governor =3D thermal_get_tz_governor(tz)=
;
> >       struct thermal_trip_desc *td;
> >       LIST_HEAD(way_down_list);
> >       LIST_HEAD(way_up_list);
> > @@ -493,12 +504,16 @@ void __thermal_zone_device_update(struct
> >       list_for_each_entry(td, &way_up_list, notify_list_node) {
> >               thermal_notify_tz_trip_up(tz, &td->trip);
> >               thermal_debug_tz_trip_up(tz, &td->trip);
> > +             if (governor->trip_crossed)
> > +                     governor->trip_crossed(tz, &td->trip, true);
>
> Is it possible to wrap this into a function ? So we keep the calls at
> the same level in this block

I can send a separate patch for this if you want me to.

Thanks!

