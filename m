Return-Path: <linux-kernel+bounces-95438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BBA874DA2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9452F1C20299
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9471292EC;
	Thu,  7 Mar 2024 11:39:02 +0000 (UTC)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F65126F39;
	Thu,  7 Mar 2024 11:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811541; cv=none; b=lVavtYUZTmSfhqOxH2uqMJh0NT3Uz19rkyqCZEtQI1H0n3VBOY/EcdaD5h1l0S5lalL9KP2EYkjmq1KSRtIL2PmrkKR8qH+jFiVynYhKdMNOV1bg+jzGyRpTmlPNQn6L2M9BNp4Q0XS5VKq9Cg/G+tP9BsZuvePXjnSOxj5WFEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811541; c=relaxed/simple;
	bh=uX7S0ye0/RwbE45mNrU4QeDT8JTmzF6N5NJm4xWvp9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GgdWlEYvfDtyw3NpD1vquNXrZpRgKEAAYF6l/NAwgRqMYeJbQPbHmpGtDTVhK8qTOwYyCH3xk7bbd9IUSsXw+q52lS6+ezdA3j0SXZwa6OIn+25DLElm4VKidxrAxGhuDtvpkx8juTBDcHHbenRlvqLUYGKXtEmG2DC4xKZd8c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e4ea48972cso321937a34.0;
        Thu, 07 Mar 2024 03:38:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709811539; x=1710416339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0aXuxbQB6L9E9sYp+MsxGWXfxoLpRZ+/4Exv7ss/u8c=;
        b=cOXIkf1DZ9rPHSTq6irDnu+Qh3jR1UD67qD2JRbkNaXSejmKdJ0HplOlI1i9JDod0o
         3AsE3leSTfLYR82kPZCtihEbz5KKZX8M0qXk//d8pThfQ9sLmdK6GoEJFNYF7efHBgjG
         zre3QTCl+bFrnAniQSESkuL7CsiXnl8BpuQUzvNt+eVbGH/5dPwrIOL3sTz+hmrfvTx3
         CQQkASEVc6migJKyz6liuSXCTVfS5RT1ggPqxb8UqzlvDmQtbjd850IJEVTNLId32GCW
         bUCKvXzkHChrJzq9eCABo83IdpnmHUASYHzBC9fliJd9qNek3VDwRM8f+PqYysGoAZRJ
         42gg==
X-Forwarded-Encrypted: i=1; AJvYcCV5VxvQIP1fRQvg4eJflQxE4d/NAECrqWz2OYYhWQm5ybPgs1Bvw+SO6ac+S6FGYdrjPVJWlmWSyPnHDKy8Qhqw/yo4/8A2IEM=
X-Gm-Message-State: AOJu0YwLdGoBhmYFEuk1joAKHZMUh+4TjNy3BBCQYCWRTzpSM86ck7+v
	s8eMQ05tKb0pVQdnWDChxyvvQihb456p9nazPnauNn7X+tQBrqseZy+PW/UNxPSkvkeVILiWfBk
	PX802Cbo9SzQkM/lair/2cmWAJuw=
X-Google-Smtp-Source: AGHT+IF3BoxPjVFlegfb1RJogAksj61KraW7uvXe0Yxsv26cFmP/Q3g5IWTOjoFdv35tm7EtpPm+Rycyuufp8Ls67Sc=
X-Received: by 2002:a05:6870:f808:b0:21f:aa52:55d6 with SMTP id
 fr8-20020a056870f80800b0021faa5255d6mr2123874oab.0.1709811539070; Thu, 07 Mar
 2024 03:38:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306085428.88011-1-daniel.lezcano@linaro.org>
 <CAJZ5v0gWhNqTGpoOH01scCdC51cEnt_8_T5ccqZC6yXPDv9QcA@mail.gmail.com>
 <3bb7c6cf-f7a8-4059-ad8e-02e09c2a44b1@linaro.org> <2266782.iZASKD2KPV@kreacher>
