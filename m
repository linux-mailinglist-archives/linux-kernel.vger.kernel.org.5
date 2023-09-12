Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD12A79D72C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbjILRGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236656AbjILRGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:06:00 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C091702;
        Tue, 12 Sep 2023 10:05:56 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1d544a4a315so4418675fac.3;
        Tue, 12 Sep 2023 10:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694538356; x=1695143156; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8uJBTEQdRONw+vXUu5BwG/gWVTti+h7mfVrycIXCgFw=;
        b=rhWAtluaYsXJSobzLa0gPn55m4+/xPsVoupw1b6M5dZRcN6PZUFix1sQibRjo6rJs8
         ZTNxsgZeh5xXRmHYVs70PQeIPyCds7/8gsh5G5bQsZ7VJaproXDDSxz5aqssXcLe6k1m
         wXrnAok1FUlKMmtrayaR5NBOcVwxKVcKeXVqStHUFCQPnlmXmd4q5R/IvPQwcoP0yrTy
         M7ivsMM+iRKZZIQhP5cq/o/nsRYh49ZAJlzzPZo1LozvAoi/KGEOxMuhozJonULR9Cnl
         1iC/Nx3OrvqKthSYQRyqO+vZAXMKp3gYdQsroX5qMTkx0e8ve+mB8L5XKEttNi3SPZho
         vHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694538356; x=1695143156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8uJBTEQdRONw+vXUu5BwG/gWVTti+h7mfVrycIXCgFw=;
        b=gfErp+6kS1lAyjEBWgNE6smc7lC0o4UBC7iOmjD9xhAXqMuc6Fkn9EgRbauEpRO9nL
         W9v61f/W2FqsNpWO9ey8plTxETfeWDUE+kvJItYChLMFfMU0JjccMU0axTWe7F8CsO1K
         /iz6vdreKfPaOH8SjAc3nmtgnhOYumxRkHs9Aehn+JPQcU+enKoFBJRXCmYXXYn8KDhR
         kLtlvORm3URnQTnXJIJaVfI+fK28ITx9P44mNX1FB3m9uw84SYsGIfZ+fXw5NhgH8dCE
         +CI7y0DTobF1txrXbb5htmnsLViixjSl9D173iXWKJlLjwyK1J7v1zxKLnNlaQ0uPbPx
         ggnA==
X-Gm-Message-State: AOJu0Yy4Ahd5VOxRZXVj02BQy0EexCB7jjWHDszRP0Jfy4R1sh2YHcgQ
        TJfwDALImN2HjfzgB2qBl310mgJF/3K4yoRPlw0=
X-Google-Smtp-Source: AGHT+IFe0HmuIMu5VK1+fjKg0/SlUkDg8D9D6s6bYMKGEfjNBjKCWbQ3kcHMS/ugJyrDHxTPI+WzBcGMxi8KOSfJh34=
X-Received: by 2002:a05:6870:8290:b0:1ba:2a58:b15e with SMTP id
 q16-20020a056870829000b001ba2a58b15emr124229oae.2.1694538355761; Tue, 12 Sep
 2023 10:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230822134849.3352329-1-alessandro.carminati@gmail.com>
 <CAPp5cGTshQJ3aLeLqv=CbaVeg9GnK_k9nsoaWrBKs1dcXzNZow@mail.gmail.com>
 <fc8023b435f78e02c96fecbe8e7599ee.sboyd@kernel.org> <CAPp5cGQ0Wp4my93tEm9-Huc6R+22zCj91mNJsPpGTFoo49=mcQ@mail.gmail.com>
 <fde1b20074cf5c0e0bc1944959486150.sboyd@kernel.org>
In-Reply-To: <fde1b20074cf5c0e0bc1944959486150.sboyd@kernel.org>
From:   Alessandro Carminati <alessandro.carminati@gmail.com>
Date:   Tue, 12 Sep 2023 19:05:19 +0200
Message-ID: <CAPp5cGSbdhLb2c5hQrP-O-+j63haXs0c6=JCoFxnAzF1mhspuA@mail.gmail.com>
Subject: Re: [PATCH] Sanitize possible_parent_show to Handle Return Value of of_clk_get_parent_name
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Philip Daly <pdaly@redhat.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

Thank you for your time and your work.

