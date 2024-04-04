Return-Path: <linux-kernel+bounces-132266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6705A899238
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 076ABB24F76
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6DF13C693;
	Thu,  4 Apr 2024 23:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RgvtSSc4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16679130E57
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 23:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712273997; cv=none; b=jqNOypWjQsErVWWiAV9ptnLEZi7rVSrVGNHS369Df88TIc0cxTGrHNdHAVPur9RRJVza/xZoLLg7Tq9EKODcpioXTBnkC+6WTsIdAUmzmbXwP+CJiHCxkXl3c/uRkhmgP3vy9v5kbgMi5Qb3cuhPFADji4oooZ70SLoz3I1oDK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712273997; c=relaxed/simple;
	bh=6HKfD/8wmlZgXYXrjxJELPl80JlkIWJruUR23ZSPDdI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMy1k2BrNLqL3G1oG1MvZtmO01xP4n+8/N2HhrUhqh2bzt5Lsu08Wj49ngeWBZdEvxk7d0K7WfX3S3E2m6aG8iC8EogUpEVUCFa1yTJtWxzthL2AqSPcQu3BIzqYLWIKPAoM6hjtK1Uu9HWRuQeyqzEK4kbwsDA+bLURoc5Wf1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RgvtSSc4; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712273996; x=1743809996;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=6HKfD/8wmlZgXYXrjxJELPl80JlkIWJruUR23ZSPDdI=;
  b=RgvtSSc4AH20TWads1rZRBBpiPjug+VDbCgVPyTPjmporsNKClg+QPVx
   HkV/LHy7e/M9l+AJ5OP1i4oBD9hJPjxIZLMfRnO2yR9dB73DEoI46LhPE
   41N5KOVcjtcvZdrg4mwavBlUdTCfg1CKmnSh772goKb6ntrgx398ewHGP
   j60p3WRoHjLchcEYIX3kLIgVIjJHP+VLQ/22bZmTlXAnAzfGuokfYqfzD
   STbvbYNmbHhwK7ph5WgAHdkiA3rBaKb0fzB5qraVyu1HQ7K5DQxE/xvJf
   1FSk8jZPk6DhhoqNec2L5CGR8NeLEDRGMRw0A/2WernDXszViO/DxBpBd
   g==;
X-CSE-ConnectionGUID: YSwh2PTMQS6L/nL7I3ukeg==
X-CSE-MsgGUID: 3jxbTN64R3+gp2y0nb81AA==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7695095"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="7695095"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 16:39:55 -0700
X-CSE-ConnectionGUID: am/1XBW/SAuPaS37RMPlYg==
X-CSE-MsgGUID: 0IaJQNE3SrSq6TfqMkDnkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="23616329"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.105])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 16:39:55 -0700
Date: Thu, 4 Apr 2024 16:39:53 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>, Yazen Ghannam <yazen.ghannam@amd.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: Machine check recovery broken in v6.9-rc1
Message-ID: <Zg86SZYDppxffEvv@agluck-desk3>
References: <Zg8kLSl2yAlA3o5D@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg8kLSl2yAlA3o5D@agluck-desk3>

On Thu, Apr 04, 2024 at 03:05:33PM -0700, Tony Luck wrote:
> v6.8 works. v6.9-rc1 fails with:
> 
> kernel BUG at include/linux/swapops.h:119
> 
> 117 static inline unsigned long swp_offset_pfn(swp_entry_t entry)
> 118 {
> 119         VM_BUG_ON(!is_pfn_swap_entry(entry));
> 120         return swp_offset(entry) & SWP_PFN_MASK;
> 121 }
> 
> 
> I've messed up the bisection three times now and ended up
> pointing at some innocent looking commit. So I wonder if
> anyone else has noticed and tried debugging.

I think I know why I messed up the bisection. I thought
the failure happens every time. But it seems that it only
happens most of the time. I must have accidentally marked
a build as "good" because I got "lucky" and my test passed.

Back to the bisect grindstone :-(

-Tony

