Return-Path: <linux-kernel+bounces-136893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9625389D977
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6FBA1C21FDC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0FF12DDB8;
	Tue,  9 Apr 2024 12:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j0MUDyz6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C00384;
	Tue,  9 Apr 2024 12:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712667202; cv=none; b=BNqc9CPLLtSYO5sp3txx4FaOsHWVtiAcOV/PKcBrCUY3Ke07L9pbb8Nq977wnAg5xJRsmz8M26ieQ40F+2fxLHUJiQDQ1IbOHel3yvayUuBXvjad6zBhJ1wDvRC6msafkRPzYsUUWnIOkkeudIh9CAPj0IWtkv9PWB+ydNSAUxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712667202; c=relaxed/simple;
	bh=yN5k7M3r1PSoxM2xUNoYNXh8X2U0F8GkRzTPqDQwUUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dx+QmENHCfTVL7FT/WvHWl0IczLL78dy/bWDPtl69omJtKfdDSnQnFAwTVielSgk+58Ry0IkTdUCSlvzsui0QAmGtiO0hX3yEotUQ0LwlQGFz3jgSh+8xUoIDGiHADjBiyY0WjI+xRGNXtzS4qs2+QZP5h/PIVjTLzGfMOp6ssM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j0MUDyz6; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712667201; x=1744203201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yN5k7M3r1PSoxM2xUNoYNXh8X2U0F8GkRzTPqDQwUUA=;
  b=j0MUDyz6+sBYaYTtnRQkcE0V/2S5SFYty5dFcAIQKSAPAkhzifj4+AYS
   /tHY6aIwl9xvVHGxshXX8JK3vSFcC5znSNRPQpW65avXSyMLLPYAAtG/i
   hX/jPteQiTK7jfEv6BLGE6taDMIapgISJF1S4HxAXkGz8tYvQ28q+22Wr
   yrWxsTareGNiUWXpvNT1Hjv6SHj+5vlykCAp+9kN0zDGCO2PaTVKkkBYV
   eTRkwRBmzbjXd/LErg90iACk2swu8kIF5shekdp0CtZsDMsU673TAIVfF
   83gwX6P2Lz1UitW4Q1q8/+bTfQStBPFbAXhZq5XW/7mpO0wqfLmBmTgiQ
   w==;
X-CSE-ConnectionGUID: R0Ikmpx1Rku/9eR02l2piQ==
X-CSE-MsgGUID: XV7ISzFbST+bzCxCzkX05g==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="8080805"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="8080805"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 05:53:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="915399115"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="915399115"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 05:53:17 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ruAyQ-00000002o7p-130G;
	Tue, 09 Apr 2024 15:53:14 +0300
Date: Tue, 9 Apr 2024 15:53:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guanbing Huang <albanhuang0@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
	linux-acpi@vger.kernel.org, tony@atomide.com,
	john.ogness@linutronix.de, yangyicong@hisilicon.com,
	jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, lvjianmin@loongson.cn,
	albanhuang@tencent.com, tombinfan@tencent.com
Subject: Re: [PATCH v6 0/3] serial: 8250_pnp: Support configurable reg shift
 property
Message-ID: <ZhU6Or3hTziarHZo@smile.fi.intel.com>
References: <cover.1712646750.git.albanhuang@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1712646750.git.albanhuang@tencent.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 09, 2024 at 03:43:20PM +0800, Guanbing Huang wrote:
> From: Guanbing Huang <albanhuang@tencent.com>
> 
> The 16550a serial port based on the ACPI table requires obtaining the
> reg-shift attribute. In the ACPI scenario, If the reg-shift property
> is not configured like in DTS, the 16550a serial driver cannot read or
> write controller registers properly during initialization.
> 
> To address the issue of configuring the reg-shift property, the 
> __uart_read_properties() universal interface is called to implement it.
> Adaptation of PNP devices is done in the __uart_read_properties() function.

You either forgot or deliberately not added my tag. Can you elaborate?

-- 
With Best Regards,
Andy Shevchenko



