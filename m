Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D74751DB7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbjGMJvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbjGMJvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:51:07 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122F82127
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:51:06 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-caf3a97aa3dso472282276.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689241865; x=1691833865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qmboCy6O4VZ2QerNW0sFMiABzsIB0mZysPTru8Y01c0=;
        b=X+8WGU6NKzCqjvvD/xjNcjLtelRyK4iDs5BbDHlVwg1VEjSYATF5eO6w6UvsQijYgc
         LIdpy+8823AqRqqtHm/Byn5SnqU1jioj8iWBucyIO/8GGCKLPNopCe07qsbotbXNuZ/K
         ZChW9oJeLkneHmewLrbX0xWrOgsVkbtD9LMsu/sfgvQyAM0EQ52A1JXSqIefW9fRHRwO
         icCCl6CpS4rfSgfkpOpdEpz1JoFxgmdpRDMd28Fear69VP8cm55IvbgZKoA/6eMnyjBE
         f77w9OCZLVZibWJbXZNWqcm9xxEZLbW/SsfVsql6cPXnbNLDdYQikWeVAg+gWJI3fOg6
         WLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689241865; x=1691833865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qmboCy6O4VZ2QerNW0sFMiABzsIB0mZysPTru8Y01c0=;
        b=MEDijmx6DMczjqmjV8eOj/Pxn/sgXHHFWl4x3ArkBjtHvTg6mFVGM1mOkpycmMFl2R
         0peulFF19OPNQ3xcsk5bpzei5BGrFtc5+x4Di0HZj8HccPMWcuLUXJgS6HL7XdrMqU4u
         FycSq5wYUe3iH09KiNMzgwCtgBY5a0mbIdRjEkbJlJhbqbKEHb9ssJBoikQ64gE0ttAl
         u7lfRtO5QclCJJ63tglKEeszHtRmDmTdEjaegV0l8kIKKgiSaI8b9KJIS8SXxahQYkOt
         LyUwstlPPJIdWtBSwSDn8Fqfw5lzRTobZcZ9iMXwRN8JdRdYHb8fewNHQ/gRA0KZGA7P
         YWqg==
X-Gm-Message-State: ABy/qLbVriOUbN4SRwHEjCuXT3mMSHhiW6+ZzBjUDVmed0D9b1m4MjqY
        2xW0whEY6WnFXDtk4KsaRLizaAIjnHY/pAgDnV8G+A==
X-Google-Smtp-Source: APBJJlFFmSyXB6CIf5q786088dWd85CG5uGJ6KY0/vrCcgZMUgfn7tKweyGDHdnOOxLB1Txzq8Ej/g9GKVXT25PnLoE=
X-Received: by 2002:a81:7744:0:b0:577:189b:ad4 with SMTP id
 s65-20020a817744000000b00577189b0ad4mr1148836ywc.48.1689241865319; Thu, 13
 Jul 2023 02:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
 <20230707140434.723349-4-ulf.hansson@linaro.org> <0c8938a9-7a26-bf97-51ee-0c271901ec21@linaro.org>
 <CAPDyKFrOye96GyHS0tiTQ02Ve5S6Crtk8=bMsRS9Ljj=h5-nWQ@mail.gmail.com>
 <1496b9c1-289a-c354-f0ae-e14fd4c9bcfa@linaro.org> <CAPDyKFr7Mqy5bisLcxcA_iEGWqL8SFt2mDDng7zYEaTD1vNisA@mail.gmail.com>
 <deyyt5r2wkxo7ily434gl3wudls2sbinkmnehssqshwnbzmlwf@lmqskj6zwfu2>
 <CAPDyKFoRtEXTGQkNzGza-sS_j1ajGmjtCTaoPB7PXVDE2bS0tQ@mail.gmail.com>
 <2ef84fb8-b5eb-4c9a-b8a1-0c5f33e7f572@app.fastmail.com> <sxyavxzvezu5dorysn3nmwq7ew5xdclpm7rg474cifnnzy54mb@jljrhirrir2i>
In-Reply-To: <sxyavxzvezu5dorysn3nmwq7ew5xdclpm7rg474cifnnzy54mb@jljrhirrir2i>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 13 Jul 2023 11:50:29 +0200
Message-ID: <CAPDyKFoQoKx1uEpFBNfsaCFEG_9TOzSdNW90h-+bVz+_3xYObA@mail.gmail.com>
Subject: Re: [PATCH 03/18] soc: amlogic: Move power-domain drivers to the
 genpd dir
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Olof Johansson <olof@lixom.net>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2023 at 02:45, Bjorn Andersson <andersson@kernel.org> wrote:
>
> On Mon, Jul 10, 2023 at 02:45:12PM +0200, Arnd Bergmann wrote:
> > On Mon, Jul 10, 2023, at 14:37, Ulf Hansson wrote:
> > > On Sun, 9 Jul 2023 at 04:21, Bjorn Andersson <andersson@kernel.org> wrote:
> > >> On Fri, Jul 07, 2023 at 05:27:39PM +0200, Ulf Hansson wrote:
> > >
> > > If I understand correctly, you are suggesting that each platform
> > > maintainer should merge the immutable branch with patch1 - and that I
> > > should send the patches (based on the immutable branch) to each of the
> > > platform maintainers to manage. Instead of one pull request with
> > > everything directly to Arnd, right?
> > >
>
> That's what I suggest, yes.
>
> > > This still means that Arnd will have to resolve the conflicts as the
> > > pull requests arrive in his inbox.
> > >
>
> Yes, we will have N maintainers modifying drivers/genpd/Makefile, all
> adding their single obj-y line. A quite trivial conflict to manage.
>
> > > Although, I guess what you are looking for is less work for the soc/
> > > maintainers, which seems reasonable. Although, in that case, I might
> > > as well share an immutable branch with the complete series, rather
> > > than just patch1. That should help Arnd too, I think.
> > >
> > > Again, let's leave the call to Arnd on what to do.
> >
> > I think it's much easier for me to pick up a single branch with
> > all of your patches. For platform maintainers, other changes can
> > go one of two ways:
> >
> > - send a normal pull requests with changes against the same
> >   files, and have me take care of any conflicts where they
> >   arise. Since most of the changes are just simple file moves
> >   rather than changing file contents, 'git mergetool' handles
> >   these fine is most cases
> >
> > - If there is a non-obvious merge, the entire genpd branch
> >   can be shared as an immutable branch, with patches for
> >   a particular platform rebased on top of that branch.
> >
>
> I already have a set of patches to these drivers in my tree for v6.6, in
> their current location.

Right.

>
> I'm afraid I am unable to see how we're going to handle the merge
> conflict you're going to create in linux-next. Perhaps you're proposing
> to just never publish Ulf's patches to linux-next?
>
> By me merging the immutable patch 1 and the qcom-patch, the conflicts
> would be minimal, and except for the genpd/Makefile entirely handled by
> me.

If you would merge the immutable branch containing the complete
series, that should work too, rather than just patch1, right?

As a heads up, I am planning to send the pull request with the v2
series tomorrow, allowing a few more acks to arrive. At that point I
will announce the immutable branch too.

Kind regards
Uffe
