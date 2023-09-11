Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FF079B112
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238314AbjIKUxw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Sep 2023 16:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236986AbjIKLss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:48:48 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D945ACDD;
        Mon, 11 Sep 2023 04:48:43 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-58e6c05f529so43010207b3.3;
        Mon, 11 Sep 2023 04:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694432923; x=1695037723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNxtitsDplq82bteZ8FNeLtI0Rd6/5SNO9LLtNUX32A=;
        b=lECok5INYMlcjwjfEgqNj1hLL1+bNxABZs0a0T0LfvhQS+Zav3DoCJhbXVfHNPuBme
         XGUbOE6gkfu3wXVgFqf5MtOWFJNmXLFuG0xmaNqZATWoj+1j7ws5Wd44v02npjGLjobl
         9a7rXqneTTc/smxS6MUPRvX1TMIBowb7RPHi3CMObctnN79OPnDMEHvFKQJt0JHdbSLJ
         8fa0LXdkNhYYYVpoXpsboYT9no0Rgm1cQFWFJDB4KKp2o0NfTuyxauH1QYc1Kptanz40
         8FhG0Ij7Pz6fXbChPrjg7QsitJEsy+qZWVOg7DkrqZc9PEIl5EQevuc3rRvd5XbXiKIu
         ifvA==
X-Gm-Message-State: AOJu0YxSDGdrJwu0Dr0ErhowRpWQUz4HI9yNX4WBm19OUH+8x/kWNgG4
        dNGjDHrXxFxTBDLztTR5eTUUYIC44tbdXg==
X-Google-Smtp-Source: AGHT+IF7sK1QEmy2OCTWrgIKZWVtvPBHm+GpKGmV/0XeTLBrYJ5phEF824CBE7TxoVrJCKZDuEVR6Q==
X-Received: by 2002:a81:730b:0:b0:595:b30:1dd8 with SMTP id o11-20020a81730b000000b005950b301dd8mr9205316ywc.18.1694432922930;
        Mon, 11 Sep 2023 04:48:42 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id i84-20020a815457000000b0057085b18cddsm1915061ywb.54.2023.09.11.04.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 04:48:42 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d7f0a60a159so3767703276.0;
        Mon, 11 Sep 2023 04:48:42 -0700 (PDT)
X-Received: by 2002:a25:d8cb:0:b0:c4b:ada8:8b86 with SMTP id
 p194-20020a25d8cb000000b00c4bada88b86mr8596493ybg.64.1694432921809; Mon, 11
 Sep 2023 04:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230829213441.310655-1-ulf.hansson@linaro.org>
 <CAHk-=wg0gc4Cc90OL29Vr5gDtd4mnsKD+TxtoNtQbAryaWHkZQ@mail.gmail.com>
 <CAHk-=wjLO=Jsdk2prq0piznMMCk+V0_fRaFRHEPuaALpF8J=hw@mail.gmail.com>
 <96bb0de0-06d9-46f8-b02f-dc924afff13c@app.fastmail.com> <CAHk-=wi5Lh-NG_rvcx3Zyqd2Uhj76G4V73tWCFULhVzOU6e1xg@mail.gmail.com>
 <CAPDyKFrJH-1uaPCwnWZDPi4MRtOm=N2CHSRyvjXRDbQ1y-oOrw@mail.gmail.com>
 <CAJZ5v0hqWYnkNXVju3U3n-9i8eqtjs197tLLNWv8Qa_N9T=KEw@mail.gmail.com>
 <CAPDyKFpXLj_2HAgyV_VJf+GPQVmxb_iiDe77Q2MY17MDNqy9fA@mail.gmail.com>
 <CAMuHMdVxLkxN0bmSRXW74R_dGNDSRDB4Z=zE0DoiXDOuweSM0A@mail.gmail.com> <CAPDyKFpUUJeGD77GTYCk59cvW=SdGTkOEXH4dap1JQWekAa0Eg@mail.gmail.com>
In-Reply-To: <CAPDyKFpUUJeGD77GTYCk59cvW=SdGTkOEXH4dap1JQWekAa0Eg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Sep 2023 13:48:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUZcrtHZz7daKjL7Oz2MEmCrjJ_ovO3ttTnZ7xuRWgiRA@mail.gmail.com>
Message-ID: <CAMuHMdUZcrtHZz7daKjL7Oz2MEmCrjJ_ovO3ttTnZ7xuRWgiRA@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On Mon, Sep 11, 2023 at 1:28 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Mon, 11 Sept 2023 at 09:52, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Aug 31, 2023 at 1:39 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > On Thu, 31 Aug 2023 at 11:33, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > If I may suggest something, I would call this "pmdomain" instead of
> > > > "genpd".  I don't think that /drivers/power/ is a particularly
> > > > suitable location for it, because it doesn't really have much to do
> > > > with power supplies and more to do with device PM.
> > >
> > > "pmdomain" is probably giving a reasonable good hint of what goes on
> > > in this subsystem. This works fine for me, thanks!
> >
> > > > Also, I would move drivers/base/power/domain.c to drivers/pmdomain/
> > > > (and rename it to something like core.c), because it would be a better
> > > > location for that fiile IMO.
> > >
> > > We could certainly do that, let's discuss it a bit more.
> > >
> > > Although, at this point I want to focus on the genpd providers, as to
> > > release some of the burden from arm-soc maintainers.
> > >
> > > > I can also handle future pull requests for this if that's fine with everyone.
> > >
> > > Thanks a lot for your offer! However, if a re-route is preferred (I
> > > think not?), this is probably better suited via arm-soc, as most
> > > changes are going to be arm platform specific.
> >
> > Which brings me to the final question: what is the upstream path
> > for changes to drivers/genpd/*/ (or whatever it's gonna be called)?
> > Before, we sent PRs to (arm-)soc.  Do you expect us to send them to
> > you? There's usually quite some interaction between drivers/soc/reneas/
> > and drivers/genpd/renesas (and there are DT binding definitions),
> > but not more than with e.g. drivers/clk/renesas/.
>
> I would be happy to pick this up and funnel this via my new genpd
> tree. As long as it's coupled with changes affecting "genpd
> providers", of course.
>
> I can certainly also collect patches directly from the
> mailing-list/patch-tracker too. Whatever works for you the best. Of
> course, in that case I need your acks before I pick up the relevant
> patches.
>
> If we need "immutable" branches, let's discuss that on a case by case basis.

At least for Renesas SoCs, every new SoC comes with a DT binding
definitions file under include/dt-bindings/power/, to be shared by genpd
driver and DTS (the same is true for clocks).  So PRs will work best.

> > And I just realized you moved the code and Makefiles to drivers/genpd/,
> > but not the Kconfig symbols and logic, which still lives under
> > drivers/soc/.  So resolving that (and the name) is something that
> > should be resolved sooner rather than later...
>
> In regards to the name, I am relying on input from Linus to make a
> final decision before I send a patch. In regards to this, I have also
> started working on a documentation patch for genpd. It needs some more
> polishing before I can send it though.
>
> When it comes to the Kconfig move, I will send out a series for it, this week.

OK.
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
