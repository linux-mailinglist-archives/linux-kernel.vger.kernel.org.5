Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8EF7CA16E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjJPIUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPIUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:20:21 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26893A1;
        Mon, 16 Oct 2023 01:20:16 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailout.nyi.internal (Postfix) with ESMTP id D49E95C038A;
        Mon, 16 Oct 2023 04:20:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 16 Oct 2023 04:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1697444413; x=1697530813; bh=7q
        0NGsNM5BawRB9cyrdDLpuBJqBrzibSQtCtQq1DbgQ=; b=LALSR39/N+2FE+uQ6Y
        cP81iYbNRFvOO1XPgWByXSem/M3l8PFA73j3yHSF9ZNim7PzBbyhKpVd/ZlcRbFh
        6tPv0gL/dHgZbvsdOVPERy8/zhVYMB+SNAdF1mp2ceJrq/1KH/eSyqHmAVVCchct
        OvA+YnHeXDV+y3AXnADNrfjXtkY2TM493WPEFSYdI0P3TG4lU5Oh9CTErqgDsWBB
        54HoiXDpZLpiFAyEkhkWGZwOczQh9FdEHuNxUzaVrVnChtPYfAk9iDCz+p8QXoSH
        pz8XFTt4WKfvUAzEG34pWPz7vh9zFV2gPnbjyeRAIEnEZVlF671X5DxvCkBI3mcq
        YCmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697444413; x=1697530813; bh=7q0NGsNM5BawR
        B9cyrdDLpuBJqBrzibSQtCtQq1DbgQ=; b=nkgcO9PBgZ/A1OttALfj2KhOVG8Rw
        /5ZofOAP0haL6kGgunVg1B47R0NqmrbWrSDMAQbcJd26/Je93xUpdsqpE4GtM3ex
        ZOzbXvWZ789Ud9Wu2rQkenHTsH3dbUZD0Cjty9YsI38a3qU6KZOcnZbE4E3938pD
        6QbXHo/utvHlDnlw84rEqMa3IEkNCc7AAwaBRWpqRFAXMI3Bg95kCTe++kRRtkRs
        +O3PvAkETLRpXN8Q1f0O/EGU7TRLe2zPNEMQQCLj4ZM10MhzL8EC8SkSBtnaoeLs
        0qOFKARv2pwhFmJxvHyqBHVT12f60rZmCkrP5jqkowjZbkiA2niFSQeXQ==
X-ME-Sender: <xms:PfIsZemL6Q1F_AX0yz3d-wUA_PX6C9RJ5qhwmRtin8L3mpA-0ZN5bw>
    <xme:PfIsZV0E5hCASqFsutAuIvCD33_QI1DJUJ3Udsm8Nyx1QmCx0E67wa8uhKZ2PF5KG
    6gnFWTN-jzpng>
X-ME-Received: <xmr:PfIsZcrB93wnZW2tsjfuGyGERI9G4r5BcD_Ew6mXzl11MnOvAPrLaM2PeDE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjedtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfmjfcu
    oehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvdevvdelje
    eugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtoh
    hm
X-ME-Proxy: <xmx:PfIsZSlrtOQiRQAojp6qkRAXzT9QixkVt-0f8d-TYrcCyfLwv4G9Qw>
    <xmx:PfIsZc06KA0tC7tcepOmOeeMBQl3i_-FuIUlpWpJNsCuYQAAOhKkIQ>
    <xmx:PfIsZZvT1zr8ay_p3nTBQEWPGsNT-f1G5cioXzfMrQg9lAL80QBgMA>
    <xmx:PfIsZVsa97zhLObVdyIHaZlUcxyxS9nFYmKHmsB8OK-UmKRgROVXtQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Oct 2023 04:20:12 -0400 (EDT)
Date:   Mon, 16 Oct 2023 10:20:10 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: linux-next: manual merge of the tty tree with the tty.current
 tree
