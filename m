Return-Path: <linux-kernel+bounces-59411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C555C84F683
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649671F23D29
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C6D65BC6;
	Fri,  9 Feb 2024 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NH+/2XYT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD58657B5;
	Fri,  9 Feb 2024 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707487636; cv=none; b=n+mbV/qZHhL+jacW9a486nu8NcJMaOu696XB1SggzMs+/MmNZ02Oe7qso0gIsHSVo8D4IlkF+ShFEf/FO4IEItxlrBzgwg55xij5nHMC3vqUy5rhGPaUHgUDCKsghujcn3tpxgQUtcFinqDV6EsR3edp77H91Op5/Z3J0SjPq84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707487636; c=relaxed/simple;
	bh=UppTMuPvFgBB9f8XupQc3wIwMSfTH3V3GTIflUXlFXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TikhDKc8g9bNiCtmf6zqRlVjKASFKVAx5Cp4owmvHKlJMDZmKNIbuELg3nzxkmjSB6Je0x+8umT9H9ApYfncfU38fgkZm4QwXhOkB1kTwMGrIRnjr8Y++E2mxfnPHTXhHGi1Wyp9BV8XrfVUkBsbor4pp7iVj5bWYv9TY4BYCHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NH+/2XYT; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707487635; x=1739023635;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UppTMuPvFgBB9f8XupQc3wIwMSfTH3V3GTIflUXlFXA=;
  b=NH+/2XYTfz5K2IxQ6nWL6ztT2PxGu8CkkN81U5qrVFaw0lGIaGn+AFr5
   c8KId0oAMiz2/sk3KSXQLdDhHyr95BEZ4H5/emszgQj5q6DkSixyTj0+d
   pZS3eiWMCqgu/OK8EKu/dEln2VRpRhoLdZATwh0Z+Pn0fMXUo9ajQg9Uu
   FC+RBjOgA536xzT9S5R/Of4KZ9PSIE3zOvpvZ8m9pv1wIJUsQAc3LgS3Q
   NBh5nHAk94Y2Was1Y99Mbgt5+R/7syYBdag1KA7dIW1e++j75t8dYd0SF
   Xl+ZzZMTQRVZJMJtlmXP/x18Lu7e4fDhiBsTF/JIXLsDggREvyOpnU4Cg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="23912329"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="23912329"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 06:07:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="910717772"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="910717772"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 06:07:11 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rYRX3-00000003AQI-1FAE;
	Fri, 09 Feb 2024 16:07:09 +0200
Date: Fri, 9 Feb 2024 16:07:09 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: constify opaque pointer in gpio_device_find()
 match function
Message-ID: <ZcYxjSWahbSWQM6g@smile.fi.intel.com>
References: <20240208202704.631203-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208202704.631203-1-krzysztof.kozlowski@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 08, 2024 at 09:27:04PM +0100, Krzysztof Kozlowski wrote:
> The match function used in gpio_device_find() should not modify the
> contents of passed opaque pointer, because such modification would not
> be necessary for actual matching and it could lead to quite unreadable,
> spaghetti code.

IIRC I also asked Bart about this in his series where something similar
was used.

Good it's not only me who sees the benefits from this.
FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



