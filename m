Return-Path: <linux-kernel+bounces-129639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A29A896DAE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BC4A1C25F24
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DD61411ED;
	Wed,  3 Apr 2024 11:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l8qbELEQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C5471736;
	Wed,  3 Apr 2024 11:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712142462; cv=none; b=uBsXGPX4CdKKf/SPm6vA4GrCNHkbPzuNS4J7OHySdQ5G6kclSj7Mrd3H/RBjZD64IzgGPlazEuU+okS6mDHMIWtqsrDn+wqo2xiJrdrH1CWD3USlVDZS8xOtqWk1xxxVQaMbpE/At5OLyr5miOFw+f17MDaRs8WpWyjzx5v2RhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712142462; c=relaxed/simple;
	bh=W3Ge3vROf3oGr+qOJOoJNxTnopZwS7ozZZCtveEdiPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIkTmfCBLgTCM533M6V4HpPdSOZxyYJCWcxXSEqucVviVdBTnrQlYKO1fxAfoEogdXPGRIDOzs2fAGW5oWa6UuAWTpm2VIjXHS4PwtTHP56Zwpnr0JgmyOgWNvna84T1xDFDlqRPJC/h3UMc2eLPh28BSc5MKv/p3EFWEe8b2s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l8qbELEQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712142461; x=1743678461;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W3Ge3vROf3oGr+qOJOoJNxTnopZwS7ozZZCtveEdiPA=;
  b=l8qbELEQDL9BT5zRMT467ASuYDn3hj0U0mPNRFEMdj+Q8L9crLEpOnak
   vhJHEk+EIlOwdLSUmILpVq7ah76hitWmWcPpV6FKxVcQlNezQG3O62SNq
   4aGWpfn4QOLyxUkon23QO7OpU34+AYhqEMfny56R296yrje50IS2B1PNz
   +T/1Q0592QMcWgeM6ktAK+ZbDHdG+k84NC7GjlIHeiIzePZkFXP8CGR4+
   LWtfCOmyrJ8zlcfHjFrzDG/m+hJx5R5cWnRKoqXraAtgcc+8atSQf3+4o
   rvIMBfgO4lQ2Yls9t/Ijf3L5LOeF4GACk11X2WpipX7qbJWYYBcRpfNUe
   g==;
X-CSE-ConnectionGUID: EwLpJeuoTR+i+j96yHnhZw==
X-CSE-MsgGUID: 2FT5tdPHRfqHSR8M+F44pA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7592840"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7592840"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 04:07:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="915179348"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="915179348"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 04:07:31 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rrySn-000000016IN-2TvT;
	Wed, 03 Apr 2024 14:07:29 +0300
Date: Wed, 3 Apr 2024 14:07:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: (subset) [PATCH v2 0/9] spi: pxa2xx: Drop linux/spi/pxa2xx_spi.h
Message-ID: <Zg04cWhT_Dl6AUik@smile.fi.intel.com>
References: <20240327193138.2385910-1-andriy.shevchenko@linux.intel.com>
 <171167575036.187521.17547262230962160149.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171167575036.187521.17547262230962160149.b4-ty@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 29, 2024 at 01:29:10AM +0000, Mark Brown wrote:
> On Wed, 27 Mar 2024 21:29:19 +0200, Andy Shevchenko wrote:
> > As Arnd suggested we may drop linux/spi/pxa2xx_spi.h as most of
> > its content is being used solely internally to SPI subsystem
> > (PXA2xx drivers). Hence this refactoring series with the additional
> > win of getting rid of legacy documentation.
> > 
> > Changelog v2:
> > - dropped applied patches
> > - added patch to amend dependencies (Mark)
> > - amended the second patch accordingly (Mark)
> > - elaborated purpose of the patch 6 in the commit message (Mark)
> > 
> > [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> 
> Thanks!
> 
> [1/9] spi: pxa2xx: Narrow the Kconfig option visibility
>       commit: 3af201a405b3e5abee65102b062c309fff68cc0e
> [2/9] spi: pxa2xx: Drop ACPI_PTR() and of_match_ptr()
>       commit: 9907c475dcab9b269422972577360122129ac84c
> [3/9] spi: pxa2xx: Extract pxa2xx_spi_init_ssp() helper
>       commit: 7290f1e4075d28ab961df5a454503296fa289271
> [4/9] spi: pxa2xx: Skip SSP initialization if it's done elsewhere
>       commit: bb77c99ee6d3d704086acf141d3ec92601747809

Thank you!

Do I need to do anything else to get the rest applied?

-- 
With Best Regards,
Andy Shevchenko



