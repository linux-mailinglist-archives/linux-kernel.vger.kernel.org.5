Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D22E78EDDA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 14:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242077AbjHaM7F convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 31 Aug 2023 08:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjHaM7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 08:59:04 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A82CF3;
        Thu, 31 Aug 2023 05:58:59 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-573128cd77dso68828eaf.0;
        Thu, 31 Aug 2023 05:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693486739; x=1694091539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uNl6jFskdrLBmjyS7+9CIbwuUHiMSI+rI9yedXX/qQ=;
        b=jCyLEG1I26gNP7CJrVpYa/Gnjurjg36dEqLURycaD2plqy9Sa0bPVpZFcaw3PjPU7z
         QyFY635fcrAN/RprlDghodeqsi0oWgHVOUCjGTJob1YMtSAki35ox4L7uwNKn8ULlgBL
         AQNdnPqVPwRgfF3e3IXpI5l0ZvXiJ+M3aQhqqTorpYd0FseAWNZ0kGNlwnN1CldUg16B
         AL1HrtE5YKd2SKucYlL3Ras3nVOY4W+oCCsmNqzzVqOz+dtcMSvvFAH6oLz9ki+JQLH1
         4FWH4vTbbuB+eABKXT5WB25OyYr8hOjj9zNbowpVpdUMbjO2GILqbczx99QAFCylVG+G
         8dBg==
X-Gm-Message-State: AOJu0Ywbw6Htm2ZcjGh5O8m6Lwmy3Z97U2/LumV0vTgxkmm09ddTcmvn
        ysDn7wVCMU1f+KzU9V7yi7DjpxlMuJ/a68c1ZgQ=
X-Google-Smtp-Source: AGHT+IEmGYX9g/ETXL3g53lOPMLKPSoIb0ND1MPTFYNli229Abq6tXAuUZTAqX6cK/rNN33pZ3n/43SiMLCKfy8PE1o=
X-Received: by 2002:a4a:b4c5:0:b0:56e:6532:467a with SMTP id
 g5-20020a4ab4c5000000b0056e6532467amr5345539ooo.1.1693486739131; Thu, 31 Aug
 2023 05:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230829213441.310655-1-ulf.hansson@linaro.org>
 <CAHk-=wg0gc4Cc90OL29Vr5gDtd4mnsKD+TxtoNtQbAryaWHkZQ@mail.gmail.com>
 <CAHk-=wjLO=Jsdk2prq0piznMMCk+V0_fRaFRHEPuaALpF8J=hw@mail.gmail.com>
 <96bb0de0-06d9-46f8-b02f-dc924afff13c@app.fastmail.com> <CAHk-=wi5Lh-NG_rvcx3Zyqd2Uhj76G4V73tWCFULhVzOU6e1xg@mail.gmail.com>
 <CAPDyKFrJH-1uaPCwnWZDPi4MRtOm=N2CHSRyvjXRDbQ1y-oOrw@mail.gmail.com>
 <CAJZ5v0hqWYnkNXVju3U3n-9i8eqtjs197tLLNWv8Qa_N9T=KEw@mail.gmail.com> <CAPDyKFpXLj_2HAgyV_VJf+GPQVmxb_iiDe77Q2MY17MDNqy9fA@mail.gmail.com>
In-Reply-To: <CAPDyKFpXLj_2HAgyV_VJf+GPQVmxb_iiDe77Q2MY17MDNqy9fA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 31 Aug 2023 14:58:47 +0200
Message-ID: <CAJZ5v0j52eotamMABZpu3-L3mmW=MwJEtTHCu3j8tAA0dZJzzA@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC/genpd driver updates for v6.6
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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

On Thu, Aug 31, 2023 at 1:37 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 31 Aug 2023 at 11:33, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Wed, Aug 30, 2023 at 10:34 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:

[cut]

> > > Please advise me on how to move forward.
> >
> > If I may suggest something, I would call this "pmdomain" instead of
> > "genpd".  I don't think that /drivers/power/ is a particularly
> > suitable location for it, because it doesn't really have much to do
> > with power supplies and more to do with device PM.
>
> "pmdomain" is probably giving a reasonable good hint of what goes on
> in this subsystem. This works fine for me, thanks!
>
> >
> > Also, I would move drivers/base/power/domain.c to drivers/pmdomain/
> > (and rename it to something like core.c), because it would be a better
> > location for that fiile IMO.
>
> We could certainly do that, let's discuss it a bit more.
>
> Although, at this point I want to focus on the genpd providers, as to
> release some of the burden from arm-soc maintainers.

That's fine, it's just a suggestion.

The rationale is that the "core" code is used by the providers, so
putting it next to them would be more convenient in case it needs to
be modified along with the providers, for example.

> >
> > I can also handle future pull requests for this if that's fine with everyone.
>
> Thanks a lot for your offer! However, if a re-route is preferred (I
> think not?), this is probably better suited via arm-soc, as most
> changes are going to be arm platform specific.

Whichever works for you better.
