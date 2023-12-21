Return-Path: <linux-kernel+bounces-8354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AA781B61E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59BA2881D0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E4F6EB4D;
	Thu, 21 Dec 2023 12:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JdDsJJEO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBE26E2D2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 12:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703162575; x=1734698575;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JsjK2q9P8/0shO/QCuwB1r3IfgpL3dyg/PSnKevjW4U=;
  b=JdDsJJEO+k74B6+1isJ7pMzNQoiPjq2hPd48mH41bqvKdyG0C5Mj+bSB
   neMBwXE0XZuMvleXlTulhvEwO2VWP4jtIBycbMadqOlo7MWHqDDKVyNn/
   lAHjnFpJc1r8NZOLyVPB+biJqMIeUTDRm6jcDorJh/ci0+gG2R685YcT8
   Q8bmqreI+NbnLkoAinOVsLjRvdqXSAMJ7VYRJGeZLAa/xxjsq/d1gzj0o
   NK+rUPe5k+lMygbBM44Kqt6DTdKJlajVIlL/9hLJN4OQOwQ3pqEFmCH9a
   66q8vpVHMLDHVgGHy76YEK7FsRq/AiNKYf8F011Qnc59qqM25/sIKLxHO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="427119894"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="427119894"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 04:42:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="1023845377"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="1023845377"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 04:42:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rGINt-00000007qtQ-2NrJ;
	Thu, 21 Dec 2023 14:42:41 +0200
Date: Thu, 21 Dec 2023 14:42:41 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Cc: hdegoede@redhat.com, lee@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mfd: intel-lpss: Introduce
 QUIRK_CLOCK_DIVIDER_UNITY for XPS 9530
Message-ID: <ZYQywQqwMVDkbrQj@smile.fi.intel.com>
References: <20231220073148.19402-1-alex.vinarskis@gmail.com>
 <20231220205621.8575-1-alex.vinarskis@gmail.com>
 <20231220205621.8575-3-alex.vinarskis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220205621.8575-3-alex.vinarskis@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 20, 2023 at 09:56:21PM +0100, Aleksandrs Vinarskis wrote:
> Some devices (eg. Dell XPS 9530, 2023) due to a firmware bug have a
> misconfigured clock divider, which should've been 1:1. This introduces
> quirk which conditionally re-configures the clock divider to 1:1.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> + * Some devices have misconfigured clock divider due to a firmware bug
> + * Set this to force the clock divider to 1:1 ratio

Same comment: Use periods.

-- 
With Best Regards,
Andy Shevchenko



