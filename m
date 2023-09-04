Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396EA791CBB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 20:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238956AbjIDSWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 14:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjIDSWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:22:37 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913111B6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 11:22:29 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bd0bc8b429so28489001fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 11:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693851747; x=1694456547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nIQO7Ie9VkKzrMM5Wfe6jISQfV4/UOvfmz+1/s96Bf4=;
        b=UeVXo14kKHrWXwFORCAfjJAyw5tbtLRCLqzcxWFQKY8NUEci8vTj9CqOwkk6wWS3AM
         z9dN/Hyg8/r1uO8MxIdywXM/roJPk6rJkcL5FFAx29gmtaJAixLnryvp8F0T4UxSWnTc
         KHWZMZIbTFjqlFntgDczuqePJo/7OuMJgsqJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693851747; x=1694456547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nIQO7Ie9VkKzrMM5Wfe6jISQfV4/UOvfmz+1/s96Bf4=;
        b=hmg0u9DTcgvwpmpHVZMpRoa8aV3RBH0BEqDZLUhVIYUayeQVoEKOx6ED3YP0i6JZNT
         a/QfXiuuPZY+QR/rGuKw4c5ArFiT/Wroe9i3NKbHQhwk9qtvFSq+5XXxcVKgzpl043dl
         9Mun6DEZTWz9DvMstjMS6Ibf/gkRx12iq1TIRwnscUN/CgyYhCL00143xSCQ5O+jGK0D
         6GQFi+o6w2jljm3vdiUDL53Rj9aUwSDcEvSvTzWUUVXi0kgDKc4uiv9Dv8F2Qbb0GT0q
         P8dCoRfpGfl4QMrA7Sc9ESZUvgtcsblX5oyf5UIwEv0GgJTrArITPOhHNceGC33BAVMK
         8HGw==
X-Gm-Message-State: AOJu0YxOQt9yKDaK5dWqNxwGEY+YLeXxIsJGWudO6gQVuKR6jQF0UD7V
        rKl7xcZvapl7ouZBwAeeCn7A7zmj+ngV+ZIby2vNcxkq
X-Google-Smtp-Source: AGHT+IG63UEV9xCZUe1obGvy6RlgdGgKZ1MFIM7ZEQD+wlgHKGpZgzUimmM679+NO2gSp8fNhe+LCg==
X-Received: by 2002:a19:5054:0:b0:500:a2d0:51b6 with SMTP id z20-20020a195054000000b00500a2d051b6mr6117586lfj.37.1693851747435;
        Mon, 04 Sep 2023 11:22:27 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id l3-20020ac24303000000b0050097974ee0sm1851436lfh.224.2023.09.04.11.22.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 11:22:26 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5009969be25so2675005e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 11:22:26 -0700 (PDT)
X-Received: by 2002:a05:6512:488c:b0:501:b8dc:6c45 with SMTP id
 eq12-20020a056512488c00b00501b8dc6c45mr980028lfb.18.1693851746170; Mon, 04
 Sep 2023 11:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230901184136.73b2833e@xps-13> <CAHk-=wgUntc0u-6WQ9U3OmNHTqB=cZQoWcTOXaipB+gixV5NPA@mail.gmail.com>
 <20230904102819.54d95098@xps-13>
In-Reply-To: <20230904102819.54d95098@xps-13>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Sep 2023 11:22:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj44eeYipM1Qjvena4ZG66-a04AE8H_zMtv6V1WFXYZcQ@mail.gmail.com>
Message-ID: <CAHk-=wj44eeYipM1Qjvena4ZG66-a04AE8H_zMtv6V1WFXYZcQ@mail.gmail.com>
Subject: Re: [GIT PULL] mtd: Changes for v6.6-rc1
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <pratyush@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Sept 2023 at 01:28, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Back in 2020, you complained about one of my pull requests with:
>
> > You didn't even mention the stm32 controller change, which seems to be
> > the biggest individual thing in here..
>
> And indeed that was a mistake on my side, but I received that comment
> as a request for a more detailed list of what had been touched. That's
> likely an over interpretation, but it lead me to be more exhaustive so
> the "you did not mention <this>" would no longer happen.

You went from one extreme to another, and what I really would want is
a nice middle ground: mention the important things, summarize the
rest, and if something is subtle, please explain it.

Now, that "something is subtle" may not even happen most of the time -
particularly in drivers - so that is probably almost never an issue.

