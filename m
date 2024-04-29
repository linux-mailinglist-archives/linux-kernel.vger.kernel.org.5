Return-Path: <linux-kernel+bounces-161956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CC18B53BE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE951F21B05
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C22F20312;
	Mon, 29 Apr 2024 09:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dr8t6HlH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF841B809;
	Mon, 29 Apr 2024 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381383; cv=none; b=dl67EcmkT+VLWLTMPH3sIr931b54eSTKwj9iRSOY+FHNHfIAY2vb+nuURa17uMBSveV3UTlpezT51d+tMMvz3dCSDY8VYt3AfqVhl9C+X0PoLGm1WoLBaG1BIAX85yWS68z5qEFpxcPbmOlAXTJSikpUVSASX+bq+wGkqgoEqE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381383; c=relaxed/simple;
	bh=+zf5RRUnwgWXxIZ9E7blLj/P5PsrUKDHdtvY9otUWvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Na5C22WwqgQFJdLPcok3onJu/0ez8mNf2fUXKEc6nw/3qvFfQZf3LK31OJ6sB+w6EsGVIaD07nc+zNgOX2PGoNW+RvOEx/NoVPtJjAzsRT4gUuW0zUkvHfUOwG6B6gkD0PKW/RSktA1UcXgSr3BtMwmkImRoXo57Mn+WGIqzmYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dr8t6HlH; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714381382; x=1745917382;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+zf5RRUnwgWXxIZ9E7blLj/P5PsrUKDHdtvY9otUWvw=;
  b=dr8t6HlHDqVN+dCnd91k4wxukNBVxibhSt1JsSdolgfbm/NucnhrQ/FH
   bjK7H3HUp4PTRo/VkSJwzfK49NRaANCzEs4s48IQsvTUZ/TnZKi5vff4b
   h6EuIMVnpw0l9kODBXyP3FyyjXDWqfkjrq97mF3kzMKf0Q3oL/OwpGccz
   3RUDYGOlyzcmBDTmkKCgV61eJm15yvD2dS7FHMTD+XJ4cLphGG8MOOi7g
   HQQippu43QLQ6WYXUi8FP0HT1x/O1RsHYYfWqWfo4O9184LTEK8/xwef1
   NcnIE3PdZoyOFo4E3hDY74ZYseDNHE9G9qdChEiZMtFMbjKX4MIfs2NWQ
   A==;
X-CSE-ConnectionGUID: g7YTvqC8R46OXSEwgXCLAQ==
X-CSE-MsgGUID: j1/sbZW2TkKbAN37Wb24YQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="13809585"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="13809585"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 02:02:14 -0700
X-CSE-ConnectionGUID: Z5Ci1fM7T0CE/5dvxE89fA==
X-CSE-MsgGUID: /mHLFr6MRAOMrEJ8rbepDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="30706299"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 02:02:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s1Mtl-00000002GQ4-2GU7;
	Mon, 29 Apr 2024 12:02:09 +0300
Date: Mon, 29 Apr 2024 12:02:09 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Joerg Roedel <joro@8bytes.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Joerg Roedel <jroedel@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: linux-next: manual merge of the iommu tree with the pm tree
Message-ID: <Zi9iEVnhGqjxikU_@smile.fi.intel.com>
References: <20240429140727.016d5758@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429140727.016d5758@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 29, 2024 at 02:07:27PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the iommu tree got a conflict in:
> 
>   drivers/acpi/scan.c
> 
> between commit:
> 
>   e80d4122df9c ("ACPI: scan: Move misleading comment to acpi_dma_configure_id()")
> 
> from the pm tree and commit:
> 
>   f091e93306e0 ("dma-mapping: Simplify arch_setup_dma_ops()")
> 
> from the iommu tree.
> 
> I fixed it up (the latter removed the comment updated by the former, so
> I just used the latter version) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

To me it looks like the correct fix, thank you!

-- 
With Best Regards,
Andy Shevchenko



