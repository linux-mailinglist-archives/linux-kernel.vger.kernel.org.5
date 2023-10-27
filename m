Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24027D90BE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbjJ0IKA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 27 Oct 2023 04:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjJ0IJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:09:57 -0400
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA4E111;
        Fri, 27 Oct 2023 01:09:54 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7aae07e7ba4so728466241.1;
        Fri, 27 Oct 2023 01:09:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698394193; x=1698998993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXz17VD25GWoAf0H7NxnM2SjBWk5BeAkDDQxS4QDQmU=;
        b=IkAcp/xTbdKSGw2Cl78ckOl9BxBh4fmouyQPbXiG+eRaSSXoTb9xayK+RdQhddNtHl
         uXuF7pE/swNtKeICPMeYEWi5ZuCm+fZvAWXviPBuvaqwIRTPsk2a3bUT5wXiJ8e5YH4X
         4exkVPPYDYw5fW+st9LxYEyvmeM9xFyH0ncrfKY5Ltprk935t1ojK7GkTTslNvqUEZtI
         J5D1QXX6JDVIAYyJDSG8SvAWYf85q6qbUSgHLQxnEBOyd1eC0Q7EEaBF3rG233t78sTU
         soESU6PNpR4muePAXVDn/nlHRrx5/OXWF8xJtGp3HKDaU9ejcs75lWvc4NOJXxN6s0R4
         k1qw==
X-Gm-Message-State: AOJu0YzQiJVmOkpLUuY4H80lxbRjLRQfnPbO5hCLXdsX0NaUd7ev32hq
        NgzrZjoY47bS48SrQHO2JMvKoWclkVWFxg==
X-Google-Smtp-Source: AGHT+IEwvnSdOsGKN4x0g+weDlDKku373Nr0W6R1+kmlKTzfLeFDb4XYt0Zki8OUcBWwAYNsrRNOqw==
X-Received: by 2002:a05:6102:3d8c:b0:45a:b396:a44 with SMTP id h12-20020a0561023d8c00b0045ab3960a44mr2199594vsv.25.1698394193414;
        Fri, 27 Oct 2023 01:09:53 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id c26-20020a056102319a00b004546c2bfd2bsm132465vsh.13.2023.10.27.01.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 01:09:52 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-49ab0641e77so805104e0c.0;
        Fri, 27 Oct 2023 01:09:52 -0700 (PDT)
X-Received: by 2002:a1f:178c:0:b0:49e:2145:1654 with SMTP id
 134-20020a1f178c000000b0049e21451654mr2148085vkx.7.1698394192303; Fri, 27 Oct
 2023 01:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694767208.git.geert+renesas@glider.be> <CAMuHMdWfBTKdXvZutg4LvWqBjuz-X=ZjzX0LKPqD=JxYuLoPRw@mail.gmail.com>
 <CAMuHMdUF61V5qNyKbrTGxZfEJvCVuLO7q2R5MqZYkzRC_cNr0w@mail.gmail.com> <CAMuHMdXTpMYqdFzro3kX-3wXYC8N6z2abiMTiXXpV9xn1ohj0Q@mail.gmail.com>
In-Reply-To: <CAMuHMdXTpMYqdFzro3kX-3wXYC8N6z2abiMTiXXpV9xn1ohj0Q@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 27 Oct 2023 10:09:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWdRCzy7_RnBh7bqpURxx8qeWaC6ARMt7XWsbRv8FYnjw@mail.gmail.com>
Message-ID: <CAMuHMdWdRCzy7_RnBh7bqpURxx8qeWaC6ARMt7XWsbRv8FYnjw@mail.gmail.com>
Subject: Re: [GIT PULL v2] drm: renesas: shmobile: Atomic conversion + DT
 support (was: Re: [PATCH v4 00/41] drm: renesas: shmobile: Atomic conversion
 + DT support)
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David, Daniel,

On Tue, Oct 24, 2023 at 12:08 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Mon, Oct 16, 2023 at 11:59 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > The following changes since commit 389af786f92ecdff35883551d54bf4e507ffcccb:
> >
> >   Merge tag 'drm-intel-next-2023-09-29' of
> > git://anongit.freedesktop.org/drm/drm-intel into drm-next (2023-10-04
> > 13:55:19 +1000)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git
> > tags/shmob-drm-atomic-dt-tag2
> >
> > for you to fetch changes up to 1399ebacbf590dfbac4fbba181dd1595b2fa10ba:
> >
> >   drm: renesas: shmobile: Add DT support (2023-10-16 11:47:48 +0200)
> >
> > ----------------------------------------------------------------
> > drm: renesas: shmobile: Atomic conversion + DT support
> >
> > Currently, there are two drivers for the LCD controller on Renesas
> > SuperH-based and ARM-based SH-Mobile and R-Mobile SoCs:
> >   1. sh_mobile_lcdcfb, using the fbdev framework,
> >   2. shmob_drm, using the DRM framework.
> > However, only the former driver is used, as all platform support
> > integrates the former.  None of these drivers support DT-based systems.
> >
> > Convert the SH-Mobile DRM driver to atomic modesetting, and add DT
> > support, complemented by the customary set of fixes and improvements.
> >
> > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Link: https://lore.kernel.org/r/cover.1694767208.git.geert+renesas@glider.be/
> >
> > Changes compared to v1:
> >   - Rebase to drm-next,
> >   - Add Acked-by.
> >
> > Thanks for pulling!
>
> Ping?
> Thanks!

Please note that this is a hard dependency for adding shmobile-lcdc
device nodes to DTS files, which is in turn a hard dependency for
removing drivers/staging/board/, and for removing legacy clkdev
registration from various clock drivers.

Thanks for pulling!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
