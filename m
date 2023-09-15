Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89A17A276B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjIOTvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjIOTuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:50:39 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA01C7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:50:33 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7a86f1befb3so1228338241.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694807432; x=1695412232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9YBfJ4jTyz5d6/Vbwqk7jfQ5mGKuKqv2TmTIASENsk=;
        b=VxYlhDltjk7xbo6Q4c5PqTcL9I02OIGRK4guIipFoQaIzw28mLrnKWm6seXGD/J/Fu
         L6gM0Vh6gaHA/XMKgbl+eMHmlNLkwf4bMV7Z25AKizlB7EbfMG9AI8qtqgC2BceV7tKC
         fTsiKW20ZTsKmpiTWw3U9hKEzbpPT0aAsA9pNuAS24wW8Xzq0MMc+DZb6r9NquZ7G0aP
         xhT4n0Y3urKeH4EWV142GXTeGcfPIaoRUyf68z9UzI0xkn6T2rt4aMGpia067W9mFDL5
         QEvDbnqTzERANCWNUVXHmBYR4cJI3yR5yUMgZy51mEk3CRV7cVjF3gG2cgVy1abd9f/G
         47tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694807432; x=1695412232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9YBfJ4jTyz5d6/Vbwqk7jfQ5mGKuKqv2TmTIASENsk=;
        b=ZpCn1ui5aYg9A+AbDAImk9hNh3Cm86Z6n8hyeS/XzIPGAomHHJUHvtWlpZTRtMN/F1
         BPZ0PqjNxbrV30AkqjdS5V9Zi33NJ8/K5gm4qOG+rmMojDrP2uWA53GVuHdxwRYvK8qU
         O2d3gEOtyyrq8kTLPJInykwh+gV46CW0DyfewIBC7zLfp41QJy45fmQR0lOKwqzkE+Gm
         UD2KNjkCfJjG+Whuna+U37Kv1HskMZzhUBiinGaY7oMmWP5vDCZ6gDrns9w5dg6Ehoc7
         rkMcrTp4h4CdUPYS7coUOC8/fCyYv7F1EpjFlfIkkAP7WHCdO4QxlQg7jt+Yn01as/rN
         6r0w==
X-Gm-Message-State: AOJu0YxehnVTexlpGY2f2xQzwZ2jnry18moLT2In9r850yM1GkNMaPpp
        JK1H9MO1zGHCxTLZAgpqOTdNROGkeLSbz3hClxntwQ==
X-Google-Smtp-Source: AGHT+IH8/tpk4+LREFcDkUSsB4/MOavNA2fQSx1QB/5AETa1HrY6C5fiiMlv5l3Wchoxhz/ZDP4l+qm1ZwAeCN3/G5g=
X-Received: by 2002:a05:6102:2cf:b0:44d:4f8f:d8e5 with SMTP id
 h15-20020a05610202cf00b0044d4f8fd8e5mr2956308vsh.20.1694807432549; Fri, 15
 Sep 2023 12:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230814093621.23209-1-brgl@bgdev.pl> <20230814093621.23209-3-brgl@bgdev.pl>
 <875y54ci86.ffs@tglx> <CAMRc=Mfg52iqFKj0QMB55K5MCxhgPLbF-0WSRG0ktN3RbofMtQ@mail.gmail.com>
 <873507cziz.ffs@tglx> <CAMRc=MdYteOxy87jdSEvBxnN7tx_J1X2aSsRzKZ6WKL31-ipmA@mail.gmail.com>
 <87sf87aw36.ffs@tglx> <CAMRc=Mcvkjmy2F=92SWRdCKL0US_YSwsvpWjcfOH9CBGw3GB0g@mail.gmail.com>
 <87il91c04a.ffs@tglx> <CAMRc=MfB=sMEmK02Y6SaG1T4PFZW2OD+box7NNoDY3KM1AchLA@mail.gmail.com>
 <87o7ir8hlh.ffs@tglx> <CAMRc=Mf9f9MxfRY+=Et9+wO5fZr61SRthcGhoHZsJ6-x6k+BgQ@mail.gmail.com>
 <873502971b.ffs@tglx> <CAMRc=Meigus=WOGwM-fStkhtDeKyTd+9vZH19HoP+U1xpwYx9Q@mail.gmail.com>
 <87msya6wmf.ffs@tglx> <CAMRc=Md6NA6-rBWL1ti66X5Rt3C4Y2irfrSZnCo3wQSCqT6nPQ@mail.gmail.com>
 <877cpd7a96.ffs@tglx> <CAMRc=MfNaydT8gnvusKdJrNrtjKVE4LTqdanh3+WNd5QF-2q_Q@mail.gmail.com>
 <87y1hb1ckk.ffs@tglx>
