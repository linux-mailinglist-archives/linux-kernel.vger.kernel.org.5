Return-Path: <linux-kernel+bounces-148254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC9E8A7FE9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A45DB20E47
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E9713D2B6;
	Wed, 17 Apr 2024 09:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXWXgxxX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E638213BC28;
	Wed, 17 Apr 2024 09:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346528; cv=none; b=U14URK7++9IWJ/iMhBTBlYZlAcXaLJEQq4cCDzq6y/d+g8ctVqCZzjEoZriqtSRGCLc3cowCBpXWtb8SLQQjrav19CnIHrPKVWaxae/o2u8zkbsghzJFFWlvTnsY1/liejS28nLvBOx9qTlsnNWRpoRnvwITIQf8g0P91nFx3LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346528; c=relaxed/simple;
	bh=FVTM6Kq9u0py4mW5xT/qLozNIRGPXJJY/cN+xZqdqPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYP+YM58XZGpx22OAeP8rVT6E6Z5vpC0z2O/ljPBT3Wq5LiWXfBmNNHBqO15vZLxTGoVwdSA9tzx2vUiKxNFYE52siEpS4+YVjFEwObdqA7GZOVmNyD3Mu5hLL1ML2QmYYTjqM6IO+Kr1BOe3/BX3xk0w0zjXmoAU0WvcfowlSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXWXgxxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B006EC32781;
	Wed, 17 Apr 2024 09:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713346527;
	bh=FVTM6Kq9u0py4mW5xT/qLozNIRGPXJJY/cN+xZqdqPE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mXWXgxxXAMV/Qma2Tys3Aqa6TkeUWDgc/PrwREmIXe2w1sVFlMGlPTNHpHfbRxGJk
	 b9AoKqVMI2Xy5py3LOPt/P2daoHbWs0mnzt/a3kcHau1mVvnBcU9xzYzI89O9Kiejs
	 zdjMfdeq6AIU9rxLIT0Mnja314Hsqhmpsyy/JnvI/Cl8GicU2iLWrVl9s1PNCu4FSo
	 jOUFoOH8sue3hiUMY+1b0N3c1BDkAua+0lflZWh37YNdc/fc13IL5xji5eygeVZ+Az
	 4eQgWqzkInh96BkRUmD7WtFciu/lIV1jKQucRtAUnPnwpwT8Rn4uuuabTXYiQmVTTP
	 /O2PtB34BxKJA==
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6eba841d83cso61420a34.2;
        Wed, 17 Apr 2024 02:35:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWLgKT8ka+7GwNjDiWarj4tU2HUOHSzbnEK8J+rM9sMR3fjN6OM7328CVyUWi7iCG9DhfCCVMyVNbnmP4ZHTLNMgVOwTnm3C3Qr0lo1
X-Gm-Message-State: AOJu0YyRnHmY3HCE7GPpuasYtNZqp1nQdXmQFTVqayA7WpqBMRekeB6H
	0oB8Sh7aoJhblj7uA/dwUhnolhGgnHcH24gWK0FycVPjfbGYhWj7mTmHPJmrOYBGkMrIML5BMCo
	6lQKEvXY+5oA2LJlLn2Ec2z9SgD4=
X-Google-Smtp-Source: AGHT+IHbjIQrHMFg/9QgbHO4ibNWIcvoVbY99/A0PKxpNe1lvnBUE8+TY59QReoRzR+WLbkg2bHfyV9B7ktxuHMwxdg=
X-Received: by 2002:a4a:bb18:0:b0:5aa:14ff:4128 with SMTP id
 f24-20020a4abb18000000b005aa14ff4128mr15953452oop.1.1713346526956; Wed, 17
 Apr 2024 02:35:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12418263.O9o76ZdvQC@kreacher> <2321994.ElGaqSPkdT@kreacher>
In-Reply-To: <2321994.ElGaqSPkdT@kreacher>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 17 Apr 2024 11:35:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hK0M=84Yn_ZZLPrz9pbD7MrSoUpu_F4fzvq9A8cM2vNQ@mail.gmail.com>
Message-ID: <CAJZ5v0hK0M=84Yn_ZZLPrz9pbD7MrSoUpu_F4fzvq9A8cM2vNQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] thermal/debugfs: Add helper function for trip
 stats updates
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 9:03=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The code updating a trip_stats entry in thermal_debug_tz_trip_up()
> and thermal_debug_update_temp() is almost entirely duplicate, so move
> it to a new helper function that will be called from both these places.
>
> While at it, drop a redundant tz_dbg->nr_trips check and a label related
> to it from thermal_debug_update_temp().
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In the meantime I realized that thermal_debug_update_temp() made
false-positive updates of trips involved in the current mitigation
episode in the cases when they were crossed on the way down.

