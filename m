Return-Path: <linux-kernel+bounces-7385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B3C81A71C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 19:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D62B1F247C1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8BA482DD;
	Wed, 20 Dec 2023 18:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iDELFlwJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949CA48780;
	Wed, 20 Dec 2023 18:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703098762; x=1734634762;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=184wfVeRsZsRRSUfgwuXxQObsh2TcUFX29/02AsW3lc=;
  b=iDELFlwJSLtY3dILCmujTER6eohVkXcYRBxVYszh9S2EOBE/u+i0G1EI
   iEZgYti84ZdOprVB8+X691f7nlvsltAhdaAa6ayr59u6rX6dvuDxEKkZi
   vDcl9sEeYpdYGFVyrgC3D03zGT+nK+cccHIBuPvayK5vkDWqy8dhkXz87
   Fic9rDLpNYZMlTEWqPpqbPP8A+sJlm7r/jcXzFRp18jglIa/5c3mBY7z0
   HwY0AAnuKgI5soxuKYTwuqJTS37mW6K3Dg0oNwNPXSswbNIB3NsWMqMzQ
   m8vPRkC9lIYEASgZeeJDFqU1iUMKJ8nU78rLzkdy3P9B2xbQ3mPSfnRiP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="380850926"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="380850926"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 10:59:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="894807088"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="894807088"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 10:59:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rG1ml-00000007eh8-2lQn;
	Wed, 20 Dec 2023 20:59:15 +0200
Date: Wed, 20 Dec 2023 20:59:15 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, jringle@gridpoint.com,
	kubakici@wp.pl, phil@raspberrypi.org, bo.svangard@embeddedart.se,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 08/18] serial: sc16is7xx: add driver name to struct
 uart_driver
Message-ID: <ZYM5g0pJk2FhckDu@smile.fi.intel.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
 <20231219171903.3530985-9-hugo@hugovil.com>
 <ZYMMs5A758h12AEM@smile.fi.intel.com>
 <20231220111136.99315587e832190a528f7630@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220111136.99315587e832190a528f7630@hugovil.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 20, 2023 at 11:11:36AM -0500, Hugo Villeneuve wrote:
> On Wed, 20 Dec 2023 17:48:03 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Tue, Dec 19, 2023 at 12:18:52PM -0500, Hugo Villeneuve wrote:

...

> > "Useless use of cat" (you can google for this phrase, it's famous).

> Interesting read!

Yep! Then there are categories: (instead of "cat" you may use) "grep", "gzip"
(e.g., better use zless / zgrep) and so on :-)

-- 
With Best Regards,
Andy Shevchenko



