Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C516751395
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 00:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjGLWc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 18:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjGLWcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:32:25 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FF41BC6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:32:23 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-57712d00cc1so87450677b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689201142; x=1691793142;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Wwa1hD9MkOtEqE1XJLWsiJmrcHA6Lsvu6NRib9qh2w=;
        b=JBXklJCNRZoeqlywb5OboeIO8iwtZZnmITnWXiIqERv05omQ80fkMAurN9CCOqHdTX
         YqLlTHU9akfYMclShk8aB1Tk/fck81BX7ItZTZAK79afhoCuc7QyI6QZ5v2O7HCF7qw/
         sTYwWbFErk8FqjMtdMqjwmXskdlGMyJbGtNHOczNY3gVSOicj42JMJ62wlq1kOsjz5Uk
         Y0jTjy9n37qxY6P0tewluw9BGowiu1s0ULr9HQcXOt+AB0WGM3/6JhUa/WDQYRNbzLtr
         D1imLg1XFUpHG1LehMQQBmXiZJo6zxjOi21Nmv3WzMaZP5XHmu/nbX//hL2XPXzxAth3
         LhPQ==
X-Gm-Message-State: ABy/qLbso+Gvn7ybq/pSAXm9COd1kKt9swtHuZpqh0yuiyrs5sq7ZEwt
        G0pX9RlvZOOMNTgQ/fvkQ8m+Y3p+mvGuCg==
X-Google-Smtp-Source: APBJJlEWJIwqQ5QiIkX2cZsSb5LSvUc2HIcy+IN9fiYTGhsPLbAuXcj2DQkXoAVhYqPjHkwMcAK9SA==
X-Received: by 2002:a0d:d7cf:0:b0:579:e318:4c01 with SMTP id z198-20020a0dd7cf000000b00579e3184c01mr22303824ywd.19.1689201141883;
        Wed, 12 Jul 2023 15:32:21 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id h83-20020a815356000000b005707d7686ddsm1437043ywb.76.2023.07.12.15.32.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 15:32:21 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-579ef51428eso87577457b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:32:20 -0700 (PDT)
X-Received: by 2002:a0d:e884:0:b0:56f:ff55:2b7d with SMTP id
 r126-20020a0de884000000b0056fff552b7dmr22576017ywe.17.1689201140148; Wed, 12
 Jul 2023 15:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230712132840.GKZK6qiK70m1O90jFL@fat_crate.local>
 <ZK6zdsIbnQFUmK69@redhat.com> <2023071200-unopposed-unbuckled-cde8@gregkh>
 <CAMw=ZnTVRaqRmtz+sDj7AeAS7xivSu+56UgKbzmuW9+K6TTx1A@mail.gmail.com>
 <2023071239-progress-molasses-3b3d@gregkh> <CAMw=ZnRheXk7W_r-32bGymbHKdXc7aKUpwGAOX+k7DJkN+DiCQ@mail.gmail.com>
 <2023071229-dusk-repacking-da3a@gregkh> <CAMw=ZnSmZTBs+bJsQ_Y2CVO8K3OTuHOZDKW4cbxKpGbo4Vgs7Q@mail.gmail.com>
 <2023071226-crafty-deviator-12e2@gregkh> <CAMw=ZnRjnxWnmoFuw2prxFS55vAGQ1hpfKeHYFfG5Oa0LB_jYA@mail.gmail.com>
 <20230712211259.GA8942@1wt.eu>
In-Reply-To: <20230712211259.GA8942@1wt.eu>
From:   Luca Boccassi <bluca@debian.org>
Date:   Wed, 12 Jul 2023 23:32:08 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnSKSSaTNNYwOTc1iVkG9gXYUMG5ZY_QvKsnr8QBPAH8SA@mail.gmail.com>
Message-ID: <CAMw=ZnSKSSaTNNYwOTc1iVkG9gXYUMG5ZY_QvKsnr8QBPAH8SA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
To:     Willy Tarreau <w@1wt.eu>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, lennart@poettering.net,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 at 22:22, Willy Tarreau <w@1wt.eu> wrote:
>
> Hello,
>
> On Wed, Jul 12, 2023 at 09:41:23PM +0100, Luca Boccassi wrote:
> > > Also note that "single identifiers for individual issues" do NOT work
> > > for kernel fixes (and arguably do not work for any other software
> > > project either) as they fail to properly describe things.
> > >
> > > Think about Meltdown, one "identifier" of a CVE, and hundreds of
> > > patches.  What if you happened to not backport one of them?
> > >
> > > Same goes for the issue reported last week or so, tens of fixes, over
> > > multiple stable kernel releases, for one "identifier", how would you
> > > have classified that?
> > >
> > > Anyway, I've been over this loads before, giving whole talks about this,
> > > there's a reason the kernel developers don't mess with CVEs (i.e.
> > > individual identifiers), they fail to work.
> >
> > There is no 'single identifier for individual issues' nor CVE involved
> > here. The purpose of the generation id (which is per EFI component,
> > not per bug) is to let the boot process know whether an EFI component
> > should be accepted or rejected, in a way that doesn't exhaust nvram.
> > Issues are not individually singled out, and there is no direct
> > correlation with CVEs. It doesn't matter how many fixes there are, or
> > how many bugs, if a generation of a component is vulnerable in any way
> > that matters, then it gets denied.
>
> I refrained from chiming in but I'm really reading shocking stuff here,
> so please let me make a few comments based on some old experience.
>
> Several times in this thread you seemed to imply that there is "someone" or
> "something" that knows whether or not a kernel is absolutely vulnerable
> or absolutely trustable regarding a certain bug, when developers
> themselves only have an estimate about it, whose probability quickly
> fades away with the depth of backports.

