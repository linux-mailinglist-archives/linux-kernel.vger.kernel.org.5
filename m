Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBCD7F1E8D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 22:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjKTVMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 16:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjKTVMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 16:12:47 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728AAC4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 13:12:43 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-da7238b3eb4so4881726276.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 13:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700514762; x=1701119562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqlmM8DM6G+5eGbay1lkfj8kQgtwPw9Yngebn56yPS8=;
        b=N3DLIT91qWAL2Osha8R+ljRp1/K7nvYIqatKViALNXewTixhSPKrM8uudt/b2tzqXO
         Uvi99AL4MI3HzHZqMpLZq3e4U50hPuGIg2dLDqwOOqcdLQAAhNaQqmGBf5M4GqNlbAYk
         38KtRDj6CTbsPF7WxLpjLPF6WHDumtl+M2JUusDCBY+SyMqrSY27UWkAcV76NxurG7LA
         6nr2x0XtJhpUH6Mypgt6zSVnAO3IXEM13TmxLTN+5efJG+djDGel74K2Kxk8rM5nzN2N
         Me+1QpTp5d38NwQUnTPQg03WHj29+OsfgpBzYWZ7st5iBa+aDooYwkKHKRjrupzQZKLV
         T0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700514762; x=1701119562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqlmM8DM6G+5eGbay1lkfj8kQgtwPw9Yngebn56yPS8=;
        b=lkRwSz+5hXsKdUuCuHDEahJJvT6Zid4rQA+iw7fowxPC+aQ1n+tg0xWRGULCQs03rM
         X/6wZLb5ekV1iJEWsPVsaI68BEyPnBOgwHaSCnWqIYwwv/fohMNLfzbIY2yhT5DTvJzH
         Nqlh34AFsVlsOOu9whTntTGJWPoiOLSO5DHEnWC0rdCBM+m+HRH3NNHcS6wTRzI9kbYY
         Gjsg0d7Up3mFlFz5EBDCn0OmvPK7umWAo7OGzRE49Hj1IbA0dqk61EcN7haDzmUdX6pf
         CUJXYtCeS63yoKGQxTyYaoAxxPKJa4mOr1MidY1YGSk4D+JmAldIKgLCK9g96ifgRDOi
         3rAg==
X-Gm-Message-State: AOJu0YyvsLmv4lYYJhxesEZXUPokrlux9ZjkHLnlKV9CPLJl4kMmnTGP
        WEySUlSDLNOXj8BUUW6Vmhy/wXwbwLBaSKVGvv15thbEwIioDR4=
X-Google-Smtp-Source: AGHT+IHmkzLN6Hy1NnfaHz7dCug+kcrwZfp5oehCARoKr0odBnL3RXk+goVDU0SJt1+bJmoJY2sAHzXK22OKdoWv+us=
X-Received: by 2002:a25:417:0:b0:db0:6cde:3859 with SMTP id
 23-20020a250417000000b00db06cde3859mr8659754ybe.41.1700514762565; Mon, 20 Nov
 2023 13:12:42 -0800 (PST)
MIME-Version: 1.0
References: <20231114022503.6310-1-kelvie@kelvie.ca> <a66a805c-3e1f-4b9a-a38e-aca84b8678a6@infradead.org>
In-Reply-To: <a66a805c-3e1f-4b9a-a38e-aca84b8678a6@infradead.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 20 Nov 2023 16:12:31 -0500
Message-ID: <CAHC9VhR6mr0XRrq=Apy00HD3tdgpKi4RyMr8f5kdx2sjA0sfig@mail.gmail.com>
Subject: Re: [PATCH RFC] Add a lockdown_hibernate parameter
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Kelvie Wong <kelvie@kelvie.ca>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 11:01=E2=80=AFPM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
> [add security & dhowells]
>
> On 11/13/23 18:23, Kelvie Wong wrote:
> > This allows the user to tell the kernel that they know better (namely,
> > they secured their swap properly), and that it can enable hibernation.
> >
> > I've been using this for about a year now, as it doesn't seem like
> > proper secure hibernation was going to be implemented back then, and
> > it's now been a year since I've been building my own kernels with this
> > patch, so getting this upstreamed would save some CO2 from me building
> > my own kernels every upgrade.
> >
> > Some other not-me users have also tested the patch:
> >
> > https://community.frame.work/t/guide-fedora-36-hibernation-with-enabled=
-secure-boot-and-full-disk-encryption-fde-decrypting-over-tpm2/25474/17
> >
> > Signed-off-by: Kelvie Wong <kelvie@kelvie.ca>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt |  5 +++++
> >  kernel/power/hibernate.c                        | 10 +++++++++-
> >  2 files changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index 426fa892d311..54785faba9e0 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2804,6 +2804,11 @@
> >                       to extract confidential information from the kern=
el
> >                       are also disabled.
> >
> > +     lockdown_hibernate      [HIBERNATION]
> > +                     Enable hibernation even if lockdown is enabled. E=
nable this only if
> > +                     your swap is encrypted and secured properly, as a=
n attacker can
> > +                     modify the kernel offline during hibernation.
> > +
> >       locktorture.nreaders_stress=3D [KNL]
> >                       Set the number of locking read-acquisition kthrea=
ds.
> >                       Defaults to being automatically set based on the
> > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > index 89c71fce225d..2221c531d54c 100644
> > --- a/kernel/power/hibernate.c
> > +++ b/kernel/power/hibernate.c
> > @@ -36,6 +36,7 @@
> >  #include "power.h"
> >
> >
> > +static int lockdown_hibernate;
> >  static int nocompress;
> >  static int noresume;
> >  static int nohibernate;
> > @@ -82,7 +83,7 @@ void hibernate_release(void)
> >  bool hibernation_available(void)
> >  {
> >       return nohibernate =3D=3D 0 &&
> > -             !security_locked_down(LOCKDOWN_HIBERNATION) &&
> > +             (lockdown_hibernate || !security_locked_down(LOCKDOWN_HIB=
ERNATION)) &&
> >               !secretmem_active() && !cxl_mem_active();
> >  }

I would feel a lot better about this if there was a way to verify that
the swap was protected as opposed to leaving that as a note in a doc
that the majority of users will never see, read, or understand.

--=20
paul-moore.com
