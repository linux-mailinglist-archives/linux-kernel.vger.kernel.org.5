Return-Path: <linux-kernel+bounces-129501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01776896BA7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC791F29905
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE2A136997;
	Wed,  3 Apr 2024 10:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aBu+BO9i"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8097135A6A;
	Wed,  3 Apr 2024 10:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138791; cv=none; b=uIYTQ3lHtZGWGgvItpeJMbHnZ/A4+TCpewhS8Y/FrJ1c9IhJzKUqD9idS39R1rmKTuSMwDCZnYtZquFc1QBGaXAV9aQ9j/X7X/t1k8VVrgfbEXRR7DNWwNg00U4PqIwk7agy2VQ502bhdzGf1vb9cgeRMhMkjh8pTnOztL5Ltx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138791; c=relaxed/simple;
	bh=MI2M5rQfKaNY2xZjsF9iyBaiS7tf62zw9KTvIfXjUD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=famHnYqyIRtPOGTQ9W/JAVbqhmM/keH0slT7ovc44H0Ac7j2s9ED1scNTucfaSkbs2PRjrVuxKae+7jge/k8rUkLcUeSTjxWMVP+q3dgtVNxKKXUO4MR18p8xeKsE6NgvJMTKn4VBLcz3oyclWsZA+/R0p59pSLCra8OXHguYI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aBu+BO9i; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712138789; x=1743674789;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MI2M5rQfKaNY2xZjsF9iyBaiS7tf62zw9KTvIfXjUD8=;
  b=aBu+BO9i19+s7bdKXy7QAHKoo9FSf2VUOmS6gNJB/YGJhXDgiNVGidk6
   p7U+s31lcUrDL9+b9e5Cns9Wc9e/W7KaWgNo4itvomd4Dii4rPNgLLBuL
   2FoT2bIpXpOhjJx1ZOpbOx+fbRvK/nH/w+DUNAJE3h08uByqyd2p934iH
   rWYFYArcSC5pzrYuaqvpmmHpvCke0d+cgiHMdMmnRDKTlI+AI7gYQFNaM
   A1x3RCfjyxVNGMQ4ioiUEr4NBM7g+sHd6pySeAjOi/h0oWO+6iAe4lwr4
   H0qTBNhg5+LohRDfrVQe4tOV1zsws7ficw1sIj6Zf10V9eEAJHg04dvj6
   Q==;
X-CSE-ConnectionGUID: uKhKitudR3+lHBMUu6dqjA==
X-CSE-MsgGUID: vZFnNpkNSqKNZ+o6uhRuhg==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7485692"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7485692"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:06:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="915177304"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="915177304"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:06:25 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rrxVe-000000015IG-3o3B;
	Wed, 03 Apr 2024 13:06:22 +0300
Date: Wed, 3 Apr 2024 13:06:22 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guanbing Huang <albanhuang@outlook.com>
Cc: gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
	linux-acpi@vger.kernel.org, tony@atomide.com,
	john.ogness@linutronix.de, yangyicong@hisilicon.com,
	jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, lvjianmin@loongson.cn,
	albanhuang@tencent.com, tombinfan@tencent.com
Subject: Re: [PATCH v4 2/3] serial: 8250_port: Add support of pnp irq to
 __uart_read_properties()
Message-ID: <Zg0qHs-wzG9y0lQt@smile.fi.intel.com>
References: <20240403074130.93811-1-albanhuang@outlook.com>
 <PSAPR06MB4952D98B1204C8591989DB25C93D2@PSAPR06MB4952.apcprd06.prod.outlook.com>
 <Zg0nSz7QSBjIQ_XP@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg0nSz7QSBjIQ_XP@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 03, 2024 at 12:54:19PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 03, 2024 at 03:41:29PM +0800, Guanbing Huang wrote:


One more thing, the Subject should start with "serial: port: ..."
And also should have PNP IRQ (capitalized).

> > The function __uart_read_properties doesn't cover pnp devices, so add irq
> 
> __uart_read_properties()
> 
> PNP
> IRQ
> 
> > processing for pnp devices in the branch.
> 
> PNP
> 
> ...
> 
> >  #include <linux/property.h>
> >  #include <linux/serial_core.h>
> >  #include <linux/spinlock.h>
> > +#include <linux/pnp.h>
> 
> Keep it ordered (in this context it should go before property.h).

-- 
With Best Regards,
Andy Shevchenko