In-Reply-To: <87y1hb1ckk.ffs@tglx>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 15 Sep 2023 21:50:21 +0200
Message-ID: <CAMRc=Meq6qrXsbDQiQHJ8t9tTh2V5Fb2ut6TcWYd5CKJwGBiAg@mail.gmail.com>
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

On Tue, Sep 12, 2023 at 8:17=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Wed, Sep 06 2023 at 16:54, Bartosz Golaszewski wrote:
> > On Wed, Aug 30, 2023 at 12:29=E2=80=AFAM Thomas Gleixner <tglx@linutron=
ix.de> wrote:
> >>   usb disconnect
> >>     ...
> >>       cp2112_remove()
> >>         i2c_del_adapter()
> >>           i2c_unregister_device(client)
> >>             ...
> >>             device_unregister()
> >>               device_del()
> >>                 bus_notify()            // Mechanism #1
> >>                   i2c_device_remove()
> >>                     if (dev->remove)
> >>                        dev->remove()
> >>                 ...
> >>                 device_unbind_cleanup()
> >>                   devres_release_all()  // Mechanism #2
> >>
> >>         gpiochip_remove()
> >>
> >> There are very well notifications to the drivers about unplug of a
> >> device. Otherwise this would end up in a complete disaster and a lot
> >> more stale data and state than just a procfs file or a requested
> >> interrupt.
> >
> > I'm not sure how either of the two helps here. #2 just releases
> > managed resources owned by cp2112. It can remove the domain with an
> > appropriate devm action but it won't do anything for the users of
> > interrupts. #1 is a bus notification emitted when the I2C adapter
> > exposed by cp2112 has been deleted.
>
> No. The domain is not yet gone at the point where the I2C bus
> notification happens. Look at the above invocation chain.
>
> The removal of the attached I2C devices happens _before_ the domain is
> removed. Anything else does not make sense at all.
>
> So the cleanup of those devices should free the interrupt, in the same
> way it frees other resources, no?
>
> i2c_device_remove()
>   if (driver->remove)
>     driver->remove()    // Driver specific cleanup
>
>   // Devres cleanup operating on the to be removed I2C device
>   devres_release_group(&client->dev, client->devres_group_id);
>
> So again:
>
>        cp2112_remove()
>          i2c_del_adapter()      // Cleans up all I2C users
>
>        gpiochip_remove()        // Removes the interrupt domain.
>
> So you do not need any magic bus notififications and whatever. It's all
> there already.
>

You're only talking about a situation in which the users of the
interrupts from the cp2112 GPIO chip's are I2C devices on its I2C
adapter. We can have consumers of those interrupts elsewhere. We can
have user-space watching interrupts on GPIOs (see below). They won't
get removed before the cp2112 GPIO chip, so their remove paths freeing
interrupts will not be triggered as you describe it.

> > This one in particular doesn't help us, the domain is long gone by now
> > but if I get what you mean correctly, you'd want the driver to call
> > request_irq() and then set up a notifier block for the
> > BUS_NOTIFY_UNBIND_DRIVER notification of the provider of that
> > interrupt? Doesn't that break like half a dozen of abstraction layers?
> > Because now the device driver which is the GPIO consumer needs to know
> > where it gets its interrupts from?
>
> Again. It does not. The point is that the device is removed in the
> hotplug event chain, which cleans up the associated resources.
> devm_request_irq() already takes care of that.
>

That's not always necessary. Imagine you have an interrupt handler set
up on a GPIO that is now gone. Your driver may do lots of other things
and remain functional even though this interrupt will never fire.

