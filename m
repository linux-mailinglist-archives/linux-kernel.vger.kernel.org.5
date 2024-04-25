Return-Path: <linux-kernel+bounces-158531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FD78B21BA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F951287C66
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C6E1494BB;
	Thu, 25 Apr 2024 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6dZUoYE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537C4133408;
	Thu, 25 Apr 2024 12:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714048619; cv=none; b=ef6+7iN05XHPJ7X8uzv7jL9bv30xwfZcCBgQGX8FJ8Fj+1izIA5q838CG0pRbKyOw82lzRWFJLBmG2plW2cx5IdZvQqvTPEj6FcmkMzri7Agkcf8gKuIY0zaz/VXAFdJ6ooAXrV9GTqjmcoN9ZpEuV+mNpNFDl907Fn6jlGfW6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714048619; c=relaxed/simple;
	bh=WPH2vArT6rmPx5cfh1ctX9In3WzdWlO76BEzWfqHfWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OvyFUhEW0Z/miqsaqgokCQrZUCkOUMvXQt8fYN+QdOCgYBAswxgCwQZwODxvVYP2v2k3dyR6ag0WBgoS8OBhlQE65UUOwbqWxRECt2ZL5chlsUvWrIJH6S9+SjU7TxLvQVtY0GwFZy+pGsa5cXfCJEGuQZalhZkBLlL+5I66Kmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6dZUoYE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB11C2BD10;
	Thu, 25 Apr 2024 12:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714048618;
	bh=WPH2vArT6rmPx5cfh1ctX9In3WzdWlO76BEzWfqHfWY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V6dZUoYEO7aXsjlSqknmQ5zuX2Au2c33+ZnePrhMd4AvUeYFl9g/+JIT80YGYboHK
	 PL+KZdWl4Nj8H8PmNMkJQfSL/jP56PFDvJI1SvamDi4bV4CXk9ir386VVTXyZjZirD
	 wEn8CsEBCn5j2KSPDVifBuVE3wJdjHjFiZc8HPXfBc4kWRG5Y9vBo0owK9s31L9qSj
	 oUjwM7lhSzw6mCjJugIRtv7OlwcwFNxcTWY7YEIQyNE/m+A9j/NbjWob3mpKX3xblM
	 tZutuUv9iTMJFrBGnu10t9oVLFBnce5CsnrUZjsMvFmTtbCrNiD8XPiIuPT8mp8mq0
	 O4T0cr3tC5nIw==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ea0a6856d7so113631a34.1;
        Thu, 25 Apr 2024 05:36:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUj2wOj/PkcAb41tV9Ar5ExpqedJcAlKDlYI9BhDhOia+j4aXY1izgmNIV6EZmD/vxg9SMH9o5lYLBv49DF3IbHmBPKSjJBKNWvE0+2agTJVXG2shQSjGh9IWl2+6CvJqdXORLd8JI=
X-Gm-Message-State: AOJu0YxdadeKHyNUZlbxeDeQ7rkDs48DTns8agaqOSWPodtiG9mptEpb
	HwXq2o2fsg8VXU/p+qeYRFwc6SHY3QMhdkkHIRyPDllAxKjz5jyvyyOuia3VyQFZzk7fUOGpdIT
	Z4Iu1qIDIKriKwTNCqSM23v9e+gc=
X-Google-Smtp-Source: AGHT+IGthMl/Ito+Q6DI6eAj99qeVy30CIPYrVXUmda7A4xZ5NNubvbTlx3YUzPpSLvOh8Q6O9pcaQwADNh9svOjl14=
X-Received: by 2002:a4a:1a06:0:b0:5af:6d3b:d952 with SMTP id
 6-20020a4a1a06000000b005af6d3bd952mr698985oof.0.1714048618075; Thu, 25 Apr
 2024 05:36:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5774279.DvuYhMxLoT@kreacher> <2181352.irdbgypaU6@kreacher> <e9be06af-48bf-45ec-8d6d-6147d20b6780@arm.com>
In-Reply-To: <e9be06af-48bf-45ec-8d6d-6147d20b6780@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 25 Apr 2024 14:36:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i=HS_-S3N7ixK=FM0S=7o21cfW5jXMq=AWObwGpUkPdA@mail.gmail.com>
Message-ID: <CAJZ5v0i=HS_-S3N7ixK=FM0S=7o21cfW5jXMq=AWObwGpUkPdA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] thermal/debugfs: Pass cooling device state to thermal_debug_cdev_add()
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Thu, Apr 25, 2024 at 12:02=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
> Hi Rafael,
>
> On 4/23/24 19:00, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If cdev_dt_seq_show() runs before the first state transition of a cooli=
ng
> > device, it will not print any state residency information for it, even
> > though it might be reasonably expected to print residency information f=
or
> > the initial state of the cooling device.
> >
> > For this reason, rearrange the code to get the initial state of a cooli=
ng
> > device at the registration time and pass it to thermal_debug_cdev_add()=
,
> > so that the latter can create a duration record for that state which wi=
ll
> > allow cdev_dt_seq_show() to print its residency information.
> >
> > Fixes: 755113d76786 ("thermal/debugfs: Add thermal cooling device debug=
fs information")
> > Reported-by: Lukasz Luba <lukasz.luba@arm.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/thermal/thermal_core.c    |    9 +++++++--
> >   drivers/thermal/thermal_debugfs.c |   12 ++++++++++--
> >   drivers/thermal/thermal_debugfs.h |    4 ++--
> >   3 files changed, 19 insertions(+), 6 deletions(-)
> >
>
> I'm trying to test it on my board and do the review, but faced issue.
> For some reason I couldn't apply that patch on the latest bleeding-edge
> branch.
> Could you help me in this please? Is there something missing in the
> patch set (like one more fist patch)?

I messed up the ordering of patches (patch [2/3] should be the last
one in the series) and on top of that, you'll need a small rebase on
that patch.

Sorry about this, I'll send a v2.

Thank you!

