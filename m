Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6563D754DCA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 10:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjGPIN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 04:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjGPINY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 04:13:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FA7BA
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 01:13:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6FB760BDC
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 08:13:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AE8C433C8;
        Sun, 16 Jul 2023 08:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689495203;
        bh=BCIFLg+mMbk0thBBhvzQoEnkCvfabJlnfRYGon8GoqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=imkk8IULCUGqod3px62mXUQ/HYKxnLOCT8P1FTXcWdmtkfuz5npz8IjcD89H9wzDJ
         NLld1dHWLTWLdjCCp3t1TRbvtosqY+L9M9W/dodEJ93qLbpWStaVFWpv7BOjkkx80X
         MuBji2OnatVbGj3jmp8pqBSdQChojjSLcyHPRPaw=
Date:   Sun, 16 Jul 2023 10:13:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH] misc/genalloc: Name subpools by of_node_full_name()
Message-ID: <2023071603-trifocals-muppet-6906@gregkh>
References: <20230622074520.3058027-1-linus.walleij@linaro.org>
 <CACRpkdYOMtAyCCvv-t0tF6ztNnCdw6gGLOZskmD3QX4_3jyURA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYOMtAyCCvv-t0tF6ztNnCdw6gGLOZskmD3QX4_3jyURA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2023 at 09:44:39AM +0200, Linus Walleij wrote:
> Greg, could you apply this patch for fixes?
> 
> Thanks!
> 
> On Thu, Jun 22, 2023 at 9:45 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > A previous commit tried to come up with more generic subpool
> > names, but this isn't quite working: the node name was used
> > elsewhere to match pools to consumers which regressed the
> > nVidia Tegra 2/3 video decoder.
> >
> > Revert back to an earlier approach using of_node_full_name()
> > instead of just the name to make sure the pool name is more
> > unique, and change both sites using this in the kernel.
> >
> > It is not perfect since two SRAM nodes could have the same
> > subpool name but it makes the situation better than before.
> >
> > Reported-by: Dmitry Osipenko <digetx@gmail.com>
> > Fixes: 21e5a2d10c8f ("misc: sram: Generate unique names for subpools")
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Let me catch up with emails over the next week or so, I'll queue it up
then, thanks.

greg k-h
