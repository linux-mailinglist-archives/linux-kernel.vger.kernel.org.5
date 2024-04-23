Return-Path: <linux-kernel+bounces-154972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 793D38AE3C7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E67F283C56
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2E57E573;
	Tue, 23 Apr 2024 11:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Zdv9eV9e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jX4Pltxf"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD80F634EA;
	Tue, 23 Apr 2024 11:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871506; cv=none; b=NPZJHt1ktUBs4d4DjBFfGBy994YhNB0RP+q2yX0xaOc+aRE9lMUcXYB9W/xvfzzEX5N7Y33oel6V/HKDYC2yRqjr4+inoTXgwnwmiakg91VX6aVQaR9pW3sjLBf6OX+oT6vhTl6GRrDN7z9ZUMb+nYWXF3Tem3oGMkd7E+FrFuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871506; c=relaxed/simple;
	bh=r+cc1d5mrSiT1NWZ4GMqLqmCRSJ7o/Mrj/vYFpuWVao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifWfd8mJJcLR02vA0Co9JZVdwqsmp3crinZxNg+X+dvJOB3ra8Hn/gtnfA/0taRggOrkbtBpVB02CXu6UkaYkwXrZZZDC72YjOkb9Ov53akKgT4vsODGtAxlhh37zkrxE2p1Jc37+uvnFgxsqXJbhaWC3hay7nhUKhYn+vAlxsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=Zdv9eV9e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jX4Pltxf; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C39C51140163;
	Tue, 23 Apr 2024 07:25:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 23 Apr 2024 07:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713871502; x=1713957902; bh=yooErJBigy
	jo0SOAFo2gUEaSYwKmOo0iaTHxSpAeDhE=; b=Zdv9eV9e8w6YRsR7Wnv+Xj8xCN
	pThapi9PxUY9jL5o04WMw1PfLQpWxRiyf4po6fBvI4Wn6PvlwQ3rSnI8K5V172WK
	/KjNNIAtOklnQSxzW2GM4TsrzflZslHwu6AVBYcLsD9/Al113QUysRt3TEzSty9J
	qjIVRRE1mYrtjXW2K/7UpbqjaUechIRXuJKghSjapU5vLMq1I4Q15cugFjIdEWlf
	mFLnJek09OI6iiVThT17fmZiSNvXQfYNdUh4Y96VnxvzPW7AC2jYRpjF/uOsd9V0
	LGw1H/xlINZ75eexLbSgJxjStq0CvPOR+Um2HaD+OnBlkodR+S+Y+GqAK89g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713871502; x=1713957902; bh=yooErJBigyjo0SOAFo2gUEaSYwKm
	Oo0iaTHxSpAeDhE=; b=jX4PltxfG+270EN3VFiDrE+oar+iEcr260aatAKJ49yg
	4VyX+uEwjL4O0dbjQ9/AIZ/9YMTPUuqjJeTk999nApl0nz9T/j/zqz+fEddvuuIs
	jmJgqDnXsyIl7cHO0sDj49tlqjphXX+BsHcuss8r0E69bi1VWO4c472CkbCXYbam
	hL1emYpTRVQTP93BufQCoES6Za9JBnhcC3Wr29MQxyPbIR2m0sZ9SGi4/EMKKbjV
	SK5Y/ZIqF2E/EwoSpCWN7t8bMeUEyFu9DS686Y1vy0gxjsiwtdvgvQsywC31fU0B
	g9y33FEY9qr+7QkX7pEmc4p6zh3UZtrR70eQqoynHg==
X-ME-Sender: <xms:jZonZmAqqRQl8UjcvbdF7xSe0HfjrzoKm8cO9jSTjV_a6-2D08EcWg>
    <xme:jZonZghnj2AdcKNmBn0u629J4hpGdzB1rootX8YPCkRpUvF4hJztUKgagK27yBAFn
    MMW2LxqN1s-KQ>
X-ME-Received: <xmr:jZonZplmYNZePKLELINQcy4VacTD1QCSbbHWt94hIDFt6op8x9pwfHUcOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeluddgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:jZonZkyRKGv18AZ0mZpJyLdC9q4lzmgz4feV4magE_EUU7bL3jC8mw>
    <xmx:jZonZrTpIymgRb_8lyh1c8-BbfM8M2_WFwmCYsZSXgMBJljc6V8-zA>
    <xmx:jZonZvbVGNONIzBA6712O5q9VdL2T1GjLzsR3sGf8Gzgn-tRq5IFMg>
    <xmx:jZonZkSvMze83y4coMQXfFNPFETD7qHz2XfvCh9HFgHzCkLine6W3A>
    <xmx:jponZgJR6K-cvbyV1oLZH_g-1Sx2rRpP8tmnBZ-cYXXQofB7wUknv2gI>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Apr 2024 07:25:01 -0400 (EDT)
Date: Tue, 23 Apr 2024 13:24:50 +0200
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tty tree with the tty.current
 tree
Message-ID: <2024042326-numbness-arrogance-ce7c@gregkh>
References: <20240419141947.4bc16fa4@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419141947.4bc16fa4@canb.auug.org.au>

On Fri, Apr 19, 2024 at 02:19:47PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the tty tree got a conflict in:
> 
>   drivers/tty/serial/serial_core.c
> 
> between commit:
> 
>   9cf7ea2eeb74 ("serial: core: Clearing the circular buffer before NULLifying it")
> 
> from the tty.current tree and commits:
> 
>   1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
>   abcd8632f26b ("serial: core: Extract uart_alloc_xmit_buf() and uart_free_xmit_buf()")
> 
> from the tty tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/tty/serial/serial_core.c
> index c476d884356d,b9d631037ff6..000000000000
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@@ -285,6 -273,53 +273,54 @@@ static int uart_alloc_xmit_buf(struct t
>   		free_page(page);
>   	}
>   
> + 	return 0;
> + }
> + 
> + static void uart_free_xmit_buf(struct tty_port *port)
> + {
> + 	struct uart_state *state = container_of(port, struct uart_state, port);
> + 	struct uart_port *uport;
> + 	unsigned long flags;
> + 	char *xmit_buf;
> + 
> + 	/*
> + 	 * Do not free() the transmit buffer page under the port lock since
> + 	 * this can create various circular locking scenarios. For instance,
> + 	 * console driver may need to allocate/free a debug object, which
> + 	 * can end up in printk() recursion.
> + 	 */
> + 	uport = uart_port_lock(state, flags);
> ++	kfifo_reset(&state->port.xmit_fifo);
> + 	xmit_buf = port->xmit_buf;
> + 	port->xmit_buf = NULL;
> + 	INIT_KFIFO(port->xmit_fifo);

The INIT_KFIFO() call here does the same (same plus more) than the
kfifo_reset() call does, so I'll just drop the kfifo_reset() here and
all should be fine.  I'll do this in my tree now, thanks.

greg k-h

