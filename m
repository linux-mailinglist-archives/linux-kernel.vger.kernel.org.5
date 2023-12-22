Return-Path: <linux-kernel+bounces-9806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7B581CBAF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB0712824D1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6ED24A1F;
	Fri, 22 Dec 2023 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IlUjt7X8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAA3241FA
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 15:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703257386; x=1734793386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z492FiLJxS2D3udrS2xL631r21KBFIzh9SxUhz0WNzQ=;
  b=IlUjt7X89gRG82nZ9EEiyosqn0I8LGKZ5+R0piYc3G3GaIuBkiqwTt8P
   gnA3Rej3zDKkD9mOshOnT5zm5F/LXrSSDGhwm7JO97O2VeCRphtN8BWeD
   aw9ZLj5Txwxzivma44XgQCVkR1SjVFk5N89bbtK3PwBf4Fqwqouyq164C
   Y2iUMlNO04TT35zCKa0sjdVwG5g5bIWtKnpJFA3PyrIUz3T1qY0MUrAxR
   07dEn/GrdqslNFeJkWYaMViACx9L7/ReRdskFxfGMrUQxxRqx00XdgYND
   zdma7K5cfhZy0ZAIGoV1B4VBVYuhlSIm6W9ThLx7scQqrvCVZCw8gHCFT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="2948794"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="2948794"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 07:03:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="895482524"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="895482524"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 07:03:03 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rGh3E-00000008BBs-2eYn;
	Fri, 22 Dec 2023 17:03:00 +0200
Date: Fri, 22 Dec 2023 17:03:00 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [resend, PATCH v1 1/1] logic_pio: Use RESOURCE_SIZE_MAX
 definition
Message-ID: <ZYWlJCFhr53eU4jX@smile.fi.intel.com>
References: <20231016132611.1201402-1-andriy.shevchenko@linux.intel.com>
 <ZVuVDBW3grRB-Cto@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVuVDBW3grRB-Cto@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Nov 20, 2023 at 07:19:08PM +0200, Andy Shevchenko wrote:
> On Mon, Oct 16, 2023 at 04:26:11PM +0300, Andy Shevchenko wrote:
> > Use a predefined limit instead of hardcoding it.
> 
> Any comments on this?

It's month passed, can this be applied if no further comments?

-- 
With Best Regards,
Andy Shevchenko



