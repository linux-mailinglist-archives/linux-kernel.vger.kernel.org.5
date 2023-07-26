Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051377635A9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbjGZLxA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Jul 2023 07:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbjGZLw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:52:56 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDBCA0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:52:52 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-584034c706dso33595187b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690372371; x=1690977171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPtaMIBhEp1qtmBi548Qk+tYezhqSNhMl5ojZr1tw5E=;
        b=FP86RaCmLLjnGzXMMK08pWXxDszAzcaPkpUMsueFronff82SFOfGqRguxlXE4OF7Ei
         NCyJU4MqNEsAX/rrsCpIuvEZUKn68Hx8ZCJe8OlbXNK2DhdOFdxjW5D7fZxhrSy0Bmcx
         zcSvN3U9txrwwjUfiBheFYKNInPARZjlgAmNS/F7+o9BAjD1B9bSCV0hGeiuFipY2bfd
         fnWtIDeIcGlCQpHGodb5Fed646cXfKaxZ4zjAHumjMHciAF7dqXiMLoymwh/ibdoqJE8
         +L0eAi6CDdf2Wbjg2rCcMrY3HAO6OhEDCUxDuYu84ZrMZv2tD4+rr42NGD1PxTpaRKzF
         Jn2A==
X-Gm-Message-State: ABy/qLZApaTPqZpeSYVvtjjw5N617SusNIfcjJaP9m7uaMedM66vQiVD
        SsgAuKV8XsvYdfRNercLjK1ctGFPK1lbGg==
X-Google-Smtp-Source: APBJJlGlkok4AbSqDOp1cUHeAl+WWU0W+RdQtiMLz51wKkjX1XZBkCYXB3qgpqT6GsqRKvWlYc/Abg==
X-Received: by 2002:a81:75c6:0:b0:559:deed:f363 with SMTP id q189-20020a8175c6000000b00559deedf363mr1804318ywc.2.1690372371587;
        Wed, 26 Jul 2023 04:52:51 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id n75-20020a0dcb4e000000b0056d3d7a59cesm4132116ywd.12.2023.07.26.04.52.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 04:52:51 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-cc4f4351ac7so7241755276.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:52:50 -0700 (PDT)
X-Received: by 2002:a05:6902:4eb:b0:c3c:8d58:6f15 with SMTP id
 w11-20020a05690204eb00b00c3c8d586f15mr1437165ybs.47.1690372370413; Wed, 26
 Jul 2023 04:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230721070955.1170974-1-javierm@redhat.com> <CAMuHMdVxF80mdTaiXA6Y8Gd59Z7pxkoEphB4ohpVcK1q-+Yy=g@mail.gmail.com>
 <n4fmda4zw4vuezvwva35tgma3yqhdvb253q2tfdyauoxbfqshx@s6fsa7de6g5s>
In-Reply-To: <n4fmda4zw4vuezvwva35tgma3yqhdvb253q2tfdyauoxbfqshx@s6fsa7de6g5s>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Jul 2023 13:52:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXtOozswqujA1h2spL8J86n65Q6=+z=5Jbb0nSXaBwqzA@mail.gmail.com>
Message-ID: <CAMuHMdXtOozswqujA1h2spL8J86n65Q6=+z=5Jbb0nSXaBwqzA@mail.gmail.com>
Subject: Re: [PATCH v4] drm/ssd130x: Allocate buffers in the plane's
 .atomic_check callback
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
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

Hi Maxime,

