Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6251793FB1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242175AbjIFOzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240937AbjIFOzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:55:22 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B261819A0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 07:54:49 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-48d333a18b3so1164491e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 07:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694012088; x=1694616888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQFPyQinTQAKSwLIG6CE7/mdZdj2wHjtBeJ0G/ar+8U=;
        b=i6pu02/v4FY41EOitv5kICCZGmDvXmIFf5ALUAwx1BvUUl/RSTipIoSaCBBp0jGCcI
         KGCyaxJpaVx0H/XJ1D1eiM7wb12lmDhqS0RcJJeWIRTbZC6iUNgAC35ROYcJFVRYBE9n
         l4eZNORYw6lt6cJ8ZzwrzP4Z/dthZO5L1S1XBFLvBjvKMzuNPymiSMS4pxOiND1euDUi
         Or5PlYyE7hjmhqZ7nxG69ih/dYt+fSksWP0ujbyQ7qgWZjS4zST0him7t0xkW1Zsfnzc
         /GgVBC9DC6ITaoN3H56RRun1auI10sN5/h1nk0TJYcNICM7r6vf2INgLDurDE0M5peO+
         7h1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694012088; x=1694616888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQFPyQinTQAKSwLIG6CE7/mdZdj2wHjtBeJ0G/ar+8U=;
        b=TnS0qX8aAkfzqB8hS2dhacXWy6xHqsKHbtoKO0d22zbR+dTMyi8SOvZvd35I7mCOyd
         E1JVO/JbEwmOyZ1eMOkcWMPDUSij6kCZVNn2yjcxQUwOPphVUK2VCIzLMTF6Oih4k78g
         BdzUPjOMvEpsBasjme8OS2/NRmFjRdQE3XTE7eJz3wMxAGezCWZpZxRD3yPoC4u3Fsab
         0UD10U0ift78coxpDVGhJJxABpDknms7OUzBwrSfdEpg3VHWmd4+kzAITahvVA0ETaXD
         WetPlyjJMl+5Cv0CIRk6TcPwUxpu75wgjpl3gx6exRKhNIro8v+dmzen6Jnp2Uv+lmJS
         IKEQ==
X-Gm-Message-State: AOJu0YyzWNppxqPObJ3ARQ1pEoyKv5VrXIPpDmtYK0HMGqGwKRRPCPoJ
        AT1ZcqIh0P/jy/SotUojZ14fz4NcVVcrf9NoFPk0Jg==
X-Google-Smtp-Source: AGHT+IFyXdoKytSQ6gv3KKz3DmlxT1H1pFAZ3cPqsfWUXe7Gy89q0ZzgQOuKOqs/AFCeXsSaLcoL7kfsp5gkZviHT2Q=
X-Received: by 2002:a1f:6603:0:b0:48c:fc50:4292 with SMTP id
 a3-20020a1f6603000000b0048cfc504292mr3098941vkc.15.1694012087878; Wed, 06 Sep
 2023 07:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230814093621.23209-1-brgl@bgdev.pl> <20230814093621.23209-3-brgl@bgdev.pl>
 <875y54ci86.ffs@tglx> <CAMRc=Mfg52iqFKj0QMB55K5MCxhgPLbF-0WSRG0ktN3RbofMtQ@mail.gmail.com>
 <873507cziz.ffs@tglx> <CAMRc=MdYteOxy87jdSEvBxnN7tx_J1X2aSsRzKZ6WKL31-ipmA@mail.gmail.com>
 <87sf87aw36.ffs@tglx> <CAMRc=Mcvkjmy2F=92SWRdCKL0US_YSwsvpWjcfOH9CBGw3GB0g@mail.gmail.com>
 <87il91c04a.ffs@tglx> <CAMRc=MfB=sMEmK02Y6SaG1T4PFZW2OD+box7NNoDY3KM1AchLA@mail.gmail.com>
 <87o7ir8hlh.ffs@tglx> <CAMRc=Mf9f9MxfRY+=Et9+wO5fZr61SRthcGhoHZsJ6-x6k+BgQ@mail.gmail.com>
 <873502971b.ffs@tglx> <CAMRc=Meigus=WOGwM-fStkhtDeKyTd+9vZH19HoP+U1xpwYx9Q@mail.gmail.com>
 <87msya6wmf.ffs@tglx> <CAMRc=Md6NA6-rBWL1ti66X5Rt3C4Y2irfrSZnCo3wQSCqT6nPQ@mail.gmail.com>
 <877cpd7a96.ffs@tglx>
