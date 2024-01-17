Return-Path: <linux-kernel+bounces-29336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E266E830CFA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1107E1C23EB2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0E0241FD;
	Wed, 17 Jan 2024 18:49:20 +0000 (UTC)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3E424210;
	Wed, 17 Jan 2024 18:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705517360; cv=none; b=bCs6qhTDa3cCcIL3cnDWRIx00aA2rgibWU5+MNMN7RjXzG4EUBMz6XeblGa7wpacfq9D31jwvYujxGnINdOzYD5Gt3lhlEvYjmFNVzjNcjW4Jd+J68ewp8DlUX6KVSIMSb9eaXK3p/9AB53yBhkU6x5JvXz43+vCjQshTHoRyw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705517360; c=relaxed/simple;
	bh=ad3rgJhd0883924xvrWg1RoM1ewVHOOJvoYUwjx2Wgg=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding; b=hkv5Q8JIAaKQQpksogPYlGQc8ta/ZQvXGp8TBxA55XSKdgvUjFPd7LR3EQVpCIiu525WBPSbHp+2VOyshk3IKjKR703OsGUoW0OjKJp3ng7UWTTwMfBW2IyTjFDRSXwDYXvtydD/Lz/0GcfFV5qMPA+a2G71EgA6Cn8qutk+fAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6dbc2bf4e8dso1659368a34.1;
        Wed, 17 Jan 2024 10:49:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705517357; x=1706122157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bsKv+8TAipZ/9m7Yt0BvIuN2J3MgQ0xrjWeDHKDNCg=;
        b=dV+NI7PLHE61YMuxyUp0JQx1dH1UVWONEmwCoSmXMw9z8HK3v444XtvOIykXR99qeV
         bGo9FB2Ws6vLnLqI3OQ85O56O4bf8irj2Z05PuV/sV/eOqLwo3dtEDsrhSmKqI/nHEIc
         XTfUzPdD6nyWMa/WsupGzE8q8ocVw86miM+8NYT2Swugpd4I52m/3sWP0NcN7Dply7GS
         mrRgwSvMjIotxNT52T1jBF9QxaljeVtb/oIrmqbBXNbKHnyjjI4anSuvFpF7yXv+OPJD
         kfz/a1d+4Zg8Dv1CivaTdJD7DoAjZmxdgdvcmJZKkSxr9rRioZiDAXrgQIyX7oAXDS69
         laGQ==
X-Gm-Message-State: AOJu0Yyp+udBhTfLHFYl3tAJih7ogYRFPUw6VtcvwMfupkifLTGxV9qb
	iWQdgtFlM4RaGcyXY/x4OoTWZDGwRRMLhxU/Aow=
X-Google-Smtp-Source: AGHT+IH1meNg4/ysFiD8RaIr2eXsh3meR0dtLD7wJXTUI2s7cmore6r1p0t/aEKnOM+VDrD2wpWBC5stmGNE2tT5NsE=
X-Received: by 2002:a4a:a549:0:b0:599:3475:64bb with SMTP id
 s9-20020a4aa549000000b00599347564bbmr1799487oom.1.1705517357432; Wed, 17 Jan
 2024 10:49:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106191502.29126-1-quic_manafm@quicinc.com>
 <CAJZ5v0gE6eEpALrfxHvCd5TRqjB+v8pffG4CKLTVXiSvuiWhHg@mail.gmail.com>
 <d7b82fc8-0ed8-80b8-9eb8-c77f9277178f@quicinc.com> <CAJZ5v0g4hnRqRCseRnTjfEF+-2=ZT8U9=2m9FODqh3G8eDd=Sw@mail.gmail.com>
 <921c2f90-fb8b-4e70-9e3d-6e185fec03b6@linaro.org>
