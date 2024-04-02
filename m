Return-Path: <linux-kernel+bounces-128435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6801A895ACC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0739F1F21D9F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F0215A4B7;
	Tue,  2 Apr 2024 17:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="siVaUY0v"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4CC15A48F;
	Tue,  2 Apr 2024 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079405; cv=none; b=h8JEEa5vYBFfFH5ioR1XBsHHVOMgS1t0ldE7z3Lymnzs9LmDIorYRIhns366NhKdu/t3kIF/WNf0dQHdztdARAQwE9y71AcH7/Q5BT5zTA9k9rlB5Bc41kgl9vR05Yc0g7/zLSZCrEh4BqC7wcR0chtwHIVRZXvfGsm4U5xrmBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079405; c=relaxed/simple;
	bh=HYvuqgTovbrmBfAhIVEBa1k32Ke1zvhTT1PBjkR5M+k=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=gJIfKheAyfOUfrf6qnbjSMdHWf5/hrBybL5qi/wASpKHAhqyvwlKIyVKTaEj4v8R+bHoAu+YjPab7iPXJZjjOogR1zMbhajBxUFtLFrDlXwZGJ2zgLpjTaBEcf5JcaeDhpnw/8M1WQ4zESqIad4Vpv50I/eze4AJ1ilZSM3KFlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=siVaUY0v; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=o6apNIGIsVP1Vlbht6EkklAQEKnHCx0bPOXMWn2QzA0=; b=siVaUY0vjW2RjUtmC9LCDwl3uo
	u8jK2cOVhzDKNQV3BZYgGbQyGxHJ4KqOy8JAslC+PS5+npch4v9Cauce0QuDJJ3GPges/DJwxCjy8
	wQRFpFO1iQpJ8CNw3xC3s1NV2QkFcTqJt0zSbVA7jHM8VEOyNSNIU33g8K92dRAuFUOw=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:59304 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rrhbP-0007OL-Lo; Tue, 02 Apr 2024 13:07:18 -0400
Date: Tue, 2 Apr 2024 13:07:15 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby
 <jirislaby@kernel.org>
Message-Id: <20240402130715.7f1292b774ee0b2f056a6e95@hugovil.com>
In-Reply-To: <20240402154219.3583679-2-andriy.shevchenko@linux.intel.com>
References: <20240402154219.3583679-1-andriy.shevchenko@linux.intel.com>
	<20240402154219.3583679-2-andriy.shevchenko@linux.intel.com>
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
	* -0.4 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v1 01/16] serial: max3100: Lock port->lock when calling
 uart_handle_cts_change()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Tue,  2 Apr 2024 18:38:07 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

Hi Andy,

> uart_handle_cts_change() has to be called with port lock taken,
> Since we run it in a separate work, the lcok maybe not taken at

lcok -> lock

and possibly: "may not be taken" ?


> the time of running. Make sure that it's taken by explicitly doing
> that. Without it we got a splat:
> 
>   WARNING: CPU: 0 PID: 10 at drivers/tty/serial/serial_core.c:3491 uart_handle_cts_change+0xa6/0xb0
>   ...
>   Workqueue: max3100-0 max3100_work [max3100]
>   RIP: 0010:uart_handle_cts_change+0xa6/0xb0
>   ...
>    max3100_handlerx+0xc5/0x110 [max3100]
>    max3100_work+0x12a/0x340 [max3100]
> 
> Fixes: 7831d56b0a35 ("tty: MAX3100")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/max3100.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
> index 5efb2b593be3..45022f2909f0 100644
> --- a/drivers/tty/serial/max3100.c
> +++ b/drivers/tty/serial/max3100.c
> @@ -213,7 +213,7 @@ static int max3100_sr(struct max3100_port *s, u16 tx, u16 *rx)
>  	return 0;
>  }
>  
> -static int max3100_handlerx(struct max3100_port *s, u16 rx)
> +static int max3100_handlerx_unlocked(struct max3100_port *s, u16 rx)
>  {
>  	unsigned int status = 0;
>  	int ret = 0, cts;
> @@ -254,6 +254,17 @@ static int max3100_handlerx(struct max3100_port *s, u16 rx)
>  	return ret;
>  }
>  
> +static int max3100_handlerx(struct max3100_port *s, u16 rx)
> +{
> +	unsigned long flags;
> +	int ret;
> +
> +	uart_port_lock_irqsave(&s->port, &flags);
> +	ret = max3100_handlerx_unlocked(s, rx);
> +	uart_port_unlock_irqrestore(&s->port, flags);
> +	return ret;
> +}
> +
>  static void max3100_work(struct work_struct *w)
>  {
>  	struct max3100_port *s = container_of(w, struct max3100_port, work);
> -- 
> 2.43.0.rc1.1.gbec44491f096
> 
> 


-- 
Hugo Villeneuve

