Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4460676302F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjGZIpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbjGZIo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:44:57 -0400
Received: from mailrelay3-1.pub.mailoutpod2-cph3.one.com (mailrelay3-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:402::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFC672B9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=r4dvvFPG61dpi+m5wXOqVQJNPQ8+eRHy9QX8yy71vx8=;
        b=Jps4sk8eHMcL2LM6qEVk5txAIrGoJels8jZ2yVCw1HiHp3bxlnFEr+C6Av0VxQacs41hOX/ejaJSP
         5Vq+QvNHKzE1hy/Y34nCAE0HMQqR7CQzaMMxVn9DZCXl4liYWX/34D+mSiEXvnVTqJcf4Qq9s+jYd2
         Ror35/ej4d8OxXFWHbJ0g6GxPMSrdMMwUdJnnxATyCWczsPS2CYpUdf0wmsnQ36my+B4QkGbojjySh
         CebDGH9h/HS2a/n0mvW5Uq4FzTuDd7DMVbuJZeBj+KBOP0EDB+YuDcc6+XAGpEKKs/v2r/MyyFcrh3
         R41QRYlmQG8sZbYA9i48IaO/BGmf3Ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=r4dvvFPG61dpi+m5wXOqVQJNPQ8+eRHy9QX8yy71vx8=;
        b=Vm5WByldnd82gz8eTojY7srg8mddzQU9H1uSw04x5Fv1MYfeNKpZTR1mOgxTd3U4oswlVraqAYURY
         eam16l/Cw==
X-HalOne-ID: 70ef6e65-2b8f-11ee-a266-b90637070a9d
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay3 (Halon) with ESMTPSA
        id 70ef6e65-2b8f-11ee-a266-b90637070a9d;
        Wed, 26 Jul 2023 08:35:58 +0000 (UTC)
Date:   Wed, 26 Jul 2023 10:35:57 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel@lists.freedesktop.org, Helge Deller <deller@gmx.de>,
        linux-fbdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: logo: LOGO should depend on FB_CORE i.s.o. FB
Message-ID: <20230726083557.GA921641@ravnborg.org>
References: <5ab3d1fe7b67ab10e4bc1bdbc0fa7731f7960965.1690300189.git.geert+renesas@glider.be>
 <87a5vkj7qe.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdWBznkqYxCWD2uwGtWLqXnBqX1Ycg31fBDc4cq2u8DkNQ@mail.gmail.com>
 <877cqoj5q5.fsf@minerva.mail-host-address-is-not-set>
 <c10d925b-8d37-caa0-8f66-a0206f948c69@suse.de>
 <874jlrkbtf.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jlrkbtf.fsf@minerva.mail-host-address-is-not-set>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 09:53:16PM +0200, Javier Martinez Canillas wrote:
> Thomas Zimmermann <tzimmermann@suse.de> writes:
> 
> > Hi
> >
> 
> [...]
> 
> >> 
> >> Yes. I meant to move drivers/video/logo/ to drivers/fbdev/core/logo and to
> >> source its Kconfig from drivers/fbdev/core/Kconfig, since it now depends
> >> on FB_CORE.
> >
> > No, please rather leave it where it is. There's no code dependencies to 
> > the fbdev core; it merely depends on the Kconfig token.
> >
> 
> Sure, fine by me. But I disagree that there's merely a Kconfig dependency.
> The include/linux/linux_logo.h header declares both fb_find_logo() and
> fb_append_extra_logo().
> 
> The fb_find_logo() function is defined in drivers/video/logo.c while the
> fb_append_extra_logo() is in drivers/video/fbdev/core/fbmem.c, even though
> only arch/powerpc/platforms/cell/spu_base.c uses fb_append_extra_logo().
> 
> So there's a relationship already between logo and fbdev/core, that's why
> I wondered if would make sense to also move drivers/video/logo.c to have
> both functions in there.
Or as I also suggested on irc - to pull out all the logo stuff from
fbmem and put it in video/logo/
With a bit of refactoring to make it obvious this is logo stuff and
maybe avoid some of the ifdeffery in the code of the users.

	Sam
