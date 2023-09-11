Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0F079B9E9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359452AbjIKWQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237160AbjIKMHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:07:34 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB38DF2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 05:07:29 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d77a4e30e97so3875363276.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 05:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694434049; x=1695038849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XX4v8HhseDUrg4nK4GOlhuMrgfux3e3KYPTg4pZxyPI=;
        b=BdFRwJ4Eg3aN53gbQ6qSgp8es3maaymTIYga1gqnYtFQijJ2WCgbzFJBTWOywvuYar
         4ucoffX8eMDsJgjtsClWXZFYTvaeSwz3JePDh+7fAupOJnTsYL1XHK13CvZV8chVjJ3j
         SfBnCwLXCw9sedL0k6j02v9MNdtl5l1lO0JoedafXq3RvSDq00uxdES+bgnN1vdpF/M7
         Suv7YIVTYaXGInAwjcFfcJghNhVnhkfkFkhMnioHlS96b8m7Ldife6bCMgano4X1O5VR
         wf2BQ+Vg2eftcQKO8rhZBVvIMmhhuxw21CZLNMKEYHT2PWPno3SMsfbzyVr4eeV1TXh5
         xQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694434049; x=1695038849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XX4v8HhseDUrg4nK4GOlhuMrgfux3e3KYPTg4pZxyPI=;
        b=X2NEn9ByDZ+vX4n9hPW1+xxTP7KDh7kbAhQX5gby1Ryq3Xm/l5KkKElF4krLhrCRFc
         OBUrP0oSaf8gTa6+0LyprLtF1s767TQsHa1DBWmsCCGidd7biBwaaLG9dyAlMDOIU463
         8ZiTxkyLUsSGvz7PIDk5HNBiq7I2ZbFx3jI43nAFLkdqjz7ZD4OXO2i0RkpvCyj0jgTO
         s6NNf5ppFkc+IpoS4Y+jH7g8eAPu5TxbzRKKKbvd+Vsq2mjTYAfUjkNW5XieXq2C/ApY
         2wwAAtsFwankNIEgtn3IjMEzfYbzEwN7KDoCbJMS9UbnN4rObEbrHibFwNrBbJ69qudu
         BS+w==
X-Gm-Message-State: AOJu0YzyaY6x+2/rsGzVSmtV+JozzD7MY/JLqMS3V1dgjfHIuaXPRn8W
        ISBOxstFbfsSocu0SIWagmEXbiyGYR67s6touUoFGw==
X-Google-Smtp-Source: AGHT+IES24EorS8GUJRuowcjC8+FAzezIUBouFFfC1NtKEb/nqAMSCkSw+Lyxw6KKpapAaBFc8ChmLvFJE9CTPGxwwE=
X-Received: by 2002:a5b:709:0:b0:d80:68d1:b826 with SMTP id
 g9-20020a5b0709000000b00d8068d1b826mr4839146ybq.6.1694434048864; Mon, 11 Sep
 2023 05:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230829213441.310655-1-ulf.hansson@linaro.org>
 <CAHk-=wg0gc4Cc90OL29Vr5gDtd4mnsKD+TxtoNtQbAryaWHkZQ@mail.gmail.com>
 <CAHk-=wjLO=Jsdk2prq0piznMMCk+V0_fRaFRHEPuaALpF8J=hw@mail.gmail.com>
 <96bb0de0-06d9-46f8-b02f-dc924afff13c@app.fastmail.com> <CAHk-=wi5Lh-NG_rvcx3Zyqd2Uhj76G4V73tWCFULhVzOU6e1xg@mail.gmail.com>
 <CAPDyKFrJH-1uaPCwnWZDPi4MRtOm=N2CHSRyvjXRDbQ1y-oOrw@mail.gmail.com>
 <CAJZ5v0hqWYnkNXVju3U3n-9i8eqtjs197tLLNWv8Qa_N9T=KEw@mail.gmail.com>
 <CAPDyKFpXLj_2HAgyV_VJf+GPQVmxb_iiDe77Q2MY17MDNqy9fA@mail.gmail.com>
 <CAMuHMdVxLkxN0bmSRXW74R_dGNDSRDB4Z=zE0DoiXDOuweSM0A@mail.gmail.com>
 <CAPDyKFpUUJeGD77GTYCk59cvW=SdGTkOEXH4dap1JQWekAa0Eg@mail.gmail.com> <CAMuHMdUZcrtHZz7daKjL7Oz2MEmCrjJ_ovO3ttTnZ7xuRWgiRA@mail.gmail.com>