> About your request today, I totally get why you would like something
> more meaningful, but I don't know how to do it. Sometimes I get series
> which have a goal and I could definitely try to capture that goal in
> the summary rather than listing the patches.

Exactly. If you have a series with a goal, please mention / explain
the goal - not the details of the series.

But, as you say:

> But then, what about the
> endless list of miscellaneous patches to fix the style, the W=1
> warnings, various robot complains...

Absolutely. That's generally the bulk of any subsystem, and then all
you need to do is mention it as a kind of "this is what happened".

When I complained back in 2020, it was bvecause you didn't mention
even the big changes. Although quite often "big" changes can also just
be "a lot of cleanup", so mentioning it as such is also fine.

>  Because this is what I mostly get
> currently, and I believe there is no way you'll prefer something like
> this:
> * Fix misc typos
> * Fix misc style fixes
> * Update to newer API's
> Or maybe it is as long as the patches are trivial?

Absolutely. That's _exactly_ what I want for trivial patches
(including if it's a series of 15 trivial patches that all do the same
thing to 15 different drivers).

Instead of mentioning the individual patches, just say exactly the
above kind of "Update to new helper APIs", or "Fix warnings reported
by syzbot".

Honestly, for pure "endpoint" drivers, that's kind of the expected
explanation. Drivers themselves seldom have any conceptually big
changes, and so the above kind of things is normal and expected.  So
then you have exactly that kind of  "Fix W=1 warnings" comment without
any more specificity.

Then, occasionally you have one driver that gets a lot of work because
somebody goes in and cleans up that driver in _particular_, and so if
one particular driver stands out because a vendor (or an individual)
just decided to do a lot of spring cleaning, then you might have a
much more specific "Lots of work on cleaning up the XYZ driver"
mention.

Just as an example, let's look at some of the recent driver merges I
did, and take something like SCSI where not a lot of interesting stuff
happened. The mention was just

     "Updates to the usual drivers (ufs, lpfc, qla2xxx, mpi3mr, libsas) and
      the usual minor updates and bug fixes but no significant core changes"

and that's ok. It was a lot of small patches that didn't do anything
that you'd really care about unless you had some specific interest in
a driver.

But I mention that merge message because it is worth noting that I
actually complained a bit to James about it, because that pull also
did end up having one thing that stood out if you looked at the
diffstat: it removed the UFS HPB support entirely. Nobody *really*
cares about it (because it was never used), which was James' argument
for not mentioning it, but it's the kind of thing that *does* stand
out and might be worth mentioning even if it's just a curiosity. It's
a _conceptually_ interesting part of the pull, even if it doesn't
actually matter in the real world.

So I give that merge message as an example of both a perfectly fine
thing in general, but also as an example of "yeah, it could certainly
have been better". Just to give you kind of an idea what I'm looking
for.

And don't get me wrong: sometimes I really appreciate - and want - a
lot more. *IF* there are major ABI changes, I not only want them
mentioned, I really want them explained.

They *probably* don't actually happen for the MTD subsystem very much,
if at all, but to give an example of somebody who does do that kind of
"ABI changes that can affect a lot of other maintainers", we have
things like the VFS layer that then affects multiple different
filesystems, and then that shows up in the merge messages as big
explanations. Or new system calls, or things like that, which affect
not only the internal kernel ABI, but that actually exposes new
user-space ABI. Then the explanations can be tens of lines of "this is
what's going on".

So examples from the VFS layer on *those* kinds of changes:

    git show 475d4df82719
    git show c0a572d9d32f

and no, I do not expect the MTD drivers to ever do that.

But to give a recent example of a nice middle road from a merge I did
yesterday, look at the phy pull from yesterday, or the HID updates
from Friday. They have slightly different approaches to the summary,
but both of those make me feel like they are explaining what went on
in some simple summary without bogging down in excessive detail:"

    git show db906f0ca6bb
    git show 29aa98d0fe01

Anyway, all those examples are meant as just that - *examples*. It
obviously depends entirely on what has been going on, and different
subsystems can have very different rules. And often "core changes" to
the subsystem are much more worthy of mention than some cleanup of
individual drivers.

A merge message of just a single line of "Trivial cleanups to drivers"
can be entirely acceptable. But then I do expect to just see pretty
much completely mindless one- or few-liners.

Or a merge message might be 30+ lines of explanation, but then I do
expect it to be some major new feature or re-organization that will
affect end-users or other subsystems.

So there is no one single "correct" thing.

                  Linus
