Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12B37FC41B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 20:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346160AbjK1TQ2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Nov 2023 14:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344921AbjK1TQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 14:16:26 -0500
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23850D66
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:16:33 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-daf4f0e3a0fso5659057276.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:16:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198992; x=1701803792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1rEKxL95Ib6FRaTkxx55nHqJypwTeMmzYLzyUcaTGA=;
        b=Qs3mgN2Ygh4w7HDhTKvOeMNCXA/JPCogf9Ijp57wBMj8odCDF7/LH5U+vp1ktte5+v
         WFQ32HKn9lJ4olPtfzP2mH021eTpp9xztuMFPS/y6N1nkRDS2s3AYyUoeqfyO8w6nblT
         CtCmgovitnlcA/q5hsiTT7wGTblfkbuwHowDa38xvz21AzEIHjlcMDQAK6+PHH+CwWdb
         D+uOIF2cKF+Zbd30f8cT6V7KM4sHfG0J9oQBOxwkub8BZ0EUENsNmmFfv8hk6y2NfwZN
         F8GFv6kW9Zim2aqWHhcOardvdDJ2yMFwyPnZZVRTghxcSdRQf5RhXUxJrJY8rkf35/tI
         mmmw==
X-Gm-Message-State: AOJu0YwPKbA8iVtNzD2LsJYBn7Hj8h4MPJCv/4h0JlAcoL95BBRas31Y
        /VTgh4ZH+JtFUpTrD4OGqw/9GONNRqpx7w==
X-Google-Smtp-Source: AGHT+IGQlUtwlrvsdpfXcGak5vBT9ZVW656crlrCUb0FFvmPRfP0PzxuyHz6zg3tUF3NuJDTIU9vFg==
X-Received: by 2002:a25:cf53:0:b0:d9a:3811:9c57 with SMTP id f80-20020a25cf53000000b00d9a38119c57mr17221628ybg.43.1701198992096;
        Tue, 28 Nov 2023 11:16:32 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id f126-20020a255184000000b00d8168e226e6sm3783928ybb.47.2023.11.28.11.16.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 11:16:30 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-da3b4b7c6bdso5644925276.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:16:30 -0800 (PST)
X-Received: by 2002:a25:d611:0:b0:da0:4a6d:bac with SMTP id
 n17-20020a25d611000000b00da04a6d0bacmr16127449ybg.0.1701198990141; Tue, 28
 Nov 2023 11:16:30 -0800 (PST)
MIME-Version: 1.0
References: <b9360c2044a1001b9a5bcb5914611711d040d4fe.1701196029.git.geert+renesas@glider.be>
 <87o7fdbszs.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87o7fdbszs.fsf@minerva.mail-host-address-is-not-set>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Nov 2023 20:16:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUhuO++ZSxh+_TX_6DHHxjPYY20jTppbNZ4FnuBvxxinQ@mail.gmail.com>
Message-ID: <CAMuHMdUhuO++ZSxh+_TX_6DHHxjPYY20jTppbNZ4FnuBvxxinQ@mail.gmail.com>
Subject: Re: [PATCH] drm/imagination: DRM_POWERVR should depend on ARCH_K3
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Frank Binns <frank.binns@imgtec.com>,
        Donald Robson <donald.robson@imgtec.com>,
        Matt Coster <matt.coster@imgtec.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
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

On Tue, Nov 28, 2023 at 8:03 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> Geert Uytterhoeven <geert+renesas@glider.be> writes:
> > The Imagination Technologies PowerVR Series 6 GPU is currently only
> > supported on Texas Instruments K3 AM62x SoCs.  Hence add a dependency on
> > ARCH_K3, to prevent asking the user about this driver when configuring a
> > kernel without Texas Instruments K3 Multicore SoC support.
> >
> > Fixes: 4babef0708656c54 ("drm/imagination: Add skeleton PowerVR driver")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
>
> Indeed. Although I wonder what is the supposed policy since for example
> the DRM_PANFROST symbol only depends on ARM || ARM64 and others such as

I think ARM Mali is sufficiently ubiquitous on ARM/ARM64 systems to
have just an ARM/ARM64 dependency...

> DRM_ETNAVIV don't even have an SoC or architecture dependency.

Vivante GPUs are found in DTS files on at least 4 architectures.
Might be worthwhile to add some dependencies, though...

> In any case, I agree with you that restricting to only K3 makes sense.

I am looking forward to adding || SOC_AM33XX || ARCH_RENESAS || ...,
eventually ;-)

> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
