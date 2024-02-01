Return-Path: <linux-kernel+bounces-48033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA2E845680
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CBEA1C2644C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1431115DBD8;
	Thu,  1 Feb 2024 11:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gtlvxEg4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044FE15DBCD;
	Thu,  1 Feb 2024 11:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788190; cv=none; b=jSjdDmgrjkEEqej1beVpxBohYD7zi+7TEZ57nxg2L3GSJREeVIMLteRXVNpK+OKSug6SULTwls0lDdZsVHQygeEaxk3Lo3PhpOdZFGOlaIHJj6FhQzm9obfsIjWUYXt9BUv+W4LFHjJlCURN8UKzGGtN9Xzxwy1ZVj0uqNSgm1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788190; c=relaxed/simple;
	bh=cV0s2jDJHTZoSygQS7/usrq7q21w7R8Vl7sXMnzUqdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJqyh/CLIfFfhnAWlZa1nI8VCLcbYd5n9IJGE9PD/n+n7dS4timSP5b/3Y8m4HPHikvnzFyXdY5OSnRGDb7VX5Al5Q9/YHV4lLG9i+SLa8W4A4cZKbxcMlxW31Lyptyzky2knO8gbEfFlxrVbYNd/XHNnM6WJyvPuGp3W5BsaAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gtlvxEg4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706788189; x=1738324189;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cV0s2jDJHTZoSygQS7/usrq7q21w7R8Vl7sXMnzUqdA=;
  b=gtlvxEg4kbHa+VEtWrn3QYr0LS1zNNfLOXzRZeHvfKw3fkcS0pZBYtc9
   3aIEMFWZzbmeIpBWQyA27xOrBKddKzJiVyld3Q18yKH6fKJcOIZIypaUg
   HujOuFo1e2xE3t//mnRABBqqu6rUKL26MHbg0m+rlhZCcuu1ZxYIl1ZTT
   Y/reGPZ5EL24n3hGn2FNx6uvyiemATf7IfUtdE8NsDv8Ffco5KHVuIPF/
   1HNjdMull43mzKYzMWKGQ4Mstcy+daJT1+ItN0/LP34dAjqCN7pRWp7c/
   dFmYsGXni6vyNwSL1CFOoRQ5rAFm9ugPQgRckQKzID6yzHcac5qQ7FIlE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3709698"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="3709698"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 03:49:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="1119923625"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="1119923625"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 03:49:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rVVSl-00000000oxX-1hek;
	Thu, 01 Feb 2024 13:42:35 +0200
Date: Thu, 1 Feb 2024 13:42:35 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
	Kalle Valo <kvalo@kernel.org>, Arend van Spriel <aspriel@gmail.com>,
	Franky Lin <franky.lin@broadcom.com>,
	Hante Meuleman <hante.meuleman@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Srinivasan Raju <srini.raju@purelifi.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH 0/6] Convert some wireless drivers to use GPIO descriptors
Message-ID: <ZbuDqwDUaSIaOI2w@smile.fi.intel.com>
References: <20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jan 31, 2024 at 11:37:19PM +0100, Linus Walleij wrote:
> This converts some Wireless network drivers to use GPIO descriptors,
> and some just have unused header inclusions.
> 
> The Intersil PL54 driver is intentionally untouched because Arnd
> is cleaning it up fully.

Thanks for doing this! We pretty much want to get rid of gpio.h along with
of_gpio.h ASAP, that's why I expect this series to be applied in a fastest
possible manner.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



