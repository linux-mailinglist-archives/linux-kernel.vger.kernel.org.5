Return-Path: <linux-kernel+bounces-93925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB736873702
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B76281544
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7317512FF91;
	Wed,  6 Mar 2024 12:53:21 +0000 (UTC)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872B98615A;
	Wed,  6 Mar 2024 12:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709729601; cv=none; b=fW1Rub3mVmgnT7WFVJ5aoeqidQ3Rih2QArg9+se0teLZa9BJLLQpum6XrbJKFLuhEszWEZLkSNSUm5n+29PEhIP6TF/E2rm3wpUswSm03OUH1rheSx//xn34kFus4sicMSS5RfVEf7cYr8n84toWnw4RtUvz22gH5c1SMihM1fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709729601; c=relaxed/simple;
	bh=y3kQn2h0xqTDbe12pz3WTdK+o94C/uEC85RMraZcn5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vB1WmAfTNZqEbm4nOw8hVgJ2MGETKH3S7W/guzKSSXBqDIsBNlbl1ujdmLwY48zfO0eZudLK7mib8JcTkdVrildT2DNIV+6KEKqOkCgsO4M//0nr0ziH8HfDt+PLk/mjyFAUhXtf6KYoQCE+jGp5Q0mJ2wWRvhj7SWnr2oSe6aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-21f10aae252so739162fac.0;
        Wed, 06 Mar 2024 04:53:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709729598; x=1710334398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRJTBcBNjexBHBHoxpbZHoKaxr9Kj8yTCM0BDotImdU=;
        b=afFyQaUizVj77GqPsO7wzm/ElORUTQ6W3reLrvMCxfGYBtPABnh03M9E6iFk+XAFGP
         WdkORiRPs4gqpBY8u95uZrpl59oKKCTOWTYror2aF0v0RhysPyH8CyQO3dl4pejDmise
         PMyL+J5JY3+2lD0SSheeK6xhoFj8SBy4KmFfuxOp95WtBQG1qoEii9WdoR++20+GP4Fo
         p5nr9a2sCNeTMk5zRwHUjBfmbEs/sSL/TaUW8ZKixZAghR/Y8l3RJZ4oykJ04iEfpNXm
         kaVAKItx2dc5GJF7V/i4lhpY2f5nfMJGn034keb99AbeT9rF+hzzx9xitGFr3RBh931y
         aR4w==
X-Forwarded-Encrypted: i=1; AJvYcCUbIRxncaUHlc6Xxft4YXurGJj9WhtG9jsVHswZrlUouP3peDqBcKkafKyeMh/qHRfZbJr9Y9GeDoyjz8T0KlTxe+itw3Bt96A6LCcdnVfFCnTy0F9op1kXjEqQYYlEAop+59A+Jj4=
X-Gm-Message-State: AOJu0YwSUM+3c597nZcpDXHqeLKjsU+hPuiMDzzjtR2wyWj2X81p7fJc
	uPQ19SP8PZWD5O7MJREzzfi4nuYKS8V3gSIWOmSFOtp3E7XwFHuImyucYST+dUSsxCQ58t+p9ae
	fOZQFZfxUvG9HJV9IAmjI2bakDIo=
X-Google-Smtp-Source: AGHT+IE8Au1kDor7m+c4NznK728Sahd1d7tP44xofyEfiZLxZtSRLXZB4oO2ia5w44eDRWVy1ojmEG+Te/BUP+A4wmU=
X-Received: by 2002:a05:6870:b507:b0:21f:cd7d:9904 with SMTP id
 v7-20020a056870b50700b0021fcd7d9904mr3603831oap.4.1709729598602; Wed, 06 Mar
 2024 04:53:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306085428.88011-1-daniel.lezcano@linaro.org>
 <CAJZ5v0jAn2F-GH=fguX0+3bG38vyAxfufadtFiBUfg=EjTBh6Q@mail.gmail.com> <14651d5b-0f67-4bff-b699-2cd1601b4fb2@linaro.org>
In-Reply-To: <14651d5b-0f67-4bff-b699-2cd1601b4fb2@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Mar 2024 13:53:07 +0100
Message-ID: <CAJZ5v0j6At1DuQYjjbA-fw9Z-jJPhXSVSz=_uLa3KfNMJowYbA@mail.gmail.com>
Subject: Re: [RFC PATCH] thermal/core: Fix trip point crossing events ordering
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	"open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 1:43=E2=80=AFPM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:
>
> On 06/03/2024 13:02, Rafael J. Wysocki wrote:
>
> [ ... ]
>
> >> +#define for_each_trip_reverse(__tz, __trip)    \
> >> +       for (__trip =3D &__tz->trips[__tz->num_trips - 1]; __trip >=3D=
 __tz->trips ; __trip--)
> >> +
> >>   void __thermal_zone_set_trips(struct thermal_zone_device *tz);
> >>   int thermal_zone_trip_id(const struct thermal_zone_device *tz,
> >>                           const struct thermal_trip *trip);
> >> --
> >
> > Generally speaking, this is a matter of getting alignment on the
> > expectations between the kernel and user space.
> >
> > It looks like user space expects to get the notifications in the order
> > of either growing or falling temperatures, depending on the direction
> > of the temperature change.  Ordering the trips in the kernel is not
> > practical, but the notifications can be ordered in principle.  Is this
> > what you'd like to do?
>
> Yes
>
> > Or can user space be bothered with recognizing that it may get the
> > notifications for different trips out of order?
>
> IMO it is a bad information if the trip points events are coming
> unordered. The temperature signal is a time related measurements, the
> userspace should receive thermal information from this signal in the
> right order. It sounds strange to track the temperature signal in the
> kernel, then scramble the information, pass it to the userspace and
> except it to apply some kind of logic to unscramble it.

So the notifications can be ordered before sending them out, as long
as they are produced by a single __thermal_zone_device_update() call.

I guess you also would like the thermal_debug_tz_trip_up/down() calls
to be ordered, wouldn't you?

