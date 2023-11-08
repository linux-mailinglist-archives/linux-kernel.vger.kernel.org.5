Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D9A7E5B20
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjKHQZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjKHQZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:25:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26D81BFA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 08:25:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E05C433C8;
        Wed,  8 Nov 2023 16:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699460721;
        bh=QDP2PkpuNljZi5l7VgltxnPr6lgtd/xesU719E+bNwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q24sJpFEgQcM0ZojLTFo7kRKdEfZ8kLMHPyttUjcyqoszAhE9uS54Yo1gjsw3wcD7
         6UHYintdG8EEsSFJd6O1qEnM3CsGueWEWwHZ+e5Xr3VGU6bVOJvmUnooAwbshgshq1
         hAQFWrAManfQFuXZpagDiJPjorzzfKxNIogIdC6Y=
Date:   Wed, 8 Nov 2023 17:25:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Ayush Singh <ayushdevel1325@gmail.com>,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] greybus: beagleplay: select CONFIG_CRC_CCITT
Message-ID: <2023110809-splendor-debtor-b073@gregkh>
References: <20231108153429.1072732-1-arnd@kernel.org>
 <d242c2e8-85a8-43b7-8438-d83f1b90c8b2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d242c2e8-85a8-43b7-8438-d83f1b90c8b2@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 08:12:57AM -0800, Randy Dunlap wrote:
> 
> 
> On 11/8/23 07:34, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > Without the CRC_CCITT code, the new greybus driver fails to link:
> > 
> > aarch64-linux-ld: drivers/greybus/gb-beagleplay.o: in function `hdlc_append_tx_u8':
> > gb-beagleplay.c:(.text+0x158): undefined reference to `crc_ccitt'
> > aarch64-linux-ld: drivers/greybus/gb-beagleplay.o: in function `gb_tty_receive':
> > gb-beagleplay.c:(.text+0x5c4): undefined reference to `crc_ccitt'
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/greybus/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/greybus/Kconfig b/drivers/greybus/Kconfig
> > index 033d31dbf3b8..ab81ceceb337 100644
> > --- a/drivers/greybus/Kconfig
> > +++ b/drivers/greybus/Kconfig
> > @@ -20,6 +20,7 @@ if GREYBUS
> >  config GREYBUS_BEAGLEPLAY
> >  	tristate "Greybus BeaglePlay driver"
> >  	depends on SERIAL_DEV_BUS
> > +	select CRC_CCITT
> >  	help
> >  	  Select this option if you have a BeaglePlay where CC1352
> >  	  co-processor acts as Greybus SVC.
> 
> Yes, same as my patch:
> https://lore.kernel.org/lkml/20231031040909.21201-1-rdunlap@infradead.org/
> 
> I expect that Greg just hasn't gotten around to applying new patches/fixes yet.

Nope, waiting until -rc1 is out, sorry.

greg k-h
