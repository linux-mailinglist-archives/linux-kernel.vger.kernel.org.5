Return-Path: <linux-kernel+bounces-38800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFC883C625
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7545A1F22EA3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AF473162;
	Thu, 25 Jan 2024 15:11:23 +0000 (UTC)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4364E6EB59;
	Thu, 25 Jan 2024 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706195482; cv=none; b=NbGILkq/gjZ+oeTV/6A/YE5dUJPYgyC1cdjFAzfsIfE7NltiPe+y4litDpzBymICodEMvMEsqlSAGsrZJXuu9OJjpYAXWw2fvOy05S0tZYzYLaR+MeO8HRw0Gt9CaVsWu9zY95gzgj+IBsvy/QZ9Ku+NiXGvz4KNgPOmiQHChhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706195482; c=relaxed/simple;
	bh=0kkgr3pPY27+XCQwPxnwYA69zulXjzszjvKCaDByQFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QE9Wqj2nOtoj2kWz+XvIU3YRRATGs9PnUwRhvHQB7i52EJ8ZFbzXM4GJBtPRriYnCs9IdBdUsy69e/BniRCDSfOOoGHdoSFZmPRDcR8JMPBF0cx6t7p55DRDSIAUrU6sK5reTrcsRrwk8RFplXc3Y2gc77tODNqtVnFHwWmshBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5958b9cda7aso1097093eaf.0;
        Thu, 25 Jan 2024 07:11:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706195480; x=1706800280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvr+07Kx8YQ93M5HqGI7hgcDB/+oVfIIQJlNttHWZyw=;
        b=pismat2h7aSg6w+gFLjuBYpI3dbdTYDgJ5gi7/6bnO5H+ior0xhOI7dGg+uV41LRbw
         rPaCQU9JCGpU+HHJiSu2CouNQzn+0X9ad5wl/R00o4TeIlMUgI5lOz7kuT9KIJqCDajq
         ZVkhTXW/ayU3t0XUlhaxKYs55bQ1doJGZp2Vgh1cy5n9LfiPDnUwRV+5jgolWNF+8DeY
         JI/2l2++pmLt8R+LZOV+UEx82QMmEg30kj4MuNXmKJSK9dM56N+BRRuHqGnPUPRCirec
         eBd5K8rwwkviuutDVvK6eF/1Xc3CbLKCpvMa5W3AvCYyqes98aSkAuCOCiHEAnT3HstI
         7CIg==
X-Gm-Message-State: AOJu0YxFvg7gVLJJGyHBXPl4SdNTcSK6GXfvk+KQxddfwdYqHCw7AVoT
	0RnlfQgnszYJcWUL3ex+AGaTaEOmGePAwTTCuwa9TmzDsi/bEeUygQWL72cwM/XqbcMVdTvS17K
	9YLa+55arcAYsCdeHKbPEPz/CLWROHWPG
X-Google-Smtp-Source: AGHT+IHtr2eKkgKX7pv+5pTOmjiDTsrPRzSkHXOo8wiwYWkBNBHfG4u/wc9sFOXfkcxnnnIoR7dIE82F+U+dZeaW4iI=
X-Received: by 2002:a05:6820:807:b0:599:6d16:353c with SMTP id
 bg7-20020a056820080700b005996d16353cmr2721741oob.1.1706195480331; Thu, 25 Jan
 2024 07:11:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5760158.DvuYhMxLoT@kreacher> <3290637.44csPzL39Z@kreacher> <ZbITTlBwu390dwT5@linux.intel.com>
In-Reply-To: <ZbITTlBwu390dwT5@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 25 Jan 2024 16:11:08 +0100
Message-ID: <CAJZ5v0iNEuZ3ebpWdETC12Jeq3pTnaTzG-gfQTwLQDGtwvphdQ@mail.gmail.com>
Subject: Re: [PATCH v1 05/12] PM: sleep: stats: Use step_failures[0] as a
 counter of successful cycles
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 8:52=E2=80=AFAM Stanislaw Gruszka
<stanislaw.gruszka@linux.intel.com> wrote:
>
> On Mon, Jan 22, 2024 at 12:29:11PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The first (index 0) cell of the step_failures[] array in struct
> > suspend_stats introduced previously can be used as a counter of
> > successful suspend-resume cycles instead of the separate "success"
> > field in it, so do that.
> >
> > While at it, change the type of the "fail" field in struct
> > suspend_stats to unsigned int, because it cannot be negative.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  include/linux/suspend.h |    3 +--
> >  kernel/power/main.c     |    9 +++++----
> >  kernel/power/suspend.c  |    2 +-
> >  3 files changed, 7 insertions(+), 7 deletions(-)
> >
> > Index: linux-pm/include/linux/suspend.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/include/linux/suspend.h
> > +++ linux-pm/include/linux/suspend.h
> > @@ -55,8 +55,7 @@ enum suspend_stat_step {
> >
> >  struct suspend_stats {
> >       unsigned int step_failures[SUSPEND_NR_STEPS];
> > -     int     success;
> <snip>
> > -                suspend_stats.success, suspend_stats.fail);
> > +     seq_printf(s, "success: %u\nfail: %u\n",
> > +                suspend_stats.step_failures[SUSPEND_NONE],
> > +                suspend_stats.fail);
> >
> >       for (step =3D SUSPEND_FREEZE; step < SUSPEND_NR_STEPS; step++)
> >               seq_printf(s, "failed_%s: %u\n", suspend_step_names[step]=
,
> > Index: linux-pm/kernel/power/suspend.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/kernel/power/suspend.c
> > +++ linux-pm/kernel/power/suspend.c
> > @@ -620,7 +620,7 @@ int pm_suspend(suspend_state_t state)
> >               suspend_stats.fail++;
> >               dpm_save_failed_errno(error);
> >       } else {
> > -             suspend_stats.success++;
> > +             suspend_stats.step_failures[SUSPEND_NONE]++;
>
> This looks confusing for me. I think would be better keep
> success field and just remove SUSPEND_NONE from the
> suspend_stat_step and suspend_stat_names. Actually do
> not introduce it, SUSPEND_NONE does not seems to be necessary
> (SUSPEND_FREEZE can be 0).

OK

I'll need to rearrange the series for that somewhat except for the
first two patches.

I guess it's OK to retain the R-by tags?

Thanks for all of the reviews!

