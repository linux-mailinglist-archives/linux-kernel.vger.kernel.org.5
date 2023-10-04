Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E43F7B77FE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 08:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbjJDGjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 02:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjJDGi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 02:38:58 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDC0B8;
        Tue,  3 Oct 2023 23:38:54 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 1B4695C02A7;
        Wed,  4 Oct 2023 02:38:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 04 Oct 2023 02:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696401534; x=1696487934; bh=vV
        ULqIQxkx8IsxEb/CWWAc+AFUmUwyFUCiEJjN/g/cI=; b=CqohPlbOWBQcywrpAL
        AMCCoG9IyfNm2o1HLGnmOSiQY/Z/o2XL9iZa9ekdZG9iEiYCnjyCZUnhnZbna0hI
        HvBUXHjAG9qQV4R6MaXJT2E8HL9usTVTdPLrewyfNq8zfr6aLcEdMJj612x9260j
        c+Pc/JzfhiQMsrJhUE6zXElAeOekEEauGpZ8kjERGIwXAhJ/MRYJYz76o0W+LCJx
        T6CXQ2xnCw4AB9PAK7uL+JzEn7Xppa1BVflVExE4zUjaxyRgmDDUatDlgj76JoZj
        /D38kx52rWCsy2yWSs731CVr+ykKyTiah9SRmtVuXIvi7lh5czbYZ7Yz143e820e
        eMOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696401534; x=1696487934; bh=vVULqIQxkx8Is
        xEb/CWWAc+AFUmUwyFUCiEJjN/g/cI=; b=O97LdEgA+mlVkqVUmfLDW8Wo2TqZk
        xmotTs+rgUzBidzCbD5kzbgjfU5K84kbTMtMTqq5rf4HdA0aldto9zWZ8kXEwqbr
        6c9CvHSTtLm0hf8M7vh6cbhOQBMbK9xPztzkTma94e1z7fz7pf/eH1rltVDwIiUR
        +ox634+Eu9nRh4zKz77Jc1MwloC24h++iIUfpW/WT3mdIoHHQpHUDTO4DWGGXxZi
        6E4sFyOHRx5ZmKJWbOgGNSzhqlELSdGN18g5FxvxUh5f8vaECT3LF0gYjPhFQK37
        MQb3fjyoocXbxpHlmdxVTltqDOiKmgjemrBTq5Fru3eEX6U6Lmz3VsmWQ==
X-ME-Sender: <xms:fQgdZW4BHDwQ_mVyn-G2bz0841iPJNUMNklHw6XlnqqIORVb24bYGA>
    <xme:fQgdZf6Lk75If_ITBS1SKfBtYAGH6V1je0yn0EHvLW_tU6RxXWxeJ3Oy-VODpnxEV
    aU6kIrceZDBTw>
X-ME-Received: <xmr:fQgdZVcnIf6UMTvCvtFbBefqmsT8KhzHaZW4iqXoTMzWgoHL6-hfN-jMLa1oa04-Qkf-1MpWUGT2Jmpvn5PKFgJbaC3VTUHN9Xe5aQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgedugddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:fQgdZTJWjfhYi-EMim-119vOtM3Fuo0s5f9GVFSG2QapxyNVgBVp6w>
    <xmx:fQgdZaJj-t0TEhpfWbZTuU8-AjYmJAiJdnu6Rc3aAUVzhQY8NLWz7w>
    <xmx:fQgdZUyUXk8Hb-W8AFZhRaZdjhfrT09osEvGOI_tO5ZNFXjaPZPYGw>
    <xmx:fggdZXAiKccPd1RT3cGBuPaTMGAAGEnzisccQOFSCMGvPruqKhrJZg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Oct 2023 02:38:53 -0400 (EDT)
Date:   Wed, 4 Oct 2023 08:38:51 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: linux-next: manual merge of the tty tree with the tty.current
 tree
Message-ID: <2023100430-padding-deranged-1617@gregkh>
References: <20231004125531.0c61a99d@canb.auug.org.au>
 <20231004131432.40b7b946@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004131432.40b7b946@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 01:14:32PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> On Wed, 4 Oct 2023 12:55:31 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the tty tree got a conflict in:
> > 
> >   drivers/tty/serial/serial_core.c
> > 
> > between commit:
> > 
> >   8679328eb859 ("serial: Reduce spinlocked portion of uart_rs485_config()")
> > 
> > from the tty.current tree and commit:
> > 
> >   559c7ff4e324 ("serial: core: Use port lock wrappers")
> > 
> > from the tty tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> 
> Not quite right :-(  This is what I used:
> 
> diff --cc drivers/tty/serial/serial_core.c
> index ca26a8aef2cb,b32bbd7aa3d3..ae1d6782ea0e
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@@ -1413,9 -1409,7 +1413,9 @@@ static int uart_rs485_config(struct uar
>   	uart_sanitize_serial_rs485(port, rs485);
>   	uart_set_rs485_termination(port, rs485);
>   
> - 	spin_lock_irqsave(&port->lock, flags);
> ++	uart_port_lock_irqsave(port, &flags);
>   	ret = port->rs485_config(port, NULL, rs485);
> - 	spin_unlock_irqrestore(&port->lock, flags);
> ++	uart_port_unlock_irqrestore(port, flags);
>   	if (ret)
>   		memset(rs485, 0, sizeof(*rs485));
>   
> @@@ -2480,12 -2474,13 +2480,12 @@@ int uart_resume_port(struct uart_drive
>   			if (ret == 0) {
>   				if (tty)
>   					uart_change_line_settings(tty, state, NULL);
>  +				uart_rs485_config(uport);
> - 				spin_lock_irq(&uport->lock);
> + 				uart_port_lock_irq(uport);
>   				if (!(uport->rs485.flags & SER_RS485_ENABLED))
>   					ops->set_mctrl(uport, uport->mctrl);
>  -				else
>  -					uart_rs485_config(uport);
>   				ops->start_tx(uport);
> - 				spin_unlock_irq(&uport->lock);
> + 				uart_port_unlock_irq(uport);
>   				tty_port_set_initialized(port, true);
>   			} else {
>   				/*
> @@@ -2592,10 -2587,10 +2592,10 @@@ uart_configure_port(struct uart_driver 
>   		port->mctrl &= TIOCM_DTR;
>   		if (!(port->rs485.flags & SER_RS485_ENABLED))
>   			port->ops->set_mctrl(port, port->mctrl);
> - 		spin_unlock_irqrestore(&port->lock, flags);
>  -		else
>  -			uart_rs485_config(port);
> + 		uart_port_unlock_irqrestore(port, flags);
>   
>  +		uart_rs485_config(port);
>  +
>   		/*
>   		 * If this driver supports console, and it hasn't been
>   		 * successfully registered yet, try to re-register it.
> 
> 
> -- 
> Cheers,
> Stephen Rothwell

Thanks, looks good, I'll use this when I resolve the merge conflict when
it hits my branches.

greg k-h
