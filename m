Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2864978E7CE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 10:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239737AbjHaIWk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 31 Aug 2023 04:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjHaIWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:22:39 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794F3EE
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 01:22:36 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-58fb73e26a6so7051917b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 01:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693470155; x=1694074955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7bxw9Xunx8GSI2r5kdgx9TSGGXffVQ4EQIFOvHHizA=;
        b=lCoPUcqdoPJqcu+3gAZVYflKYWnJzD03UJIPVF4oQL6p/8eoPIQFaplftjwj7bhFOP
         YBJuYFTvMdwJ9BUcWlISv/oYcU9BIsECXBIPTVL1KucEG3s3PGpRdNy6eht11fXRGx16
         ZVr7efkyUDumJNJTjAkrLgjv+xJgSW6P2Ap5xyjK9sDCrsR0yYSfeg5ILEIoT67EAnxj
         vRrxEPtbPvrxzcZ6BzO/0WlsDi6J8YH8h4xc+k0Sf5qjH+KkIQYB4AanpLdhSx25LCi3
         OsRcEk0ys+Ap5pVsYDd9N7Akwh0Sj02FMqec3CouBZvo0tYJ44XcSqo/sSFerMwitWFs
         ixhw==
X-Gm-Message-State: AOJu0YxUtVSTLSf+4NyatluVcjY7q2CQcepTwdf61tOEdeeATvQ0Ra7Q
        7Nmg0ZrMHuzh/1uvlHuvkmSwei2D+NHUsA==
X-Google-Smtp-Source: AGHT+IECum5YeFgcFIAaEQblCNDCOF/FvEOPpK3fg35DPDiYwxNUmWvc5oUcaiLpyfuLKayJOnTNCg==
X-Received: by 2002:a0d:d406:0:b0:58f:bbc2:f6d4 with SMTP id w6-20020a0dd406000000b0058fbbc2f6d4mr4248897ywd.8.1693470154726;
        Thu, 31 Aug 2023 01:22:34 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id i145-20020a819197000000b00570599de9a5sm276320ywg.88.2023.08.31.01.22.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 01:22:34 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-d77c5414433so342699276.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 01:22:34 -0700 (PDT)
X-Received: by 2002:a25:4203:0:b0:d11:45d3:b25d with SMTP id
 p3-20020a254203000000b00d1145d3b25dmr4840506yba.46.1693470153220; Thu, 31 Aug
 2023 01:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692888745.git.geert@linux-m68k.org> <d5f342b5382653c1f1fb72dbedb783f9ea42416e.1692888745.git.geert@linux-m68k.org>
 <10bc08a5-0e64-d8ac-b71f-d44e16da8f61@suse.de>
In-Reply-To: <10bc08a5-0e64-d8ac-b71f-d44e16da8f61@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 31 Aug 2023 10:22:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXUcEgQcjr20vK1nRANm4se0Du6M_gcrj8ZS+bXPYMMWw@mail.gmail.com>
Message-ID: <CAMuHMdXUcEgQcjr20vK1nRANm4se0Du6M_gcrj8ZS+bXPYMMWw@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] drm/ssd130x: Add support for DRM_FORMAT_R1
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Hi Thomas,

On Thu, Aug 31, 2023 at 10:01 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 24.08.23 um 17:08 schrieb Geert Uytterhoeven:
> > The native display format is monochrome light-on-dark (R1).
> > Hence add support for R1, so monochrome applications not only look
> > better, but also avoid the overhead of back-and-forth conversions
> > between R1 and XR24.
> >
> > Do not allocate the intermediate conversion buffer when it is not
> > needed, and reorder the two buffer allocations to streamline operation.
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> > v2:
> >    - Rework on top op commit 8c3926367ac9df6c ("drm/ssd130x: Use
> >      shadow-buffer helpers when managing plane's state") in drm/drm-next.
> >      Hence I did not add Javier's tags given on v1.
> >    - Do not allocate intermediate buffer when not needed.
> > ---
> >   drivers/gpu/drm/solomon/ssd130x.c | 76 +++++++++++++++++++++----------
> >   1 file changed, 51 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
> > index 78272b1f9d5b167f..18007cb4f3de5aa1 100644
> > --- a/drivers/gpu/drm/solomon/ssd130x.c
> > +++ b/drivers/gpu/drm/solomon/ssd130x.c
> > @@ -449,15 +449,14 @@ static int ssd130x_init(struct ssd130x_device *ssd130x)
> >
> >   static int ssd130x_update_rect(struct ssd130x_device *ssd130x,
> >                              struct ssd130x_plane_state *ssd130x_state,
> > +                            u8 *buf, unsigned int pitch,
> >                              struct drm_rect *rect)
> >   {
> >       unsigned int x = rect->x1;
> >       unsigned int y = rect->y1;
> > -     u8 *buf = ssd130x_state->buffer;
> >       u8 *data_array = ssd130x_state->data_array;
> >       unsigned int width = drm_rect_width(rect);
> >       unsigned int height = drm_rect_height(rect);
> > -     unsigned int line_length = DIV_ROUND_UP(width, 8);
> >       unsigned int page_height = ssd130x->device_info->page_height;
> >       unsigned int pages = DIV_ROUND_UP(height, page_height);
> >       struct drm_device *drm = &ssd130x->drm;
> > @@ -516,7 +515,7 @@ static int ssd130x_update_rect(struct ssd130x_device *ssd130x,
> >                       u8 data = 0;
> >
> >                       for (k = 0; k < m; k++) {
> > -                             u8 byte = buf[(8 * i + k) * line_length + j / 8];
> > +                             u8 byte = buf[(8 * i + k) * pitch + j / 8];
> >                               u8 bit = (byte >> (j % 8)) & 1;
> >
> >                               data |= bit << k;
> > @@ -602,27 +601,51 @@ static int ssd130x_fb_blit_rect(struct drm_plane_state *state,
>
> The handing of different formats in this function is confusing. I'd
> rather implement ssd130x_fb_blit_rect_r1 and
> ssd130x_fb_blit_rect_xrgb8888 which then handle a single format.

OK, will split.

> >       struct ssd130x_device *ssd130x = drm_to_ssd130x(fb->dev);
> >       unsigned int page_height = ssd130x->device_info->page_height;
> >       struct ssd130x_plane_state *ssd130x_state = to_ssd130x_plane_state(state);
> > -     u8 *buf = ssd130x_state->buffer;
> >       struct iosys_map dst;
> >       unsigned int dst_pitch;
> >       int ret = 0;
> > +     u8 *buf;
> >
> >       /* Align y to display page boundaries */
> >       rect->y1 = round_down(rect->y1, page_height);
> >       rect->y2 = min_t(unsigned int, round_up(rect->y2, page_height), ssd130x->height);
> >
> > -     dst_pitch = DIV_ROUND_UP(drm_rect_width(rect), 8);
> > +     switch (fb->format->format) {
> > +     case DRM_FORMAT_R1:
> > +             /* Align x to byte boundaries */
> > +             rect->x1 = round_down(rect->x1, 8);
> > +             rect->x2 = round_up(rect->x2, 8);
>
> Is rounding to multiples of 8 guaranteed to work? I know it did on
> VGA-compatible HW, because VGA enforces it. But is that generally the case?

That depends: some hardware requires e.g. 32-bit writes.
But this driver is for a display with a serial (i2c/spi) interface,
so everything should be fine ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
