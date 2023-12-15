Return-Path: <linux-kernel+bounces-1125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE73814ADB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA62B1F24305
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9198C36AF3;
	Fri, 15 Dec 2023 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UcRvMBYd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8E83BB46;
	Fri, 15 Dec 2023 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702651357; x=1734187357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HZH7p7hPPuBDIjWYzgq4q7U8NRUcQMReIyTKkpM22AQ=;
  b=UcRvMBYdiOl9uDzy4AaoZ92c/pztSF+EBVwQmdTy0E6tf1wCK1BVsIT+
   uh4R1U4COBbikZkOQVyqMcFxCMSjT6CyKMYo7Ffz81bPWtQ+mfNU3Uwxa
   qjdYpYS2U7ZzyRaWsK0camNXHKrVci78Wl7qYXFcq0cbM+iCv14CNrnlx
   Q05gAmzqsnEd/AM0joG/+HtEU3faCSo8Ga8SD9NgYrYL/5eV6FwNR1lQY
   g+2NTRIS82nezuDJf2b6PDJHGOTU9fUgGEMkZIPhrSN6QKWCwVaQwTnWd
   gF+AlWhjHPZdOAXw28AczZXdO0G2urrTeLH3Ycg5I5OkdvS+QeAM08Y5p
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2450323"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="2450323"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 06:42:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="840685298"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="840685298"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 06:42:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rE9Oa-000000069Ce-0We4;
	Fri, 15 Dec 2023 16:42:32 +0200
Date: Fri, 15 Dec 2023 16:42:31 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Raag Jadav <raag.jadav@intel.com>, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: intel: Add Intel Meteor Point pin
 controller and GPIO support
Message-ID: <ZXxl161aJ8vZyiPw@smile.fi.intel.com>
References: <20231214154653.1087747-1-andriy.shevchenko@linux.intel.com>
 <20231215064417.GV1074920@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215064417.GV1074920@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Dec 15, 2023 at 08:44:17AM +0200, Mika Westerberg wrote:
> On Thu, Dec 14, 2023 at 05:46:53PM +0200, Andy Shevchenko wrote:
> > This driver supports pinctrl/GPIO hardware found on Intel Meteor Point
> > (a Meteor Lake PCH) providing users a pinctrl and GPIO interfaces
> > including GPIO interrupts.
> 
> This is driver for Meteor Lake-S and related, correct? Why it cannot use
> pinctrl-meteorlake.c instead? Same way we do for other desktop CPUs
> whose PCHs have the GPIO/pinctrl block.

Meteor Lake-S may or may not have an additional PCH, so the SoC (on-die)
pin control IP is serviced by pinctrl-meteorlake.c, here we need to have
a different file as we would have a name clash. Yes, it means that on
the end user platform it may be two pin control drivers!

-- 
With Best Regards,
Andy Shevchenko



