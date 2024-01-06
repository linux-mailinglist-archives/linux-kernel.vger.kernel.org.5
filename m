Return-Path: <linux-kernel+bounces-18617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F24826013
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 16:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6621F23CEF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 15:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A6A848E;
	Sat,  6 Jan 2024 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XJ6+nsSs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B42879EC;
	Sat,  6 Jan 2024 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704554421; x=1736090421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JaXjLa9V7CSKfBnBChZbrxw0v/a5OfTir5VslolG6pc=;
  b=XJ6+nsSst4aNoYFRh3GmLOEg1iQk8/K16R50ST2Q/EyfS70yQro5H3po
   +HBU4OjAuNyVPCzHHwFUvSg5RChOOn4vu25kFvk0esS4rqZedVojqMb8c
   8hk98pqyyykLQ3o00Y3MEoZPbqT2d4SepNH1F5KGyRCvJKPr10eizH9Pr
   Tn4t5UJ0z7HyeAfaCc3yQ0uI09LW2w/wV5gN5ENjTacAzudpWY82F4/+/
   Fbo0oG99z21g7HvgBaqcmXvvxMoo3Xt1/fPoIFoS4ApJaaRmN0PEfXw10
   sTwhzPNEfbFczdqAI6E/DQv72ANAPDBWogqSjPaBjFa0ugtjkn0bUpZhW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="464064405"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="464064405"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 07:20:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="784455554"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="784455554"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 07:20:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rM8T4-0000000BwIF-3F4d;
	Sat, 06 Jan 2024 17:20:10 +0200
Date: Sat, 6 Jan 2024 17:20:10 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: lakshmi.sowjanya.d@intel.com
Cc: tglx@linutronix.de, jstultz@google.com, giometti@enneenne.com,
	corbet@lwn.net, linux-kernel@vger.kernel.org, x86@kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, eddie.dong@intel.com,
	christopher.s.hall@intel.com, jesse.brandeburg@intel.com,
	davem@davemloft.net, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, mcoquelin.stm32@gmail.com, perex@perex.cz,
	linux-sound@vger.kernel.org, anthony.l.nguyen@intel.com,
	pandith.n@intel.com, mallikarjunappa.sangannavar@intel.com,
	thejesh.reddy.t.r@intel.com
Subject: Re: [RFC PATCH v3 00/11] Add support for Intel PPS Generator
Message-ID: <ZZlvqvYQQuse_P4E@smile.fi.intel.com>
References: <20240103115602.19044-1-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103115602.19044-1-lakshmi.sowjanya.d@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jan 03, 2024 at 05:25:51PM +0530, lakshmi.sowjanya.d@intel.com wrote:
> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> 
> The goal of the PPS(Pulse Per Second) hardware/software is to generate a
> signal from the system on a wire so that some third-party hardware can
> observe that signal and judge how close the system's time is to another
> system or piece of hardware.
> 
> Existing methods (like parallel ports) require software to flip a bit at
> just the right time to create a PPS signal. Many things can prevent
> software from doing this precisely. This (Timed I/O) method is better
> because software only "arms" the hardware in advance and then depends on
> the hardware to "fire" and flip the signal at just the right time.
> 
> To generate a PPS signal with this new hardware, the kernel wakes up
> twice a second, once for 1->0 edge and other for the 0->1 edge. It does
> this shortly (~10ms) before the actual change in the signal needs to be
> made. It computes the TSC value at which edge will happen, convert to a
> value hardware understands and program this value to Timed I/O hardware.
> The actual edge transition happens without any further action from the
> kernel.
> 
> The result here is a signal coming out of the system that is roughly
> 1,000 times more accurate than the old methods. If the system is heavily
> loaded, the difference in accuracy is larger in old methods.
> Facebook and Google are the customers that use this feature.
> 
> Application Interface:
> The API to use Timed I/O is very simple. It is enabled and disabled by
> writing a '1' or '0' value to the sysfs enable attribute associated with
> the Timed I/O PPS device. Each Timed I/O pin is represented by a PPS
> device. When enabled, a pulse-per-second(PPS) synchronized with the
> system clock is continuously produced on the Timed I/O pin, otherwise it
> is pulled low.
> 
> The Timed I/O signal on the motherboard is enabled in the BIOS setup.

At some point you should announce v1 of the series. RFC is usually being
neglected by many (busy) maintainers.

-- 
With Best Regards,
Andy Shevchenko



