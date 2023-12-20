Return-Path: <linux-kernel+bounces-7387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E7D81A724
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 20:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58C31B20CDD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 19:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E66B482E7;
	Wed, 20 Dec 2023 19:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B0tL/GrI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F415482D8;
	Wed, 20 Dec 2023 19:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703098926; x=1734634926;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5laG/VAsIpPh3wjO8Jn0lZN6KFxoK03P8/iDWEDZx24=;
  b=B0tL/GrI5VU4AHBF4ZWYBEsAlwEkY+A8E28uJU4JUev3FvyRK4Ol79qQ
   mA5JbG9JaYKjCQ7DlN41ZTC7IJO88DKes1sEOCGeooLFlsvsmFk+lr4B2
   uvfBeLW9nAF2EPxeVfcCt4TkhAEvD0U2ZGC5GoDXeFmDH8irO4MLdEkWy
   565OApmrtldmNYz0TYmnpEf+dDPd+mIrZgPe6vywJMaaGRyyOyso9C0vX
   pT0A1JAy90abr2Hnk7CZqFdJseYWjfgRSyoBj8A43Yf2yzh8toLBAwSOR
   bJKP/HGvMrScYSTJh75znDtHJMfjTDtgj/WEgQRUUvDlOyind82U1Auwh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="2687168"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="2687168"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 11:02:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="842368484"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="842368484"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 11:02:03 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rG1pQ-00000007ejP-1oUh;
	Wed, 20 Dec 2023 21:02:00 +0200
Date: Wed, 20 Dec 2023 21:02:00 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Akinobu Mita <akinobu.mita@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: bmp280: Add missing bmp085 to SPI id table
Message-ID: <ZYM6KMQyC1eZWs-1@smile.fi.intel.com>
References: <20231220184753.6472-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220184753.6472-1-semen.protsenko@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 20, 2023 at 12:47:53PM -0600, Sam Protsenko wrote:
> "bmp085" is missing in bmp280_spi_id[] table, which leads to the next
> warning in dmesg:
> 
>     SPI driver bmp280 has no spi_device_id for bosch,bmp085
> 
> Add "bmp085" to bmp280_spi_id[] by mimicking its existing description in
> bmp280_of_spi_match[] table to fix the above warning.

Good catch!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



