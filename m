Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7440079C8B7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjILHxT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Sep 2023 03:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjILHxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:53:17 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4D9E73;
        Tue, 12 Sep 2023 00:53:13 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-58dfe2d5b9aso73238157b3.1;
        Tue, 12 Sep 2023 00:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694505192; x=1695109992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6pjXkev8HSFZ8VrviZj3gQLVlyqDHJj7+WTis9YTpk=;
        b=FCIxiUmOKAi5yzzAB0HsDlYGVB+ZYO+W7P+AiISK0euU5ote6zLDB4sFQihpouBgnb
         N56Y4Nj8CFgO//MV5SJJd3ExVlWFJUjJ+U4TxpESYMoLqqMLhzul53Jwqvzicd919fUt
         HeN3NRmXA+XBw3/WpCpQU31GD9Jsrl9vT9aIxNEHPsLvA05VE6E55V+Dbb/S5SE3K2nR
         kpWBmG7+iNH46HfqK6MEehzJSNl114kqpgpLLQT95yNHPPx7JJ1rtD4ViUS6DJ20x+C6
         bb64RBv2eEXSka6aWywqDNIVNbZA254S57Wpmktk8wYH7UMbITv2u1Ib9jvTXXXgnAmz
         wd0A==
X-Gm-Message-State: AOJu0Yyr7ODDlnHimQ6zRYQR7RO15iHSrXgF+1+Cj4PVeF5RrkHfTcA5
        wX2qgYTE5RM6jucxllKcvGEtCBmSZxGK/w==
X-Google-Smtp-Source: AGHT+IFR0Pdc/qYVEbiXUTBJf1ZlxYcdYtpFl7Li73ooZNeL9sC4HDUNsbiu0Kkc6ZnmVoJ/DElIKQ==
X-Received: by 2002:a81:6c05:0:b0:56d:2d82:63de with SMTP id h5-20020a816c05000000b0056d2d8263demr2131564ywc.3.1694505192152;
        Tue, 12 Sep 2023 00:53:12 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id h128-20020a0df786000000b005773ca61111sm2425474ywf.42.2023.09.12.00.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 00:53:11 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-d8032efa2bfso5077342276.1;
        Tue, 12 Sep 2023 00:53:11 -0700 (PDT)
X-Received: by 2002:a25:c786:0:b0:d7b:a78e:6b2d with SMTP id
 w128-20020a25c786000000b00d7ba78e6b2dmr2246302ybe.20.1694505191360; Tue, 12
 Sep 2023 00:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230911205338.2385278-1-arnd@kernel.org> <CAMuHMdWizKkuLEcv8sFFOWPib-0e1onCRuQEZm6OhV592VWUKQ@mail.gmail.com>
 <87a5tr3k92.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87a5tr3k92.fsf@minerva.mail-host-address-is-not-set>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Sep 2023 09:53:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX8azQbC6D0PTHSVqnOX7h8No3wr2-ZxTGDbuwsgOLQgg@mail.gmail.com>
Message-ID: <CAMuHMdX8azQbC6D0PTHSVqnOX7h8No3wr2-ZxTGDbuwsgOLQgg@mail.gmail.com>
Subject: Re: [PATCH] drm: fix up fbdev Kconfig defaults
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Dave Airlie <airlied@redhat.com>,
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

Hi Javier,

On Tue, Sep 12, 2023 at 9:48 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> > On Mon, Sep 11, 2023 at 10:53 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> [...]
>
> >> --- a/drivers/gpu/drm/Kconfig
> >> +++ b/drivers/gpu/drm/Kconfig
> >> @@ -135,7 +135,7 @@ config DRM_FBDEV_EMULATION
> >>         bool "Enable legacy fbdev support for your modesetting driver"
> >>         depends on DRM
> >>         select FRAMEBUFFER_CONSOLE_DETECT_PRIMARY if FRAMEBUFFER_CONSOLE
> >> -       default y
> >> +       default FB
> >
> > While this is true for existing configs, it is no longer true in general,
> > as DRM_FBDEV_EMULATION is no longer related to FB.
>
> Maybe default y if (FB_DEVICE || FRAMEBUFFER_CONSOLE) ?

Which is almost if FB_CORE? ;-)

Won't a dependency on FRAMEBUFFER_CONSOLE here introduce
a circular dependency, when combined with the hunk below?

> >>         help
> >>           Choose this option if you have a need for the legacy fbdev
> >>           support. Note that this support also provides the linux console
> >> diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
> >> index b575cf54174af..83c2d7329ca58 100644
> >> --- a/drivers/video/console/Kconfig
> >> +++ b/drivers/video/console/Kconfig
> >> @@ -74,6 +74,7 @@ config DUMMY_CONSOLE_ROWS
> >>  config FRAMEBUFFER_CONSOLE
> >>         bool "Framebuffer Console support"
> >>         depends on FB_CORE && !UML
> >> +       default DRM_FBDEV_EMULATION
> >
> > Sounds good to me, although it looks a bit strange at first sight
> > (FRAMEBUFFER_CONSOLE defaults to n on a system with real fbdev, but
> > y on emulated fbdev?).
>
> And there Maybe default y if (FB || DRM_FBDEV_EMULATION) ?
>
> > So this is the fix for commit a5ae331edb02b ("drm: Drop select
> > FRAMEBUFFER_CONSOLE for DRM_FBDEV_EMULATION").

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
