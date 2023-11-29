Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332367FD3A1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjK2KLB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 05:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjK2KK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:10:59 -0500
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FE4E1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:11:05 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-db498e1132bso3737755276.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:11:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701252665; x=1701857465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pi3TJMcpykPrfIGwW4UJ8iDsoGVZIjDe1r3vVrq4QfQ=;
        b=SGjWUg3WHXt6d1HuJd52o2aMjsEPtgl+7akDn+1LHJtjbKx82s+gjRU7km8iWZKJ5B
         ABFvGq0UBlMggPxFPvWMShVxw8CnDNngtEY/wU6cfwB0vczdaPDpOGXOGeK+tavj6URX
         Y72ZdpkrWGAX+teCA0vRvmI+aThXs0dDIgcXVCfE66iQXEkLDdN3WFsd6GnfP0cItLA7
         v//mMcv5Qc1BBzWcHqI8eq8+AG9i1If9h7gauynJBh+uU8yj1fHqBPiFAaodBq9oavU6
         MckdiOZyBV3ZePP5kfMfCzd97JnuRgSutHlHIC32g3UoFEtbzNaXpZga+RwP+dYlQ6/T
         iKRw==
X-Gm-Message-State: AOJu0YzAulns8MyxvpuTk6gNL/aBqi+vqh8nkNUvJhh5P0KfXEzVBx9v
        9iOiNUsAjIq/VhDOUpdyI+XRKg4F3omR1Q==
X-Google-Smtp-Source: AGHT+IGf2/CHqWferqNR6u6kyus1U97xKkHQhBJCjUhE7IKjnQ+B2ocQDPqfbR/tUXLKSpMsTuRF0w==
X-Received: by 2002:a25:7453:0:b0:d9a:5666:7ab5 with SMTP id p80-20020a257453000000b00d9a56667ab5mr20144516ybc.10.1701252664844;
        Wed, 29 Nov 2023 02:11:04 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id e141-20020a256993000000b00da02a2ef6afsm4134599ybc.30.2023.11.29.02.11.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 02:11:03 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5c08c47c055so64622617b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:11:03 -0800 (PST)
X-Received: by 2002:a0d:c985:0:b0:5cd:6d0e:5369 with SMTP id
 l127-20020a0dc985000000b005cd6d0e5369mr20729304ywd.34.1701252662656; Wed, 29
 Nov 2023 02:11:02 -0800 (PST)
MIME-Version: 1.0
References: <b9360c2044a1001b9a5bcb5914611711d040d4fe.1701196029.git.geert+renesas@glider.be>
 <87o7fdbszs.fsf@minerva.mail-host-address-is-not-set> <CAMuHMdUhuO++ZSxh+_TX_6DHHxjPYY20jTppbNZ4FnuBvxxinQ@mail.gmail.com>
 <7hee65pmdl5pajm2kgqld22xfi4iox4s2psswu2mdlfk6u6f7x@w4ecogdx6uj6>
 <CAMuHMdVTZ8LT1yU3e1bbJODecy96TaMX1hq_swqmT6L+mbH3aQ@mail.gmail.com> <sw5e3mdtbmywbeo6sok4ul5qe72bb5ltsg5ago2vliqxlahvpl@rcivlupw77a5>
In-Reply-To: <sw5e3mdtbmywbeo6sok4ul5qe72bb5ltsg5ago2vliqxlahvpl@rcivlupw77a5>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 29 Nov 2023 11:10:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVVb2VfEAgh+59juyTH28EvRMPHEsxT-MUiEQcmJHTD+Q@mail.gmail.com>
Message-ID: <CAMuHMdVVb2VfEAgh+59juyTH28EvRMPHEsxT-MUiEQcmJHTD+Q@mail.gmail.com>
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

On Wed, Nov 29, 2023 at 10:23 AM Maxime Ripard <mripard@kernel.org> wrote:
> On Wed, Nov 29, 2023 at 09:58:12AM +0100, Geert Uytterhoeven wrote:
> > On Wed, Nov 29, 2023 at 9:35 AM Maxime Ripard <mripard@kernel.org> wrote:
> > > On Tue, Nov 28, 2023 at 08:16:18PM +0100, Geert Uytterhoeven wrote:
> > > > On Tue, Nov 28, 2023 at 8:03 PM Javier Martinez Canillas
> > > > <javierm@redhat.com> wrote:
> > > > > Geert Uytterhoeven <geert+renesas@glider.be> writes:
> > > > > > The Imagination Technologies PowerVR Series 6 GPU is currently only
> > > > > > supported on Texas Instruments K3 AM62x SoCs.  Hence add a dependency on
> > > > > > ARCH_K3, to prevent asking the user about this driver when configuring a
> > > > > > kernel without Texas Instruments K3 Multicore SoC support.
> > > > > >
> > > > > > Fixes: 4babef0708656c54 ("drm/imagination: Add skeleton PowerVR driver")
> > > > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > > > > In any case, I agree with you that restricting to only K3 makes sense.
> > > >
> > > > I am looking forward to adding || SOC_AM33XX || ARCH_RENESAS || ...,
> > > > eventually ;-)
> > >
> > > I disagree. This is to handle a generic IP, just like panfrost, lima, or
> > > etnaviv, and we certaintly don't want to maintain the Kconfig list of
> > > every possible architecture and SoC family it might or might not be
> > > found.
> >
> > While PowerVR is a generic IP, I believe it needs a non-generic
> > firmware, which is currently only available for AM62x SoCs.
>
> I'm not sure it's actually true, but let's consider it is. Then what? If
> the firmware isn't there and/or the DT bits too, then nothing will
> happen. We would have wasted a couple of 100kB on a system that is
> taking somewhere in the 100MB-10GB range, and that's pretty much it.

I am talking about posing the question to the user to enable the driver
or not.  Which applies to everyone who configures a kernel.

> If you have we take that patch in though, we have:
>
>   - To keep merging patches as firmwares become available.

You need to keep merging patches to update DT bindings, DTS,
SoC-specific drivers, the DRM driver itself, ... too.

>   - If we update linux-firmware only, then the driver is still not
>     loading even though it could.
>
>   - If we have gotten our firmware through some other mean, then the
>     driver is still not loading even though it could.

You will still need to update parts of the kernel, too.
As long as none of that has happened, asking about the PowerVR driver
on non-AM62x hardware is futile...

> It makes life harder for everyone: maintainers, users, devs, based on
> the state of some external project that might or might not be updated in
> sync.
>
> > Once it becomes truly generic, I'm happy to drop all platform
> > dependencies.  Until then, there is no point in asking everyone who
> > configures an arm64 kernel about this driver, unless they also enabled
> > K3 support.
>
> Whether it's truly generic, whatever that means, is irrelevant here.

It is.

BTW, playing the devil's advocate: why is there a dependency on ARM64?
PowerVR GPUs are also present on (at least) arm32 and Intel?
Oh, dropping that would expose this question to Linus, causing his
wrath to come down on you... ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
