Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A7A79CA95
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbjILIvO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Sep 2023 04:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbjILIvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:51:11 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7851AA;
        Tue, 12 Sep 2023 01:51:07 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5921a962adfso52530297b3.1;
        Tue, 12 Sep 2023 01:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694508667; x=1695113467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozjJz+HbGpK2W+4R2eDfrxms+YTfRjnfcjO2Noa2OiY=;
        b=epAkzD6terbO7AZJBp7s4nG/hPR7t/AUzrYvSo0WcHn4sJmhTqP/LHg/KkXxLt19z6
         Xvu4lNa8jPdJ2K0TL3e72JGZvbIqQhP+DAH5g1/f5z3+diHsrTD52th64Oz+LykkBGNM
         7GJ3/3KMjbD7atlXDXFtuHE2AkBPaEB00agjVif1AUM99szx1CksHgTBal+nEkRynjES
         i11TvNwrkdZt9YRx1clHNwMXfMkmAys2tBlOaSnYc4kZXQ+zcEMfM/yFGG6IUigRZzj5
         I2cF6zAL/L4bMfG/q4BAiPO+cqngPFRSRidWAr8k+ldymnpN52059rI8USNDsAJaefi2
         sfVg==
X-Gm-Message-State: AOJu0YzDkc9sB3OMNHBUWjN4LEuPybMi0+D1u1tyVv+VuTCQs7iGlmKg
        KTKrYNX2ZtWzI/V+iirO1TQt5GrKKtaH2w==
X-Google-Smtp-Source: AGHT+IF4hLoX5S59WIGkjqcZHzH4FmtQKNZJO/4seofGV7qvnUBGrnGWBdaDoqizVVG598jLc9tVCA==
X-Received: by 2002:a0d:e087:0:b0:583:2ce7:2e10 with SMTP id j129-20020a0de087000000b005832ce72e10mr10141228ywe.27.1694508667005;
        Tue, 12 Sep 2023 01:51:07 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id c10-20020a81df0a000000b0059b17647dcbsm2383573ywn.69.2023.09.12.01.51.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 01:51:05 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5924093a9b2so52547267b3.2;
        Tue, 12 Sep 2023 01:51:05 -0700 (PDT)
X-Received: by 2002:a5b:709:0:b0:d80:68d1:b826 with SMTP id
 g9-20020a5b0709000000b00d8068d1b826mr7289924ybq.6.1694508664873; Tue, 12 Sep
 2023 01:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230911205338.2385278-1-arnd@kernel.org> <CAMuHMdWizKkuLEcv8sFFOWPib-0e1onCRuQEZm6OhV592VWUKQ@mail.gmail.com>
 <637afb25-8ee2-4188-9385-27ee6a97ec59@suse.de> <CAMuHMdW63WjidvAovqRz70bMgbLt4cSkOP1xSh7sEcqdwR3tOw@mail.gmail.com>
 <bf4a1cbd-c24e-4def-a523-1a707a1ca5a1@suse.de>
In-Reply-To: <bf4a1cbd-c24e-4def-a523-1a707a1ca5a1@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Sep 2023 10:50:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX2zBmLiXs488RKsVPvj=0rx4tSYj6G9cEhchyEMhZuDg@mail.gmail.com>
Message-ID: <CAMuHMdX2zBmLiXs488RKsVPvj=0rx4tSYj6G9cEhchyEMhZuDg@mail.gmail.com>
Subject: Re: [PATCH] drm: fix up fbdev Kconfig defaults
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Arthur Grillo <arthurgrillo@riseup.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, Sep 12, 2023 at 10:38 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 12.09.23 um 10:18 schrieb Geert Uytterhoeven:
> > On Tue, Sep 12, 2023 at 10:11 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >> Am 12.09.23 um 09:14 schrieb Geert Uytterhoeven:
> >> [...]
> >>>> --- a/drivers/gpu/drm/Kconfig
> >>>> +++ b/drivers/gpu/drm/Kconfig
> >>>> @@ -135,7 +135,7 @@ config DRM_FBDEV_EMULATION
> >>>>           bool "Enable legacy fbdev support for your modesetting driver"
> >>>>           depends on DRM
> >>>>           select FRAMEBUFFER_CONSOLE_DETECT_PRIMARY if FRAMEBUFFER_CONSOLE
> >>>> -       default y
> >>>> +       default FB
> >>>
> >>> While this is true for existing configs, it is no longer true in general,
> >>> as DRM_FBDEV_EMULATION is no longer related to FB.
> >>
> >> Would it make sense to make FRAMEBUFFER_CONSOLE an independent option
> >> and have FBDEV_EMULATION depend on it? Something like this:
> >>
> >> FRAMEBUFFER_CONSOLE
> >>          depends on DRM || FB
> >>          select FB_CORE
> >>
> >> FBDEV_EMULATION
> >>          depends on DRM
> >>          depends on FRAMEBUFFER_CONSOLE
> >>          default y
> >
> > Oops, now you can no longer have FBDEV_EMULATION without
> > FRAMEBUFFER_CONSOLE, which is useful to be able to enable
> > FB_DEVICE...
>
> And if it depends on FB_CORE instead of FRAMEBUFFER_CONSOLE? I'm aware
> that this would require more Kconfig changes than outlined here.
>
>
> >
> > And what's the point (if DRM is enabled) of having FB_CORE with
> > FBDEV_EMULATION disabled?
> >
> >> So if any graphics subsystems are enabled, FRAMEBUFFER_CONSOLE is
> >> select-able. But for DRM, FBDEV_EMULATION disables the console. That
> >
> > Huh?
> >
> > /me looks at his morning coffee, and confirms the cup is empty...
>
> Decaf maybe?
>
> But there's really no need to get snarky. My though is that

Sorry, I was surprised by "FBDEV_EMULATION disables the console",
which is not what the Kconfig snippet you suggested does?

> FRAMEBUFFER_CONSOLE configures an end-user feature. The user sits there
> an thinks "I want a console". FBDEV_EMULATION controls a driver
> functionality. It's not useful by itself, but enables the enduser
> feature. The features would be FRAMEBUFFER_CONSOLE and FRAMEBUFFER_DEVICE.

The latter is currently called FB_DEVICE.

If you want to have this controlled by user-visible features, then
either FRAMEBUFFER_CONSOLE and FRAMEBUFFER_DEVICE should
"select FBDEV_EMULATION if DRM", right?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
