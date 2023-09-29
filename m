Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1D47B2FA8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 12:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbjI2KD5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 29 Sep 2023 06:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjI2KDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:03:53 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7C7C0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 03:03:49 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6c4d625da40so6664923a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 03:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695981829; x=1696586629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTXbPlYpsMiuCcRFcRIzs7rP8dy9t2PLSeQxuACbVxk=;
        b=uJ/y12PcqxlBVIIWEJseXCpDWwT8jRTXMaEbUVUBCKoozKeZzFFGYlC8YEkTKnxglO
         el+4I7jpabvEb/3bGdIjntWZ9mz4CGGB+OAGlYKGPQi4IalJmFgjr/YlbLZJGNSKHELM
         GnRByy6QC4Zxrsh3sLuIFyy2+uPhbpNuGrfL2QEpoLHOOrMSBnYsJ+G8Ia7OqNycxDcC
         VvLQXxyXc3udv4wgj4339H/D/VD9pz6w9Di2qScp05BquDNKWFxJPwlKF+aaHF9LzdMt
         jo/GlRwBQnEAZJ3n+LhsyLS3DliGcEsHE4kaPqeI6pyXPPndk5WcOtxOTudYjOA8qnTc
         9BLQ==
X-Gm-Message-State: AOJu0Ywu5X2weeuyjLmg5rxPTaRo7/k8goDk+Jgd68x258hqWpuTHzQo
        t0tYPAD1RcQT7Xv7sPmLMqA1QR8A41xDLLcu
X-Google-Smtp-Source: AGHT+IGlzYgBGVhZPbnBOjYYBb1tJd1+Z/j7jtRoGZCp+Wf+K+ddxODoXqCT/v216ME8Silh3/9iaw==
X-Received: by 2002:a05:6830:1555:b0:6c4:948d:a957 with SMTP id l21-20020a056830155500b006c4948da957mr4379750otp.3.1695981828023;
        Fri, 29 Sep 2023 03:03:48 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id s125-20020a0de983000000b005925c896bc3sm5328436ywe.53.2023.09.29.03.03.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 03:03:47 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-59f6e6b206fso119797387b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 03:03:47 -0700 (PDT)
X-Received: by 2002:a81:6e85:0:b0:57a:f72:ebf8 with SMTP id
 j127-20020a816e85000000b0057a0f72ebf8mr3927704ywc.28.1695981827313; Fri, 29
 Sep 2023 03:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <6f30b86b83b972e9902b62295f397a20512d5507.1695977960.git.geert@linux-m68k.org>
 <dd94cc5b-4918-0342-4781-69a031ab2d1f@vivier.eu>
In-Reply-To: <dd94cc5b-4918-0342-4781-69a031ab2d1f@vivier.eu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 29 Sep 2023 12:03:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWOMbYqYurJ_KnxmY75soNsA=TBea6b2VZAG7eJRPy-mg@mail.gmail.com>
Message-ID: <CAMuHMdWOMbYqYurJ_KnxmY75soNsA=TBea6b2VZAG7eJRPy-mg@mail.gmail.com>
Subject: Re: [PATCH] m68k: defconfig: Update virt_defconfig for v6.6-rc3
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Fri, Sep 29, 2023 at 11:44 AM Laurent Vivier <laurent@vivier.eu> wrote:
> Le 29/09/2023 à 11:01, Geert Uytterhoeven a écrit :
> >    - Enable CONFIG_DRM_FBDEV_EMULATION and CONFIG_FB_DEVICE (no longer
> >      auto-enabled since commit bb6c4507fe825f1b ("drm: fix up fbdev
> >      Kconfig defaults")),
> >    - Drop CONFIG_FRAMEBUFFER_CONSOLE=y (auto-enabled since commit
> >      bb6c4507fe825f1b ("drm: fix up fbdev Kconfig defaults")).
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> > Perhaps CONFIG_FB_DEVICE should not be enabled?
>
> Why do you think it should not be enabled?

Because virt uses virtio_gpudrm.

> I think X was needing this to work on m68k.

Perhaps a version of X or Wayland can work with virtio_gpudrm
directly, without needing DRM's fbdev emulation and /dev/fb0?

DRM's fbdev emulation is still needed for the text console, of course.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
