Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE2F764658
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbjG0F53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbjG0F5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:57:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65B82D67;
        Wed, 26 Jul 2023 22:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:From:References:Cc:To:
        Subject:MIME-Version:Date:Message-ID:Content-Type:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2c3kQu8uKnfu7CvgeI6oAbhJJO1UTygONK37CsiKUek=; b=B8iqytb+J5HDP8QPiUbgPxRYo1
        N0GtxYBZTAzs7tRY1FI4U0ahr1YfaQflw61DbRbIEd9Sl339TFuMfRN3SWdA3JbXxn4tfvWTFhbEt
        4uswOw0iAUkS+zG6lb5YoR7956SrTy6vjIuaWgrvdYjqmijXJmrgegUMTJK50DnqMPtNKKxR/BeMw
        8T6QkHSJXRGOmJ8YZYVBJ3eO9eSI2KoqxzWNrT19RGfY2Qd+5h/1/vvBBNrGi92YMQHDyCLAQVTUH
        QEA6WY10udIdIAcEnqPKb6QxJctVCno/9vgXWWUw75MgOnnYuBPzPyB7gN5R+PwuuawLAT6hSnOTc
        BDXz60MA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qOtzQ-00CG0c-3C;
        Thu, 27 Jul 2023 05:56:45 +0000
Content-Type: multipart/mixed; boundary="------------bB2rne1QbhCmx81vuXuByPQ9"
Message-ID: <4c1ba872-156a-68d4-4d2f-ef459a8b7997@infradead.org>
Date:   Wed, 26 Jul 2023 22:56:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: linux-next: Tree for Jul 27 (fbdev/core/fbcon.o)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-fbdev@vger.kernel.org
References: <20230727143346.079d4e5a@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230727143346.079d4e5a@canb.auug.org.au>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------bB2rne1QbhCmx81vuXuByPQ9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/26/23 21:33, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20230726:
> 

on ARCH=um, SUBARCH=i386:

many build errors for fbdev:

