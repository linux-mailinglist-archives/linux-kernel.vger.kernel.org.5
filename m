Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE2A78A99C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjH1KHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjH1KG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:06:56 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A676AC6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:06:52 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-44d4c3fa5beso1372633137.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1693217211; x=1693822011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PE+qhXvnTD0mgCAbUqcO9zBTJRx+ONXApVXvJkvW02I=;
        b=bXBWhYrHEarnTLvpWlv2aq1LiYY2ARS3hOPrF2EncPLj2a9ARUBkgddh4Z+tRqCISE
         qTCxFwGjoj/7Lvuc7kfyEXZ6jLYy9YBmYVVStgLkYImi3zCDXE/OHsqrltx5XNtmXgT3
         7ownmascfCIjzF+XvOfP64rC8l/z3IjNL/Hk9n9PQ4AbuTqKqQxfgLfJGklSrGxnK20D
         yQ9yC6F0MLnRHDXkNFhcjNUeaWK7PEZt3TyEOemIG5gE254gfGQrFNPy4wlcaGnibg9/
         wGut/VpCLneWqe2pwSDZq89236kLbfIKB6Q77klCa+NQXsmnUgJyjgiN97dmYbV2s/pr
         pnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693217211; x=1693822011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PE+qhXvnTD0mgCAbUqcO9zBTJRx+ONXApVXvJkvW02I=;
        b=NBB1xlkCEfFJOJByE7zMNxdi3sCj3H8nfQ0Fhd7CsPEru3vq6PJ1Mi+GYS+bPZHI8r
         Z9ahqhph/AlQLs317C7JOqfQANVTpq9HfynuvQApIQTQk9S6bdziIbz0soCjR6bhW5g2
         A1pDG5Y2LQSuEu1YAyXpdIbylAgwi1+W3KYOWHDfwY+VeLfvgGfChS3RIOB+CXDwaO6G
         VSe+fGGtzk7QmlJgwYj9oump5gBpxGHrLze5+oxXTLySBZ+BS39Sb1d4i4N8SITp2bg7
         ehD9rcf13w0RMmvGZeqOl6VfofXk3Acg/t6mnvY6gvqhzHyjuUKm+PtfeSrjlzTrQpBH
         tUSA==
X-Gm-Message-State: AOJu0Yy/0Vi1Oc9F/Qdg4p18btLdlklMSuf0jKrtkoO9tBCNGq3TM/KJ
        bTPG8EHynsRhw0ye0QzQ1qn5A9Ut9tJ4+S93Ex84KQ==
X-Google-Smtp-Source: AGHT+IEhsgb7vzMyNmbsqMIUJRTc40eqYih/jsLjcmzgZn7jsw1sPcaUCd78vCL3HeMtDfrrN+kX6RJXj6DhLob2dqk=
X-Received: by 2002:a67:ef90:0:b0:44d:5c17:d067 with SMTP id
 r16-20020a67ef90000000b0044d5c17d067mr15064943vsp.8.1693217211407; Mon, 28
 Aug 2023 03:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230814093621.23209-1-brgl@bgdev.pl> <20230814093621.23209-3-brgl@bgdev.pl>
 <875y54ci86.ffs@tglx> <CAMRc=Mfg52iqFKj0QMB55K5MCxhgPLbF-0WSRG0ktN3RbofMtQ@mail.gmail.com>
 <873507cziz.ffs@tglx> <CAMRc=MdYteOxy87jdSEvBxnN7tx_J1X2aSsRzKZ6WKL31-ipmA@mail.gmail.com>
 <87sf87aw36.ffs@tglx> <CAMRc=Mcvkjmy2F=92SWRdCKL0US_YSwsvpWjcfOH9CBGw3GB0g@mail.gmail.com>
 <87il91c04a.ffs@tglx>
In-Reply-To: <87il91c04a.ffs@tglx>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 28 Aug 2023 12:06:40 +0200
Message-ID: <CAMRc=MfB=sMEmK02Y6SaG1T4PFZW2OD+box7NNoDY3KM1AchLA@mail.gmail.com>
Subject: Re: [PATCH 2/2] genirq: proc: fix a procfs entry leak
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 5:08=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Fri, Aug 25 2023 at 22:07, Bartosz Golaszewski wrote:
> > On Fri, Aug 25, 2023 at 7:08=E2=80=AFPM Thomas Gleixner <tglx@linutroni=
x.de> wrote:
> >> The point is that something frees an in-use interrupt descriptor, whic=
h
> >> is obviously wrong to begin with.
> >>
> > It happens in irq_dispose_mapping() when the domain is not
> > hierarchical and irq_free_desc() is called in the if branch.
>
> Again. You are explaining what the callchain is. That's not interesting
> at all (I can find the places which invoke irq_free_descs() with grep).
>
> The question is WHY is irq_dispose_mapping() called when the interrupt
> in question _IS_ in use, i.e. requested and not yet released via
> free_irq().
>
> That's the underlying problem which needs to be addressed.
>
> > Now for irqs, the consumer-facing "handle" is the interrupt number. I
> > don't know what the rationale is for that as it forces us to convert
> > it to a descriptor internally everytime we use it (tree lookup!) but
>
> Perhaps because operating on an integer is not really giving you access
> to the underlying mechanisms. The tree lookup is really not an issue and
> it's a mechanism which is used all over the place in the kernel to
> translate a cookie or identifier to the internal data representation of
> a subsystem.
>
> > As I explained before in this thread - it's perfectly normal for the
> > provider of most resources in the kernel to be gone with users still
> > holding the respective handles.
>
> No. It's not most. It's only the case when the subsystem explicitely
> documents that it can handle it, which the interrupt subsystem does not.
>
> > Maybe functions in linux/interrupt.h could use some audit in order to
> > make sure they can handle this.
>
> Maybe you stop claiming that it's perfectly legit to free resources
> which are in use. It's not and the interrupt subsystem never was making
> this guarantee and never was designed for it.
>
> > It seems to me that the current infrastructure is ready as all it
> > takes is checking if irq_to_desc() returns a non-NULL value. Or I may
> > be getting it wrong and it's much more complex than that.
>
> Again:
>
> It's not just NULL checks, which exist already. It's not just a stale
> procfs file which needs to be removed. Did you actually look what
> free_irq() does?
>
> Obviously not, otherwise you might have noticed that removing the
> resources leaks:
>
>    1) The interrupt action itself
>    2) Any interrupt threads associated with the action
>    3) The procfs entry
>    4) Any resource which was allocated during request_irq()
>    5) Interrupt descriptor pointers stored separately for low level
>       interrupt handling code
>
> Further it might:
>
>    1) leave hardware in an undefined state
>    2) race against an interrupt being processed concurrently
>
> How do you address this with slapping some NULL checks around? The only
> way to clean this up is invoking free_irq().
>

