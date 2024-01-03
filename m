Return-Path: <linux-kernel+bounces-15453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EB6822C38
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA6191C22F20
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F5218E35;
	Wed,  3 Jan 2024 11:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TuM7SuXL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFBF18EA0;
	Wed,  3 Jan 2024 11:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704281791; x=1735817791;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=si5XuoGly074gF+mu6B8SR8aurH5zdG6CC2onKMC8og=;
  b=TuM7SuXLj8MYvTThn52S+Y0XOBTWGt9MSeoWr2PWNd2EVuV4W0uyOu1H
   grtHqHK0G1Dtb5T7rhhxyG2A5bjKlToy4FJ03/Hc0X17ljUlIkJhso62Q
   FyRzms9Gk4+SOaXPLGn+oyT3f72lgTeR5MCgXCkFS16wIqJ3i5/dCgG6u
   604REbF4uEodN/SsoWQz0ZQsAUWkLJ/MaHHrVv831SE3VnH91aFM/+cpX
   ki9sSDfaRKyUfMyCttAn0VtzOhntR/2iTUaDInnEY4EjV1kUjBEGXwTzs
   17A079cOCU2X4idbFFJfyEX3U9raghpYNH/U8rouKO3n5CEL7MRXHAWyu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="394149634"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="394149634"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 03:36:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="22071222"
Received: from bergbenj-mobl1.ger.corp.intel.com ([10.251.211.32])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 03:36:26 -0800
Date: Wed, 3 Jan 2024 13:36:23 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Lino Sanfilippo <l.sanfilippo@kunbus.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, u.kleine-koenig@pengutronix.de, 
    shawnguo@kernel.org, s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com, 
    alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com, 
    hugo@hugovil.com, m.brock@vanmierlo.com, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, LinoSanfilippo@gmx.de, 
    Lukas Wunner <lukas@wunner.de>, p.rosenberger@kunbus.com, 
    stable@vger.kernel.org
Subject: Re: [PATCH v7 6/7] serial: omap: do not override settings for RS485
 support
In-Reply-To: <20240103061818.564-7-l.sanfilippo@kunbus.com>
Message-ID: <c88034d4-cb5-b64e-7a76-194ef35f28@linux.intel.com>
References: <20240103061818.564-1-l.sanfilippo@kunbus.com> <20240103061818.564-7-l.sanfilippo@kunbus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-729757387-1704281789=:1706"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-729757387-1704281789=:1706
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 3 Jan 2024, Lino Sanfilippo wrote:

> The drivers RS485 support is deactivated if there is no RTS GPIO available.
> This is done by nullifying the ports rs485_supported struct. After that
> however the settings in serial_omap_rs485_supported are assigned to the
> same structure unconditionally, which results in an unintended reactivation
> of RS485 support.
> 
> Fix this by moving the assignment to the beginning of
> serial_omap_probe_rs485() and thus before uart_get_rs485_mode() gets
> called.

This doesn't seem to accurately reflect what the problem is (which you 
correctly described in the paragraph above this). The problem doesn't seem 
to have anything to do with the placement of uart_get_rs485_mode() call 
but the if (IS_ERR(up->rts_gpiod)) block that clears rs485_supported?

A future work item that came to my mind while reviewing this: I suppose 
uart_disable_rs485_support() could be added into core which memsets  
rs485_supported and rs485 to zero so this driver could just call it.

> Also replace the assignment of rs485_config() to have the complete RS485
> setup in one function.
> 
> Fixes: e2752ae3cfc9 ("serial: omap: Disallow RS-485 if rts-gpio is not specified")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/tty/serial/omap-serial.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index ad4c1c5d0a7f..f4c6ff806465 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -1483,6 +1483,13 @@ static struct omap_uart_port_info *of_get_uart_port_info(struct device *dev)
>  	return omap_up_info;
>  }
>  
> +static const struct serial_rs485 serial_omap_rs485_supported = {
> +	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND |
> +		 SER_RS485_RX_DURING_TX,
> +	.delay_rts_before_send = 1,
> +	.delay_rts_after_send = 1,
> +};
> +
>  static int serial_omap_probe_rs485(struct uart_omap_port *up,
>  				   struct device *dev)
>  {
> @@ -1497,6 +1504,9 @@ static int serial_omap_probe_rs485(struct uart_omap_port *up,
>  	if (!np)
>  		return 0;
>  
> +	up->port.rs485_config = serial_omap_config_rs485;
> +	up->port.rs485_supported = serial_omap_rs485_supported;
> +
>  	ret = uart_get_rs485_mode(&up->port);
>  	if (ret)
>  		return ret;
> @@ -1531,13 +1541,6 @@ static int serial_omap_probe_rs485(struct uart_omap_port *up,
>  	return 0;
>  }
>  
> -static const struct serial_rs485 serial_omap_rs485_supported = {
> -	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND |
> -		 SER_RS485_RX_DURING_TX,
> -	.delay_rts_before_send = 1,
> -	.delay_rts_after_send = 1,
> -};
> -
>  static int serial_omap_probe(struct platform_device *pdev)
>  {
>  	struct omap_uart_port_info *omap_up_info = dev_get_platdata(&pdev->dev);
> @@ -1604,17 +1607,11 @@ static int serial_omap_probe(struct platform_device *pdev)
>  		dev_info(up->port.dev, "no wakeirq for uart%d\n",
>  			 up->port.line);
>  
> -	ret = serial_omap_probe_rs485(up, &pdev->dev);
> -	if (ret < 0)
> -		goto err_rs485;
> -
>  	sprintf(up->name, "OMAP UART%d", up->port.line);
>  	up->port.mapbase = mem->start;
>  	up->port.membase = base;
>  	up->port.flags = omap_up_info->flags;
>  	up->port.uartclk = omap_up_info->uartclk;
> -	up->port.rs485_config = serial_omap_config_rs485;
> -	up->port.rs485_supported = serial_omap_rs485_supported;
>  	if (!up->port.uartclk) {
>  		up->port.uartclk = DEFAULT_CLK_SPEED;
>  		dev_warn(&pdev->dev,
> @@ -1622,6 +1619,10 @@ static int serial_omap_probe(struct platform_device *pdev)
>  			 DEFAULT_CLK_SPEED);
>  	}
>  
> +	ret = serial_omap_probe_rs485(up, &pdev->dev);
> +	if (ret < 0)
> +		goto err_rs485;
> +
>  	up->latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
>  	up->calc_latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
>  	cpu_latency_qos_add_request(&up->pm_qos_request, up->latency);

Moving of serial_omap_probe_rs485() later in serial_omap_probe() doesn't 
seem anymore required but I guess it doesn't hurt either.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-729757387-1704281789=:1706--

