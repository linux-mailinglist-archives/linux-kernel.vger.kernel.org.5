Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2777578EC23
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239056AbjHaLhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjHaLho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:37:44 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAFBAB
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 04:37:41 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d7e387c33f3so454097276.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 04:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693481859; x=1694086659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lypt1ExDbkEeEChHfWqa/VhxnyCI/TkoTn/TCNMR5X8=;
        b=R2JGTmkbBgl3zqlkmLHoy2ank7534YpjhfaQs028wD55qijwQmFc2vDYtefr39KsrU
         4olE/2Lp8pueYwXJK3Nsh/Pev7QqmbfKYvRWgkwMCgkBu2UJ4lERZAsZR+HBuFy93vLY
         RQgAQi38Sd4QCviiZwyvgBc26ymGDnjm+nEoGOkYBgUGhyazg5PoGabxinPEtSaTjj8u
         Vg7+NTX8b3EOM+oE0Kkf1er80WoLlXNkz1EIgLcEvsm4P6Akp82Z+PfdyrkFvTxNSW2M
         CxfpnJ9hvmRF5KSC1BezYmVTmt/MSMxeKDOVifWQkiBxbdpwKSfMbBvmiNuSFrVf74Hz
         3itw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693481859; x=1694086659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lypt1ExDbkEeEChHfWqa/VhxnyCI/TkoTn/TCNMR5X8=;
        b=PYP3BPcrowpAPQ+Nh7mXUEUWEjrbaFel4oc1V+cG2wjomZxOsFV/DRB6FP+8wsbi6/
         kvCGNN21wp1I5r/Xp6sJ9k7ae0naShfb5NYfxZvFRgNMMvpA2m/yFnQZeDbL/6njPkO2
         16mkrMyNtxeEYKqfDpWMcQekHBCcNkje06l1FaCuMrBYjQxabDINZy0Aa/kZOwPU2NJC
         WRL0KtXN3diUuEoPGGX31P5J36ppyOSgqRZnHEfrolAWW0F5eJb5Z2vxbeHP3IWlKku0
         dWtWgVP6qNnytM3MVV8ZjpmuRYOGgAT1SyDkjtJe+rsAhGtwPh22XOTDXbyYKjM6cz+4
         QKCA==
X-Gm-Message-State: AOJu0YwZvZPfpnYfteJxotikSE4ypPLbw1XgMge0xlGrH3PiC1tonuj3
        U2umc33sd/clNSNUfesoN11zo3ibyp7WmHlq/z/e3A==
X-Google-Smtp-Source: AGHT+IGBvK3EVwNwH9rlAiV5YEc2n1O3boSOPFtTlRByjOV/DKA4yqbSCqz3ilp2WwhzpF6hM6wL2mYOd3TXCTemySw=
X-Received: by 2002:a25:fc21:0:b0:d0e:99be:5da2 with SMTP id
 v33-20020a25fc21000000b00d0e99be5da2mr4719634ybd.65.1693481859667; Thu, 31
 Aug 2023 04:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230829213441.310655-1-ulf.hansson@linaro.org>
 <CAHk-=wg0gc4Cc90OL29Vr5gDtd4mnsKD+TxtoNtQbAryaWHkZQ@mail.gmail.com>
 <CAHk-=wjLO=Jsdk2prq0piznMMCk+V0_fRaFRHEPuaALpF8J=hw@mail.gmail.com>
 <96bb0de0-06d9-46f8-b02f-dc924afff13c@app.fastmail.com> <CAHk-=wi5Lh-NG_rvcx3Zyqd2Uhj76G4V73tWCFULhVzOU6e1xg@mail.gmail.com>
 <CAPDyKFrJH-1uaPCwnWZDPi4MRtOm=N2CHSRyvjXRDbQ1y-oOrw@mail.gmail.com> <CAJZ5v0hqWYnkNXVju3U3n-9i8eqtjs197tLLNWv8Qa_N9T=KEw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hqWYnkNXVju3U3n-9i8eqtjs197tLLNWv8Qa_N9T=KEw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 31 Aug 2023 13:37:03 +0200
