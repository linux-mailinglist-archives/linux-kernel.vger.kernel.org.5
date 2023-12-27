Return-Path: <linux-kernel+bounces-12143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D9D81F083
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 959D0282AEE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACDB45946;
	Wed, 27 Dec 2023 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E12Q7fwL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D4D22062;
	Wed, 27 Dec 2023 16:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703695187; x=1735231187;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jQwOPiBl18k/nFpfaL9IxGct2oQszbXckZn45iQKbHg=;
  b=E12Q7fwLK8SVb1w+DokvZcxTM3+/QMO9Ge1GuxD7Sr0mDeBKKg3aBAE4
   KDjLQ9PxhzJUof/iwOqaE5oTqq02M84cNWpu8akH71lqHU3ynxMJoGVPq
   Au6Gkas0/pmC+VPsKry7I1UJSJd2gFVbychTUoT0Q7fjueAz+zTn1lhzZ
   ErkDPEgql+rA/aRCOqDuesIspmShtKOTIDVuScAiu4py8aWhsMyw02HVU
   Gxiv2XEjM97c1D2DBO5Ti1d/wUgFaHOaG42hUOJdnAoqn3OhtXatiZKtu
   UtI/fz7yqLpZLVKSKdy0KooIdj8Oq7bvfZ4/nz2WlBBg4yiKG9DEr6YwY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="3293145"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="3293145"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 08:39:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="896949296"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="896949296"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 08:39:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rIWwV-00000009Su6-2ShE;
	Wed, 27 Dec 2023 18:39:39 +0200
Date: Wed, 27 Dec 2023 18:39:39 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Tero Kristo <kristo@kernel.org>, Tony Lindgren <tony@atomide.com>,
	LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Subject: Re: [PATCH 00/10] clk: ti: Adjustments for eight function
 implementations
Message-ID: <ZYxTS6Cfm_c0WgXS@smile.fi.intel.com>
References: <20849a8e-e0f5-46df-ad8a-9eae6cbe337b@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20849a8e-e0f5-46df-ad8a-9eae6cbe337b@web.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Dec 24, 2023 at 05:33:53PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 24 Dec 2023 17:03:21 +0100
> 
> Several update suggestions were taken into account
> from static source code analysis.

Unneeded churn, if you want to make it better, switch the code to use
cleanup.h.

-- 
With Best Regards,
Andy Shevchenko



