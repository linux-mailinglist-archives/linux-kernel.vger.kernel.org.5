Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7095A7983E2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 10:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbjIHISd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 04:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjIHISa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 04:18:30 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CC81BE9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 01:18:24 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D33E2FF812;
        Fri,  8 Sep 2023 08:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694161102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ogn7bkK1CCLHTP188X2Gvb5g3xCexeNHMjlI2R1KyHg=;
        b=D3jgLCezxx3ws16uOwfg6Ja/rSCx5lputbq5ZQEeUUFswjrg2y6uhV11F8mp+nm12eNl3j
        V1zqPv3BQe53q9DtNoPyNm15AQ3IOOXseMC9KpxH40weL4uFNhRWVEqrvkOvUkW3nGpRDF
        lxCXSjINPC0FsUVgl9tYXKt/SSse0aiVKo8Uas4ICjlD522D64W4OArDziVIq6gzsDcp98
        JiKQ+t1DrTI9bDS3Xnbkdi5BduypD7CGQx/KWnEC1dc5gzgyX2Rb9txzIBBAzAA7eLZIQt
        +UM7SFMZrg/ojcKmLRxdZbbjliFHMeoRMSfVNm0DWaZroF140xZ1XYFCAWgxHQ==
Date:   Fri, 8 Sep 2023 10:18:19 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <pratyush@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] mtd: Changes for v6.6-rc1
Message-ID: <20230908101819.1eb26a28@xps-13>
In-Reply-To: <CAHk-=wj44eeYipM1Qjvena4ZG66-a04AE8H_zMtv6V1WFXYZcQ@mail.gmail.com>
References: <20230901184136.73b2833e@xps-13>
        <CAHk-=wgUntc0u-6WQ9U3OmNHTqB=cZQoWcTOXaipB+gixV5NPA@mail.gmail.com>
        <20230904102819.54d95098@xps-13>
        <CAHk-=wj44eeYipM1Qjvena4ZG66-a04AE8H_zMtv6V1WFXYZcQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

torvalds@linux-foundation.org wrote on Mon, 4 Sep 2023 11:22:08 -0700:

> On Mon, 4 Sept 2023 at 01:28, Miquel Raynal <miquel.raynal@bootlin.com> w=
rote:
> >
> > Back in 2020, you complained about one of my pull requests with:
> > =20
> > > You didn't even mention the stm32 controller change, which seems to be
> > > the biggest individual thing in here.. =20
> >
> > And indeed that was a mistake on my side, but I received that comment
> > as a request for a more detailed list of what had been touched. That's
> > likely an over interpretation, but it lead me to be more exhaustive so
> > the "you did not mention <this>" would no longer happen. =20
>=20
> You went from one extreme to another, and what I really would want is
> a nice middle ground: mention the important things, summarize the
> rest, and if something is subtle, please explain it.
>=20
> Now, that "something is subtle" may not even happen most of the time -
> particularly in drivers - so that is probably almost never an issue.
>=20
> > About your request today, I totally get why you would like something
> > more meaningful, but I don't know how to do it. Sometimes I get series
> > which have a goal and I could definitely try to capture that goal in
> > the summary rather than listing the patches. =20
>=20
> Exactly. If you have a series with a goal, please mention / explain
> the goal - not the details of the series.
>=20
> But, as you say:
>=20
> > But then, what about the
> > endless list of miscellaneous patches to fix the style, the W=3D1
> > warnings, various robot complains... =20
>=20
> Absolutely. That's generally the bulk of any subsystem, and then all
> you need to do is mention it as a kind of "this is what happened".
>=20
> When I complained back in 2020, it was bvecause you didn't mention
> even the big changes. Although quite often "big" changes can also just
> be "a lot of cleanup", so mentioning it as such is also fine.
>=20
> >  Because this is what I mostly get
> > currently, and I believe there is no way you'll prefer something like
> > this:
> > * Fix misc typos
> > * Fix misc style fixes
> > * Update to newer API's
> > Or maybe it is as long as the patches are trivial? =20
>=20
> Absolutely. That's _exactly_ what I want for trivial patches
> (including if it's a series of 15 trivial patches that all do the same
> thing to 15 different drivers).
>=20
> Instead of mentioning the individual patches, just say exactly the
> above kind of "Update to new helper APIs", or "Fix warnings reported
> by syzbot".
>=20
> Honestly, for pure "endpoint" drivers, that's kind of the expected
> explanation. Drivers themselves seldom have any conceptually big
> changes, and so the above kind of things is normal and expected.  So
> then you have exactly that kind of  "Fix W=3D1 warnings" comment without
> any more specificity.
>
> Then, occasionally you have one driver that gets a lot of work because
> somebody goes in and cleans up that driver in _particular_, and so if
> one particular driver stands out because a vendor (or an individual)
> just decided to do a lot of spring cleaning, then you might have a
> much more specific "Lots of work on cleaning up the XYZ driver"
> mention.

