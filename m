Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD25798AB7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 18:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243853AbjIHQfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 12:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjIHQfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 12:35:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F8F199F;
        Fri,  8 Sep 2023 09:35:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E85C433C7;
        Fri,  8 Sep 2023 16:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694190910;
        bh=opvoYBGCH4dY7vMCWNy9kQQq8R5kic6SeZ7L6tqcHnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fxBhmPd2ZSWlr0act9Ady9X7FRpPNRybLf1MPGEqt3gKZIST754/dqOVnHsImSbDP
         qIp8PdxFM58KUkuY1/RZYt9jPqNqBnOoDAM4JUENrm4eJt3Dz+kXB0qqr7/3lFNqNr
         F5+xDqzjYE8lyIJuGObee0/mHLCMHvnX8pMcKA4s=
Date:   Fri, 8 Sep 2023 17:35:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable <stable@kernel.org>,
        Stefan Lippers-Hollmann <s.l-h@gmx.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-media@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH] media: dvb: symbol fixup for dvb_attach()
Message-ID: <2023090852-stoppable-jackpot-549f@gregkh>
References: <20230908092035.3815268-2-gregkh@linuxfoundation.org>
 <ZPtKCc2PLi0wdR2+@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPtKCc2PLi0wdR2+@bombadil.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 09:21:29AM -0700, Luis Chamberlain wrote:
> On Fri, Sep 08, 2023 at 10:20:36AM +0100, Greg Kroah-Hartman wrote:
> > In commit 9011e49d54dc ("modules: only allow symbol_get of
> > EXPORT_SYMBOL_GPL modules") the use of symbol_get is properly restricted
> > to GPL-only marked symbols.  This interacts oddly with the DVB logic
> > which only uses dvb_attach() to load the dvb driver which then uses
> > symbol_get().
> > 
> > Fix this up by properly marking all of the dvb_attach attach symbols as
> > EXPORT_SYMBOL_GPL().
> > 
> > Fixes: 9011e49d54dc ("modules: only allow symbol_get of EXPORT_SYMBOL_GPL modules")
> > Cc: stable <stable@kernel.org>
> > Reported-by: Stefan Lippers-Hollmann <s.l-h@gmx.de>
> > Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: linux-media@vger.kernel.org
> > Cc: linux-modules@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > Luis, do you want to take this through your tree?  Or Mauro's?  Or I can
> > take it through mine, it should get to Linus soon as this is causing
> > regressions in his tree.
> 
> You've done the work so it is up to you, whatever helps you expedite it
> as it already hit stable. Feel free to take it through your tree.

If you ack it, I can take it now through my tree and send it to Linus
tomorrow.

thanks,

greg k-h
