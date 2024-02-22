Return-Path: <linux-kernel+bounces-76864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3228785FDD5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 480AB1C23295
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44715153BCE;
	Thu, 22 Feb 2024 16:13:57 +0000 (UTC)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AE01509B4;
	Thu, 22 Feb 2024 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708618436; cv=none; b=Re+IGLLPiSgIYrLQZBFAYiWnY5vASCXX69UDL562+H4M43ovG+jaG123oon/i1QN9qqzBP1Q1ORtny8NZxA82Y2bvnjVRn1yOJXLlnIus3dIBNdiPx5+FmWgQDZr0ie8lIQpUSlHtuXN7IpgQhRuL+rQNqRObfrHQ4DpiwSLSgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708618436; c=relaxed/simple;
	bh=xLTXZ6Bxgt5ETszVJtzS1FY0pNctpGeWh88l/gFNDvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDQBOdXHoP5OblqdSM0D+JCUHAdTQBLaBYzWI9FSRS7jvthcjab9U7JFv6cxRKut31/OQ7XbFx8lZNrkyc4/1yl8X0GU74BTKwFeMf4PtS4ofmsrYCMW8URpmWMm5Je8taQObI+iBl/Zb0YFXoBgXQX6PsS5R2iMPyLTkYiqmis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e45f7c63f4so249037a34.1;
        Thu, 22 Feb 2024 08:13:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708618434; x=1709223234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7kywycVUYnMKGOh8phoPBRqxepGp2IOpF8EYijVPTo=;
        b=EFBx3wQy2hU038vCQHvAuiMWkNfw/uNlXhseRTrN7FuITwfJXh5GMaiCTjSwsD5/jq
         SuPtYONAwPYjBQ4WXoq1UGRvg0OQIAulAQUKXk73dueqH55j9ZvomEiSDJt94i1T9nGR
         t/OuNPWhFK0jySaH7bLdtJ0Fg/Xek99Jv9FWUM/kyppgJuuCcCeQZwrX5dJfbPaamk9l
         3EkCkwqIqcBGCYX1sLLqcdGytIqIQPNpq+Kbm68Ptclby5dV3LgqFUANHETt+yrnf9iX
         cfyHt7WEbKYFjzhpXJe3QP0XGLbBGPUGMXxAfk5A8MpIrRBVbP3uyuBHvCsrpX5YG65a
         K+WA==
X-Forwarded-Encrypted: i=1; AJvYcCUNL2zoVBcS4i6LPpdfhaziKdS4NRqhCX2YqvxWRHk8/YCkgP77TMaN7oBq/rZHOZMu4rDa+n5UraQS3QmG8d4BejpCPgneiNOycSF2gr1ndJoBC1dp6UAJB+6Xf1seB0oV/XbbrlzEMf3o40aO2vcmkg+czJg2wQo958sohJPWgRaA1n9TAh+AwfRtXZj/A2GYTRyNhcKtE448cQrHXA==
X-Gm-Message-State: AOJu0Yxr9ZIAyDG1Vc0SWabrq9H232XkjS3cxpcMUjIcR8EDB4m212VG
	LRyiS90BNYgl/W2ZY6eYTqJZm6g0uv9T0GQlr/W/fj39nFODEbOy7n1+6JlJ1U8ayW1/dzzLNmk
	fC6mfcNMbJKlhS2kKDo7yPpKfQrM=
X-Google-Smtp-Source: AGHT+IElkHO4h3c6WWghois3wiU/qlbtAodvC+rzPTHM2+ADVw24psp0/zEmR6tv+Yp2vnmYYvcIM6jx6Tuv9eYN/Lw=
X-Received: by 2002:a4a:a886:0:b0:5a0:396d:2489 with SMTP id
 q6-20020a4aa886000000b005a0396d2489mr872892oom.1.1708618434009; Thu, 22 Feb
 2024 08:13:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6017196.lOV4Wx5bFT@kreacher> <2173914.irdbgypaU6@kreacher>
 <59e8fd70-5ba6-4256-9127-bd5e76e6bc99@linaro.org> <CAJZ5v0gcK7mQgDTHqo3PYT10sKqJJvu6JP0BLEHG6m0HzUKyCA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gcK7mQgDTHqo3PYT10sKqJJvu6JP0BLEHG6m0HzUKyCA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Feb 2024 17:13:42 +0100
