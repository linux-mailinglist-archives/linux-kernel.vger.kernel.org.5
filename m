Return-Path: <linux-kernel+bounces-135527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 469D189C730
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2C001F21F6B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FAD13E8A2;
	Mon,  8 Apr 2024 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g0d1WVGM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831CC13E3EE;
	Mon,  8 Apr 2024 14:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587008; cv=none; b=nJTO6pru/LXQFgUZpO3/ARWt0dODAOfTaPnQglInEA8+r7vaLk2KnqPCP0ATWp714cfe7U1XP+MJdu6YZOjq5zxuYx2aoExItUkMq67UsWTqvRkKi7OAnGY7v1vRxciLeRhb85pu3G8jYlg3KzdNRQb52UFn6AVuWJz/orKHDDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587008; c=relaxed/simple;
	bh=AP6bi9ege6JcpGaSssCggpjbRyuytVVuJ+Jp5d52k3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcacV/6MA0w3UhFBRBVy3esTM5LWlo9OndOPN3jBTvsHovL7s/iYNkt6DTHqvPY3AGe4bNhX5fhrqzf0pv9dEs8VzWFZKJuQIJmrZPGUyRCSWCIeyteLSDE/IwlWqrQnRaunToe+gaRD1RjX8/HuuP3sdWDrOoBBZ1i7KSp0CY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g0d1WVGM; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712587007; x=1744123007;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AP6bi9ege6JcpGaSssCggpjbRyuytVVuJ+Jp5d52k3Y=;
  b=g0d1WVGMQd76uorKZiHF+EkK0H4YYqEFV/pI71QG9lREEbcjlqIwAm+y
   jI6SNxrc8LvnZwFPyu1Izi25jbf50LSpGSzjx6ZNK1b973gy42IU+lucq
   OK6e8kgXC12f2SxG5xADsCADYAh7fD7ilbYGH9Z/5Knbb72Rq+M39zM9h
   tgHrQWYN3cutpAtRJ614C//cfqOeTzvjnhWjclgc17itcp8LEzGP42XXl
   VD+o1mKDnqbaYC8Qant2IV76yWhxhFsQkzWDfyBQ1AVCY3usC72MzsoKi
   DRQbILSFhVf4+9rPv1n/KMMuYjYwXqUDFZ2jfzCRItnH5yG5Q54G75jxj
   A==;
X-CSE-ConnectionGUID: RQq6ON2WS7aNA16GHxMiVw==
X-CSE-MsgGUID: BBuNGLyzSsyHPfwnO245mg==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="18588085"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="18588085"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 07:36:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="915367374"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="915367374"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 07:36:43 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rtq6y-00000002Y9M-0zwF;
	Mon, 08 Apr 2024 17:36:40 +0300
Date: Mon, 8 Apr 2024 17:36:39 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yicong Yang <yangyicong@huawei.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	yangyicong@hisilicon.com, Jiri Slaby <jirislaby@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v1 1/1] serial: core: Clearing the circular buffer before
 NULLifying it
Message-ID: <ZhQA95sHWoaWnq07@smile.fi.intel.com>
References: <20240404150034.41648-1-andriy.shevchenko@linux.intel.com>
 <b3fd1077-b49e-d99b-9cd1-c41bd244f290@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3fd1077-b49e-d99b-9cd1-c41bd244f290@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Apr 07, 2024 at 05:49:19PM +0800, Yicong Yang wrote:
> On 2024/4/4 22:59, Andy Shevchenko wrote:
> > The circular buffer is NULLified in uart_tty_port_shutdown()
> > under the spin lock. However, the PM or other timer based callbacks
> > may still trigger after this event without knowning that buffer pointer
> > is not valid. Since the serial code is a bit inconsistent in checking
> > the buffer state (some rely on the head-tail positions, some on the
> > buffer pointer), it's better to have both aligned, i.e. buffer pointer
> > to be NULL and head-tail possitions to be the same, meaning it's empty.
> > This will prevent asynchronous calls to dereference NULL pointer as
> > reported recently in 8250 case:
> > 
> >   BUG: kernel NULL pointer dereference, address: 00000cf5
> >   Workqueue: pm pm_runtime_work
> >   EIP: serial8250_tx_chars (drivers/tty/serial/8250/8250_port.c:1809)
> >   ...
> >   ? serial8250_tx_chars (drivers/tty/serial/8250/8250_port.c:1809)
> >   __start_tx (drivers/tty/serial/8250/8250_port.c:1551)
> >   serial8250_start_tx (drivers/tty/serial/8250/8250_port.c:1654)
> >   serial_port_runtime_suspend (include/linux/serial_core.h:667 drivers/tty/serial/serial_port.c:63)
> >   __rpm_callback (drivers/base/power/runtime.c:393)
> >   ? serial_port_remove (drivers/tty/serial/serial_port.c:50)
> >   rpm_suspend (drivers/base/power/runtime.c:447)
> > 
> > The proposed change will prevent ->start_tx() to be called during
> > suspend on shut down port.
> 
> Just saw the issue and thanks for your timely fix. I didn't got a board with
> 8250 and sorry for didn't found this issue.

But does this change make no regression in your case? Can you test it?

> FYI, I checked device_shutdown() and seems it called pm_runtime_barrier() for waiting all
> the scheduled RPM callbacks finished and keep the device in resume state. So ideally there
> shouldn't be any pending requests later since we handled them before shutdown?
> 
> There's someone encountered the same issue in shutdown() due to runtime pm and fixed it in
> 	af8db1508f2c ("PM / driver core: disable device's runtime PM during shutdown")
> patch above seems to still have some problem and later fixed by:
> 	fe6b91f47080 ("PM / Driver core: leave runtime PM enabled during system shutdown")

Ah, yes, thanks for reminding (yeah, I saw those patches, let me test it on my setup.

> But seems the handling in the driver core doesn't cover the case here..

Of course, since we have our own shutdown on the upper level, we don't kill the
device, but we do release _some_ resources.

-- 
With Best Regards,
Andy Shevchenko



