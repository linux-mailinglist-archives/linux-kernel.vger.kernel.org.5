Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D33E763662
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjGZMdY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Jul 2023 08:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjGZMdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:33:22 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A10F1BF8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 05:33:21 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-583f036d50bso41301567b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 05:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690374800; x=1690979600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9LHJHUg6BbctGmVEztBEPwgY6VD1uKA+BUZbOC1niEM=;
        b=TKO/Y+kYCLtqhEHyI96aaS72OqNS+5tZtHV4yJfEbVKMq3RxxvEKpaVg5603h9H7mW
         9k3pxAtS1296VJnpRhBNoRNyUWs+c1zUlPxG8m90rGE352mry/C4nDtZ0iiXXON+wnQM
         kbBMcKc4Ua1iQShERr+F+Gf674fWIIYTn8oPWSUPAYqtTgjZfXu8mnwIeCaJ4XNJr70f
         4wpL7KVrW/IbiwwtpxFrKnHtv5mA2BmICQ8Qj/QrIhuYJl2mnIpSxubbuQMEjYSj8kyP
         +88pUmTcBQpAhcwd+Kdv5EFSi0SXpPN5irUHflPinEfFIVVPflASMEJ/TpkOi9hXcE18
         bNdQ==
X-Gm-Message-State: ABy/qLaSlwRE9CiyeNq3ad1BntzsBf3iVz9PekS9kFIJDe30h8h1hcem
        hjj2NveNqufpyw0Atsrl5750+cZ9MZ1p0Q==
X-Google-Smtp-Source: APBJJlHOwB9BNYZvI1zCq8mf0LL/C9S7RHRFTUcPg4ON9zeAX6Bm313O9D3hIJl+c1vC5I+ldsuDsA==
X-Received: by 2002:a81:54d5:0:b0:576:a0b8:eb06 with SMTP id i204-20020a8154d5000000b00576a0b8eb06mr1727186ywb.52.1690374799898;
        Wed, 26 Jul 2023 05:33:19 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id i132-20020a81548a000000b005771872a8dbsm4143788ywb.132.2023.07.26.05.33.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 05:33:18 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-c2cf4e61bc6so7350418276.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 05:33:18 -0700 (PDT)
X-Received: by 2002:a25:9c08:0:b0:c76:173c:6718 with SMTP id
 c8-20020a259c08000000b00c76173c6718mr1840007ybo.1.1690374798490; Wed, 26 Jul
 2023 05:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230721070955.1170974-1-javierm@redhat.com> <CAMuHMdVxF80mdTaiXA6Y8Gd59Z7pxkoEphB4ohpVcK1q-+Yy=g@mail.gmail.com>
 <n4fmda4zw4vuezvwva35tgma3yqhdvb253q2tfdyauoxbfqshx@s6fsa7de6g5s>
 <CAMuHMdXtOozswqujA1h2spL8J86n65Q6=+z=5Jbb0nSXaBwqzA@mail.gmail.com> <874jlqlv5v.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <874jlqlv5v.fsf@minerva.mail-host-address-is-not-set>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Jul 2023 14:33:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX+J848ckG2JqsuDkRcWzRypw_Kv=0G+Hc329xstu_nqQ@mail.gmail.com>