In-Reply-To: <CAMuHMdUZcrtHZz7daKjL7Oz2MEmCrjJ_ovO3ttTnZ7xuRWgiRA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 11 Sep 2023 14:06:52 +0200
Message-ID: <CAPDyKFpctt6AQBpu+vBQ0ymW3PQGB8dt8-QEhgbz0Uo5T-1Wxw@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC/genpd driver updates for v6.6
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sept 2023 at 13:48, Geert Uytterhoeven <geert@linux-m68k.org> wr=
ote:
>
> Hi Ulf,
>
> On Mon, Sep 11, 2023 at 1:28=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> > On Mon, 11 Sept 2023 at 09:52, Geert Uytterhoeven <geert@linux-m68k.org=
> wrote:
> > > On Thu, Aug 31, 2023 at 1:39=E2=80=AFPM Ulf Hansson <ulf.hansson@lina=
ro.org> wrote:
> > > > On Thu, 31 Aug 2023 at 11:33, Rafael J. Wysocki <rafael@kernel.org>=
 wrote:
> > > > > If I may suggest something, I would call this "pmdomain" instead =
of
> > > > > "genpd".  I don't think that /drivers/power/ is a particularly
> > > > > suitable location for it, because it doesn't really have much to =
do
> > > > > with power supplies and more to do with device PM.
> > > >
> > > > "pmdomain" is probably giving a reasonable good hint of what goes o=
n
> > > > in this subsystem. This works fine for me, thanks!
> > >
> > > > > Also, I would move drivers/base/power/domain.c to drivers/pmdomai=
n/
> > > > > (and rename it to something like core.c), because it would be a b=
etter
> > > > > location for that fiile IMO.
> > > >
> > > > We could certainly do that, let's discuss it a bit more.
> > > >
> > > > Although, at this point I want to focus on the genpd providers, as =
to
> > > > release some of the burden from arm-soc maintainers.
> > > >
> > > > > I can also handle future pull requests for this if that's fine wi=
th everyone.
> > > >
> > > > Thanks a lot for your offer! However, if a re-route is preferred (I
> > > > think not?), this is probably better suited via arm-soc, as most
> > > > changes are going to be arm platform specific.
> > >
> > > Which brings me to the final question: what is the upstream path
> > > for changes to drivers/genpd/*/ (or whatever it's gonna be called)?
> > > Before, we sent PRs to (arm-)soc.  Do you expect us to send them to
> > > you? There's usually quite some interaction between drivers/soc/renea=
s/
> > > and drivers/genpd/renesas (and there are DT binding definitions),
> > > but not more than with e.g. drivers/clk/renesas/.
> >
> > I would be happy to pick this up and funnel this via my new genpd
> > tree. As long as it's coupled with changes affecting "genpd
> > providers", of course.
> >
> > I can certainly also collect patches directly from the
> > mailing-list/patch-tracker too. Whatever works for you the best. Of
> > course, in that case I need your acks before I pick up the relevant
> > patches.
> >
> > If we need "immutable" branches, let's discuss that on a case by case b=
asis.
>
> At least for Renesas SoCs, every new SoC comes with a DT binding
> definitions file under include/dt-bindings/power/, to be shared by genpd
> driver and DTS (the same is true for clocks).  So PRs will work best.

Good point! And Neil pointed out this too [1].

I am going to host an immutable branch for the dt bindings that you
can pull in. Would that be a better option for you?

[...]

Kind regards
Uffe

[1]
https://lore.kernel.org/lkml/4303c141-30df-4a2b-aba7-f11a98db9941@linaro.or=
g/