x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `store_rotate_all':
UM32/../drivers/video/fbdev/core/fbcon.c:3205: undefined reference to `fg_console'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `store_rotate':
UM32/../drivers/video/fbdev/core/fbcon.c:3183: undefined reference to `fg_console'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `show_cursor_blink':
UM32/../drivers/video/fbdev/core/fbcon.c:3245: undefined reference to `fg_console'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `show_rotate':
UM32/../drivers/video/fbdev/core/fbcon.c:3225: undefined reference to `fg_console'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_modechange_possible':
UM32/../drivers/video/fbdev/core/fbcon.c:2766: undefined reference to `vc_cons'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `get_color':
UM32/../drivers/video/fbdev/core/fbcon.c:287: undefined reference to `console_blanked'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_set_palette':
UM32/../drivers/video/fbdev/core/fbcon.c:2571: undefined reference to `con_is_visible'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_modechanged':
UM32/../drivers/video/fbdev/core/fbcon.c:2678: undefined reference to `vc_cons'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2686: undefined reference to `con_is_visible'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2692: undefined reference to `vc_resize'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2702: undefined reference to `color_table'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2703: undefined reference to `redraw_screen'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_set_all_vcs':
UM32/../drivers/video/fbdev/core/fbcon.c:2718: undefined reference to `vc_cons'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2723: undefined reference to `con_is_visible'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2735: undefined reference to `vc_resize'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_debug_enter':
UM32/../drivers/video/fbdev/core/fbcon.c:2253: undefined reference to `color_table'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_resize':
UM32/../drivers/video/fbdev/core/fbcon.c:2048: undefined reference to `con_is_visible'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_set_disp':
UM32/../drivers/video/fbdev/core/fbcon.c:1347: undefined reference to `vc_cons'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:1391: undefined reference to `vc_resize'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:1393: undefined reference to `con_is_visible'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:1394: undefined reference to `redraw_screen'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_deinit':
UM32/../drivers/video/fbdev/core/fbcon.c:1190: undefined reference to `con_is_visible'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:1202: undefined reference to `con_is_bound'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `do_fbcon_takeover':
UM32/../drivers/video/fbdev/core/fbcon.c:530: undefined reference to `do_take_over_console'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_do_set_font':
UM32/../drivers/video/fbdev/core/fbcon.c:2430: undefined reference to `vc_resize'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2433: undefined reference to `con_is_visible'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2436: undefined reference to `redraw_screen'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_set_def_font':
UM32/../drivers/video/fbdev/core/fbcon.c:2544: undefined reference to `get_default_font'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2546: undefined reference to `find_font'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_set_font':
UM32/../drivers/video/fbdev/core/fbcon.c:2522: undefined reference to `vc_cons'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_prepare_logo':
UM32/../drivers/video/fbdev/core/fbcon.c:612: undefined reference to `con_is_visible'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:614: undefined reference to `redraw_screen'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_init':
UM32/../drivers/video/fbdev/core/fbcon.c:1022: undefined reference to `fg_console'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:1025: undefined reference to `vc_cons'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:1039: undefined reference to `find_font'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:1040: undefined reference to `get_default_font'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:1091: undefined reference to `con_is_visible'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:1123: undefined reference to `vc_resize'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:1133: undefined reference to `fg_console'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fb_flashcursor':
UM32/../drivers/video/fbdev/core/fbcon.c:368: undefined reference to `vc_cons'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:370: undefined reference to `con_is_visible'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `store_cursor_blink':
UM32/../drivers/video/fbdev/core/fbcon.c:3271: undefined reference to `fg_console'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_switch':
UM32/../drivers/video/fbdev/core/fbcon.c:2072: undefined reference to `vc_cons'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2171: undefined reference to `color_table'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2176: undefined reference to `fg_console'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2178: undefined reference to `update_region'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_blank':
UM32/../drivers/video/fbdev/core/fbcon.c:2232: undefined reference to `redraw_screen'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_startup':
UM32/../drivers/video/fbdev/core/fbcon.c:923: undefined reference to `fg_console'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:924: undefined reference to `vc_cons'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:962: undefined reference to `find_font'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:963: undefined reference to `get_default_font'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:977: undefined reference to `vc_resize'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `set_con2fb_map':
UM32/../drivers/video/fbdev/core/fbcon.c:822: undefined reference to `vc_cons'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:836: undefined reference to `con_is_bound'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:861: undefined reference to `fg_console'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `con2fb_init_display':
UM32/../drivers/video/fbdev/core/fbcon.c:797: undefined reference to `fg_console'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:797: undefined reference to `vc_cons'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:806: undefined reference to `fg_console'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:806: undefined reference to `vc_cons'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:806: undefined reference to `redraw_screen'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_suspended':
UM32/../drivers/video/fbdev/core/fbcon.c:2654: undefined reference to `vc_cons'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_resumed':
UM32/../drivers/video/fbdev/core/fbcon.c:2666: undefined reference to `vc_cons'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:2666: undefined reference to `redraw_screen'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_fb_unregistered':
UM32/../drivers/video/fbdev/core/fbcon.c:2910: undefined reference to `do_unregister_con_driver'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_remap_all':
UM32/../drivers/video/fbdev/core/fbcon.c:2930: undefined reference to `con_is_bound'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_fb_blanked':
UM32/../drivers/video/fbdev/core/fbcon.c:3039: undefined reference to `vc_cons'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:3044: undefined reference to `con_is_visible'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:3046: undefined reference to `do_blank_screen'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:3048: undefined reference to `do_unblank_screen'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_new_modelist':
UM32/../drivers/video/fbdev/core/fbcon.c:3065: undefined reference to `vc_cons'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_get_requirement':
UM32/../drivers/video/fbdev/core/fbcon.c:3083: undefined reference to `vc_cons'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:3094: undefined reference to `fg_console'
x86_64-suse-linux/13/../../../../x86_64-suse-linux/bin/ld: UM32/../drivers/video/fbdev/core/fbcon.c:3094: undefined reference to `vc_cons'

Full randconfig file is attached.
-- 
~Randy
--------------bB2rne1QbhCmx81vuXuByPQ9
Content-Type: application/gzip; name="config-r3965.gz"
Content-Disposition: attachment; filename="config-r3965.gz"
Content-Transfer-Encoding: base64

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
ydqeOB2O5AC0V8YNuJMzpuH/BdxLKYLBtAEA

--------------bB2rne1QbhCmx81vuXuByPQ9--