Message-ID: <CAMuHMdX+J848ckG2JqsuDkRcWzRypw_Kv=0G+Hc329xstu_nqQ@mail.gmail.com>
Subject: Re: [PATCH v4] drm/ssd130x: Allocate buffers in the plane's
 .atomic_check callback
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Wed, Jul 26, 2023 at 2:22 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> > On Wed, Jul 26, 2023 at 12:00 PM Maxime Ripard <mripard@kernel.org> wrote:
> >> On Tue, Jul 25, 2023 at 09:21:52PM +0200, Geert Uytterhoeven wrote:
> >> > > --- a/drivers/gpu/drm/solomon/ssd130x.c
> >> > > +++ b/drivers/gpu/drm/solomon/ssd130x.c
> >> > > @@ -141,12 +141,26 @@ const struct ssd130x_deviceinfo ssd130x_variants[] = {
> >> > >  };
> >> > >  EXPORT_SYMBOL_NS_GPL(ssd130x_variants, DRM_SSD130X);
> >> > >
> >> > > +struct ssd130x_plane_state {
> >> > > +       struct drm_plane_state base;
> >> > > +       /* Intermediate buffer to convert pixels from XRGB8888 to R1 */
> >> > > +       u8 *buffer;
> >> > > +       /* Buffer that contains R1 pixels to be written to the panel */
> >> > > +       u8 *data_array;
> >> >
> >> > The second buffer actually contains pixels in hardware format.
> >> > For now that is a transposed buffer of R1 pixels, but that will change
> >> > when you will add support for greyscale displays.
> >> >
> >> > So I'd write "hardware format" instead of R1 for both.
> >> >
> >> > BTW, I still think data_array should be allocated during probing,
> >> > as it is related to the hardware, not to a plane.
> >>
> >> I somewhat disagree.
> >>
> >> If I understood right during our discussion with Javier, the buffer size
> >> derives from the mode size (height and width).
> >>
> >> In KMS, the mode is tied to the KMS state, and thus you can expect the
> >> mode to change every state commit. So the more logical thing to do is to
> >> tie the buffer size (and thus the buffer pointer) to the state since
> >> it's only valid for that particular state for all we know.
> >>
> >> Of course, our case is allows use to simplify things since it's a fixed
> >> mode, but one of Javier's goal with this driver was to provide a good
> >> example we can refer people to, so I think it's worth keeping.
> >
> > The second buffer (containing the hardware format) has a size that
> > depends on the full screen size, not the current mode (I believe that's
> > also the size of the frame buffer backing the plane?).  So its size is
> > fixed.
> >
>
> Yes, is fixed. But Maxime's point is that this is a characteristic of this
> particular device and even when the display resolution can't be changed,
> the correct thing to do is to keep all state related to the mode (even the
> buffer used to store the hardware pixels that are written to the display)
>
> > Given the allocations are now done based on plane state, I think the
> > first buffer should be sized according to the frame buffer backing
> > the plane? Currently it uses the full screen size, too (cfr. below).
> >
>
> But can the mode even be changed if ssd130x_connector_helper_get_modes()
> just adds a single display mode with mode->hdisplay == ssd130x->width and
> mode->vdisplay == ssd130x->height.

No, the mode cannot be changed.

At first, I thought you could still create a smaller frame buffer,
and attach that to the (single, thus primary) plane, but it turns out
I was wrong[*], so you can ignore that.

[*] ssd130x_primary_plane_helper_atomic_check() calls
    drm_plane_helper_atomic_check(), which calls
    drm_atomic_helper_check_plane_state() with can_position = false.
    As the position of planes is actually a software thing on ssd130x,
    positioning support could be added later, though...

> >> Also, Javier pointed me to a discussion you had on IRC about using devm
> >> allocation here. We can't really do that. KMS devices are only freed
> >> once the last userspace application closes its fd to the device file, so
> >> you have an unbounded window during which the driver is still callable
> >> by userspace (and thus can still trigger an atomic commit) but the
> >> buffer would have been freed for a while.
> >
> > It should still be safe for (at least) the data_array buffer. That
> > buffer is only used to store pixels in hardware format, and immediately
> > send them to the hardware.  If this can be called that late, it will
> > fail horribly, as you can no longer talk to the hardware at that point
> > (as ssd130x is an i2c driver, it might actually work; but a DRM driver
> >  that calls devm_platform_ioremap_resource() will crash when writing
> >  to its MMIO registers)?!?
>
> At the very least the SPI driver will fail since the GPIO that is used to
> toggle the D/C pin is allocated with devm_gpiod_get_optional(), but also
> the regulator, backlight device, etc.
>
> But in any case, as mentioned it is only relevant if the data_array buffer
> is allocated at probe time, and from Maxime's explanation is more correct
> to do it in the .atomic_check handler.

You need (at least) data_array for clear_screen, too, which is called
from .atomic_disable().

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
