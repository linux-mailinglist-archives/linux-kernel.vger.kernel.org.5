Return-Path: <linux-kernel+bounces-129459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB2A896B19
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EEB11F24291
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52061350D7;
	Wed,  3 Apr 2024 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PdMaRQFD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8192045977;
	Wed,  3 Apr 2024 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138068; cv=none; b=ZHqh8p3yZ5HvpvyG02n4uLKGM5+hNn6iehF+rZEmIqLopQ0b+Kn94MW7LyeyBaTba2lWwfLEk2/K48KMK2OqiOShqiV25ZkWg7Qhj8YXa2w9gdx3KxoCwo3DSm7cV68nzIhXGS/fqdgqtthlQXLEBSNUfSk0i9fz61SEtJHhzCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138068; c=relaxed/simple;
	bh=molvkrYeM46oRwSg5rOEZ8ktham3sHUUuk5x7OJY1B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRkYWDMIi55CBynNfVMi+RsMia0k+f1LZeKIY3I5YQ1ynZAi0B1KgsQg+LMD+yJovtVyG/I5et9M9KEhyzAkgV1w2FE9PWtVbyMvXXcUh709ngtp6op0hTnEApLK+/HPjRwXNUWmpAg9JjVOjeZz7iCjsTW9OEV6KcWuaIc/5FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PdMaRQFD; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712138067; x=1743674067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=molvkrYeM46oRwSg5rOEZ8ktham3sHUUuk5x7OJY1B0=;
  b=PdMaRQFDZuIAZyF403DtoyI4/XxrGZe7SUobhv5G89ahTA17ERTdSdee
   VKV5zOv/II4Oonx4nHKJvbGHulavBgMIilrDGIPtxX9zPKDsXVzV7ttGr
   oLDmbnmQWV9b00/5SIouPp+w4Zp5RowXJreWmhbqwifZKmf9YPmQadmsm
   b2KGF/gFj576Tuj68DligbiULPrlqIeLYDGISZ1j2TTsABw0i2ZSQXWcn
   eMKvWC0ERy3IbmDRHJ78BOJ84OoAKnf6VwGB1FzNWjodh0HaUBUG2Bsp1
   o1HXE0UGYw3xcXGOpIivoTakhUM/t8+/e6ZjF4bO2uOQhFRCqWopC4Yhp
   w==;
X-CSE-ConnectionGUID: xp7Xj1eXSqCeoO05lIKbvQ==
X-CSE-MsgGUID: xxSV8ZkDQnyZsDPuMdOdxA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7484449"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7484449"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 02:54:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="915176805"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="915176805"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 02:54:22 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rrxJz-0000000156I-3UV8;
	Wed, 03 Apr 2024 12:54:19 +0300
Date: Wed, 3 Apr 2024 12:54:19 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guanbing Huang <albanhuang@outlook.com>
Cc: gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
	linux-acpi@vger.kernel.org, tony@atomide.com,
	john.ogness@linutronix.de, yangyicong@hisilicon.com,
	jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, lvjianmin@loongson.cn,
	albanhuang@tencent.com, tombinfan@tencent.com
Subject: Re: [PATCH v4 2/3] serial: 8250_port: Add support of pnp irq to
 __uart_read_properties()
Message-ID: <Zg0nSz7QSBjIQ_XP@smile.fi.intel.com>
References: <20240403074130.93811-1-albanhuang@outlook.com>
 <PSAPR06MB4952D98B1204C8591989DB25C93D2@PSAPR06MB4952.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSAPR06MB4952D98B1204C8591989DB25C93D2@PSAPR06MB4952.apcprd06.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 03, 2024 at 03:41:29PM +0800, Guanbing Huang wrote:
> From: Guanbing Huang <albanhuang@tencent.com>
> 
> The function __uart_read_properties doesn't cover pnp devices, so add irq

__uart_read_properties()

PNP
IRQ

> processing for pnp devices in the branch.

PNP

..

>  #include <linux/property.h>
>  #include <linux/serial_core.h>
>  #include <linux/spinlock.h>
> +#include <linux/pnp.h>

Keep it ordered (in this context it should go before property.h).

-- 
With Best Regards,
Andy Shevchenko



