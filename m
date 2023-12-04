Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805F8802E2D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343607AbjLDIrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjLDIra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:47:30 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59E0D6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 00:47:36 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-46442e22afcso3216431137.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 00:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701679656; x=1702284456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQFJC/lIslhrNgCZNKBvXAQuBkogMhzm+Hv1+HgK/cM=;
        b=YgYlS5lr2SYlrCUsE5Zl9uvSP0dk+OoawAMbv/m0e8ha+pSzPWybr+36Cltc/HV670
         nq7N5HQ5E+VI1WP939Razwa531lBhZuA0WF1UVy4o+3cef5GUi4pIrMipX1CdVJqF45A
         IBVmSuy7iCqgs6t42z8v07Gvx+4X/VWi0pY+HCGZFdbt6EtLjeMibbA1T7iFqjqOGh+S
         G/YHXGJIIcrY4HaW/AraWHQGMNTR/JkA01wvJwkJlF6HfvIFQ4IQMUw4B2f0enh5Ahny
         c/g2foYYipNkt/NS8OGVcF58c1+Y151NwtkRhOAEWzfJF+nU7jh7Ukj/twirQufBwsYt
         AzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701679656; x=1702284456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQFJC/lIslhrNgCZNKBvXAQuBkogMhzm+Hv1+HgK/cM=;
        b=mK+IQGqDX4gerwSwZI7CnkKUPCNnEKOM9Hf3bhONJaIfnYLmRtcoeiJTCwpv8JmpcG
         ekS7aXlnOTSkCspS9I7mGzDPcplBn4QG1xiAQiOPkedAQXdD6JnyniLQla9g91p8GSgx
         fETsC1INiaSr8g9tzVXMGxTA5UNOE2i2lZUG379wyUeICCzAh8fHgkC91+1eBRMTQg8B
         UcKOm82mSlHnxXOG/dDCoO6kd/0uuNzuVFkTIejH4X0GpayKGWXbWTkHtR0+ZLjNsxqJ
         025443I7IO1sltLuQWHUQxls6FIeiBVm6KO32gi+biDb1wXyF8CslrKRRFifyFaVe3lT
         w6cg==
X-Gm-Message-State: AOJu0YzB4U1bwKgH2pW5+KT+2H3ZbHCcDgktPgQXWWvJT/Gdas+fn4Bk
        PbrGpuObgRBE5Vvb6grJgUjwUglKyZ24pPr9V1p5kw==
X-Google-Smtp-Source: AGHT+IG3LUoh00KXMXQlrpMr9Jb7+DMmhWlx8mJmMVfKWMaLyEBWVqyP9p1kQbqF2OqNfz4sBvsVackm9Q/ip1aUITU=
X-Received: by 2002:a05:6102:b0b:b0:464:77f1:f349 with SMTP id
 b11-20020a0561020b0b00b0046477f1f349mr1990967vst.23.1701679655921; Mon, 04
 Dec 2023 00:47:35 -0800 (PST)
MIME-Version: 1.0
References: <20231115165915.2936349-1-brgl@bgdev.pl> <CAMRc=MfoE93Aum4s-pweeb_idqYgUG-DBpXnhT5UW_WhVkLwHw@mail.gmail.com>
In-Reply-To: <CAMRc=MfoE93Aum4s-pweeb_idqYgUG-DBpXnhT5UW_WhVkLwHw@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 4 Dec 2023 09:47:24 +0100
Message-ID: <CAMRc=Md6fCbXco-VOZeDM=cAy_a6HGjM8N5jse5OM7AXSha4dw@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 0/4] genirq/irq_sim: misc updates
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 10:18=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> On Wed, Nov 15, 2023 at 5:59=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> >
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Here are a couple of updates to the interrupt simulator. Two are minor:
> > remove an unused field and reorder includes for readability. The third
> > one simplifies the error paths by using new cleanup macros. To that end
> > we also add a cleanup definition for dynamic bitmaps.
> >
> > Resending rebased on top of v6.7-rc1 and with tags collected.
> >
> > v1 -> v2:
> > - add a NULL-pointer check to the bitmap cleanup macro as advised by
> >   Peter Zijlstra
> > - initialize managed pointers when declaring them to create a clear pai=
ring
> >   between the type and the cleanup action
> >
> > Bartosz Golaszewski (4):
> >   bitmap: define a cleanup function for bitmaps
> >   genirq/irq_sim: remove unused field from struct irq_sim_irq_ctx
> >   genirq/irq_sim: order headers alphabetically
> >   genirq/irq_sim: shrink code by using cleanup helpers
> >
> >  include/linux/bitmap.h |  3 +++
> >  kernel/irq/irq_sim.c   | 30 ++++++++++++------------------
> >  2 files changed, 15 insertions(+), 18 deletions(-)
> >
> > --
> > 2.40.1
> >
>
> It's been two weeks since this submission and ~2.5 months since the
> first one so I guess, a gentle ping is in order. This is not a very
> controversial series - can this be applied?
>
> Bart

Another ping...

Bartosz
