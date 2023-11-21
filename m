Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EA17F29BF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbjKUKFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbjKUKFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:05:20 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F01B9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:05:15 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-7c4233cebddso198995241.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1700561115; x=1701165915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GVF+LG5FcUnk8Y9j01RJ8xwOSd+kWA0lh9J+UwcGDE=;
        b=PHaX/6T27UdWZQkTvQf6Hw560FpHFL6lB95cBeDovh7Bfa/ZFXJr2TTQCaCXZYRMdc
         LjNu4dfJla+glp385Ido7CzP9UqxkRbXBFTCnA5UdxB63FvtRQi4/ylD/db4AJ2OsKfC
         qac6stGgdo+tDjtqBCuZQQct1fvVmw/e6wmyCqQaTxFh7K4vE7Qrbwd68LmTsAgUnEcb
         KDmgWKoQ2hQCy819wg9nkMYrof0HMzuZK7Lsz+cO/ezcZ35TCLTe/8Rd2dyFngxKFvyx
         Hm/onh3BLNFIdqzYh0O6gIRu4Pz28Eh9kaGxVvwSH+t9+ZxKakLGEy4NEJTBb13H5n9/
         KFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700561115; x=1701165915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9GVF+LG5FcUnk8Y9j01RJ8xwOSd+kWA0lh9J+UwcGDE=;
        b=el3jOq8ZE3KszsuRGRVPBwQhQgV95cHPbwpVuuXbU3j079Lm3kOfbPFFR4wOPvBw39
         iz4pB+RUk2VWtsoQtj/2K4LmeBvjDaAiQhMKgGH0wDKMu0ureYbyjLu6+oqaA18kdn0N
         fRPX6dVhrQVdJbH81hjTktm14MW6VYcDrrU8S1aD+CcgClMeodDrA4rL1BKjFD1+U4RA
         0Iz2p6yIi1qD9J2neaVst7QD0n6eWD6ZfMaPhkGblAZU36ORpouVY4MN/sUTGR8PLkWG
         iuNqQbi3ICNxyCg3woEbkFu6e6jjpcia4cF8moPhBSYx0WsbBpN8wiVQDa/gimAn4mC2
         KHSQ==
X-Gm-Message-State: AOJu0YwaQywAtB5k4zrOJHxyiZy1kNABs4E1WuAj9Sjz2Dw/4N23CW2+
        CBYpVdGOMSGZ8uumkFwkg54Ap3xkN2Ut4AL4J0gyEg==
X-Google-Smtp-Source: AGHT+IEpIvaDN+e6sCQK0buxS4e2k57FF4FbT/Yipd658/0p7WxPX5Us7zLLxHMymtCZHfrxR2e558ZFul4XmKNrUIQ=
X-Received: by 2002:a05:6102:330f:b0:462:866e:2f2f with SMTP id
 v15-20020a056102330f00b00462866e2f2fmr5527316vsc.9.1700561114639; Tue, 21 Nov
 2023 02:05:14 -0800 (PST)
MIME-Version: 1.0
References: <CAMRc=MfvrqyAXYS0Q_ko9sYycnb-1n4Q+KjGUYBLig0BX9vDQA@mail.gmail.com>
 <CAGETcx8MNrLhoE8c0=VMc_bW0313zt+8B9w69ziYNV5ynkK8Gg@mail.gmail.com> <CAGETcx_fXa6Zt_gkTQKw8Wt11EmSt8ZQ6TxKi5P+5ii3EvwsdA@mail.gmail.com>
In-Reply-To: <CAGETcx_fXa6Zt_gkTQKw8Wt11EmSt8ZQ6TxKi5P+5ii3EvwsdA@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 21 Nov 2023 11:05:03 +0100
Message-ID: <CAMRc=Mey2DR3_gv8q1WeeuxCuwwCVeb_StvPLTzFMJ2dgK44LA@mail.gmail.com>
Subject: Re: Device links between providers and consumers
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
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

On Tue, Nov 21, 2023 at 5:53=E2=80=AFAM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> Hi Bartosz,
>
> Adding LKML so that others are aware of what the issue is and it'll be
> easier when I get to my TODO patches and send them out. I'm hoping
> that's okay with you because we didn't discuss anything confidential
> here.
>

That's alright, thanks for starting the public conversation.

