Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06D87FD181
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjK2I6X convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 03:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjK2I6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:58:19 -0500
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A78F5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:58:26 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5cd3c4457a0so63126057b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:58:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701248305; x=1701853105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7R/KGp93btDjGWFKKu/IcOnp8F5jcJhWKyHePUJieV4=;
        b=j7WfLoQHySsyRT6T1u1l++9JlQYmq385RWoHpp94O5IvFR5wFzPEQDbyc4ewaW67gC
         tQhVNDiuaFv0sUvUrPdDRqoNPGY4aETRicLvzbG79aT4S1VrkyjTclhSVadRzG+yDrgb
         jN5+E+Ruo+nLXbFh3vUs1fJwJILQ7SGIzai+1ldHNJWWVQddLgLeCtWYybUF+1BVBod3
         8fG34StapXI2h/OxLdk7gdX59WFd1vPyO7Z5vtlX4i/a5mtICcAXAti2xECR+Bsuw6w/
         ilpurCw0D+bZRCG5rC5HfQgwoVpBRpVh6SYUYyUGY1hrQ2RnnnjKcO5zXCE+qg1oLI4z
         iYPw==
X-Gm-Message-State: AOJu0Yxo2tE12ZgFdpHY5qMxKzCA6zLZTaEKhOaAcW23AXXcLXiyOSE0
        QaPpz+Xbt+RISuNAk/RePsuuVmwieOxd1A==
X-Google-Smtp-Source: AGHT+IGfHVrnc1/cQLNSJWQLLaz9bcz+B8IVeUnQh20GGKJIPP8xW9X0T8LFbGUZ55iTUUdPgGLvgw==
X-Received: by 2002:a05:690c:3007:b0:5d0:3a64:4a2e with SMTP id ey7-20020a05690c300700b005d03a644a2emr8132416ywb.16.1701248305237;
        Wed, 29 Nov 2023 00:58:25 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id s64-20020a817743000000b005956b451fb8sm4372794ywc.100.2023.11.29.00.58.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 00:58:24 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5cc589c0b90so65496987b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:58:24 -0800 (PST)
X-Received: by 2002:a81:9a97:0:b0:5d2:b29a:5e08 with SMTP id
 r145-20020a819a97000000b005d2b29a5e08mr135066ywg.17.1701248304126; Wed, 29
 Nov 2023 00:58:24 -0800 (PST)
MIME-Version: 1.0
References: <b9360c2044a1001b9a5bcb5914611711d040d4fe.1701196029.git.geert+renesas@glider.be>
 <87o7fdbszs.fsf@minerva.mail-host-address-is-not-set> <CAMuHMdUhuO++ZSxh+_TX_6DHHxjPYY20jTppbNZ4FnuBvxxinQ@mail.gmail.com>
 <7hee65pmdl5pajm2kgqld22xfi4iox4s2psswu2mdlfk6u6f7x@w4ecogdx6uj6>
In-Reply-To: <7hee65pmdl5pajm2kgqld22xfi4iox4s2psswu2mdlfk6u6f7x@w4ecogdx6uj6>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 29 Nov 2023 09:58:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVTZ8LT1yU3e1bbJODecy96TaMX1hq_swqmT6L+mbH3aQ@mail.gmail.com>
Message-ID: <CAMuHMdVTZ8LT1yU3e1bbJODecy96TaMX1hq_swqmT6L+mbH3aQ@mail.gmail.com>
Subject: Re: [PATCH] drm/imagination: DRM_POWERVR should depend on ARCH_K3
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
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

Hi Maxime,

On Wed, Nov 29, 2023 at 9:35 AM Maxime Ripard <mripard@kernel.org> wrote:
> On Tue, Nov 28, 2023 at 08:16:18PM +0100, Geert Uytterhoeven wrote:
> > On Tue, Nov 28, 2023 at 8:03 PM Javier Martinez Canillas
> > <javierm@redhat.com> wrote:
> > > Geert Uytterhoeven <geert+renesas@glider.be> writes:
> > > > The Imagination Technologies PowerVR Series 6 GPU is currently only
> > > > supported on Texas Instruments K3 AM62x SoCs.  Hence add a dependency on
> > > > ARCH_K3, to prevent asking the user about this driver when configuring a
> > > > kernel without Texas Instruments K3 Multicore SoC support.
> > > >
> > > > Fixes: 4babef0708656c54 ("drm/imagination: Add skeleton PowerVR driver")
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > > In any case, I agree with you that restricting to only K3 makes sense.
> >
> > I am looking forward to adding || SOC_AM33XX || ARCH_RENESAS || ...,
> > eventually ;-)
>
> I disagree. This is to handle a generic IP, just like panfrost, lima, or
> etnaviv, and we certaintly don't want to maintain the Kconfig list of
> every possible architecture and SoC family it might or might not be
> found.

While PowerVR is a generic IP, I believe it needs a non-generic
firmware, which is currently only available for AM62x SoCs.
Once it becomes truly generic, I'm happy to drop all platform
dependencies.  Until then, there is no point in asking everyone who
configures an arm64 kernel about this driver, unless they also enabled
K3 support.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
