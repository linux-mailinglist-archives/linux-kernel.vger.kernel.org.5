Return-Path: <linux-kernel+bounces-7247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F01881A3C0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30851F23785
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4589546438;
	Wed, 20 Dec 2023 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZMHEj/m3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A604643D;
	Wed, 20 Dec 2023 16:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703088392; x=1734624392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QqKJ2GAb74fyLS4AkPzlJYFH8BWX6OuBMeEt2i+oj8o=;
  b=ZMHEj/m3Z7gvI8I8nWRm4SfQIIy+3MOwg9oFGu8aU9xVLmsHN/haCRie
   y9suC6htGaxxwQLBNFQdS0TAS0NBnzGNkvu7+7pJDa+EinnxGlNnJ1lZC
   PFIyEybzp2a5S0HVNeK/K5m2bQJahHL8vEjGroQz3C0H3JZMTNpavhMw6
   ajqAjlM1psu0Z2wC2TVyNxboIvTCH7VEz91OKJgTkYZQGZOzv2xogpSOA
   QXBBItXlA9QY4GbSs+K1ZuOI90YZGheiVTdW51k3PhqEcqvhcsyl3Jup9
   72nsfYEnMoQRgde4xBebBfA2HxX4OF0CGgDQ7Upm7W5r268MNWoogwrJt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="398615384"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="398615384"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 08:05:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="779890075"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="779890075"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 08:04:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rFz44-00000007ayn-0O62;
	Wed, 20 Dec 2023 18:04:56 +0200
Date: Wed, 20 Dec 2023 18:04:55 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, jringle@gridpoint.com,
	kubakici@wp.pl, phil@raspberrypi.org, bo.svangard@embeddedart.se,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 18/18] serial: sc16is7xx: fix whitespace in
 sc16is7xx_startup() comments
Message-ID: <ZYMQp_GIVp6Pm15R@smile.fi.intel.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
 <20231219171903.3530985-19-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219171903.3530985-19-hugo@hugovil.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 19, 2023 at 12:19:02PM -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Add missing space at end of comments.

...

> -	/* Reset FIFOs*/
> +	/* Reset FIFOs */
>  	val = SC16IS7XX_FCR_RXRESET_BIT | SC16IS7XX_FCR_TXRESET_BIT;
>  	sc16is7xx_port_write(port, SC16IS7XX_FCR_REG, val);
>  	udelay(5);

You can combine this with other comment style cleanups and spelling fixes
(if any). I.o.w. proof-read the code and check if there are any issues
besides noted ones.

-- 
With Best Regards,
Andy Shevchenko



