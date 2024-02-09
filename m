Return-Path: <linux-kernel+bounces-59710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B899884FAC4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3051028C917
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6009F7D3ED;
	Fri,  9 Feb 2024 17:12:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6274983CAA;
	Fri,  9 Feb 2024 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498741; cv=none; b=S/251Gfp+XemIIxib0J/CnRSqHNMkEJR+vO6UvwvVpd74lfAXSn5h1uc55N2xqleenGFLe16+ASvzk0d92RWshGxqgzXJAtPQ3nQhB+I/YCuCu8YDy67oWjWx/0lC0KNxs/4ViNlNIq82sObWrQLcLj5eEd8rSWEoO0/YrQB6Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498741; c=relaxed/simple;
	bh=lsdWTSRPj487NZFyGU2JEB5etxJVaXSYuG6gjWqsrkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLM4RGLpRMh4lDhCoG6Z91+ngBGBT0OXgrpYROuHsdsEhHnWXSijB9slfPbpPeISdpDl8yspzDbd5ZMFnVGXIOq5QJSgAN73aP0BBchsr2kq+LIpQFd+xiyVczfVftiF1PFvjQ9jMAcfw4lluVzvQ2uW/AIsUIfbv+t88ekIMDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="5258945"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="5258945"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 09:11:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="910768835"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="910768835"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 09:11:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1rYUOz-00000003Cxy-3Zci;
	Fri, 09 Feb 2024 19:11:01 +0200
Date: Fri, 9 Feb 2024 19:11:01 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: George Stark <gnstark@salutedevices.com>, pavel@ucw.cz,
	vadimp@nvidia.com, mpe@ellerman.id.au, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, hdegoede@redhat.com,
	mazziesaccount@gmail.com, peterz@infradead.org, mingo@redhat.com,
	will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
	nikitos.tr@gmail.com, linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	kernel@salutedevices.com
Subject: Re: [PATCH v4 00/10] devm_led_classdev_register() usage problem
Message-ID: <ZcZcpUHygltD2ETa@smile.fi.intel.com>
References: <20231214173614.2820929-1-gnstark@salutedevices.com>
 <20231221151111.GJ10102@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221151111.GJ10102@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 21, 2023 at 03:11:11PM +0000, Lee Jones wrote:
> On Thu, 14 Dec 2023, George Stark wrote:
> 
> > This patch series fixes the problem of devm_led_classdev_register misusing.
> > 
> > The basic problem is described in [1]. Shortly when devm_led_classdev_register()
> > is used then led_classdev_unregister() called after driver's remove() callback.
> > led_classdev_unregister() calls driver's brightness_set callback and that callback
> > may use resources which were destroyed already in driver's remove().
> > 
> > After discussion with maintainers [2] [3] we decided:
> > 1) don't touch led subsytem core code and don't remove led_set_brightness() from it
> > but fix drivers
> > 2) don't use devm_led_classdev_unregister
> > 
> > So the solution is to use devm wrappers for all resources
> > driver's brightness_set() depends on. And introduce dedicated devm wrapper
> > for mutex as it's often used resource.
> > 
> > [1] https://lore.kernel.org/lkml/8704539b-ed3b-44e6-aa82-586e2f895e2b@salutedevices.com/T/
> > [2] https://lore.kernel.org/lkml/8704539b-ed3b-44e6-aa82-586e2f895e2b@salutedevices.com/T/#mc132b9b350fa51931b4fcfe14705d9f06e91421f
> > [3] https://lore.kernel.org/lkml/8704539b-ed3b-44e6-aa82-586e2f895e2b@salutedevices.com/T/#mdbf572a85c33f869a553caf986b6228bb65c8383

..

> FYI: I'll conduct my review once the locking side is settled.

To reduce burden can you apply the first one? It's a fix.

-- 
With Best Regards,
Andy Shevchenko



