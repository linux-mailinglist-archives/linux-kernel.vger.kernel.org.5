Return-Path: <linux-kernel+bounces-166674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 809CB8B9DFB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6155B20CCB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6DD15E1E1;
	Thu,  2 May 2024 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NGxCt7Y+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A286415B96E;
	Thu,  2 May 2024 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714665573; cv=none; b=gih2V3Y92wTmrBrEq2Vybt3SC1TE/p9+ZitKcJHbhf1JDO/YrZhHdeG+Vx5kegiu1td33V+NVUhMt9SGP7gGVbhvwl/IwLemnQUMQa2jM/MoWFoU+StJIVB9ldWrmbJzMoi28NBhg5S7Yc3qA5xWm3U01fJlHANGXpebgeeyhPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714665573; c=relaxed/simple;
	bh=iZkCcgfFg/A7LdSMSeuio7aGpWQ9dC530Mtf3dN0w0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IU3IJwaEhASA22DQ6IhDvq3ne+pR1xfGP7tRwSFg4hF8J6eAzn4/kEp3er9/XQEXtwCrm63rOI/E6EMS+kohswo8mAbWrncgKyZNZqCCDf3XhBfZnE1UhOq/mjP09C0wGG/AYyaCL8vladBbbAzPPr8wsEra5pLfneQyLnCWsOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NGxCt7Y+; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714665572; x=1746201572;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iZkCcgfFg/A7LdSMSeuio7aGpWQ9dC530Mtf3dN0w0k=;
  b=NGxCt7Y+BMhzgFzuRK7/3/usw64EcHK4QTm3s7xLG3p2Ee/ubCO3EB2e
   +E7nHfjKsne0OFjm41FY/4oyi+I3+qogAniZP66vqSp4VCkhDJxaSd9Ld
   1WF7DAddEE1Ce6tfo2QaCnvUBMtNk1Cl/shkjORWmibpm6DPXL4QdROTb
   kKUWSB+4h7FaH7vI1UxwxKS7yRYxVENxADbE5FCUl56GzkxjIcZ5m6Gle
   1uObSM14YTrOq2kXA8zZZqsSjsCg8BWFHanKki5z8NXG4HCRAbfodN9Xj
   B4n4VUAtDs9ndtfv+VKXof+CpMi0ny15Ox33IJ7n4FYvylylBP2qcObPL
   Q==;
X-CSE-ConnectionGUID: wjz5pEZcSjOA0Gy9H0vsVg==
X-CSE-MsgGUID: gC2UIQ63R2SJYzgVE30xmg==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10317329"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10317329"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 08:59:30 -0700
X-CSE-ConnectionGUID: U2IOL17GSWSimShBoHa7AQ==
X-CSE-MsgGUID: t5/sqIoHT0mApNyYf//JmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31971005"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 08:59:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s2YqD-00000003N2h-3GiS;
	Thu, 02 May 2024 18:59:25 +0300
Date: Thu, 2 May 2024 18:59:25 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <parker@finest.io>
Cc: Parker Newman <pnewman@connecttech.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 03/13] serial: 8250_exar: Kill CTI_PCI_DEVICE()
Message-ID: <ZjO4XTTDRtDUhMVq@smile.fi.intel.com>
References: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com>
 <20240502144626.2716994-4-andriy.shevchenko@linux.intel.com>
 <20240502111314.63d66b54@SWDEV2.connecttech.local>
 <ZjOxQWc1OtGWatKC@smile.fi.intel.com>
 <20240502113610.01881f3b@SWDEV2.connecttech.local>
 <ZjO0v9i0-adEM9Nq@smile.fi.intel.com>
 <20240502115439.3b104aae@SWDEV2.connecttech.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502115439.3b104aae@SWDEV2.connecttech.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 02, 2024 at 11:54:39AM -0400, Parker Newman wrote:
> On Thu, 2 May 2024 18:43:59 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, May 02, 2024 at 11:36:10AM -0400, Parker Newman wrote:
> > > On Thu, 2 May 2024 18:29:05 +0300
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Thu, May 02, 2024 at 11:13:14AM -0400, Parker Newman wrote:

..

> > > > Above I added current code of these macros, can you elaborate how it's incorrect?
> > >
> > > Sorry, you are correct. I was mixed up.
> >
> > No problem. And since you are here, can you tell me what type of EEPROM is
> > connected to the chip in your case?
> 
> Microchip AT93C46D and various other vendors equivalent parts.

Thank you!

> Let me know if you have any other questions.

Nope, just asking you to test and review the series when you have time.

-- 
With Best Regards,
Andy Shevchenko



