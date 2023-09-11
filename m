Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3887379ADA7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376550AbjIKWT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238521AbjIKN6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:58:24 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465FECF0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:58:19 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-592976e5b6dso42733587b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694440698; x=1695045498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nACYby6xXH6p7S8DvIzSIkOm0WQtOoj9eojm3GigSa0=;
        b=aaIZxIzPoCItBRcrNXiZfTiDpO75zLUbn7XX4fn35LgyUzFXePdOi68HUvzt43mSAV
         8zFJWEKZsL0ejPbj3yeYARMFUho8Rxg+b5ot5i15zE24YmzBKwHnIX88BLOxhXT6vNEM
         pqbE5yyvFfEFtBRrPvllSyCq8jEs9KXSlFuv2/EEZcYM441029x2ntrNCG7jPSXt9Vo+
         NBMmKLSzLnhsbOZ/f+mF9QJQaZsbhjisee4dCIF1enp8QBIna0v5GO8MU5lf7OjypNFR
         NykMddOn5JQsqUNiTqBKbMnwuxZW3Bi1TQpk6YSfU/DYYc3e2E8jp2AfcAvBSbCbQvBq
         4x7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694440698; x=1695045498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nACYby6xXH6p7S8DvIzSIkOm0WQtOoj9eojm3GigSa0=;
        b=YUb/bYXGb+/R5+n0bkqoyPq46zXO0PwXx8tOQWQl8mzqt/lbnNjWpf3hSwAHRG+a1J
         xqj8pVyMyaOh8cgzsHjGwFjvbBIXVVZx90Gz9dw9uN/F0fZe6dMsTnNhEQMBiZaU4Xaw
         Bt6XFYFGoWg0hN7dv3i7Bf82kGhiIWcGfm0kvxk1kC7cMYDzSD7RLMD3AK08YrCQGgvn
         HbCmOJHKgzPWtR5BAK5+kFunxvq+yzDHGUXdlqeF5DyLKinYAKZIVVrM9FAlFQR3QtFm
         gpNs7Gn5YEQiaWn0lOV4mnUYMi9KWvsxWIaks/FmufOAo8ZZc9uJi111Q3XZpccVU99y
         pBJA==
X-Gm-Message-State: AOJu0YzzHrqBHdYL/HLyl85WGsjIHi49N+p2VG2rL03gLAJgA7f9F4Q1
        uEjewjY1CMdNEdAq5+weneCaZHr16CtjP9mpxuccvw==
X-Google-Smtp-Source: AGHT+IH8D6O/aZm8DWZWsCsterhrJnASynNQFNSyb8/dl7IOKv39YklR9FBqcQfAiqQ8Ef585oqLrbBNQ5h4aEb5TXo=
X-Received: by 2002:a25:698f:0:b0:d7b:9d44:76dc with SMTP id
 e137-20020a25698f000000b00d7b9d4476dcmr9304485ybc.38.1694440698473; Mon, 11
 Sep 2023 06:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230829213441.310655-1-ulf.hansson@linaro.org>
 <CAHk-=wg0gc4Cc90OL29Vr5gDtd4mnsKD+TxtoNtQbAryaWHkZQ@mail.gmail.com>
 <CAHk-=wjLO=Jsdk2prq0piznMMCk+V0_fRaFRHEPuaALpF8J=hw@mail.gmail.com>
 <96bb0de0-06d9-46f8-b02f-dc924afff13c@app.fastmail.com> <CAHk-=wi5Lh-NG_rvcx3Zyqd2Uhj76G4V73tWCFULhVzOU6e1xg@mail.gmail.com>
 <CAPDyKFrJH-1uaPCwnWZDPi4MRtOm=N2CHSRyvjXRDbQ1y-oOrw@mail.gmail.com>
 <CAJZ5v0hqWYnkNXVju3U3n-9i8eqtjs197tLLNWv8Qa_N9T=KEw@mail.gmail.com>
 <CAPDyKFpXLj_2HAgyV_VJf+GPQVmxb_iiDe77Q2MY17MDNqy9fA@mail.gmail.com>
 <CAMuHMdVxLkxN0bmSRXW74R_dGNDSRDB4Z=zE0DoiXDOuweSM0A@mail.gmail.com>
 <CAPDyKFpUUJeGD77GTYCk59cvW=SdGTkOEXH4dap1JQWekAa0Eg@mail.gmail.com>
 <CAMuHMdUZcrtHZz7daKjL7Oz2MEmCrjJ_ovO3ttTnZ7xuRWgiRA@mail.gmail.com>
 <CAPDyKFpctt6AQBpu+vBQ0ymW3PQGB8dt8-QEhgbz0Uo5T-1Wxw@mail.gmail.com> <CAMuHMdWK0Y7CAGMVyr-_RyZ31WiKMaJHL5XaZjOrFkO8od7Nfw@mail.gmail.com>
