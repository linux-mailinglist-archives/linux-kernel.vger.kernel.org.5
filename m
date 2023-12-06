Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2777B807161
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378674AbjLFN5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378633AbjLFN5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:57:13 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3757AA4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:57:19 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54cd2281ccbso4042996a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 05:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1701871037; x=1702475837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6leibc9KVGhDFO57vzUjuEC1g9Shhhw6R6lNbUnfvA=;
        b=i449a/e+vxx/uHSii/PeMuJHEg499UyYhNk7YmtND6C7n577pds4XkKsf6rECSlnzL
         /UvJpBLlCP24EA96a2ECi/ugyr8zSgBsGpu2g2yCa4Hbc0+6oWMY0DUcS4cAP5S/BDbf
         /Hfh59KJvDuWw7oM4SimI3I1ULfqtKxF8PIg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701871037; x=1702475837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6leibc9KVGhDFO57vzUjuEC1g9Shhhw6R6lNbUnfvA=;
        b=vHcnFlB7QVT2+/vynsNElOToF5VITZlNqkjOzF4CuWYA+yGXU9XhG+FiBfHGgRWHbc
         sNWcadGSeGS80qT6GU151zWn/zsS8nDR6gluUKhUixpebrWnodGTwpTNW4zJbdeqyIhO
         X/tc3ncfN+1rELU4KufUu+uih8tmHFeOAxChraINsa1d0NfwgRYKwddCIOJ7LocpkZF7
         fydZ/HzzlNhohlAe86YYs1BnSFewqDACO0Wp26aJswqvUdwLOF1XxpFaolg6QNfEr34p
         cIQ4TjmgpStJ7NB1H3Fq8DjKtFGsLwlfwdhdamu3uhZ0LGqyj7Ff0K8dQS7x4SfdSsSC
         qMVg==
X-Gm-Message-State: AOJu0YzEpFOsgbE30aPRbwW6GaLPLGoLtLwV9Ep98SM/CckzWZQcQhLe
        lpvA5U7Giz7g503UhxFVcfg54tMubIqPg23mTtOJnw==
X-Google-Smtp-Source: AGHT+IG/PobLNSg+zy1WHv7BVtLTlt7MPeES0U4v/oNNLHDezYqyvRUZLZjOALXehIib1IwlHg77PgQRGzr0Rpof0Xk=
X-Received: by 2002:a17:906:3f08:b0:a14:d6e2:fb1f with SMTP id
 c8-20020a1709063f0800b00a14d6e2fb1fmr615826ejj.10.1701871037673; Wed, 06 Dec
 2023 05:57:17 -0800 (PST)
MIME-Version: 1.0
References: <20231205105341.4100896-1-dario.binacchi@amarulasolutions.com>
 <20231205105341.4100896-3-dario.binacchi@amarulasolutions.com>
 <CAPY8ntAALKiTEG6qyFO=qVqSLUW9x8AMfPMc_TUwC3z8tJ7Kzw@mail.gmail.com>
 <CABGWkvq-fJTDFPB=389XbHW_SLt6BQr-BhjZqZ+01i3v8EaYwA@mail.gmail.com> <CAMty3ZBdCW=Rak8gMin8bt9JnFChAu6nw9n6xQyCSZw=63BukA@mail.gmail.com>
In-Reply-To: <CAMty3ZBdCW=Rak8gMin8bt9JnFChAu6nw9n6xQyCSZw=63BukA@mail.gmail.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Wed, 6 Dec 2023 14:57:06 +0100
Message-ID: <CAOf5uwm_YmXz0A6nuCbJh+iszwqWyQkRRKATKyWZ33YUgZmEnw@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] drm/bridge: Fix a use case in the bridge disable logic
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan

On Wed, Dec 6, 2023 at 2:31=E2=80=AFPM Jagan Teki <jagan@amarulasolutions.c=
om> wrote:
>
> Hi Dario,
>
> On Wed, Dec 6, 2023 at 6:57=E2=80=AFPM Dario Binacchi
> <dario.binacchi@amarulasolutions.com> wrote:
> >
> > Hi Dave and Jagan,
> >
> > On Tue, Dec 5, 2023 at 4:39=E2=80=AFPM Dave Stevenson
> > <dave.stevenson@raspberrypi.com> wrote:
> > >
> > > Hi Dario
> > >
> > > On Tue, 5 Dec 2023 at 10:54, Dario Binacchi
> > > <dario.binacchi@amarulasolutions.com> wrote:
> > > >
> > > > The patch fixes the code for finding the next bridge with the
> > > > "pre_enable_prev_first" flag set to false. In case this condition i=
s
> > > > not verified, i. e. there is no subsequent bridge with the flag set=
 to
> > > > false, the whole bridge list is traversed, invalidating the "next"
> > > > variable.
> > > >
> > > > The use of a new iteration variable (i. e. "iter") ensures that the=
 value
> > > > of the "next" variable is not invalidated.
> > >
> > > We already have https://patchwork.freedesktop.org/patch/529288/ that
> > > has been reviewed (but not applied) to resolve this. What does this
> > > version do differently and why?
> >
> > My patches only affect drm_atomic_bridge_chain_post_disable(), whereas
> > Jagan's patch affects both
> > drm_atomic_bridge_chain_post_disable() and drm_atomic_bridge_chain_pre_=
enable().
> > I tested Jagan's patch on my system with success and I reviewed with
> > Michael Trimarchi the
> > drm_atomic_bridge_chain_pre_enable() fixing and we think it's okay.
> > We also believe that our changes to post_disable() are better, as we
> > set the 'next' variable only when required,
> > and the code is more optimized since the list_is_last() is not called
> > within the loop.
> > Would it be possible to use Jagan's patch for fixing
> > drm_atomic_bridge_chain_pre_enable() and mine for
> > fixing drm_atomic_bridge_chain_post_disable()?
> >
>
> Can you please share the post-disabled bridge chain list with the
> below example before and after your change?

We have already git commit the description in how the patch affects
the post_disable. As Dario
reported your patch is ok even in our use case. We don't have a real
use case as the one you describe.

Can we know how you test it in this use case here? Can you test our
patches of post_disable?

Thanks
Michael

>
> Example:
> - Panel
> - Bridge 1
> - Bridge 2 pre_enable_prev_first
> - Bridge 3
> - Bridge 4 pre_enable_prev_first
> - Bridge 5 pre_enable_prev_first
> - Bridge 6
> - Encoder
>
> Thanks,
> Jagan.
