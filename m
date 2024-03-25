Return-Path: <linux-kernel+bounces-117400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B4788B284
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E317EB3F43F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F7513D50B;
	Mon, 25 Mar 2024 15:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hs3sMEGP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4239D13D2BF
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381340; cv=none; b=rc9rwy+MuhhdeIiUYGAOcGqxkaNeh8nAh4Tuem0OiNIXq9XjKPFzPF1Sg6/2NkMixnoHpvV8fVLwQHYg4FTOqx/N9ZzWjcNn46e/8QQHxhMJWXtH3aOodw9nXYlil8rMsqW9crq7ZLOxAo4cUVs+4t/xL4nzRCf8MmsQpI37QLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381340; c=relaxed/simple;
	bh=KcgY73DDippwTtUzWOvcJOeO8SjdhHQhBOlxrmtlBug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKDF2Smr5NXDAN3grol6Pg5l02bI76tVq7pkZcEOYREQtcU0WUSzjv7b5/6TpPl+4U15degTwTwElyeAIjuswnP6UvIZB0RN7uCOK5oSINgi1GmRKpUmxqlZuC8HLRIAOz6bje8yvBIznLFNee6QGidj2GyAFWgcAlPnelJ08Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hs3sMEGP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711381339; x=1742917339;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KcgY73DDippwTtUzWOvcJOeO8SjdhHQhBOlxrmtlBug=;
  b=Hs3sMEGP59oFiFDXAgCVSMPaLCNkGZU3igs9GJ7rccbQNH04kG4O+YIc
   9Aod6W9Xca38f1Nx9zhXaVgcCD6f0JIlX9KYOU/nx7wr4+clMwjasI17o
   KixDLCsqjOjS4TG0VqPE6Ip8tP1MLPFS46cN3sSLNAWZ8Pj+7mcB0KN4L
   JB5/p8Y7IvHqhmFA8aBohmgm/Q6LVTV14n5/82ROvGf9Xyvgqkv46uTj4
   mFsqA0oKY4EyY8WU71Ci+kP3lni1RL9GtzOWUyrp3K6WZ5eKbQdJvDlKS
   GuXywBabN4gPclcdn7hILTrDBOjftzxgYCSLPOOa5I47d2L7XsAw89opZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="31828842"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="31828842"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 08:41:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="914846903"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="914846903"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 08:41:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1romS5-0000000G1lm-1KA9;
	Mon, 25 Mar 2024 17:41:33 +0200
Date: Mon, 25 Mar 2024 17:41:33 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxim Korotkov <korotkov.maxim.s@gmail.com>
Cc: Boris Brezillon <bbrezillon@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Hector Palacios <hector.palacios@digi.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] mtd: rawnand: hynix: fixed typo
Message-ID: <ZgGbLe4XTy1FUP0C@smile.fi.intel.com>
References: <20240313102721.1991299-1-korotkov.maxim.s@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313102721.1991299-1-korotkov.maxim.s@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 13, 2024 at 01:27:20PM +0300, Maxim Korotkov wrote:
> The function hynix_nand_rr_init() should probably return an error code.
> Judging by the usage, it seems that the return code is passed up 
> the call stack.
> Right now, it always returns 0 and the function hynix_nand_cleanup()
> in hynix_nand_init() has never been called.
> 
> Found by RASU JSC and Linux Verification Center (linuxtesting.org)

> Fixes: 626994e07480 ("mtd: nand: hynix: Add read-retry support for 1x nm MLC NANDs")
> 
> Signed-off-by: Maxim Korotkov <korotkov.maxim.s@gmail.com>

FWIW, the tag block shouldn't have blank lines.

-- 
With Best Regards,
Andy Shevchenko



