Return-Path: <linux-kernel+bounces-129469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B8F896B3F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 316F81F2956A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2345135A40;
	Wed,  3 Apr 2024 10:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qfl3/8Iw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985D1134CD4;
	Wed,  3 Apr 2024 10:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138463; cv=none; b=dXXiGJ7CT0oSUDHgj3mQFk9CImzb1qasNiS8oM++JVpI/Lcp1RHIyBQZN7xVKC4gUr1v+Rayfn5SE9PsFDzYrJTGm+WrKvqul0ygL6JBsbABInfn1V1rOtBzIhZUcZrFZkqDWMmzbeRecqV2t0hY/iP7L2uQaQuNtmoaW+meVAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138463; c=relaxed/simple;
	bh=v2WLwND+C3+F4xObkTQOEyrUO8eg3Ifk/UecczhzRQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F84f42tSwFu3uk4BUoq7jr6b2/16C+9a0+/+SPu3PLj51YrpUkiD/i0cIHAuJy8N/+9ULKPKh5hs+n4dWGGH0Uhk8uzjn8tFtHRUz/jAVYh886fDlBadyt7lZMtrsmVokkLSO2ixFY+J92QuciENel+EzcBaOzm5YdfgbkTIMKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qfl3/8Iw; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712138461; x=1743674461;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v2WLwND+C3+F4xObkTQOEyrUO8eg3Ifk/UecczhzRQE=;
  b=Qfl3/8IwqDiTabaECD6XRqlHSxxdyTa9HDorZi7w1sLpisYAp7DJoidi
   rH1gvDZ5BDe3PonOA6Or1Tb3RIuQs2Yp3hDrNlIPOaKs7zxzxAB8iyJ+x
   USrcZ0ii7EM+ICampd+7P3uM9uE8QykMIuyV8KrB+uK+k5ulqBZEYDIPF
   kJMGLDWxCjrlnMjA2hHB0wZzpnBpIgVvX3bYf3R/uUWOWUUFkzOYYgqHB
   /joq9V/qSkenLzYO0RAneSNccBH7PgOb5GhJ8drZt9dqqDIVAok189pCk
   CvEINzJIbzaGn8ZEW9+uJgDC7mX1jft09mgvUKJeWAMl5hJCLdrmm1QDj
   g==;
X-CSE-ConnectionGUID: bqoUeFrdS7W9qLp+DcDVgA==
X-CSE-MsgGUID: DEFo5Q62QumpDhM6n6341w==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7485036"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7485036"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:00:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="915177057"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="915177057"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:00:44 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rrxQA-000000015CA-1Iup;
	Wed, 03 Apr 2024 13:00:42 +0300
Date: Wed, 3 Apr 2024 13:00:42 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guanbing Huang <albanhuang@outlook.com>
Cc: gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
	linux-acpi@vger.kernel.org, tony@atomide.com,
	john.ogness@linutronix.de, yangyicong@hisilicon.com,
	jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, lvjianmin@loongson.cn,
	albanhuang@tencent.com, tombinfan@tencent.com
Subject: Re: [PATCH v4 3/3] serial: 8250_pnp: Support configurable reg shift
 property
Message-ID: <Zg0oyldGmxbNnSLI@smile.fi.intel.com>
References: <20240403074130.93811-1-albanhuang@outlook.com>
 <PSAPR06MB495296BC1D96B42A60F7C230C93D2@PSAPR06MB4952.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSAPR06MB495296BC1D96B42A60F7C230C93D2@PSAPR06MB4952.apcprd06.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 03, 2024 at 03:41:30PM +0800, Guanbing Huang wrote:
> From: Guanbing Huang <albanhuang@tencent.com>
> 
> The 16550a serial port based on the ACPI table requires obtaining the
> reg-shift attribute. In the ACPI scenario, If the reg-shift property
> is not configured like in DTS, the 16550a serial driver cannot read or
> write controller registers properly during initialization.

..

>  		uart.port.mapbase = pnp_mem_start(dev, 0);
> +		uart.port.mapsize = pnp_mem_end(dev, 0) - pnp_mem_start(dev, 0);

pnp_mem_len()

..

Add a comment here to explain that

	/*
	 * The previous call may not set iotype correctly when reg-io-width
	 * property is absent and it doesn't support IO port resource.
	 */

> +	uart.port.iotype = iotype;


>  	uart.port.flags |= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
>  	if (pnp_irq_flags(dev, 0) & IORESOURCE_IRQ_SHAREABLE)
>  		uart.port.flags |= UPF_SHARE_IRQ;
> -	uart.port.uartclk = 1843200;
> -	device_property_read_u32(&dev->dev, "clock-frequency", &uart.port.uartclk);
> -	uart.port.dev = &dev->dev;
> +	else
> +		uart.port.flags &= ~UPF_SHARE_IRQ;

This is not needed, just move

	uart.port.flags |= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;

to be before uart_read_properties().

-- 
With Best Regards,
Andy Shevchenko



