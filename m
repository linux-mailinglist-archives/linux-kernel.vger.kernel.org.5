Return-Path: <linux-kernel+bounces-153258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7478ACB98
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDEBC28433C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022BA14600D;
	Mon, 22 Apr 2024 11:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F+SkKYwI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2113482C1;
	Mon, 22 Apr 2024 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713783870; cv=none; b=dsYcLd1UFsTe3D42ydLOyU5TQAcG+AoalFmTJ5gyfl5rSPTCD6SlSeUiyhPUpmpu/CSE6IeBxBGvxB1+EZm3/1LuOjOfDVEgkWs3W5Va8dYQs4d9x/Geq2Qm4Osgv7DBgSFRLezhaCMWFIfldUkeXhFnCqFUfhTqziQtng9tEAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713783870; c=relaxed/simple;
	bh=0qlN9vG0iaCszP2AoQIzr57wHGNRrf1FM24tkAd7IRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqQkVjLn9OvRZmeegE+4AhTAMcxojZN7oE9+ma/jPQo3rsNrrtBVG/ZQ5k1/Vc9aa3Y5mj9AqD9wZzkG7++TEFfDhVpymr2TPMKCf+aTZAnIgBYDb4s7ZNbjsZ4KUiER8lTUrIfNK/BrBKVL76yErZfhX3U2ihbECsPnTfoiObE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F+SkKYwI; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713783869; x=1745319869;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0qlN9vG0iaCszP2AoQIzr57wHGNRrf1FM24tkAd7IRY=;
  b=F+SkKYwIp4OdQzFcK2Kl84KhbP6dihGNS5zGRq/nu77/u4xj9/D4e/cA
   dMAH3Ol1LjBMQVupH2Wjxnrqy93roWsPCcpfZkGukwuXzIHPzU2IuHuAg
   T0hDDSHA0GVnUku/oZcVL/wivK8z+v9xJHwI9XVZMtAKbKsoeJJQSRJjA
   T6DLhrJPtzTR81yxmuiaDE+YEWZ1M0N/kgj5ETDwsVrNz6aG4VCX9s8UC
   R3qruQFmTP4BMAZqbabsOMj+yWVvq7v7apeKZe/2QQXknuq4mEsr/0t5J
   /XuYcb83WwGUIyyDA1K9q7s7XYM5qt0vnKx9pRsgfbfGwHd6QDtxutbvS
   w==;
X-CSE-ConnectionGUID: +3CC1+JVQo2DJhymooNqxQ==
X-CSE-MsgGUID: qB6BQ0OwQBSrdHxMKo9IvA==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="9180365"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="9180365"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 04:04:28 -0700
X-CSE-ConnectionGUID: iOdMmI+KQuWJRUNvSvioWQ==
X-CSE-MsgGUID: 9RIS8QI/SHyq02jcEbaGsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="24582798"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 04:04:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ryrTD-00000001czC-43QQ;
	Mon, 22 Apr 2024 14:04:23 +0300
Date: Mon, 22 Apr 2024 14:04:23 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Martijn Braam <martijn@brixit.nl>
Subject: Re: [PATCH v1 1/1] iio: light: stk3310: Drop most likely fake ACPI ID
Message-ID: <ZiZEN807oywU-MAx@smile.fi.intel.com>
References: <20240415141852.853490-1-andriy.shevchenko@linux.intel.com>
 <20240420122633.79b4185b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420122633.79b4185b@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Apr 20, 2024 at 12:26:33PM +0100, Jonathan Cameron wrote:
> On Mon, 15 Apr 2024 17:18:52 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > The commit in question does not proove that ACPI ID exists.
> > Quite likely it was a cargo cult addition while doint that
> > for DT-based enumeration.  Drop most likely fake ACPI ID.
> > 
> > Googling for STK3335 gives no useful results in regard to DSDT.
> > 
> > Fixes: 677f16813a92 ("iio: light: stk3310: Add support for stk3335")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Hi Andy,
> 
> It's been there quite a while (5 years) so whilst I agree it should
> never have gone in without a known DSDT in the wild, I'm not sure we
> should remove it at this point.
> 
> Definitely not with a fixes tag as I don't want to see this picked up
> for stable and breaking some old consumer device we don't know about.
> 
> If there is a good maintenance reason to scrap these I'm in favour,
> but if it's just tidying up errors from the past that have no
> real impact then I'm not so sure.
> 
> Maybe we need a 'deprecated' marking for acpi ids that always prints
> a message telling people not to make them up.  Mind you what would that
> do beyond make us feel better?

I prefer to find the actual users by removing these IDs. It's the best approach
to limiting the presence of wrong ID in time and at the same time harvesting
the actual (ab)users of it. Warning or other "soft" approaches makes rottening
just longer and _increases_ the chance of mis-use/abuse of these fake IDs.

I understand your position as a maintainer who can be blamed by mere user in
case we are (I am) mistaken, but I consider it the least harm than by
continuing "supporting" them. Feel free to NAK this patch, but for the record
I won't like this :-)

TL;DR: I do not buy 5 / 10 / etc years in the Linux kernel as an argument,
sorry.

-- 
With Best Regards,
Andy Shevchenko



