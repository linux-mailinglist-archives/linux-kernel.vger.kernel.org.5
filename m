Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D367B7638D1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbjGZOQg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Jul 2023 10:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbjGZOQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:16:16 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A202D42
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:15:06 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6b9c9944da8so5618300a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690380858; x=1690985658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYmXF6+fhXjo5iXeYGhM12iR95vAqcFzUbgaNOIrO3o=;
        b=ARCVNh9u84aWPUOC95raEa3iUzmQ9tpqsM6QnlQRsG+yO+MEF0KJHS3G47IfJnqBGo
         WYgxite+YQxJz5U0J8sUh1HDA/4wWEV0ueJGvf976FNroIWflWGDzWXpMNQqjTRQ8NlH
         5JcWp+0OOUqFy/vVU3ZBGME3Vnmm/MGCi0lIo5LKJ1qrnpQPIgULVfsharpkRyYMjuGJ
         sqsNRVfI701Y3t90QX50q+RK7BjyL5wbP4tir7Xl2BSopN2FhPyVG3ZNelnN8uGckZyY
         CqxScExsoEB7YLvhrTE/aHmWshF64SRj5pf7DS9kyOGogtiqiBGscjaMdn7fvw7K5Xb0
         QY/w==
X-Gm-Message-State: ABy/qLZbRhlUObcPdHmuewVnSe9ZSCrkIy9iIjBz6+IeHR7AREChDkC3
        VFMYIqcmFvzdis3mrggfv6A/bo/IJLQxJQ==
X-Google-Smtp-Source: APBJJlEv2QIOCdbp+Cs87QsJXehkB+z5hXs71D1N0BoIoR5rzBOHygqpFE4JyiWuStiGWiKRJf/8uA==
X-Received: by 2002:a05:6358:7e12:b0:135:a5fe:53e1 with SMTP id o18-20020a0563587e1200b00135a5fe53e1mr2165108rwm.14.1690380857982;
        Wed, 26 Jul 2023 07:14:17 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id y1-20020a056902052100b00d0fe6cb4741sm1668367ybs.25.2023.07.26.07.14.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 07:14:17 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-c11e2b31b95so7149362276.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:14:17 -0700 (PDT)
X-Received: by 2002:a25:828c:0:b0:d0b:5a37:1aa0 with SMTP id
 r12-20020a25828c000000b00d0b5a371aa0mr1586828ybk.36.1690380856985; Wed, 26
 Jul 2023 07:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230721070955.1170974-1-javierm@redhat.com> <CAMuHMdVxF80mdTaiXA6Y8Gd59Z7pxkoEphB4ohpVcK1q-+Yy=g@mail.gmail.com>
 <n4fmda4zw4vuezvwva35tgma3yqhdvb253q2tfdyauoxbfqshx@s6fsa7de6g5s>
 <CAMuHMdXtOozswqujA1h2spL8J86n65Q6=+z=5Jbb0nSXaBwqzA@mail.gmail.com>
 <874jlqlv5v.fsf@minerva.mail-host-address-is-not-set> <CAMuHMdX+J848ckG2JqsuDkRcWzRypw_Kv=0G+Hc329xstu_nqQ@mail.gmail.com>
 <g6bu3b26evk464x4cn77xnzjiuotsq7pfvyakfvwnir5e3ihnk@2jh4dd56fsza>
In-Reply-To: <g6bu3b26evk464x4cn77xnzjiuotsq7pfvyakfvwnir5e3ihnk@2jh4dd56fsza>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Jul 2023 16:14:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX54sYfv2HJQZxMD_O2XT_nmuoQEE2iTbWkJ9-QvfAWYQ@mail.gmail.com>
Message-ID: <CAMuHMdX54sYfv2HJQZxMD_O2XT_nmuoQEE2iTbWkJ9-QvfAWYQ@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Wed, Jul 26, 2023 at 3:54 PM Maxime Ripard <mripard@kernel.org> wrote:
> On Wed, Jul 26, 2023 at 02:33:06PM +0200, Geert Uytterhoeven wrote:
> > > >> Also, Javier pointed me to a discussion you had on IRC about using devm
> > > >> allocation here. We can't really do that. KMS devices are only freed
> > > >> once the last userspace application closes its fd to the device file, so
> > > >> you have an unbounded window during which the driver is still callable
> > > >> by userspace (and thus can still trigger an atomic commit) but the
> > > >> buffer would have been freed for a while.
> > > >
> > > > It should still be safe for (at least) the data_array buffer. That
> > > > buffer is only used to store pixels in hardware format, and immediately
> > > > send them to the hardware.  If this can be called that late, it will
> > > > fail horribly, as you can no longer talk to the hardware at that point
> > > > (as ssd130x is an i2c driver, it might actually work; but a DRM driver
> > > >  that calls devm_platform_ioremap_resource() will crash when writing
> > > >  to its MMIO registers)?!?
> > >
> > > At the very least the SPI driver will fail since the GPIO that is used to
> > > toggle the D/C pin is allocated with devm_gpiod_get_optional(), but also
> > > the regulator, backlight device, etc.
> > >
> > > But in any case, as mentioned it is only relevant if the data_array buffer
> > > is allocated at probe time, and from Maxime's explanation is more correct
> > > to do it in the .atomic_check handler.
> >
> > You need (at least) data_array for clear_screen, too, which is called
> > from .atomic_disable().
>
> I'm not sure I get what your concern is?
>
> Even if we entirely disable the plane, the state will not have been
> destroyed yet so you still have at least access to the data_array from
> the old state.

Currently, clearing the screen is done from the plane's .atomic_disable()
callback, so the plane's state should be fine.

But IIUIC, DRM allows the user to enable/disable the display without
creating any plane first, so clearing should be handled in the CRTC's
.atomic_disable() callback instead? Then, would we still have access
to valid plane state?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
