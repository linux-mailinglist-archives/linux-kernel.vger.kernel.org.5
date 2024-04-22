Return-Path: <linux-kernel+bounces-153263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87D18ACBA9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5525BB23932
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8E114658E;
	Mon, 22 Apr 2024 11:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i60KuCp0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AEA14601F;
	Mon, 22 Apr 2024 11:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713784110; cv=none; b=uJSA5iThLIZHc1nZsfnC8qK0fg4X7rqMwCLCINV8D2fHIAGWnD1xK7XfMSTlhqhtEGlGssYrUJEjSxN2fY2IS1OnSYyaa155dE9wtVuzC5kDebaNwy6vqX2zUVoCoPrpB+6xEy9eFeXUIdRoZzbCChmDt/iJSyCMDkiboJWsBGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713784110; c=relaxed/simple;
	bh=C35p8Bi3L4rFjq1HGwUAjXWsznXGjDENBX3u47Iejwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trU6WCBluJTUIKSrh6t8E8I4yHu98+/ToFMHf0cQIadnit+Wa2Qn1mwVNQ/7mRIlVc53J6a/XNpuCBQBKfGrZW2cJ6a5RB8LGW9jfRB+cxu5Zv8zQ+llYrJ/6rGuMMHwG1Ym0efGq21xoGl3gyhCqKGNs1x1xv0CDQ611eDlaPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i60KuCp0; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713784110; x=1745320110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C35p8Bi3L4rFjq1HGwUAjXWsznXGjDENBX3u47Iejwc=;
  b=i60KuCp0h9P8CwRHVD58aq7hzQ3uPrYLyviw/RBKYuP3bwh3gmVsaL3z
   rT6HoYaOL0VjDfxkVQatVyCntRZe2nRTUBHs5cEFORvkkFKkjBqAcdQfG
   S5paQzGxOE3ocIglf9Z0tUPzaZh3p3mQ7bxivOtKix1Xyg3crDart5oE/
   SKPC5gy5mfudwAQle5Mrrde51DEbUwlVhlWRsWWjyKA/SxSwxAr5XmRIW
   FrYcNXzpB+jHbWSiGtrp8sY9PdyQSNAVaHqvHGFGO/+FI2HzdPmJEaBK9
   PGctVEqeONgwFT4C2uwCeoqv7EQISp8iNVZyeSoJ3kGU6tfK6v1J/K7do
   g==;
X-CSE-ConnectionGUID: xJt/Xa7+R9+643VhwnLGUg==
X-CSE-MsgGUID: 57RCdT8FScKVAvPB6/W60g==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="9429224"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="9429224"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 04:08:29 -0700
X-CSE-ConnectionGUID: aLeef+0eSKOQQewmlNT99A==
X-CSE-MsgGUID: rrtoQdEOR+OLcenHfDdLVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="24062044"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 04:08:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ryrX5-00000001d2A-1cn9;
	Mon, 22 Apr 2024 14:08:23 +0300
Date: Mon, 22 Apr 2024 14:08:23 +0300
From: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
To: "Colberg, Peter" <peter.colberg@intel.com>
Cc: "Xu, Yilun" <yilun.xu@intel.com>,
	"linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
	"mdf@kernel.org" <mdf@kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"Wu, Hao" <hao.wu@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"russ.weight@linux.dev" <russ.weight@linux.dev>,
	"Pagani, Marco" <marpagan@redhat.com>, "Rix, Tom" <trix@redhat.com>,
	"matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH RESEND] fpga: dfl: omit unneeded casts of u64 values for
 dev_dbg()
Message-ID: <ZiZFJ3Wg153P4212@smile.fi.intel.com>
References: <20240329000429.7493-1-peter.colberg@intel.com>
 <Zgt7fA/Jfks/iKYi@yilunxu-OptiPlex-7050>
 <61cf643fda9b983b8a78b9f66c46290becf4f537.camel@intel.com>
 <ZiJwe1hgizRkWcdo@smile.fi.intel.com>
 <ea0bb8be541a812ebc037da0765154d10c212878.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea0bb8be541a812ebc037da0765154d10c212878.camel@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 19, 2024 at 07:19:26PM +0000, Colberg, Peter wrote:
> On Fri, 2024-04-19 at 16:24 +0300, andriy.shevchenko@linux.intel.com
> wrote:
> > > On Thu, Apr 18, 2024 at 09:30:48PM +0000, Colberg, Peter wrote:
> > > > > On Tue, 2024-04-02 at 11:29 +0800, Xu Yilun wrote:
> > > > > > > On Thu, Mar 28, 2024 at 08:04:29PM -0400, Peter Colberg wrote:

..

> > > > > $ rg --sort=path -c dev_dbg drivers/fpga/
> > > 
> > > Side Q: is 'rg' an alias to `git grep`?
> > > 
> 
> No, ripgrep; thanks for the hint to prefer `git grep` going forward.

You're welcome!

P.S. The motivation to ask is to point out that `git grep` does it much much
faster as it goes via index, it's unlikely external tools use libgit2 or
similar approaches when they are run in the Git repo. Nevertheless, I am always
curious about such tools and open to learn :-)

-- 
With Best Regards,
Andy Shevchenko