Il giorno ven 8 set 2023 alle ore 23:25 Stephen Boyd
<sboyd@kernel.org> ha scritto:
>
> Quoting Alessandro Carminati (2023-09-08 01:36:14)
> > Hello Stephen,
> > Thank you for your review and the time you dedicated to it.
> >
> > Il giorno ven 8 set 2023 alle ore 00:33 Stephen Boyd
> > <sboyd@kernel.org> ha scritto:
> > >
> > > Quoting Alessandro Carminati (2023-09-07 07:15:36)
> > > > this is a gentle ping
> > > >
> > >
> > > I couldn't read your email because it was sent to nobody
> > > (unlisted-recipients). Can you resend with a proper To: line?
> > >
> > > >
> > > > Il giorno mar 22 ago 2023 alle ore 15:49 Alessandro Carminati
> > > > <alessandro.carminati@gmail.com> ha scritto:
> > > > >
> > > > > In the possible_parent_show function, ensure proper handling of the return
> > > > > value from of_clk_get_parent_name to prevent potential issues arising from
> > > > > a NULL return.
> > > > > The current implementation invokes seq_puts directly on the result of
> > > > > of_clk_get_parent_name without verifying the return value, which can lead
> > > > > to kernel panic if the function returns NULL.
> > > > >
> > > > > This patch addresses the concern by introducing a check on the return
> > > > > value of of_clk_get_parent_name. If the return value is not NULL, the
> > >
> > > Use of_clk_get_parent_name() to signify that it is a function.
> > >
> > > > > function proceeds to call seq_puts, providing the returned value as
> > > > > argument.
> > > > > However, if of_clk_get_parent_name returns NULL, the function provides a
> > > > > static string as argument, avoiding the panic.
> > > > >
> > > > > Reported-by: Philip Daly <pdaly@redhat.com>
> > > > > Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gmail.com>
> > > > > ---
> > >
> > > It needs a Fixes tag.
> > Sure!
> > I need to be more careful on this.
> >
> > >
> > > > >  drivers/clk/clk.c | 11 ++++++-----
> > > > >  1 file changed, 6 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > > > index c249f9791ae8..ab999644e185 100644
> > > > > --- a/drivers/clk/clk.c
> > > > > +++ b/drivers/clk/clk.c
> > > > > @@ -3416,6 +3416,7 @@ static void possible_parent_show(struct seq_file *s, struct clk_core *core,
> > > > >                                  unsigned int i, char terminator)
> > > > >  {
> > > > >         struct clk_core *parent;
> > > > > +       const char *tmp;
> > > > >
> > > > >         /*
> > > > >          * Go through the following options to fetch a parent's name.
> > > > > @@ -3436,12 +3437,12 @@ static void possible_parent_show(struct seq_file *s, struct clk_core *core,
> > > > >                 seq_puts(s, core->parents[i].name);
> > > > >         else if (core->parents[i].fw_name)
> > > > >                 seq_printf(s, "<%s>(fw)", core->parents[i].fw_name);
> > > > > -       else if (core->parents[i].index >= 0)
> > > > > -               seq_puts(s,
> > > > > -                        of_clk_get_parent_name(core->of_node,
> > > > > -                                               core->parents[i].index));
> > > > > -       else
> > > > > +       else if (core->parents[i].index >= 0) {
> > > > > +               tmp = of_clk_get_parent_name(core->of_node, core->parents[i].index);
> > > > > +               seq_puts(s, tmp ? tmp : "(none)");
> > >
> > > How about using seq_printf("%s", ...) instead? That should print out
> > > "(null)" in the case that it is NULL, instead of "(none)" and it is a
> > > one line change.
> >
> > I did consider using seq_printf("%s", ...) as an alternative approach to
> > address the issue initially.
> > However, after a review of the file's history, I arrived at a different
> > conclusion.
> >
> > The commit [1] that introduced this bug was primarily focused on replacing
> > seq_printf() with seq_putc().
> > I considered that to maintain code consistency and align with the intentions
> > of that commit, it may be more appropriate to continue using seq_putc() in
> > this particular instance.
> > I agree however with the idea of rolling back that particular change, but
> > in this case, we perhaps may want to consider also [2], a similar change made
> > in the same period.
> > I haven't proceeded with a patch submission for it[2], mainly due to the lack
> > of evidence of a kernel splash related to it and my uncertainty around the
> > fact that can exist use cases where the name field in the struct cgroup_subsys
> > can hit that code set to NULL.
>
> Is nothing actually wrong? And this is a speculative patch?

In the current state, Linux can crash, so I would say that there's something
wrong.
I submitted this patch in response to a specific bug report that caused a
kernel crash during testing.

>
> All other arms of this conditional statement check the validity of the
> pointer before printing the string. And when the parent isn't known we
> print "(missing)", so it looks like we should do that instead. How about
> this patch?

Indeed, your patch appears to provide a more verbose coding and accurate
message, which is valuable for troubleshooting.
So yeah, for what it is worth, I think it is good as well.

>
> ----8<---
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index c249f9791ae8..473563bc7496 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3416,6 +3416,7 @@ static void possible_parent_show(struct seq_file *s, struct clk_core *core,
>                                  unsigned int i, char terminator)
>  {
>         struct clk_core *parent;
> +       const char *name = NULL;
>
>         /*
>          * Go through the following options to fetch a parent's name.
> @@ -3430,18 +3431,20 @@ static void possible_parent_show(struct seq_file *s, struct clk_core *core,
>          * registered (yet).
>          */
>         parent = clk_core_get_parent_by_index(core, i);
> -       if (parent)
> +       if (parent) {
>                 seq_puts(s, parent->name);
> -       else if (core->parents[i].name)
> +       } else if (core->parents[i].name) {
>                 seq_puts(s, core->parents[i].name);
> -       else if (core->parents[i].fw_name)
> +       } else if (core->parents[i].fw_name) {
>                 seq_printf(s, "<%s>(fw)", core->parents[i].fw_name);
> -       else if (core->parents[i].index >= 0)
> -               seq_puts(s,
> -                        of_clk_get_parent_name(core->of_node,
> -                                               core->parents[i].index));
> -       else
> -               seq_puts(s, "(missing)");
> +       } else {
> +               if (core->parents[i].index >= 0)
> +                       name = of_clk_get_parent_name(core->of_node, core->parents[i].index);
> +               if (!name)
> +                       name = "(missing)";
> +
> +               seq_puts(s, name);
> +       }
>
>         seq_putc(s, terminator);
>  }

Regards.
Alessandro
