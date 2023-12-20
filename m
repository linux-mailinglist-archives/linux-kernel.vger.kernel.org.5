Return-Path: <linux-kernel+bounces-7190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 946D381A302
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496CA1F2552E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E1D40BF2;
	Wed, 20 Dec 2023 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTr8t25I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19E6405D3;
	Wed, 20 Dec 2023 15:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703087290; x=1734623290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3XR7enFHKoVe08GWHpYKNroBhFsbx5ma1bagxJv3MNc=;
  b=lTr8t25Iex5KUpWKnue67q3Ap95K/6T5JyocFfVMn76wWq7cQ44aMOk2
   3L7dUGufI7x5w+gRDgtp66pOgFHsNfOfMDr4W+6DR2/RRlr8q4hm4HUIC
   jFIjkACB6Snzf7iJ+5C+lju0sT4Wi6aCn+AIwLfF8wNFx3hgsJ1+x4JnY
   6SyZMfV/cBRV6ZYjO4wI29KTz3tn1g9Vz2jSfwL4BOvzKxV4IKx/wxvNQ
   MDvq/CbWj0LxLQt63C8N5myZsrH2gWsTIxkuJLGsJ4SUmA41xei/M89i7
   ojOw6FrB4o22f6p9905eeIHsr8atekfg0qaiwlYWqr7E1OI8TFFd1ALpT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="482018894"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="482018894"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 07:48:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="776380711"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="776380711"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 07:48:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rFynj-00000007aki-2iLW;
	Wed, 20 Dec 2023 17:48:03 +0200
Date: Wed, 20 Dec 2023 17:48:03 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, jringle@gridpoint.com,
	kubakici@wp.pl, phil@raspberrypi.org, bo.svangard@embeddedart.se,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 08/18] serial: sc16is7xx: add driver name to struct
 uart_driver
Message-ID: <ZYMMs5A758h12AEM@smile.fi.intel.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
 <20231219171903.3530985-9-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219171903.3530985-9-hugo@hugovil.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 19, 2023 at 12:18:52PM -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Make sure that the driver name is displayed instead of "unknown" when
> displaying the driver infos:
> 
> Before:
>     cat /proc/tty/drivers | grep ttySC
>     unknown              /dev/ttySC    243 0-7 serial
> 
> After:
>     cat /proc/tty/drivers | grep ttySC
>     sc16is7xx            /dev/ttySC    243 0-7 serial

"Useless use of cat" (you can google for this phrase, it's famous).

	grep ... /proc/...

will work :-)

Otherwise LGTM!

-- 
With Best Regards,
Andy Shevchenko



