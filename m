Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F4E78DE6A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241540AbjH3TC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242451AbjH3IeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 04:34:17 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2161AE
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 01:34:14 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d78328bc2abso4855545276.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 01:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693384453; x=1693989253; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xtdiwzQL21GYKlHw5/D0J/VmrjrErWbcUTzSWFrSXes=;
        b=E31HCfg4sYIGJhKfH+dTdWkW/as60UvLx0i9dXIXYGpR/9tE95609GhbwPXhSbQXxf
         /oVIC4+BI9gX1NsnGcCMu7KIw0X1TT5fDFkvfPuhimQq3SorpDixiBch3zrsIvwey6Jz
         7qvxtenDcFkAclg5Nqk6XIkzS2IBfQQEmqIMzs6P5nVDEvPOgSsqvmxs32H9XsB8qA/Q
         6IM/i6/CmzSPdwE1CXEGC0CuDxf0yqLCgGmYx9Gt2Jln8LSaSCybfvNRAE4qYDRFh+wP
         ZvWej/Kee/HP005BFtYfHuI5WuC5qxG1btSvzxLQuX8Cm9fNHM99qWskiZvFNhD+tG7M
         GPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693384453; x=1693989253;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xtdiwzQL21GYKlHw5/D0J/VmrjrErWbcUTzSWFrSXes=;
        b=JSSs9RmvHNt/ercrEK8mcV6bKMv9eAZCBLdb/4BYIVylmBp5elzCkaTveyLRoD2cVK
         ZRnuTAKqJiP25rZkbLiSAhKeFGHDmCOrnyKE7fjfFgTsxswbd1VTdvKwNOhRFKvKgXle
         kFwv7ALkh/s81Sx02euE5t46kGfIHu+W8p9lRvyoAj8vEQoBiPuHw3UrQ3Rv9kArfmDp
         j1khRR1+goSa3P74hL84UO9XUjDxYDYBavxHPbwigrqXkVYi+eyOUR6FPVNQNtxABZs5
         EAlGBd/oOCSPUNM8j4kwhNv3j2e66XFLmABckTGLGeyDF6QksPoWwyRcyWaQYW2Y/f+L
         9T5g==
X-Gm-Message-State: AOJu0YwXidds+WR1+HPR1QAsR1TMg1uqjCVLJM9j4y1lviI9aSu0IA07
        X5lixhlXPs32MeM3rKdoNHfpOTfoCY8FHMwoefE1NA==
X-Google-Smtp-Source: AGHT+IGtJWftzWF4BAzABxuDQ6HGZfR/UnHG8Az6ZEx5vM7b+S86qvW3j5sh8nuhOsKgT8Zm9TWVIp5MYnP+H44iMh4=
X-Received: by 2002:a25:6944:0:b0:d53:f98f:8018 with SMTP id
 e65-20020a256944000000b00d53f98f8018mr1490963ybc.65.1693384453468; Wed, 30
 Aug 2023 01:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230829213441.310655-1-ulf.hansson@linaro.org>
 <CAHk-=wg0gc4Cc90OL29Vr5gDtd4mnsKD+TxtoNtQbAryaWHkZQ@mail.gmail.com>
 <CAHk-=wjLO=Jsdk2prq0piznMMCk+V0_fRaFRHEPuaALpF8J=hw@mail.gmail.com>
 <96bb0de0-06d9-46f8-b02f-dc924afff13c@app.fastmail.com> <CAHk-=wi5Lh-NG_rvcx3Zyqd2Uhj76G4V73tWCFULhVzOU6e1xg@mail.gmail.com>
In-Reply-To: <CAHk-=wi5Lh-NG_rvcx3Zyqd2Uhj76G4V73tWCFULhVzOU6e1xg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 30 Aug 2023 10:33:37 +0200
Message-ID: <CAPDyKFrJH-1uaPCwnWZDPi4MRtOm=N2CHSRyvjXRDbQ1y-oOrw@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC/genpd driver updates for v6.6
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2023 at 03:20, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 29 Aug 2023 at 17:48, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > How about moving it to drivers/power/domain/ instead?
>
> That sounds like a sensible name and would seem to fit logically with
> our existing tree structure quite well.

I am sincerely sorry if I have annoyed you with picking the name
"genpd" as the directory-name - and especially without further
explanation. The genpd thing certainly deserves to be documented
better, I will try to get some time to do this soon. Anyway, me and
many others in the power/performance areas that have been working with
the genpd interface, have simply gotten comfortable using the "genpd"
acronym. Hence, the naming was a no-brainer to me.

That said, if you feel that the above directory-path/name is a better
fit I can certainly move it over there, np! Although, before you make
the final decision I want to point out a few things for you to
consider.

*) The new subsystem is solely intended for the generic PM domain
providers. Other PM domains providers, like the ACPI PM domains for
example (drivers/acpi/*), don't really belong here, at least in my
opinion. So, maybe "domain" isn't specific enough? Although, if not
using "genpd", I have no better suggestion.

**) Please keep in mind that we have several other power/performance
related subsystems that don't live under drivers/power/*. Moving more
things in there is not really going to help the people that work on
these things. No matter where and what the name of the subsystem is,
one simply needs to dive into the details anyway. Moreover, in this
case, "genpd" isn't just about "power" (idle management) but
performance management too.

>
> > I don't think we can easily rename the interfaces that have been
> > in use for the past 12 years
>
> I actually think the interface names are much less of an issue, since
> anybody using them is presumably familiar with the naming.
>
> It was only with the directory structure that I reacted to it, because
> that kind of exposes the naming to people who definitely are *not*
> familiar with it (ie me, but presumably anybody else who sees the
> diffstats etc fly past).
>
> And yes, we have a number of other pretty obscure driver names in our
> tree (I end up having to remind myself what "ntb" and "hsi" etc mean),
> and I don't tend to love them either, but at least they tend to be
> industry / vendor names.

I get your point. I was indeed trying to obey the current naming
strategy, but I think it's not entirely easy to understand what is
prefered.

Please advise me on how to move forward.

Kind regards
Uffe
