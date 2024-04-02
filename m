Return-Path: <linux-kernel+bounces-128429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C784895AB8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA160B25C34
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CC115A49D;
	Tue,  2 Apr 2024 17:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="GFtHOR8O"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA505159912;
	Tue,  2 Apr 2024 17:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079135; cv=none; b=ilrLw8/ULZ4k9uv03dCUpNGFSw0EVOAP8+dKQD92wQ7NA/1ELeA3eZgbNlprJdx76oEMzQdLNvG1L2CxrAK/kFVlK86cuarvyTL24cbA82WBc4WaQ811pe8NWojw1KTRcZXV5a2PI4zDyDGo7rd9PzmdgiONAa+GCeaU5Fq4/Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079135; c=relaxed/simple;
	bh=mV53t1podiDxtR/XNgQXyFOr0aY8dlvQ8zbvCHm7YHg=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=VBU/VjIPeYE9yeU2ICvJ0y2xv3TtIqcZm0UWDIEeeg3mamREY/SFLb22ush596ngY2r1hY2XM11t8DrYb9pR7mU7rAK0mk98rjc/v3zIZKIzZlT9PBrSgquPrh2snZ9DLUkjmtmydyILQHq8V8ymm9Pa6W9ZnHIDCFGAyWK8l6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=GFtHOR8O; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=tlmcDV4tJG/vmyJxl8o94HzuPvhHeWXr40QJIGScueA=; b=GFtHOR8O1pJ0LYmvPijVG1uhh1
	xgSBiJpYlrTQLZesk0EmnnStmucyt1up9p5krXbQN+Qhnxf7FNiBBq1OsuLQE07cA466hLn1DwVEK
	YqmAqAePLxLtfrrXf+BizPJNVfozPSvY6dMCCx3ayEV3KIT+wv8LNlUarWQ1/S8vLJSw=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:41686 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rrhzW-00082d-BF; Tue, 02 Apr 2024 13:32:11 -0400
Date: Tue, 2 Apr 2024 13:32:09 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby
 <jirislaby@kernel.org>
Message-Id: <20240402133209.910f63378eb40fa27363f3ed@hugovil.com>
In-Reply-To: <20240402154219.3583679-14-andriy.shevchenko@linux.intel.com>
References: <20240402154219.3583679-1-andriy.shevchenko@linux.intel.com>
	<20240402154219.3583679-14-andriy.shevchenko@linux.intel.com>
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
Subject: Re: [PATCH v1 13/16] serial: max3100: Extract to_max3100_port()
 helper macro
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Tue,  2 Apr 2024 18:38:19 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Instead of using container_of() explicitly, introduce a heler macro.

heler -> helper

Reviewed-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>


