Return-Path: <linux-kernel+bounces-142882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E18078A319C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3FF1C2318E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A071474D1;
	Fri, 12 Apr 2024 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oEPUvAYY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC907146D71
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712933661; cv=none; b=nK/E+2DIcdy6ONo9vFBSBCoiw/m+vokq+7rkRWKUgiP0qMtJNhzjdzuWIVP/1c3HjWzYxLLNDpZMPIQIPTbBHdZeOlAvfZW0+dC1txjoOxjuqZJCAmCdazTIUjGfLHC6EG2RGnh06dzuGDIU5CYwJh3yK0PLrGKtNR8TiSgwPWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712933661; c=relaxed/simple;
	bh=afqeI7wnK4mu5ocuG6kYCfL1dWMMCoS8i0jeYsFz9Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxC38se7MBahBRoejAUJ4q691mt8fNYexrOvh+rBb7Nw7MxZ0WdMGRTs/m0CPTdQusuK2MVfn9UUXgmtAPptVm8KgsJQcoXlbiqcKjuqOW8xmpH5YOLlvWPC+tENVQQto0mELR8vk8vI3KwtStfrFPRzYTUPu6Fw+kf9zl+u4lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oEPUvAYY; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712933660; x=1744469660;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=afqeI7wnK4mu5ocuG6kYCfL1dWMMCoS8i0jeYsFz9Us=;
  b=oEPUvAYYIg43BVe+qBahdtYRmZ6cXpa6Ej/hrYbkt5kY0a+kNyXOgJAp
   7Tou2339qi8gyt7ty3ZUC0TGge5dAxDfH9y5ouwuP3LYjRetPqJePS/r9
   uwOPENjHxxcIxNO0l4/r77I6Pdym8Le5Up4VyQiJaGKdSSCObMRU/E+cR
   kx+2hn+8zJ2afwcEOKbkgGBsGUQjZ+ktp6H3FeTA+9mKMZM4yGWJ2COVI
   c+4YQfa7lXNugZXXE+BBlBoMCX3I4o/qxacOAlB9kEY6eTYS0bQRCzkqF
   4l0YmiXZ1XY7o7YKSYLPEB82Un6zR1eJHGmVIPE88Y5gr2KcpDvLK3QKb
   Q==;
X-CSE-ConnectionGUID: cruOWevMRuSV0MMJvjq7cQ==
X-CSE-MsgGUID: fbFdY5BARmWxRfilBpA/ZQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="8249803"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="8249803"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 07:54:19 -0700
X-CSE-ConnectionGUID: OfRelUKURkSR1jEyQC/4RA==
X-CSE-MsgGUID: VI1JjWtxTNOCSRjm6b0tmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="21238609"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 07:54:15 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rvHqJ-00000003eP8-0aUV;
	Fri, 12 Apr 2024 17:25:27 +0300
Date: Fri, 12 Apr 2024 17:25:26 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kyle Meyer <kyle.meyer@hpe.com>
Cc: linux-kernel@vger.kernel.org, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	russ.anderson@hpe.com, dimitri.sivanich@hpe.com, steve.wahl@hpe.com
Subject: Re: [PATCH v2 2/2] sched/topology: Optimize topology_span_sane()
Message-ID: <ZhlEVoW6FJC6uBVE@smile.fi.intel.com>
References: <20240410213311.511470-1-kyle.meyer@hpe.com>
 <20240410213311.511470-3-kyle.meyer@hpe.com>
 <Zhe9ttm9Ppv2wT3S@smile.fi.intel.com>
 <ZhhcPwFCgxDUhndo@DESKTOP-IR8JFSN.>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhhcPwFCgxDUhndo@DESKTOP-IR8JFSN.>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 11, 2024 at 04:55:11PM -0500, Kyle Meyer wrote:
> On Thu, Apr 11, 2024 at 01:38:46PM +0300, Andy Shevchenko wrote:
> > On Wed, Apr 10, 2024 at 04:33:11PM -0500, Kyle Meyer wrote:

..

> > > Since topology_span_sane() is called inside of for_each_cpu(), each
> > > pervious CPU has already been compared against every other CPU. The
> > 
> > previous
> 
> Thank you for pointing that out. Should I send an updated version or can
> a maintainer correct my mistake?

Depends on the maintainer. I'm not the one here, don't expect answer from me.

> > > current CPU only needs to be compared against higher-numbered CPUs.

-- 
With Best Regards,
Andy Shevchenko



