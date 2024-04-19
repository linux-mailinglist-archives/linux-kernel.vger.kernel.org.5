Return-Path: <linux-kernel+bounces-151463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25948AAF3C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB572839A3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546F31272DC;
	Fri, 19 Apr 2024 13:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dco3AVnY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C3141C66;
	Fri, 19 Apr 2024 13:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713533058; cv=none; b=VkaljOBUZ6JIA4Q8aFPZi2EP1EwVCzDPp7QPBdhupzr5qvOtI3BpURxR/ldhj4n2bvq9xPAMap5VCjhh3JtpV83219xe01pl2s1BNVKNLXGgKDmQfw9X8/meSr3Q5FECKNCWlXf0GU4x1GfUDYoE0caIDfvecTl4VbYzZbsVFus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713533058; c=relaxed/simple;
	bh=km0hypdLXwBb2Cs3HyM86DuFLSognrk/cCgNSgOGGAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqFmvZjEs0V9dllf4Gn644XQoDyJbCsVfe4PnIqXiiJcHqY6F6jpWGWJTZ8UsdAzIwuqUKG7745x0vpC17v+GehmkQ3q44CfFqU1zLbuSeq4sZuYfox5Zt3wYE3N2zFcG/FbaEA95DWG3uO9XK2rScKEd37JvLkM1Y8uOL1Pub8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dco3AVnY; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713533057; x=1745069057;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=km0hypdLXwBb2Cs3HyM86DuFLSognrk/cCgNSgOGGAk=;
  b=Dco3AVnYJfbdTybNpRdgjAm+SVQpzsIzN/jSOxf4LgWFG2+RZ2EVF6R+
   Wni+QyNS6oaoDQWPXPifoDCz6XFG3ajkyTYAEguXVGk7mrq7z5Y5MKLdP
   /Et6+jd88jA5tS3E4pUInemWvM8JzLnMAJCn4vSSad57PJMV0MdaEe1nu
   9sx7RFntpkfAPV2PP2cNdTUoxAwoFYN8vGYQ4qhDxZAMoV1LNMHdfgWrJ
   HM04TVYlpA30sR05tmsY+JAvzhWtJ6OzKYOWFRFWqJxcTrLqHWiiNN6i0
   E23s7tC6shZ4DxYf7jt2FB75VsemC9yKVj7c3+tBgGEaVuiB2bgx0i6r7
   w==;
X-CSE-ConnectionGUID: X4RQQ0PaQ4q3GyMCq9VUzw==
X-CSE-MsgGUID: z+JhTizxQrWQzYQwROHYPA==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="19828830"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="19828830"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 06:24:16 -0700
X-CSE-ConnectionGUID: IgoxUjZ5SsuDY6ybxc0Hag==
X-CSE-MsgGUID: HD6Py7hGQIKPdZ/kHPL5lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="27954946"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 06:24:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rxoDr-00000000jCZ-1pBx;
	Fri, 19 Apr 2024 16:24:11 +0300
Date: Fri, 19 Apr 2024 16:24:11 +0300
From: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
To: "Colberg, Peter" <peter.colberg@intel.com>
Cc: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"Xu, Yilun" <yilun.xu@intel.com>,
	"linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
	"mdf@kernel.org" <mdf@kernel.org>, "Wu, Hao" <hao.wu@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"russ.weight@linux.dev" <russ.weight@linux.dev>,
	"Pagani, Marco" <marpagan@redhat.com>, "Rix, Tom" <trix@redhat.com>,
	"matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH RESEND] fpga: dfl: omit unneeded casts of u64 values for
 dev_dbg()
Message-ID: <ZiJwe1hgizRkWcdo@smile.fi.intel.com>
References: <20240329000429.7493-1-peter.colberg@intel.com>
 <Zgt7fA/Jfks/iKYi@yilunxu-OptiPlex-7050>
 <61cf643fda9b983b8a78b9f66c46290becf4f537.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61cf643fda9b983b8a78b9f66c46290becf4f537.camel@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 18, 2024 at 09:30:48PM +0000, Colberg, Peter wrote:
> On Tue, 2024-04-02 at 11:29 +0800, Xu Yilun wrote:
> > On Thu, Mar 28, 2024 at 08:04:29PM -0400, Peter Colberg wrote:

..

> $ rg --sort=path -c dev_dbg drivers/fpga/

Side Q: is 'rg' an alias to `git grep`?

-- 
With Best Regards,
Andy Shevchenko



