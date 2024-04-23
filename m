Return-Path: <linux-kernel+bounces-154616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F23E8ADE74
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B1772831A2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A25E47F64;
	Tue, 23 Apr 2024 07:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TCmTUS8r"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1091C698;
	Tue, 23 Apr 2024 07:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713858264; cv=none; b=XaRmYtH650PXhm0CLRgvAAbWdAbBCUn8IMsfLZKXb6SBPm724rGSTFP5ij5ZFrvRUEqDmyoyLXw0H3DJpyxA2Z/p3XQU2ANyflv3rpIcwM7f+O+yJwQeXkITOw7Q22RVP6SrXgZ3TaFjjiycblX4lp5rL1AFGOyUVMISMRQZZ9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713858264; c=relaxed/simple;
	bh=JTZGZF6/n1PLTGlgTbj3EOnj4s2EN+2YlvWSFQvXm0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apYGz93hnQ8Y3qTQOq/aUhtyK20xJbkvdzyNsl7aapXWTo2mcqYPqjxHJFQrPwHKbVbpqGZ37aw9/XV2qBmiaQQk8FgA9zQpppYw/DiazURrIFuJihHHu4tKlH++8fu8+6FKsLYo6xL55TQlAutg26jtHr6CrvjdCWxxr331Z0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TCmTUS8r; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713858263; x=1745394263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JTZGZF6/n1PLTGlgTbj3EOnj4s2EN+2YlvWSFQvXm0I=;
  b=TCmTUS8rBC5uPOUuPq6J5Umz6LOPXIjqb/c6sNrJpipvEYVRku2usNkL
   xXyLiPXqaKJMQU1mXBaVaIgH+VJUNRIZmKDU5BHP4uSaq9N6Th2XFoGMD
   2Yn5a/x3FfgTqv9rzPHIGqRwMVRK9W322NCd2AAogyuoA84XejIuzmm08
   HtaK1mZpT1Mq4bMikXAIBrOiOQ9rlDUfphi2S8BwjEHXKhpNRmKLJfUXg
   wh+RFFyWUlgaWBDT5ytEVAvqF9vp6tv1FbEoUDyRRJ4yJaaQ9WGWoNcFK
   vVLGHwP/NevS+KBzGuXn9Yd2V4M9+oNo+Y78PelT7FYEM9QUawCeRPqO6
   g==;
X-CSE-ConnectionGUID: 8BnXEuTLRX+9Pu7W1KA6Hg==
X-CSE-MsgGUID: X8zM3DoQTsa5DMqa86bfMQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9302929"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9302929"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 00:44:22 -0700
X-CSE-ConnectionGUID: v6rtPzSbT92u0dSUKcm7Eg==
X-CSE-MsgGUID: MJbMIjI4Tn6JrDefDets/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="47565057"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa002.fm.intel.com with ESMTP; 23 Apr 2024 00:44:18 -0700
Date: Tue, 23 Apr 2024 15:38:58 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marpagan@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Alan Tull <atull@opensource.altera.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russ Weight <russ.weight@linux.dev>, linux-fpga@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] fpga: region: add owner module and take its refcount
Message-ID: <ZidlkofF4YSj9xeW@yilunxu-OptiPlex-7050>
References: <20240419083601.77403-1-marpagan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419083601.77403-1-marpagan@redhat.com>

On Fri, Apr 19, 2024 at 10:35:59AM +0200, Marco Pagani wrote:
> The current implementation of the fpga region assumes that the low-level
> module registers a driver for the parent device and uses its owner pointer
> to take the module's refcount. This approach is problematic since it can
> lead to a null pointer dereference while attempting to get the region
> during programming if the parent device does not have a driver.
> 
> To address this problem, add a module owner pointer to the fpga_region
> struct and use it to take the module's refcount. Modify the functions for
> registering a region to take an additional owner module parameter and
> rename them to avoid conflicts. Use the old function names for helper
> macros that automatically set the module that registers the region as the
> owner. This ensures compatibility with existing low-level control modules
> and reduces the chances of registering a region without setting the owner.
> 
> Also, update the documentation to keep it consistent with the new interface
> for registering an fpga region.
> 
> Fixes: 0fa20cdfcc1f ("fpga: fpga-region: device tree control for FPGA")
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Xu Yilun <yilun.xu@intel.com>
> Reviewed-by: Russ Weight <russ.weight@linux.dev>
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next instead of v5