> This saves a lot of lines of code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/max3100.c | 67 ++++++++++--------------------------
>  1 file changed, 19 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
> index 585bf6c898b2..19b05992a9ac 100644
> --- a/drivers/tty/serial/max3100.c
> +++ b/drivers/tty/serial/max3100.c
> @@ -16,6 +16,7 @@
>  /* 4 MAX3100s should be enough for everyone */
>  #define MAX_MAX3100 4
>  
> +#include <linux/container_of.h>
>  #include <linux/delay.h>
>  #include <linux/slab.h>
>  #include <linux/device.h>
> @@ -110,6 +111,8 @@ struct max3100_port {
>  	struct timer_list	timer;
>  };
>  
> +#define to_max3100_port(port)	container_of(port, struct max3100_port, port)
> +
>  static struct max3100_port *max3100s[MAX_MAX3100]; /* the chips */
>  static DEFINE_MUTEX(max3100s_lock);		   /* race on probe */
>  
> @@ -322,9 +325,7 @@ static irqreturn_t max3100_irq(int irqno, void *dev_id)
>  
>  static void max3100_enable_ms(struct uart_port *port)
>  {
> -	struct max3100_port *s = container_of(port,
> -					      struct max3100_port,
> -					      port);
> +	struct max3100_port *s = to_max3100_port(port);
>  
>  	mod_timer(&s->timer, jiffies);
>  	dev_dbg(&s->spi->dev, "%s\n", __func__);
> @@ -332,9 +333,7 @@ static void max3100_enable_ms(struct uart_port *port)
>  
>  static void max3100_start_tx(struct uart_port *port)
>  {
> -	struct max3100_port *s = container_of(port,
> -					      struct max3100_port,
> -					      port);
> +	struct max3100_port *s = to_max3100_port(port);
>  
>  	dev_dbg(&s->spi->dev, "%s\n", __func__);
>  
> @@ -343,9 +342,7 @@ static void max3100_start_tx(struct uart_port *port)
>  
>  static void max3100_stop_rx(struct uart_port *port)
>  {
> -	struct max3100_port *s = container_of(port,
> -					      struct max3100_port,
> -					      port);
> +	struct max3100_port *s = to_max3100_port(port);
>  
>  	dev_dbg(&s->spi->dev, "%s\n", __func__);
>  
> @@ -359,9 +356,7 @@ static void max3100_stop_rx(struct uart_port *port)
>  
>  static unsigned int max3100_tx_empty(struct uart_port *port)
>  {
> -	struct max3100_port *s = container_of(port,
> -					      struct max3100_port,
> -					      port);
> +	struct max3100_port *s = to_max3100_port(port);
>  
>  	dev_dbg(&s->spi->dev, "%s\n", __func__);
>  
> @@ -372,9 +367,7 @@ static unsigned int max3100_tx_empty(struct uart_port *port)
>  
>  static unsigned int max3100_get_mctrl(struct uart_port *port)
>  {
> -	struct max3100_port *s = container_of(port,
> -					      struct max3100_port,
> -					      port);
> +	struct max3100_port *s = to_max3100_port(port);
>  
>  	dev_dbg(&s->spi->dev, "%s\n", __func__);
>  
> @@ -386,9 +379,7 @@ static unsigned int max3100_get_mctrl(struct uart_port *port)
>  
>  static void max3100_set_mctrl(struct uart_port *port, unsigned int mctrl)
>  {
> -	struct max3100_port *s = container_of(port,
> -					      struct max3100_port,
> -					      port);
> +	struct max3100_port *s = to_max3100_port(port);
>  	int loopback, rts;
>  
>  	dev_dbg(&s->spi->dev, "%s\n", __func__);
> @@ -414,9 +405,7 @@ static void
>  max3100_set_termios(struct uart_port *port, struct ktermios *termios,
>  		    const struct ktermios *old)
>  {
> -	struct max3100_port *s = container_of(port,
> -					      struct max3100_port,
> -					      port);
> +	struct max3100_port *s = to_max3100_port(port);
>  	unsigned int baud = port->uartclk / 16;
>  	unsigned int baud230400 = (baud == 230400) ? 1 : 0;
>  	unsigned cflag;
> @@ -532,9 +521,7 @@ max3100_set_termios(struct uart_port *port, struct ktermios *termios,
>  
>  static void max3100_shutdown(struct uart_port *port)
>  {
> -	struct max3100_port *s = container_of(port,
> -					      struct max3100_port,
> -					      port);
> +	struct max3100_port *s = to_max3100_port(port);
>  	u16 rx;
>  
>  	dev_dbg(&s->spi->dev, "%s\n", __func__);
> @@ -559,9 +546,7 @@ static void max3100_shutdown(struct uart_port *port)
>  
>  static int max3100_startup(struct uart_port *port)
>  {
> -	struct max3100_port *s = container_of(port,
> -					      struct max3100_port,
> -					      port);
> +	struct max3100_port *s = to_max3100_port(port);
>  	char b[12];
>  	int ret;
>  
> @@ -607,9 +592,7 @@ static int max3100_startup(struct uart_port *port)
>  
>  static const char *max3100_type(struct uart_port *port)
>  {
> -	struct max3100_port *s = container_of(port,
> -					      struct max3100_port,
> -					      port);
> +	struct max3100_port *s = to_max3100_port(port);
>  
>  	dev_dbg(&s->spi->dev, "%s\n", __func__);
>  
> @@ -618,18 +601,14 @@ static const char *max3100_type(struct uart_port *port)
>  
>  static void max3100_release_port(struct uart_port *port)
>  {
> -	struct max3100_port *s = container_of(port,
> -					      struct max3100_port,
> -					      port);
> +	struct max3100_port *s = to_max3100_port(port);
>  
>  	dev_dbg(&s->spi->dev, "%s\n", __func__);
>  }
>  
>  static void max3100_config_port(struct uart_port *port, int flags)
>  {
> -	struct max3100_port *s = container_of(port,
> -					      struct max3100_port,
> -					      port);
> +	struct max3100_port *s = to_max3100_port(port);
>  
>  	dev_dbg(&s->spi->dev, "%s\n", __func__);
>  
> @@ -640,9 +619,7 @@ static void max3100_config_port(struct uart_port *port, int flags)
>  static int max3100_verify_port(struct uart_port *port,
>  			       struct serial_struct *ser)
>  {
> -	struct max3100_port *s = container_of(port,
> -					      struct max3100_port,
> -					      port);
> +	struct max3100_port *s = to_max3100_port(port);
>  	int ret = -EINVAL;
>  
>  	dev_dbg(&s->spi->dev, "%s\n", __func__);
> @@ -654,18 +631,14 @@ static int max3100_verify_port(struct uart_port *port,
>  
>  static void max3100_stop_tx(struct uart_port *port)
>  {
> -	struct max3100_port *s = container_of(port,
> -					      struct max3100_port,
> -					      port);
> +	struct max3100_port *s = to_max3100_port(port);
>  
>  	dev_dbg(&s->spi->dev, "%s\n", __func__);
>  }
>  
>  static int max3100_request_port(struct uart_port *port)
>  {
> -	struct max3100_port *s = container_of(port,
> -					      struct max3100_port,
> -					      port);
> +	struct max3100_port *s = to_max3100_port(port);
>  
>  	dev_dbg(&s->spi->dev, "%s\n", __func__);
>  	return 0;
> @@ -673,9 +646,7 @@ static int max3100_request_port(struct uart_port *port)
>  
>  static void max3100_break_ctl(struct uart_port *port, int break_state)
>  {
> -	struct max3100_port *s = container_of(port,
> -					      struct max3100_port,
> -					      port);
> +	struct max3100_port *s = to_max3100_port(port);
>  
>  	dev_dbg(&s->spi->dev, "%s\n", __func__);
>  }
> -- 
> 2.43.0.rc1.1.gbec44491f096
> 
> 


-- 
Hugo Villeneuve

