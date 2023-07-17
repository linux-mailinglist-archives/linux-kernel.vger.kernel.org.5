Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9712D75600A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjGQKEd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jul 2023 06:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjGQKEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:04:09 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E0F194
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:03:38 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-579dfae6855so43836457b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689588217; x=1692180217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r38XqAfbSP4Ur+0AuPdJrDlGHf8b+ew1arLdw+Z2HI0=;
        b=IPLWQKMvPwy7K2Eql0DUKd+Dc2C/6qcUIIFtdLBjoB88ZyjUPX/cwKZlzAU/FRIDME
         6Yu47z365kcXWCUInm9KiVRgBDoHKfsIKj+8MStzJU2gJUnfVAWYqJvy3BMINcdYrckc
         KwaoOBNAca4d7cgbpreTEhhJl9zjabOzt+KPqWEUPv+5+Kfu3S4XScx+8KG6L64NVh16
         ZtMnDAqBonh3nNYE07YaVxkGMBSBnHbT6SwY8bqqVXFYJQD7WDRAvpg4pD39gQaaGzoN
         SJ7WsRFlNM/FcBQ91GZyMAQHpEK0bO2uj2weSBImIxsaxbRkYjKbU8QQQKaiel1YMr5o
         U0ZA==
X-Gm-Message-State: ABy/qLbvjU++77FAGCEWisfYMzL9wxF2tTzBv+9Djq/pFbJl4diEr4OR
        hYHOySDpqdPgVO4hg77fTJAxdnFTlJ+XMA==
X-Google-Smtp-Source: APBJJlHRShrYfpVLPU5TOcoY0d+hYkRtWVZuv6OCDOTjiltJ2MgZ3bbiZzoqv4Ki0e7CBsetyg4YLA==
X-Received: by 2002:a0d:cb13:0:b0:57a:6675:3051 with SMTP id n19-20020a0dcb13000000b0057a66753051mr11380722ywd.46.1689588217276;
        Mon, 17 Jul 2023 03:03:37 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id x134-20020a0dd58c000000b005832fe29034sm931887ywd.89.2023.07.17.03.03.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 03:03:37 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-cada5e4e3f6so4381610276.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:03:37 -0700 (PDT)
X-Received: by 2002:a25:b90a:0:b0:c63:a04d:ad34 with SMTP id
 x10-20020a25b90a000000b00c63a04dad34mr9332442ybj.64.1689588216863; Mon, 17
 Jul 2023 03:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689252746.git.geert@linux-m68k.org> <87zg3w7zlz.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdV_qNfytroBEfqDMe04POt27s9o=FevXht7N4YXRmBz8Q@mail.gmail.com>
 <87o7kakijn.fsf@minerva.mail-host-address-is-not-set> <CAMuHMdURa8E9cmphbDkTgS2o3ORWd7JAj68PV9bxd3aygKZRJg@mail.gmail.com>
 <87jzuykhm5.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87jzuykhm5.fsf@minerva.mail-host-address-is-not-set>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Jul 2023 12:03:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUiEXgk51Bjo+SdTXJz=bCrPzrcd8k1cZcEJUamsn0d1g@mail.gmail.com>
Message-ID: <CAMuHMdUiEXgk51Bjo+SdTXJz=bCrPzrcd8k1cZcEJUamsn0d1g@mail.gmail.com>
Subject: Re: [PATCH 0/8] drm: fb-helper/ssd130x: Add support for DRM_FORMAT_R1
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Mon, Jul 17, 2023 at 11:33 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> >> >> penguin in test004 is not displayed correctly. I was expecting that to be
> >> >> working correctly since you mentioned to be using the Linux logo on boot.
> >> >
> >> > Linux has logos for displays using 2, 16, and 256 colors. Note that the
> >> > default logos are 80x80, which is larger than your display, so no logo
> >> > is drawn.
> >> > Fbtest has only the full color logo, so it will look bad on a monochrome
> >> > display.
> >>
> >> I see. Should the test check for minimum num_colors and skip that test then?
> >
> > The test still works (you did see an ugly black-and-white penguin), doesn't it?
>
> Fair enough. But when it defaulted to XRGB8888, it looked better. So I
> thought that it was a regression. No strong opinion though if the test
> should be skipped or not.

IC, fbtest's mono_match_color() just finds the closest color (black or
white), while drm_fb_xrgb8888_to_gray8_line() uses a weighted average
of the RGB components. That might make a small but visible difference.

We could make it look even better using Floyd-Steinberg dithering... ;-)
Fbtest does have an unused match_color_error() helper, so I must have
had that in mind, initially...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
