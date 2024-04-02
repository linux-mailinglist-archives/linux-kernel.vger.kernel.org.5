Return-Path: <linux-kernel+bounces-128530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63194895C17
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C0C1C22487
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD01615B54F;
	Tue,  2 Apr 2024 18:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BuFwNfgn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CE615B14D;
	Tue,  2 Apr 2024 18:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712084329; cv=none; b=EkNhbcs99e7k++Flr6O2Dvq1X6XNQNBQgcNzBVO3l43jM5KNoztC+Oc6q32ynJGGl150OYxtok9S/IK61X7xWOYEJr2+zZQWKI5yOj16qMExccd+UX1ebzCuOia5C/85C9IHahKsMn4Tg6+hknrwcxeEe7YSsZ3G2Ij/P1dZess=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712084329; c=relaxed/simple;
	bh=pfhTEjnGoQZBXhOvCxvyf4F/kDdqOCTHbhRdXUe7DvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9Ynj0BV5leIA5UkibyJ+GZ7i27TNvKGNmK4obIzuyYdfQ/HvQygyk8YmN8rfX9TadasStaMxIm4wMN7rMCLBI7mcoxR9vFI0yVsY9mJfwZwrA8W7Xa6UcODpxmfA2q1bJMUOtwlIgf/7znfCZ6yBl5Eiyi6XvBb2JpyWbYVAQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BuFwNfgn; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712084328; x=1743620328;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pfhTEjnGoQZBXhOvCxvyf4F/kDdqOCTHbhRdXUe7DvE=;
  b=BuFwNfgnKX+LesH7SCzK4M8dndjBejME5PwZW6sUoqvaP9N+ZwrP51cD
   fjY7UznsRJoLHnaE1K+5xCnFzq0S3SGEfqlPjwwDTQkpjeeA6zFj+70xy
   1H/+LTH2/d8uAe06sHWtNyrlG0U2vG7WxgjBa/xKdpyxZiAOQpi8gcj9z
   YDGK+siy+nstjcvMXOzyD6uebJIQ4rlq6z6rF+gZYAPGBTbxY3GjxGF7C
   XyrS7mPbhYuTDu39d0sjK5HPy0ooPlDTkww3cOYBPIkjk5xaDGmiBf+WW
   VcR130pBOnv/fUJIlx5X4ZFUOYSXRK+SFmfydCQxzYnWgJVtbwKfY17Ua
   Q==;
X-CSE-ConnectionGUID: 6uCN5v8sQa2xVT9j3JS4NA==
X-CSE-MsgGUID: Ucc9FJmVQMieEGXdO5cz8g==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7179084"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="7179084"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 11:58:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="915150459"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="915150459"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 11:58:44 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rrjLH-00000000uJT-0cxb;
	Tue, 02 Apr 2024 21:58:43 +0300
Date: Tue, 2 Apr 2024 21:58:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 0/2] ACPI: LPSS: Prepare for SPI code cleanup
Message-ID: <ZgxVYnB84nyCb4FA@smile.fi.intel.com>
References: <20240402152952.3578659-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402152952.3578659-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 02, 2024 at 06:28:51PM +0300, Andy Shevchenko wrote:
> An ad-hoc cleanup followed by preparation for SPI code cleaning.
> The latter will be done in the next kernel cycle to avoid conflicts.

Thinking more about these two, it might be even possible to put them
as amendments for v6.9-rc3, but I'm fine to have them for v6.10-rc1.
Just speaking out my thoughts, whatever is better for you is good
for me.

-- 
With Best Regards,
Andy Shevchenko



