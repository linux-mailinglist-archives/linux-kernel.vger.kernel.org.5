Return-Path: <linux-kernel+bounces-58282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0BB84E407
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 143DF28D5D0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624E87640A;
	Thu,  8 Feb 2024 15:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="tBo8WICt"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4DF7B3EA;
	Thu,  8 Feb 2024 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707405986; cv=none; b=PqxsvyfOT//VhttZAx9JddA68dEhAZtmjAGyO3eNR8Ksy6/EksGAbizHY7djAzz8ZN8Y86bA+rRcrUgJuj30xvJlgtxkJWF+9tEBVCRbuCyZXxjytWAVRH0jzUsBr5l+Wq5EwLQ+pENjSFNEayeBCXyoBPAC2E4eooVz3ueRvDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707405986; c=relaxed/simple;
	bh=rGHq7lYWXIk7fsacp3KMVuL/mWPQFX1MbTYCRSGEr7g=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=ep1KRhQzSK64UdV4gVzamQWnotaGsFvPHyLGNzIcRYAJalnKgYCUSdVyXHFcQFG9ZnpzJerPYZw0SmXaXc2nJtybIPWOAtc2/ipFIWlyo6eAk6XvRRyIMV5368EYiT2XwJaeINBroTwBFAioqAU3M/wIJX6PYKzA1nmGo7PejAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=tBo8WICt; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=jog1i33uHRXEYtwEaKRBf0ivRlCDI/h7IaGamPhR7RI=; b=tBo8WICt9IR9C8q9WTvXB48s87
	sTxPlhAXoYLL6ZkKLFowRd6vuqCLE+Ns4eNlfjYEsNS6u+9Baa6b2NwUbg4kCVhRxsyLPPzRyPYuU
	zx/femYu6Nn62kqsMmKe55Cu1GRYQa36aj6OQrlcSjKXReaFKenBfU3AdE2/kL6PfyBU=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52262 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rY6I2-0001xf-H1; Thu, 08 Feb 2024 10:26:15 -0500
Date: Thu, 8 Feb 2024 10:26:13 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>
Message-Id: <20240208102613.887945859e48f3b2d9519385@hugovil.com>
In-Reply-To: <20240206214208.2141067-4-hugo@hugovil.com>
References: <20240206214208.2141067-1-hugo@hugovil.com>
	<20240206214208.2141067-4-hugo@hugovil.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	* -3.3 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH 3/4] serial: sc16is7xx: split into core and I2C/SPI
 parts (sc16is7xx_lines)
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Tue,  6 Feb 2024 16:42:07 -0500
Hugo Villeneuve <hugo@hugovil.com> wrote:

> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Before, sc16is7xx_lines was checked for a free (zero) bit first, and then
> later it was set only if UART port registration succeeded.
> 
> Now that sc16is7xx_lines is shared for the I2C and SPI drivers, make sure
> it is reserved and modified atomically, and use a new variable to hold the
> status of UART port regisration.
> 
> Remove need to check for previous port registration in sc16is7xx_remove(),
> because if sc16is7xx_probe() succeeded, we are guaranteed to have
> successfully registered both ports.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  drivers/tty/serial/sc16is7xx.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 5b53c88b7133..5073ebfc45bf 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -1468,6 +1468,7 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>  	u32 uartclk = 0;
>  	int i, ret;
>  	struct sc16is7xx_port *s;
> +	bool port_registered[SC16IS7XX_MAX_PORTS];
>  
>  	for (i = 0; i < devtype->nr_uart; i++)
>  		if (IS_ERR(regmaps[i]))
> @@ -1533,8 +1534,10 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>  		     SC16IS7XX_IOCONTROL_SRESET_BIT);
>  
>  	for (i = 0; i < devtype->nr_uart; ++i) {
> -		s->p[i].port.line = find_first_zero_bit(sc16is7xx_lines,
> -							SC16IS7XX_MAX_DEVS);
> +		port_registered[i] = false;

I just realised that this will not work. All port_registered[]
members need to be initialized before entering the loop.

I will add this (for V2) before the loop:

  memset(port_registered, 0, sizeof(port_registered));

Hugo Villeneuve


> +
> +		s->p[i].port.line = find_and_set_bit(sc16is7xx_lines,
> +						     SC16IS7XX_MAX_DEVS);
>  		if (s->p[i].port.line >= SC16IS7XX_MAX_DEVS) {
>  			ret = -ERANGE;
>  			goto out_ports;
> @@ -1584,7 +1587,7 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>  		if (ret)
>  			goto out_ports;
>  
> -		set_bit(s->p[i].port.line, sc16is7xx_lines);
> +		port_registered[i] = true;
>  
>  		/* Enable EFR */
>  		sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_LCR_REG,
> @@ -1642,9 +1645,11 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>  #endif
>  
>  out_ports:
> -	for (i = 0; i < devtype->nr_uart; i++)
> -		if (test_and_clear_bit(s->p[i].port.line, sc16is7xx_lines))
> +	for (i = 0; i < devtype->nr_uart; i++) {
> +		clear_bit(s->p[i].port.line, sc16is7xx_lines);
> +		if (port_registered[i])
>  			uart_remove_one_port(&sc16is7xx_uart, &s->p[i].port);
> +	}
>  
>  	kthread_stop(s->kworker_task);
>  
> @@ -1667,8 +1672,8 @@ void sc16is7xx_remove(struct device *dev)
>  
>  	for (i = 0; i < s->devtype->nr_uart; i++) {
>  		kthread_cancel_delayed_work_sync(&s->p[i].ms_work);
> -		if (test_and_clear_bit(s->p[i].port.line, sc16is7xx_lines))
> -			uart_remove_one_port(&sc16is7xx_uart, &s->p[i].port);
> +		clear_bit(s->p[i].port.line, sc16is7xx_lines);
> +		uart_remove_one_port(&sc16is7xx_uart, &s->p[i].port);
>  		sc16is7xx_power(&s->p[i].port, 0);
>  	}
>  
> -- 
> 2.39.2
> 
> 

