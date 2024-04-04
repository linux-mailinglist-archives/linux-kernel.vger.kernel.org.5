Return-Path: <linux-kernel+bounces-131146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA428983B2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D92991C22018
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9904E73531;
	Thu,  4 Apr 2024 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjAMY7vk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D671B3399A;
	Thu,  4 Apr 2024 09:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712221423; cv=none; b=ivBbXuXgV3bg6PwvNKusKA5a4DcdjCFR2wYJvldSt/x0BUYORU0pCoVHSL3l78/v6Ckt7BdXPHkiXVXXVfoI42WqT7UIFpqSeMaA0eOZh3Pjpz6w1hUGXqPMtFD/eUO3OYRgrSsDB93kGpRbIBJUptJ7YappNMEumWB+lBbQkLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712221423; c=relaxed/simple;
	bh=GPdoxmH0kXWK71xhmTauGg+kJZju/VsSstqqnKrPh3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCNYhpyG4RMZhiepX8LGHhVWFtqePbtvFnkP9jck5sqRwXxfnvZoHxWzpf7lLPPjpyQWkWbOtNcmqgSRB2Sd9SLog87r+ewP+yUOAcUz3Km2O36X64fbMaYCQrD0Qui2ND2MjPMTbxfMJhMBlw09hOWlW2MQMY8ge3j73Rxb+oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjAMY7vk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EECFC43399;
	Thu,  4 Apr 2024 09:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712221423;
	bh=GPdoxmH0kXWK71xhmTauGg+kJZju/VsSstqqnKrPh3c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SjAMY7vkFSjcACcmRHPyeHG7m3JBPkKHMaJIxOCUziSR0/nlvbwaG1JPnsWozAQlk
	 2KBUHqOOuMyyzX0hdCEGCQHx0ysztyCYFuxq0zo8jdTh5Fl3Ia0CEmO7nkLjLq/UQf
	 hKjbrZJFMgV5w2E7ENhMNXj4KDdsCNn4mymGidmO7/R4cHxmYv338i/1VEgpb74zBz
	 FuYzAns9OJzSXA9ndTdcBw85RJWzb5BAwRW27rS9m6/kuFstoUfMji0LpAjYmOdVPR
	 g51m/eQHs/sA6viYQusj3NErS5fdPHnHoLC0JrqZOTxcC43ByPIMVH7ZELrwawKzkp
	 YWiIuv2GUd/IQ==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a4930d9c48so128529eaf.1;
        Thu, 04 Apr 2024 02:03:43 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxp1aLRQlQk8PFTqkdsvt25VhUCixXRjnGqIlFQNOpA6Z1ey1Mw
	xrvOFhx2Usz5kP89EYdhPmdlf6JbgErCYd8k/Y/Dc+nLKoGzXgdzXCUFgvYrh3yk7DHxxzHnkxq
	xHITbXy2KewKkjF9GEH9z6NbwQrU=
X-Google-Smtp-Source: AGHT+IG1x7ghAraSqglLa67HISEtrAFoZm1A+mODWpVOFcuum6TmKbEi7oWlzKiPD7Vic27k+bqeVekjgsjaNf7c5DI=
X-Received: by 2002:a4a:3511:0:b0:5a4:6ac7:de6d with SMTP id
 l17-20020a4a3511000000b005a46ac7de6dmr1684332ooa.1.1712221422653; Thu, 04 Apr
 2024 02:03:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4558251.LvFx2qVVIh@kreacher> <3556878.iIbC2pHGDl@kreacher>
In-Reply-To: <3556878.iIbC2pHGDl@kreacher>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Apr 2024 11:03:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j0jKi9=w_RiYqSZuQtveskcE8jKZHDwaP1EmNOxLk-RQ@mail.gmail.com>
Message-ID: <CAJZ5v0j0jKi9=w_RiYqSZuQtveskcE8jKZHDwaP1EmNOxLk-RQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] thermal: core: Relocate critical and hot trip handling
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 9:04=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.net=
> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Modify handle_thermal_trip() to call handle_critical_trips() only after
> finding that the trip temperature has been crossed on the way up and
> remove the redundant temperature check from the latter.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

This change is premature, as it will cause handle_non_critical_trips()
to be called for hot/critical trips which is questionable, so I'm
withdrawing it for now.

The rest of the series is still applicable, though.


> ---
>  drivers/thermal/thermal_core.c |   15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> Index: linux-pm/drivers/thermal/thermal_core.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -349,10 +349,6 @@ void thermal_zone_device_critical_reboot
>  static void handle_critical_trips(struct thermal_zone_device *tz,
>                                   const struct thermal_trip *trip)
>  {
> -       /* If we have not crossed the trip_temp, we do not care. */
> -       if (trip->temperature <=3D 0 || tz->temperature < trip->temperatu=
re)
> -               return;
> -
>         trace_thermal_zone_trip(tz, thermal_zone_trip_id(tz, trip), trip-=
>type);
>
>         if (trip->type =3D=3D THERMAL_TRIP_CRITICAL)
> @@ -404,12 +400,15 @@ static void handle_thermal_trip(struct t
>                 list_add_tail(&td->notify_list_node, way_up_list);
>                 td->notify_temp =3D trip->temperature;
>                 td->threshold -=3D trip->hysteresis;
> +
> +               if (trip->type =3D=3D THERMAL_TRIP_CRITICAL ||
> +                   trip->type =3D=3D THERMAL_TRIP_HOT) {
> +                       handle_critical_trips(tz, trip);
> +                       return;
> +               }
>         }
>
> -       if (trip->type =3D=3D THERMAL_TRIP_CRITICAL || trip->type =3D=3D =
THERMAL_TRIP_HOT)
> -               handle_critical_trips(tz, trip);
> -       else
> -               handle_non_critical_trips(tz, trip);
> +       handle_non_critical_trips(tz, trip);
>  }
>
>  static void update_temperature(struct thermal_zone_device *tz)
>
>
>
>

