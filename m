Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E5877D201
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239190AbjHOSjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239240AbjHOSi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:38:57 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC16883
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 11:38:52 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-447823dd96fso1602290137.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 11:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692124732; x=1692729532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6kiY/3INKuqWnYXZcjhUe9YIe2oZztkBjxgCphjaAI=;
        b=5eINg4VPwpz3c8+lncMfMURdPg+XsvtHYbWboztYP853blbw1GSDvtPxl0tUYCQm4G
         eyne7uwlGCkEMVA0rjTa0YMTiAtwGYzNg1FBFXMQPgHExq0++DO77CRRv+DgJtiiuCIs
         eRRl57SuRGWSDVYo234oY+Fz2OlqAeaEw6akSaZte9VzQJ5TdCP7BnI5HZsMPY2NVes4
         7Acj7A23h/xDzmxeB3y7mkBi96S3v+fAfEjN6uqEbSgLobuCiKANq6QeFuWDOQCKJUEu
         lfthTgcbrJp03kn26ubksux9AESnUkrLvbvgdIOaccPH03xGpNQFBpg2CGi4O6IzPoII
         8NUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692124732; x=1692729532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6kiY/3INKuqWnYXZcjhUe9YIe2oZztkBjxgCphjaAI=;
        b=Wmgw+BS3hP7+g/qCjj81+Tl15+Q95vr5ryyK5c6mU99rBT4FlUyLPHCirsER41s7OO
         zmF2HXQrQ8W2ltQnBQpHu/LR6uWRdM5IEnZYnXGnuYUUSFRPFiKcaXa8yKMqV2bxLRZy
         ugA+4gARY4OiPpsozubcK2lZePUsUNVtCZ98yV2uENUTqW7gLdswCG9D5m/+uQH/DTyZ
         kgQJuC9PEppQmP6dy8BQemUgO0GV2quLn4KAWQkYFN+TFcMdk5yT4YvOWc3JR7KkRRcx
         7rewaYe7IhhlD54taxMYcmRfg/pUtJBZdgC+m8FEVjlMKLeDYq/ID9QNInF73+rOZqMp
         HTAw==
X-Gm-Message-State: AOJu0YxnqSRcJh+jREpbO+Jt0yjRrC9WXoeyvnRV90ZRMHm0hQaG+Lpt
        gqZcmw72whtu8oymJerzpCuBp2py/GdftWy9DRycPayl9FbE1Ekf/YA=
X-Google-Smtp-Source: AGHT+IHHNS+dP1xKfwUkmxyCJHrqDstk8cgSAzGEU9CKswA/UZusbfV78tqNUJYA0oSO+raPESQNSAY7RC4gQgpyi0Q=
X-Received: by 2002:a67:f886:0:b0:445:202:d278 with SMTP id
 h6-20020a67f886000000b004450202d278mr8980818vso.32.1692124732046; Tue, 15 Aug
 2023 11:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230812194457.6432-1-brgl@bgdev.pl> <20230812194457.6432-2-brgl@bgdev.pl>
 <ZNtVuUWTZa0gLwXz@smile.fi.intel.com>
In-Reply-To: <ZNtVuUWTZa0gLwXz@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 15 Aug 2023 20:38:41 +0200
Message-ID: <CAMRc=MeJS9-EF3EEAV8EW1UN2_pcafyc9ckHHjwTQVJnfxOVMA@mail.gmail.com>
Subject: Re: [PATCH 1/4] genirq/irq_sim: dispose of remaining mappings before
 removing the domain
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
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

On Tue, Aug 15, 2023 at 12:38=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sat, Aug 12, 2023 at 09:44:54PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > If the device providing simulated interrupts is unbound (real life
> > example: gpio-sim is disabled with users that didn't free their irqs)
> > and removes the simulated domain while interrupts are still requested,
> > we will hit memory issues when they are eventually freed and the
> > mappings destroyed in the process.
> >
> > Specifically we'll access freed memory in __irq_domain_deactivate_irq()=
.
> >
> > Dispose of all mappings before removing the simulator domain.
>
> ...
>
> > +#include <linux/list.h>
>
> Maybe ordered?
>

This patch comes first in the series as it's meant to be a
backportable fix. Header ordering comes later.

Bart

> >  #include <linux/irq.h>
> >  #include <linux/irq_sim.h>
> >  #include <linux/irq_work.h>
>
> ...
>
> > @@ -16,12 +17,14 @@ struct irq_sim_work_ctx {
> >       unsigned int            irq_count;
> >       unsigned long           *pending;
> >       struct irq_domain       *domain;
> > +     struct list_head        irqs;
> >  };
> >
> >  struct irq_sim_irq_ctx {
> >       int                     irqnum;
> >       bool                    enabled;
> >       struct irq_sim_work_ctx *work_ctx;
>
> > +     struct list_head        siblings;
>
> You can reduce the code size by moving this to be the first member.
> Not sure about struct irq_sim_work_ctx, you can play with bloat-o-meter.
>
> >  };
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
