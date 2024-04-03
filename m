Return-Path: <linux-kernel+bounces-129486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 849B7896B7F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4E221C273DC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B94135405;
	Wed,  3 Apr 2024 10:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QVd4rd3B"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57F5135A55;
	Wed,  3 Apr 2024 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138626; cv=none; b=YGWprsgfc5HkAdBnODefhKMuRj8FWmn3ahwyDD0BU5PEiQqSOWn+lwopjgUOSMdNSBBskhvV6uuLItUlOpSQDURJvaeQ4RRO3eS+9lL03Y33oOmZMPQQGMvsTgbFVHI7Z7Zc2D/H9xzCny3wazfg01jqRAgH+0c/4O8iOIyuucc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138626; c=relaxed/simple;
	bh=fXRjjaGZV7ZIRS20aHDdphwu1uV0+rRzTuIeMRTW/fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxmG2ALE4dlFwR1Irq+IuCZPEI6Sic29rxncwCzHyrM8hIqaXsmjb7tbydJqwjvcQ68GkIADECaaTlmMuGn6m1UsE4QKODhYtXIe9eAnxEvKTSD+WmhrX0BfFHfW7FoL5bei5AinwQrROD+yv8j76tvMwLRBpQk+TDFkOE9mvBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QVd4rd3B; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712138625; x=1743674625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fXRjjaGZV7ZIRS20aHDdphwu1uV0+rRzTuIeMRTW/fM=;
  b=QVd4rd3BbntjlRQx0jo8+gNEHBYD6I9zJTaUBYVJXD/ljn8Wjqrebp/w
   Q17v/bi/VHSGFWmv+GPKS5jUKMk/EhUpXRxLdveTZ0n3JeRx2G6JdlCaL
   ShUDFaNLrFpf+4MlxWDiPXTCbohr2fflwiiWYhVHF6LQjXbkLeuwbKfCx
   5lHM4oO8HPmyIzgXYJNspBC+RaNIwXVs9iWJxABzSgd/kkolWyW4FrtxE
   hWPUvUQQwT/fLasLiBAtC9aSO457D6IOJRGvPvuHWskPMsKcpWX4UomGu
   yo38unl01qPCJLFTADBcKi61/lNotL5zWaaC/nh2P5atX42gvGKpcYKpj
   w==;
X-CSE-ConnectionGUID: g86CndUqQ+qvAJoSkkrr8A==
X-CSE-MsgGUID: JuLw/DfyRsu2NoJFPMLrqQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7485418"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7485418"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:03:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="915177185"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="915177185"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:03:41 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rrxT1-000000015GN-0Djh;
	Wed, 03 Apr 2024 13:03:39 +0300
Date: Wed, 3 Apr 2024 13:03:38 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-input@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 07/34] Input: stmpe-ts - mark OF related data as maybe
 unused
Message-ID: <Zg0pei7ut5lC9yVC@smile.fi.intel.com>
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-8-arnd@kernel.org>
 <Zg0kC6uYFOi-UGXl@smile.fi.intel.com>
 <614fc80a-5d2a-43a1-b8d4-48bdb2cc7dc7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <614fc80a-5d2a-43a1-b8d4-48bdb2cc7dc7@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 03, 2024 at 11:52:12AM +0200, Krzysztof Kozlowski wrote:
> On 03/04/2024 11:40, Andy Shevchenko wrote:
> > On Wed, Apr 03, 2024 at 10:06:25AM +0200, Arnd Bergmann wrote:

..

> >> -static const struct of_device_id stmpe_ts_ids[] = {
> >> +static const struct of_device_id stmpe_ts_ids[] __maybe_unused = {
> > 
> > __maybe_unused? 
> > 
> > Why not adding it into .driver as you have done in another patch in this series?
> 
> Because there is no benefit in this. This is instantiated by MFD, so the
> only thing you need is entry for module loading.

Hmm... Seems to me rather a good candidate for MODULE_ALIAS in this case. No?

-- 
With Best Regards,
Andy Shevchenko



