Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7C67FD514
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjK2LJR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 06:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbjK2LIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:08:40 -0500
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69F9210C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:08:31 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d9beb865a40so5989166276.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:08:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701256110; x=1701860910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8VdKcHy5PeFkYHqGNDJ3lUZxHHY2sCDNAxHRZAwQzc=;
        b=wkRhRr87xSmDxY80TXcQO1ULusnhkUot4Zp9muht/MtsXUumDmA0nheSST8m1Ko8nt
         xYms6Ozp3XxhjVjUGaWMA1iQ/RyEeaIIujMiTVloCiEXbREW2/vqT8jc+adSRVqzA/76
         dOKlDX5a8F5IOhjP3/amvZoDeoa//RoTtXxtCuYvs8zsRX78TyE4beASnYgPFtvE5k0z
         VaZNSvF+B9J/M5y/4EHGZ33ZfY6r1hPdYhvDUh3/iw4srq/AZuZ/gN9cUu15AdeXinCk
         ypgC7Lk+lzslDBmVQwkocPrtpUNFVSGG12kziW6OsWInMg/Nhn6kLcWu6AIu0nmb9cTt
         6oBg==
X-Gm-Message-State: AOJu0YzeMHh0PQRR3UWRvaNIWgVQochjf79wS0y+wa+qXv8kozrhwrUl
        XMXHyYggkDJLFa/wVhLCunPEGWYr+jDTrA==
X-Google-Smtp-Source: AGHT+IGbxqcy9Y4wtY1yNYkBp8mvDbNGxMuEnywQKErzsORPqOLXjYn3ER9di3ofdu8PhYyYZGcbUA==
X-Received: by 2002:a5b:f4e:0:b0:db3:9a05:a956 with SMTP id y14-20020a5b0f4e000000b00db39a05a956mr18099216ybr.61.1701256110557;
        Wed, 29 Nov 2023 03:08:30 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id i17-20020a25b211000000b00db41482d349sm4126015ybj.57.2023.11.29.03.08.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 03:08:30 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5cc5988f85eso67677827b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:08:30 -0800 (PST)
X-Received: by 2002:a0d:dd04:0:b0:5ae:dff7:6159 with SMTP id
 g4-20020a0ddd04000000b005aedff76159mr19752324ywe.18.1701256109852; Wed, 29
 Nov 2023 03:08:29 -0800 (PST)
MIME-Version: 1.0
References: <b9360c2044a1001b9a5bcb5914611711d040d4fe.1701196029.git.geert+renesas@glider.be>
 <87o7fdbszs.fsf@minerva.mail-host-address-is-not-set> <CAMuHMdUhuO++ZSxh+_TX_6DHHxjPYY20jTppbNZ4FnuBvxxinQ@mail.gmail.com>
 <7hee65pmdl5pajm2kgqld22xfi4iox4s2psswu2mdlfk6u6f7x@w4ecogdx6uj6>
 <CAMuHMdVTZ8LT1yU3e1bbJODecy96TaMX1hq_swqmT6L+mbH3aQ@mail.gmail.com>
 <sw5e3mdtbmywbeo6sok4ul5qe72bb5ltsg5ago2vliqxlahvpl@rcivlupw77a5>
 <CAMuHMdVVb2VfEAgh+59juyTH28EvRMPHEsxT-MUiEQcmJHTD+Q@mail.gmail.com> <u42osuikwzf372mb5xkhiyaycxpmduc5ntyanjlauqca6roeh4@i7zqwu36lzko>
In-Reply-To: <u42osuikwzf372mb5xkhiyaycxpmduc5ntyanjlauqca6roeh4@i7zqwu36lzko>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 29 Nov 2023 12:08:17 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW2wCeHU+4HRoT_CM6noMzQjanmvMk5=Wg0t98tg9o1Qw@mail.gmail.com>
Message-ID: <CAMuHMdW2wCeHU+4HRoT_CM6noMzQjanmvMk5=Wg0t98tg9o1Qw@mail.gmail.com>
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

On Wed, Nov 29, 2023 at 11:50 AM Maxime Ripard <mripard@kernel.org> wrote:
> On Wed, Nov 29, 2023 at 11:10:51AM +0100, Geert Uytterhoeven wrote:
> > On Wed, Nov 29, 2023 at 10:23 AM Maxime Ripard <mripard@kernel.org> wrote:
> > > On Wed, Nov 29, 2023 at 09:58:12AM +0100, Geert Uytterhoeven wrote:
> > > > On Wed, Nov 29, 2023 at 9:35 AM Maxime Ripard <mripard@kernel.org> wrote:
> > > > > On Tue, Nov 28, 2023 at 08:16:18PM +0100, Geert Uytterhoeven wrote:
> > > > > > On Tue, Nov 28, 2023 at 8:03 PM Javier Martinez Canillas
> > > > > > <javierm@redhat.com> wrote:
> > > > > > > Geert Uytterhoeven <geert+renesas@glider.be> writes:
> > > > > > > > The Imagination Technologies PowerVR Series 6 GPU is currently only
> > > > > > > > supported on Texas Instruments K3 AM62x SoCs.  Hence add a dependency on
> > > > > > > > ARCH_K3, to prevent asking the user about this driver when configuring a
> > > > > > > > kernel without Texas Instruments K3 Multicore SoC support.
> > > > > > > >
> > > > > > > > Fixes: 4babef0708656c54 ("drm/imagination: Add skeleton PowerVR driver")
> > > > > > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > >
> > > > > > > In any case, I agree with you that restricting to only K3 makes sense.
> > > > > >
> > > > > > I am looking forward to adding || SOC_AM33XX || ARCH_RENESAS || ...,
> > > > > > eventually ;-)
> > > > >
> > > > > I disagree. This is to handle a generic IP, just like panfrost, lima, or
> > > > > etnaviv, and we certaintly don't want to maintain the Kconfig list of
> > > > > every possible architecture and SoC family it might or might not be
> > > > > found.
> > > >
> > > > While PowerVR is a generic IP, I believe it needs a non-generic
> > > > firmware, which is currently only available for AM62x SoCs.
>
> I just asked, it's not true in most cases. There's some exceptions
> (GX6250 for example) that could require different firmwares depending on
> the SoC it's used in, but it's not the case here.

