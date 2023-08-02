Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBA076CF2E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbjHBNtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbjHBNtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:49:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D9F2D45;
        Wed,  2 Aug 2023 06:49:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FA4B618F1;
        Wed,  2 Aug 2023 13:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B56C433C8;
        Wed,  2 Aug 2023 13:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690984142;
        bh=v4jY1Gnnh7BJLrSBv3CEToi+sTpVMfrijbgTYHUZl5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VtY7B05Y3BJsPCw9G1Lp0bugaHOHxnhSszQeKSEdsOAYl65UyKkA4YSu4jiDSlg1C
         YcPCIyD3imXJ2+CA/ek2KQ9lWI8zXJ91yLa/6iVBLqrvGaK40tWGpBlZBojIo5XHOP
         kNAecNhDPgIt/uLFlRiCM5s5N3zbVsfL/6WqCxas=
Date:   Wed, 2 Aug 2023 15:49:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update TTY layer for lists and recently
 added files
Message-ID: <2023080250-fender-salute-9830@gregkh>
References: <20230721072334.59272-1-tony@atomide.com>
 <ZLpboaXKVOOjeGJ+@smile.fi.intel.com>
 <20230724045327.GV5194@atomide.com>
 <2023072517-onward-payment-569d@gregkh>
 <2023072530-wired-chaps-c1e3@gregkh>
 <edb0414f-3808-8651-4956-8ec34b056901@kernel.org>
 <20230802120530.GE14799@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802120530.GE14799@atomide.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 03:05:30PM +0300, Tony Lindgren wrote:
> * Jiri Slaby <jirislaby@kernel.org> [230726 10:12]:
> > On 25. 07. 23, 19:29, Greg Kroah-Hartman wrote:
> > > On Tue, Jul 25, 2023 at 07:28:46PM +0200, Greg Kroah-Hartman wrote:
> > > > On Mon, Jul 24, 2023 at 07:53:27AM +0300, Tony Lindgren wrote:
> > > > > * Andy Shevchenko <andriy.shevchenko@intel.com> [230721 10:19]:
> > > > > > On Fri, Jul 21, 2023 at 10:23:32AM +0300, Tony Lindgren wrote:
> > > > > > > Add mailing lists for linux-serial and lkml for the TTY layer. And let's
> > > > > > > list the recently added files. This makes it easier for get_maintainer.pl
> > > > > > > to include linux-serial for patches.
> > > > > > 
> > > > > > Shouldn't serial_* stuff go to the "SERIAL DRIVERS" section?
> > > > > 
> > > > > Not sure if there's some reason we have "TTY LAYER" with serial_core
> > > > > files. If not, yeah let's move the serial files.
> > > > 
> > > > I'll take this patch, can you send a new one that removes the serial
> > > > files from this entry as I don't think they are needed in here anymore.
> > > 
> > > Better yet, they should be merged probably.  Although I don't know if
> > > Jiri wants to be responsible for serial stuff, that's his call...
> > 
> > No problem. I actually didn't realize they are separate. So feel free to
> > submit a patch, so we have a single MAINTAINTERS file entry...
> 
> How about something like this?
> 
> Tony
> 
> 8< ----------------------
> diff --git a/MAINTAINERS b/MAINTAINERS
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19319,13 +19319,6 @@ F:	Documentation/devicetree/bindings/serial/serial.yaml
>  F:	drivers/tty/serdev/
>  F:	include/linux/serdev.h
>  
> -SERIAL DRIVERS
> -M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> -L:	linux-serial@vger.kernel.org
> -S:	Maintained
> -F:	Documentation/devicetree/bindings/serial/
> -F:	drivers/tty/serial/
> -
>  SERIAL IR RECEIVER
>  M:	Sean Young <sean@mess.org>
>  L:	linux-media@vger.kernel.org
> @@ -21760,20 +21753,16 @@ W:	https://github.com/srcres258/linux-doc
>  T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
>  F:	Documentation/translations/zh_TW/
>  
> -TTY LAYER
> +TTY LAYER AND SERIAL DRIVERS
>  M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>  M:	Jiri Slaby <jirislaby@kernel.org>
>  L:	linux-kernel@vger.kernel.org
>  L:	linux-serial@vger.kernel.org
>  S:	Supported
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
> +F:	Documentation/devicetree/bindings/serial/
>  F:	Documentation/driver-api/serial/
>  F:	drivers/tty/
> -F:	drivers/tty/serial/serial_base.h
> -F:	drivers/tty/serial/serial_base_bus.c
> -F:	drivers/tty/serial/serial_core.c
> -F:	drivers/tty/serial/serial_ctrl.c
> -F:	drivers/tty/serial/serial_port.c
>  F:	include/linux/selection.h
>  F:	include/linux/serial.h
>  F:	include/linux/serial_core.h

Fine with me.