Namely, in that case the zone temperature is already below the low
temperature of the trip, but that is only recorded by
thermal_debug_tz_trip_down() that is called after
thermal_debug_update_temp().

For this reason, I'm withdrawing this patch and I will send
replacement patches later today.

Thanks!

> ---
>  drivers/thermal/thermal_debugfs.c |   42 +++++++++++++++++--------------=
-------
>  1 file changed, 19 insertions(+), 23 deletions(-)
>
> Index: linux-pm/drivers/thermal/thermal_debugfs.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/thermal/thermal_debugfs.c
> +++ linux-pm/drivers/thermal/thermal_debugfs.c
> @@ -539,6 +539,19 @@ static struct tz_episode *thermal_debugf
>         return tze;
>  }
>
> +static struct trip_stats *update_tz_episode(struct tz_debugfs *tz_dbg,
> +                                           int trip_id, int temperature)
> +{
> +       struct tz_episode *tze =3D list_first_entry(&tz_dbg->tz_episodes,
> +                                                 struct tz_episode, node=
);
> +       struct trip_stats *trip_stats =3D &tze->trip_stats[trip_id];
> +
> +       trip_stats->max =3D max(trip_stats->max, temperature);
> +       trip_stats->min =3D min(trip_stats->min, temperature);
> +       trip_stats->avg +=3D (temperature - trip_stats->avg) / ++trip_sta=
ts->count;
> +       return trip_stats;
> +}
> +
>  void thermal_debug_tz_trip_up(struct thermal_zone_device *tz,
>                               const struct thermal_trip *trip)
>  {
> @@ -547,6 +560,7 @@ void thermal_debug_tz_trip_up(struct the
>         struct thermal_debugfs *thermal_dbg =3D tz->debugfs;
>         int temperature =3D tz->temperature;
>         int trip_id =3D thermal_zone_trip_id(tz, trip);
> +       struct trip_stats *trip_stats;
>         ktime_t now =3D ktime_get();
>
>         if (!thermal_dbg)
> @@ -612,14 +626,8 @@ void thermal_debug_tz_trip_up(struct the
>          */
>         tz_dbg->trips_crossed[tz_dbg->nr_trips++] =3D trip_id;
>
> -       tze =3D list_first_entry(&tz_dbg->tz_episodes, struct tz_episode,=
 node);
> -       tze->trip_stats[trip_id].timestamp =3D now;
> -       tze->trip_stats[trip_id].max =3D max(tze->trip_stats[trip_id].max=
, temperature);
> -       tze->trip_stats[trip_id].min =3D min(tze->trip_stats[trip_id].min=
, temperature);
> -       tze->trip_stats[trip_id].count++;
> -       tze->trip_stats[trip_id].avg =3D tze->trip_stats[trip_id].avg +
> -               (temperature - tze->trip_stats[trip_id].avg) /
> -               tze->trip_stats[trip_id].count;
> +       trip_stats =3D update_tz_episode(tz_dbg, trip_id, temperature);
> +       trip_stats->timestamp =3D now;
>
>  unlock:
>         mutex_unlock(&thermal_dbg->lock);
> @@ -686,9 +694,8 @@ out:
>  void thermal_debug_update_temp(struct thermal_zone_device *tz)
>  {
>         struct thermal_debugfs *thermal_dbg =3D tz->debugfs;
> -       struct tz_episode *tze;
>         struct tz_debugfs *tz_dbg;
> -       int trip_id, i;
> +       int i;
>
>         if (!thermal_dbg)
>                 return;
> @@ -697,20 +704,9 @@ void thermal_debug_update_temp(struct th
>
>         tz_dbg =3D &thermal_dbg->tz_dbg;
>
> -       if (!tz_dbg->nr_trips)
> -               goto out;
> +       for (i =3D 0; i < tz_dbg->nr_trips; i++)
> +               update_tz_episode(tz_dbg, tz_dbg->trips_crossed[i], tz->t=
emperature);
>
> -       for (i =3D 0; i < tz_dbg->nr_trips; i++) {
> -               trip_id =3D tz_dbg->trips_crossed[i];
> -               tze =3D list_first_entry(&tz_dbg->tz_episodes, struct tz_=
episode, node);
> -               tze->trip_stats[trip_id].count++;
> -               tze->trip_stats[trip_id].max =3D max(tze->trip_stats[trip=
_id].max, tz->temperature);
> -               tze->trip_stats[trip_id].min =3D min(tze->trip_stats[trip=
_id].min, tz->temperature);
> -               tze->trip_stats[trip_id].avg =3D tze->trip_stats[trip_id]=
avg +
> -                       (tz->temperature - tze->trip_stats[trip_id].avg) =
/
> -                       tze->trip_stats[trip_id].count;
> -       }
> -out:
>         mutex_unlock(&thermal_dbg->lock);
>  }
>
>
>
>
>

