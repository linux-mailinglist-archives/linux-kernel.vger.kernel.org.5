Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0705A81105C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377485AbjLMLmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbjLMLmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:42:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7D4A5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:42:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFCBC433C7;
        Wed, 13 Dec 2023 11:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702467732;
        bh=1vE/zzbxSADW+upL7QWLplgWH0pgOZiq9dOEA6CmitU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KndCDJnulYRqiJ3doUao0vYtq17Ji+F+E3huOFCgEVjKCQSusaPJF6sGxezj+zB03
         v57qlCpx5XoJbBrwuUcXCcqQRYv5bg8uZsdipbsSbYJ44xo4OzWJijSeH7gW4oyIPE
         Uf1jIuIJRSvegnP04aUIVL2CqE5aJM2G2Ezhix4QsrMB0vpSjAOO53YhyTJ2v3neSQ
         Klnk2TLdXhozpsA0payECkTpCtkUnkv0BdrHCwLiNoosRAc1V7I5J0h3um5wk/1a1A
         BLTAK/kiBegGEYOdv7yz3a4GgCeHCW6sHwXdIB6QXDIRlAtR+ZMRpkCB8X1cMZCXyi
         Yuf2szvDw7sqA==
Date:   Wed, 13 Dec 2023 11:42:07 +0000
From:   Lee Jones <lee@kernel.org>
To:     Helge Deller <deller@gmx.de>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fbdev@vger.kernel.org, linux-mtd@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Andy Lowe <alowe@mvista.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Alan Hourihane <alanh@fairlite.co.uk>
Subject: Re: [PATCH 1/2] fbdev: Remove support for Carillo Ranch driver
Message-ID: <20231213114207.GJ111411@google.com>
References: <20231208224703.1603264-1-willy@infradead.org>
 <1f800b42-03a2-452e-b2a3-912250936413@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f800b42-03a2-452e-b2a3-912250936413@gmx.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023, Helge Deller wrote:

> On 12/8/23 23:47, Matthew Wilcox (Oracle) wrote:
> > As far as anybody can tell, this product never shipped.  If it did,
> > it shipped in 2007 and nobody has access to one any more.  Remove the
> > fbdev driver and the backlight driver.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >   drivers/video/backlight/Kconfig           |    7 -
> >   drivers/video/backlight/Makefile          |    1 -
> >   drivers/video/backlight/cr_bllcd.c        |  264 -----
> >   drivers/video/fbdev/Kconfig               |   15 -
> >   drivers/video/fbdev/Makefile              |    1 -
> >   drivers/video/fbdev/vermilion/Makefile    |    6 -
> >   drivers/video/fbdev/vermilion/cr_pll.c    |  195 ----
> >   drivers/video/fbdev/vermilion/vermilion.c | 1175 ---------------------
> >   drivers/video/fbdev/vermilion/vermilion.h |  245 -----
> >   9 files changed, 1909 deletions(-)
> >   delete mode 100644 drivers/video/backlight/cr_bllcd.c
> >   delete mode 100644 drivers/video/fbdev/vermilion/Makefile
> >   delete mode 100644 drivers/video/fbdev/vermilion/cr_pll.c
> >   delete mode 100644 drivers/video/fbdev/vermilion/vermilion.c
> >   delete mode 100644 drivers/video/fbdev/vermilion/vermilion.h
> 
> I've applied this patch to the fbdev git tree.
> It touches the backlight tree, so I hope it's ok for backlight people?

Better to ask for forgiveness than permission it seems! :)

-- 
Lee Jones [李琼斯]
