Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A02778E977
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 11:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245417AbjHaJdO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 31 Aug 2023 05:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244669AbjHaJdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 05:33:13 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5494CED;
        Thu, 31 Aug 2023 02:33:10 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6b9cd6876bbso224365a34.1;
        Thu, 31 Aug 2023 02:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693474390; x=1694079190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nl1K4yYAIDgYQbgietNrYp754cjHjZdTyKlafeP/4n8=;
        b=HMJWQLgKwr5OOt9/6z02fdCy/dX3XSWLgskoy248TVt+Q5LTFuB1Kgkh4s+4G1EcIc
         9Eeyldl1uTotR81Bg+p08w7HpyRlrGsHHQS4QcDxuVQ2qh4SENWaTJ5C8scT+yZDNCQq
         oSs+rYZjPZ0iSYAvdpZFEHaBtGTf2rhiyUQBn2gz/nLAwpVlV3Omm/5/UgUJvjbiP49S
         DUgen+YJueSbzp+qvLIuyLzGvVEm+RVcJs7kMGKH56Zbuce6/EUTAlib862wBgwL7rbg
         N9IryZ5NiHhS7O9NlObY/zmlulu4xfmVL069DvqWRoY0/M79LkNkgO7F2tRTVvGBpiuw
         1ERA==
X-Gm-Message-State: AOJu0YyDlWgp3VDy7x+n+H8Yo+0bSrzEejlmkLYibXuOqpHCW7drj2HM
        jiVeI+6wbX/RsSSz200HNu4rowV5yaGCBOCMs5U=
X-Google-Smtp-Source: AGHT+IGTX1BhrCY8B/1eA+vI1+888PczPza8yfMwZBebL/g+Y6xUSxGjKfo4zaOwCE0xXYnXdxYsp9+w7W2j7y4/gLE=
X-Received: by 2002:a05:6820:1b18:b0:56e:94ed:c098 with SMTP id
 bv24-20020a0568201b1800b0056e94edc098mr4892136oob.0.1693474389861; Thu, 31
 Aug 2023 02:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230829213441.310655-1-ulf.hansson@linaro.org>
 <CAHk-=wg0gc4Cc90OL29Vr5gDtd4mnsKD+TxtoNtQbAryaWHkZQ@mail.gmail.com>
 <CAHk-=wjLO=Jsdk2prq0piznMMCk+V0_fRaFRHEPuaALpF8J=hw@mail.gmail.com>
 <96bb0de0-06d9-46f8-b02f-dc924afff13c@app.fastmail.com> <CAHk-=wi5Lh-NG_rvcx3Zyqd2Uhj76G4V73tWCFULhVzOU6e1xg@mail.gmail.com>
 <CAPDyKFrJH-1uaPCwnWZDPi4MRtOm=N2CHSRyvjXRDbQ1y-oOrw@mail.gmail.com>
In-Reply-To: <CAPDyKFrJH-1uaPCwnWZDPi4MRtOm=N2CHSRyvjXRDbQ1y-oOrw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 31 Aug 2023 11:32:57 +0200
Message-ID: <CAJZ5v0hqWYnkNXVju3U3n-9i8eqtjs197tLLNWv8Qa_N9T=KEw@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC/genpd driver updates for v6.6
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 10:34 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 30 Aug 2023 at 03:20, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Tue, 29 Aug 2023 at 17:48, Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > How about moving it to drivers/power/domain/ instead?
> >
> > That sounds like a sensible name and would seem to fit logically with
> > our existing tree structure quite well.
>
> I am sincerely sorry if I have annoyed you with picking the name
> "genpd" as the directory-name - and especially without further
> explanation. The genpd thing certainly deserves to be documented
> better, I will try to get some time to do this soon. Anyway, me and
> many others in the power/performance areas that have been working with
> the genpd interface, have simply gotten comfortable using the "genpd"
> acronym. Hence, the naming was a no-brainer to me.
>
> That said, if you feel that the above directory-path/name is a better
> fit I can certainly move it over there, np! Although, before you make
> the final decision I want to point out a few things for you to
> consider.
>
> *) The new subsystem is solely intended for the generic PM domain
> providers. Other PM domains providers, like the ACPI PM domains for
> example (drivers/acpi/*), don't really belong here, at least in my
> opinion. So, maybe "domain" isn't specific enough? Although, if not
> using "genpd", I have no better suggestion.
>
> **) Please keep in mind that we have several other power/performance
> related subsystems that don't live under drivers/power/*. Moving more
> things in there is not really going to help the people that work on
> these things. No matter where and what the name of the subsystem is,
> one simply needs to dive into the details anyway. Moreover, in this
> case, "genpd" isn't just about "power" (idle management) but
> performance management too.
>
> >
> > > I don't think we can easily rename the interfaces that have been
> > > in use for the past 12 years
> >
> > I actually think the interface names are much less of an issue, since
> > anybody using them is presumably familiar with the naming.
> >
> > It was only with the directory structure that I reacted to it, because
> > that kind of exposes the naming to people who definitely are *not*
> > familiar with it (ie me, but presumably anybody else who sees the
> > diffstats etc fly past).
> >
> > And yes, we have a number of other pretty obscure driver names in our
> > tree (I end up having to remind myself what "ntb" and "hsi" etc mean),
> > and I don't tend to love them either, but at least they tend to be
> > industry / vendor names.
>
> I get your point. I was indeed trying to obey the current naming
> strategy, but I think it's not entirely easy to understand what is
> prefered.
>
> Please advise me on how to move forward.

If I may suggest something, I would call this "pmdomain" instead of
"genpd".  I don't think that /drivers/power/ is a particularly
suitable location for it, because it doesn't really have much to do
with power supplies and more to do with device PM.

Also, I would move drivers/base/power/domain.c to drivers/pmdomain/
(and rename it to something like core.c), because it would be a better
location for that fiile IMO.

I can also handle future pull requests for this if that's fine with everyone.

Cheers!
