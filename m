Return-Path: <linux-kernel+bounces-145322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C098A52AE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA2AB1C213E2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E7B757EB;
	Mon, 15 Apr 2024 14:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H+jUHZQb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE00474E3A;
	Mon, 15 Apr 2024 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713190074; cv=none; b=pdpBnCA3J9JRckS+dXyzTwNA/pmzdrLc4/G7xqT57PyC4AoKvW8X0lsM6Mm2dYnjyfPK0oPz7Ur4t5Ni/KWCWv5hSU0vbziC1Z2Wq0NqqWrwjNwul4ALYdG4/hSCER/zePN/thpG6AmGS/axzTd7nA0ol4w9mUF2VZk03viOK1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713190074; c=relaxed/simple;
	bh=iLpEtGtKkckJoSs3revBB/GVNqg1O8LlmWFpE7x+CWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDyHtd8BArPa1YWqafk9yIzaz3ByHYQQRUY4eF+LwnSKQSxG3vMgG6SEThpLE+ITTtfyLy6hKMiSLgcqYoQXHrSQUElI3wVUDfB94P1swESPCL+Y8PGWosvvCAsRLoqx31SJogyeO8sZJkT+crv4B3QRO8qU41lOGQg3nTAMrok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H+jUHZQb; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713190073; x=1744726073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iLpEtGtKkckJoSs3revBB/GVNqg1O8LlmWFpE7x+CWU=;
  b=H+jUHZQbl3oDXZSyPUdHKLRVTSlVXJ75+2YDubSQJivOOHAPRcRKXa8z
   0d/zYA3xDpBhp77mdGFXjcNGpspIS1d3ryUMKmF5M9oXJNix1Sy1xWOxH
   iwKyvZ7lc++aD86RffWy0/A0PzHEMDIqE2cGqvzYp/2Oi7tbZXYPcIqFs
   GF17NBLJ5R2wF5fA729XSbhIwj54/4E+sai+lmfE196VulXcPTxuTk+1K
   /VBskPWr3+67pT5pyHYAhtI4SQx5IocXwNF9PmyK2CYUIh86sDs8dQ5hD
   tl/aZ8A/GUJa2YLjjU4O8CchAEVzMsdnTFdNnIcF7E7XQlHibRoO81V01
   w==;
X-CSE-ConnectionGUID: EbXiUeQrTzi7WrBh0/N4pQ==
X-CSE-MsgGUID: g9+l/fhXSwCQzryM4OTlIQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8415926"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="8415926"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 07:07:53 -0700
X-CSE-ConnectionGUID: COIgAGrNS2iRVj55sVt0fA==
X-CSE-MsgGUID: M3lwDkRlS8qtp/Yw0mR9sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="22399383"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 07:07:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rwMzs-00000004Qby-13lO;
	Mon, 15 Apr 2024 17:07:48 +0300
Date: Mon, 15 Apr 2024 17:07:47 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: u.kleine-koenig@pengutronix.de, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: dwc: allow suspend/resume for 16 channels
Message-ID: <Zh00s9VX0m42jO8t@smile.fi.intel.com>
References: <20240415074051.14681-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415074051.14681-1-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 15, 2024 at 01:10:51PM +0530, Raag Jadav wrote:
> With 16 channel pwm support, we're registering two instances of pwm_chip
> with 8 channels each. We need to update PM functions to use both instances
> of pwm_chip during power state transitions.
> 
> Introduce struct dwc_pwm_drvdata and use it as driver_data, which will
> maintain both instances of pwm_chip along with dwc_pwm_info and allow us
> to use them inside suspend/resume handles.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



