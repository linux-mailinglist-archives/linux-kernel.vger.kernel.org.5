Return-Path: <linux-kernel+bounces-97205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC3A8766F3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C4E1F2106A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106454400;
	Fri,  8 Mar 2024 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jpvSdWdM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12596322A;
	Fri,  8 Mar 2024 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709910225; cv=none; b=rByau1jM5o0GqrdahhnY2ySi5CndywuIEbg90/4dWzqKcbmHOBWuaMO8wIkHPE50Zn4yTbt7I01ppqEgh/3jukXkcr92+lkBcCx9/bWwI1fo3gMxU0520DBDUajBFCqGAw76uvPpRqZiAhX3DHUnEAAEE5sSlogwntt3aNZTxJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709910225; c=relaxed/simple;
	bh=nLXRZzrvvTYfk/wB41SwnEDOT+0lF2L9eQ4Zgc72uf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shixdwCblsaodVo+XCP4bHJYnNr1bEjhKhltBXSBWe2URWorQ5eeu2Uqgp6P60j/whCXPqrDO7RNQD3WuNaM0pvkcGiLYo3jMpNeCDFFd/OYmBp6uF6FAfdfthfVT5vjoF9jg+JlCxj3YaJqH23VJ3L//NzihN0LLOAF1v8Ezrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jpvSdWdM; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709910224; x=1741446224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nLXRZzrvvTYfk/wB41SwnEDOT+0lF2L9eQ4Zgc72uf4=;
  b=jpvSdWdMD1o4A5MR3nIz41xOtZhofV27akfPeurVnQze6XWQea6ZcNOY
   dS6QTF4hGIVzZUo3sA2yP/GNM8fxDoxgQFVsGi2liaqDJZQyjK2TZEr7v
   uwbjKqSyPr4EIBVGZJ4H7H+ZCxLTc1SK69rcc2jdshUuB41Sq5KlOA2Xl
   0Dpb4xm8BNCESzYwKy0Tb7uHc6uzqAJySsl2pILP2L9n7A/canY+45/SF
   ewBuuzNzMjnhvfg0jiAEC2A4iyMKibtyaFhSSiTxKt6f0k9BXdLP79mBD
   iipnLRipIl3oXRC0Q1QOncNowNay9pDAAI+0Olnqdlg6QAZ7Wfaj5/zex
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4500777"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="4500777"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 07:03:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="914248499"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="914248499"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 07:03:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ribl4-0000000Arw1-1L27;
	Fri, 08 Mar 2024 17:03:38 +0200
Date: Fri, 8 Mar 2024 17:03:38 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 3/3] spi: pxa2xx: Use proper SSP header in
 soc/pxa/ssp.c
Message-ID: <ZesoygjRoCR9HO_V@smile.fi.intel.com>
References: <20240307195056.4059864-1-andriy.shevchenko@linux.intel.com>
 <20240307195056.4059864-4-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307195056.4059864-4-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 07, 2024 at 09:47:47PM +0200, Andy Shevchenko wrote:
> There is nothing from pxa2xx_spi.h used by soc/pxa/ssp.c.
> Replace it with pxa2xx_ssp.h.

Acked-by: Arnd Bergmann <arnd@arndb.de>

P.S.
I dared to add Arnd's tag from previous version as this patch
hasn't been changed.

-- 
With Best Regards,
Andy Shevchenko



