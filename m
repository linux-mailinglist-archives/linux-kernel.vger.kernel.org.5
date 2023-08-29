Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2D078C435
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbjH2MZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbjH2MYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:24:47 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24AC1B1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:24:33 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-44d3fceb567so2659924137.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1693311873; x=1693916673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqUYNTWfcrZtrdSW8rQhLXO0+aU2YhVbjaMf2n+6904=;
        b=an1WIhyqIf6DUxbKmp55sMgEcrgWpnAjQTpt7juAYgtisL+5zgxGxQJw05eAiRU7OD
         WQn9jz8MBazYpwLPk1nHwHh46N8YRx3KqKfEtVSU64uJIeaMIzM98OR+RGJu1irp7Og4
         sr943A6dgjpTwpIyHkWLLOBPfxZaJCig5i3O4ly43J9Z52ull4z8IUYmo24yFEC3M/1E
         +mkeWss5NgCQwERbkb0wGtmZAcCqZZBePReLF6/I1/+fti/M07bFfkUMWquWZQHInsK8
         wHEer6628H7X24IC0L8nLhp4X1ime//1iOlkGHeP0I36zZAGmt1OeMxHgKbvU6J3AG1i
         xMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693311873; x=1693916673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqUYNTWfcrZtrdSW8rQhLXO0+aU2YhVbjaMf2n+6904=;
        b=cWQVbRwLdXMQm/w1aPSFnXAfwmiD+wG9ikBSiz4mK3iYaGE8v0sJTY91Ak/O88A45D
         lyh3uWLfbiZr+ssWAHS4rU0AXmaSJm5vKhMn+JXxqqwIiE9nug7gX4aSuPqeGCypATQ+
         ArVOlrM0E/wj/1dKpROh+LCAROA4i2V4ZR09lDC8zWmQBgcXQPnTyFRHepm+rYP2ecZ5
         FLxqlVGf0pt83+fbglfbQVLTFu+ifLTU3GcvGzaUz7E/qKfu1BBWxmNi2XAj4SfUqzLI
         6mFFBNGDmQ1s60Hx9HbeVp6nl3cSG1K1hIVAIKuldMuwCefZMg8SMpiRk9BC7MI6fJd2
         6ZTw==
X-Gm-Message-State: AOJu0YxmbGVI277TwvcpAkzXYIfSsv7QwMvB8vjBynewPQupIWHNXSfc
        o3SqNgLktA3bYdWNz4H4mAeYzceMte5O9pLGbWvfXEQ+Zcur+r2h
X-Google-Smtp-Source: AGHT+IFXZawGHC7kliiQ8qPu9jU0or8YuSZ8Rmm2337A7J6D3drwbnzl49phAoj8+qsiZH51RSNY2xu+g1P0lSvEp/I=
X-Received: by 2002:a67:f3d8:0:b0:44e:cab7:be2d with SMTP id
 j24-20020a67f3d8000000b0044ecab7be2dmr1307118vsn.7.1693311872733; Tue, 29 Aug
 2023 05:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230814093621.23209-1-brgl@bgdev.pl> <20230814093621.23209-3-brgl@bgdev.pl>
 <875y54ci86.ffs@tglx> <CAMRc=Mfg52iqFKj0QMB55K5MCxhgPLbF-0WSRG0ktN3RbofMtQ@mail.gmail.com>
 <873507cziz.ffs@tglx> <CAMRc=MdYteOxy87jdSEvBxnN7tx_J1X2aSsRzKZ6WKL31-ipmA@mail.gmail.com>
 <87sf87aw36.ffs@tglx> <CAMRc=Mcvkjmy2F=92SWRdCKL0US_YSwsvpWjcfOH9CBGw3GB0g@mail.gmail.com>
 <87il91c04a.ffs@tglx> <CAMRc=MfB=sMEmK02Y6SaG1T4PFZW2OD+box7NNoDY3KM1AchLA@mail.gmail.com>
 <87o7ir8hlh.ffs@tglx> <CAMRc=Mf9f9MxfRY+=Et9+wO5fZr61SRthcGhoHZsJ6-x6k+BgQ@mail.gmail.com>
 <873502971b.ffs@tglx> <CAMRc=Meigus=WOGwM-fStkhtDeKyTd+9vZH19HoP+U1xpwYx9Q@mail.gmail.com>
 <87msya6wmf.ffs@tglx>
