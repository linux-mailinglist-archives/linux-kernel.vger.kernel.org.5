Return-Path: <linux-kernel+bounces-151503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D97258AAFB9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1773D1C21410
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BB912BEBB;
	Fri, 19 Apr 2024 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="nLO7R+Fw"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021C112A151;
	Fri, 19 Apr 2024 13:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713534559; cv=none; b=WpRB9fiGVW0Gj0pMYxqxLC4qydCF4OQjGklpeeJsFu3EXNRiaNupmuPnM+Nlhh43CmdVDBS0aTQ1ij3l424uDNiBkiiTq0u6qUkTrpo4G1NbgUOsmacxBvbKmuH+AyVHb3M/sRws6814cSur6nO2dUJ31zNSDvSYZjEYVXFXAb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713534559; c=relaxed/simple;
	bh=jxH8FhJWpDgQUXcEQKQMzaAbxlJ84zYWCvqJAeOPUM0=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=OuIjlLT+wo9YZlHTmm3b7HI6qP0JPWQfEOn2oblJi6WaftFDe9eAtnHXo9/PZLiqGtaCyZtgjDssYWP9dgWsSuOEbQ5T9TYSq80BQABcGvIa6yzAL90MMBV2pz+1aOxVEQ7c+0ZW+Rp2wUjfFgkKB9wapJtrNa2E9YmLcvIbuZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=nLO7R+Fw; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=8+E9VtuaG9ezLqos4LlwN9niDTf2ke/sHGmBDJU06d0=; b=nLO7R+Fw8X7BJGF9S7+R8F65gq
	I1hNXhZ3UI8GTbcadgAtI4FBr6U/xfzpqil0XAkgmK3+ujwE8Jojd26qz8XFl3Yv+6QGHv0pLYYpf
	YAgdnAEjydvzU3INpQzgb7y1tQqTJPOsXnELImTRuz3mkWRFRkaeDxMM/F4i8X3/rOD8=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:43560 helo=debian-acer)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rxoJM-0002l3-Km; Fri, 19 Apr 2024 09:29:52 -0400
Date: Fri, 19 Apr 2024 09:29:52 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Konstantin Pugin <rilian.la.te@ya.ru>
Cc: Konstantin Pugin <ria.freelander@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Hugo
 Villeneuve <hvilleneuve@dimonoff.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Lech Perczak
 <lech.perczak@camlingroup.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Message-Id: <20240419092952.e458f83d8b414b178d598c19@hugovil.com>
In-Reply-To: <20240419124506.1531035-2-rilian.la.te@ya.ru>
References: <20240419124506.1531035-1-rilian.la.te@ya.ru>
	<20240419124506.1531035-2-rilian.la.te@ya.ru>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -2.2 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v4 1/3] serial: sc16is7xx: announce support of
 SER_RS485_RTS_ON_SEND
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Fri, 19 Apr 2024 15:45:01 +0300
Konstantin Pugin <rilian.la.te@ya.ru> wrote:

> From: Konstantin Pugin <ria.freelander@gmail.com>
> 
> The hardware supports both RTS_ON_SEND and RTS_AFTER_SEND modes, but
> after the commit 4afeced55baa ("serial: core: fix sanitizing check for
> RTS settings") we always end up with SER_RS485_RTS_AFTER_SEND set and
> always write to the register field SC16IS7XX_EFCR_RTS_INVERT_BIT, which
> breaks some hardware using these chips.

Hi Konstantin,
I am using RS-485 mode, and currently I may need SC16IS7XX_EFCR_RTS_INVERT_BIT to be set for my setup to work (not sure, must check this). Does it mean that with this patch it will be cleared? I am not sure by reading your commit message...

I need to look at this in more details, and test it on my hardware, which I will be able to do only next week. I will keep you posted.

Hugo.



> 
> Fixes: 267913ecf737 ("serial: sc16is7xx: Fill in rs485_supported")
> Signed-off-by: Konstantin Pugin <ria.freelander@gmail.com>
> ---
>  drivers/tty/serial/sc16is7xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 03cf30e20b75..dfcc804f558f 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -1449,7 +1449,7 @@ static int sc16is7xx_setup_mctrl_ports(struct sc16is7xx_port *s,
>  }
>  
>  static const struct serial_rs485 sc16is7xx_rs485_supported = {
> -	.flags = SER_RS485_ENABLED | SER_RS485_RTS_AFTER_SEND,
> +	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND,
>  	.delay_rts_before_send = 1,
>  	.delay_rts_after_send = 1,	/* Not supported but keep returning -EINVAL */
>  };
> -- 
> 2.34.1
> 
> 
> 


-- 
Hugo Villeneuve <hugo@hugovil.com>

