Return-Path: <linux-kernel+bounces-150309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE16A8A9D36
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8390B295FC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FE9168AF7;
	Thu, 18 Apr 2024 14:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fQ683lHe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685B86A8CA;
	Thu, 18 Apr 2024 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713450534; cv=none; b=RYPdA/a7gJ0LzsX9e+Vod16TPNOPWHzvwDECInG0UpUucJO4llJgELWwgYKYlXWvVNwmCvw5ZJwyM7rt/iIIRp1mSor2fqh98LDqCyQRsCmFf3ySUJjQcB3bv5QCdThk9wjxkUuvCscEZtYVWeZmPsYZPzIXgnKS0BnZJ9rDZ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713450534; c=relaxed/simple;
	bh=rKFeQFsgx0NqL1L7btW70VT8wS22OsLuq/GSEvwpFt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrR+Xw/UQuCFW5nC66y3TuWMTAlDp/57p/xstpnxpo2rtFOom88h9/kWJthRu6A7/55MjFvZ07HJQJnmYwKxsY55Zuts6u5S0tzBKfsUo4VVlBSfeGYhuKZL7HDaXQHYf1wVMRGxRM/eChweIlWnwuYpGP0ENYAW8fZLcirMtQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fQ683lHe; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713450532; x=1744986532;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rKFeQFsgx0NqL1L7btW70VT8wS22OsLuq/GSEvwpFt0=;
  b=fQ683lHethrB8RKn5jW+sGnWSdZdKoWPPxVW1Oym/zyWJKkNyLs4dVg3
   fHW4Gtd9fcRPVH51NXherRy7IjpYfZ6Je7oWYt/iqTDV6Gz5m+Zna8m0Z
   jOsuPsq9cgG6BSEzkqT15OmQ87qOkxT3MHBOQVNpnSNFq74J2PXgpXJVt
   yhr/ouKw9DRv8qqZHAtTDqEKHHRyjOUcZdUj1WmFIIqYCpzsehiPG7k6T
   sSe5QWzX/yJsJ7L3WrxIipa64Yalzwx4M3XmyTfTlEZY5ZUTTFoFRJ23m
   QFD49UI2wKWpgmik9vT8WnQmESbzvvDpnohUao1B2WG/1hZ+sWv7DOZdF
   w==;
X-CSE-ConnectionGUID: UvF5rfpWTBm9ig5Z+tyMEw==
X-CSE-MsgGUID: ELqP8EjNRvWFdIDrRV8GvA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8868112"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="8868112"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 07:28:51 -0700
X-CSE-ConnectionGUID: KidSamR1Qm6psbtD6HeHgg==
X-CSE-MsgGUID: xs87afnGTQ2l5n7VDNmpng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="27628124"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 07:28:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rxSkn-00000000Lon-01XX;
	Thu, 18 Apr 2024 17:28:45 +0300
Date: Thu, 18 Apr 2024 17:28:44 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Konstantin Pugin <rilian.la.te@ya.ru>
Cc: Konstantin Pugin <ria.freelander@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 3/3] serial: sc16is7xx: add support for EXAR XR20M1172
 UART
Message-ID: <ZiEuHE7aGnrPk5RK@smile.fi.intel.com>
References: <20240418135737.3659498-1-rilian.la.te@ya.ru>
 <20240418135737.3659498-4-rilian.la.te@ya.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418135737.3659498-4-rilian.la.te@ya.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 18, 2024 at 04:57:34PM +0300, Konstantin Pugin wrote:
> From: Konstantin Pugin <ria.freelander@gmail.com>
> 
> Its register set is mostly compatible with SC16IS762, but

"Its"? Whose? Elaborate, please.

> it has a support for additional division rates of UART
> with special DLD register. So, add handling this register
> via UPF_MAGIC_MULTIPLIER port flag.

Oh, can we avoid using this? You can redefine ->set_termios() if required and
before factor out the common pieces to the helper functions.

..

All three commit messages seems follow different text width, please keep it around

~60 for Subject and ~72 for the commit message.

..

>  /* Special Register set: Only if ((LCR[7] == 1) && (LCR != 0xBF)) */
>  #define SC16IS7XX_DLL_REG		(0x00) /* Divisor Latch Low */
>  #define SC16IS7XX_DLH_REG		(0x01) /* Divisor Latch High */
> +#define SC16IS7XX_DLD_REG		(0x02) /* Divisor Latch Mode (only on EXAR chips) */

Is it called DLD in the datasheet? If so, can you match the comment to
the datasheet, otherwise make it DLM and I would even go for the EXAR
namespace.

..

> +/* Divisor Latch Mode bits (EXAR extension)
> + *
> + * EXAR hardware is mostly compatible with SC16IS7XX, but supports additional feature:
> + * 4x and 8x divisor, instead of default 16x. It has a special register to program it.
> + * Bits 0 to 3 is fractional divisor, it used to set value of last 16 bits of
> + * uartclk * (16 / divisor) / baud, in case of default it will be uartclk / baud.
> + * Bits 4 and 5 used as switches, and should not be set to 1 simultaneously.
> + */

/*
 * This is wrong multi-line comment
 * style for this subsystem. Use this
 * example.
 */

..

> +#define SC16IS7XX_DLD_16X		0
> +#define SC16IS7XX_DLD_DIV(m)	((m) & 0xf)

GENMASK() (since you already use BIT() below)

> +#define SC16IS7XX_DLD_8X		BIT(4)
> +#define SC16IS7XX_DLD_4X		BIT(5)

Perhaps also EXAR namespace.

..

>  	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
>  	u8 lcr;
>  	u8 prescaler = 0;
> -	unsigned long clk = port->uartclk, div = clk / 16 / baud;
> +	u8 divisor = 16;
> +	u8 dld_mode = SC16IS7XX_DLD_16X;
> +	bool has_dld = !!(port->flags & UPF_MAGIC_MULTIPLIER);
> +	unsigned long clk = port->uartclk, div, div16;

Please, try to keep it in reversed xmas tree order (longer lines first).

..

> +	if (has_dld)

Can we actually replace this with some ID checks?

> +		while (DIV_ROUND_CLOSEST(port->uartclk, baud) < divisor)
> +			divisor /= 2;

Bit shifts and ffs() / fls() from bitops.h (or respective round*() / ilog2() /
etc. from log2.h) will help you to avoid while loop.

..

> +	div16 = clk * (16 / divisor) / baud;
> +	div = div16 / 16; /* For divisor = 16, it is the same as clk / 16 / baud */


So, these may loose in precision, right?

Wouldn't be better to have

	div16 = (clk * 16) / divisor / baud;
	div = div16 / 16;

?

>  	if (div >= BIT(16)) {
>  		prescaler = SC16IS7XX_MCR_CLKSEL_BIT;
>  		div /= 4;
>  	}
>  

..

>  	{ .compatible = "nxp,sc16is752",	.data = &sc16is752_devtype, },
>  	{ .compatible = "nxp,sc16is760",	.data = &sc16is760_devtype, },
>  	{ .compatible = "nxp,sc16is762",	.data = &sc16is762_devtype, },
> +	{ .compatible = "exar,xr20m1172",	.data = &xr20m1172_devtype, },

Sorted?

..

> +	{ "xr20m1172",	(kernel_ulong_t)&xr20m1172_devtype, },

This gives a hint about the above mentioned EXAR namespace for the definitions,
i.e. use

#define XR20M1172_...

-- 
With Best Regards,
Andy Shevchenko



