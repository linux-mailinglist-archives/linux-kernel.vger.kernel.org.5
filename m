Return-Path: <linux-kernel+bounces-8753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D4281BBCF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08A62B2385A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12865821E;
	Thu, 21 Dec 2023 16:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e5modP1d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7843755E56;
	Thu, 21 Dec 2023 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703175604; x=1734711604;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K6yqbQOo9UVnGtwfPiwWh5xvsQj2AGp4vZ2i4oaQBQI=;
  b=e5modP1dSMZIqoTkpL6FVM1AodA+O9xuBe+N2nYqXQsacSC6KXHQmufM
   dqv+6Ziseog2N3Rqrwf+Rdh8O0CvXt4eyCfZ1ZkpLvQU8i8URPKnfNbv4
   Jv7XQEOBjAUttoAA6zyUd4m5NihjxPrAW7ZGwT6Bd2bujiGy8oExlo4To
   XKqfrBJG7ArpVeOQuPENLsR6JqdYYaQH8HTcAr/SLfsZH7rrRssgtCXOx
   Lye3Sc8NGY0cVUquUDtRgRLBIZTYd7xmZQIWZVb+9+LDav8b+huVOverk
   uZFmySQRFq4BE5gPMoqABT/zu8sMsOVLXOF44LxtkHJWqy1AAN+x/HsFY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="2829579"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="2829579"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 08:20:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="805653521"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="805653521"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 08:19:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rGLm4-00000007tP3-3oVk;
	Thu, 21 Dec 2023 18:19:52 +0200
Date: Thu, 21 Dec 2023 18:19:52 +0200
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
Subject: Re: [RFC PATCH v2 04/10] igc: remove convert_art_to_tsc()
Message-ID: <ZYRlqAzwTapf7ZGd@smile.fi.intel.com>
References: <20231221093254.9599-1-lakshmi.sowjanya.d@intel.com>
 <20231221093254.9599-5-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221093254.9599-5-lakshmi.sowjanya.d@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 21, 2023 at 03:02:48PM +0530, lakshmi.sowjanya.d@intel.com wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Remove convert_art_to_tsc() function call, Pass system clock cycles and
> clocksource ID as input to get_device_system_crosststamp().

...

> +	return (struct system_counterval_t) {
> +		.cs_id    = CSID_X86_ART,
> +		.cycles    = tstamp,
> +		.nsecs    = true,

Either you should remove the extra spaces before '=' or replace them by TAB(s).

> +	};

-- 
With Best Regards,
Andy Shevchenko



