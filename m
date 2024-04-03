Return-Path: <linux-kernel+bounces-129987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F28A08972E4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3571F26E15
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA95B1494AD;
	Wed,  3 Apr 2024 14:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WK2TUBqT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2413F149017;
	Wed,  3 Apr 2024 14:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712155297; cv=none; b=o6OA/mc3MJHLEzQH4iAhD6YFBWb/eRw6tdj0NLdqrvAZJXeA4l+ovnKVGoZrmPiltvSb1FITibR5kOh7kzCErCfA4i0y5lhIvc38zwm14DLR12xCnF/2m4Laazcbcr+hyE8sBMaQVOi3g2lTO6g4wLelqUOJlNmw3dJqVgmHqKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712155297; c=relaxed/simple;
	bh=1DaGXx9siVBjJXZdLr/dlAMuD32pjEFC4WhTEPlNsNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXXmQVlxkBQ/UjeTZCskM5xIx7vTUDYJiBlCQOcncZ+iGkC20Jb5XnmCJotzHF7RV+Ntd6vV7bgz5wLB6vT2RtKDAW4evYh1MDtsLw2Zz4xC7r4I6fnWzN7ot4K07j/ytbuAIMimOSW5VW5memrWizvSFEN4bScbH200COCfgs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WK2TUBqT; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712155296; x=1743691296;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1DaGXx9siVBjJXZdLr/dlAMuD32pjEFC4WhTEPlNsNk=;
  b=WK2TUBqT93dW5AMLUwdaqDldgRtK5w7aLsIo3Unmk3X3bWPzfsOf9/HY
   yrmn11QH6uAsAdGYUXEkpkrRWsDa+ltL7IhIupnOBOxJaXGKCnDxxVlMq
   tyinFdFwWoOjOFGB3vQWgttm58GAzueSif/Ef8sQXp1E9B5k9mZkwBrPk
   ou/BSz/k0wB2UtUcZGeF6sLica6y+yaOpPuPL4aF/PfV3VK7C6BCLjsCt
   OqHAIilwuHUCh9J28hasZfjhDu5F+1F0rxkosvF3/+aKfHEyfU4bTl4mc
   j94FFk3KzIW/cYfPvf7k44Cv5ajwzbTEpwtqaxKDKOaAoooaB15xcVuen
   g==;
X-CSE-ConnectionGUID: X+vnOTS2Tu2NSOIECLWVXQ==
X-CSE-MsgGUID: vlHvR8d0T3yAhd4+zpSI+Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7291705"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7291705"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 07:41:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="915185310"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="915185310"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 07:41:33 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rs1nu-0000000196t-1djl;
	Wed, 03 Apr 2024 17:41:30 +0300
Date: Wed, 3 Apr 2024 17:41:30 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: (subset) [PATCH v2 0/9] spi: pxa2xx: Drop linux/spi/pxa2xx_spi.h
Message-ID: <Zg1qmlX78lQGLC3B@smile.fi.intel.com>
References: <20240327193138.2385910-1-andriy.shevchenko@linux.intel.com>
 <171167575036.187521.17547262230962160149.b4-ty@kernel.org>
 <Zg04cWhT_Dl6AUik@smile.fi.intel.com>
 <b7ac20d0-ca45-4e65-92ff-ddf84da6645a@sirena.org.uk>
 <Zg1cAHEkhIf2vpwJ@smile.fi.intel.com>
 <Zg1clCuOwkCNzSgy@smile.fi.intel.com>
 <0af775e1-f5f7-4ad4-b336-78834a9e0342@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0af775e1-f5f7-4ad4-b336-78834a9e0342@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 03, 2024 at 03:13:48PM +0100, Mark Brown wrote:
> On Wed, Apr 03, 2024 at 04:41:40PM +0300, Andy Shevchenko wrote:
> > On Wed, Apr 03, 2024 at 04:39:13PM +0300, Andy Shevchenko wrote:
> > > On Wed, Apr 03, 2024 at 02:29:38PM +0100, Mark Brown wrote:
> 
> > > > All the concerns I have with swnodes just being a more complex and less
> > > > maintainable way of doing things still stand, I'm not clear that this is
> > > > making anything better.
> 
> > > As I explained before it's not less maintainable than device tree sources.
> > > The only difference is that we don't have validation tool for in-kernel
> > > tables. And I don't see why we need that. The data describes the platforms
> > > and in the very same way may come to the driver from elsewhere.
> > > How would you validate that? It the same as we trust firmware (boot loader)
> > > or not. If we don't than how should we do at all?
> 
> I don't think we should do this at all, all I see from these changes is
> effort in reviewing them - as far as I can tell they are a solution in
> search of a problem.  DT has some support for validation of the
> formatting of the data supplied by the board and offers the potential
> for distributing the board description separately to the kernel.
> 
> > > Can you point out what the exact aspect is most significant from C language
> > > perspective that we miss after conversion? Type checking? Something else?
> 
> You're changing the code from supplying data from the board description
> via a simple C structure where the compiler offers at least some
> validation and where we can just supply directly usable values to an
> abstract data structure that's still encoded in C but has less
> validation and requires a bunch of code to parse at runtime.  Platform
> data is unsurprisingly a good solution to the problem of supplying
> platform data.

Linus was long time ago against board files. Yet, we have a few old
(kinda supported) boards left in the tree. The conversion makes the
driver be prepared for the DT conversion when it happens. From maintenance
perspective my patch reduced the code under the maintenance, which reduces
time spent by both contributors and maintainers on this.

AFAIU all what you are moaning about is type checking. Okay, I got
it, but we have a lot of other places with similar approach done,
e.g. GPIO_LOOKUP*() tables that basically gives something unconnected to the
driver without any platform data being involved and you seems to be fine with
that:

$ git log --oneline --no-merges --grep 'Mark Brown' -- arch/ | grep 'GPIO desc'

I randomly took this 366f36e2a ("ASoC: wm1250-ev1: Convert to GPIO descriptors").

Can you tell how it is different to my proposal?

> > Also note, after hiding the data structures from that file we open
> > the door for the much bigger cleanup, and I have patches already precooked
> > (need a bit of time to test, though).
> 
> Perhaps those will motivate a change, as things stand I've not seen what
> you're proposing to do here.

Okay, let me incorporate those into v3.

-- 
With Best Regards,
Andy Shevchenko



