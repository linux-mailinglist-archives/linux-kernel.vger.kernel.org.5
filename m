Return-Path: <linux-kernel+bounces-160192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 917258B3A67
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF1228B586
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B15148836;
	Fri, 26 Apr 2024 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j/b5mzhv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DAD1FC4;
	Fri, 26 Apr 2024 14:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714143067; cv=none; b=ZPbiehThsFfnQIyoSnQfjrm5ctUsXByQSRcVNM6WbiORQasscs0TkrH/LP8bSAMWQlRY+eZilQ7CkDqye3ZcKuMcjCA9AJa1iwV8gcEsn7/GaL0LFp8JaDVBfR+HwVrHFzovbuBIPHW4gskFqUwvDV2AbByBX5LjdUuKpra8cA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714143067; c=relaxed/simple;
	bh=7+nFJRsjAtttF2SdNbZzjmYG+WL55LusdRkThvinTMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHANx7mw8Mvey+HWD9FlL+OiUdrq3lUgEvvoWdFAm6hsb6h6EfnJ5ox+AS/MeXqy79/UQB0ieeCnQMMlZC7U81Eb9Yi3eKLCGRNmgJpYk8EvGMS0oA6e6YLoZak/NmQipCR1+CW3feiggcHTQWE9ELK3fNoCPsTQYHtt0mHBF/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j/b5mzhv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714143067; x=1745679067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7+nFJRsjAtttF2SdNbZzjmYG+WL55LusdRkThvinTMU=;
  b=j/b5mzhvH2LwDYbfKmoL+f0MbAISxIE1cGuwELBjhE5twqsEVCoeWm3X
   LLK3vLr8udL5kC2cYP69yeIZpzn6WPJXZl6PLx37NCenoxmOvjOS+fLK9
   SWlHreeDJnswsWRXYH1UuftYd/RydX6waLfQQNd8jcrBJIFSHhmBgEuKN
   3fr+3srrKK3ZyqjCUyjDZNRDBddGgXCaQtdIyzwckMFm0v4X4MyGRk3qN
   BlT7Mojmfs9EuLivvFk6vZ44R1EOaFvs80rtlJil+c9qVZREofX01nmzs
   4svM38HgOCJDHdi8ih9+IxIzlgs1ptqSbvKM7+Bff89+ZcvHt+s6k1SQu
   w==;
X-CSE-ConnectionGUID: QfXgIpKLQ+yFUBOFeD+M5g==
X-CSE-MsgGUID: RowRrdMHSyeLVMIL59F9AA==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="13711116"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="13711116"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 07:51:06 -0700
X-CSE-ConnectionGUID: +gsZFItORS6LcGbEKS6l8Q==
X-CSE-MsgGUID: MEw8FoUgQvyCvjtVvtaw0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="30074296"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 07:51:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s0Muj-00000001LoB-00Z2;
	Fri, 26 Apr 2024 17:51:01 +0300
Date: Fri, 26 Apr 2024 17:51:00 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tty tree with the mm tree
Message-ID: <Ziu_VIoE9L5iP9Pr@smile.fi.intel.com>
References: <20240426145540.1593f8f4@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426145540.1593f8f4@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 26, 2024 at 02:55:40PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the tty tree got conflicts in:
> 
>   include/linux/kfifo.h
>   lib/kfifo.c
> 
> between commit:
> 
>   a8372870a0ae ("kfifo: don't use "proxy" headers")
> 
> from the mm-nonmm-unstable branch of the mm tree and commit:
> 
>   d52b761e4b1a ("kfifo: add kfifo_dma_out_prepare_mapped()")
> 
> from the tty tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

This is correct fix from my point of view, thank you!

-- 
With Best Regards,
Andy Shevchenko



