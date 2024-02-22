Return-Path: <linux-kernel+bounces-76819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF7985FD10
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CC9A1C2409E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A302814F9E4;
	Thu, 22 Feb 2024 15:52:02 +0000 (UTC)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DF414D44C;
	Thu, 22 Feb 2024 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617122; cv=none; b=HEsFlezRUoAGR96r5QSzdVPblD9JNA3f4X5j54bbo55G5RDHs6JElZlzUyDs1TweRLkVIOHSP2N2LJdZSTytBYEnwLMszf9r82KLdu2fJZLVEi5VDUgYGwAstiuKirg/wILq3lWIqYHVIVCmF1WwgiayxZIpakGwKv3kkhG7zPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617122; c=relaxed/simple;
	bh=mkjHm/NVb9a2uWxajb0Ouni221Gr7rVjOELDkF29fVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZE3xZLSFmtAHo6LCIscKbvt9kC+jCsigqxp0t/FeBWUcE4xLpTqYpfU1iMm0JP7bAahfNWQR7pPxUUIptSl/zD3jJqNdcYMjUm/68I7kkivJlz24GRUkmCWN3XtHbNio7TTUMDwRWjGGtI04Loj8Dpb5e/Kw9ASGLXIMFXrE8As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-59fc31c57easo1527784eaf.1;
        Thu, 22 Feb 2024 07:52:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708617119; x=1709221919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUugHfDLSgSDL3uT41o5vUaHZB8bMJCbk674TlEy4XU=;
        b=Jlxa8s7xcT0sSWUi3ODwaDJnpLVOX+Bo5CY3s1G6yy0yPJ4tC7CAbC4hxAThUPUJ9k
         efOBwGW+xw6xXLXDBGfbLWWfg2K/BUVrlwWmsUl/UmfeKNVc/1XHG+VtFwisCl/JT4XY
         rHHce+hGgqqLh3JwR/cPesbk3kRRxkl2wRtwYuRnnEaSHl9VEuvm4M7m88ZY/lqZN4Hi
         5xT6VpSdkthr9W6tdrAyheh/HiVeUqXTBD9GpHEf1v2ZJ0fmcnQz8eH1MzXE0c3n/IeE
         3gGFRtJEtMqLKzr8qupyXb6YSfL4cQwxRevFpNhppJm8c7fyMnsVAy3406anOM0tDMIA
         xr4w==
X-Forwarded-Encrypted: i=1; AJvYcCVPC0G+SDbcijMirqbHeLZx0LH7fl25y6d8ZBoRZNve3KkS58q7gCd8GXywXeoIa7IAWTHKK37pyhrlavbIDdWH5hTcRZBBPciCOdDLASF+1oWJiw5jw7pc/ZxeE8oPsf2u15lwBYaxQqrGAjXylbToJ94yK+WNaLEiifR01sbezCspR4NujKFQsCazdFo88d6Xg7tQmbInEVuODg4WjQ==
X-Gm-Message-State: AOJu0Yyp1OJu1XTFbsilRyw4S3Y/e5Zgh8YFuQaNO7a98Av4AkEs5CKi
	byDeLFOtmVXlV3mVwI/3T/xc8iKBUKDoEZ9i7IbDNKVxRZpusPim+7ccQR5IK0vBCA+XhPyCyUZ
	fFJFjNn/dVHJDAhPDfx1a5zrjcIw=
X-Google-Smtp-Source: AGHT+IHyxSwW1kmoq+/lgG2oeRQLzRN0uhtfVW3o6WiFkJW1sEH+QD0jVJCqboDpe1GdciaHyQ4u2pOwGUSHa1V7YoM=
X-Received: by 2002:a05:6820:2993:b0:5a0:3c8a:4940 with SMTP id
 dq19-20020a056820299300b005a03c8a4940mr162267oob.1.1708617119517; Thu, 22 Feb
 2024 07:51:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6017196.lOV4Wx5bFT@kreacher> <2173914.irdbgypaU6@kreacher> <59e8fd70-5ba6-4256-9127-bd5e76e6bc99@linaro.org>
In-Reply-To: <59e8fd70-5ba6-4256-9127-bd5e76e6bc99@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Feb 2024 16:51:48 +0100
Message-ID: <CAJZ5v0gcK7mQgDTHqo3PYT10sKqJJvu6JP0BLEHG6m0HzUKyCA@mail.gmail.com>
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

