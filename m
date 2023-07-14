Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5920275397B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 13:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbjGNL1J convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Jul 2023 07:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbjGNL1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 07:27:08 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF1C358D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 04:27:04 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-bff27026cb0so1673450276.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 04:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689334023; x=1691926023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9d2GJn9eN8pUvgJt/sqbVpEovcEaIR0UrH2yseemVM=;
        b=SfYcYqpz9MwBXCxN22COM4mp0MESHOM6sk1vOSmdYY0CCJwJ6UEAr4pjla61brB66A
         iy1ZhkuM9oKS6f35RY1Oxl222Z/3upGJgNkygFMmjJHf9D3YmNPEJ0eYBjEcncQrdoir
         7gpty5c/LkcQALsme3+HGrvgxllx4x3Ahwwz07IySi9xP9ImbpxPYxOEI/L+63RM1t2j
         /nQ4B19ErbZuka07hoekkb0zEo7Sy3pBCyBLA9PV/8HjgGATF4K/vHtZ4IMQ3drhXtjg
         K2LnzyTQ7o8AgQhryJPXhIYFyY7yd5cf2xmMwHj9JeEIG5wwDMZbH24G5zNV0z4TQWLB
         eSyQ==
X-Gm-Message-State: ABy/qLYMSirHKL/MXjarH4dMMGA+iSOym8WiG0Hc1QcX6pmkW/Jjx0PM
        feU5vZPbxDqFkfvNX5GaOZhFfDkmrx4ihA==
X-Google-Smtp-Source: APBJJlH8vG6Yy3Mu1jrGRvxKZti26vjD+jh3vtYbBH0JWS1bvs+/gtA6Lc+Bm4HdMlOUwU4YiCTgYQ==
X-Received: by 2002:a0d:ee45:0:b0:576:6b83:2466 with SMTP id x66-20020a0dee45000000b005766b832466mr4280334ywe.25.1689334023168;
        Fri, 14 Jul 2023 04:27:03 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id v72-20020a81484b000000b00569ff2d94f6sm2256780ywa.19.2023.07.14.04.27.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 04:27:03 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-579e5d54e68so16976907b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 04:27:03 -0700 (PDT)
X-Received: by 2002:a81:678b:0:b0:57a:6e41:948e with SMTP id
 b133-20020a81678b000000b0057a6e41948emr4381884ywc.11.1689334022850; Fri, 14
 Jul 2023 04:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689252746.git.geert@linux-m68k.org> <72746f6d9c47f09fc057ad7a4bbb3b7f423af803.1689252746.git.geert@linux-m68k.org>
 <87ilamu7e3.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87ilamu7e3.fsf@minerva.mail-host-address-is-not-set>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Jul 2023 13:26:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV1MXexXuRuvW2ap5KA51q_3h9X8jXdYXtFb2RF-BBLnw@mail.gmail.com>
Message-ID: <CAMuHMdV1MXexXuRuvW2ap5KA51q_3h9X8jXdYXtFb2RF-BBLnw@mail.gmail.com>
Subject: Re: [PATCH 4/8] drm/ssd130x: Add support for DRM_FORMAT_R1
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Fri, Jul 14, 2023 at 12:14 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> Thanks a lot for your patch, this has been on my TODO for some time!
>
> > The native display format is monochrome light-on-dark (R1).
> > Hence add support for R1, so monochrome applications can avoid the
> > overhead of back-and-forth conversions between R1 and XR24.
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> > This work interfered with commit 49d7d581ceaf4cf8 ("drm/ssd130x: Don't
> > allocate buffers on each plane update") in drm-misc/for-linux-next,
> > which always allocates the buffer upfront, while it is no longer needed
> > when never using XR24.
>
> you mean R1 here, right ?

I did mean R1. I think you missed the double negation.

> It's still used in ssd130x_clear_screen() though.

I guess it became worthwhile to make ssd130x_clear_screen()
do memset(data_array, 0, ...) and call ssd130x_write_data() directly,
avoiding the pointless reshuffling of black pixels in
ssd130x_update_rect()?

> > Probably ssd130x->buffer should be allocated on first use.
>
> Yes, that makes sense.
>
> > And why not allocate the buffers using devm_kcalloc()?
>
> I think there are some lifetimes discrepancies between struct device and
> struct drm_device objects. But we could use drm_device managed resources
> helpers, i.e: drmm_kzalloc().

The display should not be updated after .remove(), so I think plain
devm_kcalloc() should be fine.

> >  drivers/gpu/drm/solomon/ssd130x.c | 57 ++++++++++++++++++++++---------
> >  1 file changed, 40 insertions(+), 17 deletions(-)
> >
>
> [...]
>
> > +     case DRM_FORMAT_XRGB8888:
> > +             dst_pitch = DIV_ROUND_UP(drm_rect_width(rect), 8);
> > +             buf = ssd130x->buffer;
> > +             if (!buf)
> > +                     return 0;
> > +
>
> I think this check is not needed anymore now that the driver won't attempt
> to update planes for disabled CRTCs ?

Probably. We do need it here when allocating on first use.

> It's OK for me to be paranoid though, specially after the other issue that
> you found. So I'll let you decide if you think is worth to keep the check.

I kept the check as I only moved/shifted that part of the code.

> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