In-Reply-To: <921c2f90-fb8b-4e70-9e3d-6e185fec03b6@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 17 Jan 2024 19:49:05 +0100
Message-ID: <CAJZ5v0h+93YBsYsA5rOvzp+b3JMGyjUStHA=J8P7ynv+-ym-4g@mail.gmail.com>
Subject: Re: [PATCH] thermal/sysfs: Always enable hysteresis write support
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 5:57=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 10/01/2024 13:48, Rafael J. Wysocki wrote:
> > Hi Manaf,
> >
> > On Wed, Jan 10, 2024 at 9:17=E2=80=AFAM Manaf Meethalavalappu Pallikunh=
i
> > <quic_manafm@quicinc.com> wrote:
> >>
> >> Hi Rafael,
> >>
> >> On 1/9/2024 7:12 PM, Rafael J. Wysocki wrote:
> >>
> >> On Sat, Jan 6, 2024 at 8:16=E2=80=AFPM Manaf Meethalavalappu Pallikunh=
i
> >> <quic_manafm@quicinc.com> wrote:
> >>
> >> The commit 2e38a2a981b2("thermal/core: Add a generic
> >> thermal_zone_set_trip() function") adds the support to update
> >> trip hysteresis even if set_trip_hyst() operation is not defined.
> >> But during hysteresis attribute creation, if this operation is
> >> defined then only it enables hysteresis write access. It leads
> >> to a case where hysteresis sysfs will be read only for a thermal
> >> zone when its set_trip_hyst() operation is not defined.
> >>
> >> Which is by design.
> >>
> >> I think it is regression after recent re-work. If a sensor is register=
ed with thermal framework via thermal_of,
> >>
> >> sensor driver doesn't need to know the trip configuration and nothing =
to do with set_trip_hyst() in driver.
> >>
> >> Without this change, if a sensor needs to be monitored from userspace(=
trip/hysteresis),
> >
> > What exactly do you mean by "monitored" here?
> >
> >> it is enforcing sensor driver to add  dummy set_trip_hyst() operation.=
 Correct me otherwise
> >
> > With the current design, whether or not trip properties can be updated
> > by user space is a thermal zone property expressed by the presence of
> > the set_trip_* operations, so yes, whoever registers the thermal zone
> > needs to provide those so that user space can update the trip
> > properties.
> >
> >> For some thermal zone types (eg. acpi), updating trip hysteresis via
> >> sysfs might lead to incorrect behavior.
> >>
> >> To address this issue, is it okay to  guard  hysteresis write permissi=
on under CONFIG_THERMAL_WRITABLE_TRIPS defconfig ?
> >
> > Not really, because it would affect all of the thermal zones then.
>
> It seems like there is an inconsistency here with the writable trip
> points and the writable hysteresis [1].
>
> My understanding is it does not make sense to have the hysteresis
> writable even if the driver has a hysteresis dedicated ops. The code
> allowing to change the hysteresis was done regardless the consistency
> with the trip temperature change and writable trip points kernel option I=
MO.
>
> It would make sense to have:
>
> if enabled(CONFIG_WRITABLE_TRIP_POINT)
>   -> trip_temp RW
>   -> trip_hyst RW
> else
>   -> trip temp RO
>   -> trip hyst RO
> fi
>
> But if the interface exists since a long time, we may not want to change
> it, right ?

If the platform firmware implements hysteresis by changing trip
temperature (as recommended by the ACPI specification, for example),
modifying the trip hysteresis via sysfs is simply incorrect and user
space may not know that.

> However, we can take the opportunity to introduce a new 'user' trip
> point type in order to let the userspace to have dedicated trip point
> and receive temperature notifications [2]
>
> > TBH, the exact scenario in which user space needs to update trip
> > hysteresis is not particularly clear to me, so can you provide some
> > more details, please?
>
> IIUC changing the hysteresis value is useful because the temperature
> speed will vary given the thermal contribution of the components
> surrounding the thermal zone, that includes the ambient temperature.
>
> However, that may apply to slow speed temperature sensor like the skin
> temperature sensor where we may to do small hysteresis variation.
>
> The places managed by the kernel have an insane temperature transition
> speed. The userspace is unable to follow this speed and manage the
> hysteresis on the fly.
>
> So that brings us to userspace trip point handling again.

Well, I've already said that whether hysteresis can be modified via
sysfs is a property of a thermal zone.

It may as well be a trip property, for example expressed via a (new)
trip flag set in the trips table used for thermal zone registration.

