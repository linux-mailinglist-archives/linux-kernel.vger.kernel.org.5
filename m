Return-Path: <linux-kernel+bounces-128644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 545AD895D5B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F16B2834A1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965D015DBB3;
	Tue,  2 Apr 2024 20:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="Gv7SUA0K"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C24415D5A5;
	Tue,  2 Apr 2024 20:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712088700; cv=none; b=ZhZBG7NvnYDu4liLsT0/C9o6mBHZVDFBqeXFArF7wrcYV7P6px3s2TKCB18sV3EUE98S1y/o2wybNfXe0OYdYDOj4CLVCpGo+phPkbd1Am7EDWecheIAi++zLbsLxyEEBixhZ2FTXb9YgrG8IwspwUDOQkpystn8zNkPO33ZAmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712088700; c=relaxed/simple;
	bh=6tCecI1p2GrcZi1CLphqXwbNFQmt5NRfntEinQ8+YVg=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=Hrg35mMaaDFD0yTgobPXxjECzu9RN/gJwCGD7/QQScZKBV8uXXieAvlnqMrUl0iq63qQ8ZQZVwvWi+RC4wq9igW+bwQVJPBuwsCoaQbXQPYEhf8nf4JIOqhpWIWP/3o1SAJHK8eqOZXuqEXxjxUzKkhVRTOHguiqAFW3uBH9mII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=Gv7SUA0K; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=08CXtM/NDOOxIO3agmGKtcyyUeWlNcqoFgseuwA/avs=; b=Gv7SUA0K4DYpVFwvVOmuUW60/u
	ipN7z79ASHrM0rUTi8+aC7873DBZ7plYVf7gmMKPkppMwicc7/nj9QKLNJdykgJs9OSUOwuofMLc4
	Quev20h8bMHZPaWeEHBCmvx79t9TtOZKhdDEk6y7MK0q16/0ybZKkFmFB1Wa/e8X4HEA=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:51160 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rrkTn-0001cN-Ca; Tue, 02 Apr 2024 16:11:36 -0400
Date: Tue, 2 Apr 2024 16:11:34 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby
 <jirislaby@kernel.org>
Message-Id: <20240402161134.387b57e9723b6c7e11567722@hugovil.com>
In-Reply-To: <20240402195306.269276-3-andriy.shevchenko@linux.intel.com>
References: <20240402195306.269276-1-andriy.shevchenko@linux.intel.com>
	<20240402195306.269276-3-andriy.shevchenko@linux.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.4 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v2 02/16] serial: max3100: Update uart_driver_registered
 on driver removal
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Tue,  2 Apr 2024 22:50:29 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> The removal of the last MAX3100 device triggers the removal of
> the driver. However, code doesn't update the respective global
> variable and after insmod — rmmod — insmod cycle the kernel
> oopses:
> 
>   max3100 spi-PRP0001:01: max3100_probe: adding port 0
>   BUG: kernel NULL pointer dereference, address: 0000000000000408
>   ...
>   RIP: 0010:serial_core_register_port+0xa0/0x840
>   ...
>    max3100_probe+0x1b6/0x280 [max3100]
>    spi_probe+0x8d/0xb0
> 
> Update the actual state so next time UART driver will be registered
> again.
> 
> Hugo also noticed, that the error path in the probe also affected
> by having the variable set, and not cleared. Instead of clearing it
> move the assignment after the successfull uart_register_driver() call.
> 
> Fixes: 7831d56b0a35 ("tty: MAX3100")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>


> ---
>  drivers/tty/serial/max3100.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
> index 45022f2909f0..b3e63b6a402e 100644
> --- a/drivers/tty/serial/max3100.c
> +++ b/drivers/tty/serial/max3100.c
> @@ -749,13 +749,14 @@ static int max3100_probe(struct spi_device *spi)
>  	mutex_lock(&max3100s_lock);
>  
>  	if (!uart_driver_registered) {
> -		uart_driver_registered = 1;
>  		retval = uart_register_driver(&max3100_uart_driver);
>  		if (retval) {
>  			printk(KERN_ERR "Couldn't register max3100 uart driver\n");
>  			mutex_unlock(&max3100s_lock);
>  			return retval;
>  		}
> +
> +		uart_driver_registered = 1;
>  	}
>  
>  	for (i = 0; i < MAX_MAX3100; i++)
> @@ -841,6 +842,7 @@ static void max3100_remove(struct spi_device *spi)
>  		}
>  	pr_debug("removing max3100 driver\n");
>  	uart_unregister_driver(&max3100_uart_driver);
> +	uart_driver_registered = 0;
>  
>  	mutex_unlock(&max3100s_lock);
>  }
> -- 
> 2.43.0.rc1.1.gbec44491f096
> 


