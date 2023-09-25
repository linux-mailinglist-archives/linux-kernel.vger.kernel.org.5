Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13A37AD1B1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjIYHcX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Sep 2023 03:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIYHcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:32:20 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE13CE;
        Mon, 25 Sep 2023 00:32:14 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-59f82ad1e09so8742087b3.0;
        Mon, 25 Sep 2023 00:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695627133; x=1696231933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xThiWU+H5y1zPVxgj/ULPXRi0AJOVCXd78/fbyAqgmg=;
        b=uAbJMuub9pOa9N5Ha/hsAIk/p+BDxM2jWdLfhSWwQ+p8kJPovc7gqFq7L5dhpJ4oUf
         R2A30bd/trmLhWjnXQq/d8tADp65XM6VQBWG4zf//APJcwDBW3CSo755P+5DxBYn56XE
         EZ4LxwcS7f7ku9J79SzXE3CaBRDEIIlBsDZ9pL4vRHBnrzV4CP3hHO5nN/23sGvtvzCD
         Sn4iTjKUmJ7+FaLVA3x4uyLUscQ89OvtOVP8NBvK1rk1RfolB3yq3mhakWHLhxC140aI
         7qMOhBATQ/VYjlQnv6id0CnC6h2sfLK3OmQBom4K1bxiDijO2ppxhDYTa/gNu/N/GAI3
         R6aA==
X-Gm-Message-State: AOJu0YxBZc/s2MHXZfNuvLBvcEBFusAEcIXy6vPqSYLsC4SDNWkRAOnh
        NZG3IPIUieOSkOvC+toPSlqqa7v+MI7ZjQ==
X-Google-Smtp-Source: AGHT+IEvQzYxT9r00rsUVKsh5Moqkn6GgZLJE7uewZ7n1ZLSRrLFJ/ka7lxDnp2EBFr16oL7OGxg0Q==
X-Received: by 2002:a81:bf48:0:b0:59b:6c4:b822 with SMTP id s8-20020a81bf48000000b0059b06c4b822mr6756049ywk.36.1695627132945;
        Mon, 25 Sep 2023 00:32:12 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id x125-20020a0dee83000000b0057a918d6644sm2274542ywe.128.2023.09.25.00.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 00:32:12 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-d815a5eee40so6369733276.2;
        Mon, 25 Sep 2023 00:32:12 -0700 (PDT)
X-Received: by 2002:a25:ec0c:0:b0:d81:bb7e:f47f with SMTP id
 j12-20020a25ec0c000000b00d81bb7ef47fmr6282466ybh.44.1695627132454; Mon, 25
 Sep 2023 00:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <202309130632.LS04CPWu-lkp@intel.com> <feadd6a5-0f56-4575-9891-3a7d88e69e64@infradead.org>
In-Reply-To: <feadd6a5-0f56-4575-9891-3a7d88e69e64@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Sep 2023 09:32:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVRyaq5xT+2GGREHS95Nm86wHmmU0cE_qR5-eza1vMExw@mail.gmail.com>
Message-ID: <CAMuHMdVRyaq5xT+2GGREHS95Nm86wHmmU0cE_qR5-eza1vMExw@mail.gmail.com>
Subject: Re: sh4-linux-ld: drivers/video/fbdev/sh7760fb.o:undefined reference
 to `fb_io_read'
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel test robot <lkp@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-fbdev@vger.kernel.org,
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

Hi Randy,

On Wed, Sep 13, 2023 at 7:13 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 9/12/23 15:42, kernel test robot wrote:
> > FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   3669558bdf354cd352be955ef2764cde6a9bf5ec
> > commit: 5f86367006c6a0662faaf36f753f437afe42fb63 fbdev/sh7760fb: Use fbdev I/O helpers
> > date:   6 weeks ago
> > config: sh-randconfig-r012-20230913 (https://download.01.org/0day-ci/archive/20230913/202309130632.LS04CPWu-lkp@intel.com/config)
> > compiler: sh4-linux-gcc (GCC) 13.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230913/202309130632.LS04CPWu-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202309130632.LS04CPWu-lkp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> >    sh4-linux-ld: drivers/video/fbdev/sh7760fb.o: in function `sh7760fb_probe':
> >    sh7760fb.c:(.text+0x374): undefined reference to `framebuffer_alloc'
> >    sh4-linux-ld: sh7760fb.c:(.text+0x394): undefined reference to `fb_videomode_to_var'
> >    sh4-linux-ld: sh7760fb.c:(.text+0x39c): undefined reference to `fb_alloc_cmap'
> >    sh4-linux-ld: sh7760fb.c:(.text+0x3a4): undefined reference to `register_framebuffer'
> >    sh4-linux-ld: sh7760fb.c:(.text+0x3ac): undefined reference to `fb_dealloc_cmap'
> >    sh4-linux-ld: sh7760fb.c:(.text+0x434): undefined reference to `framebuffer_release'
> >    sh4-linux-ld: drivers/video/fbdev/sh7760fb.o: in function `sh7760fb_remove':
> >    sh7760fb.c:(.text+0x800): undefined reference to `unregister_framebuffer'
> >    sh4-linux-ld: sh7760fb.c:(.text+0x804): undefined reference to `fb_dealloc_cmap'
> >    sh4-linux-ld: sh7760fb.c:(.text+0x814): undefined reference to `framebuffer_release'
> >>> sh4-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0xc): undefined reference to `fb_io_read'
> >>> sh4-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x10): undefined reference to `fb_io_write'
> >    sh4-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x2c): undefined reference to `cfb_fillrect'
> >    sh4-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x30): undefined reference to `cfb_copyarea'
> >    sh4-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x34): undefined reference to `cfb_imageblit'
>
> The problem is CONFIG_FB=m and CONFIG_FB_SH7760=y.
>
> This can be fixed by this simple change ... if it's correct.
>
> or this Kconfig entry can be made into a tristate, but that may not
> help with booting a system.

What kind of problem do you foresee? Users could still configure it builtin
when needed.

I see no reason to restrict this to builtin.
The driver already has all MODULE_*() boilerplate.

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

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
