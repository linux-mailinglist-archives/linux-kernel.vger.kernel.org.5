Return-Path: <linux-kernel+bounces-15378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F64822B2C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9321F23FAC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFB418AE9;
	Wed,  3 Jan 2024 10:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cEOKkcE3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC4918656
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dbdb2433800so7027756276.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 02:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704277075; x=1704881875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Scmrhih7hxA5GuetUV6f9gA0fz7HYsSC+1TAzsNPLsk=;
        b=cEOKkcE3JR/pRGpKa7F606jO9SVa371a340Sp/pDSrFKCRyiWvzr5POLJoafRC9Cie
         WNPh/PruI6GWYzFs5k8jRwbBIQqgDCHH58BbZS3G4Yqn0LBMUW4hkpZFeOpNwgSA9NUY
         9EaYoQJQEFF34dBu9bHsnDDQMyL06VPEHSoekNfCrzmmHaN+TiqdWDaJstnMgk+cjGHw
         ZI3/6DWRsILfgrJ6krLmJM7/rUHpv/AY3E4QwhZqQfS1LpOTZwDGQRrKckYaO7MhjalZ
         vvdgqutDe8rm9INtXDfOk7neky7Hy0NMWjiEll2QOiXmPavesJI5+ENMq5jSHSxAX2hL
         r4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704277075; x=1704881875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Scmrhih7hxA5GuetUV6f9gA0fz7HYsSC+1TAzsNPLsk=;
        b=df33lUdEkrKaLcjyzTkNiWiH5Wn8lpxQYFF7Y0uf8IjiJb+wUEj+cWUJFde4XoSaiL
         8nIYyzmNMJnSvKJLlSC7q0rdzYhYJuf4ltPd4gyRoEzTIFhLvyWVw4AbJWb+e5J2TIap
         lj7ltWgRHJTYwjyQmMYd+0bNesEY5GVPXOMsncS0dXZbEuUHRM1YYegORMzy/JGihUCH
         AB0sKdXTuhAuFRtmGH3e5QVp7Anasqgl7vn731JQX/vdtesyJyobWU4bxtqPuoAXVDiA
         OPA0fIvmygru4EP+u3VDK2Ou+VkQeuVLI3jKEqpcIvDT9eSueX/nqO4ZvLaLLFbqpxMi
         LWCA==
X-Gm-Message-State: AOJu0YwoCcyH/qFsfXONZMPR+3QdatbsNoW0V8B2ZKTD/arkPGKHxOEE
	v9bEd3OvFnywYqnnepMzhPBdlVLDnjJAdwVOeYooruaeZvDkHg==
X-Google-Smtp-Source: AGHT+IE7HiUEQ4naUDjpKJlvYcSC4jJgKxiKK5Frq8V1Xd0XhmUBdF2wPZAjrqmnWa1oef+THMUfXyCl4ton5HibS74=
X-Received: by 2002:a25:c7d1:0:b0:db5:4e80:54c9 with SMTP id
 w200-20020a25c7d1000000b00db54e8054c9mr9529450ybe.42.1704277075476; Wed, 03
 Jan 2024 02:17:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20231227084252epcas2p3b063f7852f81f82cd0a31afd7f404db4@epcas2p3.samsung.com>
 <5754861.DvuYhMxLoT@kreacher> <6019796.lOV4Wx5bFT@kreacher>
 <13435856.uLZWGnKmhe@kreacher> <CAPDyKFohQjDzpYpm0QQLM4eTzGOzGfDNKUGHHC-niPBOrtR8BQ@mail.gmail.com>
 <CAJZ5v0jPtYFk=pPE63CGGL0kuc+N_bZqKdgBMC=PMrwqzHBDTg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jPtYFk=pPE63CGGL0kuc+N_bZqKdgBMC=PMrwqzHBDTg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 3 Jan 2024 11:17:18 +0100
Message-ID: <CAPDyKFp5BGpVX5WZxD+u4QELD9KEKVGE41q8mPxM8Eg4dP7RLw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] PM: sleep: Fix possible deadlocks in core
 system-wide PM code
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-pm@vger.kernel.org, Youngmin Nam <youngmin.nam@samsung.com>, 
	linux-kernel@vger.kernel.org, d7271.choe@samsung.com, 
	janghyuck.kim@samsung.com, hyesoo.yu@samsung.com, 
	Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Jan 2024 at 14:54, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Jan 2, 2024 at 2:35=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