In-Reply-To: <877cpd7a96.ffs@tglx>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 6 Sep 2023 16:54:36 +0200
Message-ID: <CAMRc=MfNaydT8gnvusKdJrNrtjKVE4LTqdanh3+WNd5QF-2q_Q@mail.gmail.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 12:29=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> On Tue, Aug 29 2023 at 14:24, Bartosz Golaszewski wrote:
> > On Tue, Aug 29, 2023 at 11:11=E2=80=AFAM Thomas Gleixner <tglx@linutron=
ix.de> wrote:
> >> > On Mon, Aug 28, 2023 at 11:44=E2=80=AFPM Thomas Gleixner <tglx@linut=
ronix.de> wrote:
> >> So when the USB device disconnects, then something needs to tell the
> >> i2c-xx-driver that the I2C interface is not longer available, right?
> >>
> >> IOW, the unbind operation needs the following notification and teardow=
n
> >> order:
> >>
> >>    1) USB core notifies hid-cp2112
> >>
> >>    2) hid-cp2112 notifies i2c-xx-driver
> >>
> >>    3) i2c-xx-driver mops up and invokes free_irq()
> >>
> >>    4) hid-cp2112 removes the interrupt domain
> >>
> >> But it seems that you end up with a situation where the notification o=
f
> >> the i2c-xx-driver is either not happening or the driver in question is
> >> simply failing to mop up and free the requested interrupt.
> >>
> >
> > Yes, there's no notification of any kind.
>
> I'm not buying that.

Gah, sorry, it took me a while to get back to this thread...

>
>   usb disconnect
>     ...
>       cp2112_remove()
>         i2c_del_adapter()
>           i2c_unregister_device(client)
>             ...
>             device_unregister()
>               device_del()
>                 bus_notify()            // Mechanism #1
>                   i2c_device_remove()
>                     if (dev->remove)
>                        dev->remove()
>                 ...
>                 device_unbind_cleanup()
>                   devres_release_all()  // Mechanism #2
>
>         gpiochip_remove()
>
> There are very well notifications to the drivers about unplug of a
> device. Otherwise this would end up in a complete disaster and a lot
> more stale data and state than just a procfs file or a requested
> interrupt.

I'm not sure how either of the two helps here. #2 just releases
managed resources owned by cp2112. It can remove the domain with an
appropriate devm action but it won't do anything for the users of
interrupts. #1 is a bus notification emitted when the I2C adapter
exposed by cp2112 has been deleted. This one in particular doesn't
help us, the domain is long gone by now but if I get what you mean
correctly, you'd want the driver to call request_irq() and then set up
a notifier block for the BUS_NOTIFY_UNBIND_DRIVER notification of the
provider of that interrupt? Doesn't that break like half a dozen of
abstraction layers? Because now the device driver which is the GPIO
consumer needs to know where it gets its interrupts from?

>
> So the mechanisms are there, no?
>

Technically you could duct tape something up. But this is far from
being generic and it would be a per-driver solution at best, not even
per-subsystem. Because this is just interrupts. What about other
providers? Setup a notification for every single one? The resources a
device needs are normally acquired in probe() and released in
remove(). Possibly there are per-systems setup/teardown, open/close
etc. callbacks but it's not much different. What would you do in this
notification callback? Release the resource and keep going? In what
state would that device be now?

You would think that plug-and-play works well in the kernel and it's
true for certain parts but it really isn't the case for subsystems
that were not considered as very plug-and-play until people started
putting them on a stick. Some devices that are not typically
hot-pluggable - like serial - have been used with USB for so long that
they do handle unplugging very well. But as soon as you put i2c on
USB, you'll see what a mess it is. If you have an I2C device on a USB
I2C expander and it's being used, when you pull the plug, you'll see
that the kernel thread removing the device will block on a call to
wait_for_completion() until all users release their i2c adapter
references. They (the users) are not however notified in any generic
way about the provider of their resources being gone.

And even if they were, what would they do? "Unbind themselves" so that
their remove paths be triggered where they would free resources? That
may be a solution I suppose - a device whose non-optional resource
provider is gone, should go down as well I suppose. This would be a
huge development however and a more realistic approach is to make
provider APIs resistant to the backing device being removed.

> If this is just about the problem that some device driver writers fail
> to implement them correctly, then yes it makes sense to have a last
> resort fallback which cleans them up and emits a big fat warning.
>
> Making this a programming model would be beyond wrong.
>
> > It's a common problem unfortunately across different subsystems. We
> > have hot-unpluggable consumers using resources that don't support it
> > (like interrupts in this example).
>
> All hotpluggable consumers have at least one mechanism to mop up the
> resources they allocated. There are a lot of resources in the kernel
> which do not clean themself up magically.
>

Yeah, hotpluggable consumers are fine. The problem here is
hotpluggable *providers* with consumers who don't know that.

> So what's so special about interrupts? They are not any different from a
> pointer which is registered at some entity and the device driver writer
> forgets to unregister it, but the underlying resource is freed. That's
> even worse than the leaked interrupt and cannot be magically undone at
> all.

But that's precisely my point. It's not only interrupts. There *IS* a
wider problem in the kernel with resources that are provided by
devices that can disappear at any moment. My argument is that the
provider API should handle that and not rely on the consumer to
release those resources in time. Serial or GPIO handle that by having
a reference counted outer layer and an inner implementation that can
go from under it. The outer layer then simply returns an appropriate
error to the consumer. During any of the provider calls, the
lower-level object is locked and protected from being destroyed.