This is not what I meant, let me rephrase the question:

Is there any reason why whatever operations irq_free() performs could
not be done by the irqchip when it knows it will be destroyed with
irqs still in use? And then any new management operation that would be
called by the now orphaned user would just bail out? Maybe not, I'm
asking this question because I don't know and it's not obvious from
the code.

> >> So just claiming that it's fine to free in-use interrupts and everythi=
ng
> >> is greate by removing the procfs entries is just wishful thinking.
> >>
> >> You simply cannot free an in-use interrupt descriptor and I'm going to
> >> add a big fat warning into that code to that effect.
> >>
> > With the above example, if our GPIO desc is analogous to the interrupt
> > number in the irq world - I'm not really sure what the role of the
> > irq_desc is. Should it be the *handle* that users get when they
> > request an irq? Maybe it is what the GPIO device is for us? Should it
> > be reference counted then?
>
> It's an internal data structure which is not accessible outside of the
> interrupt core and architecture low level code. The number is the
> identifier for the consumers to interact with the core code. That
> concept is called abstraction. What's so hard about that?
>

No need to be snarky. I do know what abstraction is. I also know that
a pointer to an opaque structure fulfills the same role without the
translation step and this is what irq_desc could be. But I get it, the
numbers have been in use for years, it's hard to change it, I don't
have an issue with that. Let's not continue this.

> >> So if it turns out that this is a general problem, then we have to sit
> >> down and solve it from ground up.
> >
> > It may very well be. I guess it will require a more detailed
> > investigation. I'd still say this patch is correct though, as the
> > self-contained function removing a procfs hierarchy should remove all
> > sub-directories and not just leak them. They don't hold any irq
> > resources anyway.
>
> This patch is not correct at all. Once again:
>
>  The interrupt subsystem is not designed to have its underlying
>  resources be freed when an interrupt is in-use.
>
> It's that simple. And no, your patch is not changing this. It tries to
> paper over the violation of the rule of this subsystem.
>
> The below is going to be applied ASAP to make this entirely clear. And
> yes, that's going to leak a bit more than just the procfs entry.
>
> The proper solution to this is to take a reference count on the module
> which provides the interrupt chip and allocates the interrupt domain.
> The core code has a mechanism for that. See request/free_irq().

I guess you're referring to irq_alloc_descs()? Anyway, here's a
real-life example: we have the hid-cp2112 module which drives a
GPIO-and-I2C-expander-on-a-USB-stick. I plug it in and have a driver
that requests one of its GPIOs as interrupt. Now I unplug it. How has
taking the reference to the hid-cp2112 module protected me from
freeing an irq domain with interrupts in use?

Let me focus on a possible solution then, because as it is, we have
the GPIO subsystem which claims it can survive a hot-unplug with
active users (it's not fully done yet for all corner-cases but that's
a different story...) but a GPIO chip can also act as an interrupt
controller whereas the caller can bypass most of the core GPIO code.
And now it's clear that the interrupt subsystem does not support hot
unplugging at all. And please, don't yell at me for this as this
design predates my involvement with the subsystem.

I'm thinking about two possible solutions that could be contained
within the GPIO core.

One would be to keep track of requested irqs in the GPIO-to-interrupt
glue code (where the domain is managed) and then when the GPIO chip
device is unbound, we could just go over the list of active ones and
call irq_free() on all of them. Does it even make any sense? If so: is
there any way at the moment to be notified about an irq being
requested/freed for given domain? I don't think map() and unmap()
callbacks are the right place as they are called once per mapping.
Would you be ok with adding this functionality?

Second possibility would be to keep the domain in refcounted struct
gpio_device and not struct gpio_chip where it can be freed on device
unbind. Except unlike requesting a GPIO descriptor, requesting the
interrupt directly does not increase the gpio_device's reference count
so we're back to the former. We could move the domain to the
refcounted struct and with a proper on-request notification, could
increase its refcount just like we do with the GPIO device on GPIO
request.

Do you maybe have any other suggestions by chance?

Bartosz

>
> Unfortunately it is not properly utilized by the irqdomain
> infrastructure today. But that's a fixable problem.
>
> Thanks,
>
>         tglx
> ---
> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index 27ca1c866f29..5382fd4e7588 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -466,6 +466,9 @@ static void free_desc(unsigned int irq)
>  {
>         struct irq_desc *desc =3D irq_to_desc(irq);
>
> +       if (WARN_ON_ONCE(desc->action))
> +               return;
> +
>         irq_remove_debugfs_entry(desc);
>         unregister_irq_proc(irq, desc);
>
>
