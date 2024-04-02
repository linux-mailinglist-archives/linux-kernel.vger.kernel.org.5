Return-Path: <linux-kernel+bounces-128601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B8A895CF1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD35D1F222D3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090F915D5A9;
	Tue,  2 Apr 2024 19:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n79RWDNd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486A915CD78;
	Tue,  2 Apr 2024 19:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086984; cv=none; b=WtuxPUrfYtTQRHiahUAzzBm48afbhM2d2fw5vYb3vF6E3VC1KV60mpVmCB2kOdydpZRTdv+u2opDxUN+gma00br7y2fty/t6N5M3T6Dg9oAwlgmHdPWmfAR0Hmm8elbSY7ueSwN19s4BLAyPjjXHDF72gA1Ep/EqOe33cOS+wZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086984; c=relaxed/simple;
	bh=hux++m/Dx5FlfAfpKCTL72iTbUT8Ywm8K3OkJ/onX1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgBDRBE2/coGxvbygAJfUA6hpJ5fyHZLOmd739d3XePmWAbrbnB5ieNZhGozkmetFv1sEKTXs/BrT0fdxXFJHjxb19uYY6Aow31uFDPiLc2qhtzV+W+apSEnxiy3O22lOv0lttRhJUC9fhkCz2wdR4sJ7JrabLq5MrapnZSy1Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n79RWDNd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1AEDC43601;
	Tue,  2 Apr 2024 19:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712086983;
	bh=hux++m/Dx5FlfAfpKCTL72iTbUT8Ywm8K3OkJ/onX1E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n79RWDNdQ5jOejZzKpbWUX5cdLm9tDIsgvqhBfpj+Pgu2MGV3YkXLg+24mDi4ls3W
	 nUb59vF/2Kcruciot+DRMca9y/IJLGpRXfurhwuy8RcbY8+sE7kxlTq05LwjIiHtzA
	 CZy31RIgPKdzgKuLEQa5d4IyBWsG0msWf69Z52QzQUlkI0noGHdzfqPDg3F2FA0Epp
	 CpFzrW+2G64IAuKYjtdOsYqhCETPP7mynXEHSyBqRpJc6Q6i0SsITpXoO+pDwDyKIX
	 CJXUdqxin21h5pGsV6dBFJx7QC9jGGuz91AYn9d6/M5gdRMO8ZA4Uzr/nM/KohernR
	 BrngJ4HBu+7HA==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5a4930d9c48so1089577eaf.1;
        Tue, 02 Apr 2024 12:43:03 -0700 (PDT)
X-Gm-Message-State: AOJu0YwKaz2CxziMGQjSv08gjca6bVTwq/2S83pFtb0W12F0MfDFbFEy
	JPY8pfi2KMAa7VrP881JXjXsCLIhoPLFEhh1j78sJHzHm1xwsdDzzPL80yUJeYHmBsQmCkg4q74
	8bYRVpwTmRxK196pwqg9zrL/heRM=
X-Google-Smtp-Source: AGHT+IG0rTJIvGE2GbczLwW+SqLUgeZ4yISW7oJYWMUALQxGyOgRaj5b/VJdT3fuzvRrBwAsbtSz+v06K29NcIQqYHs=
X-Received: by 2002:a05:6820:2289:b0:5a4:6e23:e335 with SMTP id
 ck9-20020a056820228900b005a46e23e335mr15520012oob.0.1712086983154; Tue, 02
 Apr 2024 12:43:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4558251.LvFx2qVVIh@kreacher>
In-Reply-To: <4558251.LvFx2qVVIh@kreacher>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 2 Apr 2024 21:42:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iSyTP4SbGBYESNy9NynMCQn8dojCFoOtQU4Q305ZKGTQ@mail.gmail.com>
Message-ID: <CAJZ5v0iSyTP4SbGBYESNy9NynMCQn8dojCFoOtQU4Q305ZKGTQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] thermal: More separation between the core and drivers
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
> Hi Everyone,
>
> This is an update of
>
> https://lore.kernel.org/linux-pm/4558384.LvFx2qVVIh@kreacher/
>
> and
>
> https://lore.kernel.org/linux-pm/2331888.ElGaqSPkdT@kreacher/
>
> which rebases the first patch on top of 6.9-rc2, adds 3 patches and adjus=
ts
> the third patch from v2.
>
> The original description of the first two patches still applies:
>
> > Patch [1/2] is based on the observation that the threshold field in str=
uct
> > thermal_trip really should be core-internal and to make that happen it
> > introduces a wrapper structure around struct thermal_trip for internal
> > use in the core.
> >
> > Patch [2/2] moves the definition of the new structure and the struct
> > thermal_zone_device one to a local header file in the core to enforce
> > more separation between the core and drivers.
> >
> > The patches are not expected to introduce any observable differences in
> > behavior, so please let me know if you see any of that.
>
> Note that these patches were first sent before the merge window and have =
not
> really changed since then (except for a minor rebase of the first patch i=
n
> this series).  Moreover, no comments regarding the merit of these patches
> have been made shared, so if this continues, I will be considering them a=
s
> good to go by the end of this week.
>
> Patch [3/6] is a rewrite of comments regarding trip crossing and threshol=
d
> computations.
>
> Patch [4/6] updates the trip crossing detection code to consolidate the
> threshold initialization with trip crossing on the way up.
>
> Patch [5/6] ([3/3] in v2) adds a mechanism to sort notifications and debu=
g
> calls taking place during one invocation of __thermal_zone_device_update(=
) so
> they always go in temperature order.
>
> Patch [6/6] relocates the critical and trip point handling to avoid a
> redundant temperature check.
>
> The series applies on top of 6.9-rc2 and I'm planning to create a test
> branch containing it.

As promised:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=
=3Dthermal-core-testing

