Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B072755F17
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjGQJUA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jul 2023 05:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjGQJT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:19:58 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040C910DC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:19:58 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-57012b2973eso42872157b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689585597; x=1692177597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iL6H4V2XU8kmGm5fHcmeXtpvI5hQ0R0kS2i0q5dCFTY=;
        b=ZUYkseGLd2sSg/2oidILxltPD+5QPgunUdy+jFYV7Tv3wf6e5cKuD/dzOqvktFhy0I
         RLkchAq8hU+MARXOQlS45hnPA9cQ1xCGsC8sUbRg12ii005nubir/lBR/It3nvuc0p2h
         ztJk0ep7glXq2u9nbEpcX1R3Qp6wn5uVXr7ryCvx9XQPrmaFgJWKxHUuh0dwOeIbaWbP
         E1+U/duVcRJhbURksKVZQhqDJINkZXNC+JIGUeXe0/2Ask0eLoFfXHhzAfYUuXM9wfnZ
         zE9E2kweLpmhmcNsMgywx10NlRc3wVwoM+v2TD9BL1jRvZpASeJC5bKycoNMU/5Iou49
         DFzA==
X-Gm-Message-State: ABy/qLZTcuDJqV7Ak517ZHcu46Ah1Ui6mCJmjZOnrFX5o3g7d+UrWRGR
        FuPIJwNqnZ/iBsUQtt2D2OVQZZppfWtCEQ==
X-Google-Smtp-Source: APBJJlEBC06W7JnHdb82lORTZCrCUdg1I85j73NWJf8qZFgS8Vtgm2w1cHIXlhKGI6ePWrI9clJaVg==
X-Received: by 2002:a0d:d801:0:b0:56d:824e:d93f with SMTP id a1-20020a0dd801000000b0056d824ed93fmr11753889ywe.38.1689585597012;
        Mon, 17 Jul 2023 02:19:57 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id s64-20020a0de943000000b005704a372ce7sm3723383ywe.125.2023.07.17.02.19.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 02:19:56 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-cabf1dbafc4so4379488276.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:19:56 -0700 (PDT)
X-Received: by 2002:a25:6ec3:0:b0:c8b:7d63:72b0 with SMTP id
 j186-20020a256ec3000000b00c8b7d6372b0mr10263134ybc.10.1689585596517; Mon, 17
 Jul 2023 02:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689252746.git.geert@linux-m68k.org> <87zg3w7zlz.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdV_qNfytroBEfqDMe04POt27s9o=FevXht7N4YXRmBz8Q@mail.gmail.com> <87o7kakijn.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87o7kakijn.fsf@minerva.mail-host-address-is-not-set>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Jul 2023 11:19:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdURa8E9cmphbDkTgS2o3ORWd7JAj68PV9bxd3aygKZRJg@mail.gmail.com>
Message-ID: <CAMuHMdURa8E9cmphbDkTgS2o3ORWd7JAj68PV9bxd3aygKZRJg@mail.gmail.com>
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

On Mon, Jul 17, 2023 at 11:13 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> > On Sun, Jul 16, 2023 at 3:30 PM Javier Martinez Canillas
> > <javierm@redhat.com> wrote:
> >> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> >> > The native display format of ssd1306 OLED displays is monochrome
> >> > light-on-dark (R1).  This patch series adds support for the R1 buffer
> >> > format to both the ssd130x DRM driver and the FB helpers, so monochrome
> >> > applications (including fbdev emulation and the text console) can avoid
> >> > the overhead of back-and-forth conversions between R1 and XR24.
> >>
> >> I've tested your series on a ssd1306 I2C OLED panel and fbcon did work for
> >> me, but had some issues when trying to run your fbtest suite. Because the
> >
> > Thanks, due to the limited userspace environment on my RV32 test system,
> > I didn't run fbtest myself.
> >
>
> You are welcome.
>
> >> test005 gets killed with a SIGSEGV.
> >>
> >> $ ./fbtest -d
> >> fb_init()
> >> fb_open()
> >> fb_get_var()
> >> fb_get_fix()
> >> fb_map()
> >> fb_start = 0, fb_offset = 0, fb_len = 1000
> >
> >    [...]
> >
> >> Running test test005
> >> Caught signal 11. Exiting
> >
> > Strange.
> >
> >> Maybe more tests are missing the minimum num_colors requirement? Also, the
> >
> > On monochrome, test005 should make the left half of the screen black,
> > and the right half white.  It works on ARAnyM, and there don't seem
> > to be off-by-one errors in the call to fill_rect().
> > Can you please run this under gdb or valgrind?
> >
>
> Sure. I only spent my free time on these panels though so likely will do
> during the week or more likely the weekend. I believe the bug is somewhere
> in the test though and not in your kernel patches.

OK.

> >> penguin in test004 is not displayed correctly. I was expecting that to be
> >> working correctly since you mentioned to be using the Linux logo on boot.
> >
> > Linux has logos for displays using 2, 16, and 256 colors. Note that the
> > default logos are 80x80, which is larger than your display, so no logo
> > is drawn.
> > Fbtest has only the full color logo, so it will look bad on a monochrome
> > display.
>
> I see. Should the test check for minimum num_colors and skip that test then?

The test still works (you did see an ugly black-and-white penguin), doesn't it?

> When you post v2, feel free to add:
>
> Tested-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
