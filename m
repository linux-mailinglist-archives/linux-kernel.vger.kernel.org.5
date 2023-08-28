Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4183078B7C9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjH1TDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjH1TDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:03:22 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1E4FF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:03:16 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6bf0decd032so1256270a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1693249396; x=1693854196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEZDj6py3Y0REpJ+qhEDDLWQbWTqF3p5so9YTkXiGGA=;
        b=5TMC1zosWA7v8dY+8EqL/3goVoqhqUOBxrMyKd1aFh4SyHDFa6FsXkVDCGRxIQriru
         UdLwzhR1XFC2hj/4dkQ0gVOU+8IKMB0gvP/puusw1LZL13pmTc2LxQG4dpj9Mx422Jgw
         vl5+e7iby1TUgUwDsx2oNw7vw5N2jrj8cvara4jQM5yeFgJVwrlOV38T7Ta9kKVLW1Vn
         ogdyno3i+QOCeDsSFgrSPL5MW/rQ7/LR5VM5TZMCzXaoVVEk5vWL69NEEOlRObkoansm
         PXAuXwcU5ktDtiiz/BD/s591oU3MdthVb0DxsEDtQ/3Rb/YRjLhtaEp/kjWDyOeRU72/
         7FnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693249396; x=1693854196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zEZDj6py3Y0REpJ+qhEDDLWQbWTqF3p5so9YTkXiGGA=;
        b=UiHpd5c14RBmwIovlWyqIMHnYFZr4MoGT0KWAPLaK7Ehoba5zG1SXFGTBXhTjso3Jh
         6PNR2OAwdjZBXb79jM1OjDE+MdeRXI7tFnGOtXyM/CMNKoURpXSdLzCx2wn52EFTKxw4
         ITWUkDsLRD/bYYatvihCjdKxvmZp7v89oG2q9CDfvY8ErkjoSiIi0m3+jejH2Xt+YlZ1
         i3pmeAqefjPy4Jq+wNIPcM8TFsZUq566R5JyN5EEVn314wGgp0G/tmqpKdSu09Xvo6cj
         +ywOfTXlY4bdmhqRZC/KOd8p2uXnHzlV+gG0z9qaXu1vk4OQByivElkmQFTWTwGymaii
         olig==
X-Gm-Message-State: AOJu0YzAocBgcaS6BLPi6/+K3Cyy89C11E4iAYe9d3/21szRSWrA81H2
        1GHxaqlOEnXsFo4MOZ42dMINq1y4Mfe+OtScP0cAtcCpeFnIdN6G
X-Google-Smtp-Source: AGHT+IEKbgfU9RsShKBMFsz+RpE6+7bTYyQgAU8sAZoRsGR2mLY6yGCB34Tw2q3cb6x7yqCDsp1VsJ5SMw1+vz3tPUI=
X-Received: by 2002:a05:6358:5284:b0:135:4003:784c with SMTP id
 g4-20020a056358528400b001354003784cmr24967261rwa.17.1693249395930; Mon, 28
 Aug 2023 12:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230814093621.23209-1-brgl@bgdev.pl> <20230814093621.23209-3-brgl@bgdev.pl>
 <875y54ci86.ffs@tglx> <CAMRc=Mfg52iqFKj0QMB55K5MCxhgPLbF-0WSRG0ktN3RbofMtQ@mail.gmail.com>
 <873507cziz.ffs@tglx> <CAMRc=MdYteOxy87jdSEvBxnN7tx_J1X2aSsRzKZ6WKL31-ipmA@mail.gmail.com>
 <87sf87aw36.ffs@tglx> <CAMRc=Mcvkjmy2F=92SWRdCKL0US_YSwsvpWjcfOH9CBGw3GB0g@mail.gmail.com>
 <87il91c04a.ffs@tglx> <CAMRc=MfB=sMEmK02Y6SaG1T4PFZW2OD+box7NNoDY3KM1AchLA@mail.gmail.com>
 <87o7ir8hlh.ffs@tglx>
In-Reply-To: <87o7ir8hlh.ffs@tglx>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 28 Aug 2023 21:03:04 +0200
Message-ID: <CAMRc=Mf9f9MxfRY+=Et9+wO5fZr61SRthcGhoHZsJ6-x6k+BgQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] genirq: proc: fix a procfs entry leak
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
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

On Mon, Aug 28, 2023 at 2:41=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Mon, Aug 28 2023 at 12:06, Bartosz Golaszewski wrote:
> > On Sat, Aug 26, 2023 at 5:08=E2=80=AFPM Thomas Gleixner <tglx@linutroni=
x.de> wrote:
> >>
> >> How do you address this with slapping some NULL checks around? The onl=
y
> >> way to clean this up is invoking free_irq().
> >>
> >
> > This is not what I meant, let me rephrase the question:
> >
> > Is there any reason why whatever operations irq_free() performs could
> > not be done by the irqchip when it knows it will be destroyed with
> > irqs still in use? And then any new management operation that would be
> > called by the now orphaned user would just bail out? Maybe not, I'm
> > asking this question because I don't know and it's not obvious from
> > the code.
>
> The irqchip can do nothing and it is not directly involved in freeing
> the interrupt descriptor. The entity, which allocated the interrupt
> descriptors is responsible for that. That's in most modern cases the
> interrupt domain.
>
> It might be possible to free the actions in a teardown operation, but
> that needs a lot of thoughts vs. concurrency and life time rules. A
> simple 'let's invoke free_irq()' does not cut it.
>
> >> The proper solution to this is to take a reference count on the module
> >> which provides the interrupt chip and allocates the interrupt domain.
> >> The core code has a mechanism for that. See request/free_irq().
> >
> > I guess you're referring to irq_alloc_descs()? Anyway, here's a
> > real-life example: we have the hid-cp2112 module which drives a
> > GPIO-and-I2C-expander-on-a-USB-stick. I plug it in and have a driver
> > that requests one of its GPIOs as interrupt. Now I unplug it. How has
> > taking the reference to the hid-cp2112 module protected me from
> > freeing an irq domain with interrupts in use?
>
> request_irq() does not care which module request the interrupt. It
> always takes a refcount on irq_desc::owner. That points to the module
> which created the interrupt domain and/or allocated the descriptors.
>
> IOW, this needs a mechanism to store the module which creates the
> interrupt domain somewhere in the domain itself and use it when
> allocating interrupt descriptors. So in your case this would take a
> refcount on the GPIO module.
>

This is still not complete. In the above example, the USB bus can
still unbind the GPIO device that created the domain on hot-unplug,
triggering its cleanup routines (.remove(), devres chain) and
destroying the domain and keeping the reference to the hid-cp2112
module will not help it. This is why I suggested tracking the irq
requests and freeing them in said cleanup path.

Bartosz
