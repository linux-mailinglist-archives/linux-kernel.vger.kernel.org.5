Return-Path: <linux-kernel+bounces-121528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA48688E93B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB00C1C283A1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC25149E08;
	Wed, 27 Mar 2024 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0UtVpHi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C262D149DE0;
	Wed, 27 Mar 2024 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553133; cv=none; b=d1l1dHlqs//CzlL1kIxaXeT5qO+rDY7hgsQaPJWno7/NT6FxU2RTrpuqwzoalUkOFtKsICvBBciIJu3HL8033lDAJ23bdwsiIPycDALVyNAVkw2BkOOPpz7UT7Qiu1QQXE4BOleIbhF4zNhZ1ecFaTWARNHv1ILJWnFBsX9J+3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553133; c=relaxed/simple;
	bh=DLhR7AzkO0xf8+xYLiFt7UJXuf/uTo3qQMUJ4AihCJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BF49v8B5G0AyU9Kklpm55ALVf+KmHb1zMaACSH4+cuKhy5bPH+CRQk0oNQNpID0EqCCxReZjtvvz9UQwySW/S1yqijm1M30ivj/J45jvLI2bTcGcpurAjUCP5gIffSyORmYXT6yZzEWLv/NfIPYcWynyaiWpotG7IOtbF0Vsl3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0UtVpHi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B652C433B2;
	Wed, 27 Mar 2024 15:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711553133;
	bh=DLhR7AzkO0xf8+xYLiFt7UJXuf/uTo3qQMUJ4AihCJI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c0UtVpHiXxvyCG626zVmhvcD4i+DEkn1Q1tGU04kzVzfizD8QtqNSfEwsNap+m4WS
	 CtNJKmGYp0wu+cXzP4jDO4594oQ3oeCTPymspkML0Um5vg5kv6kJ4krIijtROSiJzn
	 ap4GENDyB5KmbFgWXpjg1NdWrounhPxuWcZOnvyJqGRL2HAk9nq84HmfMeS0M4JJZf
	 RMnVxMRfoQGVSB1fRr1wvZV0FeXbBZt9X57sdCBwnYb/z+FKNt+jVrf7H64tToLTZm
	 wXdyPRhxgEqbt7OaZY6Kvw1bwBwBXgDEDKopFSAiz4tm0X2xOUsRewT/7K6xhga9j4
	 1G6ucz3FPMhlQ==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e67ad4c2e3so494569a34.1;
        Wed, 27 Mar 2024 08:25:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXKNLHpx6t6dhxtCbLSJJK8VyscTgloL+YVZ58CfmXNoKi7NyTtkXu2sNbv3f2llEAXk8NooMoGqtPfbUKEHF2uBt2Od+Te/M0uc+59P+NG38WHYnBZIcvTFqrmO2T/+6kp+xwGpxo=
X-Gm-Message-State: AOJu0YwNYDivdQpFOdgc9wH6cmnhknRgaxAj0rrybhHzh3aDy2rSAR75
	blsb9QMeL5bnoKdzkoXEcdaWJHpoog+AChGNGo1yTBhLwIN0LYN7yWMY4mf4lZSethoGLgKx/eV
	ZusLTJDdDA9dBztXPeGmOU7okxEg=
X-Google-Smtp-Source: AGHT+IHyocjUoMb2836C7kecUnLxqysy7ocHQMv/hFnJPjZWGdKMobN2j6lJ80C5dtAFC/mUPOpuzP9Ai7SGpBhOzPE=
X-Received: by 2002:a05:6870:14d6:b0:229:e3d8:128c with SMTP id
 l22-20020a05687014d600b00229e3d8128cmr13824960oab.1.1711553132646; Wed, 27
 Mar 2024 08:25:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321-gpa-no-cooling-devs-v1-1-5c9e0ef2062e@trvn.ru>
