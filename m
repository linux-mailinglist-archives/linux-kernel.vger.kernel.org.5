Return-Path: <linux-kernel+bounces-160178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AC28B3A4A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278BE1F22B96
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A6914882E;
	Fri, 26 Apr 2024 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cGxeM14T"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA3613A3E2;
	Fri, 26 Apr 2024 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714142690; cv=none; b=k+1ojQHKR2yKSSBjME5weWhpfFqePLd7isxmbFQawoVN/btgjZbMLbuFlYyJnIrKZAxb5HsMUqfPCat+2PXeosif5xPtkEfM0X8uOVVLjKZ62HOULh2OI/IUwddMt18fUFbrVNfv49L0b6eiYDFkf2JHFNT4KJmcZmQ7Mxvc9Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714142690; c=relaxed/simple;
	bh=gnPMUO0AUqRSV3TxulQi2QF2Cl4IEzq86XVhb8vBjNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6fqub3lZxav8fmicTnd6kwRCyuNXVmr3Eg4omMDu97omIOea1BVbTjRiKsoGNzIYgAiPdRqh+ccq40OqQg7HOpiD1xb3xO4Z+17tSv/SqtNEnbbDWJPVTdXf4rVyu+84zv0hd5alFswk9KtwdpdArojuKWVymiwzZt+GNspUes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cGxeM14T; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714142688; x=1745678688;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gnPMUO0AUqRSV3TxulQi2QF2Cl4IEzq86XVhb8vBjNM=;
  b=cGxeM14T1E+vMKPoz1NBY/ijjUEeiMFM8o8Jgz73YuISSi4FfKeCx9Xb
   1JDeLBI0CDRTY/tx2cUhat8VKkY64tF3W8hsaW4A6Ipi7+3kEmAmqNVW2
   M1+28rLReOi7f86RF+R9aBLQGHLfJaV/IhX+5CzvA3wPcdkTYD8NL5Agl
   MoVQQW/UFW7cWkMbDZ1WIQuGLAyTZVz+2q4a+2Na9p1deocH5fu7Du8Ie
   7Gbv6csSWH6pX3nEVkeZx4Ns1Z5fDAkBaI8iqXW3qVKjVsCKTy4FZeJ7E
   zdG3P/oy4qiQMakE1s+1q9viZok0PrdSmhLqq2P4uDrsesCr8QwbLY2U2
   w==;
X-CSE-ConnectionGUID: w2nZ8l6gQdeFpVF8bApCzg==
X-CSE-MsgGUID: NGIlOp7TQ2S0gDckSqFTzA==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="20432555"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="20432555"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 07:44:31 -0700
X-CSE-ConnectionGUID: ceDn5bB2T52Fm5LPn3YzyA==
X-CSE-MsgGUID: HvDIZqLNTEOf6mD1Xrui+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="25843735"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 07:44:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s0MoA-00000001Lgv-33Aa;
	Fri, 26 Apr 2024 17:44:14 +0300
Date: Fri, 26 Apr 2024 17:44:14 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: lumingyindetect@126.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org,
	jirislaby@kernel.or
Subject: Re: [PATCH] serial: 8250_lpss: Fix memory leak in lpss8250_probe()
Message-ID: <Ziu9viefEtkQmHbz@smile.fi.intel.com>
References: <20240426133959.1294012-1-lumingyindetect@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426133959.1294012-1-lumingyindetect@126.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 26, 2024 at 02:39:59PM +0100, lumingyindetect@126.com wrote:
> From: LuMingYin <lumingyindetect@126.com>
> 
> The return statements at line 347 and line 351 in the lpss8250_probe()
> function result in a memory leak of the variable pdev.  Add a label named
> free_irq_vectors in the lpss8250_probe() function to release the memory area
> pointed to by pdev.  Modify the two return statements mentioned above to jump
> to the label "free_irq_vectors" instead.

> Fixes: e88c4cfcb7b888ac374916806f86c17d8ecaeb67 ("serial: 8250_lpss: fix memory in lpss8250_probe()")

Same as for the previous version, NAK.

This patch does NOT fix anything. Please, read the code and try to understand
how it works.

-- 
With Best Regards,
Andy Shevchenko



