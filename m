Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DA380C41D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbjLKJOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbjLKJOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:14:45 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7D0100
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:14:50 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7cb029c41e4so55664241.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702286089; x=1702890889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifFUtMv14jjmsyQD3seNpomQ4jZ0rsJwdv7NnE8oVF4=;
        b=FkwxYNzYiFsvO1D6SfjXWuNmuKDBpBsoF2x37uPtF04ocuxx40Idu22etxeVNurnx5
         Rdds+MhH/vzAAQWxjR5hh6piwKQz9iAz3i5UX5MFedhqGeBF5r40Xl7b7Eq+uCTwBUJi
         jmpfrKmcmrn4Yx0cRGohDmFbQWuUhAEUtZZ9eCpbdY5L5iwsW17XISWJ/gVHCLzDHQNF
         iPRv1PUXWxM+px4/LL6FX98kYTN01hJt9rtuYe9DTWKUTA8YZWypv0QjrveZsF9/pZe0
         Gp5e+YpO2D/eyRgnU2zOnhB4GKqdVrflT2o1TY9eJ8LjXpv1Y7UGvx7qgklcoWJu6oxj
         BIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702286089; x=1702890889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ifFUtMv14jjmsyQD3seNpomQ4jZ0rsJwdv7NnE8oVF4=;
        b=GPRRfoFbS4aNJ1VU94g2esDCSyk5nlkZLm498rD2Z298+drK+M5NN7X15Cc7boCpPF
         7KTtC4fgXiylEuDoTRkwS/DCndW2pGrsj8sHmJTnHxECRTVg5JeaB7PqXJOWKNIT77jk
         mVZFnqjLlMoy76moUZWF4GAbv8B4JsHx1UDPfwgkYPdLzzVmzV3DvpvrtD+/55olIhzl
         J/BgC+T8op1XT71MjdIAl+WX8HBXbxRVaooWKtHv9tyycP7qqKrw1sVppv8cq/gPQAKN
         vD4hw5RPxj0GMZGx1MVS0sXTyt/3R4O72vn5vetTRIj1Dcb5Ge6WqvtpfMG/WNOsce0e
         rPrg==
X-Gm-Message-State: AOJu0YxlWCmIKbaKtJHEzpZjDe2Kd7DCoLSijxoXbsrmT9iHhOQWwFCj
        9qq3WqoaoBEViDQdOcx12BKSvkUOPClnCnaqz5PClGjAAxMlSkLx
X-Google-Smtp-Source: AGHT+IEYJDEZISkxxQQnqjsuy3oSCYaAXfYDPkQM7U3WOhZ0uMOUkXiEmV06SWlV6/7zXx6GnXheetzTw60vqz4YJGI=
X-Received: by 2002:a05:6102:5596:b0:464:93af:268 with SMTP id
 dc22-20020a056102559600b0046493af0268mr2348369vsb.9.1702286089204; Mon, 11
 Dec 2023 01:14:49 -0800 (PST)
MIME-Version: 1.0
References: <20231115165915.2936349-1-brgl@bgdev.pl> <CAMRc=MfoE93Aum4s-pweeb_idqYgUG-DBpXnhT5UW_WhVkLwHw@mail.gmail.com>
 <CAMRc=Md6fCbXco-VOZeDM=cAy_a6HGjM8N5jse5OM7AXSha4dw@mail.gmail.com>
In-Reply-To: <CAMRc=Md6fCbXco-VOZeDM=cAy_a6HGjM8N5jse5OM7AXSha4dw@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 11 Dec 2023 10:14:38 +0100
Message-ID: <CAMRc=MeLCUQ1dGT2RsgrWMBMbGmjQ9tGwEWJ7nBCOss9TfvvGw@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 0/4] genirq/irq_sim: misc updates
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
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

On Mon, Dec 4, 2023 at 9:47=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> On Wed, Nov 29, 2023 at 10:18=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.=
pl> wrote:
> >
> > On Wed, Nov 15, 2023 at 5:59=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev=
.pl> wrote:
> > >
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Here are a couple of updates to the interrupt simulator. Two are mino=
r:
> > > remove an unused field and reorder includes for readability. The thir=
d
> > > one simplifies the error paths by using new cleanup macros. To that e=
nd
> > > we also add a cleanup definition for dynamic bitmaps.
> > >
> > > Resending rebased on top of v6.7-rc1 and with tags collected.
> > >
> > > v1 -> v2:
> > > - add a NULL-pointer check to the bitmap cleanup macro as advised by
> > >   Peter Zijlstra
> > > - initialize managed pointers when declaring them to create a clear p=
airing
> > >   between the type and the cleanup action
> > >
> > > Bartosz Golaszewski (4):
> > >   bitmap: define a cleanup function for bitmaps
> > >   genirq/irq_sim: remove unused field from struct irq_sim_irq_ctx
> > >   genirq/irq_sim: order headers alphabetically
> > >   genirq/irq_sim: shrink code by using cleanup helpers
> > >
> > >  include/linux/bitmap.h |  3 +++
> > >  kernel/irq/irq_sim.c   | 30 ++++++++++++------------------
> > >  2 files changed, 15 insertions(+), 18 deletions(-)
> > >
> > > --
> > > 2.40.1
> > >
> >
> > It's been two weeks since this submission and ~2.5 months since the
> > first one so I guess, a gentle ping is in order. This is not a very
> > controversial series - can this be applied?
> >
> > Bart
>
> Another ping...
>
> Bartosz

Thomas,

Is there any formal reason why this cannot be processed?

Bartosz