In-Reply-To: <20240321-gpa-no-cooling-devs-v1-1-5c9e0ef2062e@trvn.ru>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 27 Mar 2024 16:25:21 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jAq=iMKzYBz-Ni6Zqpbgxp3_0UYpPiAoSLcfGNJ8ruhQ@mail.gmail.com>
Message-ID: <CAJZ5v0jAq=iMKzYBz-Ni6Zqpbgxp3_0UYpPiAoSLcfGNJ8ruhQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: gov_power_allocator: Allow binding without
 cooling devices
To: nikita@trvn.ru, Lukasz Luba <lukasz.luba@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 3:44=E2=80=AFPM Nikita Travkin <nikita@trvn.ru> wro=
te:
>
> Commit e83747c2f8e3 ("thermal: gov_power_allocator: Set up trip points ea=
rlier")
> added a check that would fail binding the governer if there is no
> cooling devices bound to the thermal zone. Unfortunately this causes
> issues in cases when the TZ is bound to the governer before the cooling
> devices are attached to it. (I.e. when the tz is registered using
> thermal_zone_device_register_with_trips().)
>
> Additionally, the documentation across gov_power_allocator suggests it's
> intended to allow it to be bound to thermal zones without cooling
> devices (and thus without passive/active trip points), however the same
> change added a check for the trip point to be present, causing those TZ
> to fail probing.
>
> Those changes cause all thermal zones to fail on some devices (such as
> sc7180-acer-aspire1) and prevent the kernel from controlling the cpu/gpu
> frequency based on the temperature, as well as losing all the other
> "informational" thermal zones if power_allocator is set as default.
>
> This commit partially reverts the referenced one by dropping the trip
> point check and by allowing the TZ to probe even if no actor buffer was
> allocated to allow those TZ to probe again.
>
> Fixes: e83747c2f8e3 ("thermal: gov_power_allocator: Set up trip points ea=
rlier")
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
> I've noticed that all thermal zones fail probing with -EINVAL on my
> sc7180 based Acer Aspire 1 since 6.8. This commit allows me to bring
> them back.

=C5=81ukasz, any comments?

> ---
>  drivers/thermal/gov_power_allocator.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_=
power_allocator.c
> index 1b17dc4c219c..4f2d7f3b7508 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -679,11 +679,6 @@ static int power_allocator_bind(struct thermal_zone_=
device *tz)
>                 return -ENOMEM;
>
>         get_governor_trips(tz, params);
> -       if (!params->trip_max) {
> -               dev_warn(&tz->device, "power_allocator: missing trip_max\=
n");
> -               kfree(params);
> -               return -EINVAL;
> -       }
>
>         ret =3D check_power_actors(tz, params);
>         if (ret < 0) {
> @@ -693,7 +688,7 @@ static int power_allocator_bind(struct thermal_zone_d=
evice *tz)
>         }
>
>         ret =3D allocate_actors_buffer(params, ret);
> -       if (ret) {
> +       if (ret && ret !=3D -EINVAL) {
>                 dev_warn(&tz->device, "power_allocator: allocation failed=
\n");
>                 kfree(params);
>                 return ret;
> @@ -714,9 +709,10 @@ static int power_allocator_bind(struct thermal_zone_=
device *tz)
>         else
>                 params->sustainable_power =3D tz->tzp->sustainable_power;
>
> -       estimate_pid_constants(tz, tz->tzp->sustainable_power,
> -                              params->trip_switch_on,
> -                              params->trip_max->temperature);
> +       if (params->trip_max)
> +               estimate_pid_constants(tz, tz->tzp->sustainable_power,
> +                                      params->trip_switch_on,
> +                                      params->trip_max->temperature);
>
>         reset_pid_controller(params);
>
>
> ---
> base-commit: e7528c088874326d3060a46f572252be43755a86
> change-id: 20240321-gpa-no-cooling-devs-c79ee3288325
>
> Best regards,
> --
> Nikita Travkin <nikita@trvn.ru>
>

