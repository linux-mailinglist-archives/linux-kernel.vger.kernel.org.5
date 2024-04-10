Return-Path: <linux-kernel+bounces-138650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E675389F8A3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA84A284751
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4364316DEBE;
	Wed, 10 Apr 2024 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WWwjUk8v"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6809F16D9D4;
	Wed, 10 Apr 2024 13:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756453; cv=none; b=fw0moWmcPDHo8AEhjPcrXPWW+lL3rM0xazd4vX52ZBDkuC9Y/uoGVlfszt5OmGRQC62SQOXzQSWDMTQFIhWhHYZxN1y/YeRZjEx3SDETiZQ/wFAjmzXvVj+O1jqiQyFOwv3XeGkSazjzLxhGjaUDliFiO+pLqkQVbiW1vnqJ8as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756453; c=relaxed/simple;
	bh=2FUZKmDC3uXV6lRtnmgMR3WBQZOamgU9l6hJ9YWMlsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwJcH+RMAji3aXbCRaywWl2rbCNpViWwzeoMrhbqTmJWYVHjZk+/sQ4BpLmRRd8ZyXJ+vpbEtciF6R/AL/6c+K5bq0q3oI1Xq2HoyGrz8gDWNRXBfgldga4Q5SwQv0cxiKeTxlnipNAhDcE6l79Wu+Bi7YMxj9GD+zXLSCgO9to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WWwjUk8v; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712756452; x=1744292452;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2FUZKmDC3uXV6lRtnmgMR3WBQZOamgU9l6hJ9YWMlsw=;
  b=WWwjUk8v3LNWtBaigWnCnU64h1F45shPvccb2E6tGvTIIe0GLHDP3GKl
   WaUx8vzj84gHyak3DvWHFPLf37+GdZLCXGjh2Z9wXdqH7PKhS2YtWUpEy
   ESTPBjjNjdn/Fg6drgO7J4Ou1aIeIrDx5zUxGdm/lUjR3OQfyTfoGxDtw
   Xaqpfa6jc1Pa6ThOA+ez3/+eJ2Kr7huOkKsmtB0XEgPMi8+AqOg5BodJl
   6vnBNjj3d9LGQSuHc2RFLrqnr73BsyUPna045+Nrui2vsbRwnODXi9QWd
   6kEpDavFpWtIjLHQWOtyT3meap66kmTNuZi2NWvkSUow0A/PwurVZoXn9
   Q==;
X-CSE-ConnectionGUID: Ad1oVmFiSa2Z/oGaLxFp/g==
X-CSE-MsgGUID: FX+jqJ92Te+opPcajXWSrw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7991582"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7991582"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 06:40:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="915433375"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="915433375"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 06:40:47 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ruYBw-00000003516-3Ty5;
	Wed, 10 Apr 2024 16:40:44 +0300
Date: Wed, 10 Apr 2024 16:40:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: albanhuang <albanhuang0@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
	linux-acpi@vger.kernel.org, tony@atomide.com,
	john.ogness@linutronix.de, yangyicong@hisilicon.com,
	jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, lvjianmin@loongson.cn,
	albanhuang@tencent.com, tombinfan@tencent.com
Subject: Re: [PATCH v6 0/3] serial: 8250_pnp: Support configurable reg shift
 property
Message-ID: <ZhaW3PM3TccV5t3w@smile.fi.intel.com>
References: <cover.1712646750.git.albanhuang@tencent.com>
 <ZhU6Or3hTziarHZo@smile.fi.intel.com>
 <4f0950f8-e0e1-4b26-85b9-385c97c39cf6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f0950f8-e0e1-4b26-85b9-385c97c39cf6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 10, 2024 at 10:49:29AM +0800, albanhuang wrote:
> 在 2024/4/9 20:53, Andy Shevchenko 写道:
> > On Tue, Apr 09, 2024 at 03:43:20PM +0800, Guanbing Huang wrote:
> > > From: Guanbing Huang <albanhuang@tencent.com>
> > > 
> > > The 16550a serial port based on the ACPI table requires obtaining the
> > > reg-shift attribute. In the ACPI scenario, If the reg-shift property
> > > is not configured like in DTS, the 16550a serial driver cannot read or
> > > write controller registers properly during initialization.
> > > 
> > > To address the issue of configuring the reg-shift property, the
> > > __uart_read_properties() universal interface is called to implement it.
> > > Adaptation of PNP devices is done in the __uart_read_properties() function.
> > You either forgot or deliberately not added my tag. Can you elaborate?
> 
> I'm very sorry, this is my first time submitting a kernel patch. My
> understanding
> 
> of the submission specification is not comprehensive and profound enough,
> 
> and I didn't intentionally not add tags. I hope you can forgive my
> operational mistake.
> 
> Should I just add a "Reviewed-by tag", or do I need any other tags? Thanks.

Understood. So if you are is one who is sending a new version, you should take
care about any given tags (such as Reviewed-by) and carry them, in case the
code is not drastically changed. I.o.w. if you don't, you have to explain why.

Anyways, it seems the patch still has a flaw as per LKP, so fix that by
providing probably two macros in the pnp.h header for both cases
(CONFIG_PNP=y/n), and I will review it again.

	#ifdef CONFIG_PNP
	...
	#define dev_is_pnp(...) ...
	...
	#else
	...
	#define dev_is_pnp(...)		false
	...
	#endif

-- 
With Best Regards,
Andy Shevchenko



