Return-Path: <linux-kernel+bounces-139747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DE08A072F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36BAD1F255E6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D462B13B5B0;
	Thu, 11 Apr 2024 04:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="LckDQ6qy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="auCiEw45"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B271FBB;
	Thu, 11 Apr 2024 04:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712810321; cv=none; b=Hid/eUbnfIZNL29wF54BhKOcLtjSjkSk/6o+w9l/nQpien9SeLAmrqLn75UazZ+u5wkS8fGeb4ZV3AOARvDZEqL5Ri0uNtcaICgxHlMKfubR52/7xsT3z1tYmgYHA0uhRr9kFUEhkGYaBpJhYyUKxFerk1MN2k/MRACS0RLXTPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712810321; c=relaxed/simple;
	bh=2QJOCBKT8uqHKXrNRwNb+d1lBDm1dAOBkKyWx0fCqS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NN/EQgmsGNMDWNxUjVTHIzJCQilr2r8Ti3nXMvjfsiig4ZYArQ4aZ+/obJjHX9nT/mF/tWSFMEj08IFudO9qEa0qriaYOkkRR5yeToBFA+Hv6qWzoiEZVPDBZZU3TbNyDxuAbRueE/Rj3VZ6CBUBs6G2/vGR5z7PwcPbkFf0vaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=LckDQ6qy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=auCiEw45; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 81C371380228;
	Thu, 11 Apr 2024 00:38:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 11 Apr 2024 00:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712810318; x=1712896718; bh=NCWvNXzLHm
	JWqElu8lx/O63cakNTW+/sBJ2+LV2F62g=; b=LckDQ6qyi8k3r17YxgtthBV2OG
	uLt4GlPjsSkUw/pvPVBAL7mBUxe2t8KFfdG+RLqEA6caOKLT5OdZuxpt9hBjTM4W
	6lh4ZiRcmOUe9sKWWpp267iXgFrVlcAQ+40mw+mNWmq3DJp8u1kfk/0ypwQcoQpt
	+JbbfEo/t6plqBxmoIy6g2ksPM5DC6P74BoGN+KHvBIFB2peQO3WpF6JOpgZ+yss
	xYECwuGaDHxIqsk14CAR1jrSAbMYkcDNYYr19quX3BgEhO7beJcrTAGrHGA732ZJ
	MROYGElzOhiYhDAQIJovP1Jcc2Rz7bc6nfioEHoIC5M3mQpXLpEQDNicvpBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712810318; x=1712896718; bh=NCWvNXzLHmJWqElu8lx/O63cakNT
	W+/sBJ2+LV2F62g=; b=auCiEw45hGmBwqglKrV/A5NhHYXPQ64N1+sWQMnW1H8m
	9B5A0z+lYw1RxPR/X1ZzTGYVms1gSRj3e9M/veChMMQvr+I2JFEzW7dgTTKo+Xa+
	dVb9qZ25GeFlhtfLzP9LO+/WMw56Q8xUPp60/civ+hYOUDKDnmhCFzuysyAw/GzK
	4Nc+tr76d7WV6b7m2v1hGOHW8nR7NfBgH+9XcKiDIdIES4GbQPhpVDz4l9tRq9h+
	knQDdlwIW8sbI/hKdGcaD8wkZRskflsm0w6m6bBpCCyeIADoUGsrPnRuiEPonzbS
	t/X26uCNyLv8cF3aW2FZwiZWWWA4bkWzdTnhH9plhg==
X-ME-Sender: <xms:TWkXZup1WPQF8NESUunqMhVl6WTKDaGcvFdeK_xgJCvwxL-Ww_MfRg>
    <xme:TWkXZsqMSGslhaE88ZDnLEgKIIZHQZtEXYbGx-7ZDBYWYsrVYI9wzwTDBU-SucIgO
    viotL8BHOCLfA>
X-ME-Received: <xmr:TWkXZjPG-cnjF0bJNFyMCU7W3YWJM9ArHtT6B1Ho19DLdWq7-UjuNAKo8uY-6KyZE5unEkNEsC3PVom7kcAF8QAib5BSenOHVi37mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehjedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:TWkXZt6hUp1_fOVYtYDpJuVE4ct5R5Luwiuxow5yz_wEaKdHIekOCQ>
    <xmx:TWkXZt4jiDICQM824uLBeKXZW5VjUWpNq2pDUU63wco0dfHTh2snCA>
    <xmx:TWkXZthVv-mprY9qZBIXjFw4zV9koCkY3VJeNnIe1hVzKP1lknf37w>
    <xmx:TWkXZn4uVVMh6wfdZNSl_SyYioBfwJ0VhHtL5wyziUPv8czEkIIWbg>
    <xmx:TmkXZqxp1_XJpk7qO4rAwpJo8UudWGXZ0XXZVxZ8h6lpCAPcDFFyZhVG>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Apr 2024 00:38:37 -0400 (EDT)
Date: Thu, 11 Apr 2024 06:38:36 +0200
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tty tree with the tty.current
 tree
Message-ID: <2024041114-abide-ageless-d7d3@gregkh>
References: <20240411135735.58de7090@canb.auug.org.au>
 <20240411141711.63dbd8e9@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411141711.63dbd8e9@canb.auug.org.au>

On Thu, Apr 11, 2024 at 02:17:11PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> On Thu, 11 Apr 2024 13:57:35 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the tty tree got a conflict in:
> > 
> >   drivers/tty/serial/serial_core.c
> > 
> > between commit:
> > 
> >   9cf7ea2eeb74 ("serial: core: Clearing the circular buffer before NULLifying it")
> > 
> > from the tty.current tree and commit:
> > 
> >   1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
> > 
> > from the tty tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> > 
> > -- 
> > Cheers,
> > Stephen Rothwell
> > 
> > diff --cc drivers/tty/serial/serial_core.c
> > index 2247efe97250,a78ded8c60b5..000000000000
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@@ -1788,9 -1773,9 +1773,10 @@@ static void uart_tty_port_shutdown(stru
> >   	 * Free the transmit buffer.
> >   	 */
> >   	uart_port_lock_irq(uport);
> >  +	uart_circ_clear(&state->xmit);
> > - 	buf = state->xmit.buf;
> > - 	state->xmit.buf = NULL;
> > + 	buf = port->xmit_buf;
> > + 	port->xmit_buf = NULL;
> > + 	INIT_KFIFO(port->xmit_fifo);
> >   	uart_port_unlock_irq(uport);
> >   
> >   	free_page((unsigned long)buf);
> 
> That didn't work :-(
> 
> So I have used the below resolution instead.
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/tty/serial/serial_core.c
> index 2247efe97250,a78ded8c60b5..000000000000
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@@ -1788,9 -1773,9 +1773,10 @@@ static void uart_tty_port_shutdown(stru
>   	 * Free the transmit buffer.
>   	 */
>   	uart_port_lock_irq(uport);
> - 	uart_circ_clear(&state->xmit);
> - 	buf = state->xmit.buf;
> - 	state->xmit.buf = NULL;
> ++	kfifo_reset(&state->port.xmit_fifo);
> + 	buf = port->xmit_buf;
> + 	port->xmit_buf = NULL;
> + 	INIT_KFIFO(port->xmit_fifo);
>   	uart_port_unlock_irq(uport);
>   
>   	free_page((unsigned long)buf);

Thank you for this, I will use it when the tty-linus changes are merged
with Linus's tree.

greg k-h

