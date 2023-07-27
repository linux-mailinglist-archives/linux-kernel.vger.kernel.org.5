Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01D3764663
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjG0GA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjG0GA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:00:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CA994;
        Wed, 26 Jul 2023 23:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Nppsaspz4CjT3S8/e89X2Jzh5rOqdX/6FAO/rCJxSxA=; b=VFOdBgzU376WuGfOouqajz4rEa
        6x/oaqtjy83zHp4U2Wg/jjTMjALPwOVd5lUkqLQVIxM2sKbRmiRt7p4UEQBSe28H6kDOBvfvvW5xg
        hK+Kjk48q7IDAlH5lmggxd7YvRh5sQUVTWhYk8cdh3eWHJk7mKEQHBuUShjYCq6oacw03MBHZqD/t
        8B0HfgEglK0l55kAoFW7pK371hHDFQtp3zhM0Z1FfI30YE5QjLt0pMnoc4hGczP1cvdjsy/beBMxc
        pDATdgWaxDeFgEWCGfAnULtnzmWR2HAYdhh2K6XZvA2UxTp8syvVLG8XjBeEOhhS7MVdDTeSIVwBZ
        ZCGywrAQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qOu3R-00CHBi-1c;
        Thu, 27 Jul 2023 06:00:53 +0000
Message-ID: <16a13cab-6974-e2a6-f4c5-45971ede258b@infradead.org>
Date:   Wed, 26 Jul 2023 23:00:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: linux-next: Tree for Jul 27 (fbdev/core/fbcon.o)
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-fbdev@vger.kernel.org
References: <20230727143346.079d4e5a@canb.auug.org.au>
 <4c1ba872-156a-68d4-4d2f-ef459a8b7997@infradead.org>
