Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304ED7FD379
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjK2KDZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 05:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjK2KDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:03:24 -0500
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BB9E1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:03:30 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5cd81e76164so57793837b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:03:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701252209; x=1701857009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dObiGvWh8P2CqEpKI7yz0tGXt/3B108CIDPRJbpF7+s=;
        b=FOMXhZ1GbGTJG+L8dDojDwQMfE8gIyQUzJpc1RWT9ERg/8z6dGHzQ8VbQsqI5nAe4P
         oVewNz3RicFJfhkPj+wTlcMM4iw+EfwyQhWTT8X8rEaxIBb8e3EeHD+6uNpGo/5I0i/v
         QDdByA7YBtjjb++1suUjUDl+E1IBKuchps8eOgRoYLCIt0WXOvrV67BW3Dc4dbht6IhF
         vuFmu8CBp6LuHu8Z69TNpzyMUWvwGWO3Gkc2adzMsJm+GcdYJKxGs2SSViKEdl3sLdXu
         g37vDsKAkdfZe1cQ+54C1BbJ9iXGwV2He1gJxsebGz25o+0hRuecq6XDV3rpVmZmNpbV
         pIHA==
X-Gm-Message-State: AOJu0YxMvj0JItr0VX2wIqzF8VqRkuklIZgjIc7M2Xqb/SUjtC4xDOWq
        NpZy/A14JeCH6ahW49hrjW5cQgx0+n4WBg==
X-Google-Smtp-Source: AGHT+IH8/uoTJ/prLwCmUkxjlSWbbZeEKgTfhfInlsrxFYQWb3vZE7XLgH2msmIdEtxBU4cqAh+Y8w==
X-Received: by 2002:a05:690c:2845:b0:5d0:53a8:725f with SMTP id ed5-20020a05690c284500b005d053a8725fmr8002989ywb.4.1701252209357;
        Wed, 29 Nov 2023 02:03:29 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id b64-20020a0df243000000b00598d67585d7sm4490226ywf.117.2023.11.29.02.03.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 02:03:28 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5cd81e76164so57793587b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:03:28 -0800 (PST)
X-Received: by 2002:a05:690c:c09:b0:5ce:7ac9:d10c with SMTP id
 cl9-20020a05690c0c0900b005ce7ac9d10cmr17048170ywb.32.1701252207822; Wed, 29
 Nov 2023 02:03:27 -0800 (PST)
MIME-Version: 1.0
References: <b9360c2044a1001b9a5bcb5914611711d040d4fe.1701196029.git.geert+renesas@glider.be>
 <87o7fdbszs.fsf@minerva.mail-host-address-is-not-set> <CAMuHMdUhuO++ZSxh+_TX_6DHHxjPYY20jTppbNZ4FnuBvxxinQ@mail.gmail.com>
 <7hee65pmdl5pajm2kgqld22xfi4iox4s2psswu2mdlfk6u6f7x@w4ecogdx6uj6>
 <CAMuHMdVTZ8LT1yU3e1bbJODecy96TaMX1hq_swqmT6L+mbH3aQ@mail.gmail.com> <87cyvsc46y.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87cyvsc46y.fsf@minerva.mail-host-address-is-not-set>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 29 Nov 2023 11:03:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUODXACTmrtTuKZPZT8xFVn611kDU+DTTjRE7Hn2zS0Zg@mail.gmail.com>
Message-ID: <CAMuHMdUODXACTmrtTuKZPZT8xFVn611kDU+DTTjRE7Hn2zS0Zg@mail.gmail.com>
Subject: Re: [PATCH] drm/imagination: DRM_POWERVR should depend on ARCH_K3
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Frank Binns <frank.binns@imgtec.com>,
        Donald Robson <donald.robson@imgtec.com>,
        Matt Coster <matt.coster@imgtec.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sarah Walker <sarah.walker@imgtec.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Wed, Nov 29, 2023 at 10:13 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> > On Wed, Nov 29, 2023 at 9:35 AM Maxime Ripard <mripard@kernel.org> wrote:
> >> On Tue, Nov 28, 2023 at 08:16:18PM +0100, Geert Uytterhoeven wrote:
> >> > On Tue, Nov 28, 2023 at 8:03 PM Javier Martinez Canillas
> >> > <javierm@redhat.com> wrote:
> >> > > Geert Uytterhoeven <geert+renesas@glider.be> writes:
> >> > > > The Imagination Technologies PowerVR Series 6 GPU is currently only
> >> > > > supported on Texas Instruments K3 AM62x SoCs.  Hence add a dependency on
> >> > > > ARCH_K3, to prevent asking the user about this driver when configuring a
> >> > > > kernel without Texas Instruments K3 Multicore SoC support.
> >> > > >
> >> > > > Fixes: 4babef0708656c54 ("drm/imagination: Add skeleton PowerVR driver")
> >> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> >> > > In any case, I agree with you that restricting to only K3 makes sense.
> >> >
> >> > I am looking forward to adding || SOC_AM33XX || ARCH_RENESAS || ...,
> >> > eventually ;-)
> >>
> >> I disagree. This is to handle a generic IP, just like panfrost, lima, or
> >> etnaviv, and we certaintly don't want to maintain the Kconfig list of
> >> every possible architecture and SoC family it might or might not be
> >> found.
> >
> > While PowerVR is a generic IP, I believe it needs a non-generic
> > firmware, which is currently only available for AM62x SoCs.
> > Once it becomes truly generic, I'm happy to drop all platform
> > dependencies.  Until then, there is no point in asking everyone who
> > configures an arm64 kernel about this driver, unless they also enabled
> > K3 support.
>
> That's true but it will require a Kconfig patch every time that there is a
> design with a different SoC using this generic IP.

It also requires a DT bindings patch, to add a new compatible value,
plus whatever missing properties for SoC integration (e.g. resets).
And a DTS integration patch.
And patches for various on-SoC resources (e.g. clocks).
And perhaps a DRM driver update.

> So when should be added? Once there's an upstream DTS that has a GPU device?
> Once there's a firmware for it in linux-firmware?

It can be added when handling the above.  As all patches should be
tested, the firmware must be available first.

When critical mass is reached, platform dependencies can be dropped.
I do hope that will happen rather sooner than later!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
