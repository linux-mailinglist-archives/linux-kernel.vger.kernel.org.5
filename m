Return-Path: <linux-kernel+bounces-142954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6233D8A3279
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBAD286401
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA701482F1;
	Fri, 12 Apr 2024 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z/D3XQHs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E28C1474B7;
	Fri, 12 Apr 2024 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712935806; cv=none; b=tFxtGXUdL8nDzKRDlGgD49u8OhkJSoMEu7qz2QF308y6tf6QfNgrl4mle7eSBf1vah3/6kk2Se/bGzaIvT76chdGRC6Z5WN6dYV+44NWGI+wJhS8D0M6xZk3m6lqGf2Oih3FABeK6y93yF3He6UpawWmW3l0rpYv/b6O4CxkpB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712935806; c=relaxed/simple;
	bh=qRnR4KLIrbv9fj/IcwwaawmY0UtF7Li2NM5sPKlO3s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKIzmRhDtMo1D8KMneVV46qyCarezKTyO6H/GP3eDpEOwv/CHRZaOnDEr0Alun7GjvLZx+E+0OQrFDT7EXqmHxmBh2UDJDVojF2WA3UDYkvQQlH2sRexWjJz1fcZP8UC1SIRSLudmkOUqj39ZTt5tBVFuPhkEGLPvL3o9gMMH0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z/D3XQHs; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712935805; x=1744471805;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qRnR4KLIrbv9fj/IcwwaawmY0UtF7Li2NM5sPKlO3s4=;
  b=Z/D3XQHsXMSvbW6xC8nzIs5LJWLoaDJ2hwPt4lvEFQKLgXfyq0NTyHk1
   Q15LsmemegNv64KA6Yv0XOs/YOOdLf+5lLE3mhk9757AgdV59emQyt3kb
   P6DFKDy/Kh01YS/BHgXTGaJZaBqAjH0mziNFmAG6PJ7aYjofgUhxUxvtp
   mV6pF0TwTU5E3pZPd9LuHGdA2v/wMPZQ7fXwwFykQonyOCWYPI34X+0PL
   BOt4UWKkaEGyY4gpPKmGmk7fz8+s8rdoeYWd12rbk+7XljAElFVCHA/k2
   VoMQur7z1DoDTqPu4K+wAcQmGiPZi0Z4FBKv9FpE2IALp9kCOY+TObnbZ
   A==;
X-CSE-ConnectionGUID: sWGZaWXjQKC7UFvFZpCwCQ==
X-CSE-MsgGUID: 1Sk3FC9KSrisB1jHsyTr1w==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="8252867"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="8252867"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 08:30:04 -0700
X-CSE-ConnectionGUID: n0XM1hcPTQeRQ2VQqAewOA==
X-CSE-MsgGUID: o/crIzWBQ3CKnR++AL8cvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="25942422"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 08:30:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rvIqi-00000003glk-3eXO;
	Fri, 12 Apr 2024 18:29:56 +0300
Date: Fri, 12 Apr 2024 18:29:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guanbing Huang <albanhuang0@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
	linux-acpi@vger.kernel.org, tony@atomide.com,
	john.ogness@linutronix.de, yangyicong@hisilicon.com,
	jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, lvjianmin@loongson.cn,
	albanhuang@tencent.com, tombinfan@tencent.com
Subject: Re: [PATCH v7 1/3] PNP: Add dev_is_pnp() macro
Message-ID: <ZhlTdPNuD_IayWlw@smile.fi.intel.com>
References: <cover.1712890897.git.albanhuang@tencent.com>
 <41d35ec4ff287ad6ab4fe7360fc80fb604a12958.1712890897.git.albanhuang@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41d35ec4ff287ad6ab4fe7360fc80fb604a12958.1712890897.git.albanhuang@tencent.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 12, 2024 at 11:24:12AM +0800, Guanbing Huang wrote:

..

> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I haven't given this tag _explicitly_ as it's a new code and I answered in
the previous email that I will give one for the new version.

..

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404100523.b06UvPSB-lkp@intel.com/

No, the new feature can't be reported.

..

Please, try again.

-- 
With Best Regards,
Andy Shevchenko



