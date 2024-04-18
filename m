Return-Path: <linux-kernel+bounces-149818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EB18A9640
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A60FDB23462
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995B015B10F;
	Thu, 18 Apr 2024 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TF4Vxjbs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BEE15AD99;
	Thu, 18 Apr 2024 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432844; cv=none; b=pcjUHLaIUDjPwFXROb3vDfoNtaJ5ESDrYXFMmJrGJ+WEW1nxyGbVe1BX5lBIFS87p0cCBVqBtH5oE/PYIS7aNYXv0PhE/3k0rXrkic+xGAhHI32zf3Fqp6WrOYniD0+287rW4U8qbk7QUdLmdykKGDR9FVF0aHX6VGIh1u3nnZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432844; c=relaxed/simple;
	bh=x4SKvEtyE1KDA25Hl+uymZOENz/gJ0e1qUXoDzCGpCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T726Vty9PkCQ2Qc/rBh734JlIG18sDI/IJf2jBrEm0RPvaS43yKuEWIC0yP5uxHX72/tAJU4jLhMmWQuYC9WEgiBJSfSzkQLuoouZI/NE/od1RPQkLKUlZO7u8nIuK0Q2pjB/0svzv5PTpY2tgkhWPM1WabKOJ5RfjQ9rsyR7DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TF4Vxjbs; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713432843; x=1744968843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x4SKvEtyE1KDA25Hl+uymZOENz/gJ0e1qUXoDzCGpCk=;
  b=TF4VxjbsgSfBY0ctMSuZjgxV7lEwbrBSo0MiKvFvQKszKY3mA7cXMAVg
   9ImylX3a7in8g8g30HrUhLQQc0+oOO6VRiGrxZusYPLDZoRzdHHPVhoKO
   Ogu/qh4G0GQtm7Q3gdteO7h+hr8Lqtu6PneX7/S5cz64b4DcLNAJhnPGJ
   oHwijqUOIUFldqPPXVuIjTgFj3+V/4BoiytYDji25Uitt33IM6tmM6km0
   Ud+kYlbKDj44k+7xoxodmMY2btjJJQlW7skoexTi/QBWgGBdlzO6xFitt
   o8d3F8cZa/fY1kbBw5rzZTJ8Tt8nIEVPCAuWp+YQ4qsu50Dajsm1S9AoC
   g==;
X-CSE-ConnectionGUID: aEYRQx1WTeiH7lkUUttZMQ==
X-CSE-MsgGUID: ts8lvqmSQ+qZWAdFOLTG4g==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="26478311"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="26478311"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 02:34:02 -0700
X-CSE-ConnectionGUID: oAfuQlx5TtGZSrQaYo2Ljg==
X-CSE-MsgGUID: pYQAq1JIQTSDzYoK4+p90w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="46213405"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 18 Apr 2024 02:34:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 882F024D; Thu, 18 Apr 2024 12:33:59 +0300 (EEST)
Date: Thu, 18 Apr 2024 12:33:59 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/2] gpiolib: acpi: Add fwnode name to the GPIO
 interrupt label
Message-ID: <20240418093359.GQ112498@black.fi.intel.com>
References: <20240417103829.2324960-1-andriy.shevchenko@linux.intel.com>
 <20240417103829.2324960-2-andriy.shevchenko@linux.intel.com>
 <20240418044907.GO112498@black.fi.intel.com>
 <ZiDmoT9gn7cFaYyV@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZiDmoT9gn7cFaYyV@smile.fi.intel.com>

On Thu, Apr 18, 2024 at 12:23:45PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 18, 2024 at 07:49:07AM +0300, Mika Westerberg wrote:
> > On Wed, Apr 17, 2024 at 01:37:27PM +0300, Andy Shevchenko wrote:
> > > It's ambiguous to have a device-related index in the GPIO interrupt
> > > label as most of the devices will have it the same or very similar.
> > > Extend label with fwnode name for better granularity. It significantly
> > > reduces the scope of searching among devices.
> > 
> > Can you add an example here how it looks like before and after the
> > patch?
> 
> Sure:
> 
> Before:
> 
>   GpioInt() 0
>   GpioInt() 0
> 
> After:
> 
>   NIO1 GpioInt(0)
>   URT0 GpioInt(0)
> 
> Assuming I update this when applying, can you give your tag?

Sure. For both,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

