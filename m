Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328A67890FC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 23:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjHYV6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 17:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjHYV6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 17:58:22 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464FC26B0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 14:58:19 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bb99fbaebdso21137321fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 14:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693000697; x=1693605497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5vqh0pjH8L8vsEX9VZkjGRGPe8QVst65z8KgGhXSIw=;
        b=CRNutOBDre83ONajAQ009LldpJ8dAFhd2csHUOezk3rezrdQqNMUVmMrB5cTc3vJLK
         Csm6FI/qYlTNOicsgJRTd/UWYt15uLdKySskcq+KI2M3+BJg4645ghygx5g3sBGbHy7p
         R0Hfo9sPw4vqe4ObJyEduLo/bSA4DL06LT6c4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693000697; x=1693605497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5vqh0pjH8L8vsEX9VZkjGRGPe8QVst65z8KgGhXSIw=;
        b=ahB1VvpK0qAva+mMH4KArDyTqUs8b2BJmePU06rFSYz+3AfGupCKBrBVbW4MCMncL3
         7YNt0xbNRqh8T+Gmwo9fyLNen+nXCVDADgkPwqvmhsw60pv/7Dcpx2MwyIocJ5b/e4ru
         GVqMmOeIl/r2Tsq+n0eX5fVtXC+lOxnPEU4dWPaC4WlgY79LGVXxsjePU/mimQRSsR4T
         QjPYCrGd5l1GvUhpin5Kw3u/yqTcfYBEEkm0nq0Q9QSw9xzTAmYrXXdajVw8D8yrWnfq
         g16rrnxRVAdR8YGaQKVSWvmXhe+x218vVKzxJMDBXtxx3XXaZ5QeYh9UEluLO3y8ENFd
         7GIg==
X-Gm-Message-State: AOJu0YwjYeA/1VCMGOnUkmO9qr/sus/tTZRVLPn91e5aDXsdxi0mOC3c
        XMA8srSpm8D84spnci+zM+pDax6BsIPz56lIstaRJQ==
X-Google-Smtp-Source: AGHT+IGdqcxGUdtsYaSQwsqeHr5TkC+cPTnwnUiaCjnoQ5ixD2HaM2taIxW6UTWB82xGQH2Q01NmpQ==
X-Received: by 2002:a2e:2c05:0:b0:2b6:e618:b5a0 with SMTP id s5-20020a2e2c05000000b002b6e618b5a0mr15313057ljs.6.1693000696627;
        Fri, 25 Aug 2023 14:58:16 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id h1-20020a1709062dc100b0098921e1b064sm1351411eji.181.2023.08.25.14.58.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 14:58:15 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3fe2d620d17so28795e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 14:58:15 -0700 (PDT)
X-Received: by 2002:a05:600c:501e:b0:3f7:e4d8:2569 with SMTP id
 n30-20020a05600c501e00b003f7e4d82569mr31887wmr.5.1693000695582; Fri, 25 Aug
 2023 14:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230804210644.1862287-1-dianders@chromium.org>
 <20230804140605.RFC.4.I930069a32baab6faf46d6b234f89613b5cec0f14@changeid> <bphkopaq76imqzut7xrx7aprqybhx3veajdympqhig2wqlix6c@64ck23rc5cv7>
In-Reply-To: <bphkopaq76imqzut7xrx7aprqybhx3veajdympqhig2wqlix6c@64ck23rc5cv7>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 25 Aug 2023 14:58:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XiVkoCsjin4R74nkcd8vzOq9uPq+o5cRjd=YOoPXuQkg@mail.gmail.com>
Message-ID: <CAD=FV=XiVkoCsjin4R74nkcd8vzOq9uPq+o5cRjd=YOoPXuQkg@mail.gmail.com>
Subject: Re: [RFC PATCH 04/10] drm/panel_helper: Introduce drm_panel_helper
To:     Maxime Ripard <mripard@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime,

On Sun, Aug 6, 2023 at 11:41=E2=80=AFPM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> Hi Doug,
>
> Thanks for working on this :)
>
> On Fri, Aug 04, 2023 at 02:06:07PM -0700, Douglas Anderson wrote:
> > The goal of this file is to contain helper functions for panel drivers
> > to use. To start off with, let's add drm_panel_helper_shutdown() for
> > use by panels that want to make sure they're powered off at
> > shutdown/remove time if they happen to be powered on.
> >
> > The main goal of introducting this function is so that panel drivers
> > don't need to track the enabled/prepared state themselves.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> It shouldn't be necessary at all: drivers should call
> drm_atomic_helper_shutdown at removal time which will disable the
> connector (which in turn should unprepare/disable its panel).
>
> If either the driver is missing drm_atomic_helper_shutdown, or if the
> connector doesn't properly disable the panel, then I would consider that
> a bug.

Hmmm. I'm a bit hesitant here. I guess I'm less worried about the
removal time and more worried about the shutdown time.

For removal I'd be fine with just dropping the call and saying it's
the responsibility of the driver to call drm_atomic_helper_shutdown(),
as you suggest. I'd tend to believe that removal of DRM drivers is not
used anywhere in "production" code (or at least not common) and I
think it's super hard to get it right, to unregister and unbind all
the DRM components in the right order. Presumably anyone trying to
remove a DRM panel in a generic case supporting lots of different
hardware is used to it being a bit broken...  Not that it's a super
great situation to be in for remove() not to work reliably, but that's
how I think it is right now.

For shutdown, however, I'm not really OK with just blindly removing
the code that tries to power off the panel. Shutdown is called any
time you reboot a device. That means that if a DRM driver is _not_
calling drm_atomic_helper_shutdown() on the panel's behalf at shutdown
time then the panel won't be powered off properly. This feels to me
like something that might actually matter. Panels tend to be one of
those things that really care about their power sequencing and can
even get damaged (or not turn on properly next time) if sequencing is
not done properly, so just removing this code and putting the blame on
the DRM driver seems scary to me. Sure enough, a quick survey of DRM
drivers shows that many don't call drm_atomic_helper_shutdown() at
.shutdown time. A _very_ quick skim of callers to
drm_atomic_helper_shutdown():

* omapdrm/omap_drv.c - calls at remove, not shutdown
* arm/hdlcd_drv.c - calls at unbind, not shutdown
* arm/malidp_drv.c - calls at unbind, not shutdown
* armada/armada_drv.c - calls at unbind, not shutdown

...huh, actually, there are probably too many to list that don't call
it at shutdown. There are some that do, but also quite a few that
don't. I'm not sure I really want to blindly add
drm_atomic_helper_shutdown() to all those DRM driver's shutdown
callbacks... That feels like asking for someone to flame me...

...but then, what's the way forward? I think normally the panel's
shutdown() callback would happen _before_ the DRM driver's shutdown()
callback, so we can't easily write logic in the panel's shutdown like
"if the DRM panel didn't shut the panel down then print a warning and
shut down the panel". We'd have to somehow invent and register for a
"late shutdown" callback and have the panel use that to shut itself
down if the DRM driver didn't. That seems like a bad idea...

Do you have any brilliant ideas here? I could keep the function as-is
but only have panels only call it at shutdown time if you want. I
could add to the comments and/or the commit message some summary of
the above and that the call is important for panels that absolutely
need to be powered off at shutdown time even if the DRM driver doesn't
do anything special at shutdown... Any other ideas?


-Doug
