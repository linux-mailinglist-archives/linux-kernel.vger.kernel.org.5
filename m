Return-Path: <linux-kernel+bounces-155745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C5D8AF689
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A80951F25091
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08AD13EFE4;
	Tue, 23 Apr 2024 18:29:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F8813DDAA;
	Tue, 23 Apr 2024 18:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713896999; cv=none; b=AU7NksAmB6p5LLMzQkDHR5i9JiMjCtbzPagX+P8K21kH5fQ8yCt6//8bwzMFyIYQq5FQ++JxLn4sYhsfIYxQIXpPg6GNSxxatethlk0o2UAQmoG+KKrEwERWKdIwx/jkdACo0tQ6QizrXpfzDXKUsfF6EEiwtGuZzacOUq4QxAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713896999; c=relaxed/simple;
	bh=u+jW0tJOmCnes0B+R2bL403F+bcRaggYH4EWURUlaiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWnCAbzvkzVpSMpF46TsyJiYOT7L3RTrU4g3wWf+XT/5o3+5/1LxJUJNFIdbnecjB/tcEqRyXpTfgmsxyq0BmUoyGP5S38Efa8ZCTBdO+lRUkFcKQaNxjDeqOrEffBJvVDA8Y+WLWi9mjopK8S9TNExaMsXtNP8OxSfvOXZE7hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: QRGtseqfQOCMdXwW7xsoJA==
X-CSE-MsgGUID: YG04vnEgRkOApE70J5mFjw==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9329798"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9329798"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 11:29:57 -0700
X-CSE-ConnectionGUID: T489GwyVTWqDK4H6kCJHQQ==
X-CSE-MsgGUID: F/zUM+zISH63zORzV1VXOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24495894"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 11:29:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rzKtt-00000000QwT-0ju7;
	Tue, 23 Apr 2024 21:29:53 +0300
Date: Tue, 23 Apr 2024 21:29:52 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Aapo Vienamo <aapo.vienamo@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Elliott, Robert (Servers)" <elliott@hpe.com>,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] gpio: Add Intel Granite Rapids-D vGPIO driver
Message-ID: <Zif-IHllDG6CmJmk@smile.fi.intel.com>
References: <20240423181314.84677-1-aapo.vienamo@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423181314.84677-1-aapo.vienamo@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 23, 2024 at 09:13:14PM +0300, Aapo Vienamo wrote:
> This driver provides a basic GPIO driver for the Intel Granite Rapids-D
> virtual GPIOs. On SoCs with limited physical pins on the package, the
> physical pins controlled by this driver would be exposed on an external
> device such as a BMC or CPLD. The virtual GPIO registers are an
> interface to firmware, which communicates with the external device that
> implements the GPIO hardware functionality.

..

> +#include <linux/bitmap.h>
> +#include <linux/bits.h>

The latter is guaranteed to be included by the former. I can amend this when
applying.

..

I'll wait for others to review for a while. I want to send my PR to Bart at
the end of this week.

-- 
With Best Regards,
Andy Shevchenko