In-Reply-To: <2266782.iZASKD2KPV@kreacher>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 7 Mar 2024 12:38:46 +0100
Message-ID: <CAJZ5v0jDdD1FSZsab0F=AQyxnUTKrBEFWpY4H+RJFGk8uYnJGQ@mail.gmail.com>
Subject: Re: [RFC PATCH] thermal/core: Fix trip point crossing events ordering
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	"open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 8:32=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.net=
> wrote:
>
> On Wednesday, March 6, 2024 4:55:51 PM CET Daniel Lezcano wrote:
> > On 06/03/2024 16:41, Rafael J. Wysocki wrote:
> > > On Wed, Mar 6, 2024 at 2:16=E2=80=AFPM Daniel Lezcano <daniel.lezcano=
@linaro.org> wrote:
> > >>
> > >> On 06/03/2024 13:53, Rafael J. Wysocki wrote:
> > >>> On Wed, Mar 6, 2024 at 1:43=E2=80=AFPM Daniel Lezcano <daniel.lezca=
no@linaro.org> wrote:
> > >>>>
> > >>>> On 06/03/2024 13:02, Rafael J. Wysocki wrote:
> > >>>>
> > >>>> [ ... ]
> > >>>>
> > >>>>>> +#define for_each_trip_reverse(__tz, __trip)    \
> > >>>>>> +       for (__trip =3D &__tz->trips[__tz->num_trips - 1]; __tri=
p >=3D __tz->trips ; __trip--)
> > >>>>>> +
> > >>>>>>     void __thermal_zone_set_trips(struct thermal_zone_device *tz=
);
> > >>>>>>     int thermal_zone_trip_id(const struct thermal_zone_device *t=
z,
> > >>>>>>                             const struct thermal_trip *trip);
> > >>>>>> --
> > >>>>>
> > >>>>> Generally speaking, this is a matter of getting alignment on the
> > >>>>> expectations between the kernel and user space.
> > >>>>>
> > >>>>> It looks like user space expects to get the notifications in the =
order
> > >>>>> of either growing or falling temperatures, depending on the direc=
tion
> > >>>>> of the temperature change.  Ordering the trips in the kernel is n=
ot
> > >>>>> practical, but the notifications can be ordered in principle.  Is=
 this
> > >>>>> what you'd like to do?
> > >>>>
> > >>>> Yes
> > >>>>
> > >>>>> Or can user space be bothered with recognizing that it may get th=
e
> > >>>>> notifications for different trips out of order?
> > >>>>
> > >>>> IMO it is a bad information if the trip points events are coming
> > >>>> unordered. The temperature signal is a time related measurements, =
the
> > >>>> userspace should receive thermal information from this signal in t=
he
> > >>>> right order. It sounds strange to track the temperature signal in =
the
> > >>>> kernel, then scramble the information, pass it to the userspace an=
d
> > >>>> except it to apply some kind of logic to unscramble it.
> > >>>
> > >>> So the notifications can be ordered before sending them out, as lon=
g
> > >>> as they are produced by a single __thermal_zone_device_update() cal=
l.
> > >>>
> > >>> I guess you also would like the thermal_debug_tz_trip_up/down() cal=
ls
> > >>> to be ordered, wouldn't you?
> > >>
> > >> Right
> > >
> > > I have an idea how to do this, but it is based on a couple of patches
> > > that I've been working on in the meantime.
> > >
> > > Let me post these patches first and then I'll send a prototype patch
> > > addressing this on top of them.
> >
> > That is awesome, thanks !
>
> Anytime!
>
> Now that I've posted this series:
>
> https://lore.kernel.org/linux-pm/4558384.LvFx2qVVIh@kreacher/
>
> I can append the patch below that is based on it.
>
> The idea is really straightforward: Instead of sending the notifications
> and recording the stats right away, create two lists of trips for which
> they need to be send, sort them and then send the notifications etc in
> the right order.  I want to avoid explicit memory allocations that can
> fail in principle, which is why lists are used.
>
> The reason why two lists are used is in case the trips are updated and
> that's why they appear to be crossed (which may not depend on the actual
> temperature change).
>
> One caveat is that the lists are sorted by trip thresholds (because they
> are the real values take into account in the code), but user space may
> expect them to be sorted by trip temperatures instead.  That can be chang=
ed.

I've concluded that it is better to sort by trip temperature, because
the thresholds used here are the new ones (computed after the trips
have been crossed) which may be confusing.

