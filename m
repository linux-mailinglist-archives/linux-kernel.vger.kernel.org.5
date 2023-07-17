Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8C3755DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjGQIIU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jul 2023 04:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjGQIIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:08:15 -0400
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8606D1985
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:07:39 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-48138ef0c3eso1161176e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689581242; x=1692173242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQUYYb5UoV28AOm1zKXHyuqRflG1e1czbgtprr+9WpA=;
        b=VGT3lvD8TXLVBuEaqyup85W6vsAjRYR4aahRiSgA7NwLNz2TdMmymQPsnkfjZphQZh
         qavvk6BFjINwIgm7GTs8YINuqHlQZyRSQNs+Z3fws7GSvS9kPsGholPRe4sB8pACmjPo
         em1jGJMzmnvgITHN5oC8MBlDu2MtRFwBw4+7+sbZ4l3FqRBxpqzBVXqFPM8hhgIYwCDV
         YlNf65HEF1BtaZfl8fQV6z+CozzsgzXYFDMcLQ1CuqU2B6Yrj8+BuDn8yeoAVQQpR4c6
         tpX6R57eYzvBLR/NZ+iAlnm8fFBCeG4P4wPe8qNXx+TdG5ZB1kJVDN/p1IMwW3eQ+gJQ
         00sg==
X-Gm-Message-State: ABy/qLahjhQfAIZR2pYYVdZCxiXhaExAC8BUeSeV3EYtskHB+Punv8o6
        kraTP/U5LwKVZq1mnHMeP3lWjraPNoCAig==
X-Google-Smtp-Source: APBJJlE4xiOXNipoYz2opyAKYnOUA9koRjLeYlUeAl4ZoMIFl81enKNFn1qU5YuSZJvFwcPagCB9Fw==
X-Received: by 2002:a1f:e342:0:b0:471:b557:12a with SMTP id a63-20020a1fe342000000b00471b557012amr4340104vkh.11.1689581242264;
        Mon, 17 Jul 2023 01:07:22 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id l17-20020ac5c351000000b004813aaf424esm1509963vkk.38.2023.07.17.01.07.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 01:07:22 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4812f39ca53so1153994e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:07:22 -0700 (PDT)
X-Received: by 2002:a1f:bd48:0:b0:47e:fd6:6d77 with SMTP id
 n69-20020a1fbd48000000b0047e0fd66d77mr4986101vkf.3.1689581241818; Mon, 17 Jul
 2023 01:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689252746.git.geert@linux-m68k.org> <87zg3w7zlz.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87zg3w7zlz.fsf@minerva.mail-host-address-is-not-set>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Jul 2023 10:07:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV_qNfytroBEfqDMe04POt27s9o=FevXht7N4YXRmBz8Q@mail.gmail.com>
Message-ID: <CAMuHMdV_qNfytroBEfqDMe04POt27s9o=FevXht7N4YXRmBz8Q@mail.gmail.com>
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

On Sun, Jul 16, 2023 at 3:30 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> > The native display format of ssd1306 OLED displays is monochrome
> > light-on-dark (R1).  This patch series adds support for the R1 buffer
> > format to both the ssd130x DRM driver and the FB helpers, so monochrome
> > applications (including fbdev emulation and the text console) can avoid
> > the overhead of back-and-forth conversions between R1 and XR24.
>
> I've tested your series on a ssd1306 I2C OLED panel and fbcon did work for
> me, but had some issues when trying to run your fbtest suite. Because the

Thanks, due to the limited userspace environment on my RV32 test system,
I didn't run fbtest myself.

> test005 gets killed with a SIGSEGV.
>
> $ ./fbtest -d
> fb_init()
> fb_open()
> fb_get_var()
> fb_get_fix()
> fb_map()
> fb_start = 0, fb_offset = 0, fb_len = 1000

   [...]

> Running test test005
> Caught signal 11. Exiting

Strange.

> Maybe more tests are missing the minimum num_colors requirement? Also, the

On monochrome, test005 should make the left half of the screen black,
and the right half white.  It works on ARAnyM, and there don't seem
to be off-by-one errors in the call to fill_rect().
Can you please run this under gdb or valgrind?

> penguin in test004 is not displayed correctly. I was expecting that to be
> working correctly since you mentioned to be using the Linux logo on boot.

Linux has logos for displays using 2, 16, and 256 colors. Note that the
default logos are 80x80, which is larger than your display, so no logo
is drawn.
Fbtest has only the full color logo, so it will look bad on a monochrome
display.

> Another question, do you know if is possible to change the default format?

AFAIK DRM does not support that.

> I believe that fbset won't work because the DRM fbdev emulation layer does
> not implement mode settings but I thought that changing the mode using the

Correct.

> atomic KMS API would work.
>
> $ modetest -M ssd130x -P 31@33:128x64@XR24 -a
> $ echo $?
> 0
>
> but after that I still get:
>
> $ fbset -i
>
> mode "128x64"
>     geometry 128 64 128 64 1
>     timings 0 0 0 0 0 0 0
>     rgba 1/0,1/0,1/0,0/0
> endmode
>
> Frame buffer device information:
>     Name        : ssd130xdrmfb
>     Address     : (nil)
>     Size        : 4096
>     Type        : PACKED PIXELS
>     Visual      : MONO10
>     XPanStep    : 1
>     YPanStep    : 1
>     YWrapStep   : 0
>     LineLength  : 16
>     Accelerator : No
>
> Maybe I'm doing something wrong or misunderstading about how should work?

Do you need the "-d" option (drop master after mode set) of modetest?
Still, that would only impact DRM.  The fbdev emulation on top of DRM has
already been initialized before, and is never reinitialized.


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
