Return-Path: <linux-kernel+bounces-131631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEA2898A41
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F41491F2D57C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480A94E1CF;
	Thu,  4 Apr 2024 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VeQHltvX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D045D11CB8;
	Thu,  4 Apr 2024 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712241290; cv=none; b=QTZsRxc+fbGGqgBuJUfnIOKd9Ggp5ZChLVhDYtnECgFGefYEB6+cJhhd3I/KzjyELuqRddycznBXIQvW7MhoyNN3+QzW2NuW+URYVHj2hvb4uOcK0OOPUX7hnEYYB1J63cIWAtVvnhDix5+Adj2ch9XRMUpExE5GNyInkWPYFpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712241290; c=relaxed/simple;
	bh=DorkrpbGkmH6Hd/xxbpsPwzp65GkMHv55jrfPPfG+cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOGgKDKdM9Y5Vv3fPJb5kOvX1zHny9dsenomW2q3XLjaBG6FmsaT3XCOU5f4CK0GHN5FePwu0yOkYbcrOu33mrbE6AClO9H5o/LS+sb8mfT0kM9hbDJMjeRKZ3LqikaIfj70sk/P5CvIy8SXFmfsdGLU1dtuerk5oxpL1pUc1HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VeQHltvX; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712241289; x=1743777289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DorkrpbGkmH6Hd/xxbpsPwzp65GkMHv55jrfPPfG+cE=;
  b=VeQHltvXn3jQ2Qdek/Mmg7lF4tdZlxJjkeCTR/bngPix4o6/69zs5SEI
   1fq9fUA2I8hAsukroct7e4bNfRGiYKRUoYEhD4kxKNJMvCZA/t+kt3dNm
   3ZkD9VdN5IrU9+gmk2oaeYRN3P8f6jGMUZ8LpQolc1Yw/4NSyBKWjk1pq
   1bb/3/IxFaYv9gd5c/6z30dzQRntXrZnrrd9GEEPWDxLLkixdpOb62Jub
   +AHJ7ZqbypVomaI1GbasCXY2IcL/RdzfAaFjJ6ZsXJMCfT+Ip+LktYvZ/
   JhPfTsJxUPh53b+AZiVZWgyTRrnBPM+Te3TfElVd/dSDOSdXaonhocX1l
   g==;
X-CSE-ConnectionGUID: D32PXaEwT32mtlyVJmAILw==
X-CSE-MsgGUID: AUieEUCKTK2WxujumXLBjg==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7689418"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7689418"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 07:34:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="915219989"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="915219989"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 07:34:46 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rsOAt-00000001U28-14lJ;
	Thu, 04 Apr 2024 17:34:43 +0300
Date: Thu, 4 Apr 2024 17:34:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tony Lindgren <tony@atomide.com>
Cc: kernel test robot <oliver.sang@intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable <stable@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [linus:master] [serial]  43066e3222:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <Zg66gtOQ01bOD5q3@smile.fi.intel.com>
References: <202404031607.2e92eebe-lkp@intel.com>
 <Zg1hBvRAxifo50sf@smile.fi.intel.com>
 <20240404065415.GO5132@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404065415.GO5132@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 04, 2024 at 09:54:15AM +0300, Tony Lindgren wrote:
> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [240403 14:00]:
> > Probably we need to check if the port is still open...
> > 
> > P.S. AFAIU the state / xmit is invalid pointer or so.
> > 
> > Culprit line:	serial_out(up, UART_TX, xmit->buf[xmit->tail]);
> 
> Maybe we can set UPF_DEAD a bit earlier as below?

We should do this under port_mutex. Otherwise we replace one race by another.

-- 
With Best Regards,
Andy Shevchenko



