Return-Path: <linux-kernel+bounces-18616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E66C82600F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 16:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61F61F2341A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 15:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0267F847E;
	Sat,  6 Jan 2024 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VAbKLUnU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DA8847A
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 15:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704554228; x=1736090228;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aCMF/6xtqN2tURlbU0rvh1lp9bqxI/LuS/vbawhj8ok=;
  b=VAbKLUnUJWZ/LiW82RzmVsO87R+8rtuEq+p7i+alfON+DPXLZPgJO8/N
   ho4oa51C3SwYof1Jf1/V5E/gwuSl+NpMAcHce2sHMyRbLdeoi9k7kP5QB
   cSEUUdgUdHDl56zWRE71sWAdqwA5nD+wrTa9nvVsr14gMzow7OPD4Zthi
   zLoQ3NbptzTkCQBUFhdDOU49zdK3Q6z4JfAg4Yb2iQs+aDwzlD7RS+vfM
   WoD31IAGGVOX/KHfxJ6UBsc6y/EWv+wEByV5FnmeagduQKgoBd5TXEURU
   0U7Tsh94PIPfFONFrkvMtBb9DBq01Rr7bdq6bnHENs7IIAeqDgtVIEAuB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="428846683"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="428846683"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 07:17:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="774091815"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="774091815"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 07:17:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rM8DT-0000000Bw6O-3QUU;
	Sat, 06 Jan 2024 17:04:03 +0200
Date: Sat, 6 Jan 2024 17:04:03 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: drivers/mux/adg792a.c:134:34: warning: 'adg792a_of_match'
 defined but not used
Message-ID: <ZZlr48NanPRkmkgl@smile.fi.intel.com>
References: <202312290237.ChqMrE6k-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312290237.ChqMrE6k-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Dec 29, 2023 at 02:46:30AM +0800, kernel test robot wrote:
> Hi Andy,

...

> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312290237.ChqMrE6k-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/mux/adg792a.c:134:34: warning: 'adg792a_of_match' defined but not used [-Wunused-const-variable=]
>      134 | static const struct of_device_id adg792a_of_match[] = {
>          |                                  ^~~~~~~~~~~~~~~~

of_match_ptr() should be dropped.

-- 
With Best Regards,
Andy Shevchenko



