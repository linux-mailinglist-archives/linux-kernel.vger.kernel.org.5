Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BE5753B3E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbjGNMnr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Jul 2023 08:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbjGNMnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:43:45 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B189ACE
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:43:44 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6b9aadde448so1528638a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689338624; x=1691930624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Px1vO0AvllUBalN0eYcohDkgadNEXWhdZtlNo8lqudc=;
        b=SWtJxpg+6y+jYP6i1TsEDNn2ddWYeWc25pMRLbN/yXpT6ZJ/tm/XPydn1KOfM2QRD7
         aqn3Bf6yACZirGZfAEHED8VxcCmQa51OY0OLnmp/JhFu6wImjoJJoiT/amlvzz8CNqyE
         xMd6zt0O5u9926tIKGwEoYgRlG12s7Ge1FApoTQYGSULVyXITgagEs2GmWI29TiFSQ6C
         at81gcv78CiAwAZbIdjbaIpeta3nkJ+eoUcgjA1zoCDBIAaiimDv3gE45iK7MTkiIx2R
         q9rGlniL9akFA5DjXcnkjnftEM/CfUIg6kD/u6EahyysYVD9CwvL7ID/amyViVCooLSN
         /3ig==
X-Gm-Message-State: ABy/qLauylRIG3k72Z9+c3QiJ0hLKiuE1kE1a+9yTzKDqeQfg0s+rRg4
        unS37im7x47g5R77kvn0yaAPlGO9nPngbA==
X-Google-Smtp-Source: APBJJlHO/ngT5hlOAbejQ5+Nx8tCaVbNAqQ8YhuwEZ7fs5gcvgNslg/CdlGbJKMkG9/YngxQgx5t/w==
X-Received: by 2002:a05:6870:d214:b0:1b3:e267:68ab with SMTP id g20-20020a056870d21400b001b3e26768abmr4972311oac.53.1689338623834;
        Fri, 14 Jul 2023 05:43:43 -0700 (PDT)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id 62-20020a4a1a41000000b00566270e616dsm3845347oof.38.2023.07.14.05.43.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 05:43:43 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-563439ea4a2so1244580eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:43:42 -0700 (PDT)
X-Received: by 2002:a05:6358:913:b0:131:b4c:b868 with SMTP id
 r19-20020a056358091300b001310b4cb868mr5242387rwi.3.1689338622730; Fri, 14 Jul
 2023 05:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689252746.git.geert@linux-m68k.org> <72746f6d9c47f09fc057ad7a4bbb3b7f423af803.1689252746.git.geert@linux-m68k.org>
 <87ilamu7e3.fsf@minerva.mail-host-address-is-not-set> <CAMuHMdV1MXexXuRuvW2ap5KA51q_3h9X8jXdYXtFb2RF-BBLnw@mail.gmail.com>
 <875y6macxu.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <875y6macxu.fsf@minerva.mail-host-address-is-not-set>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Jul 2023 14:43:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUrqwQAaNFONO0KOktrRY_twpktAP6=AeKv_8jjdb5_fA@mail.gmail.com>
Message-ID: <CAMuHMdUrqwQAaNFONO0KOktrRY_twpktAP6=AeKv_8jjdb5_fA@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Fri, Jul 14, 2023 at 2:35 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> > On Fri, Jul 14, 2023 at 12:14 PM Javier Martinez Canillas
> > <javierm@redhat.com> wrote:
> >> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> >> Thanks a lot for your patch, this has been on my TODO for some time!
> >>
> >> > The native display format is monochrome light-on-dark (R1).
> >> > Hence add support for R1, so monochrome applications can avoid the
> >> > overhead of back-and-forth conversions between R1 and XR24.
> >> >
> >> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

> >> > Probably ssd130x->buffer should be allocated on first use.
> >>
> >> Yes, that makes sense.
> >>
> >> > And why not allocate the buffers using devm_kcalloc()?
> >>
> >> I think there are some lifetimes discrepancies between struct device and
> >> struct drm_device objects. But we could use drm_device managed resources
> >> helpers, i.e: drmm_kzalloc().
> >
> > The display should not be updated after .remove(), so I think plain
> > devm_kcalloc() should be fine.
>
> That was precisely my point, that there could be atomic commits even after
> the driver has been removed (e.g: if using DRM fbdev emulation, user-space
> can keep the /dev/fb0 opened and continue updating the framebuffer. That's
> not released until the fd is closed and struct fb_ops .fb_destroy called.
>
> But that's a general rule in DRM, any user-visible resource must not be
> allocated using device managed resources and instead use the drm_device
> managed resources helpers. To make sure that are not released until the
> last call to drm_dev_put():

These buffers are not user-visible, so they should not be accessed
after .remove().  When these are accessed, the next step would be
to write the buffer data to the device, which would also fail miserably,
as the regmap, GPIO, and regulator are hardware resources managed
through devm_*().

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