> > You would think that plug-and-play works well in the kernel and it's
> > true for certain parts but it really isn't the case for subsystems
> > that were not considered as very plug-and-play until people started
> > putting them on a stick. Some devices that are not typically
> > hot-pluggable - like serial - have been used with USB for so long that
> > they do handle unplugging very well. But as soon as you put i2c on
> > USB, you'll see what a mess it is. If you have an I2C device on a USB
> > I2C expander and it's being used, when you pull the plug, you'll see
> > that the kernel thread removing the device will block on a call to
> > wait_for_completion() until all users release their i2c adapter
> > references. They (the users) are not however notified in any generic
> > way about the provider of their resources being gone.
>
> So why aren't you fixing this and instead trying to implement force
> unplug mechanisms which require a pile of unholy hacks all over the
> place?
>

That's not what I'm suggesting. I've described the general model I'm
postulating. If this patch is an unholy hack, it's because I didn't
know better. Now I do, I've abandoned it two weeks ago.

> >> All hotpluggable consumers have at least one mechanism to mop up the
> >> resources they allocated. There are a lot of resources in the kernel
> >> which do not clean themself up magically.
> >>
> >
> > Yeah, hotpluggable consumers are fine. The problem here is
> > hotpluggable *providers* with consumers who don't know that.
>
> Then these consumers have to be fixed and made aware of the new world ord=
er
> of hotplug, no?
>

I've asked that question in my previous email. What do you think we
should do when a provider of a resource we're using in a driver is
gone? Let's assume, the consumer device will not get removed in the
hot-unplug chain - which is perfectly reasonable. I'm arguing that it
should receive an error code on the next call to that provider. The
alternatives I see are: force-unbind the device or notify it by some
other unspecified means and have it do what exactly?

> >> Your idea of tracking request_irq()/free_irq() at some subsystem level
> >> is not going to work either simply because it requires that such muck =
is
> >> sprinkled all over the place.
> >>
> > I was thinking more about tracking it at the irq domain level so that
> > when a domain is destroyed with interrupts requested, these interrupts
> > are freed. I admit I still don't have enough in-depth knowledge about
> > linux interrupts to understand why it  can't work, I need to spend
> > more time on this. I'll be back.
>
> There is no need for special tracking. The core can figure out today
> whether an interrupt which is mapped by the domain is requested or
> not. That's not the problem at all.
>
> The problems are the life time rules, references, concurrency etc. They
> are not magically going away by some new form of tracking.
>
> It's amazing that you insist on solving the problem at the wrong end.
>

Is it really the wrong end though? Let me give you an analogy with a
driver consuming a resource replaced by a user-space process. Let's
take a user process requesting some kernel resource by opening a
character device file. The handle the process gets will now be the
file descriptor number. The resource can be a GPIO (or even an
interrupt on that GPIO - as user-space can watch interrupts via the
GPIO character device).

Let's now assume the GPIO is on a USB expander. We now unplug it.
Should the user-space get informed about this fact with some
side-channel other than the descriptor? Or sent a signal/killed
(analogy to the removal of the device in the hot-unplug path)? Should
we set up some entirely different notification mechanism? No, the only
sane thing to do is: next time the process calls into the kernel via a
system call referencing that descriptor, it should return an error -
typically -ENODEV. If a poll() is in process, it should be woken up
with EPOLLERR. The process should then call close() on that
descriptor, putting its reference to the resource. If it doesn't, then
all it'll see will be errors. The process however can keep on living
and doing other stuff.

What should happen in the kernel is: on the unplug event we clean
everything up, leaving just the user-facing, reference-counted outer
shell. Once the last reference to struct file is put, it'll be
released. Of course not everyone does it and so user-space can crash
the kernel just by opening a character device exposed by vulnerable
subsystems, unbinding the device over sysfs and calling ioctl() or
otherwise.

My point is: the same rule should apply to in-kernel consumers. When
they request a resource, they get a reference to it. The resource is
managed by its provider. If the provider is going down, it frees the
resource. The consumer tries to use it -> it gets an error. I'm not
convinced by the life-time rules argument. The consumer is not
CREATING a resource. It's REQUESTING it for usage. IMO this means it
REFERENCES it, not OWNS it. And so is only responsible for putting the
reference.

Bartosz

> The real problem is that there are device drivers and subsystems which
> are not prepared for hotplug, right?
>
> As interrupts are only a small part of the overall problem, I'm
> absolutely not seeing how adding heuristics all over the place is a
> sensible design principle.
>
> What's so problematic about teaching the affected subsystems and drivers
> that hotplug exists?
>
> Thanks,
>
>         tglx
>
