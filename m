Return-Path: <linux-kernel+bounces-156933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3787D8B0A84
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5882EB2183C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AA215B130;
	Wed, 24 Apr 2024 13:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="npKtE5vm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F66156C71;
	Wed, 24 Apr 2024 13:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713964266; cv=none; b=R9ZU7LhsfBB+2tVC5SQsGXjFP/M3H4dV5qig+FUIcbClNaNzKvNKY9RZI5tAPtKHcwio8Ph+AfKH3BoHWqlTKXTaV4e+WtxMMcJwFC/VRcJWKj5jY/O/F+iUmaHir/0+277gZXul91BC0HsSJr0mhJiE1MibC+CImgpKw1A5efg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713964266; c=relaxed/simple;
	bh=3PcOgPceJEiC6m9cZ1LVSeHjh37/hFNV6mfbgVb5lwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeWHNDbdQ15oXBOIMrZOsXyA4uZGXSd+CbGcBFgng7yyDZv4SLP/2NIwYVu6JJ14KLNb8qQQAh2WdIUfluMDxGOcmArSXSpJ4IVFzN7xBita/BAdQEjKRir1VloD95y0ztHY2cpDvhS9ZUEwnejoRDFRhemiJi4YDHzUEIvyx+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=npKtE5vm; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713964265; x=1745500265;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3PcOgPceJEiC6m9cZ1LVSeHjh37/hFNV6mfbgVb5lwI=;
  b=npKtE5vmNUftwo2hMDTnVvNDk5u8pzt48bXjvBm+JZRMVd7aJwQ6rpWk
   cnFbcFdKlrO6UWEsHwA5DHlRk+j1JeRDRc65z2yYvKGib5HH+8ZGS5Kcq
   9UjgI4kTb9BSUuLZ4ct1ttGf7Kd/2QwXEg4sAhKRC3ZO65uAjSF904zOe
   i9lvBDjbI56f2H6MMl/5O46wH9p2QSTAD73OWAi0eOSyRmO6syG32TRJj
   pfXSSZh+JR+dApnPlAcOQv70PTrPTLlc7UTSpdBknnkvcxMsckQTHJvna
   R77/57quwCGwvCdk8OjaupFHpkfI0Kut4b3I59zUddEYggO1jJBDVgVF6
   Q==;
X-CSE-ConnectionGUID: 42BSboLdTM2UMoVdjFc02w==
X-CSE-MsgGUID: DS4jJoUtRQWem34+ff+Wlw==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="32084786"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="32084786"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 06:11:05 -0700
X-CSE-ConnectionGUID: hcUH0FqpTTWhma57UPIH3w==
X-CSE-MsgGUID: vl74hA0uTqeby/DYkytS3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="55907700"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 06:11:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzcOp-00000000em2-1179;
	Wed, 24 Apr 2024 16:10:59 +0300
Date: Wed, 24 Apr 2024 16:10:58 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sui Jingfeng <sui.jingfeng@linux.dev>, dri-devel@lists.freedesktop.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] software node: Implement device_get_match_data fwnode
 callback
Message-ID: <ZikE4qOVO7rgIs9a@smile.fi.intel.com>
References: <20240422164658.217037-1-sui.jingfeng@linux.dev>
 <Zie3ebHOEpWHj1qV@smile.fi.intel.com>
 <d5bc1e73-a553-451e-ab74-f5f0ca259c6b@linux.dev>
 <hcltp2bbxxg2t7ibmzgiib7mgbwgmvzwnnq6mochdh7c4h76r3@bxj6yk5zq64e>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <hcltp2bbxxg2t7ibmzgiib7mgbwgmvzwnnq6mochdh7c4h76r3@bxj6yk5zq64e>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 24, 2024 at 12:37:16AM +0300, Dmitry Baryshkov wrote:
> On Wed, Apr 24, 2024 at 12:49:18AM +0800, Sui Jingfeng wrote:
> > On 2024/4/23 21:28, Andy Shevchenko wrote:
> > > On Tue, Apr 23, 2024 at 12:46:58AM +0800, Sui Jingfeng wrote:

..

> But let me throw an argument why this patch (or something similar) looks
> to be necessary.
> 
> Both on DT and non-DT systems the kernel allows using the non-OF based
> matching. For the platform devices there is platform_device_id-based
> matching.
> 
> Currently handling the data coming from such device_ids requires using
> special bits of code, e.g. platform_get_device_id(pdev)->driver_data to
> get the data from the platform_device_id. Having such codepaths goes
> against the goal of unifying DT and non-DT paths via generic property /
> fwnode code.
> 
> As such, I support Sui's idea of being able to use device_get_match_data
> for non-DT, non-ACPI platform devices.

I'm not sure I buy this. We have a special helpers based on the bus type to
combine device_get_match_data() with the respective ID table crawling, see
the SPI and I²C cases as the examples.

-- 
With Best Regards,
Andy Shevchenko



