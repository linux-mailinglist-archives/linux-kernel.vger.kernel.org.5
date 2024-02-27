Return-Path: <linux-kernel+bounces-83117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BD5868EAD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8FB1C22A79
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0039313A252;
	Tue, 27 Feb 2024 11:21:40 +0000 (UTC)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0122A8C1;
	Tue, 27 Feb 2024 11:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709032899; cv=none; b=hmym1+yeT8I8X9bD14IMgjZ3Y1QOlxTB2dsXRyRz1TmmSHAeVLrBGZy9wXPpOTOUZO/sS8Za2sIv+iR3kNFk86Yo+Y9OwTV9bcHrh9l6sgWeQXHVLiwqIrc1ZrL0t2KoNPGChhEEG3R00xpQX9KcljX36PZ3wxzdDpUrPvU3TfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709032899; c=relaxed/simple;
	bh=RaWEV72BqNmmOYLtb7IS8wMv+m+y+FZZl/ZP+h5IzIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOicVBJgvlacq8Za14nKTv02rxEv7ydkevyRYY3llp6rhchxU+fO5soiGKhlO/UsKUOvw3OqDKL/PLxSMMDQANpu5OND0qWrZTolF5jJ0xByN3YhmHDPW8jvTMIgAcdNEllVJUpOxG15A+Nji0Zphu0TR6PX52vjupiePQ1WQ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e4aa4877a9so37095a34.0;
        Tue, 27 Feb 2024 03:21:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709032896; x=1709637696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJa7MEOXe9perm2OgBKMzPUDW7pCOyIoOUv/oJgjUmw=;
        b=Ptt1TZt/4Mvw22VF3ycC047q5A/Vmk3mlb16kbV+ET4Fv7V4zHdq/j95RxBd1dn6zQ
         0omI1WpWrv4xx4i8XJGuMD2zCVgEU1M7N7qWKFlAEDbyRDoGqZmBEKfCWvlpvKFUIv7S
         hc91aNQl+hr6j0NVQHl4aS12XKKdKCFHF3xNTknl2muZS1LQ/ghJk0tgGPNlaJlytKmm
         wWUvEDb3qBM8oyObAZfeKHtKji/rns0I2ZSFjAC2wU4R6nkvPJjaPj0GO4CYzlqICJcb
         FQ2DpHHBT8gbHugj3ja6LXUVuTyE2/negxNPADN65IPopxJnX5hJKV6wfndY1jvZW6ml
         0Iog==
X-Forwarded-Encrypted: i=1; AJvYcCW/9QmpdCTeb3CoPURwqRu/mh+PuU3mo83KW2Q29QZwNuEBjJAXuKReGrrhBbf5A5xV9d0MRvhdzxelcNfwrxJeH0zvYMFleNlSERJUTYZ2l0J9Md0zqZ4vLjkXrnIklFbMnVBDoM9Nbpp1N+f/DhRKGlhDGcujxyWdjbimKGoR8pzY7U4=
X-Gm-Message-State: AOJu0YwjOlhJaALmuqk00Cy2Kng7cnc75ECPYaZgC2Rt9hY5/E2yehUw
	XbPiOl63hf5ruc6ntDnkzuvOksakQOHaRZPSPbNaixzuv0F/NbuvtZhxlWjwGbaqDbUWLbULj8M
	TamWYjqBBh2fXE4PH4koaJZ6RtznyVJIb
X-Google-Smtp-Source: AGHT+IG9R13m5DR4gqp8WyHLIwyWyY0kzDaW1HOcNY3cc8IEXbuXqtoRojPV8BUhSKwMbh395KfY6gadg4eji0L5rKk=
X-Received: by 2002:a05:6820:2b15:b0:5a0:396d:2489 with SMTP id
 dt21-20020a0568202b1500b005a0396d2489mr9325087oob.1.1709032896476; Tue, 27
 Feb 2024 03:21:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6017196.lOV4Wx5bFT@kreacher> <2173914.irdbgypaU6@kreacher> <5779195.DvuYhMxLoT@kreacher>
