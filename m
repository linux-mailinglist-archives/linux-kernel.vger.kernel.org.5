Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA6977B1EF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 08:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbjHNG7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 02:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbjHNG7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 02:59:04 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F12E63
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 23:59:02 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-799761430c2so1001056241.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 23:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691996342; x=1692601142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+47bnekDF0uNgP1KPu2KEIEopr2dJRMJ7GXVn9KSsI=;
        b=KFlPYtGzaMgko5C7zeA6UgIKwVEoH0shf6CbT9nG4vdmirl94eg6EGxJ27q7To5xlE
         RcMrml8K156Y+tPTqWJljIlJmduxJR1wYJtk2H/jo2SX4N1Utk6qDcKa/cLDWb8eUpuO
         q8fOFzV/sJrJUF3tc2INpLf9A2HqoknQ40hhU0+1fXuXyCjyzI0ac6YhKETo2WDIA51d
         z7rpqoemDHL8MrWcg2H2toaCgMxE8d23oxafiUqj9awtMm3GrWEtBgnHIG0b69AYZf7g
         hao/gJeTKVsSRsHYG7/FvSA1rFKVTKPdnxdiwf0glWbFoozRZ3D0SKEp9qnKgEZPsZgG
         r2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691996342; x=1692601142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+47bnekDF0uNgP1KPu2KEIEopr2dJRMJ7GXVn9KSsI=;
        b=FwFeFUcroKmvRxrj39SPQ7HP+BZM5Yh3QQVCoN8uilcWiGnh/Gb9Qf5DYBN84dBNTT
         Xd8O6KWJCPt2ekcQpNgBbtD2IziqNo9bpKB+FFKAW5rOZzGm7mBZJDK8jTZStNz6Xfxz
         rq35bPB0XZNJ/iadmXqgMCRHPiVb7C1DV5PovZqoyUQPWyuSafvCwbmUIb/8hgBrvaXW
         rPOkFy2gCjctIym9tFg+4BIZyfhGra0v/gxlF8BuvhD3px4ooeSGbeu8TGXaAO51HlS5
         +bEp3aWoeCtT0UK+I0jzb87ucgXuZyWljuO55PCxPdIawOccDFJLwoXa5YdkX8punImp
         BS6g==
X-Gm-Message-State: AOJu0Yx5rBBSuDPLRfnmfMOPnYxuhi6Ts4NmU0gkpkRxwASQkEFPShfM
        qxrYDNE908EYg3CLcPFn5FoZ0fV47l0nBg5sxFmeLQ==
X-Google-Smtp-Source: AGHT+IEciWk/8xK8KpSlGXlcq93FmbA/U6dh8/Gen07BKGj85eE84a8r+PPG+f0jjFQ1G3ThyVKOfSE4cQWk1hPDYTg=
X-Received: by 2002:a67:ffd1:0:b0:443:6afe:e842 with SMTP id
 w17-20020a67ffd1000000b004436afee842mr7199381vsq.35.1691996341963; Sun, 13
 Aug 2023 23:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230812194457.6432-1-brgl@bgdev.pl> <20230812194457.6432-5-brgl@bgdev.pl>
 <ZNl+uKweuqJKaMcb@yury-ThinkPad>
In-Reply-To: <ZNl+uKweuqJKaMcb@yury-ThinkPad>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 14 Aug 2023 08:58:51 +0200
Message-ID: <CAMRc=Mf-z4ART0cNmjoANTStZ=UfEk9ff16n1zd3KHBwn1wmjA@mail.gmail.com>
Subject: Re: [PATCH 4/4] genirq/irq_sim: shrink code by using cleanup helpers
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

On Mon, Aug 14, 2023 at 3:09=E2=80=AFAM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> On Sat, Aug 12, 2023 at 09:44:57PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Use the new __free helper from linux/cleanup.h to remove all gotos and
> > simplify the error paths.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  kernel/irq/irq_sim.c | 24 ++++++++++--------------
> >  1 file changed, 10 insertions(+), 14 deletions(-)
> >
> > diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
> > index a8b013d0c5be..202beb1169c9 100644
> > --- a/kernel/irq/irq_sim.c
> > +++ b/kernel/irq/irq_sim.c
> > @@ -4,6 +4,7 @@
> >   * Copyright (C) 2020 Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >   */
> >
> > +#include <linux/cleanup.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/irq.h>
> >  #include <linux/irq_sim.h>
> > @@ -170,34 +171,29 @@ static const struct irq_domain_ops irq_sim_domain=
_ops =3D {
> >  struct irq_domain *irq_domain_create_sim(struct fwnode_handle *fwnode,
> >                                        unsigned int num_irqs)
> >  {
> > -     struct irq_sim_work_ctx *work_ctx;
> > +     struct irq_sim_work_ctx *work_ctx __free(kfree) =3D NULL;
> > +     unsigned long *pending __free(bitmap) =3D NULL;
>
> Why initializing here as NULL ...
>
> >       work_ctx =3D kmalloc(sizeof(*work_ctx), GFP_KERNEL);
> >       if (!work_ctx)
> > -             goto err_out;
> > +             return ERR_PTR(-ENOMEM);
> >
> > -     work_ctx->pending =3D bitmap_zalloc(num_irqs, GFP_KERNEL);
> > -     if (!work_ctx->pending)
> > -             goto err_free_work_ctx;
> > +     pending =3D bitmap_zalloc(num_irqs, GFP_KERNEL);
> > +     if (!pending)
> > +             return ERR_PTR(-ENOMEM);
>
> and overriding immediately after that? Not familiar to __free()
> machinery in details, although. Does it require initialization?
>
> Thank,
> Yury

For the first variable: it's just good practice resulting from years
of user-space coding in GLib which makes heavy use of autopointers.
For the 'pending' variable, it's necessary as if the first kmalloc()
fails, it will go out of scope with random contents and bitmap_free()
will get called on it. Now if we ever add some statement that can
return between the start of the function and the first kmalloc() then
we'll save ourselves having to modify the variable declaration.

Bart
