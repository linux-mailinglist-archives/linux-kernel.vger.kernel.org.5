Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6FF77D21B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239173AbjHOSnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239279AbjHOSnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:43:01 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65D510C0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 11:42:58 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-44acad48bffso66874137.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 11:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692124977; x=1692729777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NA19hktULJmUDPiX3j/KBCBMEsbPKcE+qy3FeOZUEC0=;
        b=M5AuDY9NdO9NlF6gxNwT7AkQDsl1VjxvyNF3gxIfnZrMXOJqMWJDF3FBVYSyXzZ+eX
         22Z/a0HFJ1jEzQotju4HDD4cWdJu8fZD8z3s2OW8hn0OGgGzPvFJ4dC5dFh26k2cFuM5
         sNtPrSZbHaOi15NbWYrYiUEEdjOaVJJQ46voo65SPtH2mkFkQ21/02zQgF3qsXaj1TxN
         EXAkOJ9Z9Nfr21D+DOZ/VnZ/DaJilKIrC14yfE4xeS6j2sdpbyN8eU55gnc64fMtiAFV
         vMqZLtjDydA5TdYTTGBaMLtqb6/4Yyd5Kx87+SGWJzX/ore4pTMSfBRxTM/05LEbpDLC
         4wGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692124977; x=1692729777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NA19hktULJmUDPiX3j/KBCBMEsbPKcE+qy3FeOZUEC0=;
        b=RaOllOopahdEiNQCJkXJvCQ22BJlQDFG8p7or9FJL5thaxCeYLn6V31glAEfFOlrz1
         8lbzV43ut0czBmXz2Y5FYtTDWXKrRUGyw1VbocnVw6HFfWPW7BbDCgHIQg1C9yHWCruQ
         jC/aUINj7eJ1nwyYXyot9xrMWQm/XTwnI5JKUUzWgOTMRcuXDYXaDktvFbaaTP7yY9BJ
         o58Vu0gEXNvcNlLXu6QrUOselaOg8C2EJUV1g40+VKEHKIOpTgbpfq28C9B8TaxQFrsE
         vQzmG046TkVvw9HVVcToKXAqYqljvnDYurDtN4cPZxXloXZjcuzc0tooz441LIGwYI3e
         J3ng==
X-Gm-Message-State: AOJu0YzM/csdObaN5VvRmDozEUGy22KXxXA4nyYv2Es0/5nW1WMJegoy
        4znIOKNhdPq+lOnVzmAThMUUmvr629YUwgeU39A9Vg==
X-Google-Smtp-Source: AGHT+IEAzX3U2YDp0YL8ma958s4AHNtteFS2eF03+nYYF9q/eqFbg5u4EWCg+wKKpPb8JBdg8daou4HM91YnAlNB2RI=
X-Received: by 2002:a05:6102:e43:b0:443:898c:864d with SMTP id
 p3-20020a0561020e4300b00443898c864dmr12504242vst.14.1692124977745; Tue, 15
 Aug 2023 11:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230812194457.6432-1-brgl@bgdev.pl> <20230812194457.6432-2-brgl@bgdev.pl>
 <ZNtVuUWTZa0gLwXz@smile.fi.intel.com> <ZNujJhy9fmCFwwLK@yury-ThinkPad>
