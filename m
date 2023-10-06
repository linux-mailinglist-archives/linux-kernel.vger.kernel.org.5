Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1209A7BB1CE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 08:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjJFG6B convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 Oct 2023 02:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjJFG57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 02:57:59 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90099CA;
        Thu,  5 Oct 2023 23:57:57 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5a21ea6baccso22057157b3.1;
        Thu, 05 Oct 2023 23:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696575476; x=1697180276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gwH34nAKT/9gJP0Nz0nWG6ojc2t+JiQa+bhA5w8EoOU=;
        b=JZJrhj2CSxjx94rGuFqYzXFXCxTfOtOSEbwQJUzJS+icM7eCeEyuRCRpqjJPzQm93t
         +6eh4M1dTL9AR0M8CiUOsb/orusLgBNz7i63YNU7T85gfqW8Z+kIOY6PdqHYwOj4XwV/
         shwNKtmuQY8nA8ds2ZeCYPaGD9asFFHXqTxXX0V3E7AfsREXlfOOWeWgOZlFnRh9VAt6
         lcc49bpZuiiNMmHqKevCt1HkIfOOXfIkiQuUw60h9fjvWfMkM8zhRX68WwxHqgiUuqMW
         5kAyL/jIyKbI8i7+hq2K5I1IjlyMl6tGV7Y9patx5zkHXCE6Ylx/9PZPmc8U9x6A5P6L
         VOhg==
X-Gm-Message-State: AOJu0YwYUb9BmQbqKyP3vBRQMj2Y/ZRcWOUyeMQFAZxBJ4W5YxVHwouD
        yz3xk1M2bPt816knSFGaHtWLVeuMrrHfzQ==
X-Google-Smtp-Source: AGHT+IGhu6JArA9cHaP9r9i2HcIvm9k6frV9bXDtZLv2ovBOUJVekyOSi0HKYflebjNQQ/dN5nvj+w==
X-Received: by 2002:a05:6902:1024:b0:d55:cf49:9144 with SMTP id x4-20020a056902102400b00d55cf499144mr8274974ybt.15.1696575476571;
        Thu, 05 Oct 2023 23:57:56 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id i84-20020a25d157000000b00d81479172f8sm906344ybg.5.2023.10.05.23.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 23:57:56 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5a2536adaf3so21893897b3.2;
        Thu, 05 Oct 2023 23:57:56 -0700 (PDT)
X-Received: by 2002:a0d:dfc6:0:b0:57a:2e83:4daf with SMTP id
 i189-20020a0ddfc6000000b0057a2e834dafmr7696369ywe.32.1696575475803; Thu, 05
 Oct 2023 23:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694767208.git.geert+renesas@glider.be> <CAMuHMdWfBTKdXvZutg4LvWqBjuz-X=ZjzX0LKPqD=JxYuLoPRw@mail.gmail.com>
 <20230919152428.GB18426@pendragon.ideasonboard.com> <CAMuHMdUwBXQ2X6hOm+kcZOteDLMau8x5xUcRJr2zy9dXyVf9Xw@mail.gmail.com>
In-Reply-To: <CAMuHMdUwBXQ2X6hOm+kcZOteDLMau8x5xUcRJr2zy9dXyVf9Xw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 6 Oct 2023 08:57:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUnQx82bzJ7XyzCo6MuDHNhDviZigJOyuYvtUOCkogxqQ@mail.gmail.com>
Message-ID: <CAMuHMdUnQx82bzJ7XyzCo6MuDHNhDviZigJOyuYvtUOCkogxqQ@mail.gmail.com>
Subject: Re: [GIT PULL] drm: renesas: shmobile: Atomic conversion + DT support
 (was: Re: [PATCH v4 00/41] drm: renesas: shmobile: Atomic conversion + DT support)
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Tue, Sep 26, 2023 at 4:51 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, Sep 19, 2023 at 5:24 PM Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> > On Tue, Sep 19, 2023 at 04:28:40PM +0200, Geert Uytterhoeven wrote:
> > > The following changes since commit 0663e1da5ba8e6459e3555ac12c62741668c0d30:
> > >
> > >   drm/dp_mst: Tune down error message during payload addition
> > > (2023-09-18 16:38:21 +0300)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git
> > > tags/shmob-drm-atomic-dt-tag1
> > >
> > > for you to fetch changes up to bfea0fa9052aa8d235b24957eb84d9ff20cb87b7:
> > >
> > >   drm: renesas: shmobile: Add DT support (2023-09-19 15:58:04 +0200)
> > >
> > > ----------------------------------------------------------------
> > > drm: renesas: shmobile: Atomic conversion + DT support
> > >
> > > Currently, there are two drivers for the LCD controller on Renesas
> > > SuperH-based and ARM-based SH-Mobile and R-Mobile SoCs:
> > >   1. sh_mobile_lcdcfb, using the fbdev framework,
> > >   2. shmob_drm, using the DRM framework.
> > > However, only the former driver is used, as all platform support
> > > integrates the former.  None of these drivers support DT-based systems.
> > >
> > > Convert the SH-Mobile DRM driver to atomic modesetting, and add DT
> > > support, complemented by the customary set of fixes and improvements.
> > >
> > > Link: https://lore.kernel.org/r/cover.1694767208.git.geert+renesas@glider.be/
> > >
> > > This PR is based on today's drm-misc/for-linux-next, to avoid a
> > > conflict with commit 775b0669e19f2e4a ("drm/shmobile: Convert to
> > > platform remove callback returning void") in drm-misc/for-linux-next
>
> Now drm-misc/for-linux-next (which is still at v6.5-rc2) has been
> merged into drm/drm-next (which is at v6.6-rc2), do you want me to
> rebase my branch to current drm/drm-next, or any other commit?

Please advise me what needs to be done to move this forward.
Thanks!

> > > Thanks for pulling!
> > > ----------------------------------------------------------------
> > > Geert Uytterhoeven (36):
> > >       MAINTAINER: Create entry for Renesas SH-Mobile DRM drivers
> >
> > I'm technically listed as the maintainer for this driver until Geert
> > takes over, so for this pull request,
> >
> > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >
> > And after that, shmobile won't need my ack to merge further changes :-)
> >
> > This is very nice work Geert. I'm looking forward to dropping the
> > sh_mobile_lcdcfb driver.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
