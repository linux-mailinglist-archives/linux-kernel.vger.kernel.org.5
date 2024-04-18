Return-Path: <linux-kernel+bounces-150603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CCC8AA198
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30CE51C20FE2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF4F177980;
	Thu, 18 Apr 2024 17:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GjRJw1YW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D861442F4;
	Thu, 18 Apr 2024 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713462849; cv=none; b=QS966/nuq79Ec1E5Grm3mu1suVYKYiCexb8r25RuaqbyTaaXRkS+K00sxq98x2fOs5K4e30LaXYDk9FDLjpzXoWQ/TgUcJ5p5DsmoqetrOtyIA2OFL+fWEw5pLriInPqPXAOhfaYnczce+yTtuWFS5paAUuw6cnF8Czf4R1CnKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713462849; c=relaxed/simple;
	bh=0a9FZ5kxuVUE8o/BfQ+wXbwjLxMhPraV7wWeJYFX9S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ds7tDhM0o3DSQod6RBroxovvzlIglZRh6QGeFATNwqp80VaBkoFyIsOV++Ri36CKlQgArP6xB7zQveVdjSXvPVutr6unOR2H80iCz7VA8d9YiTbBciVmcEXTcmpt0PB9mGM1LswKgGlAOcMiFiReH4qBDaNGCepZjReVSVi8k40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GjRJw1YW; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713462848; x=1744998848;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0a9FZ5kxuVUE8o/BfQ+wXbwjLxMhPraV7wWeJYFX9S4=;
  b=GjRJw1YW9eIwlBOSYtry8oZ6FIGYU/05rqD6A3joZYIKorp84S77ELPH
   4+5BWwSq2aqBLNt21LSf2IS2Nz8JUAlB2VrKhMFKzl7DrYPoD/o9dsFKD
   fIIanmcHsr6YrNgr66QZE2g5NiCjeGo5G0gc45/4UsTWrZ56FY/9fCCoC
   icbOmxsSo1gBi//99/Bsn6F4+AQZqT3toZD5S69nRgs5HA5Skhvtl/Jk+
   iVxI6aSuYJ8YErnuB1fmrc8LgQzGrsPAU9k5g4eWJJxE7kMJKhrOxzBid
   +lr5k68ylKGiyCvv2dxAbq2DDqn8fMmVs9gTGNd9hbccqDS7TN0Uw4aAl
   w==;
X-CSE-ConnectionGUID: MjbR1HnsSJKu9MGCsblBxw==
X-CSE-MsgGUID: A2IKTMihQjSKGFmF14zWpw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="20453032"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="20453032"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 10:54:07 -0700
X-CSE-ConnectionGUID: kUa5EzyiRam30J+gYZs1Pg==
X-CSE-MsgGUID: G2A+ciC3QfWd5q8+RK7/XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="23124009"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 10:54:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rxVxQ-00000000QYc-1qx5;
	Thu, 18 Apr 2024 20:54:00 +0300
Date: Thu, 18 Apr 2024 20:54:00 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Konstantin Pugin <rilian.la.te@ya.ru>
Cc: Konstantin Pugin <ria.freelander@gmail.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 3/3] serial: sc16is7xx: add support for EXAR XR20M1172
 UART
Message-ID: <ZiFeOKNashUrmoDi@smile.fi.intel.com>
References: <20240418170610.759838-1-rilian.la.te@ya.ru>
 <20240418170610.759838-4-rilian.la.te@ya.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418170610.759838-4-rilian.la.te@ya.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 18, 2024 at 08:06:07PM +0300, Konstantin Pugin wrote:
> From: Konstantin Pugin <ria.freelander@gmail.com>
> 
> XR20M1172 register set is mostly compatible with SC16IS762, but it has
> a support for additional division rates of UART with special DLD register.
> So, add handling this register by appropriate devicetree bindings.

..

>  /* Special Register set: Only if ((LCR[7] == 1) && (LCR != 0xBF)) */
>  #define SC16IS7XX_DLL_REG		(0x00) /* Divisor Latch Low */
>  #define SC16IS7XX_DLH_REG		(0x01) /* Divisor Latch High */
> +#define XR20M117X_DLD_REG		(0x02) /* Divisor Fractional Register (only on EXAR chips) */

The comment in the parentheses is not needed anymore as it's implied by
the namespace.

..

> +#define XR20M117X_DLD_16X		0
> +#define XR20M117X_DLD_DIV(m)	((m) & GENMASK(3, 0))

Seems like one too little TABs in between.

> +#define XR20M117X_DLD_8X		BIT(4)
> +#define XR20M117X_DLD_4X		BIT(5)

..

>  	char	name[10];
>  	int	nr_gpio;
>  	int	nr_uart;

> +	bool has_dld;

Not needed. See below.

..

> +	bool has_dld = s->devtype->has_dld;

So, you can check against devtype itself:

	s->devtype == &xr20m1172_devtype;

> +static const struct sc16is7xx_devtype = {

..

> +	if (has_dld && DIV_ROUND_CLOSEST(clk, baud) < 16)
> +		divisor = 1 << (fls(DIV_ROUND_CLOSEST(clk, baud)) - 1);

BIT() ?

-- 
With Best Regards,
Andy Shevchenko