> >
> > On Wed, 27 Dec 2023 at 21:41, Rafael J. Wysocki <rjw@rjwysocki.net> wro=
te:
> > >
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > It is reported that in low-memory situations the system-wide resume c=
ore
> > > code deadlocks, because async_schedule_dev() executes its argument
> > > function synchronously if it cannot allocate memory (an not only then=
)
> > > and that function attempts to acquire a mutex that is already held.
> > >
> > > Address this by changing the code in question to use
> > > async_schedule_dev_nocall() for scheduling the asynchronous
> > > execution of device suspend and resume functions and to directly
> > > run them synchronously if async_schedule_dev_nocall() returns false.
> > >
> > > Fixes: 09beebd8f93b ("PM: sleep: core: Switch back to async_schedule_=
dev()")
> > > Link: https://lore.kernel.org/linux-pm/ZYvjiqX6EsL15moe@perf/
> > > Reported-by: Youngmin Nam <youngmin.nam@samsung.com>
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >
> > > The commit pointed to by the Fixes: tag is the last one that modified
> > > the code in question, even though the bug had been there already befo=
re.
> > >
> > > Still, the fix will not apply to the code before that commit.
> >
> > An option could be to just do "Cc: stable@vger.kernel.org # v5.7+"
> > instead of pointing to a commit with a Fixes tag.
>
> Right, but one can argue that every commit with a "Cc: stable" tag is
> a fix, so it should carry a Fixes: tag too anyway.

Yes, certainly. But in this case it's more questionable as it's not
really fixing the commit it points out.

Note that, I have no strong opinion here, but maybe Greg has a preferred wa=
y?

>
> > >
> > > ---
> > >  drivers/base/power/main.c |  148 +++++++++++++++++++++--------------=
-----------
> > >  1 file changed, 68 insertions(+), 80 deletions(-)
> > >
> > > Index: linux-pm/drivers/base/power/main.c
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- linux-pm.orig/drivers/base/power/main.c
> > > +++ linux-pm/drivers/base/power/main.c
> > > @@ -579,7 +579,7 @@ bool dev_pm_skip_resume(struct device *d
> > >  }
> > >
> > >  /**
> > > - * device_resume_noirq - Execute a "noirq resume" callback for given=
 device.
> > > + * __device_resume_noirq - Execute a "noirq resume" callback for giv=
en device.
> > >   * @dev: Device to handle.
> > >   * @state: PM transition of the system being carried out.
> > >   * @async: If true, the device is being resumed asynchronously.
> > > @@ -587,7 +587,7 @@ bool dev_pm_skip_resume(struct device *d
> > >   * The driver of @dev will not receive interrupts while this functio=
n is being
> > >   * executed.
> > >   */
> > > -static int device_resume_noirq(struct device *dev, pm_message_t stat=
e, bool async)
> > > +static void __device_resume_noirq(struct device *dev, pm_message_t s=
tate, bool async)
> > >  {
> > >         pm_callback_t callback =3D NULL;
> > >         const char *info =3D NULL;
> > > @@ -655,7 +655,13 @@ Skip:
> > >  Out:
> > >         complete_all(&dev->power.completion);
> > >         TRACE_RESUME(error);
> > > -       return error;
> > > +
> > > +       if (error) {
> > > +               suspend_stats.failed_resume_noirq++;
> > > +               dpm_save_failed_step(SUSPEND_RESUME_NOIRQ);
> > > +               dpm_save_failed_dev(dev_name(dev));
> > > +               pm_dev_err(dev, state, async ? " async noirq" : " noi=
rq", error);
> > > +       }
> > >  }
> > >
> > >  static bool is_async(struct device *dev)
> > > @@ -668,11 +674,15 @@ static bool dpm_async_fn(struct device *
> > >  {
> > >         reinit_completion(&dev->power.completion);
> > >
> > > -       if (is_async(dev)) {
> > > -               get_device(dev);
> > > -               async_schedule_dev(func, dev);
> > > +       if (!is_async(dev))
> > > +               return false;
> > > +
> > > +       get_device(dev);
> > > +
> > > +       if (async_schedule_dev_nocall(func, dev))
> > >                 return true;
> > > -       }
> > > +
> > > +       put_device(dev);
> > >
> > >         return false;
> > >  }
> > > @@ -680,15 +690,19 @@ static bool dpm_async_fn(struct device *
> > >  static void async_resume_noirq(void *data, async_cookie_t cookie)
> > >  {
> > >         struct device *dev =3D data;
> > > -       int error;
> > > -
> > > -       error =3D device_resume_noirq(dev, pm_transition, true);
> > > -       if (error)
> > > -               pm_dev_err(dev, pm_transition, " async", error);
> > >
> > > +       __device_resume_noirq(dev, pm_transition, true);
> > >         put_device(dev);
> > >  }
> > >
> > > +static void device_resume_noirq(struct device *dev)
> > > +{
> > > +       if (dpm_async_fn(dev, async_resume_noirq))
> > > +               return;
> > > +
> > > +       __device_resume_noirq(dev, pm_transition, false);
> > > +}
> > > +
> > >  static void dpm_noirq_resume_devices(pm_message_t state)
> > >  {
> > >         struct device *dev;
> > > @@ -698,14 +712,6 @@ static void dpm_noirq_resume_devices(pm_
> > >         mutex_lock(&dpm_list_mtx);
> > >         pm_transition =3D state;
> > >
> > > -       /*
> > > -        * Advanced the async threads upfront,
> > > -        * in case the starting of async threads is
> > > -        * delayed by non-async resuming devices.
> > > -        */
> > > -       list_for_each_entry(dev, &dpm_noirq_list, power.entry)
> > > -               dpm_async_fn(dev, async_resume_noirq);
> > > -
> >
> > If I understand correctly, this means that we are no longer going to
> > run the async devices upfront, right?
>
> Right.
>
> > Depending on how devices get ordered in the dpm_noirq_list, it sounds
> > like the above could have a negative impact on the total resume time!?
>
> It could, but it is unclear at this time whether or not it will.
>
> > Of course, if all devices would be async capable this wouldn't be a
> > problem...
>
> Sure.
>
> So the existing behavior can be restored with the help of an
> additional device flag, but I didn't decide to add such a flag just
> yet.
>
> I'll probably do it in 6.9, unless the performance impact is serious
> enough, in which case it can be added earlier.
>
> I still would prefer to get to a point at which the suspend and resume
> paths are analogous (from the async POV) and that's what happens after
> this patch, so I'd say that IMO it is better to address any
> performance regressions on top of it.

Fair enough!

[...]

Feel free to add my Reviewed-by for the series!

Kind regards
Uffe

