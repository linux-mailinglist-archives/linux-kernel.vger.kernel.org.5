Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8BE7AEEFF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 16:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbjIZOwK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Sep 2023 10:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjIZOwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 10:52:08 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9824E6;
        Tue, 26 Sep 2023 07:52:01 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5a1d0fee86aso38019487b3.2;
        Tue, 26 Sep 2023 07:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695739921; x=1696344721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GeJt2kDkJDREmJCiOFGlfnsT2tn2qZEwAJk2/hTfX/A=;
        b=mKZfX09dwIW1CL9VUU/k7AKmdtn5FLzmKXuJ7CWMrrDzz3YcoFb1fG9Yt4QwHztf1C
         kUKFwQDi0ad9YpxYk9vXLHy5iO+c+o+P/1zlOs1FVmc1UUSK34br7gpSV7ekKpOVMv69
         Zedm9svPQ4pBc4QTvUlKn9Yax1OdO0U66WIBbhYdncbCup/BCdj46NosCizDgryZ9plX
         klKxszuXMx2nWE9r0n6HOW2mJXVyZdAlpBkCo0AtF6kZaeqax5Lo5f/oDtR29WpJEm1I
         oa86k5o+Fhoubdlt6Eag4RdKOyhwxgMEige5al2ayRUmKvjFS+3g9a+0BtulFgF3lVh6
         fnKw==
X-Gm-Message-State: AOJu0Yzy6dF7+7g4vrqcR3GzVFAYqNMvnBcCQTJ1TZNVHueuwyXvW1DZ
        NtN82qrKmLT8MhjcgpG4aUpkKGQlIyEmdA==
X-Google-Smtp-Source: AGHT+IHA9Kwv8b9RsIF/btN0XIzdlR77dl0BD83zmSktk2GgARGXV6ketpyUafK+4HljurNDkPRSKA==
X-Received: by 2002:a81:5245:0:b0:59b:e72a:e40b with SMTP id g66-20020a815245000000b0059be72ae40bmr10149177ywb.6.1695739920709;
        Tue, 26 Sep 2023 07:52:00 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id c7-20020a0dc107000000b0058e37788bf7sm3029319ywd.72.2023.09.26.07.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 07:51:58 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d7f0a60a159so10242142276.0;
        Tue, 26 Sep 2023 07:51:58 -0700 (PDT)
X-Received: by 2002:a25:f211:0:b0:d86:b9d5:124d with SMTP id
 i17-20020a25f211000000b00d86b9d5124dmr5899090ybe.16.1695739918497; Tue, 26
 Sep 2023 07:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694767208.git.geert+renesas@glider.be> <CAMuHMdWfBTKdXvZutg4LvWqBjuz-X=ZjzX0LKPqD=JxYuLoPRw@mail.gmail.com>
 <20230919152428.GB18426@pendragon.ideasonboard.com>
In-Reply-To: <20230919152428.GB18426@pendragon.ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 26 Sep 2023 16:51:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUwBXQ2X6hOm+kcZOteDLMau8x5xUcRJr2zy9dXyVf9Xw@mail.gmail.com>
Message-ID: <CAMuHMdUwBXQ2X6hOm+kcZOteDLMau8x5xUcRJr2zy9dXyVf9Xw@mail.gmail.com>
Subject: Re: [GIT PULL] drm: renesas: shmobile: Atomic conversion + DT support
 (was: Re: [PATCH v4 00/41] drm: renesas: shmobile: Atomic conversion + DT support)
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
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

Hi Laurent, David, Daniel,

On Tue, Sep 19, 2023 at 5:24 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tue, Sep 19, 2023 at 04:28:40PM +0200, Geert Uytterhoeven wrote:
> > The following changes since commit 0663e1da5ba8e6459e3555ac12c62741668c0d30:
> >
> >   drm/dp_mst: Tune down error message during payload addition
> > (2023-09-18 16:38:21 +0300)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git
> > tags/shmob-drm-atomic-dt-tag1
> >
> > for you to fetch changes up to bfea0fa9052aa8d235b24957eb84d9ff20cb87b7:
> >
> >   drm: renesas: shmobile: Add DT support (2023-09-19 15:58:04 +0200)
> >
> > ----------------------------------------------------------------
> > drm: renesas: shmobile: Atomic conversion + DT support
> >
> > Currently, there are two drivers for the LCD controller on Renesas
> > SuperH-based and ARM-based SH-Mobile and R-Mobile SoCs:
> >   1. sh_mobile_lcdcfb, using the fbdev framework,
> >   2. shmob_drm, using the DRM framework.
> > However, only the former driver is used, as all platform support
> > integrates the former.  None of these drivers support DT-based systems.
> >
> > Convert the SH-Mobile DRM driver to atomic modesetting, and add DT
> > support, complemented by the customary set of fixes and improvements.
> >
> > Link: https://lore.kernel.org/r/cover.1694767208.git.geert+renesas@glider.be/
> >
> > This PR is based on today's drm-misc/for-linux-next, to avoid a
> > conflict with commit 775b0669e19f2e4a ("drm/shmobile: Convert to
> > platform remove callback returning void") in drm-misc/for-linux-next

Now drm-misc/for-linux-next (which is still at v6.5-rc2) has been
merged into drm/drm-next (which is at v6.6-rc2), do you want me to
rebase my branch to current drm/drm-next, or any other commit?

Thanks!

> > Thanks for pulling!
> > ----------------------------------------------------------------
> > Geert Uytterhoeven (36):
> >       MAINTAINER: Create entry for Renesas SH-Mobile DRM drivers
>
> I'm technically listed as the maintainer for this driver until Geert
> takes over, so for this pull request,
>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> And after that, shmobile won't need my ack to merge further changes :-)
>
> This is very nice work Geert. I'm looking forward to dropping the
> sh_mobile_lcdcfb driver.

Thank you!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
