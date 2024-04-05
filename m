Return-Path: <linux-kernel+bounces-132431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DED28994CB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A36251F26BBD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E925224CE;
	Fri,  5 Apr 2024 05:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="DBETiGHy"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A071EB2A;
	Fri,  5 Apr 2024 05:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712296000; cv=none; b=AxiYMNT0aI+7ObvF+BXYwBkdqccVr9yIxBKqyd+tFarEjkZgxtUTe3YnblaqgNgXej6iiIr5lKPa8d6QeQbr3atPIxjh/RSl8twujWwur9iOM+bg3ydgjWFkK7BjlPVsJH1ofV3VQN+H+OIffUJCa4OWYHMv/LjdUx8xla8p7yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712296000; c=relaxed/simple;
	bh=GELzFyw10kbJwOThW65zaSoLGBpg9a4ALZJAr38/+Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BquYIxwExC5NC+KV33dh+cetoAxqDJiU90Z2jC0QJpZtG/5xC3BqbKQfrXAI28ncofri2nUKfoTVEtLWRwYjz50DaujY6zGO8fsvodZHylyOEZDcmCr/nGIdAuuB5wtrZpiSoPIN5vvGonmMxkZeQ1CPgFkq9zlQ50bPzwHKZK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=DBETiGHy; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 6041060333;
	Fri,  5 Apr 2024 05:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1712295998;
	bh=GELzFyw10kbJwOThW65zaSoLGBpg9a4ALZJAr38/+Ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DBETiGHyvP2bnLvQgtNZaxqY2pb1Opk/nD096aHz2hvhC4waeHqvwTaiVKitlsCDm
	 8ZdNYQzl9KpGKMaa/C+hQeR3b7jJO3g1rER/QI9R/CzvHcquHyUDp/6Z9SM7N9hcVx
	 N5VMa2dNNBiNM8bbN6hQyIMpgH7C6BLVpupbtpvydVz8TLidalND9bIOCIcEUJKu9v
	 p1iCL8/8zDsiBjdq9+v7fR9IFpVc/ax7PK7CHpY3719nvi8GdsJkF4fZkcEBeU9xtF
	 3FbQVCh7WfLPImiAODkZLq4BVmL2mq7TjcgcCh0JIf+XV86HCYBoZ+TDp8WuXISC4i
	 0VOM2YTxEbPMw==
Date: Fri, 5 Apr 2024 08:46:17 +0300
From: Tony Lindgren <tony@atomide.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: kernel test robot <oliver.sang@intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable <stable@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [linus:master] [serial]  43066e3222:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <20240405054617.GQ5132@atomide.com>
References: <202404031607.2e92eebe-lkp@intel.com>
 <Zg1hBvRAxifo50sf@smile.fi.intel.com>
 <20240404065415.GO5132@atomide.com>
 <Zg66gtOQ01bOD5q3@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg66gtOQ01bOD5q3@smile.fi.intel.com>

* Andy Shevchenko <andriy.shevchenko@linux.intel.com> [240404 14:34]:
> On Thu, Apr 04, 2024 at 09:54:15AM +0300, Tony Lindgren wrote:
> > * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [240403 14:00]:
> > > Probably we need to check if the port is still open...
> > > 
> > > P.S. AFAIU the state / xmit is invalid pointer or so.
> > > 
> > > Culprit line:	serial_out(up, UART_TX, xmit->buf[xmit->tail]);
> > 
> > Maybe we can set UPF_DEAD a bit earlier as below?
> 
> We should do this under port_mutex. Otherwise we replace one race by another.

Oh right.. And adding some better check in addition to UPF_DEAD
would be better.

Regards,

Tony