In-Reply-To: <87msya6wmf.ffs@tglx>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 29 Aug 2023 14:24:21 +0200
Message-ID: <CAMRc=Md6NA6-rBWL1ti66X5Rt3C4Y2irfrSZnCo3wQSCqT6nPQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] genirq: proc: fix a procfs entry leak
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

On Tue, Aug 29, 2023 at 11:11=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> On Tue, Aug 29 2023 at 08:26, Bartosz Golaszewski wrote:
> > On Mon, Aug 28, 2023 at 11:44=E2=80=AFPM Thomas Gleixner <tglx@linutron=
ix.de> wrote:
> >> That's the module which provides the interrupt domain and hid-whatever
> >> is the one which requests the interrupt, no?
> >>
> > Not at all! This is what I said: "we have the hid-cp2112 module which
> > drives a GPIO-and-I2C-expander-on-a-USB-stick". Meaning: the
> > hid-cp2112 module registers a USB driver for a GPIO expander on a
> > stick. This GPIO chip is the interrupt controller here. It's the USB
> > stick that provides interrupts for whatever else needs them (in real
> > life: it can be an IIO device on the I2C bus which signals some events
> > over the GPIOs). The user can get the interrupt number using the
> > gpiod_to_irq() function. It can be unplugged at any moment and module
> > references will not stop the USB bus from unbinding it.
>
> Sorry for my confusion, but this all is confusing at best.
>
> So what you are saying is that the GPIO driver, which creates the
> interrupt domain is unbound and that unbind destroys the interrupt
> domain, right? IOW, the wonderful world of plug and pray.
>
> Let's look at the full picture again.
>
>    USB -> USB-device
>           |----------- GPIO
>           |------------I2C  ---------- I2C-device
>                  (hid-cp2112 driver)   (i2c-xx-driver)
>
> i2x-xx-driver is the one which requests the interrupt from
> hid-cp2112-GPIO, right?
>

Yes! Sorry if I was not being clear about it.

> So when the USB device disconnects, then something needs to tell the
> i2c-xx-driver that the I2C interface is not longer available, right?
>
> IOW, the unbind operation needs the following notification and teardown
> order:
>
>    1) USB core notifies hid-cp2112
>
>    2) hid-cp2112 notifies i2c-xx-driver
>
>    3) i2c-xx-driver mops up and invokes free_irq()
>
>    4) hid-cp2112 removes the interrupt domain
>
> But it seems that you end up with a situation where the notification of
> the i2c-xx-driver is either not happening or the driver in question is
> simply failing to mop up and free the requested interrupt.
>

Yes, there's no notification of any kind. It's a common problem
unfortunately across different subsystems. We have hot-unpluggable
consumers using resources that don't support it (like interrupts in
this example).

> As a consequence you want to work around it by mopping up the requested
> interrupts somewhere else.
>

The approach I'm proposing - and that we implement in GPIO - is
treating the "handle" to the resource as what's often called in
programming - a weak reference. The resource itself is released not by
the consumer, but the provider. The consumer in turn can get the weak
reference from the provider and has to have some way of converting it
to a strong one for the duration of any of the API calls. It can be
implemented internally with a mutex, spinlock, an RCU read section or
otherwise (in GPIO we're using rw_semaphores but I'm working on
migrating to SRCU in order to protect the functions called from
interrupt context too which is missing ATM). If for any reason the
provider vanishes, then the next API call will fail. If it vanishes
during a call, then we'll wait for the call to exit before freeing the
resources, even if the underlying HW is already gone (the call in
progress may fail, that's alright).

For interrupts it would mean that when the consumer calls
request_irq(), the number it gets is a weak reference to the irq_desc.
For any management operation we lock irq_desc. If the domain is
destroyed, irq_descs get destroyed with it (after all users leave the
critical section). Next call to any of the functions looks up the irq
number and sees it's gone. It fails or silently returns depending on
the function (e.g. irq_free() would have to ignore the missing
lookup).

But I'm just floating ideas here.

> It's not clear to me what you are trying to achieve here.
>
>    If this is meant as a hardening effort to catch such issues and let
>    the kernel gracefully "survive", then I'm all ears.
>

IMO if more subsystems adapted the above approach then we'd have less
surprises when their resources are used in an unexpected way. I'd call
it "part of a broader hardening effort". :)

Bart

>    If this is just meant to paper over the shortcomings of subsystems or
>    driver implemtations then I'm not interested at all.
>
> Thanks,
>
>         tglx
>
>
>
>
