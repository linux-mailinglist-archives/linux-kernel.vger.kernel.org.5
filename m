Return-Path: <linux-kernel+bounces-143095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1D28A340C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E4A31F22971
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249CE14B065;
	Fri, 12 Apr 2024 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZE5N07Ow"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEAE7E761
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712940714; cv=none; b=hXYdADg1jWZ8P+oXqOB0TMdeXKQc0xKi8m6wRRE7A/6Y7QgvZ1reolDNfKpZ6QOhXRQkudRuzH2YwM+Hr+YcTljI1ZkcuXkimkhMS+2dvXdKgcTh55+T7DFc5D1KiJH3kVkPPHbFEWMocI8+UaMyWppcDtNxX1U2404Bjv1N+gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712940714; c=relaxed/simple;
	bh=HeDnhJ82dasF87GecRL/plqbEeMWHTeF59qWmUrOuGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PtBLt0Xb3808YwDzp0ecQBZ8VpM7/bGrYd4mUbDqotfcaYugl8VwaBDkISulImMg1/OtG8DLTwRbMa/QpKuPt2BSemGsQKjK4NuUJULZnIRj3OJ4qvuwpESOn9BIOUPaj1RwlaNEFI/5r+IpKs0wkohiIFIVF9MeI0XsSNv/jow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZE5N07Ow; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712940713; x=1744476713;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=HeDnhJ82dasF87GecRL/plqbEeMWHTeF59qWmUrOuGQ=;
  b=ZE5N07OwOyTLSAxtr2OEA/ldM1F25dILTYnLENnjxhgVPUPdhHWaUhaZ
   AcUejqVtXAVKRvFJftFUgqjgSyWbd/BX5soTVKVJcIThOuXcAqDR6rPCd
   FVU4dPfItFwf+WfHE2SnqI79l40H7jhZNusE9TBbEbzD+NzrsnjgdWpMI
   owEniyBHY27axflc2uD+NIF1irOdjuCf9P/ygjnf/d7vvGOLCTL2jJmdj
   W7jTfq0D5IyasCjEjvXURogQ1fw5GrTgVT/MN4vFSj+oyjPjEur/fcJAX
   McnUwwyGzYgKGaCnzVgP1R+Zg/h8wXR+aLhQfAmwjpXdFV1VN2n/JUeQt
   A==;
X-CSE-ConnectionGUID: mmSCFws7QiyZKMPea46qIQ==
X-CSE-MsgGUID: Q/0b4UiUTt6jPdBBUxlFew==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="8573117"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="8573117"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 09:51:53 -0700
X-CSE-ConnectionGUID: r3xlsxIGQUipra3vPd4IUA==
X-CSE-MsgGUID: lXPVF5XcTNqPf8K4LQfmHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="21317430"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 09:51:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rvK7w-00000003hzk-2EsM;
	Fri, 12 Apr 2024 19:51:48 +0300
Date: Fri, 12 Apr 2024 19:51:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Raag Jadav <raag.jadav@intel.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Make dev_err_probe() silent for -ENOMEM
Message-ID: <ZhlmpPNbEMRye2wZ@smile.fi.intel.com>
References: <20240412164405.335657-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240412164405.335657-2-u.kleine-koenig@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 12, 2024 at 06:44:05PM +0200, Uwe Kleine-König wrote:
> For an out-of-memory error there should be no additional output. Adapt
> dev_err_probe() to not emit the error message when err is -ENOMEM.
> This simplifies handling errors that might among others be -ENOMEM.

..

	BUILD_BUG_ON(err == -ENOMEM);

Done!


-- 
With Best Regards,
Andy Shevchenko