Message-ID: <CAJZ5v0j6LWGnUfB6fbgHTXFOJ=n857ZSxqbd3u-5_FAVnbhXoQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] thermal: core: Add flags to struct thermal_trip
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>, 
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, linux-wireless@vger.kernel.org, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 4:51=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Feb 22, 2024 at 3:36=E2=80=AFPM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> >
> > On 12/02/2024 19:31, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > In order to allow thermal zone creators to specify the writability of
> > > trip point temperature and hysteresis on a per-trip basis, add a flag=
s
> > > field to struct thermal_trip and define flags to represent the desire=
d
> > > trip properties.
> > >
> > > Also make thermal_zone_device_register_with_trips() set the
> > > THERMAL_TRIP_FLAG_RW_TEMP flag for all trips covered by the writable
> > > trips mask passed to it and modify the thermal sysfs code to look at
> > > the trip flags instead of using the writable trips mask directly or
> > > checking the presence of the .set_trip_hyst() zone callback.
> > >
> > > Additionally, make trip_point_temp_store() and trip_point_hyst_store(=
)
> > > fail with an error code if the trip passed to one of them has
> > > THERMAL_TRIP_FLAG_RW_TEMP or THERMAL_TRIP_FLAG_RW_HYST,
> > > respectively, clear in its flags.
> > >
> > > No intentional functional impact.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >
> > > v1 -> v2:
> > >     * Rename trip flags (Stanislaw).
> > >
> > > ---
> > >   drivers/thermal/thermal_core.c  |   12 +++++++++++-
> > >   drivers/thermal/thermal_core.h  |    2 +-
> > >   drivers/thermal/thermal_sysfs.c |   28 +++++++++++++++++++---------
> > >   include/linux/thermal.h         |    7 +++++++
> > >   4 files changed, 38 insertions(+), 11 deletions(-)
> > >
> > > Index: linux-pm/include/linux/thermal.h
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- linux-pm.orig/include/linux/thermal.h
> > > +++ linux-pm/include/linux/thermal.h
> > > @@ -64,15 +64,23 @@ enum thermal_notify_event {
> > >    * @threshold: trip crossing notification threshold miliCelsius
> > >    * @type: trip point type
> > >    * @priv: pointer to driver data associated with this trip
> > > + * @flags: flags representing binary properties of the trip
> > >    */
> > >   struct thermal_trip {
> > >       int temperature;
> > >       int hysteresis;
> > >       int threshold;
> > >       enum thermal_trip_type type;
> > > +     u8 flags;
> > >       void *priv;
> > >   };
> > >
> > > +#define THERMAL_TRIP_FLAG_RW_TEMP    BIT(0)
> > > +#define THERMAL_TRIP_FLAG_RW_HYST    BIT(1)
> > > +
> > > +#define THERMAL_TRIP_FLAG_MASK_RW    (THERMAL_TRIP_FLAG_RW_TEMP | \
> > > +                                      THERMAL_TRIP_FLAG_RW_HYST)
> >
> > What about THERMAL_TRIP_FLAG_RW instead ?
>
> Fine with me.
>
> > >   struct thermal_zone_device_ops {
> > >       int (*bind) (struct thermal_zone_device *,
> > >                    struct thermal_cooling_device *);
> > > Index: linux-pm/drivers/thermal/thermal_core.c
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- linux-pm.orig/drivers/thermal/thermal_core.c
> > > +++ linux-pm/drivers/thermal/thermal_core.c
> > > @@ -1356,13 +1356,23 @@ thermal_zone_device_register_with_trips(
> > >       tz->devdata =3D devdata;
> > >       tz->trips =3D trips;
> > >       tz->num_trips =3D num_trips;
> > > +     if (num_trips > 0) {
> >
> > Is this check really necessary?
>
> No, it isn't.
>
> > for_each_trip() should exit immediately if there is no trip points.
>
> Right.
>
> > > +             struct thermal_trip *trip;
> > > +
> > > +             for_each_trip(tz, trip) {
> > > +                     if (mask & 1)
> > > +                             trip->flags |=3D THERMAL_TRIP_FLAG_RW_T=
EMP;
> > > +
> > > +                     mask >>=3D 1;
> > > +             }
> > > +     }
> > >
> > >       thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_d=
elay);
> > >       thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_d=
elay);
> > >
> > >       /* sys I/F */
> > >       /* Add nodes that are always present via .groups */
> > > -     result =3D thermal_zone_create_device_groups(tz, mask);
> > > +     result =3D thermal_zone_create_device_groups(tz);
> > >       if (result)
> > >               goto remove_id;
> > >
> > > Index: linux-pm/drivers/thermal/thermal_core.h
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- linux-pm.orig/drivers/thermal/thermal_core.h
> > > +++ linux-pm/drivers/thermal/thermal_core.h
> > > @@ -131,7 +131,7 @@ void thermal_zone_trip_updated(struct th
> > >   int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *te=
mp);
> > >
> > >   /* sysfs I/F */
> > > -int thermal_zone_create_device_groups(struct thermal_zone_device *, =
int);
> > > +int thermal_zone_create_device_groups(struct thermal_zone_device *tz=
);
> > >   void thermal_zone_destroy_device_groups(struct thermal_zone_device =
*);
> > >   void thermal_cooling_device_setup_sysfs(struct thermal_cooling_devi=
ce *);
> > >   void thermal_cooling_device_destroy_sysfs(struct thermal_cooling_de=
vice *cdev);
> > > Index: linux-pm/drivers/thermal/thermal_sysfs.c
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
> > > +++ linux-pm/drivers/thermal/thermal_sysfs.c
> > > @@ -122,6 +122,11 @@ trip_point_temp_store(struct device *dev
> > >
> > >       trip =3D &tz->trips[trip_id];
> > >
> > > +     if (!(trip->flags & THERMAL_TRIP_FLAG_RW_TEMP)) {
> > > +             ret =3D -EPERM;
> > > +             goto unlock;
> > > +     }
> >
> > Does it really happen?
> >
> > If the sysfs file is created with the right permission regarding the
> > trip->flags then this condition can never be true.
>
> But the permissions can be changed after the file has been created, can't=
 they?

Even so, the .store() callback will not be set then anyway.

I'll send an update of this patch.

