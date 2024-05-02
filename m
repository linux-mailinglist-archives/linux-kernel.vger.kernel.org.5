Return-Path: <linux-kernel+bounces-166820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EA08B9FF8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4696F2811E0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF4D17167B;
	Thu,  2 May 2024 18:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VVHdByLD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01071172BC4;
	Thu,  2 May 2024 18:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714672922; cv=none; b=pQRg9pObOXT5z1TRRqVeIw5r2U6uhozmNQv/s3q+3RNMdNLaOHuOlSbw07wdLWykQyJIlpunnOsQe/JAZtFUPodOmv5OsSISbxpn9SYiwGlUGtK8HP4SyzmnDaoVLN5zzHtSXtiEMtuM5p32Ptxca5COYajm6hYmg08xa0ejWsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714672922; c=relaxed/simple;
	bh=fK6rNh5/XVxawqcuFnoZCcn6CMceXixxzj9TBw5xcps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wz7BKsX9KyswzmWHVncZopVPX06eQIcyZ8IWruSHmy+agXdhiImDkIPc8V7eHq3YvmlKYGs1qkWfFrEbmCAf0faljPimz5o1SX1z3e1K+ARVykX0RMOgJYIA8WCSgoZ9Nghr+iBH081JXpOBgTgNhEwPHvRATqh6wR3J8tr1csU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VVHdByLD; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714672921; x=1746208921;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fK6rNh5/XVxawqcuFnoZCcn6CMceXixxzj9TBw5xcps=;
  b=VVHdByLD8NQfCA69/1ierfECZ3T+NfC/5VQeC/3jB5zUyb69H+ctxYXh
   jasDHEvU17+c15QKe8FltTkyltrJdiV9D+UrU3t6v1wGuy+4/UpWc8c9d
   JVmRKvhf9TR89CUYMq+ztBmTHhOTcpVkGT0WUW8Kur97rJZ9k/BryQrfT
   8pB/MAmkepV9t58cKjHd9X7A2+oPZwoatdCwPKTSyARGJc1jyoJwHEGSk
   6MkSeAkDAcgr+w6s7MacItT0J2YYi5/3BjOxW5SGuIsRvOjqj1jYi5N15
   I+eqh8Lew4Db2fQEZ50n2UAoe++Cau/QAIewvt2GPKSb0ECkrBEQDNJOk
   A==;
X-CSE-ConnectionGUID: 6DT+PsdvS/amnhrJdyLeig==
X-CSE-MsgGUID: 3w2qxByRR46njA/ooDYdpA==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="35843501"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="35843501"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 11:01:59 -0700
X-CSE-ConnectionGUID: ALCyUXnTRta/n8RVrZdtWQ==
X-CSE-MsgGUID: VmkOh0UbSN6P1HEw+ByJNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="58089293"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 11:01:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s2akk-00000003POD-2k3S;
	Thu, 02 May 2024 21:01:54 +0300
Date: Thu, 2 May 2024 21:01:54 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Parker Newman <pnewman@connecttech.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 00/13] serial: 8250_exar: Clean up the driver
Message-ID: <ZjPVEr7D0lEf86kQ@smile.fi.intel.com>
References: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com>
 <20240502114645.4445b3da@SWDEV2.connecttech.local>
 <ZjO4vYEBzxU3fpzC@smile.fi.intel.com>
 <20240502120840.02c65f30@SWDEV2.connecttech.local>
 <ZjPL5z7ah-Qkct6l@smile.fi.intel.com>
 <20240502134949.5e780635@SWDEV2.connecttech.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502134949.5e780635@SWDEV2.connecttech.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 02, 2024 at 01:49:49PM -0400, Parker Newman wrote:
> On Thu, 2 May 2024 20:22:47 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, May 02, 2024 at 12:08:40PM -0400, Parker Newman wrote:
> > > On Thu, 2 May 2024 19:01:01 +0300
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Thu, May 02, 2024 at 11:46:45AM -0400, Parker Newman wrote:
> > > > > On Thu,  2 May 2024 17:43:54 +0300
> > > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > >
> > > > > > After a rework for CONNTECH was done, the driver may need a bit of
> > > > > > love in order to become less verbose (in terms of indentation and
> > > > > > code duplication) and hence easier to read.
> > > > > >
> > > > > > This clean up series fixes a couple of (not so critical) issues and
> > > > > > cleans up the recently added code. No functional change indented by
> > > > > > the cleaning up part.
> > > > >
> > > > > Just an FYI I submitted a patch series that fixed several of these issues but I
> > > > > think it fell through the cracks (I know everyone is very busy!).
> > > > >
> > > > > Link: https://lore.kernel.org/linux-serial/cover.1713533298.git.pnewman@connecttech.com/
> > > > >
> > > > > I believe my previous patch series is no longer required. This one fixes
> > > > > everything.
> > > >
> > > > I haven't noticed that, if it contains duplicated patches, I may replace mine
> > > > with yours if you insist.
> > > >
> > > > In any case it's better to reply there that you prefer this series to be
> > > > applied, so Greg will not pick it up.
> > > >
> > >
> > > I do not have a preference. I am fine with using yours if it is easier on
> > > the maintainers.
> >
> > Up to you, there is no issue to take your patches in case they are the same
> > (or quite similar) as mine. I can pick them up, just tell me if you want this
> > to happen with a list of the patches (as mail Message-Id).
> 
> Just use yours.

Okay, thanks!

If you are going to test, better to pay attention to the BIT() conversion patch
as Ilpo noted an issue. I believe it's easy to drop (via local git-rebase run)
or move and test separately.

-- 
With Best Regards,
Andy Shevchenko