In-Reply-To: <5779195.DvuYhMxLoT@kreacher>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Feb 2024 12:21:25 +0100
Message-ID: <CAJZ5v0j1vzUuNNVihQghiN_ZbEWwxZh9u+Jf1EpBwLJpXry7nA@mail.gmail.com>
Subject: Re: [PATCH v2.1 2/9] thermal: core: Add flags to struct thermal_trip
To: Linux PM <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>, 
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, linux-wireless@vger.kernel.org, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 8:48=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> In order to allow thermal zone creators to specify the writability of
> trip point temperature and hysteresis on a per-trip basis, add a flags
> field to struct thermal_trip and define flags to represent the desired
> trip properties.
>
> Also make thermal_zone_device_register_with_trips() set the
> THERMAL_TRIP_FLAG_RW_TEMP flag for all trips covered by the writable
> trips mask passed to it and modify the thermal sysfs code to look at
> the trip flags instead of using the writable trips mask directly or
> checking the presence of the .set_trip_hyst() zone callback.
>
> Additionally, make trip_point_temp_store() and trip_point_hyst_store()
> fail with an error code if the trip passed to one of them has
> THERMAL_TRIP_FLAG_RW_TEMP or THERMAL_TRIP_FLAG_RW_HYST,
> respectively, clear in its flags.
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

AFAICS this patch addresses all of the review comments and because the
rest of the series (depending on it) has been approved, I'm applying
the whole series including this patch.