On Thu, Feb 22, 2024 at 3:36=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 12/02/2024 19:31, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > In order to allow thermal zone creators to specify the writability of
> > trip point temperature and hysteresis on a per-trip basis, add a flags
> > field to struct thermal_trip and define flags to represent the desired
> > trip properties.
> >
> > Also make thermal_zone_device_register_with_trips() set the
> > THERMAL_TRIP_FLAG_RW_TEMP flag for all trips covered by the writable
> > trips mask passed to it and modify the thermal sysfs code to look at
> > the trip flags instead of using the writable trips mask directly or
> > checking the presence of the .set_trip_hyst() zone callback.
> >
> > Additionally, make trip_point_temp_store() and trip_point_hyst_store()
> > fail with an error code if the trip passed to one of them has
> > THERMAL_TRIP_FLAG_RW_TEMP or THERMAL_TRIP_FLAG_RW_HYST,
> > respectively, clear in its flags.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v1 -> v2:
> >     * Rename trip flags (Stanislaw).
> >
> > ---
> >   drivers/thermal/thermal_core.c  |   12 +++++++++++-
> >   drivers/thermal/thermal_core.h  |    2 +-
> >   drivers/thermal/thermal_sysfs.c |   28 +++++++++++++++++++---------
> >   include/linux/thermal.h         |    7 +++++++
> >   4 files changed, 38 insertions(+), 11 deletions(-)
> >
> > Index: linux-pm/include/linux/thermal.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/include/linux/thermal.h
> > +++ linux-pm/include/linux/thermal.h
> > @@ -64,15 +64,23 @@ enum thermal_notify_event {
> >    * @threshold: trip crossing notification threshold miliCelsius
> >    * @type: trip point type
> >    * @priv: pointer to driver data associated with this trip
> > + * @flags: flags representing binary properties of the trip
> >    */
> >   struct thermal_trip {
> >       int temperature;
> >       int hysteresis;
> >       int threshold;
> >       enum thermal_trip_type type;
> > +     u8 flags;
> >       void *priv;
> >   };
> >
> > +#define THERMAL_TRIP_FLAG_RW_TEMP    BIT(0)
> > +#define THERMAL_TRIP_FLAG_RW_HYST    BIT(1)
> > +
> > +#define THERMAL_TRIP_FLAG_MASK_RW    (THERMAL_TRIP_FLAG_RW_TEMP | \
> > +                                      THERMAL_TRIP_FLAG_RW_HYST)
>
> What about THERMAL_TRIP_FLAG_RW instead ?

Fine with me.

> >   struct thermal_zone_device_ops {
> >       int (*bind) (struct thermal_zone_device *,
> >                    struct thermal_cooling_device *);
> > Index: linux-pm/drivers/thermal/thermal_core.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_core.c
> > +++ linux-pm/drivers/thermal/thermal_core.c
> > @@ -1356,13 +1356,23 @@ thermal_zone_device_register_with_trips(
> >       tz->devdata =3D devdata;
> >       tz->trips =3D trips;
> >       tz->num_trips =3D num_trips;
> > +     if (num_trips > 0) {
>
> Is this check really necessary?

No, it isn't.

> for_each_trip() should exit immediately if there is no trip points.

Right.

> > +             struct thermal_trip *trip;
> > +
> > +             for_each_trip(tz, trip) {
> > +                     if (mask & 1)
> > +                             trip->flags |=3D THERMAL_TRIP_FLAG_RW_TEM=
P;
> > +
> > +                     mask >>=3D 1;
> > +             }
> > +     }
> >
> >       thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_del=
ay);
> >       thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_del=
ay);
> >
> >       /* sys I/F */
> >       /* Add nodes that are always present via .groups */
> > -     result =3D thermal_zone_create_device_groups(tz, mask);
> > +     result =3D thermal_zone_create_device_groups(tz);
> >       if (result)
> >               goto remove_id;
> >
> > Index: linux-pm/drivers/thermal/thermal_core.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_core.h
> > +++ linux-pm/drivers/thermal/thermal_core.h
> > @@ -131,7 +131,7 @@ void thermal_zone_trip_updated(struct th
> >   int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp=
);
> >
> >   /* sysfs I/F */
> > -int thermal_zone_create_device_groups(struct thermal_zone_device *, in=
t);
> > +int thermal_zone_create_device_groups(struct thermal_zone_device *tz);
> >   void thermal_zone_destroy_device_groups(struct thermal_zone_device *)=
;
> >   void thermal_cooling_device_setup_sysfs(struct thermal_cooling_device=
 *);
> >   void thermal_cooling_device_destroy_sysfs(struct thermal_cooling_devi=
ce *cdev);
> > Index: linux-pm/drivers/thermal/thermal_sysfs.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
> > +++ linux-pm/drivers/thermal/thermal_sysfs.c
> > @@ -122,6 +122,11 @@ trip_point_temp_store(struct device *dev
> >
> >       trip =3D &tz->trips[trip_id];
> >
> > +     if (!(trip->flags & THERMAL_TRIP_FLAG_RW_TEMP)) {
> > +             ret =3D -EPERM;
> > +             goto unlock;
> > +     }
>
> Does it really happen?
>
> If the sysfs file is created with the right permission regarding the
> trip->flags then this condition can never be true.

But the permissions can be changed after the file has been created, can't t=
hey?