On Wed, Jul 26, 2023 at 12:00 PM Maxime Ripard <mripard@kernel.org> wrote:
> On Tue, Jul 25, 2023 at 09:21:52PM +0200, Geert Uytterhoeven wrote:
> > > --- a/drivers/gpu/drm/solomon/ssd130x.c
> > > +++ b/drivers/gpu/drm/solomon/ssd130x.c
> > > @@ -141,12 +141,26 @@ const struct ssd130x_deviceinfo ssd130x_variants[] = {
> > >  };
> > >  EXPORT_SYMBOL_NS_GPL(ssd130x_variants, DRM_SSD130X);
> > >
> > > +struct ssd130x_plane_state {
> > > +       struct drm_plane_state base;
> > > +       /* Intermediate buffer to convert pixels from XRGB8888 to R1 */
> > > +       u8 *buffer;
> > > +       /* Buffer that contains R1 pixels to be written to the panel */
> > > +       u8 *data_array;
> >
> > The second buffer actually contains pixels in hardware format.
> > For now that is a transposed buffer of R1 pixels, but that will change
> > when you will add support for greyscale displays.
> >
> > So I'd write "hardware format" instead of R1 for both.
> >
> > BTW, I still think data_array should be allocated during probing,
> > as it is related to the hardware, not to a plane.
>
> I somewhat disagree.
>
> If I understood right during our discussion with Javier, the buffer size
> derives from the mode size (height and width).
>
> In KMS, the mode is tied to the KMS state, and thus you can expect the
> mode to change every state commit. So the more logical thing to do is to
> tie the buffer size (and thus the buffer pointer) to the state since
> it's only valid for that particular state for all we know.
>
> Of course, our case is allows use to simplify things since it's a fixed
> mode, but one of Javier's goal with this driver was to provide a good
> example we can refer people to, so I think it's worth keeping.

The second buffer (containing the hardware format) has a size that
depends on the full screen size, not the current mode (I believe that's
also the size of the frame buffer backing the plane?).  So its size is
fixed.

Given the allocations are now done based on plane state, I think the
first buffer should be sized according to the frame buffer backing
the plane? Currently it uses the full screen size, too (cfr. below).

> > > @@ -159,23 +173,23 @@ static int ssd130x_buf_alloc(struct ssd130x_device *ssd130x)
> > >
> > >         pitch = drm_format_info_min_pitch(fi, 0, ssd130x->width);
> > >
> > > -       ssd130x->buffer = kcalloc(pitch, ssd130x->height, GFP_KERNEL);
> > > -       if (!ssd130x->buffer)
> > > +       ssd130x_state->buffer = kcalloc(pitch, ssd130x->height, GFP_KERNEL);

Based on full screen width and height.

> > > +       if (!ssd130x_state->buffer)
> > >                 return -ENOMEM;
> > >
> > > -       ssd130x->data_array = kcalloc(ssd130x->width, pages, GFP_KERNEL);
> > > -       if (!ssd130x->data_array) {
> > > -               kfree(ssd130x->buffer);
> > > +       ssd130x_state->data_array = kcalloc(ssd130x->width, pages, GFP_KERNEL);

Based on full screen width and height (hardware page size).

> > > +       if (!ssd130x_state->data_array) {
> > > +               kfree(ssd130x_state->buffer);
> >
> > Should ssd130x_state->buffer be reset to NULL here?
> > I.e. if .atomic_check() fails, will .atomic_destroy_state() be called,
> > leading to a double free?
>
> That's a good question.
>
> I never really thought of that, but yeah, AFAIK atomic_destroy_state()
> will be called when atomic_check() fails.
>
> Which means that it's probably broken in a lot of drivers.
>
> Also, Javier pointed me to a discussion you had on IRC about using devm
> allocation here. We can't really do that. KMS devices are only freed
> once the last userspace application closes its fd to the device file, so
> you have an unbounded window during which the driver is still callable
> by userspace (and thus can still trigger an atomic commit) but the
> buffer would have been freed for a while.

It should still be safe for (at least) the data_array buffer. That
buffer is only used to store pixels in hardware format, and immediately
send them to the hardware.  If this can be called that late, it will
fail horribly, as you can no longer talk to the hardware at that point
(as ssd130x is an i2c driver, it might actually work; but a DRM driver
 that calls devm_platform_ioremap_resource() will crash when writing
 to its MMIO registers)?!?

> > > +static struct drm_plane_state *ssd130x_primary_plane_duplicate_state(struct drm_plane *plane)
> > > +{
> > > +       struct ssd130x_plane_state *old_ssd130x_state;
> > > +       struct ssd130x_plane_state *ssd130x_state;
> > > +
> > > +       if (WARN_ON(!plane->state))
> > > +               return NULL;
> > > +
> > > +       old_ssd130x_state = to_ssd130x_plane_state(plane->state);
> > > +       ssd130x_state = kmemdup(old_ssd130x_state, sizeof(*ssd130x_state), GFP_KERNEL);
> >
> > I know this is the standard pattern, but the "dup" part is a bit
> > silly here:
> >   - The ssd130x-specific parts in ssd130x_plane_state are zeroed below,
> >   - The base part is copied again in
> >     __drm_atomic_helper_plane_duplicate_state).
> > So (for now) you might as well just call kzalloc() ;-)
>
> Still if we ever add a field in the state structure, it will be
> surprising that it's not copied over.
>
> The code is there and looks good to me, so I'd rather keep it.

Fair enough, let's keep it.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
