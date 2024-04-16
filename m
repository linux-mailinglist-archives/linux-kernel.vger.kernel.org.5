Return-Path: <linux-kernel+bounces-147429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 872338A73ED
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CDF51F222FE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7238613777B;
	Tue, 16 Apr 2024 18:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ACbuZAXC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8FB1C06;
	Tue, 16 Apr 2024 18:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293745; cv=none; b=Hr3B9CwMSXWqP9qG3nXrORXuzvVm5AoF0D4pyKGOqn9LhgjX/DKLu2zBiTAuw/69VgL0qHm0ni4sNZjHH/87gJv3Zw7uJrrFEMs4XkIzroge/lDVyssIudT5nlBzad8S6/HVg4dfpEoW7S4kfnrHErbpC/hFnhPRe9wt/fe3xuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293745; c=relaxed/simple;
	bh=80+I06RrrBCZAtelHC3oSYJjtxn58mItfSFXw8bzQXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeUIjRuXo8QxvH/7J3RBUxW9h9OZlOjSwoZRUoRgo8HRPpYeItgrWsBTrKOwKwIYRhjWq+N6ko9kaDIPlDa4p9g5aedcbPYVwXwFSivdKr6V6LS3Mn8eMVgweomlqZGZfFxMzSUeSZHmjYi+eB5pV/KB8ACPvNZ9MySYTN4bIw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ACbuZAXC; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713293745; x=1744829745;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=80+I06RrrBCZAtelHC3oSYJjtxn58mItfSFXw8bzQXU=;
  b=ACbuZAXCv9+HMyh75P6F/oqgpROzMr5v9cz8XXda7hBMVKfvku9KXqVm
   dH4X8s2B+iSly560f0Q3sUDjwekfZDvawrgj1yzcJP6pDecG4a5Fe5vkB
   xeoLK0+vS/TY5+YUg9LgzctcmCMh+/C5+IfnCo8mq4MRQkoyExteYOzJ2
   GJ37irQt+N/PFZGANQIAFvkpPKVpFmaaAQKw4novds06tsdSprPjPEUeh
   K5u1pRCIGkvqwV++ovyo7mmoUG0d8eM88bIGF3GCIpA0XItsoYBuemgVY
   MdjzSF0x1Iv8IrSxbQpfaFfydINAXO5EibZZVOouPIrLXjWrheJJ9Mhx7
   g==;
X-CSE-ConnectionGUID: 1d/gJW5FSXWE6Xt1sdi2lw==
X-CSE-MsgGUID: 2S0DJnnWSqaCo3h7A/WjoA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8679578"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="8679578"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 11:55:44 -0700
X-CSE-ConnectionGUID: sT7ukwYERSCHJKHETx1IZQ==
X-CSE-MsgGUID: NwnxGkY1Sfqi7vga9gLcRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="26787206"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 11:55:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rwnxy-00000004nSh-0qCS;
	Tue, 16 Apr 2024 21:55:38 +0300
Date: Tue, 16 Apr 2024 21:55:37 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michael Pratt <mcpratt@pm.me>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Wander Lairson Costa <wander@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vamshi Gajjela <vamshigajjela@google.com>
Subject: Re: [PATCH v2 2/3] serial: 8250: Store whether fifo device is enabled
Message-ID: <Zh7Jqf2sJNw1mVyJ@smile.fi.intel.com>
References: <20240416182741.22514-1-mcpratt@pm.me>
 <20240416182741.22514-3-mcpratt@pm.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416182741.22514-3-mcpratt@pm.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 16, 2024 at 06:29:56PM +0000, Michael Pratt wrote:
> Currently, there are 7 checks for whether to enable
> the internal fifo device of a 8250/16550 type uart.
> 
> Instead of checking all 7 values again whenever
> we need to know whether we have the fifo device enabled,
> store the result as a struct member of uart_8250_port.
> 
> This can, for example, lessen the amount
> of calculations done during a write operation.

..

> @@ -3392,6 +3392,8 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,

> +	up->fifo_enable = use_fifo;

This seems incorrect / not the only one place to assign this. What if the
console not enabled at compile time? What if it's not enabled at boot time?

-- 
With Best Regards,
Andy Shevchenko



