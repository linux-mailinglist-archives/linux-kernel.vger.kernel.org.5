Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A83793A71
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbjIFK6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 06:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjIFK6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:58:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82FF10C8;
        Wed,  6 Sep 2023 03:58:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF4DC433C8;
        Wed,  6 Sep 2023 10:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693997886;
        bh=7NWBFFeaDc5kT8Y4tg+pWiWspbiauLGDwmhKsxAfZMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U/XlV/6UuVF4Qt76H9wMzbr4sojsNCHBX/lHJnRKS+ELy0BXI5uNyJ6i6mglloVx0
         51pOvIHBe3Krn9iPW0Zxic92UplOJVWBIi6DWQHtRWIzkaQl0Mx3GXiWmvGiOf06VY
         C2mEw2Ewa5hNqikob57UuYhUuVxtcOw1Ve3RJQH8=
Date:   Wed, 6 Sep 2023 11:58:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Hugo Villeneuve <hugo@hugovil.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] serial: sc16is7xx: remove unused to_sc16is7xx_port macro
Message-ID: <2023090642-density-durably-c3ef@gregkh>
References: <20230905181649.134720-1-hugo@hugovil.com>
 <f8912f92-dda9-9f56-99fa-f3f79d95c86@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8912f92-dda9-9f56-99fa-f3f79d95c86@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 01:47:10PM +0300, Ilpo Järvinen wrote:
> On Tue, 5 Sep 2023, Hugo Villeneuve wrote:
> 
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > This macro is not used anywhere.
> > 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  drivers/tty/serial/sc16is7xx.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> > index f61d98e09dc3..d8534580c6d5 100644
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> > @@ -358,7 +358,6 @@ static struct uart_driver sc16is7xx_uart = {
> >  static void sc16is7xx_ier_set(struct uart_port *port, u8 bit);
> >  static void sc16is7xx_stop_tx(struct uart_port *port);
> >  
> > -#define to_sc16is7xx_port(p,e)	((container_of((p), struct sc16is7xx_port, e)))
> >  #define to_sc16is7xx_one(p,e)	((container_of((p), struct sc16is7xx_one, e)))
> >  
> >  static int sc16is7xx_line(struct uart_port *port)
> > 
> > base-commit: 3f86ed6ec0b390c033eae7f9c487a3fea268e027
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> Note that Greg might be happier if you wait next time until after the 
> merge window is closed before sending non-fixes patch like this.

I just ignore them and add them to my review queue until after -rc1 is
out, not a problem at all.

thanks,

greg k-h