In-Reply-To: <CAMuHMdWK0Y7CAGMVyr-_RyZ31WiKMaJHL5XaZjOrFkO8od7Nfw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 11 Sep 2023 15:57:41 +0200
Message-ID: <CAPDyKFq9E29XPD6AYjapJDhr=ML_Sdk8FnNtiAduP=p=gJcX5A@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sept 2023 at 15:06, Geert Uytterhoeven <geert@linux-m68k.org> wr=
ote:
>
> Hi Ulf,
>
> On Mon, Sep 11, 2023 at 2:07=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> > On Mon, 11 Sept 2023 at 13:48, Geert Uytterhoeven <geert@linux-m68k.org=
> wrote:
> > > On Mon, Sep 11, 2023 at 1:28=E2=80=AFPM Ulf Hansson <ulf.hansson@lina=
ro.org> wrote:
> > > > On Mon, 11 Sept 2023 at 09:52, Geert Uytterhoeven <geert@linux-m68k=
.org> wrote:
> > > > > On Thu, Aug 31, 2023 at 1:39=E2=80=AFPM Ulf Hansson <ulf.hansson@=
linaro.org> wrote:
> > > > > > On Thu, 31 Aug 2023 at 11:33, Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> > > > > > > If I may suggest something, I would call this "pmdomain" inst=
ead of
> > > > > > > "genpd".  I don't think that /drivers/power/ is a particularl=
y
> > > > > > > suitable location for it, because it doesn't really have much=
 to do
> > > > > > > with power supplies and more to do with device PM.
> > > > > >
> > > > > > "pmdomain" is probably giving a reasonable good hint of what go=
es on
> > > > > > in this subsystem. This works fine for me, thanks!
> > > > >
> > > > > > > Also, I would move drivers/base/power/domain.c to drivers/pmd=
omain/
> > > > > > > (and rename it to something like core.c), because it would be=
 a better
> > > > > > > location for that fiile IMO.
> > > > > >
> > > > > > We could certainly do that, let's discuss it a bit more.
> > > > > >
> > > > > > Although, at this point I want to focus on the genpd providers,=
 as to
> > > > > > release some of the burden from arm-soc maintainers.
> > > > > >
> > > > > > > I can also handle future pull requests for this if that's fin=
e with everyone.
> > > > > >
> > > > > > Thanks a lot for your offer! However, if a re-route is preferre=
d (I
> > > > > > think not?), this is probably better suited via arm-soc, as mos=
t
> > > > > > changes are going to be arm platform specific.
> > > > >
> > > > > Which brings me to the final question: what is the upstream path
> > > > > for changes to drivers/genpd/*/ (or whatever it's gonna be called=
)?
> > > > > Before, we sent PRs to (arm-)soc.  Do you expect us to send them =
to
> > > > > you? There's usually quite some interaction between drivers/soc/r=
eneas/
> > > > > and drivers/genpd/renesas (and there are DT binding definitions),
> > > > > but not more than with e.g. drivers/clk/renesas/.
> > > >
> > > > I would be happy to pick this up and funnel this via my new genpd
> > > > tree. As long as it's coupled with changes affecting "genpd
> > > > providers", of course.
> > > >
> > > > I can certainly also collect patches directly from the
> > > > mailing-list/patch-tracker too. Whatever works for you the best. Of
> > > > course, in that case I need your acks before I pick up the relevant
> > > > patches.
> > > >
> > > > If we need "immutable" branches, let's discuss that on a case by ca=
se basis.
> > >
> > > At least for Renesas SoCs, every new SoC comes with a DT binding
> > > definitions file under include/dt-bindings/power/, to be shared by ge=
npd
> > > driver and DTS (the same is true for clocks).  So PRs will work best.
> >
> > Good point! And Neil pointed out this too [1].
> >
> > I am going to host an immutable branch for the dt bindings that you
> > can pull in. Would that be a better option for you?
>
> Yes, that would work for me, too.
> Can I conclude you prefer to take patches over PRs?

In general, yes. But, I am fine with both options, as long as it works
for you too!

Kind regards
Uffe