There is no such implication. This is about _known_ good state,
nothing absolute about that.

> When I was in charge of extended 2.6.32 many years ago, the Debian kernel
> team helped me by occasionally sending me series of backports of fixes
> for issues I had missed, and fixes for backports I had failed. That's the
> principle of maintenance: adding incremental fixes that make the whole
> code better.
>
> With your process (OK you said it's not yours, but then why adopt it when
> it doesn't match the workflow of the software it tries to adapt to), how
> would we proceed ? "Let's bump this ID now that the new 2.6.32.233 has
> everything fixed". Or rather "let's *not* bump it because nobody knows
> how to backport this other stuff that's blocking the ID increment". Then
> once finally bumped, one month later we figure that the fixes were still
> incorrect due to important differences in the older branches, and have
> to be fixed again, so according to what I understand, we must then
> immediately revoke the current ID, that is also shared by upstream and
> all correctly fixed maintenance branches, and have to emit a new one
> for all branches at once even if the code didn't change, just because
> myself incompetent stable maintainer of the week-end failed to fix
> something non-obvious at once ? If so, I'm sorry but this is non-sense.
> There must be another approach to this or it was designed by someone
> having never met a bug in person!

The other approach is fine-grained revocations, but as already
explained that's the status quo and demonstrably cannot work for this
problem. Coarse-grained revocations have some drawbacks, and yes if
you screw up hard enough it might need a re-roll, and if the screw up
is really bad and in an upstream component, then everyone gets a
do-over. Though luck! Screw ups happen, but they are not the end of
the world. Guess what, that happened in Debian - the downstream Grub
generation id was bumped but due to tooling issues the actual binaries
did not have the required patches applied, so another bump was needed
immediately after. I can confirm that the sky did not fall as a
consequence of that. Besides, the vast majority of the work involved
here is with the people doing tracking and coordination, not with
kernel developers, that's the good news for you.

You could devise a scheme, still allowed by the protocol, where each
branch gets its own component name, so they all have separate
generation ids. Here's one of the problems with that: instead of being
(for all intents and purposes) fixed in size, the revocation list
would instead grow by (number of releases) * (number of distributions)
lines every year, forever. It would also require a lot more
coordination and tracking work. Is it possible? Yes. Is it worth it
just to answer a strawman case? No.

> What I'm also wondering is, if in the end it turns out that only the
> distro has the skills to decide which kernel version is fixed and which
> one isn't (after all, it's the distro who chooses the config and the
> compiler, both are as much involved in bugs as the code itself), then
> why not make sort of a wrapper or an envelope around an existing kernel
> image, which provides this ID that the distro can freely choose, then
> transfer the control to the embedded kernel image ? This might give
> the distro the freedom to proceed as it wants with no cross-dependency
> on kernel branches.

The issue there is tracking - revocations are global, not per-distro.
So you need to ensure that the upstream component generation id is the
same everywhere. What's the best way to ensure this coherency, if not
by storing it in the upstream component tree directly? Of course it
can be patched downstream, but that imposes a lot of busywork on
everyone since they'll need out-of-band management. While if you don't
care about security, secure boot and/or sbat upstream, it costs
nothing to have it, apart from applying patches when they are sent.

> > > Pointing to an external document that is thousands of lines long,
> > > talking about bootloaders, is NOT a good way to get people to want to
> > > accept a kernel patch :)
> >
> > Then how about just asking for that? "Hello submitter, please send a
> > v2 with a detailed summary of the problem being solved for those of us
> > who are not familiar with it, thank you"
>
> Probably that there was a problem with process in the first place by
> which someone asks some maintainers to accept to merge, maintain and
> become responsible for breaking changes they disagree with, without
> having even being presented to them before being developed ?

I don't think that's what [RFC] means.
