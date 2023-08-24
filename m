Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF33D7873FC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241182AbjHXPWY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 24 Aug 2023 11:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241656AbjHXPWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:22:19 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1423B19B0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:22:18 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1a1fa977667so4593230fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692890537; x=1693495337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvbKBvGBb47deB3Uur3bkWNEdVyLXWReh2OEJ/A5lAI=;
        b=Dpe187WEXKIH92G2DCCGgC3RBiIXuYDte4Ha/H21Lw22sZo+8do6Jrc0k8yXrs1caf
         j+jMFM/IC0eyQwPDYuLZP1PwpySTfVMglLsKDyKjboOOdjssPybt8vB/DUmSb9JU1LnR
         +VbgFgHUK3CyCfGlirUGhZInY/3hcESenSV/pGk1xJOXM/0/aPJZZ/m7ZMbRDXzv5h+X
         An8QIGATFubXSVW/NpkRug1tWIj2Fuz/A6Kch5jf60pn2HoK/y4tCHuz6WsPytW+XURU
         H0qWsCrv5MXYP07kH5vAoH49i0mZUpRKSdwOEM134ogxV7eJxP5qCWHVQJpncRE4DEzB
         wDkA==
X-Gm-Message-State: AOJu0Yzl18SXGWtfF/FMNPQ83BOLqo4OJ8lfKKSCQZr+9u7TfjAl5KqC
        pN5p/LAyFhV8QVGRQ33pqGg6Zeq2yOxJjw==
X-Google-Smtp-Source: AGHT+IEdZ4TNXu1xbihkS0Gstihbz1pMrkuc6eWrithcKJ1vdNl5MPrQ0Gt2ExvX8A8XbPBRkAN41w==
X-Received: by 2002:a05:6870:40c6:b0:1c3:91b9:e1e7 with SMTP id l6-20020a05687040c600b001c391b9e1e7mr61078oal.21.1692890537064;
        Thu, 24 Aug 2023 08:22:17 -0700 (PDT)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com. [209.85.210.42])
        by smtp.gmail.com with ESMTPSA id kz18-20020a05687c321200b001c52d7cc508sm8301550oac.33.2023.08.24.08.22.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 08:22:16 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6bc9254a1baso5049357a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:22:16 -0700 (PDT)
X-Received: by 2002:a05:6358:5913:b0:139:b4c0:93c with SMTP id
 g19-20020a056358591300b00139b4c0093cmr17358536rwf.5.1692890536410; Thu, 24
 Aug 2023 08:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692888745.git.geert@linux-m68k.org> <50762fd1694d3b5f6df1bdfa482564adb2ee7f36.1692888745.git.geert@linux-m68k.org>
 <CAPj87rNr7PTcquaz+VzwmXh0mSWSSK25_Fa6uxC2VOfj=wMmcQ@mail.gmail.com>
In-Reply-To: <CAPj87rNr7PTcquaz+VzwmXh0mSWSSK25_Fa6uxC2VOfj=wMmcQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 24 Aug 2023 17:22:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWyMNZJ3seWWHqigLfXwCnp47Xwzs1B6ixOyY+n7cir-A@mail.gmail.com>
Message-ID: <CAMuHMdWyMNZJ3seWWHqigLfXwCnp47Xwzs1B6ixOyY+n7cir-A@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] drm/client: Convert drm_client_buffer_addfb() to drm_mode_addfb2()
To:     Daniel Stone <daniel@fooishbar.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Thu, Aug 24, 2023 at 5:12 PM Daniel Stone <daniel@fooishbar.org> wrote:
> On Thu, 24 Aug 2023 at 16:09, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >         struct drm_client_dev *client = buffer->client;
> > -       struct drm_mode_fb_cmd fb_req = { };
> > -       const struct drm_format_info *info;
> > +       struct drm_mode_fb_cmd2 fb_req = { };
> >         int ret;
> >
> > -       info = drm_format_info(format);
> > -       fb_req.bpp = drm_format_info_bpp(info, 0);
> > -       fb_req.depth = info->depth;
> >         fb_req.width = width;
> >         fb_req.height = height;
> > -       fb_req.handle = handle;
> > -       fb_req.pitch = buffer->pitch;
> > +       fb_req.pixel_format = format;
> > +       fb_req.handles[0] = handle;
> > +       fb_req.pitches[0] = buffer->pitch;
> >
> > -       ret = drm_mode_addfb(client->dev, &fb_req, client->file);
> > +       ret = drm_mode_addfb2(client->dev, &fb_req, client->file);
> >         if (ret)
> >                 return ret;
>
> This should explicitly set the LINEAR modifier (and the modifier flag)
> if the driver supports modifiers.

Thanks for your comment!

I have no idea how to do that, and I do not know what the impact
would be.  All I know is that the current implementation of
drm_client_buffer_addfb() does not do that, so changing that in this
patch would mean that this would no longer be a trivial conversion.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