> ---
>
> v2 -> v2.1:
>    * Don't add redundant checks in 3 places (Daniel).
>    * Define THERMAL_TRIP_FLAG_RW as the combination of the _RW_ trip flag=
s (Daniel).
>
> v1 -> v2:
>    * Rename trip flags (Stanislaw).
>
> ---
>  drivers/thermal/thermal_core.c  |    9 ++++++++-
>  drivers/thermal/thermal_core.h  |    2 +-
>  drivers/thermal/thermal_sysfs.c |   18 +++++++++---------
>  include/linux/thermal.h         |    8 ++++++++
>  4 files changed, 26 insertions(+), 11 deletions(-)
>
> Index: linux-pm/include/linux/thermal.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/include/linux/thermal.h
> +++ linux-pm/include/linux/thermal.h
> @@ -64,15 +64,23 @@ enum thermal_notify_event {
>   * @threshold: trip crossing notification threshold miliCelsius
>   * @type: trip point type
>   * @priv: pointer to driver data associated with this trip
> + * @flags: flags representing binary properties of the trip
>   */
>  struct thermal_trip {
>         int temperature;
>         int hysteresis;
>         int threshold;
>         enum thermal_trip_type type;
> +       u8 flags;
>         void *priv;
>  };
>
> +#define THERMAL_TRIP_FLAG_RW_TEMP      BIT(0)
> +#define THERMAL_TRIP_FLAG_RW_HYST      BIT(1)
> +
> +#define THERMAL_TRIP_FLAG_RW   (THERMAL_TRIP_FLAG_RW_TEMP | \
> +                                THERMAL_TRIP_FLAG_RW_HYST)
> +
>  struct thermal_zone_device_ops {
>         int (*bind) (struct thermal_zone_device *,
>                      struct thermal_cooling_device *);
> Index: linux-pm/drivers/thermal/thermal_core.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -1278,6 +1278,7 @@ thermal_zone_device_register_with_trips(
>                                         int passive_delay, int polling_de=
lay)
>  {
>         struct thermal_zone_device *tz;
> +       struct thermal_trip *trip;
>         int id;
>         int result;
>         struct thermal_governor *governor;
> @@ -1356,13 +1357,19 @@ thermal_zone_device_register_with_trips(
>         tz->devdata =3D devdata;
>         memcpy(tz->trips, trips, num_trips * sizeof(*trips));
>         tz->num_trips =3D num_trips;
> +       for_each_trip(tz, trip) {
> +               if (mask & 1)
> +                       trip->flags |=3D THERMAL_TRIP_FLAG_RW_TEMP;
> +
> +               mask >>=3D 1;
> +       }
>
>         thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_del=
ay);
>         thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_del=
ay);
>
>         /* sys I/F */
>         /* Add nodes that are always present via .groups */
> -       result =3D thermal_zone_create_device_groups(tz, mask);
> +       result =3D thermal_zone_create_device_groups(tz);
>         if (result)
>                 goto remove_id;
>
> Index: linux-pm/drivers/thermal/thermal_core.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/thermal/thermal_core.h
> +++ linux-pm/drivers/thermal/thermal_core.h
> @@ -131,7 +131,7 @@ void thermal_zone_trip_updated(struct th
>  int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
>
>  /* sysfs I/F */
> -int thermal_zone_create_device_groups(struct thermal_zone_device *, int)=
;
> +int thermal_zone_create_device_groups(struct thermal_zone_device *tz);
>  void thermal_zone_destroy_device_groups(struct thermal_zone_device *);
>  void thermal_cooling_device_setup_sysfs(struct thermal_cooling_device *)=
;
>  void thermal_cooling_device_destroy_sysfs(struct thermal_cooling_device =
*cdev);
> Index: linux-pm/drivers/thermal/thermal_sysfs.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
> +++ linux-pm/drivers/thermal/thermal_sysfs.c
> @@ -392,17 +392,16 @@ static const struct attribute_group *the
>  /**
>   * create_trip_attrs() - create attributes for trip points
>   * @tz:                the thermal zone device
> - * @mask:      Writeable trip point bitmap.
>   *
>   * helper function to instantiate sysfs entries for every trip
>   * point and its properties of a struct thermal_zone_device.
>   *
>   * Return: 0 on success, the proper error value otherwise.
>   */
> -static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
> +static int create_trip_attrs(struct thermal_zone_device *tz)
>  {
> +       const struct thermal_trip *trip;
>         struct attribute **attrs;
> -       int indx;
>
>         /* This function works only for zones with at least one trip */
>         if (tz->num_trips <=3D 0)
> @@ -437,7 +436,9 @@ static int create_trip_attrs(struct ther
>                 return -ENOMEM;
>         }
>
> -       for (indx =3D 0; indx < tz->num_trips; indx++) {
> +       for_each_trip(tz, trip) {
> +               int indx =3D thermal_zone_trip_id(tz, trip);
> +
>                 /* create trip type attribute */
>                 snprintf(tz->trip_type_attrs[indx].name, THERMAL_NAME_LEN=
GTH,
>                          "trip_point_%d_type", indx);
> @@ -458,7 +459,7 @@ static int create_trip_attrs(struct ther
>                                                 tz->trip_temp_attrs[indx]=
name;
>                 tz->trip_temp_attrs[indx].attr.attr.mode =3D S_IRUGO;
>                 tz->trip_temp_attrs[indx].attr.show =3D trip_point_temp_s=
how;
> -               if (mask & (1 << indx)) {
> +               if (trip->flags & THERMAL_TRIP_FLAG_RW_TEMP) {
>                         tz->trip_temp_attrs[indx].attr.attr.mode |=3D S_I=
WUSR;
>                         tz->trip_temp_attrs[indx].attr.store =3D
>                                                         trip_point_temp_s=
tore;
> @@ -473,7 +474,7 @@ static int create_trip_attrs(struct ther
>                                         tz->trip_hyst_attrs[indx].name;
>                 tz->trip_hyst_attrs[indx].attr.attr.mode =3D S_IRUGO;
>                 tz->trip_hyst_attrs[indx].attr.show =3D trip_point_hyst_s=
how;
> -               if (tz->ops.set_trip_hyst) {
> +               if (trip->flags & THERMAL_TRIP_FLAG_RW_HYST) {
>                         tz->trip_hyst_attrs[indx].attr.attr.mode |=3D S_I=
WUSR;
>                         tz->trip_hyst_attrs[indx].attr.store =3D
>                                         trip_point_hyst_store;
> @@ -505,8 +506,7 @@ static void destroy_trip_attrs(struct th
>         kfree(tz->trips_attribute_group.attrs);
>  }
>
> -int thermal_zone_create_device_groups(struct thermal_zone_device *tz,
> -                                     int mask)
> +int thermal_zone_create_device_groups(struct thermal_zone_device *tz)
>  {
>         const struct attribute_group **groups;
>         int i, size, result;
> @@ -522,7 +522,7 @@ int thermal_zone_create_device_groups(st
>                 groups[i] =3D thermal_zone_attribute_groups[i];
>
>         if (tz->num_trips) {
> -               result =3D create_trip_attrs(tz, mask);
> +               result =3D create_trip_attrs(tz);
>                 if (result) {
>                         kfree(groups);
>
>
>
>
>

