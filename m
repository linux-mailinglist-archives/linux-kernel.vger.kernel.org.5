Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818B67C67F3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378039AbjJLH5v convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Oct 2023 03:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbjJLH5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:57:48 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A565390
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 00:57:47 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5a7dd65052aso9922447b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 00:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697097467; x=1697702267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LoocAAYpHjIjnl+lXEbw5oajucsokY7PPaRYp92RNBU=;
        b=DDCcnElOXbgDJLR/+M6Sy9DNIob/abtlZd7c6AdgPskwRJ46yg2z8oDJj3xLaZ2PTb
         hZPgGLBYxf7hML77gU6Tb+jxI9PsqiD63kJZHCmJHmWbLC91Aw7wTsspSj9eeBMASmP6
         sYBDd3YcToytkr6JLOX1hr9HnXgkZYlsfhaJRJNofmxQE6BofbrHtfoblYghkZNX5FVk
         MwNOfYP7DQFFSNytv4TjvA49iGRSxIZoihJSgSx3Q2zCqDnSMlny9o9FlhVCbY2DKRtN
         3rL+C04znkMon9fN7DCWzZX1DZyt5eAFqp+/tmIhQzGVwvwUEDsYuggBzkIzBcNHRpj4
         WknA==
X-Gm-Message-State: AOJu0YyTV73HmnvCwMICWNZQ2CuJttydmLN6pJpTvSEbQ2tMBws5f6yM
        yldDhzL4TPhtu47VgX5eXLIQSy4Vj/xXgQ==
X-Google-Smtp-Source: AGHT+IGaSP/G+ZPdBagiZy2K6GBSetJxjyTypXSfL/UdKi2L317+0iTtZEhuUtmX8udZ2i02i6IlkA==
X-Received: by 2002:a05:690c:fc8:b0:5a7:e7ba:9a68 with SMTP id dg8-20020a05690c0fc800b005a7e7ba9a68mr4429888ywb.16.1697097466677;
        Thu, 12 Oct 2023 00:57:46 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id d199-20020a814fd0000000b005a7bf9749c8sm1788456ywb.4.2023.10.12.00.57.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 00:57:45 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5a2536adaf3so9522307b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 00:57:45 -0700 (PDT)
X-Received: by 2002:a25:400f:0:b0:d9a:68db:7f96 with SMTP id
 n15-20020a25400f000000b00d9a68db7f96mr6501132yba.21.1697097465754; Thu, 12
 Oct 2023 00:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231012065822.1007930-1-javierm@redhat.com> <20231012065822.1007930-5-javierm@redhat.com>
In-Reply-To: <20231012065822.1007930-5-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 12 Oct 2023 09:57:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVuDvomz57RHr2NMG9+a=AXy1H39Tv5jN+1J2sqv4+3rg@mail.gmail.com>
Message-ID: <CAMuHMdVuDvomz57RHr2NMG9+a=AXy1H39Tv5jN+1J2sqv4+3rg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] drm/ssd130x: Add support for the SSD132x OLED
 controller family
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Conor Dooley <conor@kernel.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org
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

Hi Javier,

On Thu, Oct 12, 2023 at 8:58 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> The Solomon SSD132x controllers (such as the SSD1322, SSD1325 and SSD1327)
> are used by 16 grayscale dot matrix OLED panels, extend the driver to also
> support this chip family.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>
> Changes in v2:
> - Align the rectangle to the segment width (Geert Uytterhoeven).

Thanks for the update!

> --- a/drivers/gpu/drm/solomon/ssd130x.c
> +++ b/drivers/gpu/drm/solomon/ssd130x.c

> +static int ssd132x_update_rect(struct ssd130x_device *ssd130x,
> +                              struct drm_rect *rect, u8 *buf,
> +                              u8 *data_array)
> +{
> +       unsigned int x = rect->x1;
> +       unsigned int y = rect->y1;
> +       unsigned int segment_width = SSD132X_SEGMENT_WIDTH;
> +       unsigned int width = drm_rect_width(rect);
> +       unsigned int height = drm_rect_height(rect);
> +       unsigned int columns = DIV_ROUND_UP(width, segment_width);
> +       unsigned int rows = height;
> +       struct drm_device *drm = &ssd130x->drm;
> +       u32 array_idx = 0;
> +       int ret, i, j;

unsigned int i, j;

> +
> +       drm_WARN_ONCE(drm, x % segment_width != 0, "x must be aligned to screen segment\n");
> +
> +       /*
> +        * The screen is divided in Segment and Common outputs, where
> +        * COM0 to COM[N - 1] are the rows and SEG0 to SEG[M - 1] are
> +        * the columns.
> +        *
> +        * Each Segment has a 4-bit pixel and each Common output has a
> +        * row of pixels. When using the (default) horizontal address
> +        * increment mode, each byte of data sent to the controller has
> +        * two Segments (e.g: SEG0 and SEG1) that are stored in the lower
> +        * and higher nibbles of a single byte representing one column.
> +        * That is, the first byte are SEG0 (D0[3:0]) and SEG1 (D0[7:4]),
> +        * the second byte are SEG2 (D1[3:0]) and SEG3 (D1[7:4]) and so on.
> +        */
> +
> +       /* Set column start and end */
> +       ret = ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_COL_RANGE, x / segment_width, columns - 1);
> +       if (ret < 0)
> +               return ret;
> +
> +       /* Set row start and end */
> +       ret = ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_ROW_RANGE, y, rows - 1);
> +       if (ret < 0)
> +               return ret;
> +
> +       for (i = 0; i < height; i++) {
> +               /* Process pair of pixels and combine them into a single byte */
> +               for (j = 0; j < width; j += segment_width) {
> +                       u8 n1 = buf[i * width + j];
> +                       u8 n2 = buf[i * width + j + 1];
> +
> +                       data_array[array_idx++] = (n2 << 4) | n1;
> +               }
> +       }
> +
> +       /* Write out update in one go since horizontal addressing mode is used */
> +       ret = ssd130x_write_data(ssd130x, data_array, columns * rows);
> +
> +       return ret;
> +}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
