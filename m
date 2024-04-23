Return-Path: <linux-kernel+bounces-155593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 930D38AF48F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37FDD1F247F1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A8E13D52C;
	Tue, 23 Apr 2024 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bshuNDet"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F5513D516;
	Tue, 23 Apr 2024 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713890794; cv=none; b=jprMI7BQfZdQr0+yXi4YB3a+YBm+e0H7vePXdwWe28fQBmgS1yoUfmCRvKTywfgq5JsYcb/E4+zDZHaMO3JL4b3bY7it5hKNpFIyrwfWCcQ/M1DoaaAmzGYMC/pntOM3lrvI/Hqi5uq3LpI4M99CFuT7j5/7iCyXXMyDrWDWetM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713890794; c=relaxed/simple;
	bh=X04TMGUEoTQq6ssKaWRAYwBOvxwm4/UkOVHluKDUc0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGRupVmhl3CXee9vUIwaQAW6iCGNYd0xlBYKA0ZJl0tHaeo572L67rJfIP0SBITPcirxJMCv6mxv45HbvManftjeLnjsc6DkdxpIt+fQulrICa3T93rAVwqp7NJsa7+GQpKTfp4ESFf86q1tubpBsR+Isl1RH8901CuzuJkIYVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bshuNDet; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713890793; x=1745426793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X04TMGUEoTQq6ssKaWRAYwBOvxwm4/UkOVHluKDUc0A=;
  b=bshuNDetZQUu+e83KRVePRP2DDg0IGsiP0lb9ymxwaxVj73RhQ49+h+0
   yaXVtc+kwkLYLGfMIYSge7TwOldsKptL19MNbNZBj0wHUI0sS9Ypmbr+u
   7wm0d56dACDY7lUPm2thEmntOXnO4tuli7bdqcpQwFh3HnmAMtx219mZx
   6yvbLNzPgf+4+3Z9zNSIGfhvYwtYy8QXDrHY3EnvCji4sUU14ca7d2eBH
   AgfW/EL9Hcd6aqZlREbdG4tUEYAnCgxgmUruI5ooBzB4VVLYK4a62fEoi
   YLd/BrizC4qF3q7kQAzUKDkh6eG65vXjBDmPqCXhKmkLqvb1XJ46ceqts
   w==;
X-CSE-ConnectionGUID: cEgt2psCQ9iaVuqwsDn6bQ==
X-CSE-MsgGUID: vTy7pJI/R1SACFn3lneJ5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9318061"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9318061"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 09:46:32 -0700
X-CSE-ConnectionGUID: fx3hzkhmRTKzdTyvq2YGIw==
X-CSE-MsgGUID: tQSw8qZSSl+Gasbx+7P2Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24395789"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 09:46:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzJHo-00000000Osh-1HrE;
	Tue, 23 Apr 2024 19:46:28 +0300
Date: Tue, 23 Apr 2024 19:46:28 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Jani Nikula <jani.nikula@intel.com>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] Documentation: process: Recommend to put Cc: tags
 after cutter '---' line
Message-ID: <Zifl5PAAD1GTLWSK@smile.fi.intel.com>
References: <20240423132024.2368662-1-andriy.shevchenko@linux.intel.com>
 <20240423132024.2368662-3-andriy.shevchenko@linux.intel.com>
 <871q6wrw12.fsf@intel.com>
 <ZifHnw1cxgP77MKx@smile.fi.intel.com>
 <878r14yw8n.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878r14yw8n.fsf@meer.lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 23, 2024 at 08:44:24AM -0600, Jonathan Corbet wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> 
> >> A lot of patches get sent with
> >> more Cc's in the mail message than in the commit message.
> >
> > Note, this is the recommendation as it's stated. You can continue polluting
> > the environment on your wish.
> 
> The environmental case here is ... not strong.
> 
> I, too, have my doubts about this recommendation; responding this way is
> not going to change a lot of minds, IMO.

Let's see how discussion will go.

Nevertheless, there seem no objections against the first patch in the series.
Can it be applied?

-- 
With Best Regards,
Andy Shevchenko



