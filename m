Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CF77AD1C9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjIYHeC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Sep 2023 03:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjIYHd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:33:58 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38FCDA;
        Mon, 25 Sep 2023 00:33:51 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-59f55c276c3so36013607b3.2;
        Mon, 25 Sep 2023 00:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695627231; x=1696232031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4DkV30tiTF+/Nd4PKu9iZtuKtXNv4GedklEIC0otY4=;
        b=aDzhuuGpNqZNihZ8QgYoQLWcI8xYGNxL7dth5aVTvONMlt/z/OOn/Cv3nKTcn1ZMIk
         36jWKG/Uda40czBYgAyqToKtbM5ln8U/QMFmJUrJe2WixEWtzJq8rqal3SHRVkrUxkZ/
         cJDEpHWBIcJPPIA2+PwskyGRM+JEAPgImifk4GFYcJwNFE9LSSi2FyWAiHkXAdMG0kG7
         P8QeNoI/R8cUowitcUlRJyuvpL/bGr7X09GNXc2/NztI0bBVneO9Y5r/9U3Bl6Z0tbvl
         9NOKA4exPou+CZHaAk6wycYHiRsr52pteK0hWxg/t1P9OYDDK/LCxrauqJe9cOBYhXKN
         Irtw==
X-Gm-Message-State: AOJu0YzMsd95Xd7xJ4VVAWdeV1X71gmGlznhfevNx2hC+PkI7rHSglUn
        7I7JhhvAHMBwk/mMZ34jy8JQhl44XA8Xqw==
X-Google-Smtp-Source: AGHT+IElws08cBsFb18SYq1VBghZRSUDRln/QItLZlH+Nx48SD1CHhC+8fP3P0XGGXAQEpVNdHUCSA==
X-Received: by 2002:a0d:ff05:0:b0:59b:4f2d:231 with SMTP id p5-20020a0dff05000000b0059b4f2d0231mr5928925ywf.45.1695627230943;
        Mon, 25 Sep 2023 00:33:50 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id f128-20020a0ddc86000000b0059c8387f673sm2290760ywe.51.2023.09.25.00.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 00:33:50 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-d8198ca891fso6362926276.1;
        Mon, 25 Sep 2023 00:33:50 -0700 (PDT)
X-Received: by 2002:a25:37d4:0:b0:d77:91db:e5c6 with SMTP id
 e203-20020a2537d4000000b00d7791dbe5c6mr6003949yba.17.1695627230398; Mon, 25
 Sep 2023 00:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230918090400.13264-1-tzimmermann@suse.de>
In-Reply-To: <20230918090400.13264-1-tzimmermann@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Sep 2023 09:33:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWodf+dfrs8wtwsyYJttx448o3AMVFwTXGzFVZ6MU3-Ew@mail.gmail.com>
Message-ID: <CAMuHMdWodf+dfrs8wtwsyYJttx448o3AMVFwTXGzFVZ6MU3-Ew@mail.gmail.com>
Subject: Re: [PATCH] fbdev/sh7760fb: Depend on FB=y
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     deller@gmx.de, sam@ravnborg.org, arnd@arndb.de, javierm@redhat.com,
        rdunlap@infradead.org, glaubitz@physik.fu-berlin.de,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        kernel test robot <lkp@intel.com>,
        Linux-sh list <linux-sh@vger.kernel.org>
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

On Mon, Sep 18, 2023 at 11:45 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Fix linker error if FB=m about missing fb_io_read and fb_io_write. The
> linker's error message suggests that this config setting has already
> been broken for other symbols.
>
>   All errors (new ones prefixed by >>):
>
>      sh4-linux-ld: drivers/video/fbdev/sh7760fb.o: in function `sh7760fb_probe':
>      sh7760fb.c:(.text+0x374): undefined reference to `framebuffer_alloc'
>      sh4-linux-ld: sh7760fb.c:(.text+0x394): undefined reference to `fb_videomode_to_var'
>      sh4-linux-ld: sh7760fb.c:(.text+0x39c): undefined reference to `fb_alloc_cmap'
>      sh4-linux-ld: sh7760fb.c:(.text+0x3a4): undefined reference to `register_framebuffer'
>      sh4-linux-ld: sh7760fb.c:(.text+0x3ac): undefined reference to `fb_dealloc_cmap'
>      sh4-linux-ld: sh7760fb.c:(.text+0x434): undefined reference to `framebuffer_release'
>      sh4-linux-ld: drivers/video/fbdev/sh7760fb.o: in function `sh7760fb_remove':
>      sh7760fb.c:(.text+0x800): undefined reference to `unregister_framebuffer'
>      sh4-linux-ld: sh7760fb.c:(.text+0x804): undefined reference to `fb_dealloc_cmap'
>      sh4-linux-ld: sh7760fb.c:(.text+0x814): undefined reference to `framebuffer_release'
>   >> sh4-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0xc): undefined reference to `fb_io_read'
>   >> sh4-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x10): undefined reference to `fb_io_write'
>      sh4-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x2c): undefined reference to `cfb_fillrect'
>      sh4-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x30): undefined reference to `cfb_copyarea'
>      sh4-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x34): undefined reference to `cfb_imageblit'
>
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309130632.LS04CPWu-lkp@intel.com/
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks for your patch!

> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -1756,7 +1756,7 @@ config FB_COBALT
>
>  config FB_SH7760
>         bool "SH7760/SH7763/SH7720/SH7721 LCDC support"
> -       depends on FB && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763 \
> +       depends on FB=y && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763 \
>                 || CPU_SUBTYPE_SH7720 || CPU_SUBTYPE_SH7721)
>         select FB_IOMEM_HELPERS
>         help
> --

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