> On Mon, Nov 20, 2023 at 2:21=E2=80=AFPM Saravana Kannan <saravanak@google=
.com> wrote:
> >
> > On Mon, Nov 20, 2023 at 12:38=E2=80=AFPM Bartosz Golaszewski <brgl@bgde=
v.pl> wrote:
> > >
> > > Hi Saravana,
> > >
> > > As I suspected, I couldn't observe the behavior you described during
> > > our discussion at the LPC event. I have a DT GPIO provider and a
> > > consumer referencing it by phandle. I'm unbinding the provider and th=
e
> > > consumer keeps on living, if it tries to use the GPIO, then it will
> > > enter the regular code path in GPIO for checking if the provider is
> > > there or not.
> > >
> > > Could you point me in the right direction here?
> >
> > Thanks for trying it out! Based on the code it should unbind the
> > consumers. I haven't ever tried it myself (no need for it).
>
> I took a closer look to show you where the consumer unbind is supposed
> to be done, but in doing so I think I know what issue you are hitting.
> One of my TODO items for device links should fix your problem.
>
> The force unbinding of consumers when the supplier is unbound is
> supposed to happen here:
> device_driver_detach()
> -> device_release_driver_internal()
> -> __device_release_driver()
> -> device_links_unbind_consumers()
> -> for all "active" consumer -> device_release_driver_internal()
>
> However the problem is the "if (drv)" check in __device_release_driver().
>
> This problem also exists for "class" device suppliers that don't have
> a drv. Fixing managed device links for "class" suppliers (and now, bus
> suppliers without drv) has been in my TODO list for a while.
>
> The gpio device is one of the cases of a "bus" device probing without
> a driver. A while ago, I implemented a gpio_bus_match() that'll probe
> the gpio device (so consumer probing isn't blocked) and I was trying
> to keep the boilerplate code minimalistic. So, for your test case, a
> quick test hack would be to implement an actual stub driver instead of
> using a stub bus match. That should fix your problem with the
> consumers not unbinding. I'll put up a proper fix sometime soon
> (hopefully over the holiday lulls).
>

But I don't even see any code referring to device_link in
drivers/gpio/. I see that if you get a regulator, there is a link
created between the regulator device and the consumer device in
_regulator_get() but nothing like that in GPIO.

> Btw, when we were talking in person at the LPC dinner, you were asking
> "what would you do if the supplier was an optional supplier but you
> forcefully unbound the consumer?" I have a nice answer now:
>

Actually, my question was: "what if a resource is optional and the
provider of that resource gets unbound". But below you still did
answer this question. :)

> After a force unbind, we need to add all these consumers to the
> deferred probe list and trigger another deferred probe attempt. If the
> supplier was optional, the consumer would probe again. This also has
> the nice property that the consumer doesn't advertise something to
> userspace that it can't deliver (because the supplier has gone
> missing) and it makes the error handling easier for drivers. They
> don't have to worry about suppliers vanishing in every part of their
> code. Once they get the supplier and probe successfully, they
> shouldn't have to worry about it vanishing underneath them.
>

Let me rephrase it to see if I understand it:

1. Provider is probed.
2. Consumer is probed and gets the resource from provider.
3. Provider is unbound.
4. As a result, the consumer is unbound.
5. Consumer is put into the deferred probe list.
6. Consumer binds again to its driver but this time doesn't get the resourc=
e.

It makes some sense I guess but then you have to deal with the device
disappearing for a brief moment in whatever code uses it so it's not
like it has no price over handling the provider unbind in consumers.
If you're exposing anything to user-space, you're offloading that
handling to it.

There are also two approaches to handling the providers unbinding:
returning an error from API calls vs returning 0 and doing nothing in
which case most of the consumer code can remain the same. This is what
GPIO does ATM.

> Cheers,
> Saravana
>

Is there a way for a driver to alter the behavior? For instance tell
the device core that it should not unbind it if the provider is
detached?

The behavior in general makes sense but it only applies to platform
devices on DT systems and has some corner-cases that would need to be
ironed out. What I proposed is more generic as it also covers
resources exposed to drivers or user-space from discoverable devices.

Bart

>
> >
> > Let's start with making sure the basic functionality is working in your=
 case.
> >
> > Can you check /sys/class/devlink to see if you see a folder with the
> > following name?
> > <bus:supplier>--<bus:consumer>
> >
> > Once you find it, can you cat all the file contents and tell me what
> > it says before you unbind it?
> >
> > The "status" should be "available". And "sync_state_only" should be fal=
se.
> >
> > Also, how are you unbinding the supplier? And does the board you are
> > playing with something that's upstream? Should we take this discussion
> > to LKML?
> >
> > -Saravana