In-Reply-To: <4c1ba872-156a-68d4-4d2f-ef459a8b7997@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/23 22:56, Randy Dunlap wrote:
> 
> 
> On 7/26/23 21:33, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20230726:
>>
> 
> on ARCH=um, SUBARCH=i386:
> 
> many build errors for fbdev:
> 
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `store_rotate_all':
> UM32/../drivers/video/fbdev/core/fbcon.c:3205: undefined reference to `fg_console'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `store_rotate':
> UM32/../drivers/video/fbdev/core/fbcon.c:3183: undefined reference to `fg_console'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `show_cursor_blink':
> UM32/../drivers/video/fbdev/core/fbcon.c:3245: undefined reference to `fg_console'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `show_rotate':
> UM32/../drivers/video/fbdev/core/fbcon.c:3225: undefined reference to `fg_console'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_modechange_possible':
> UM32/../drivers/video/fbdev/core/fbcon.c:2766: undefined reference to `vc_cons'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `get_color':
> UM32/../drivers/video/fbdev/core/fbcon.c:287: undefined reference to `console_blanked'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_set_palette':
> UM32/../drivers/video/fbdev/core/fbcon.c:2571: undefined reference to `con_is_visible'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_modechanged':
> UM32/../drivers/video/fbdev/core/fbcon.c:2678: undefined reference to `vc_cons'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2686: undefined reference to `con_is_visible'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2692: undefined reference to `vc_resize'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2702: undefined reference to `color_table'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2703: undefined reference to `redraw_screen'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_set_all_vcs':
> UM32/../drivers/video/fbdev/core/fbcon.c:2718: undefined reference to `vc_cons'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2723: undefined reference to `con_is_visible'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2735: undefined reference to `vc_resize'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_debug_enter':
> UM32/../drivers/video/fbdev/core/fbcon.c:2253: undefined reference to `color_table'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_resize':
> UM32/../drivers/video/fbdev/core/fbcon.c:2048: undefined reference to `con_is_visible'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_set_disp':
> UM32/../drivers/video/fbdev/core/fbcon.c:1347: undefined reference to `vc_cons'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:1391: undefined reference to `vc_resize'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:1393: undefined reference to `con_is_visible'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:1394: undefined reference to `redraw_screen'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_deinit':
> UM32/../drivers/video/fbdev/core/fbcon.c:1190: undefined reference to `con_is_visible'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:1202: undefined reference to `con_is_bound'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `do_fbcon_takeover':
> UM32/../drivers/video/fbdev/core/fbcon.c:530: undefined reference to `do_take_over_console'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_do_set_font':
> UM32/../drivers/video/fbdev/core/fbcon.c:2430: undefined reference to `vc_resize'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2433: undefined reference to `con_is_visible'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2436: undefined reference to `redraw_screen'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_set_def_font':
> UM32/../drivers/video/fbdev/core/fbcon.c:2544: undefined reference to `get_default_font'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2546: undefined reference to `find_font'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_set_font':
> UM32/../drivers/video/fbdev/core/fbcon.c:2522: undefined reference to `vc_cons'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_prepare_logo':
> UM32/../drivers/video/fbdev/core/fbcon.c:612: undefined reference to `con_is_visible'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:614: undefined reference to `redraw_screen'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_init':
> UM32/../drivers/video/fbdev/core/fbcon.c:1022: undefined reference to `fg_console'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:1025: undefined reference to `vc_cons'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:1039: undefined reference to `find_font'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:1040: undefined reference to `get_default_font'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:1091: undefined reference to `con_is_visible'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:1123: undefined reference to `vc_resize'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:1133: undefined reference to `fg_console'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fb_flashcursor':
> UM32/../drivers/video/fbdev/core/fbcon.c:368: undefined reference to `vc_cons'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:370: undefined reference to `con_is_visible'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `store_cursor_blink':
> UM32/../drivers/video/fbdev/core/fbcon.c:3271: undefined reference to `fg_console'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_switch':
> UM32/../drivers/video/fbdev/core/fbcon.c:2072: undefined reference to `vc_cons'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2171: undefined reference to `color_table'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2176: undefined reference to `fg_console'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2178: undefined reference to `update_region'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_blank':
> UM32/../drivers/video/fbdev/core/fbcon.c:2232: undefined reference to `redraw_screen'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_startup':
> UM32/../drivers/video/fbdev/core/fbcon.c:923: undefined reference to `fg_console'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:924: undefined reference to `vc_cons'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:962: undefined reference to `find_font'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:963: undefined reference to `get_default_font'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:977: undefined reference to `vc_resize'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `set_con2fb_map':
> UM32/../drivers/video/fbdev/core/fbcon.c:822: undefined reference to `vc_cons'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:836: undefined reference to `con_is_bound'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:861: undefined reference to `fg_console'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `con2fb_init_display':
> UM32/../drivers/video/fbdev/core/fbcon.c:797: undefined reference to `fg_console'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:797: undefined reference to `vc_cons'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:806: undefined reference to `fg_console'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:806: undefined reference to `vc_cons'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:806: undefined reference to `redraw_screen'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_suspended':
> UM32/../drivers/video/fbdev/core/fbcon.c:2654: undefined reference to `vc_cons'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_resumed':
> UM32/../drivers/video/fbdev/core/fbcon.c:2666: undefined reference to `vc_cons'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2666: undefined reference to `redraw_screen'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_fb_unregistered':
> UM32/../drivers/video/fbdev/core/fbcon.c:2910: undefined reference to `do_unregister_con_driver'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_remap_all':
> UM32/../drivers/video/fbdev/core/fbcon.c:2930: undefined reference to `con_is_bound'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_fb_blanked':
> UM32/../drivers/video/fbdev/core/fbcon.c:3039: undefined reference to `vc_cons'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:3044: undefined reference to `con_is_visible'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:3046: undefined reference to `do_blank_screen'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:3048: undefined reference to `do_unblank_screen'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_new_modelist':
> UM32/../drivers/video/fbdev/core/fbcon.c:3065: undefined reference to `vc_cons'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_get_requirement':
> UM32/../drivers/video/fbdev/core/fbcon.c:3083: undefined reference to `vc_cons'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:3094: undefined reference to `fg_console'
> x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:3094: undefined reference to `vc_cons'
> 
> Full randconfig file is attached.


Sorry, I missed these kconfig warnings:


WARNING: unmet direct dependencies detected for FRAMEBUFFER_CONSOLE
  Depends on [n]: VT [=n] && FB_CORE [=y] && !UML [=y]
  Selected by [y]:
  - DRM_FBDEV_EMULATION [=y] && HAS_IOMEM [=y] && DRM [=y] && !EXPERT [=n]

WARNING: unmet direct dependencies detected for FRAMEBUFFER_CONSOLE_DETECT_PRIMARY
  Depends on [n]: VT [=n] && FRAMEBUFFER_CONSOLE [=y]
  Selected by [y]:
  - DRM_FBDEV_EMULATION [=y] && HAS_IOMEM [=y] && DRM [=y] && FRAMEBUFFER_CONSOLE [=y]

WARNING: unmet direct dependencies detected for FONT_8x16
  Depends on [n]: FONT_SUPPORT [=n]
  Selected by [y]:
  - FB_VT8623 [=y] && HAS_IOMEM [=y] && FB [=y] && PCI [=y] && FRAMEBUFFER_CONSOLE [=y]
  - FB_ARK [=y] && HAS_IOMEM [=y] && FB [=y] && PCI [=y] && FRAMEBUFFER_CONSOLE [=y]

WARNING: unmet direct dependencies detected for FRAMEBUFFER_CONSOLE
  Depends on [n]: VT [=n] && FB_CORE [=y] && !UML [=y]
  Selected by [y]:
  - DRM_FBDEV_EMULATION [=y] && HAS_IOMEM [=y] && DRM [=y] && !EXPERT [=n]

WARNING: unmet direct dependencies detected for FRAMEBUFFER_CONSOLE_DETECT_PRIMARY
  Depends on [n]: VT [=n] && FRAMEBUFFER_CONSOLE [=y]
  Selected by [y]:
  - DRM_FBDEV_EMULATION [=y] && HAS_IOMEM [=y] && DRM [=y] && FRAMEBUFFER_CONSOLE [=y]

WARNING: unmet direct dependencies detected for FONT_8x16
  Depends on [n]: FONT_SUPPORT [=n]
  Selected by [y]:
  - FB_VT8623 [=y] && HAS_IOMEM [=y] && FB [=y] && PCI [=y] && FRAMEBUFFER_CONSOLE [=y]
  - FB_ARK [=y] && HAS_IOMEM [=y] && FB [=y] && PCI [=y] && FRAMEBUFFER_CONSOLE [=y]

WARNING: unmet direct dependencies detected for FRAMEBUFFER_CONSOLE
  Depends on [n]: VT [=n] && FB_CORE [=y] && !UML [=y]
  Selected by [y]:
  - DRM_FBDEV_EMULATION [=y] && HAS_IOMEM [=y] && DRM [=y] && !EXPERT [=n]

WARNING: unmet direct dependencies detected for FRAMEBUFFER_CONSOLE_DETECT_PRIMARY
  Depends on [n]: VT [=n] && FRAMEBUFFER_CONSOLE [=y]
  Selected by [y]:
  - DRM_FBDEV_EMULATION [=y] && HAS_IOMEM [=y] && DRM [=y] && FRAMEBUFFER_CONSOLE [=y]

WARNING: unmet direct dependencies detected for FONT_8x16
  Depends on [n]: FONT_SUPPORT [=n]
  Selected by [y]:
  - FB_VT8623 [=y] && HAS_IOMEM [=y] && FB [=y] && PCI [=y] && FRAMEBUFFER_CONSOLE [=y]
  - FB_ARK [=y] && HAS_IOMEM [=y] && FB [=y] && PCI [=y] && FRAMEBUFFER_CONSOLE [=y]


-- 
~Randy
