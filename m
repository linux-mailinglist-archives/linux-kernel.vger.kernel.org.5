Return-Path: <linux-kernel+bounces-147459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 882068A747A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E538E281FB6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CE413849C;
	Tue, 16 Apr 2024 19:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BxFY9opg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E39D137C2A;
	Tue, 16 Apr 2024 19:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713295119; cv=none; b=DAcXRDqmwfG2l09ZcsVW0tUzsFXENcs//5j9JeyqFtAiz1k5wedbg7VOiE5d3XLv+2KnHQGH0/qmyLJoDB49TMsRAO6dRSjAUdx422NypxNs0YzW8KA6bRAXhaD9EWj8OgCIZAEuqgjh6xtzo9brgGIu+iWNjF/9ktLWsnFmtN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713295119; c=relaxed/simple;
	bh=yqAl2l6rQBoY1qZSGTS9h32f0FNm91n/xwPxkRH8eyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAVdcszL8RpfDi5jwVUbYU7EDVAiClr5iWNTm3XHiHCUO6xGCj0DWHDLMULROHKL7gN8FTd1OYqGRl696MYC+V+vNx1QUk7xaIyik6pv9Z231eVEPcEbjK+FQjBwPEXivi1UkJFPxs/dJfhCZIXvNGwtXddua4yJEs6Wei01Tuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BxFY9opg; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713295117; x=1744831117;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yqAl2l6rQBoY1qZSGTS9h32f0FNm91n/xwPxkRH8eyQ=;
  b=BxFY9opgSoNHqYtxxNEOqh2S6y5/sCj2JcXEeGy+t+sm2AxwU2W50QQh
   DGaRJTGpCmcFLavSuky1MuvihOCsxnn6TLjhHaFiFyqj5pn1ZAdxVO7Ib
   2chd+tF1mIkVnOQ6nvVcpTtzElUMDDRI284viIlDP9XHAt0FaAI8YEEo7
   GvzRMu9t/CHfAFR7AhBNxYL2/r7qjLy+4okStvdyzhW54JfCBvvx8nK9q
   VstxWPwi+/1JMDGi/jeyiJ9LfI8B5eGbAzAJL11BFaDedDus9v3XtR0Rx
   xFtqf9DQUYfTFRFTTB1EO81F+bekz5S7i+KtJDZ3LWRRAIDZeZrrB41Lv
   g==;
X-CSE-ConnectionGUID: yzVOgKC5QK+bXLFtEmvoEA==
X-CSE-MsgGUID: nABbMqbSSmKhh1v/eom6pA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8979719"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="8979719"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 12:18:36 -0700
X-CSE-ConnectionGUID: 5SCBKKUiQVC5wYPGjMeeuw==
X-CSE-MsgGUID: pHQBlPSNT7OY4lXdmvGmyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="22429255"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 12:18:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rwoK7-00000004nky-3gby;
	Tue, 16 Apr 2024 22:18:31 +0300
Date: Tue, 16 Apr 2024 22:18:31 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michael Pratt <mcpratt@pm.me>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Wander Lairson Costa <wander@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vamshi Gajjela <vamshigajjela@google.com>
Subject: Re: [PATCH v2 2/3] serial: 8250: Store whether fifo device is enabled
Message-ID: <Zh7PBwJ_r2OzES1y@smile.fi.intel.com>
References: <20240416182741.22514-1-mcpratt@pm.me>
 <20240416182741.22514-3-mcpratt@pm.me>
 <Zh7Jqf2sJNw1mVyJ@smile.fi.intel.com>
 <TYV02sftzpleM60PqVjM3niI3BqS03AyOPPAg0urAoBKyhgGGQyq1OSkZQM8aZ70Q-KaT7-lYiHl9xH-wjcdsMNvKPiJZDsvwC1uN5uEn7E=@pm.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYV02sftzpleM60PqVjM3niI3BqS03AyOPPAg0urAoBKyhgGGQyq1OSkZQM8aZ70Q-KaT7-lYiHl9xH-wjcdsMNvKPiJZDsvwC1uN5uEn7E=@pm.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 16, 2024 at 07:09:52PM +0000, Michael Pratt wrote:
> On Tuesday, April 16th, 2024 at 14:55, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> > > @@ -3392,6 +3392,8 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
> > 
> > > + up->fifo_enable = use_fifo;
> > 
> > This seems incorrect / not the only one place to assign this. What if the
> > console not enabled at compile time? What if it's not enabled at boot time?
> 
> This is 8250 specific, and currently, it's the only place there
> where it's decided whether or not to use the fifo device
> by checking a bunch of flags and values.

Exactly, as initial commit is related to the kernel console _only_.
While your code, IIUC (correct me, if I'm wrong) is for any use of the port.

> If you're suggesting that these checks are moved out of this function somewhere else,
> I would probably agree with that, but let's save that idea for the future...

Not really (again, IIUC above), as console can be not enabled, and hence
serial8250_console_write() never been called and you will have false impression
that there is no FIFO in use.

> If you're suggesting that there could be a null pointer, I don't think that's possible
> in this function... (the name of the pointer being "up" might be confusing?)
> 
> Sorry if I'm misunderstanding what you mean.

-- 
With Best Regards,
Andy Shevchenko