In-Reply-To: <ZNujJhy9fmCFwwLK@yury-ThinkPad>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 15 Aug 2023 20:42:46 +0200
Message-ID: <CAMRc=MdC15RKOu7Jcphk0XLcMupzV=WkvMBtvUdv8GmsWXcZ=g@mail.gmail.com>
Subject: Re: [PATCH 1/4] genirq/irq_sim: dispose of remaining mappings before
 removing the domain
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 6:09=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> On Tue, Aug 15, 2023 at 01:38:49PM +0300, Andy Shevchenko wrote:
> > On Sat, Aug 12, 2023 at 09:44:54PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > If the device providing simulated interrupts is unbound (real life
> > > example: gpio-sim is disabled with users that didn't free their irqs)
> > > and removes the simulated domain while interrupts are still requested=
,
> > > we will hit memory issues when they are eventually freed and the
> > > mappings destroyed in the process.
> > >
> > > Specifically we'll access freed memory in __irq_domain_deactivate_irq=
().
> > >
> > > Dispose of all mappings before removing the simulator domain.
> >
> > ...
> >
> > > +#include <linux/list.h>
> >
> > Maybe ordered?
> >
> > >  #include <linux/irq.h>
> > >  #include <linux/irq_sim.h>
> > >  #include <linux/irq_work.h>
> >
> > ...
> >
> > > @@ -16,12 +17,14 @@ struct irq_sim_work_ctx {
> > >     unsigned int            irq_count;
> > >     unsigned long           *pending;
> > >     struct irq_domain       *domain;
> > > +   struct list_head        irqs;
> > >  };
> > >
> > >  struct irq_sim_irq_ctx {
> > >     int                     irqnum;
> > >     bool                    enabled;
> > >     struct irq_sim_work_ctx *work_ctx;
> >
> > > +   struct list_head        siblings;
> >
> > You can reduce the code size by moving this to be the first member.
> > Not sure about struct irq_sim_work_ctx, you can play with bloat-o-meter=
.
>
> Pahole you meant?
>
>   yury:linux$ pahole -C irq_sim_irq_ctx /sys/kernel/btf/vmlinux
>   struct irq_sim_irq_ctx {
>         int                        irqnum;               /*     0     4 *=
/
>         bool                       enabled;              /*     4     1 *=
/
>
>         /* XXX 3 bytes hole, try to pack */
>
>         struct irq_sim_work_ctx *  work_ctx;             /*     8     8 *=
/
>
>         /* size: 16, cachelines: 1, members: 3 */
>         /* sum members: 13, holes: 1, sum holes: 3 */
>         /* last cacheline: 16 bytes */
>   };
>
> In this particular case, there will be no hole because list head
> position (16) will be aligned to sizeof(struct list_head) =3D=3D 16.
>
> But as Bartosz said in the other email, "it's just good practice
> resulting from years of" kernel coding to have:

Did I sound smug or what? I didn't mean to. I was merely pointing to
the fact that linux is not the first to use C autopointers. They've
been around for years.

>  - members declared strongly according to the logic of the code, and
>    if no strong preference:
>  - list head be the first element of the structure, to let compiler
>    avoid generating offsets when traversing lists;
>  - put elements of greater size at the beginning, so no holes will be
>    emitted like in the example above.
>
> So I'd suggest:
>
>   struct irq_sim_irq_ctx {
>      struct list_head        siblings;
>      struct irq_sim_work_ctx *work_ctx;
>      int                     irqnum;
>      bool                    enabled;
>   }

Sounds good.

>
> Again, if there's NO ANY reason to have the irq number at the
> beginning.
>
> While here, I wonder, why irqnum is signed? Looking at the very first
> random function in kernel/irq/irq_sim.c, I see that it's initialized
> from a function returning unsigned value:
>

This field is currently unused. I'm not sure how it ended up there,
maybe a leftover from some earlier iterations of the irq_sim. This
patch just makes use of it in the end. It may be that it should use
unsigned int. Before I change it, I'd like to hear Thomas' comments on
these changes in general.

Bart

>   static void irq_sim_handle_irq(struct irq_work *work)
>   {
>           struct irq_sim_work_ctx *work_ctx;
>           unsigned int offset =3D 0;
>           int irqnum;
>
>           work_ctx =3D container_of(work, struct irq_sim_work_ctx, work);
>
>           while (!bitmap_empty(work_ctx->pending, work_ctx->irq_count)) {
>                   offset =3D find_next_bit(work_ctx->pending,
>                                          work_ctx->irq_count, offset);
>                   clear_bit(offset, work_ctx->pending);
>                   irqnum =3D irq_find_mapping(work_ctx->domain, offset);
>                   handle_simple_irq(irq_to_desc(irqnum));
>           }
>   }
>
> Thanks,
> Yury
