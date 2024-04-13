Return-Path: <linux-kernel+bounces-143543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD66B8A3AAE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13921C22A64
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25EB18EA1;
	Sat, 13 Apr 2024 03:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fc8mBwkR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FEE10A19;
	Sat, 13 Apr 2024 03:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712979365; cv=none; b=UWTNM4cal3ZmFq007AAjqpvGGfvbQr1cYT+6UH1doQQhciEiqHXuBGlbJChQ7I7SRLWxvxgP6WdG7d0UnM70YF7qF00ddtXAT4/mLwh6Zj/hHtl9RWTLqZjSbK/wawk2JIfelpmxKB7GH4HKhi5kgLQisDv1W3uhYXK00lUh0iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712979365; c=relaxed/simple;
	bh=vVsY1U7XLodsMzLioPoPKonjThgbBUdmWS00CWigBdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTzHEEht1XnLIHJjNf232LJEekK5i8adIeLZpX5SXlrOeEmhViz/OVE6CjU/Qph3sD3WTLPxaLsOigWIbae9TmhHyvKdJdWQTnUH368G8Tb10E8X2p3kCgp5PkuUSwf46JTeB4USSqMIItW12VDOLAd5hTAG0wOlE0fn981odaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fc8mBwkR; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712979363; x=1744515363;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vVsY1U7XLodsMzLioPoPKonjThgbBUdmWS00CWigBdg=;
  b=fc8mBwkRulRNlQzPW+nkQsnLdMnyZjAADmLw4IO+YTbOFOh3U6UGkSps
   Y83mWKn0FDkQ2K+/U6yjUUD04GNptHInx+V8q1xzD0LJO1OnpGFrhd5S9
   cNXVWbFE+qkCLz0ZHC/UjFjXB6LWTPnTqRqpgBjIC/+8VLvxubJDVSsFe
   sQqjnePDxpQzbm7pwReKP4xJKbdE1aTYxp6cumfR5oi0uD89BWPN63vX+
   L2TO/Ny6EwjZu8WhIaxkL8Fpzgk8OLDO8mua3Ok2CigiL/ILabl2xLn65
   KFzf8D4oCmL+/SeSbUnaMIHMScYkMWS0nFRw948GNn5CY+Sv9VLkDBe/i
   Q==;
X-CSE-ConnectionGUID: Lkh0oMkoTqWRmTi9o6/9Kg==
X-CSE-MsgGUID: K9xID6Q5TyuBFKxr8VtREQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="8666608"
X-IronPort-AV: E=Sophos;i="6.07,198,1708416000"; 
   d="scan'208";a="8666608"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 20:36:02 -0700
X-CSE-ConnectionGUID: EGRpeF/WQJWE1Gvie7acmQ==
X-CSE-MsgGUID: C+hQWB6cS/KhX0IUU2IMrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,198,1708416000"; 
   d="scan'208";a="26208564"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa005.jf.intel.com with ESMTP; 12 Apr 2024 20:36:00 -0700
Date: Sat, 13 Apr 2024 11:30:54 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Peter Colberg <peter.colberg@intel.com>
Cc: Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v2] fpga: dfl: remove unused member pdata from struct
 dfl_{afu,fme}
Message-ID: <Zhn8bjex94DpkGBw@yilunxu-OptiPlex-7050>
References: <20240401184915.714603-1-peter.colberg@intel.com>
 <Zhn3npCOy2h1SYm4@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zhn3npCOy2h1SYm4@yilunxu-OptiPlex-7050>

On Sat, Apr 13, 2024 at 11:10:22AM +0800, Xu Yilun wrote:
> On Mon, Apr 01, 2024 at 02:49:15PM -0400, Peter Colberg wrote:
> > The member pdata was added to struct dfl_afu in commit 857a26222ff7 ("fpga:
> > dfl: afu: add afu sub feature support") and to struct dfl_fme in commit

Sorry, I didn't apply. Please don't wrap the git commit description. Put
them in a new line but no wrap, if you have to reference git commit in
changelog.

> > 29de76240e86 ("fpga: dfl: fme: add partial reconfiguration sub feature
> > support").

This sentence is actually not useful, I suggest you just remove it and
add a Fix: tag below. That makes reviewers quickly find what the
problem. Also avoid the git commit references fragments the changelog
too much.

Thanks,
Yilun

> > It is set in function {afu,fme}_dev_init() but never used.
> > 
> > Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> > Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Acked-by: Xu Yilun <yilun.xu@intel.com>
> 
> Applied to for-next.
> 

