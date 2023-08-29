Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D81F78BE64
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjH2G0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjH2G0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:26:52 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2446218F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 23:26:49 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-48d0bc6a834so1100879e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 23:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1693290408; x=1693895208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hxh5aXZyDJVdQDQmq6WXKz3ahyaBB0XCxjT8xagUqKs=;
        b=cevzkjgpF014J3qAoDByxwpexi2vC4Fh1LPplrTzbeyay9/3uiXWQEJu0cmBD67TPU
         Ft6ztlJMr6+I69td+1Mt/0pNsEGtBay8coUs5dKG18F81mx7VbDb2ov1geonjJkSWM07
         QNImeuMwH45OUQugtmj7n7otYvUpR1UG6SBvPtv5LmhloX3+4FcXNd0Z4B1ffLlB2LWC
         80cUXnV4iLbPLvEc7DGdOOyQeHb2Io5S0STwziyrJqQY78IlBwD9x3ICz7NVr+TL5pir
         WCQNb44dsTkb/LTmMBwl0BNBP5oGLi2xz8uNxz6Ejd45/ZBqA5GlMzOrz9uoYB1vWp+Y
         gnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693290408; x=1693895208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hxh5aXZyDJVdQDQmq6WXKz3ahyaBB0XCxjT8xagUqKs=;
        b=JCH2RxFQo3htuQyin/j50ZwE8FPa7AA8XRMobhVy7F4DusKdyLPgBZBek9v53Ci2SN
         kkYknX/mEwX8zu2aUhfbyuQNptxrnmQD+zqu4cu9Z6TIdLSrm9SZa6T2mCVL8WJ/qfir
         KVdbBd9DE4aabAuLf3WpIfnZEVk0TLZCwUlPX+8Ib6fYIOz8IGxTmVbcSCfjTW60nAI5
         tTEwiwmVLEly94CS6TaqcJ9HVxKaOvOdW9647kQt32XOjnljSPlBHCFyip+dHZwzE19z
         4JWZZ4ETE3yN0AHqJv5YmSa5haVgLxXrlALE7Lzbnl/6LuEOpGUdVRS4ywls+lzM0JZ8
         rBVQ==
X-Gm-Message-State: AOJu0Yzljqce9uUEXoT1J02YCA2OCOEHsHdir0YjjaEep9NtVbPFagPx
        VtmfVrbqvUnnFuE5g8Wf8+FNpSbix5PEJZYd3qISo7apZNBmKm7Jn68=
X-Google-Smtp-Source: AGHT+IFFwOEazxtUKsztWvVMws3hiEMVdSKzhtzMbh3RSXZOO339gVy/Bol44R3KJlswcslDT3Op6lXYmVW0JQESSPA=
X-Received: by 2002:a1f:ed43:0:b0:48f:895f:45da with SMTP id
 l64-20020a1fed43000000b0048f895f45damr18746586vkh.14.1693290408228; Mon, 28
 Aug 2023 23:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230814093621.23209-1-brgl@bgdev.pl> <20230814093621.23209-3-brgl@bgdev.pl>
 <875y54ci86.ffs@tglx> <CAMRc=Mfg52iqFKj0QMB55K5MCxhgPLbF-0WSRG0ktN3RbofMtQ@mail.gmail.com>
 <873507cziz.ffs@tglx> <CAMRc=MdYteOxy87jdSEvBxnN7tx_J1X2aSsRzKZ6WKL31-ipmA@mail.gmail.com>
 <87sf87aw36.ffs@tglx> <CAMRc=Mcvkjmy2F=92SWRdCKL0US_YSwsvpWjcfOH9CBGw3GB0g@mail.gmail.com>
 <87il91c04a.ffs@tglx> <CAMRc=MfB=sMEmK02Y6SaG1T4PFZW2OD+box7NNoDY3KM1AchLA@mail.gmail.com>
 <87o7ir8hlh.ffs@tglx> <CAMRc=Mf9f9MxfRY+=Et9+wO5fZr61SRthcGhoHZsJ6-x6k+BgQ@mail.gmail.com>
 <873502971b.ffs@tglx>
In-Reply-To: <873502971b.ffs@tglx>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 29 Aug 2023 08:26:37 +0200
Message-ID: <CAMRc=Meigus=WOGwM-fStkhtDeKyTd+9vZH19HoP+U1xpwYx9Q@mail.gmail.com>
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

On Mon, Aug 28, 2023 at 11:44=E2=80=AFPM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> On Mon, Aug 28 2023 at 21:03, Bartosz Golaszewski wrote:
> > On Mon, Aug 28, 2023 at 2:41=E2=80=AFPM Thomas Gleixner <tglx@linutroni=
x.de> wrote:
> >> > I guess you're referring to irq_alloc_descs()? Anyway, here's a
> >> > real-life example: we have the hid-cp2112 module which drives a
> >> > GPIO-and-I2C-expander-on-a-USB-stick. I plug it in and have a driver
> >> > that requests one of its GPIOs as interrupt. Now I unplug it. How ha=
s
> >> > taking the reference to the hid-cp2112 module protected me from
> >> > freeing an irq domain with interrupts in use?
> >>
> >> request_irq() does not care which module request the interrupt. It
> >> always takes a refcount on irq_desc::owner. That points to the module
> >> which created the interrupt domain and/or allocated the descriptors.
> >>
> >> IOW, this needs a mechanism to store the module which creates the
> >> interrupt domain somewhere in the domain itself and use it when
> >> allocating interrupt descriptors. So in your case this would take a
> >> refcount on the GPIO module.
> >>
> > This is still not complete. In the above example, the USB bus can
> > still unbind the GPIO device that created the domain on hot-unplug,
> > triggering its cleanup routines (.remove(), devres chain) and
> > destroying the domain and keeping the reference to the hid-cp2112
> > module will not help it. This is why I suggested tracking the irq
> > requests and freeing them in said cleanup path.
>
> Are you actually reading what I write?
>
> >> So in your case this would take a refcount on the GPIO module.
>
> That's the module which provides the interrupt domain and hid-whatever
> is the one which requests the interrupt, no?
>

Not at all! This is what I said: "we have the hid-cp2112 module which
drives a GPIO-and-I2C-expander-on-a-USB-stick". Meaning: the
hid-cp2112 module registers a USB driver for a GPIO expander on a
stick. This GPIO chip is the interrupt controller here. It's the USB
stick that provides interrupts for whatever else needs them (in real
life: it can be an IIO device on the I2C bus which signals some events
over the GPIOs). The user can get the interrupt number using the
gpiod_to_irq() function. It can be unplugged at any moment and module
references will not stop the USB bus from unbinding it.

Bartosz
