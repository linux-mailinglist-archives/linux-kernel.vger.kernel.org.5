Return-Path: <linux-kernel+bounces-101628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5C487A9A0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C6A91C21909
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A85B446D1;
	Wed, 13 Mar 2024 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="v6oioyru"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1230446AC;
	Wed, 13 Mar 2024 14:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710340686; cv=none; b=EmQu0Mmhcw0XOm712B+kvwIue8S3JiGiHvVjrrursyRqD/nSi2Wz+D/wM7/GD0p65JJUeqY9tkZnTbh3jMwLquad9+jWFCVu9cUeQ/xW/4cGv9yTIq/9TElEynD0uw5rdgwu/9QGowmE0bpqjrHlj5gbN/Ob6APmh2qxGmYS750=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710340686; c=relaxed/simple;
	bh=hDA7tqOmA8wnGfEta/8cJQeKmR/C5NjwCnDdHSybjqM=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=lJn65KbiGogd8iMDlZCMGW0DzJFmw/CsIo2CqY0UNk/n3bvo35jvO/kdcNIj/ndpBcE1NZASXzV6aL4BAX5rCKNjorRshkgmwnjblNQU/+TGoHtAGkAzZB9EE6hq99qRBU1eI/K8YiqwgZvqZziqUWBCmDSls/JbCiBURiZbsy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=v6oioyru; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=wd9jIWlbL+VuMUA20BcRV4ZrSSX3yz6PI7b617YPVYg=; b=v6oioyruOR/Pu9TsNjWNIth39V
	CkvQrCA2em2BEA6giEmspJ5W/G0Zus38b6PCQSy/IIZenuFF8WeONzOgrrOQWiYG7bEA7TW9zAIo6
	1LEbjne0s+R0vdLybqgH+onPBeI2bFPgRIVFS0sljxLl1ZlVms7KarwF0+qRiaHcWtDo=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52044 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rkPju-0005c0-L2; Wed, 13 Mar 2024 10:37:55 -0400
Date: Wed, 13 Mar 2024 10:37:54 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>
Message-Id: <20240313103754.6c33d160f5d69427a29a3e2b@hugovil.com>
In-Reply-To: <20240307161828.118495-4-hugo@hugovil.com>
References: <20240307161828.118495-1-hugo@hugovil.com>
	<20240307161828.118495-4-hugo@hugovil.com>
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
	* -1.8 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v2 3/4] serial: sc16is7xx: split into core and I2C/SPI
 parts (sc16is7xx_lines)
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Thu,  7 Mar 2024 11:18:27 -0500
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
>  drivers/tty/serial/sc16is7xx.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 5b53c88b7133..d81aad1b201d 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -343,6 +343,8 @@ struct sc16is7xx_port {
>  
>  static DECLARE_BITMAP(sc16is7xx_lines, SC16IS7XX_MAX_DEVS);
>  
> +static DEFINE_MUTEX(sc16is7xx_lines_lock); /* For probe atomic line reservation. */
> +
>  static struct uart_driver sc16is7xx_uart = {
>  	.owner		= THIS_MODULE,
>  	.driver_name    = SC16IS7XX_NAME,
> @@ -1468,6 +1470,7 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>  	u32 uartclk = 0;
>  	int i, ret;
>  	struct sc16is7xx_port *s;
> +	bool port_registered[SC16IS7XX_MAX_PORTS];
>  
>  	for (i = 0; i < devtype->nr_uart; i++)
>  		if (IS_ERR(regmaps[i]))
> @@ -1532,14 +1535,21 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>  	regmap_write(regmaps[0], SC16IS7XX_IOCONTROL_REG,
>  		     SC16IS7XX_IOCONTROL_SRESET_BIT);
>  
> +	memset(port_registered, 0, sizeof(port_registered));
> +
>  	for (i = 0; i < devtype->nr_uart; ++i) {
> +		mutex_lock(&sc16is7xx_lines_lock);
>  		s->p[i].port.line = find_first_zero_bit(sc16is7xx_lines,
>  							SC16IS7XX_MAX_DEVS);
>  		if (s->p[i].port.line >= SC16IS7XX_MAX_DEVS) {
>  			ret = -ERANGE;
> +			mutex_unlock(&sc16is7xx_lines_lock);
>  			goto out_ports;
>  		}
>  
> +		set_bit(s->p[i].port.line, sc16is7xx_lines);
> +		mutex_unlock(&sc16is7xx_lines_lock);
> +
>  		/* Initialize port data */
>  		s->p[i].port.dev	= dev;
>  		s->p[i].port.irq	= irq;
> @@ -1584,7 +1594,7 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>  		if (ret)
>  			goto out_ports;
>  
> -		set_bit(s->p[i].port.line, sc16is7xx_lines);
> +		port_registered[i] = true;
>  
>  		/* Enable EFR */
>  		sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_LCR_REG,
> @@ -1642,9 +1652,11 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
>  #endif
>  
>  out_ports:
> -	for (i = 0; i < devtype->nr_uart; i++)
> -		if (test_and_clear_bit(s->p[i].port.line, sc16is7xx_lines))
> +	for (i = 0; i < devtype->nr_uart; i++) {
> +		clear_bit(s->p[i].port.line, sc16is7xx_lines);
> +		if (port_registered[i])

Hi Andy,
I just realised that since we no longer need to search if a
bit is set, it is possible to simplify sc16is7xx_lines allocation
by using the IDA framework, as you suggested a few months ago.

I will send a V3 with this change.

Hugo Villeneuve


>  			uart_remove_one_port(&sc16is7xx_uart, &s->p[i].port);
> +	}
>  
>  	kthread_stop(s->kworker_task);
>  
> @@ -1667,8 +1679,8 @@ void sc16is7xx_remove(struct device *dev)
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