Message-ID: <2023101600-handling-dilation-c3e7@gregkh>
References: <20231004125531.0c61a99d@canb.auug.org.au>
 <20231004131432.40b7b946@canb.auug.org.au>
 <2023100430-padding-deranged-1617@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023100430-padding-deranged-1617@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 08:38:51AM +0200, Greg KH wrote:
> On Wed, Oct 04, 2023 at 01:14:32PM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > On Wed, 4 Oct 2023 12:55:31 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Today's linux-next merge of the tty tree got a conflict in:
> > > 
> > >   drivers/tty/serial/serial_core.c
> > > 
> > > between commit:
> > > 
> > >   8679328eb859 ("serial: Reduce spinlocked portion of uart_rs485_config()")
> > > 
> > > from the tty.current tree and commit:
> > > 
> > >   559c7ff4e324 ("serial: core: Use port lock wrappers")
> > > 
> > > from the tty tree.
> > > 
> > > I fixed it up (see below) and can carry the fix as necessary. This
> > > is now fixed as far as linux-next is concerned, but any non trivial
> > > conflicts should be mentioned to your upstream maintainer when your tree
> > > is submitted for merging.  You may also want to consider cooperating
> > > with the maintainer of the conflicting tree to minimise any particularly
> > > complex conflicts.
> > 
> > Not quite right :-(  This is what I used:
> > 
> > diff --cc drivers/tty/serial/serial_core.c
> > index ca26a8aef2cb,b32bbd7aa3d3..ae1d6782ea0e
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@@ -1413,9 -1409,7 +1413,9 @@@ static int uart_rs485_config(struct uar
> >   	uart_sanitize_serial_rs485(port, rs485);
> >   	uart_set_rs485_termination(port, rs485);
> >   
> > - 	spin_lock_irqsave(&port->lock, flags);
> > ++	uart_port_lock_irqsave(port, &flags);
> >   	ret = port->rs485_config(port, NULL, rs485);
> > - 	spin_unlock_irqrestore(&port->lock, flags);
> > ++	uart_port_unlock_irqrestore(port, flags);
> >   	if (ret)
> >   		memset(rs485, 0, sizeof(*rs485));
> >   
> > @@@ -2480,12 -2474,13 +2480,12 @@@ int uart_resume_port(struct uart_drive
> >   			if (ret == 0) {
> >   				if (tty)
> >   					uart_change_line_settings(tty, state, NULL);
> >  +				uart_rs485_config(uport);
> > - 				spin_lock_irq(&uport->lock);
> > + 				uart_port_lock_irq(uport);
> >   				if (!(uport->rs485.flags & SER_RS485_ENABLED))
> >   					ops->set_mctrl(uport, uport->mctrl);
> >  -				else
> >  -					uart_rs485_config(uport);
> >   				ops->start_tx(uport);
> > - 				spin_unlock_irq(&uport->lock);
> > + 				uart_port_unlock_irq(uport);
> >   				tty_port_set_initialized(port, true);
> >   			} else {
> >   				/*
> > @@@ -2592,10 -2587,10 +2592,10 @@@ uart_configure_port(struct uart_driver 
> >   		port->mctrl &= TIOCM_DTR;
> >   		if (!(port->rs485.flags & SER_RS485_ENABLED))
> >   			port->ops->set_mctrl(port, port->mctrl);
> > - 		spin_unlock_irqrestore(&port->lock, flags);
> >  -		else
> >  -			uart_rs485_config(port);
> > + 		uart_port_unlock_irqrestore(port, flags);
> >   
> >  +		uart_rs485_config(port);
> >  +
> >   		/*
> >   		 * If this driver supports console, and it hasn't been
> >   		 * successfully registered yet, try to re-register it.
> > 
> > 
> > -- 
> > Cheers,
> > Stephen Rothwell
> 
> Thanks, looks good, I'll use this when I resolve the merge conflict when
> it hits my branches.

This should now be resolved in my tree, thanks!

greg k-h
