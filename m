Return-Path: <linux-kernel+bounces-138670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC3F89F8E2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A60AC2820EB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9816216EBE7;
	Wed, 10 Apr 2024 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c9erP2RV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F7A171659;
	Wed, 10 Apr 2024 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756734; cv=none; b=OoTSpPyHkPyV+YWJsp2VJjQFQd1COOFZIo29EZ5PPNb59FhVPXsz8glN+tEoTxCkQuwGsROQsSVfJ81hyGNDgDzYCjWBDeiyWBcb/gwFlIliK8vPjEeECqHCkK39A6+ilmDs5AmzjG3ObqocvtqQWrUFg5WAbutjia4bp59y9Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756734; c=relaxed/simple;
	bh=BZBYIru1y9O0ff+KqP42qWApBTmbdjS4qKJAb5/5bwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0JVDdk5jwEbUpMtKdeuk6QaMpH1M++vsL/LWWQMUTw0hlmE5mW9bsA9tPqAm0tpA6IFKgbhRWnrpGbBxA/amVJTRdSIqwgPKw7hva4rvD605m9NcZL+Hi4FcOoyLjYrVxuTFDVhx/RV5RfUYkc8DCOIF9+LFuPv4we8aASGxRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c9erP2RV; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712756734; x=1744292734;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BZBYIru1y9O0ff+KqP42qWApBTmbdjS4qKJAb5/5bwo=;
  b=c9erP2RVSPWjuTKDNSLaGLMc1sR8iZgNFugyP3wmow7YOdhpwx9IzIro
   ZQ7YsM2uSfR9mCLgmEzqDmLlEU+lxYl6B6EarMGQB+Ta+tX7iDHiVwYpj
   7iIPIG176zm88WXqau93sE0kpepFA0Fi75WO0rhN8Zny54gwk+Wsu4Nun
   POzmiaJ49FmImyaFZJZer5JuLaskn09Hj8GiKrK7TFrlWnfk19z6hG0NM
   LXBWyKtm77G+DkXs9y+/AokdCHA7h7xQB8LDDhxVKvMDJ8kJZ2l05v4cA
   34ATQekF4MbpGZpr7kA0+KfkVtBlNyODGL8s14MJv3cTI01kC7xj9gKaX
   w==;
X-CSE-ConnectionGUID: EGQD7SB6TMCeh1oPmVd6hA==
X-CSE-MsgGUID: lxIkZn92TpS3QGBxbaXVOA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7991959"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7991959"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 06:45:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="915433467"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="915433467"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 06:45:31 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ruYGX-0000000354V-17GR;
	Wed, 10 Apr 2024 16:45:29 +0300
Date: Wed, 10 Apr 2024 16:45:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 1/1] serial: core: Extract uart_alloc_xmit_buf() and
 uart_free_xmit_buf()
Message-ID: <ZhaX-R2UV8B9xMXL@smile.fi.intel.com>
References: <20240409174057.1104262-1-andriy.shevchenko@linux.intel.com>
 <52a83cb5-ef4f-46f5-ad90-1f64b4d588e2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52a83cb5-ef4f-46f5-ad90-1f64b4d588e2@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 10, 2024 at 11:04:35AM +0200, Jiri Slaby wrote:
> On 09. 04. 24, 19:40, Andy Shevchenko wrote:

..

> I see very much of tty_port_alloc_xmit_buf() and tty_port_free_xmit_buf() in
> here :).

A-ha!

> Currently, different locks are used, so the patch is, I think, good for now.
> For future, we should switch to the tty port helpers.

Sure, but I'm not familiar with TTY.

> Actually have you looked if the different locking is an issue at all? IOW,
> isn't the tty_port's (and its xmit buf) lifetime enough w/o uart port locks?

Nope. I only looked at spin lock differences (irq/irqsave) and decided that
irqsave variant is good for both cases.

..

So, do I need to do anything or is it good to go as-is?
Thanks for review.

-- 
With Best Regards,
Andy Shevchenko



