Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CAA7AAA33
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjIVHZ7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 22 Sep 2023 03:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjIVHZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:25:32 -0400
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042FF18F;
        Fri, 22 Sep 2023 00:23:39 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5041d6d8b10so2906810e87.2;
        Fri, 22 Sep 2023 00:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695367415; x=1695972215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOFXpuvl1H4NAlV/tBfiU1JSfb7HtfZX/jg6fk0KIaU=;
        b=uySOc49gDQGaUiDmgFOVyyes+qKuksFk+bkucinl7YWpcwXbZYkqbrWWdAgiyDRLNs
         ZctUty0AEf5Ftt84D/kRgck/Su4Lkd3ew5IJW5y74RrEDhXEDXavcm+CV910X1Kp6shj
         FVgLvXLEs8Q4ZfuBMsfH86/VZpYWLnBBVm7QjrtmehCh+RBZCUnEbDuNccE0dW+R4ca1
         rbAjT/SJBSlM3sir1OVdQBgw674KAEz3S1j0CwYDEZ7nr8eO1Bq8nDaWIswWlKOYEvBH
         /TONHyvNV+XfU7tquj+4Y7MvGxjtfCPcgO6sUZI+ryyrVHMw27wztgkNNUmfxOuwmSMQ
         K9xw==
X-Gm-Message-State: AOJu0YyztVqzbqteMWMJt81vZHBRAMJpCeV/Ejs7NkwkOP4Ysj9u6FVS
        phNKNHzNBDRQLlK9ScKkHuRBShtpUDDu6HUD
X-Google-Smtp-Source: AGHT+IHrkPr8UMGJOTjWcm6l/0n1CVnK7ePJQiZ/a6YAxqWP2honS0cgNBCDRmFpNzLY7R+PGTW8NQ==
X-Received: by 2002:a05:6512:1582:b0:503:654:cf27 with SMTP id bp2-20020a056512158200b005030654cf27mr8523906lfb.28.1695367414797;
        Fri, 22 Sep 2023 00:23:34 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id m29-20020a056512015d00b0050234d02e64sm626862lfo.15.2023.09.22.00.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 00:23:34 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5041d6d8b10so2906741e87.2;
        Fri, 22 Sep 2023 00:23:34 -0700 (PDT)
X-Received: by 2002:ac2:5b07:0:b0:500:9a15:9054 with SMTP id
 v7-20020ac25b07000000b005009a159054mr5914632lfn.20.1695367414153; Fri, 22 Sep
 2023 00:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230921060228.29041-1-rdunlap@infradead.org>
In-Reply-To: <20230921060228.29041-1-rdunlap@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 22 Sep 2023 09:23:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWBhCcUJw00ZzeHJ=x62RGP2MJ8H-AXRHxBrfOaGeU8Dw@mail.gmail.com>
Message-ID: <CAMuHMdWBhCcUJw00ZzeHJ=x62RGP2MJ8H-AXRHxBrfOaGeU8Dw@mail.gmail.com>
Subject: Re: [PATCH] fbdev: sh7760fb: require FB=y to build cleanly
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org
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

Hi Randy,

On Thu, Sep 21, 2023 at 10:43 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> Fix build errors when CONFIG_FB=m and CONFIG_FB_SH7760=y:
>
> sh2-linux-ld: drivers/video/fbdev/sh7760fb.o: in function `sh7760fb_probe':
> sh7760fb.c:(.text+0x374): undefined reference to `framebuffer_alloc'
> sh2-linux-ld: sh7760fb.c:(.text+0x394): undefined reference to `fb_videomode_to_var'
> sh2-linux-ld: sh7760fb.c:(.text+0x3a0): undefined reference to `fb_alloc_cmap'
> sh2-linux-ld: sh7760fb.c:(.text+0x3a4): undefined reference to `register_framebuffer'
> sh2-linux-ld: sh7760fb.c:(.text+0x3ac): undefined reference to `fb_dealloc_cmap'
> sh2-linux-ld: sh7760fb.c:(.text+0x434): undefined reference to `framebuffer_release'
> sh2-linux-ld: drivers/video/fbdev/sh7760fb.o: in function `sh7760fb_remove':
> sh7760fb.c:(.text+0x800): undefined reference to `unregister_framebuffer'
> sh2-linux-ld: sh7760fb.c:(.text+0x804): undefined reference to `fb_dealloc_cmap'
> sh2-linux-ld: sh7760fb.c:(.text+0x814): undefined reference to `framebuffer_release'
> sh2-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0xc): undefined reference to `fb_io_read'
> sh2-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x10): undefined reference to `fb_io_write'
> sh2-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x2c): undefined reference to `cfb_fillrect'
> sh2-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x30): undefined reference to `cfb_copyarea'
> sh2-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x34): undefined reference to `cfb_imageblit'
>
> Fixes: 4a25e41831ee ("video: sh7760fb: SH7760/SH7763 LCDC framebuffer driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thanks for your patch!

> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -1762,7 +1762,7 @@ config FB_COBALT
>
>  config FB_SH7760
>         bool "SH7760/SH7763/SH7720/SH7721 LCDC support"
> -       depends on FB && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763 \
> +       depends on FB=y && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763 \
>                 || CPU_SUBTYPE_SH7720 || CPU_SUBTYPE_SH7721)
>         select FB_IOMEM_HELPERS
>         help

Any reason this can't become tristate instead?
drivers/video/fbdev/sh7760fb.c uses module_platform_driver(), and
already has all needed MODULE_*().

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
