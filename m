Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBFA788F85
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 22:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjHYUIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 16:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjHYUHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 16:07:47 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A63C2686
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 13:07:44 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-48d0f4d8e49so462097e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 13:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692994063; x=1693598863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2VZMISQD2OdN3jlH124pPyCPe9lCckfbcHPiuLCe+ZM=;
        b=NWBFK8qQmu7Gc0Lx1DfY0mhEUpMNkjZyKTs9dqg/TZ5VQjtF91eryQ1ds4rOKCXYUY
         4gxGda8Kum1w5FlvfP66hd0GEybHAP1JrJb/hF9VLQ5qdJ4GMXnJFzBJZLCh/KDYJ0MY
         UdQlUedT3AGm9X6ZwnBEqcNQ1P/nrR3b+fDfYJEP1F4f4jQaK7yOrOS9j9tANXuxQt9C
         +kWgFvnH9xRj/AdYwxEBuSYQyES9qe9lQX1DLMHzd3WUa0W/YRVWlv8KlYIpieVzuRx5
         7evOTDwT8FHeHtDRr9ZMxFWbsQdB04KjfFBZ1KmpIfY3vMFnT+tKnCVSKpbTNJ5E9llg
         ybhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692994063; x=1693598863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2VZMISQD2OdN3jlH124pPyCPe9lCckfbcHPiuLCe+ZM=;
        b=Nz8jF9rJLl6We6bnlZet70EztWe1rkHtLH5/ZBYZTEyIbQcgy68j4mzGQZSujd3lkS
         HfzuIOBpciYci7XUeGKN8SyB/pBRvr6aM9yGqqZWBMdt3ooTSY41MPeSlLUzS8bpcEPf
         UrMQldm05VdAdbe56cJymwwK5+cxTGtQ+n5UHsTU8KdJQll6sBzfoSV+OZNOp80EIlzZ
         0w7FGZsdJN/wOFOPOa0qBDxGuAfKlGfH7JbADg6VbwQHkqx3RACGzr09mdo4MoG/zaet
         kux0W8Bj0ljzFWrjmmm4mR2nwSJkM13jya5OSQRCNYqNo0vi9ovtIMydvIwF6a+UYNTg
         t+9g==
X-Gm-Message-State: AOJu0YxRVYnSnheW8UyBuuTqqHC27N5Nq6ZWIPDcetFwyco7LhlyyjCK
        qaZeMt5cYUd+0iulS4ACaYEOqa7AdR1a+3d9pMpI5A==
X-Google-Smtp-Source: AGHT+IFVVSo89qAw4CRacv0Z+UzhQb0J3+/g4LrcpSnsAvzEbJIMhZf3XOgEUEsmIVBWFHkIN+LQzGDbM6L0YWS7L4Y=
X-Received: by 2002:a1f:cd01:0:b0:490:1114:f3ee with SMTP id
 d1-20020a1fcd01000000b004901114f3eemr408251vkg.8.1692994063101; Fri, 25 Aug
 2023 13:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230814093621.23209-1-brgl@bgdev.pl> <20230814093621.23209-3-brgl@bgdev.pl>
 <875y54ci86.ffs@tglx> <CAMRc=Mfg52iqFKj0QMB55K5MCxhgPLbF-0WSRG0ktN3RbofMtQ@mail.gmail.com>
 <873507cziz.ffs@tglx> <CAMRc=MdYteOxy87jdSEvBxnN7tx_J1X2aSsRzKZ6WKL31-ipmA@mail.gmail.com>
 <87sf87aw36.ffs@tglx>
In-Reply-To: <87sf87aw36.ffs@tglx>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 25 Aug 2023 22:07:32 +0200
Message-ID: <CAMRc=Mcvkjmy2F=92SWRdCKL0US_YSwsvpWjcfOH9CBGw3GB0g@mail.gmail.com>
Subject: Re: [PATCH 2/2] genirq: proc: fix a procfs entry leak
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
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

