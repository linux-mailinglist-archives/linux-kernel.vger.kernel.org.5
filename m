Return-Path: <linux-kernel+bounces-155333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EA48AE901
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821F71F22B4D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9C013BADE;
	Tue, 23 Apr 2024 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cTVbsEpU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E716138499;
	Tue, 23 Apr 2024 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880912; cv=none; b=kXTMx9hk0dAuZludroeeFC/38U398BmkWPSas7DWZczwsbu4idG6jNMpX6LA8skB2Jilwtb+lL1B2eazB0KoqaW0L3n49Mz7eL6bn+ypW/xVQq6Bcvw6+8Tu5KStJPXuaqKUCFj1r/tXjNfcNX3+YkJ/22yr5jCHaZcHD3zo+hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880912; c=relaxed/simple;
	bh=jurAq+qLuaIebEVYfXbuv3sd0JBoXVXd0/D82SINrxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3m9ZqiCNznpaOHkpc4jOZ0J5q1JbSPZvwhNmKaDsiLSC/aMva7H+M2QvOzpU1GA6eqweHs42PGckg5TasBhrCBKXOfvzM08MXUB/TwnqF1YWEpImIYYF491v2O0w7HWoYyD/Gk2xyWJ45tDM2tgAOU9R8aQWk71SaHynP49ZuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cTVbsEpU; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713880911; x=1745416911;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jurAq+qLuaIebEVYfXbuv3sd0JBoXVXd0/D82SINrxM=;
  b=cTVbsEpU/HjSSTvHVOk+b+Jig1lvORwzMD2CbtG4BKUjJIa9UmUUsfJt
   id2rnqfU/1u8Ff8ihEu1OsVoGRiG9eURCmP3EgOvNrElLtVl0jeLZqGcy
   eVVedvvbskdQ1vuXUJxHZw5Fa5KJ79m3JaePDuaEKY4Edb0JGf5TzywgH
   KKLWlvDbE3DiPjXoq3r4ywihprCXKl74UP+Xb70ugyn9+0Xiu7Qp2aVqx
   Talgkj1UOGo5S+zHmulkZnpJJjXrZ4/1+A7pH8bwRyR5qHm2dTvUI5i/N
   N8ZuUZAKtd/8gLJh+uB34/Sx6T10PXUjCwdqqa69GjDgkzXAvUMq7ezhU
   g==;
X-CSE-ConnectionGUID: 1kAMYkkzTy+XPs+aQh0xxw==
X-CSE-MsgGUID: YKqLhQD8TSueW5oGw6t1ow==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9629406"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9629406"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 07:01:50 -0700
X-CSE-ConnectionGUID: gCqOyLsVT6OWoOWf9k9piQ==
X-CSE-MsgGUID: PRNoTFdfQQ27b3ts/Vcb6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="28835722"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 07:01:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzGiP-00000000M24-3WsT;
	Tue, 23 Apr 2024 17:01:45 +0300
Date: Tue, 23 Apr 2024 17:01:45 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/1] serial: 8250_pnp: Simplify "line" related code
Message-ID: <Zie_SWPwpbsdU4mK@smile.fi.intel.com>
References: <20240423134930.67033-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423134930.67033-1-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 23, 2024 at 04:49:30PM +0300, Ilpo Järvinen wrote:
> 8250_pnp sets drvdata to line + 1 if the probe is successful. The users
> of drvdata are in remove, suspend and resume callbacks, none of which
> will be called if probe failed. The line acquired from drvdata can
> never be zero in those functions and the checks for that can be
> removed.
> 
> Eliminate also +/-1 step because all users of line subtract 1 from the
> value.

Also noticed that, looks like a leftover from the legacy PM callbacks that
might be called without probe being succeeded.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



