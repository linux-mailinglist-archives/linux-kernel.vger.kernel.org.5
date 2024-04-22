Return-Path: <linux-kernel+bounces-153260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEE08ACBA1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46DE1B21FC3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1572146582;
	Mon, 22 Apr 2024 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SIAvEHjV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EEE145FF9;
	Mon, 22 Apr 2024 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713783983; cv=none; b=ivQ+fqHB/P8UbUYjZgY+4UoKQ6hIfUF/6mpm/yjQzLUMy5WgFdzbqyzebxE4eWmxSYfASQfCGjokaVIAcUREqvhQaj6Kp7C1guwDAPc5ts2Hmoe8Q/wBXujyx/0zmeeNefio8dhfZaVWWtikm4kJCxoXCExacSW/qnifYlSdo3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713783983; c=relaxed/simple;
	bh=h2UNfTlm5sz5kec3CRBEuMh4kmLjtFE2D+wbJYs4t2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+hibmK3BnvsnOF4SEgU/Qqw+rgp6DycAOyTmSH6lbxoteu3b030jIa+r3g16gLGYoBojf2Tt9RrShtwcH+qrJ7LH6EGSGhZiboEwTZci1NRA7B9UFgw2aqllY+cGlRyZ9m1gXmOvHkoKuctcBl6E9hcFS68MNWXrgHSgj6FJ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SIAvEHjV; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713783981; x=1745319981;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h2UNfTlm5sz5kec3CRBEuMh4kmLjtFE2D+wbJYs4t2Y=;
  b=SIAvEHjV1fqXf7aXZX9egc024Uxsk90X8LmiTj1q6aqNTXjMBDBRXvXL
   +xsPxq+U+yfzAIkYvTA0c76UbgXsMxXOq9aKl+1zSADL7i1pnLdtDFLX6
   s7YEy84uBsO5C9+euRwwKI5xbeVyTUgsko5lDAGS8KrEkbc13w1xsqGlI
   77pEdxG7hjEYUBfMNYwqQ6M4jZDeOnzPgr6bEcViYSUmgQKh4YjZ76hX8
   snIH9dgXxXvfMU51s3fETyw+/lh+nc52jsHuJOHIAnILBb8+eTVRISRKH
   Zvpv/ATYq5oMI1ldbROMdREP67Y6nzCepqDLs0affj03YBQi2eBHANCm2
   w==;
X-CSE-ConnectionGUID: GeAHKSQ2RkyHtnrnCxQjdw==
X-CSE-MsgGUID: Yml9/MmsT3KlnZitnIXL3Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="9232163"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="9232163"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 04:06:21 -0700
X-CSE-ConnectionGUID: rWc1Z1CoQOat4ZePb6tnVw==
X-CSE-MsgGUID: Ff1bHfyQS9qZ21ybVbQkHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="55193730"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 04:06:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ryrV2-00000001d0h-2TIL;
	Mon, 22 Apr 2024 14:06:16 +0300
Date: Mon, 22 Apr 2024 14:06:16 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Martijn Braam <martijn@brixit.nl>
Subject: Re: [PATCH v1 1/1] iio: light: stk3310: Drop most likely fake ACPI ID
Message-ID: <ZiZEqDCqc01Cx3oq@smile.fi.intel.com>
References: <20240415141852.853490-1-andriy.shevchenko@linux.intel.com>
 <20240420122633.79b4185b@jic23-huawei>
 <ZiZEN807oywU-MAx@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiZEN807oywU-MAx@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 22, 2024 at 02:04:23PM +0300, Andy Shevchenko wrote:
> On Sat, Apr 20, 2024 at 12:26:33PM +0100, Jonathan Cameron wrote:
> > On Mon, 15 Apr 2024 17:18:52 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > 
> > > The commit in question does not proove that ACPI ID exists.
> > > Quite likely it was a cargo cult addition while doint that
> > > for DT-based enumeration.  Drop most likely fake ACPI ID.
> > > 
> > > Googling for STK3335 gives no useful results in regard to DSDT.
> > > 
> > > Fixes: 677f16813a92 ("iio: light: stk3310: Add support for stk3335")
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Hi Andy,
> > 
> > It's been there quite a while (5 years) so whilst I agree it should
> > never have gone in without a known DSDT in the wild, I'm not sure we
> > should remove it at this point.
> > 
> > Definitely not with a fixes tag as I don't want to see this picked up
> > for stable and breaking some old consumer device we don't know about.
> > 
> > If there is a good maintenance reason to scrap these I'm in favour,
> > but if it's just tidying up errors from the past that have no
> > real impact then I'm not so sure.
> > 
> > Maybe we need a 'deprecated' marking for acpi ids that always prints
> > a message telling people not to make them up.  Mind you what would that
> > do beyond make us feel better?
> 
> I prefer to find the actual users by removing these IDs. It's the best approach
> to limiting the presence of wrong ID in time and at the same time harvesting
> the actual (ab)users of it. Warning or other "soft" approaches makes rottening
> just longer and _increases_ the chance of mis-use/abuse of these fake IDs.
> 
> I understand your position as a maintainer who can be blamed by mere user in
> case we are (I am) mistaken, but I consider it the least harm than by
> continuing "supporting" them. Feel free to NAK this patch, but for the record
> I won't like this :-)
> 
> TL;DR: I do not buy 5 / 10 / etc years in the Linux kernel as an argument,
> sorry.

P.S>
What I may agree on is to drop Fixes tag.

-- 
With Best Regards,
Andy Shevchenko