Clear.

> Just as an example, let's look at some of the recent driver merges I
> did, and take something like SCSI where not a lot of interesting stuff
> happened. The mention was just
>=20
>      "Updates to the usual drivers (ufs, lpfc, qla2xxx, mpi3mr, libsas) a=
nd
>       the usual minor updates and bug fixes but no significant core chang=
es"
>=20
> and that's ok. It was a lot of small patches that didn't do anything
> that you'd really care about unless you had some specific interest in
> a driver.
>=20
> But I mention that merge message because it is worth noting that I
> actually complained a bit to James about it, because that pull also
> did end up having one thing that stood out if you looked at the
> diffstat: it removed the UFS HPB support entirely. Nobody *really*
> cares about it (because it was never used), which was James' argument
> for not mentioning it, but it's the kind of thing that *does* stand
> out and might be worth mentioning even if it's just a curiosity. It's
> a _conceptually_ interesting part of the pull, even if it doesn't
> actually matter in the real world.
>
> So I give that merge message as an example of both a perfectly fine
> thing in general, but also as an example of "yeah, it could certainly
> have been better". Just to give you kind of an idea what I'm looking
> for.
>=20
> And don't get me wrong: sometimes I really appreciate - and want - a
> lot more. *IF* there are major ABI changes, I not only want them
> mentioned, I really want them explained.

Duly noted.

> They *probably* don't actually happen for the MTD subsystem very much,
> if at all, but to give an example of somebody who does do that kind of
> "ABI changes that can affect a lot of other maintainers", we have
> things like the VFS layer that then affects multiple different
> filesystems, and then that shows up in the merge messages as big
> explanations. Or new system calls, or things like that, which affect
> not only the internal kernel ABI, but that actually exposes new
> user-space ABI. Then the explanations can be tens of lines of "this is
> what's going on".
>=20
> So examples from the VFS layer on *those* kinds of changes:
>=20
>     git show 475d4df82719
>     git show c0a572d9d32f
>=20
> and no, I do not expect the MTD drivers to ever do that.
>=20
> But to give a recent example of a nice middle road from a merge I did
> yesterday, look at the phy pull from yesterday, or the HID updates
> from Friday. They have slightly different approaches to the summary,
> but both of those make me feel like they are explaining what went on
> in some simple summary without bogging down in excessive detail:"
>=20
>     git show db906f0ca6bb
>     git show 29aa98d0fe01

That one mentions the main authors, I believe there is no added value
doing this as it takes time to write and would be easily catch with a
git log.

But otherwise, I think I get what you expect.

> Anyway, all those examples are meant as just that - *examples*. It
> obviously depends entirely on what has been going on, and different
> subsystems can have very different rules. And often "core changes" to
> the subsystem are much more worthy of mention than some cleanup of
> individual drivers.
>=20
> A merge message of just a single line of "Trivial cleanups to drivers"
> can be entirely acceptable. But then I do expect to just see pretty
> much completely mindless one- or few-liners.
>=20
> Or a merge message might be 30+ lines of explanation, but then I do
> expect it to be some major new feature or re-organization that will
> affect end-users or other subsystems.
>=20
> So there is no one single "correct" thing.

I believe I get the idea. I will try to match your expectations in my
next pull requests, please do not hesitate to share your thoughts if
you think it could be further improved in a specific way.

Thanks,
Miqu=C3=A8l
