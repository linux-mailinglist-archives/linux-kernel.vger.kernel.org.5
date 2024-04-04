Return-Path: <linux-kernel+bounces-131347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5605389868E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5C61F246E9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DE984FBF;
	Thu,  4 Apr 2024 11:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxFiXLzR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E7884FAA;
	Thu,  4 Apr 2024 11:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231840; cv=none; b=jWaN/gcrpVXtp7+WNl/+vtdLLzIucmRUciUUH1mb+SCyEDEFisutOSC8UYPilA/CaQJfHobgrH1h15PvFiu2NzjhLHLXuRRHKnsuj1uLSfANod+toArpzaUFT1MJlqvspuqV4bmpUtnjCrU6LqZJ6qxaoOC1PdbGYVvj5O+/sbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231840; c=relaxed/simple;
	bh=Dl0DCFFeaG32auCuag3L3uwTOmeWVL3ayWOMwWYAh8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jBDrvIQe2A14wZTdtrzF+MpIk2MVnj5wBUpHsFAqMKPrv78xj0SzGI2zfz9JQ231y5PFiApVtl97OKOBJG9VxdqwvG2RzQNtI2hYpM1l12pZ+Av0J/hSBVE0uLFM7tSe7Nmyh5ZuFDZQpp2p6LKEDM0xto6zhP1LouQvX7vsWtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxFiXLzR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC7EC43394;
	Thu,  4 Apr 2024 11:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712231840;
	bh=Dl0DCFFeaG32auCuag3L3uwTOmeWVL3ayWOMwWYAh8g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DxFiXLzRpeXrD5jM6XlZnyh/7G/4TMqh8nzd6j0aWfeiqUMSOVHDcGMjfZtzEY9H8
	 gZmL+yfbuZAjZK/p4djk6G7SQdsogQjWVctEZxj0Ga3fP1avhxysVjYOMJ7O/w51TO
	 duDMI0BuK0ObfXLRc1zwWEm2b+tigCRyrBiTCdWNo2l+RZr1OtlS54cwrmM4LpYoO4
	 e8TUhzGCDn+4uEkHGDzOkA5oO2gsGu7BxUhBr5Y/TQcVN9lEN+ru4m7sKtSGOK5D9C
	 ezPeMNLHCb0Y5cm219SgI0nlyo+DNaKHSJRMhjWf5fXiNIyfHjLhp3+zdEHZn6z/wm
	 wu3tLft3tETKw==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5a4e0859b65so268083eaf.0;
        Thu, 04 Apr 2024 04:57:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWWp1kRPb0kgvD84UIrkDcC0jpi+SG+RbWiQ3F3YPErpsj5aLHmOOqSJClMooX6nEeIEWI24GuHBK1Uy8dqdZ9SGcs7FrXikENfX0Ez98v52eQpyj6u0n1szU/rK9vCMPykzPUMUUU=
X-Gm-Message-State: AOJu0Yz6kgoc5Cv2fXFyl4iB43QQdpEh8qbZhp+jzkFxXXAzVO/iPT9Z
	MAqwMYOkibFAa73wkm6mz92kndk9/oDaDmPj4asvv+J3etZhJAdX1fVlbjmfbXkrp9ldyL7r3Bc
	tYyw4vU4XzwA4mk1ps8sKzcoCyCY=
X-Google-Smtp-Source: AGHT+IGmHNaoCJ05Wj/10dFYzW7o/nO7HyRVuPaGHmT3FbayK4Gc1hRS13Ap+tRnqEIM30ZGkBW+zHYw+HDPdi6e1TA=
X-Received: by 2002:a4a:dbc7:0:b0:5a4:5630:93d6 with SMTP id
 t7-20020a4adbc7000000b005a4563093d6mr2273294oou.1.1712231839209; Thu, 04 Apr
 2024 04:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5766468.DvuYhMxLoT@kreacher> <2318465.ElGaqSPkdT@kreacher> <6f950b18-4ff7-4570-957d-49b46167c12e@arm.com>
In-Reply-To: <6f950b18-4ff7-4570-957d-49b46167c12e@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Apr 2024 13:57:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hD=Nfk3=5gQuEKu8oq9PV6C_+7N0ZJYKkQ9OH505RpZg@mail.gmail.com>
Message-ID: <CAJZ5v0hD=Nfk3=5gQuEKu8oq9PV6C_+7N0ZJYKkQ9OH505RpZg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] thermal: gov_step_wise: Simplify checks related to
 passive trips
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 1:26=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> wr=
ote:
>
>
>
> On 4/3/24 19:12, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Make it more clear from the code flow that the passive polling status
> > updates only take place for passive trip points.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/thermal/gov_step_wise.c |   14 ++++++--------
> >   1 file changed, 6 insertions(+), 8 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/gov_step_wise.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/gov_step_wise.c
> > +++ linux-pm/drivers/thermal/gov_step_wise.c
> > @@ -92,15 +92,13 @@ static void thermal_zone_trip_update(str
> >               if (instance->initialized && old_target =3D=3D instance->=
target)
> >                       continue;
> >
> > -             if (old_target =3D=3D THERMAL_NO_TARGET &&
> > -                 instance->target !=3D THERMAL_NO_TARGET) {
> > -                     /* Activate a passive thermal instance */
> > -                     if (trip->type =3D=3D THERMAL_TRIP_PASSIVE)
> > +             if (trip->type =3D=3D THERMAL_TRIP_PASSIVE) {
> > +                     /* If needed, update the status of passive pollin=
g. */
> > +                     if (old_target =3D=3D THERMAL_NO_TARGET &&
> > +                         instance->target !=3D THERMAL_NO_TARGET)
> >                               tz->passive++;
> > -             } else if (old_target !=3D THERMAL_NO_TARGET &&
> > -                        instance->target =3D=3D THERMAL_NO_TARGET) {
> > -                     /* Deactivate a passive thermal instance */
> > -                     if (trip->type =3D=3D THERMAL_TRIP_PASSIVE)
> > +                     else if (old_target !=3D THERMAL_NO_TARGET &&
> > +                              instance->target =3D=3D THERMAL_NO_TARGE=
T)
> >                               tz->passive--;
> >               }
> >
> >
> >
> >
>
> The patch looks good, although I got some warning while applying with
> my b4 tool:
> BADSIG: DKIM/rjwysocki.net

It's likely because it was sent from an address in the rjwysocki.net
domain, but it is perfectly fine to send "somebody else's" patches if
a replacement From: header is given.

Looks like a b4 issue to me.

> Anyway, it looks like false warning IMO.
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Thank you!