OK, please tell me how to use it on e.g. R-Car Gen3.

> > > I'm not sure it's actually true, but let's consider it is. Then what? If
> > > the firmware isn't there and/or the DT bits too, then nothing will
> > > happen. We would have wasted a couple of 100kB on a system that is
> > > taking somewhere in the 100MB-10GB range, and that's pretty much it.
> >
> > I am talking about posing the question to the user to enable the driver
> > or not.  Which applies to everyone who configures a kernel.
>
> If that user doesn't use a defconfig, doesn't use any variant of
> *defconfig make target. Plus, the driver still isn't enabled by default.
>
> > > If you have we take that patch in though, we have:
> > >
> > >   - To keep merging patches as firmwares become available.
> >
> > You need to keep merging patches to update DT bindings, DTS,
> > SoC-specific drivers, the DRM driver itself, ... too.
>
> The DT binding and DRM driver is already there, the SoC specific drivers

The DT binding only lists "ti,am62-gpu" with "img,img-axe" as a fallback.

> are probably already there by the time you reach GPU enablement, and the
> DT doesn't have to be upstream.

And getting it upstream requires updating the bindings...

> > >   - If we update linux-firmware only, then the driver is still not
> > >     loading even though it could.
> > >
> > >   - If we have gotten our firmware through some other mean, then the
> > >     driver is still not loading even though it could.
> >
> > You will still need to update parts of the kernel, too.
>
> Not really, no. We can use the AM62x as an example. The only thing that
> was required to enable the driver (excluding the driver itself of
> course) was a single DT patch, without anything you've mentioned so far.

Who added:

Documentation/devicetree/bindings/gpu/img,powervr.yaml-          - ti,am62-gpu
Documentation/devicetree/bindings/gpu/img,powervr.yaml:      - const:
img,img-axe # IMG AXE GPU model/revision is fully discoverable

?

> > As long as none of that has happened, asking about the PowerVR driver
> > on non-AM62x hardware is futile...
>
> Maybe. Just like asking whether you want to enable the UMS driver on
> platforms that don't have a USB controller. Or, closer to us, whether
> you want to enable AMDGPU on platforms without a PCIe bus.
>
> We *never* do that.

Thanks for not checking ;-)

    if USB
    [...]
    source "drivers/usb/storage/Kconfig"

    config DRM_AMDGPU
            tristate "AMD GPU"
            depends on DRM && PCI && MMU

> If only because we can't. We don't have a per-SoC Kconfig option, so
> even if we were to merge your patch, we would still ask about the
> PowerVR driver on, let's say, the AM69 that isn't an AM62x and is just
> as futile according to you. Or for the TDA4VM, or...

That's why we use per-family options.  It's the next best thing we have.

> The other reason is that it's just impossible to maintain. You wouldn't
> expect everyone, once they got their USB support in, to amend the
> Kconfig dependencies for every USB driver out there, would you?

USB devices are (usually) truly generic, and can be plugged in
everywhere you see a USB port.

> > > It makes life harder for everyone: maintainers, users, devs, based on
> > > the state of some external project that might or might not be updated in
> > > sync.
> > >
> > > > Once it becomes truly generic, I'm happy to drop all platform
> > > > dependencies.  Until then, there is no point in asking everyone who
> > > > configures an arm64 kernel about this driver, unless they also enabled
> > > > K3 support.
> > >
> > > Whether it's truly generic, whatever that means, is irrelevant here.
> >
> > It is.
> >
> > BTW, playing the devil's advocate: why is there a dependency on ARM64?
> > PowerVR GPUs are also present on (at least) arm32 and Intel?
>
> I would welcome any patch extending that requirement, or droping that
> requirement.
>
> > Oh, dropping that would expose this question to Linus, causing his
> > wrath to come down on you... ;-)
>
> Don't threaten me with a good time.
>
> Also, it's already the case for AMDGPU or etnaviv, so I'm not sure what
> Linus would have to say about it exactly.

AMDGPU is a PCI device, and can be plugged everywhere you see a PCI
slot.  Etnaviv could indeed use some dependencies...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
