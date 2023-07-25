Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5247D761E64
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjGYQXl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Jul 2023 12:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbjGYQXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:23:34 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F8626AE;
        Tue, 25 Jul 2023 09:23:29 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-583d702129cso33736457b3.3;
        Tue, 25 Jul 2023 09:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690302208; x=1690907008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RWDVJ0AjoNsrk9M4DPO9gyxQKQ5zdHdLwPZslQUT8gk=;
        b=AbiVbwOjz9OaSSywYi8eVPMj5tE/6XgnjInGurYEIgZQGF0HQCcu4KmWq63yzyWSJG
         3YYYi3SEJscTQjjtIAwJDJUTh2Sa6ZivdFNYN86BQmAE4qAC5DFQV8a7RZioGk1S3shm
         GeEQ8h4P0ivXPxwfhm1g/QldQPNdZAp4M5sXdv7NrHUwuAvXypl+dypbVr3Ic8ejSCDo
         wX5hF/ZbCyXmdl3Z3TU8qqr5VamW1WHI5h5m6Y23yIZlwOIKXrcpYn/o2oH3vOu7GAoy
         KfOa2CExkd3uS2LCb8Wj+4kEdRqwf988FMyxdjCjPh0NCgq1vvg5jvbIOZeysZbUsW37
         RQ1Q==
X-Gm-Message-State: ABy/qLbeN4+lKIUHEhwLHUTY792WruEz5ku9bXntzH1mKiCD/TTTVl4K
        7BrbsnxmwjqWWNMkCZ9bGlnhlHOQw6O/fQ==
X-Google-Smtp-Source: APBJJlHolW2sQAccUJKzqjZLCyPsiKlwtr19EssWz4swGm8tLCpbhi0FHKXA4zm6fS4WQEXBi6Eutg==
X-Received: by 2002:a81:9205:0:b0:579:dfac:f507 with SMTP id j5-20020a819205000000b00579dfacf507mr11183630ywg.34.1690302208614;
        Tue, 25 Jul 2023 09:23:28 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id q128-20020a818086000000b0055a07c7be39sm3648018ywf.31.2023.07.25.09.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 09:23:28 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-d0548cf861aso4742905276.3;
        Tue, 25 Jul 2023 09:23:27 -0700 (PDT)
X-Received: by 2002:a25:9d01:0:b0:d09:d53:ce41 with SMTP id
 i1-20020a259d01000000b00d090d53ce41mr7792077ybp.55.1690302207767; Tue, 25 Jul
 2023 09:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <5ab3d1fe7b67ab10e4bc1bdbc0fa7731f7960965.1690300189.git.geert+renesas@glider.be>
 <87a5vkj7qe.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87a5vkj7qe.fsf@minerva.mail-host-address-is-not-set>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Jul 2023 18:23:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWBznkqYxCWD2uwGtWLqXnBqX1Ycg31fBDc4cq2u8DkNQ@mail.gmail.com>
Message-ID: <CAMuHMdWBznkqYxCWD2uwGtWLqXnBqX1Ycg31fBDc4cq2u8DkNQ@mail.gmail.com>
Subject: Re: [PATCH] video: logo: LOGO should depend on FB_CORE i.s.o. FB
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Tue, Jul 25, 2023 at 6:07 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> Geert Uytterhoeven <geert+renesas@glider.be> writes:
> > If CONFIG_FB_CORE=y but CONFIG_FB=n, the frame buffer bootup logos can
> > no longer be enabled.  Fix this by making CONFIG_LOGO depend on
> > CONFIG_FB_CORE instead of CONFIG_FB, as there is no good reason for the
> > logo code to depend on the presence of real frame buffer device drivers.
>
> Indeed.
>
> > Fixes: 55bffc8170bb5813 ("fbdev: Split frame buffer support in FB and FB_CORE symbols")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  drivers/video/Kconfig      | 2 +-
> >  drivers/video/logo/Kconfig | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > index e5b1cc54cafa10d5..b694d7669d3200b1 100644
> > --- a/drivers/video/Kconfig
> > +++ b/drivers/video/Kconfig
> > @@ -63,7 +63,7 @@ if VT
> >       source "drivers/video/console/Kconfig"
> >  endif
> >
> > -if FB || SGI_NEWPORT_CONSOLE
> > +if FB_CORE || SGI_NEWPORT_CONSOLE
> >       source "drivers/video/logo/Kconfig"
> >
> >  endif
> > diff --git a/drivers/video/logo/Kconfig b/drivers/video/logo/Kconfig
> > index 6d6f8c08792dc897..b7d94d1dd1585a84 100644
> > --- a/drivers/video/logo/Kconfig
> > +++ b/drivers/video/logo/Kconfig
> > @@ -5,7 +5,7 @@
> >
> >  menuconfig LOGO
> >       bool "Bootup logo"
> > -     depends on FB || SGI_NEWPORT_CONSOLE
> > +     depends on FB_CORE || SGI_NEWPORT_CONSOLE
> >       help
> >         Enable and select frame buffer bootup logos.
>
> Should then move this option to drivers/video/fbdev/core/Kconfig ?

No, all logo options are in their own file.

> Regardless, could be done as a follow-up and the fix looks good to me.
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