Message-ID: <CAPDyKFpXLj_2HAgyV_VJf+GPQVmxb_iiDe77Q2MY17MDNqy9fA@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC/genpd driver updates for v6.6
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 at 11:33, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Aug 30, 2023 at 10:34=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.=
org> wrote:
> >
> > On Wed, 30 Aug 2023 at 03:20, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Tue, 29 Aug 2023 at 17:48, Arnd Bergmann <arnd@arndb.de> wrote:
> > > >
> > > > How about moving it to drivers/power/domain/ instead?
> > >
> > > That sounds like a sensible name and would seem to fit logically with
> > > our existing tree structure quite well.
> >
> > I am sincerely sorry if I have annoyed you with picking the name
> > "genpd" as the directory-name - and especially without further
> > explanation. The genpd thing certainly deserves to be documented
> > better, I will try to get some time to do this soon. Anyway, me and
> > many others in the power/performance areas that have been working with
> > the genpd interface, have simply gotten comfortable using the "genpd"
> > acronym. Hence, the naming was a no-brainer to me.
> >
> > That said, if you feel that the above directory-path/name is a better
> > fit I can certainly move it over there, np! Although, before you make
> > the final decision I want to point out a few things for you to
> > consider.
> >
> > *) The new subsystem is solely intended for the generic PM domain
> > providers. Other PM domains providers, like the ACPI PM domains for
> > example (drivers/acpi/*), don't really belong here, at least in my
> > opinion. So, maybe "domain" isn't specific enough? Although, if not
> > using "genpd", I have no better suggestion.
> >
> > **) Please keep in mind that we have several other power/performance
> > related subsystems that don't live under drivers/power/*. Moving more
> > things in there is not really going to help the people that work on
> > these things. No matter where and what the name of the subsystem is,
> > one simply needs to dive into the details anyway. Moreover, in this
> > case, "genpd" isn't just about "power" (idle management) but
> > performance management too.
> >
> > >
> > > > I don't think we can easily rename the interfaces that have been
> > > > in use for the past 12 years
> > >
> > > I actually think the interface names are much less of an issue, since
> > > anybody using them is presumably familiar with the naming.
> > >
> > > It was only with the directory structure that I reacted to it, becaus=
e
> > > that kind of exposes the naming to people who definitely are *not*
> > > familiar with it (ie me, but presumably anybody else who sees the
> > > diffstats etc fly past).
> > >
> > > And yes, we have a number of other pretty obscure driver names in our
> > > tree (I end up having to remind myself what "ntb" and "hsi" etc mean)=
,
> > > and I don't tend to love them either, but at least they tend to be
> > > industry / vendor names.
> >
> > I get your point. I was indeed trying to obey the current naming
> > strategy, but I think it's not entirely easy to understand what is
> > prefered.
> >
> > Please advise me on how to move forward.
>
> If I may suggest something, I would call this "pmdomain" instead of
> "genpd".  I don't think that /drivers/power/ is a particularly
> suitable location for it, because it doesn't really have much to do
> with power supplies and more to do with device PM.

"pmdomain" is probably giving a reasonable good hint of what goes on
in this subsystem. This works fine for me, thanks!

>
> Also, I would move drivers/base/power/domain.c to drivers/pmdomain/
> (and rename it to something like core.c), because it would be a better
> location for that fiile IMO.

We could certainly do that, let's discuss it a bit more.

Although, at this point I want to focus on the genpd providers, as to
release some of the burden from arm-soc maintainers.

>
> I can also handle future pull requests for this if that's fine with every=
one.

Thanks a lot for your offer! However, if a re-route is preferred (I
think not?), this is probably better suited via arm-soc, as most
changes are going to be arm platform specific.

Kind regards
Uffe
