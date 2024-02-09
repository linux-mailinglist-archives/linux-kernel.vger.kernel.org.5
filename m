Return-Path: <linux-kernel+bounces-59716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA7384FADB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52AB01C24E33
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A6D7BB0C;
	Fri,  9 Feb 2024 17:18:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B0369971;
	Fri,  9 Feb 2024 17:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707499088; cv=none; b=Cty5Y383HA/O+1U6xGaifDMpJVyK+2xsFJDvJEKxC1NDvrSlTWC8w+7/hRceuw+j8PyoFva7bIeY81+2B/ktSpVQjJebb8J1ReqJ4ITAyz3AWKPA7xA+aPAjZJHe/zwIAQ5tET7IqXprhI6YSYXq2AgwaKVdEcO9HGzQxWVYrgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707499088; c=relaxed/simple;
	bh=Dy+JjMgljdiiiDHtwEIR3FHiqoWmfBZMsPQGD2TR9ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzd+uJ8dO7AXBMh6btSLoB1+aSxxuC1i5uFIjF/cu9geY8Pzm0rj8DL0hc8KmYQLbF/JQy5VfjTSBETKyBbW8ZEBxXiNKmITdt7qYhq2hyEB6OtZvnzpKbZ/u7j6l29n5MiPLq86liV/yXmHk1Areemb0mniEPDFwmiWC0jFOQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1364537"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1364537"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 09:18:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="910769368"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="910769368"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 09:18:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1rYUVi-00000003D8J-2Oca;
	Fri, 09 Feb 2024 19:17:58 +0200
Date: Fri, 9 Feb 2024 19:17:58 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: George Stark <gnstark@salutedevices.com>
Cc: pavel@ucw.cz, lee@kernel.org, vadimp@nvidia.com, mpe@ellerman.id.au,
	npiggin@gmail.com, christophe.leroy@csgroup.eu, hdegoede@redhat.com,
	mazziesaccount@gmail.com, peterz@infradead.org, mingo@redhat.com,
	will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
	nikitos.tr@gmail.com, linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	kernel@salutedevices.com
Subject: Re: [PATCH v4 00/10] devm_led_classdev_register() usage problem
Message-ID: <ZcZeRmVjEPhVPW9-@smile.fi.intel.com>
References: <20231214173614.2820929-1-gnstark@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214173614.2820929-1-gnstark@salutedevices.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 14, 2023 at 08:36:04PM +0300, George Stark wrote:
> This patch series fixes the problem of devm_led_classdev_register misusing.
> 
> The basic problem is described in [1]. Shortly when devm_led_classdev_register()
> is used then led_classdev_unregister() called after driver's remove() callback.
> led_classdev_unregister() calls driver's brightness_set callback and that callback
> may use resources which were destroyed already in driver's remove().
> 
> After discussion with maintainers [2] [3] we decided:
> 1) don't touch led subsytem core code and don't remove led_set_brightness() from it
> but fix drivers
> 2) don't use devm_led_classdev_unregister
> 
> So the solution is to use devm wrappers for all resources
> driver's brightness_set() depends on. And introduce dedicated devm wrapper
> for mutex as it's often used resource.
> 
> [1] https://lore.kernel.org/lkml/8704539b-ed3b-44e6-aa82-586e2f895e2b@salutedevices.com/T/
> [2] https://lore.kernel.org/lkml/8704539b-ed3b-44e6-aa82-586e2f895e2b@salutedevices.com/T/#mc132b9b350fa51931b4fcfe14705d9f06e91421f
> [3] https://lore.kernel.org/lkml/8704539b-ed3b-44e6-aa82-586e2f895e2b@salutedevices.com/T/#mdbf572a85c33f869a553caf986b6228bb65c8383

Are you going to send an updated version with the amended second patch?

-- 
With Best Regards,
Andy Shevchenko



