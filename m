Return-Path: <linux-kernel+bounces-160167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0C18B3A20
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A9C12821A6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B58953389;
	Fri, 26 Apr 2024 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C4pDxQu8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BA21E504;
	Fri, 26 Apr 2024 14:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714142091; cv=none; b=hBzO4etsK3/Rar60HgXJJzz9xTy1ZjichbZWZqE/Jdc+R+L5TYSY28rUQVMbIK7BsSfCz0y1ZtuPlyHtXbg1vEkhC74PjKfe0sA/ShHzJpAFAm2Mb0ErlMZNNtlTnZkleIzexY6vPUWW2pa1gr1b9+rbg7F9zvEbROhwHT4mzO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714142091; c=relaxed/simple;
	bh=UJhGAfgCa1LonBaou1hb2Cm90iAzZlg29gkrT2S6//U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUIcA1VIRoCG9eWDh62uylAcRPBDelE5P8oUJaosketkDcwJ4jAQstsmVIE5gVIxghSnkgldybKOnMXzDvK2Ukn/klircvxurUYZYvhoOTPsbMH4eXu9ibjQKUv7GbgaKnPtcFFbG6FcH4gdkBQafXyWTsRsZyHKvNF8pKPI5PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C4pDxQu8; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714142090; x=1745678090;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UJhGAfgCa1LonBaou1hb2Cm90iAzZlg29gkrT2S6//U=;
  b=C4pDxQu8aK87C7QxleHekd2ieIlxtHCLwSUQbpmdf/U7+23wZmzvxo4B
   CeY5ZNqksPlZwyfTD2M30KpGv1vfM3lYj2eCrVtyXKteVh3YohU0ILfbd
   PpOlLS//VrhS1NhuGuOg+Gt+6iG+FIkK2RqwPc0meJdZZ22AKR4vZ0iQx
   iJwNNGWjT8L6ejXJrSbe2BssV266Km5kkPulhXsYY/K34qxLZWTLUB5CZ
   pCKib416luTTNTym66ngLEW1N5QeIB11YwABWR3vXH1fISd0GDvul/Kzu
   CHVcxSG4irB0i4RaRaOitASgnzzOg81A3sp4SWwupma5QJQi6noABgZ+J
   Q==;
X-CSE-ConnectionGUID: ERyP42cRQgWQx/iS8lspPQ==
X-CSE-MsgGUID: linzn3zEQFulCdJp4g+LrA==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="27334179"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="27334179"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 07:34:49 -0700
X-CSE-ConnectionGUID: DOQkqHPMTae0DO5onbrITg==
X-CSE-MsgGUID: CPBENSQ1QSSplDzFHksY3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="56361315"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 07:34:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s0Mez-00000001LXP-0q4D;
	Fri, 26 Apr 2024 17:34:45 +0300
Date: Fri, 26 Apr 2024 17:34:44 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: lumingyindetect@126.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	LuMingYin <11570291+yin-luming@user.noreply.gitee.com>
Subject: Re: [PATCH] "drivers:Fixed memory leak in
 /linux/drivers/tty/serial/8250/8250_lpss.c file.
Message-ID: <Ziu7hC25v2Xi50VG@smile.fi.intel.com>
References: <20240426021939.1083521-1-lumingyindetect@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426021939.1083521-1-lumingyindetect@126.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 26, 2024 at 03:19:39AM +0100, lumingyindetect@126.com wrote:
> From: LuMingYin <11570291+yin-luming@user.noreply.gitee.com>
> 
> In the lpss8250_probe function in the file
> /linux/drivers/tty/serial/8250/8250_lpss.c, there were certain return paths
> where pci_free_irq_vectors was not called to release memory related to pdev,
> leading to a memory leak. This commit fixes that issue."

This patch does not fix anything. The driver uses pcim_enable_device()
which changes how this all behaves.

NAK.

-- 
With Best Regards,
Andy Shevchenko



