Return-Path: <linux-kernel+bounces-128416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99973895A87
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1B71F2291C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD4215A490;
	Tue,  2 Apr 2024 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="tyoLoxlb"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9AA15990F;
	Tue,  2 Apr 2024 17:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712078312; cv=none; b=CQbo5f0Nx61YOIXJbWp3EaTO1aQxWnQNd88ahhHeLmC9qJSFgi9gAxO5yg9V7eFeUE6lA1BzfRe4DuOK7stVjDTAt7KxnBcX6BCvb/EDhfPJBON7owD+VAIGv72CL03DUI6BOte0q0EHd7fZYSuZgpKBvvcwR/0U7UM2ymgCbdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712078312; c=relaxed/simple;
	bh=gnyauasBEVKJlgRTyusXcYoUHHL80G7u43VYIjNqww0=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=XF4k5H2qMm+koF9eqRjEtdzSWfeUBu6qZPWj3vs4lawWij0hh3LC40LihdMXOzqrHG3K4DiukiEqlEMZ/vEE9pzV+Dm6sSiHcXCe91pN/mww/RJ95YQ8WpEyJ46PKBwVByRLDCemiQsUoTBjdx9nZ4whH+yPnx0YsHLLWDwNWAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=tyoLoxlb; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=yoiHiwETSu1iBvC11FxmDWnqf+yKtnHBsQkfmlSTe60=; b=tyoLoxlb0t/sgZZtHdClz6E2YM
	FSy85kwC28U/ZhFvr/e+rhjRiTqEpR/wIk7XpfEJFZfwUmhcxOdgd0yoMHeSi5pcv3MSaz8edrF/g
	85DjJZP6mRYNl6bnTVve4q2hm3h8GfUZTMbQs1IQYFqJWZn4it3DazmVc/zNsXTQyeRs=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:44634 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rrhmF-0007UU-Ov; Tue, 02 Apr 2024 13:18:28 -0400
Date: Tue, 2 Apr 2024 13:18:27 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby
 <jirislaby@kernel.org>
Message-Id: <20240402131827.fdc429dfb6f62db4d291688f@hugovil.com>
In-Reply-To: <20240402154219.3583679-3-andriy.shevchenko@linux.intel.com>
References: <20240402154219.3583679-1-andriy.shevchenko@linux.intel.com>
	<20240402154219.3583679-3-andriy.shevchenko@linux.intel.com>
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
Subject: Re: [PATCH v1 02/16] serial: max3100: Update uart_driver_registered
 on driver removal
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Tue,  2 Apr 2024 18:38:08 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

Hi Andy,

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
> Fixes: 7831d56b0a35 ("tty: MAX3100")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/max3100.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
> index 45022f2909f0..efe26f6d5ebf 100644
> --- a/drivers/tty/serial/max3100.c
> +++ b/drivers/tty/serial/max3100.c
> @@ -841,6 +841,7 @@ static void max3100_remove(struct spi_device *spi)
>  		}
>  	pr_debug("removing max3100 driver\n");
>  	uart_unregister_driver(&max3100_uart_driver);
> +	uart_driver_registered = 0;

At the beginning of the probe function, we have:

-----------------------
if (!uart_driver_registered) {
		uart_driver_registered = 1;
		retval = uart_register_driver(&max3100_uart_driver);
		if (retval) {
			printk(KERN_ERR "Couldn't register max3100 uart
driver\n"); mutex_unlock(&max3100s_lock);
			return retval;
..
-----------------------

If uart_register_driver() fails, uart_driver_registered would still be
true and would it prevent any other subsequent devices from being
properly registered? If yes, then maybe "uart_driver_registered = 1"
should be set only after a sucessfull call to uart_register_driver()?

Hugo.


>  
>  	mutex_unlock(&max3100s_lock);
>  }
> -- 
> 2.43.0.rc1.1.gbec44491f096
> 
> 

