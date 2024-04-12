Return-Path: <linux-kernel+bounces-142880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0144C8A318E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9B231F21A29
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9C4145FF9;
	Fri, 12 Apr 2024 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PXAJs4g5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DB0145333;
	Fri, 12 Apr 2024 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712933572; cv=none; b=HO8JDTJZac0eU5OdyGs2XBy28cB9pzgHDPYM/60b0HEm0999nj9zCzR12ZCUBSfsN+bvKpQqhVYvxOE/sgOrupqcsCeqxZvQ/zjdJ+5rJ1Jfh/8AXJ5YmDII1aDRdlnwWPeOcW4pqo4OTvYGzSwBJJ6r5Xv/Vo94gdI+KE82wYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712933572; c=relaxed/simple;
	bh=3VJO+40pwSkL8WEP5XEs7367DXnCHzRW9AIbe65tr7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1ixzWl+R1yCRCu+dSqbLikH2KzgyrgVoftv+40dCgeodPe8SRDdKeafVr7xfeXpJt27Kx97nlj7sXb4bFSEn/hbh52hCAoPVMuTn/sOJYO0BiQunWGtq/sPZc/xGqyJe/TgMnuKYQNiMkKNu7jBq/y2ybS6lR4WuNOZxCihp+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PXAJs4g5; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712933571; x=1744469571;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3VJO+40pwSkL8WEP5XEs7367DXnCHzRW9AIbe65tr7w=;
  b=PXAJs4g5wg3ErC1btReuQ0iiYUy8BKv8nVcclBwEa+cM9Un6mH4WcYAe
   AFYgML7ccsQ2l+QtWUP97joyNtmOWHPsUsM/JP5YU9EIsBCTPDt8HzF+8
   5ng6j6Ld0NeviflAFfc74eLzX1fP4DDESayIatu4IV/9gQdGD4+kBRUpc
   eLT0iEp5cAeu3uDms74G0cMVOB92eWBfkBDX41qmpDtKLLtcyLIZzIGKa
   HToSXqvb5MYCYKo18wb5YUfn/kLDPA/JBLEQkGck+6BnHISAaU0utNl6g
   LCSs7IMsBDY5SQlSgDm4RH17WBtSJaFVJ/VxYHSSVTjkzOV3zpb+3fHSk
   g==;
X-CSE-ConnectionGUID: 7gGmLBNDSYCUN8qqGendhg==
X-CSE-MsgGUID: 0E1ZN7QZRTSIaYuVw6rNUA==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="8497359"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="8497359"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 07:52:50 -0700
X-CSE-ConnectionGUID: UR2HQIB/T9aOUxFJHHipNw==
X-CSE-MsgGUID: IbdOgvKoQS2wVBiMBfp5dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="25906271"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 12 Apr 2024 07:52:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id CCE371B02; Fri, 12 Apr 2024 13:19:44 +0300 (EEST)
Date: Fri, 12 Apr 2024 13:19:44 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	David Thompson <davthompson@nvidia.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 0/4] gpiolib: acpi: Use con_id in
 acpi_dev_gpio_irq_get_by()
Message-ID: <20240412101944.GE112498@black.fi.intel.com>
References: <20240411172540.4122581-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240411172540.4122581-2-andriy.shevchenko@linux.intel.com>

On Thu, Apr 11, 2024 at 08:22:28PM +0300, Andy Shevchenko wrote:
> Use con_id instead of property in the acpi_dev_gpio_irq_get_by().
> It will be aligned with other GPIO library functions.
> 
> Assumed to go via my GPIO ACPI library tree follwoed by GPIO subsystem.
> 
> Andy Shevchenko (4):
>   gpiolib: acpi: Extract __acpi_find_gpio() helper
>   gpiolib: acpi: Simplify error handling in __acpi_find_gpio()
>   gpiolib: acpi: Move acpi_can_fallback_to_crs() out of
>     __acpi_find_gpio()
>   gpiolib: acpi: Pass con_id instead of property into
>     acpi_dev_gpio_irq_get_by()
> 
>  drivers/gpio/gpio-pca953x.c                   |  2 +-
>  drivers/gpio/gpiolib-acpi.c                   | 52 +++++++++++--------

For the gpiolib-acpi.c parts,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

