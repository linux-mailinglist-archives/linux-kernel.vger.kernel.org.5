Return-Path: <linux-kernel+bounces-15850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89110823448
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F621F2534C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5CF1C6A1;
	Wed,  3 Jan 2024 18:21:23 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315491C68A;
	Wed,  3 Jan 2024 18:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59584f41f1eso368908eaf.1;
        Wed, 03 Jan 2024 10:21:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704306081; x=1704910881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWmv7c5RiyJ3UNMTa+NDImBfcyC6YZrzWsoqFgF77JQ=;
        b=GFus7TFDmt5LutSyhVg0cqAxgmhWtiE60jJFeu3GcT9kobC6J9e5ykvKzwecwGAWBo
         yKKAw8/C8PhZkjfybFSWeivQI3hfXg52KB1I/YGje9SjT3fj5jgvGIupUz6QgQDkA5e0
         VtBVrIiqCb1UtufvA0Jwvkln4DSI90tfqvHhdsiq2i2eH+P/gs3MhsEqtu2zv+81inG8
         gWHKbzbFY2lEdRnvLTXkUNeQbkfhFlXxlPbw2aslS44vJSH+ah0ve9FOe1HwCYRmrd79
         kct1LXdDD3gKydx0JdrygXOREBwQ/LMZsyHZoZEWiAp8mnXO8vIRmETcgY1SjepnK/zw
         ocpg==
X-Gm-Message-State: AOJu0Yx9NM/T3oO0cgmfE9qUd5kVHdx077cqyf8DH+41eZbrvgzEY4aH
	WdvXdcGTnKtvYCPuclxAxvPh2EArsCMp181I2jpCIPuWCN0=
X-Google-Smtp-Source: AGHT+IFPmF6vV20joRuGNLv/Tb8AloxcIBTmef57kqwklKnBQ6+KuR4krjZvbEXoO419ApiPfHoThd88Hm/uliAFlUM=
X-Received: by 2002:a4a:e096:0:b0:595:6028:d8cb with SMTP id
 w22-20020a4ae096000000b005956028d8cbmr7930946oos.0.1704306081399; Wed, 03 Jan
 2024 10:21:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103041459.11113-1-ricardo.neri-calderon@linux.intel.com>
 <20240103041459.11113-5-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0jSERoeMki9ZvWtTqiZidETeo1Xm_Qb0Oo2qRG0PMrSJQ@mail.gmail.com> <ZZV3CgnaWznmzFKF@linux.intel.com>
In-Reply-To: <ZZV3CgnaWznmzFKF@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Jan 2024 19:21:10 +0100
Message-ID: <CAJZ5v0i5CwLJ7Fb-eZH+azxwnhMQ2QxyBAD58mGL151YpWqZXA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] thermal: intel: hfi: Add a suspend notifier
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, 
	Len Brown <len.brown@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Zhao Liu <zhao1.liu@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 6:26=E2=80=AFPM Stanislaw Gruszka
<stanislaw.gruszka@linux.intel.com> wrote:
>
> On Wed, Jan 03, 2024 at 02:34:26PM +0100, Rafael J. Wysocki wrote:
> > > +static int hfi_pm_notify(struct notifier_block *nb,
> > > +                        unsigned long mode, void *unused)
> > > +{
> > > +       struct hfi_cpu_info *info =3D &per_cpu(hfi_cpu_info, 0);
> > > +       struct hfi_instance *hfi =3D info->hfi_instance;
> > > +       int ret =3D 0;
> > > +
> > > +       /* HFI may not be in use. */
> > > +       if (!hfi)
> > > +               return ret;
> > > +
> > > +       mutex_lock(&hfi_instance_lock);
> > > +       /*
> > > +        * Only handle the HFI instance of the package of the boot CP=
U. The
> > > +        * instances of other packages are handled in the CPU hotplug=
 callbacks.
> > > +        */
> > > +       switch (mode) {
> > > +       case PM_HIBERNATION_PREPARE:
> > > +       case PM_SUSPEND_PREPARE:
> > > +       case PM_RESTORE_PREPARE:
> > > +               ret =3D smp_call_function_single(0, hfi_do_disable, N=
ULL, true);
> > > +               break;
> > > +
> > > +       case PM_POST_RESTORE:
> > > +       case PM_POST_HIBERNATION:
> > > +       case PM_POST_SUSPEND:
> > > +               ret =3D smp_call_function_single(0, hfi_do_enable, hf=
i, true);
> > > +               break;
> >
> > Because this handles the boot CPU only, one has to wonder if it should
> > be a syscore op rather than a PM notifier.
> >
> > It does not sleep AFAICS, so it can run in that context, and it is
> > guaranteed to run on the boot CPU then, so it is not necessary to
> > force that.  Moreover, syscore ops are guaranteed to be
> > non-concurrent, so locking is not needed.
>
> There are below warnings in smp_call_function_single() :
>
>         /*
>          * Can deadlock when called with interrupts disabled.
>          * We allow cpu's that are not yet online though, as no one else =
can
>          * send smp call function interrupt to this cpu and as such deadl=
ocks
>          * can't happen.
>          */
>         WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
>                      && !oops_in_progress);
>
>         /*
>          * When @wait we can deadlock when we interrupt between llist_add=
() and
>          * arch_send_call_function_ipi*(); when !@wait we can deadlock du=
e to
>          * csd_lock() on because the interrupt context uses the same csd
>          * storage.
>          */
>         WARN_ON_ONCE(!in_task());
>
> And this one in syscore_suspend():
>
>         WARN_ONCE(!irqs_disabled(),
>                 "Interrupts enabled before system core suspend.\n");
>
> So seems they are not compatible.

But smp_call_function_single() need not be used in syscore ops at all,
because they always run on the boot CPU.