On Fri, Aug 25, 2023 at 7:08=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Fri, Aug 25 2023 at 13:01, Bartosz Golaszewski wrote:
> > On Fri, Aug 25, 2023 at 10:11=E2=80=AFAM Thomas Gleixner <tglx@linutron=
ix.de> wrote:
> >> On Fri, Aug 25 2023 at 00:36, brgl@bgdev.pl wrote:
> >> > On Thu, 24 Aug 2023 22:12:41 +0200, Thomas Gleixner <tglx@linutronix=
.de> said:
> >> > Here a GPIO device - that is also an irq chip - is unbound (this is =
a testing
> >> > module unbound during a test-case but it can be anything else, like =
an I2C
> >> > expander for which the driver is unloaded) while some users called
> >> > request_irq() on its interrupts (this is orthogonal to gpiod_get() a=
nd doesn't
> >> > take a reference to the module, so nothing is stopping us from
> >> > unloading it)
> >>
> >> You just described the real problem in this sentence. So why are you
> >> trying to cure a symptom?
> >
> > Honestly I'm not following. Even if we did have a way of taking the
> > reference to the underlying GPIO module (I'm 99% percent sure, it's
> > not possible: we're not using any of the GPIO interfaces for that,
>
> The point is that something frees an in-use interrupt descriptor, which
> is obviously wrong to begin with.
>

It happens in irq_dispose_mapping() when the domain is not
hierarchical and irq_free_desc() is called in the if branch.

> Now you go and cure the symptom of a stale procfs file, but as I said
> before this is the least of the worries.
>
> Care to look at what free_irq() does and you might figure out why this
> stale file is just an easy to observe symptom, but obviously not the
> real problem.
>
> This leaves an activated interrupt around with stale pointers to the
> descriptor. The interrupt could be on the flight. The associated thread
> could be running. There can be resources claimed via request_irq() which
> will not be freed either. There can be management operations on the
> interrupt in parallel.
>
> A driver which successfully requests an interrupt can rightfully expect
> that any management operation on the interrupt, e.g. disable(),
> enable(), set_*() is valid until the point it invokes free_irq().
>

Whether by "valid" you mean "always succeeds" or merely just "doesn't
crash the kernel", it basically means that the consumer that requested
the resource (irq, GPIO or otherwise) can always call any of the
consumer-facing calls and the handle it got from the provider (GPIO
descriptor, irq number) remains valid even after the device backing
that handle is gone - in which case the call either returns 0 and acts
like nothing happened or returns an appropriate error code (most
likely -ENODEV).

Or even a combination of both, like we do in the GPIO subsystem where
we emit a warning to kernel log but we still return 0.

> IOW, the descriptor including the associated interrupt chips (software
> representation) in the hierarchy must be at least in a consistent state
> and accessible. If the underlying hardware vanished, e.g. USB
> disconnect, then still the software side must be intact. Of course an
> disable_irq() won't reach the hardware anymore, but that's something the
> relevant driver has to handle correctly.
>

Absolutely agree! This is precisely what we do in the GPIO subsystem.
Except that we migrated from using a GPIO numberspace similar to the
irq numbers in favor of using GPIO descriptors which are simple
structs containing some meta-data about the GPIO request and - most
importantly - a reference to the GPIO device backing the descriptor.

That GPIO device (still talking about the software representation) has
two layers and is composed of a struct that embeds struct device and
is reference counted via the kobject refs inside struct device as well
as a second struct called the GPIO chip which on the other hand can be
destroyed at any time (most likely when the provider device is
unbound). struct gpio_device is guaranteed to exist for as long as
anyone references it even after struct gpio_chip was freed. Whenever
the user calls any of the consumer-facing APIs, we dereference the
descriptor, take the gpio_device pointer and see if the chip is still
there. If it's not - we return 0 as mentioned above.

Now for irqs, the consumer-facing "handle" is the interrupt number. I
don't know what the rationale is for that as it forces us to convert
it to a descriptor internally everytime we use it (tree lookup!) but
from what you're saying, if the domain backing it is destroyed and
with it, the interrupt descriptors, then management calls may end up
triggering use-after-free bugs. It seems about right as not all of
them check if the mapping can be found. I may have been lucky to never
trigger it as I was only using request_irq() and free_irq().

As I explained before in this thread - it's perfectly normal for the
provider of most resources in the kernel to be gone with users still
holding the respective handles. Maybe functions in linux/interrupt.h
could use some audit in order to make sure they can handle this. It
seems to me that the current infrastructure is ready as all it takes
is checking if irq_to_desc() returns a non-NULL value. Or I may be
getting it wrong and it's much more complex than that.

> So just claiming that it's fine to free in-use interrupts and everything
> is greate by removing the procfs entries is just wishful thinking.
>
> You simply cannot free an in-use interrupt descriptor and I'm going to
> add a big fat warning into that code to that effect.
>

With the above example, if our GPIO desc is analogous to the interrupt
number in the irq world - I'm not really sure what the role of the
irq_desc is. Should it be the *handle* that users get when they
request an irq? Maybe it is what the GPIO device is for us? Should it
be reference counted then?

> So if it turns out that this is a general problem, then we have to sit
> down and solve it from ground up.
>

It may very well be. I guess it will require a more detailed
investigation. I'd still say this patch is correct though, as the
self-contained function removing a procfs hierarchy should remove all
sub-directories and not just leak them. They don't hold any irq
resources anyway.

Are you fine with the first, cleanup patch in this series BTW?

Bartosz

> Thanks,
>
>         tglx
