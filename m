Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E927620B1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 19:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjGYR4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 13:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjGYR4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 13:56:44 -0400
Received: from mailrelay1-1.pub.mailoutpod2-cph3.one.com (mailrelay1-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:400::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539F71FF2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 10:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=b58HxDk4pWLDi3O792SrDwRigi4TNZsbJpTqvdkuXQw=;
        b=LTkZxPGUiYmTXLYVZ70EIwnAuEoe8IidUv1urjDHVF5DE3iKISkV+wNHqwNX82fb7/9zJB3ERTrWM
         bklyLi2z/tBAjWAK+ECNdJQMVcvPGEHI2tmGvpL6yBU0ydySDdUcCystBKecmscZoB6pmbc+1MZCtL
         7vtFk89c/Ng+awbupm6PbMATPhDFGcdSRHWbqdZnsbSTqo+ZeCnEsBMzLRmHSxvHup0/vCe0AuDWly
         1NBfaeOWi9c7IREaldfHCXXuIZxrLJhi4g66bi007ctX+1xa2nNPlcIWZpjU04OQrNpL1uiYbgT59z
         iutkNuTtxPnmMmlGnnRTtwjTXcki3/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=b58HxDk4pWLDi3O792SrDwRigi4TNZsbJpTqvdkuXQw=;
        b=xIWNFOA9Y1e5I+D5BtIac7rX8eyu5PIYXyX3JRjEgiw/PCuSip3XrYqqz7VhOkTpSmuYrJDJcO/KG
         yvd4QkeAg==
X-HalOne-ID: 9a250718-2b14-11ee-9efa-99461c6a3fe8
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay1 (Halon) with ESMTPSA
        id 9a250718-2b14-11ee-9efa-99461c6a3fe8;
        Tue, 25 Jul 2023 17:56:40 +0000 (UTC)
Date:   Tue, 25 Jul 2023 19:56:39 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: logo: LOGO should depend on FB_CORE i.s.o. FB
Message-ID: <20230725175639.GC838289@ravnborg.org>
References: <5ab3d1fe7b67ab10e4bc1bdbc0fa7731f7960965.1690300189.git.geert+renesas@glider.be>
 <87a5vkj7qe.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdWBznkqYxCWD2uwGtWLqXnBqX1Ycg31fBDc4cq2u8DkNQ@mail.gmail.com>
 <877cqoj5q5.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cqoj5q5.fsf@minerva.mail-host-address-is-not-set>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

> >> >  menuconfig LOGO
> >> >       bool "Bootup logo"
> >> > -     depends on FB || SGI_NEWPORT_CONSOLE
> >> > +     depends on FB_CORE || SGI_NEWPORT_CONSOLE
> >> >       help
> >> >         Enable and select frame buffer bootup logos.
> >>
> >> Should then move this option to drivers/video/fbdev/core/Kconfig ?
> >
> > No, all logo options are in their own file.
> >
> 
> Yes. I meant to move drivers/video/logo/ to drivers/fbdev/core/logo and to
> source its Kconfig from drivers/fbdev/core/Kconfig, since it now depends
> on FB_CORE.
> 
> But I see now that it also depends on SGI_NEWPORT_CONSOLE, so having those
> in drivers/video/logo makes sense indeed.

The SGI_NEWPORT_CONSOLE should be replaced by some ifdef in the
newport_con.c code - to do what other drivers do.
But thats for another day.

	Sam
