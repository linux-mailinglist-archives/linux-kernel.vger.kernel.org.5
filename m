Return-Path: <linux-kernel+bounces-7197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8041F81A314
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BA3A1F214F3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915B141757;
	Wed, 20 Dec 2023 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MaXTpkpz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4A440C00;
	Wed, 20 Dec 2023 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703087443; x=1734623443;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UhdmluMNpK/TcTrqtcRnsnNoNAHzR/TaqZv3iZKi1oc=;
  b=MaXTpkpz0mzFMfP5I4n4/B7zkbrxy7E+CJh73I44uFbO5wwJX4/iyjHU
   s17q6bwa/ZK4rFjLmkJzZdbofCZId3uo1KW+IaCJH9PfVhr+OR01rmdXB
   ztAfoWxdbb0W9Yk96zqlmwePTChYTVahqi4UPOOxh8k1dwMUF+hcutwOk
   DgX40traih8C8677JYPFa2Fyx03CghlG6kwy1TedjS+D6Rophm1jFM516
   G0gMTNWKlQgJ2tsE5DhyZyZvz1HTTai70TnNYl2uyl1WVFZu0z5LCIOUn
   B/4WE1VWi8zzfH8KuYHl42mqqAA1sI+n8kBk3Li6s9qX+H+tJiHNcFuJ9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="462282775"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="462282775"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 07:50:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="1107765632"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="1107765632"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 07:50:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rFyqB-00000007amZ-0P8C;
	Wed, 20 Dec 2023 17:50:35 +0200
Date: Wed, 20 Dec 2023 17:50:34 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, jringle@gridpoint.com,
	kubakici@wp.pl, phil@raspberrypi.org, bo.svangard@embeddedart.se,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 09/18] serial: sc16is7xx: add macro for max number of
 UART ports
Message-ID: <ZYMNSqFgAhId-lQ2@smile.fi.intel.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
 <20231219171903.3530985-10-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219171903.3530985-10-hugo@hugovil.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 19, 2023 at 12:18:53PM -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Add macro to hold the maximum number of UART ports per IC/device.

...

> -	if (count < 0 || count > ARRAY_SIZE(irda_port))
> +	if (count < 0 || count > SC16IS7XX_MAX_PORTS)

ARRAY_SIZE() is more robust than this. What if you change to support different
devices where this won't be as defined?

>  		return;

...

> -	if (count < 0 || count > ARRAY_SIZE(mctrl_port))
> +	if (count < 0 || count > SC16IS7XX_MAX_PORTS)
>  		return 0;

Ditto.

...

> +	WARN_ON(devtype->nr_uart > SC16IS7XX_MAX_PORTS);

Not sure about this, perhaps it's fine.

Otherwise looks reasonable.

-- 
With Best Regards,
Andy Shevchenko



