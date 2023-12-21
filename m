Return-Path: <linux-kernel+bounces-8764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3FD81BBEB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B73D7285352
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE7D5820B;
	Thu, 21 Dec 2023 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TQtiZor2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346D658203;
	Thu, 21 Dec 2023 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703176043; x=1734712043;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gtx3hXaYOEPt95H7RVRIGbgG0vy7IRlF6DZK8ggX4l0=;
  b=TQtiZor2LKBVJ2PgpELmkKJmatCqql9A5FgYEIeMNFXzd1PlLJIdqXSh
   VZds9EmCvgKIAkPBjPV+jFUI19lGHeeINYkdyKAFHvQ7w40eNGELnW2qV
   Yb+fKFoEzhk3PQPANToLw3kDQyZfdYxTxHutOgRw6Ho+kI2FgoPfpetTI
   17slEMWmhBh3KEcFoa+Kj55EC9LFs1jtqQR8Uxwxs5OUJ3UDe4LtHrnph
   o7Hq+biZmVVmCZwUonVgthxJ1Uq1Qpvlixgte4lCbNe++dwYQdgjeR4Yg
   dl6Lztc1eVRtoPm2mMspjKloT/S0KP1A2Gwfq/wesJvl9NxDo2E0aCRAE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="393163071"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="393163071"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 08:27:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="726475781"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="726475781"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 08:27:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rGLtA-00000007tUq-1eGT;
	Thu, 21 Dec 2023 18:27:12 +0200
Date: Thu, 21 Dec 2023 18:27:12 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: lakshmi.sowjanya.d@intel.com
Cc: tglx@linutronix.de, jstultz@google.com, giometti@enneenne.com,
	corbet@lwn.net, linux-kernel@vger.kernel.org, x86@kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, eddie.dong@intel.com,
	christopher.s.hall@intel.com, jesse.brandeburg@intel.com,
	davem@davemloft.net, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com, perex@perex.cz,
	linux-sound@vger.kernel.org, anthony.l.nguyen@intel.com,
	pandith.n@intel.com, mallikarjunappa.sangannavar@intel.com,
	thejesh.reddy.t.r@intel.com
Subject: Re: [RFC PATCH v2 10/10] ABI: pps: Add ABI documentation for Intel
 TIO
Message-ID: <ZYRnYJ0ljsvzWLXI@smile.fi.intel.com>
References: <20231221093254.9599-1-lakshmi.sowjanya.d@intel.com>
 <20231221093254.9599-11-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221093254.9599-11-lakshmi.sowjanya.d@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 21, 2023 at 03:02:54PM +0530, lakshmi.sowjanya.d@intel.com wrote:
> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> 
> Document sysfs interface for Intel Timed I/O PPS driver

...

> +Date:		January 2024
> +KernelVersion	6.8

No way, use next one.

-- 
With Best Regards,
Andy Shevchenko



