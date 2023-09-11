Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B2779BED4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241059AbjIKWfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236817AbjIKL2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:28:50 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8607CCDD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:28:45 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d80121cba8cso2789503276.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694431724; x=1695036524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7aH+LgtXU/bZep1051Dmp3W7xLVGoC7LOjeeK6uQUB0=;
        b=mfl1vtlAR0BVJni1RAdlYmCjR2EghvE6QIsVDjYjSw+z5uVpYMRm7tdZVjp0h17RB/
         IuIEZJhVJfoAy/J7xTK0o47g/FS96KdRYCG7JtvqHAVrICneMVmcXg1wZhdbAN0un9J2
         z9kry21+AIsonOz6J5xx1/hjhBapHIm8j67/BqUv1zU8wLePXtUffNrDkt8cgIE/rqrc
         /ZcoUSvbUltrJn2ud3c1s13f4c9wuTPVHqQ0NpG2CmqEWVFMndLrbiLASJ8hgbxl9jRf
         GCQ5nAHr1WmT/BSeG7rHqJnzR1VEhivnvIQKv5W8I72PCzoICtFd7rtYioRrb7zGYGyf
         AlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694431724; x=1695036524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7aH+LgtXU/bZep1051Dmp3W7xLVGoC7LOjeeK6uQUB0=;
        b=xPqnpLs8JBq987Q1Q4fPcE8+zvevIUrvc2sMe3OWXKFuBIeuM77cvMjel7Pd7tSaTe
         8+cIY0p406Jj07LS5Iud/Ea0HVGT5NXftlmbW3eow8mcrr4i6SiXLK7xz6YM8JaCgpjM
         SIiJzKIjxBp+UjUam0bmIPt20khoZatTGeWT2iRj8RNjiBfO10hPlUIuYN92Wfmkh4eK
         0RwYrKY1SqmV0y/mAMt5boXdH9u46o7ae6WFjOX90/243nGqtwwxULRHyVrerm3mhsod
         MMfIbPo2fUniLzcgOzp7fAmBAX/IUBKFRZxqqDhKV1E9AVJzHfxG6ZMi5nI6vOyNv8Nt
         0nLQ==
X-Gm-Message-State: AOJu0YzDdEkkRg0xBPde8g1m5raLXJqMbMUk/kt425mOyqWH+kA0Hoib
        CIi0oj7BEGwK/h/2aHeITPimyApddFxMGspOp/I4Hw==
X-Google-Smtp-Source: AGHT+IEswWwSSaXU++NcaMiC0Ujkjj+Vn04CKhSZv7TtPGdjUYWT5Z8lgFE+X0lYJNg7DMjyqZlAFXqETyStZY8C9vo=
X-Received: by 2002:a25:b16:0:b0:d7f:cdc8:e17c with SMTP id
 22-20020a250b16000000b00d7fcdc8e17cmr7889180ybl.51.1694431724711; Mon, 11 Sep
 2023 04:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230829213441.310655-1-ulf.hansson@linaro.org>
 <CAHk-=wg0gc4Cc90OL29Vr5gDtd4mnsKD+TxtoNtQbAryaWHkZQ@mail.gmail.com>
 <CAHk-=wjLO=Jsdk2prq0piznMMCk+V0_fRaFRHEPuaALpF8J=hw@mail.gmail.com>
 <96bb0de0-06d9-46f8-b02f-dc924afff13c@app.fastmail.com> <CAHk-=wi5Lh-NG_rvcx3Zyqd2Uhj76G4V73tWCFULhVzOU6e1xg@mail.gmail.com>
 <CAPDyKFrJH-1uaPCwnWZDPi4MRtOm=N2CHSRyvjXRDbQ1y-oOrw@mail.gmail.com>
 <CAJZ5v0hqWYnkNXVju3U3n-9i8eqtjs197tLLNWv8Qa_N9T=KEw@mail.gmail.com>
 <CAPDyKFpXLj_2HAgyV_VJf+GPQVmxb_iiDe77Q2MY17MDNqy9fA@mail.gmail.com> <CAMuHMdVxLkxN0bmSRXW74R_dGNDSRDB4Z=zE0DoiXDOuweSM0A@mail.gmail.com>
In-Reply-To: <CAMuHMdVxLkxN0bmSRXW74R_dGNDSRDB4Z=zE0DoiXDOuweSM0A@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 11 Sep 2023 13:28:08 +0200
Message-ID: <CAPDyKFpUUJeGD77GTYCk59cvW=SdGTkOEXH4dap1JQWekAa0Eg@mail.gmail.com>
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

On Mon, 11 Sept 2023 at 09:52, Geert Uytterhoeven <geert@linux-m68k.org> wr=
ote:
>
> Hi Ulf,
>
> On Thu, Aug 31, 2023 at 1:39=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> > On Thu, 31 Aug 2023 at 11:33, Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> > > If I may suggest something, I would call this "pmdomain" instead of
> > > "genpd".  I don't think that /drivers/power/ is a particularly
> > > suitable location for it, because it doesn't really have much to do
> > > with power supplies and more to do with device PM.
> >
> > "pmdomain" is probably giving a reasonable good hint of what goes on
> > in this subsystem. This works fine for me, thanks!
>
> Sounds nice!
> All of this lives in <linux/pm_domain.h> (with underscore?) anyway,
> and "PM Domains" is the usual naming, as it covers both Power and
> Clock Domains.
>
> However, although I am quite familiar with genpd, I am still wondering
> what is the meaning of the "generic" part in the name? And what is a
> non-generic PM Domain?

I guess generic here means "works for most cases".

There are certainly a bunch of other "non-generic", like the ACPI,
pm_clk, OMAP2, etc.

Maybe some of them could be converted to genpd, but that's another story.

>
> > > Also, I would move drivers/base/power/domain.c to drivers/pmdomain/
> > > (and rename it to something like core.c), because it would be a bette=
r
> > > location for that fiile IMO.
> >
> > We could certainly do that, let's discuss it a bit more.
> >
> > Although, at this point I want to focus on the genpd providers, as to
> > release some of the burden from arm-soc maintainers.
> >
> > > I can also handle future pull requests for this if that's fine with e=
veryone.
> >
> > Thanks a lot for your offer! However, if a re-route is preferred (I
> > think not?), this is probably better suited via arm-soc, as most
> > changes are going to be arm platform specific.
>
> Which brings me to the final question: what is the upstream path
> for changes to drivers/genpd/*/ (or whatever it's gonna be called)?
> Before, we sent PRs to (arm-)soc.  Do you expect us to send them to
> you? There's usually quite some interaction between drivers/soc/reneas/
> and drivers/genpd/renesas (and there are DT binding definitions),
> but not more than with e.g. drivers/clk/renesas/.

I would be happy to pick this up and funnel this via my new genpd
tree. As long as it's coupled with changes affecting "genpd
providers", of course.

I can certainly also collect patches directly from the
mailing-list/patch-tracker too. Whatever works for you the best. Of
course, in that case I need your acks before I pick up the relevant
patches.

If we need "immutable" branches, let's discuss that on a case by case basis=
.

>
> And I just realized you moved the code and Makefiles to drivers/genpd/,
> but not the Kconfig symbols and logic, which still lives under
> drivers/soc/.  So resolving that (and the name) is something that
> should be resolved sooner rather than later...

In regards to the name, I am relying on input from Linus to make a
final decision before I send a patch. In regards to this, I have also
started working on a documentation patch for genpd. It needs some more
polishing before I can send it though.

When it comes to the Kconfig move, I will send out a series for it, this we=
ek.

[...]

Kind regards
Uffe