>
> Whatever you try, you can't turn driver programming into a task which
> can be accomplished w/o brains.
>

I merely want to reduce the number of obvious traps. :)

> > For interrupts it would mean that when the consumer calls
> > request_irq(), the number it gets is a weak reference to the irq_desc.
>
> Interrupt numbers are weak references by definition. request_irq() does
> not return an interrupt number, it returns success or fail. The
> interrupt number is handed to request_irq(), no?
>
> The entities which hand out the interrupt number are a complete
> different story. But that number is from their perspective a weak
> reference too.
>
> > For any management operation we lock irq_desc.
>
> That's required anyway, but irq_desc::lock is not a sufficient
> protection against a teardown race.
>
> > If the domain is destroyed, irq_descs get destroyed with it
>
> Interrupts consist of more than just an interrupt descriptor. If you
> care to look at the internals, then the descriptor is the last entity
> which goes away simply because all other related resources hang off the
> interrupt descriptor.
>
> So they obviously need to be mopped up first and trying to mop up
> requested interrupts at the point where the interrupt descriptor is
> freed is way too late.
>
> In fact they need to mopped up first, which is obvious from the setup
> ordering as everything underneath must be in place already before
> request_irq() can succeed. The only sensible ordering for teardown is
> obviously the reverse of setup, but that's not specific to interrupts at
> all.
>
> > (after all users leave the critical section).
>
> Which critical section? Interrupts have more than just the
> irq_desc::lock critical section which needs to be left.
>
> > Next call to any of the functions looks up the irq number and sees
> > it's gone. It fails or silently returns depending on the function
> > (e.g. irq_free() would have to ignore the missing lookup).
>
> That's what happens today already.
>
> The missing bit is the magic function which mops up when the driver
> writer blew it up. But that's far from a 'put a trivial free_irq() call
> somewhere'.
>
> First of all we have too many interrupt mechanisms ranging from the
> linux 0.1 model with static interrupt spaces to hierarchical interrupt
> domains.
>
>   - Almost everything which is interrupt domain based (hierarchical or
>     not) can probably be "addressed" by some definition of "addressed"
>     because there are only a few places in the core code which are
>     involved in releasing individual or domain wide resources.
>
>     But see below.
>
>   - The incarnations which do not use interrupt domains are way harder
>     because the teardown of the interrupt resources is not happening in
>     the core code. It's happening at the driver side and the core is
>     only involved to release the interrupt descriptor. But that's too
>     late.
>
>     The good news about those is that probably the vast majority of the
>     instances is built in, mostly legacy and not pluggable.
>
> So lets assume that anything which is not interrupt domain based is not
> relevant, which reduces the problem space significantly. But the
> remaining space is still non-trivial.
>
>   1) Life-time
>
>      Interrupt descriptors are RCU freed but that's mostly for external
>      usage like /proc/interrupts
>
>      Still most of the core code relies on the proper setup/teardown
>      order, so there would be quite some work to do vs. validating that
>      an interrupt descriptor is consistent at all hierarchy levels.
>
>      That's going to be interesting vs. interfaces which can be invoked
>      from pretty much any context (except NMI).
>
>      irq_desc::lock is not the panacea here because it obviously can
>      only be held for real short truly atomic sections. But quite some
>      of the setup/teardown at all levels requires sleepable context.
>
>   2) Concurrency
>
>      Protection against concurrent interrupt handler execution is
>      covered in free_irq() as it fully synchronizes.
>
>      That's the least of my worries.
>
>      Whatever the invalidation mechanism might be, pretty much every
>      usage site of irq_to_desc() and any usage site of interrupt
>      descriptors which are stored outside of the maple_tree for
>      performance reasons need to be audited.
>
>      The validation has to take into account whether that's an requested
>      descriptor or an unused one.
>
> So no, neither removing some procfs entry at the wrong point nor
> slapping some variant of free_irq() into random places is going to cut
> it.
>
> Your idea of tracking request_irq()/free_irq() at some subsystem level
> is not going to work either simply because it requires that such muck is
> sprinkled all over the place.
>

I was thinking more about tracking it at the irq domain level so that
when a domain is destroyed with interrupts requested, these interrupts
are freed. I admit I still don't have enough in-depth knowledge about
linux interrupts to understand why it  can't work, I need to spend
more time on this. I'll be back.

> I completely agree that the interrupt core code does not have enough
> places which emit a prominent warning when the rules are violated.
>
> So sure, in some way or the other a "fix" by some definition of "fix"
> could be implemented, but I'm really not convinced that's the right way
> to waste^Wspend our time with.
>
> Especially not because interrupt handling is a hot-path and any
> life-time/conncurrency validation mechanism will introduce overhead no
> matter what.
>

Thanks for the detailed explanation.

Bartosz
