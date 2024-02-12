Return-Path: <linux-kernel+bounces-61649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2948514EA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE80FB225F6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD624DA10;
	Mon, 12 Feb 2024 13:14:41 +0000 (UTC)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838D84D138;
	Mon, 12 Feb 2024 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743680; cv=none; b=EJT/dnIEq9yZLQ+fSQ0x/9EWVYlmLYEcjtQuErMHdwCbaAI6YS7xWTl4CsEF8u7AreQBqjWUOhwOmWfuX9ubdGtqNi44pzy275IcAhkjji5M6m/mIprL6orJcTVncGU5o/6eDaWg2PhGXGcUonr/gLVSEm9cmGS5symbPHPUmA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743680; c=relaxed/simple;
	bh=xLrubvOXIWaG5ypIlIgyoaUmN6jnod09uqn4rzwa6HI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xl1uvLV9JY6ZwRt9SFL5QDVmyHT6Rn5yhi86siXalFZ+0WPKSOUXQhwblMg9o0SgO2AYNx10MOO2Mb5Z3Ez6DObibhb23kYQK0z0b6yW/+QF1aGLbRO0buZ77c349N00to+ex2eaXddb/e51nN6mC25xkHmB4WH1QsWUnGjWFTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-59cbf204d52so224232eaf.1;
        Mon, 12 Feb 2024 05:14:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707743677; x=1708348477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pxvkc38U9s3DcZdB/JiCA8P1fxWR4fG0EKloHutaJ/Q=;
        b=Z2qXjNsCX2qDvQpg9VrzGeRcJrRh8nDXa4lj2hZFwXkZ/xaCy2EkjTpDsoQh00hBNF
         EavS6UQ9B7dsb7ohFn7E+TF5P4hyzUVLnSRG5Fp9AZ2RfyOPa9W9hjR47HMLNqCwRMwf
         Y7/AHenxOvylJZgGvCST5AWOoPrhBP6bF8Ks62gfvrK6nt3kYdw7zgwCLSt+F0KSnWXu
         VwNCrr6WBuL4MTiVOt/n7oeuEyXgM06TgDEWiwp6FRM39kmfm9WwOYOc5S2d3rgA+25r
         nq6k6Ucg8odeQSvLbesXgd1lnnFqYBze6TmanGkQn4uD/JCz3LV69p2FGxsL4R1y2MZu
         g34A==
X-Gm-Message-State: AOJu0YyQSa+BoQ8Ra5psznuzb4DXqy4wni4t2sRuNxZ0J4cln9F680Rt
	C1TTxymxugJpfmeySxKehg5ukgb0UVLW8xG/MzkZBzMOS7dn1RFo1Yc9ocdg7WJy2EKIX3mmTKM
	RWnABRiPP760Y9fszsqKiet9EyE6iktQK
X-Google-Smtp-Source: AGHT+IGapQqegXlSqDCpTcHwaawdnbFBDRDPO60i3uPd2gLv3x7/jAKo5OyG5JdMpwm36eD3JU1HFtZkSzzAOHkJX7U=
X-Received: by 2002:a4a:ce94:0:b0:59a:bfb:f556 with SMTP id
 f20-20020a4ace94000000b0059a0bfbf556mr5298057oos.0.1707743677486; Mon, 12 Feb
 2024 05:14:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207020923.4720-1-di.shen@unisoc.com>
In-Reply-To: <20240207020923.4720-1-di.shen@unisoc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 12 Feb 2024 14:14:25 +0100
Message-ID: <CAJZ5v0jTY+_YYfeTzf0vNKogGAd334pUH5-W1xXiDL2REroViA@mail.gmail.com>
Subject: Re: [RESEND][PATCH V2] thermal: power_allocator: Avoid overwriting
 PID coefficients from setup time
To: Di Shen <di.shen@unisoc.com>
Cc: lukasz.luba@arm.com, rafael@kernel.org, daniel.lezcano@linaro.org, 
	rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xuewen.yan@unisoc.com, zhanglyra@gmail.com, orsonzhai@gmail.com, 
	cindygm567@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 3:09=E2=80=AFAM Di Shen <di.shen@unisoc.com> wrote:
>
> When the PID coefficients k_* are set via sysfs before the IPA
> algorithm is triggered then the coefficients would be overwritten after
> IPA throttle() is called. The old configuration values might be
> different than the new values estimated by the IPA internal algorithm.
>
> There might be a time delay when this overwriting happens. It
> depends on the thermal zone temperature value. The temperature value
> needs to cross the first trip point value then IPA algorithms start
> operating. Although, the PID coefficients setup time should not be
> affected or linked to any later operating phase and values must not be
> overwritten.
>
> This patch initializes params->sustainable_power when the governor
> binds to thermal zone to avoid overwriting k_*. The basic function won't
> be affected, as the k_* still can be estimated if the sustainable_power
> is modified.
>
> Signed-off-by: Di Shen <di.shen@unisoc.com>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/gov_power_allocator.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_=
power_allocator.c
> index 81e061f183ad..1b17dc4c219c 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -711,6 +711,8 @@ static int power_allocator_bind(struct thermal_zone_d=
evice *tz)
>
>         if (!tz->tzp->sustainable_power)
>                 dev_warn(&tz->device, "power_allocator: sustainable_power=
 will be estimated\n");
> +       else
> +               params->sustainable_power =3D tz->tzp->sustainable_power;
>
>         estimate_pid_constants(tz, tz->tzp->sustainable_power,
>                                params->trip_switch_on,
> --

Applied as 6.9 material, thanks!

