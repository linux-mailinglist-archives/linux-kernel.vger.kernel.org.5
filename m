Return-Path: <linux-kernel+bounces-123245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B476B890513
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06291C2F9EF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF11E1384A6;
	Thu, 28 Mar 2024 16:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m1jexxr8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44922137C2A;
	Thu, 28 Mar 2024 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642933; cv=none; b=jVVIlAuwyQWWEEinjjSusTofrVyvgqwvBuOK9F3gWSOM6beMy1brXQ6XfVPhqhKHYHr1anY/257UwGVpQIAKhdoFVUaS6R47Xzay63q8QzskjMYFLxqcq5+EBJ/ds3aWFpdfYQvKLbRpRo/MZhCo7XKqkz6AzrdGE8BOkSC52hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642933; c=relaxed/simple;
	bh=bSHvmQ+UWzfHYRyiidyuX1GYmVR6GOA1F/3dAa7M2w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUHS513rPp+sUqESfDbF3antICfn1Cn8bM/BuBoB3Jk1iZfZxnq8KbHFedPIlad2FP1Lnoaux4O8QrxjTh62J/jSToZ9NjpemZ4eKo0L/+7a7YoqczfEITNHTL2oVV0hH++2YQ+tyG6bD2k5gD3N82NpNmJAdHwvJDqKwPb88vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m1jexxr8; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711642931; x=1743178931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bSHvmQ+UWzfHYRyiidyuX1GYmVR6GOA1F/3dAa7M2w4=;
  b=m1jexxr8JmG3LN5eJCg5i1ZHqAoKorcJTSiSK3flhydIj9CqmtpTRCH/
   I/fOKuuK4AlQds16nAA6VP9epp02Qsm8Ty0jnWCn4nSWayAWPUBKMhPD2
   D1GHC7KSHd5reUeUb/7GK+k3gT1KXR4gQPujE/aQmtjOhugBKg6xTAPZ7
   8In+RbmSsIxseYJJ9moAdea0PhnDBQ+KT3wPXPSstiKUBPNceGlLI7jl7
   c7Lv1NIsZd2VbYlKNUbfzmNgT3fZ3NrzDHAA590JW9P14I1lYI6l0kH7v
   vwJwGXh5odhE3hQ60jwbV148pwvfdbyXgK1y7+eRxi/hUayeUr6e7yD9G
   g==;
X-CSE-ConnectionGUID: NYS4uucvTyGUw2CjJ1k00Q==
X-CSE-MsgGUID: 4ammN5MjQqCTWorUh6kvUQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6936185"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6936185"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 09:22:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="914954863"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="914954863"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 09:22:08 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rpsVx-0000000H3ug-45Ul;
	Thu, 28 Mar 2024 18:22:05 +0200
Date: Thu, 28 Mar 2024 18:22:05 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guanbing Huang <albanhuang@outlook.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	lvjianmin@loongson.cn, albanhuang@tencent.com,
	tombinfan@tencent.com
Subject: Re: [PATCH v3] serial: 8250_pnp: Support configurable reg shift
 property
Message-ID: <ZgWZLfKp9fqAHjb8@smile.fi.intel.com>
References: <SG2PR06MB4953D0E0A40FDAC34FF130C8C93B2@SG2PR06MB4953.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR06MB4953D0E0A40FDAC34FF130C8C93B2@SG2PR06MB4953.apcprd06.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 28, 2024 at 11:45:29AM +0800, Guanbing Huang wrote:
> From: Guanbing Huang <albanhuang@tencent.com>
> 
> The 16550a serial port based on the ACPI table requires obtaining the
> reg-shift attribute. In the ACPI scenario, If the reg-shift property
> is not configured like in DTS, the 16550a serial driver cannot read or
> write controller registers properly during initialization.

Thank you for the update!
Basically we have now a few issues with this (easy to fix though).

Note, below I described _two_ variants of what needs to be done,
but if you think it's too much for you, let's go in v4 to the code
of v2 (i.o.w. just adding what you need in 8250_pnp).

..

>  	memset(&uart, 0, sizeof(uart));
> -	if (pnp_irq_valid(dev, 0))
> -		uart.port.irq = pnp_irq(dev, 0);

This has checked for IRQ validness and left it 0 if not...

>  	if ((flags & CIR_PORT) && pnp_port_valid(dev, 2)) {
>  		uart.port.iobase = pnp_port_start(dev, 2);
> -		uart.port.iotype = UPIO_PORT;
>  	} else if (pnp_port_valid(dev, 0)) {
>  		uart.port.iobase = pnp_port_start(dev, 0);
> -		uart.port.iotype = UPIO_PORT;
>  	} else if (pnp_mem_valid(dev, 0)) {
>  		uart.port.mapbase = pnp_mem_start(dev, 0);

(The mapsize is also needed now to be initialized correctly)

> -		uart.port.iotype = UPIO_MEM;
>  		uart.port.flags = UPF_IOREMAP;
>  	} else
>  		return -ENODEV;
>  
> -	dev_dbg(&dev->dev,
> -		 "Setup PNP port: port %#lx, mem %#llx, irq %u, type %u\n",
> -		 uart.port.iobase, (unsigned long long)uart.port.mapbase,
> -		 uart.port.irq, uart.port.iotype);
> +	uart.port.uartclk = 1843200;
> +	uart.port.dev = &dev->dev;
> +
> +	ret = uart_read_port_properties(&uart.port);

..which means here you need to check for IRQ being absent. The example
is 8250_dw.c, where similar check is done.

> +	if (ret < 0)
> +		return ret;

Then the iotype should be preserved, most likely it will become UPIO_UNKNOWN
for those who do not provide reg-io-width property. That means you need an
additional local variable that you assign instead of port->iotype in the above
if-else-if chain and (re)assign port->iotype with it here.

..

Next point is that above API doesn't cover PNP devices, what you need is
to add a patch to that API in drivers/tty/serial/serial_port.c

        else if (dev_is_pnp(dev))
		ret = pnp_irq(to_pnp_dev(dev), 0);
		if (ret < 0)
			ret = -ENXIO;
	} else

You may try to fix pnp to return -ENXIO from pnp_irq(), but this might need
more careful check of users that none of them relies on the exact returned
value. (If you choose this direction, the mentioned change has to be done
separately.)

And also update include/linux/pnp.h to provide dev_is_pnp() macro
(somewhere before module_pnp_driver() I think)

#define dev_is_pnp(d)	((d)->bus == &pnp_bus_type)

(This should be done in a separate patch)

That said you should have the series out of 3+ patches:
1) (optional) Fix pnp_irq() to return -ENXIO.
2) Add dev_is_pnp() macro to include/linux/pnp.h.
3) Add support of PNP IRQ to __uart_read_properties().
4) Update 8250_pnp to support the additional properties.


Alternatively to the above you may simply try pnp_irq() after the call

	ret = uart_read_port_properties(&uart.port);
	if (ret == -ENXIO) {
		if (pnp_irq_valid(dev, 0))
			uart.port.irq = pnp_irq(dev, 0);
		if (pnp_irq_flags(dev, 0) & IORESOURCE_IRQ_SHAREABLE)
			uart.port.flags |= UPF_SHARE_IRQ;
	} else if (ret) {
		return ret;
	}

-- 
With Best Regards,
Andy Shevchenko