> ---
>  drivers/thermal/thermal_core.c |   39 +++++++++++++++++++++++++++++++++-=
-----
>  drivers/thermal/thermal_core.h |    1 +
>  2 files changed, 34 insertions(+), 6 deletions(-)
>
> Index: linux-pm/drivers/thermal/thermal_core.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -15,6 +15,7 @@
>  #include <linux/slab.h>
>  #include <linux/kdev_t.h>
>  #include <linux/idr.h>
> +#include <linux/list_sort.h>
>  #include <linux/thermal.h>
>  #include <linux/reboot.h>
>  #include <linux/string.h>
> @@ -361,7 +362,9 @@ static void handle_critical_trips(struct
>  }
>
>  static void handle_thermal_trip(struct thermal_zone_device *tz,
> -                               struct thermal_trip_desc *td)
> +                               struct thermal_trip_desc *td,
> +                               struct list_head *way_up_list,
> +                               struct list_head *way_down_list)
>  {
>         const struct thermal_trip *trip =3D &td->trip;
>
> @@ -382,8 +385,7 @@ static void handle_thermal_trip(struct t
>                  * the threshold and the trip temperature will be equal.
>                  */
>                 if (tz->temperature >=3D trip->temperature) {
> -                       thermal_notify_tz_trip_up(tz, trip);
> -                       thermal_debug_tz_trip_up(tz, trip);
> +                       list_add_tail(&td->notify_list_node, way_up_list)=
;
>                         td->threshold =3D trip->temperature - trip->hyste=
resis;
>                 } else {
>                         td->threshold =3D trip->temperature;
> @@ -400,8 +402,7 @@ static void handle_thermal_trip(struct t
>                  * the trip.
>                  */
>                 if (tz->temperature < trip->temperature - trip->hysteresi=
s) {
> -                       thermal_notify_tz_trip_down(tz, trip);
> -                       thermal_debug_tz_trip_down(tz, trip);
> +                       list_add(&td->notify_list_node, way_down_list);
>                         td->threshold =3D trip->temperature;
>                 } else {
>                         td->threshold =3D trip->temperature - trip->hyste=
resis;
> @@ -457,10 +458,24 @@ static void thermal_zone_device_init(str
>                 pos->initialized =3D false;
>  }
>
> +static int thermal_trip_notify_cmp(void *ascending, const struct list_he=
ad *a,
> +                                  const struct list_head *b)
> +{
> +       struct thermal_trip_desc *tda =3D container_of(a, struct thermal_=
trip_desc,
> +                                                    notify_list_node);
> +       struct thermal_trip_desc *tdb =3D container_of(b, struct thermal_=
trip_desc,
> +                                                    notify_list_node);
> +       int ret =3D tdb->threshold - tda->threshold;

So this will become

+    int ret =3D tdb->trip.temperature - tda->trip.temperature;

> +
> +       return ascending ? ret : -ret;
> +}
> +
>  void __thermal_zone_device_update(struct thermal_zone_device *tz,
>                                   enum thermal_notify_event event)
>  {
>         struct thermal_trip_desc *td;
> +       LIST_HEAD(way_down_list);
> +       LIST_HEAD(way_up_list);
>
>         if (tz->suspended)
>                 return;
> @@ -475,7 +490,19 @@ void __thermal_zone_device_update(struct
>         tz->notify_event =3D event;
>
>         for_each_trip_desc(tz, td)
> -               handle_thermal_trip(tz, td);
> +               handle_thermal_trip(tz, td, &way_up_list, &way_down_list)=
;
> +
> +       list_sort((void *)true, &way_up_list, thermal_trip_notify_cmp);
> +       list_for_each_entry(td, &way_up_list, notify_list_node) {
> +               thermal_notify_tz_trip_up(tz, &td->trip);
> +               thermal_debug_tz_trip_up(tz, &td->trip);
> +       }
> +
> +       list_sort(NULL, &way_down_list, thermal_trip_notify_cmp);
> +       list_for_each_entry(td, &way_down_list, notify_list_node) {
> +               thermal_notify_tz_trip_down(tz, &td->trip);
> +               thermal_debug_tz_trip_down(tz, &td->trip);
> +       }
>
>         monitor_thermal_zone(tz);
>  }
> Index: linux-pm/drivers/thermal/thermal_core.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/thermal/thermal_core.h
> +++ linux-pm/drivers/thermal/thermal_core.h
> @@ -17,6 +17,7 @@
>
>  struct thermal_trip_desc {
>         struct thermal_trip trip;
> +       struct list_head notify_list_node;
>         int threshold;
>  };
>

