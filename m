Return-Path: <linux-kernel+bounces-155591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8288AF488
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA581C23CCD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C4813D51B;
	Tue, 23 Apr 2024 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Br4cDyEW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA7E13B78A;
	Tue, 23 Apr 2024 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713890741; cv=none; b=m2Q+jdSpVXrR+qe5talMJiFFEzghC6bq3GS6jTrOLvSAKxkzC0ZDWGDptfHzBGEoXp6wCMXnRnU8GznvmRC8xF2MWNK6UvUFTL2qoBLD80Gh7O1yMHSYhDX2sQ9DAlAFUtCeN6a8DoV4UxUpIqREwevdgCoTz+1lIvKaxjtX6LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713890741; c=relaxed/simple;
	bh=ylGPiC11Rh1IR0lbQDb6F+buZSZZaXAcX2MKtgj4y+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQKPd6xueuQlna4tQWA8Ho3gkYEWoe6pcZOn+kBZ+JowVuDPikPEZdZwlEn8ePjDgN8yKkYG3cHR7qrLYYRkTou2rlA7+mx+GhHcwg4GJb0FtkSOwVNBNI/lOPUnjWsAOXAxGhSHyj9Ao/MTAqslp2iHarQ9xs9hd1xYHZxPjhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Br4cDyEW; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713890740; x=1745426740;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ylGPiC11Rh1IR0lbQDb6F+buZSZZaXAcX2MKtgj4y+E=;
  b=Br4cDyEWLtSsCNdp0+ITJgDGUXuL0fRWG/fK90BT518AWlyeNMTJqSKz
   i1nrCVq6qeblODyOObp6cdtA0YUN0JFDzQvPB9ZQALfsqasb/ZftgIg+N
   rTm/rzggoddCfSDYX6QpkWm1ulp3vGuc4UfX/gVXO9CwE+HTP0NJXDyeW
   rf1G1aqUEfyPcvcbyieSSIX5EqJaZvwv25Q4v5Z7n6qb3GDzoDXb/YmWU
   b9DnXPitzSSI/+pRPZBIqppSFdMJjZejG9eNhYV2FYLV3lwMVUZgyE8fe
   ZbOeNQ+nKoyiTh1b7Cd0YIb6RCF5m0kZ2OQTtH12ekATrwyTnnHjNDL00
   w==;
X-CSE-ConnectionGUID: jXC4Fv2cT1W7je7Wkv3gkA==
X-CSE-MsgGUID: 5IA2DsAqQxqCMUYtJivTFA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9706257"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9706257"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 09:45:39 -0700
X-CSE-ConnectionGUID: UQl0iVxrQky/oUGb9NmS6g==
X-CSE-MsgGUID: RuE1ny//QJSQSHUU0wE5EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="28916984"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 09:45:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzJGx-00000000Os0-1WUN;
	Tue, 23 Apr 2024 19:45:35 +0300
Date: Tue, 23 Apr 2024 19:45:35 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jani Nikula <jani.nikula@intel.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v1 2/2] Documentation: process: Recommend to put Cc: tags
 after cutter '---' line
Message-ID: <Ziflr9ag4Nl2lTic@smile.fi.intel.com>
References: <20240423132024.2368662-1-andriy.shevchenko@linux.intel.com>
 <20240423132024.2368662-3-andriy.shevchenko@linux.intel.com>
 <871q6wrw12.fsf@intel.com>
 <ZifHnw1cxgP77MKx@smile.fi.intel.com>
 <87ttjsqbld.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttjsqbld.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 23, 2024 at 07:37:34PM +0300, Jani Nikula wrote:
> On Tue, 23 Apr 2024, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Apr 23, 2024 at 05:30:49PM +0300, Jani Nikula wrote:
> >> The Cc's on the mailing list archive are harder to dig up, and do not
> >> accurately reflect the same information.
> >
> > How comes? These Cc: are 1:1 mapped to the Cc: email headers.
> 
> Patch Cc's get mapped to email Cc's depending on personal git sendemail
> configuration.
> 
> People can add more Cc's in the emails when sending.

So, which exactly a proof why email headers are better for that, as they
reflect _reality_.

> Mailing list Cc's actually present in the archives depend on mailing
> list manager configuration, and, in some cases, even the personal list
> preferences of individual subscribers.

-- 
With Best Regards,
Andy Shevchenko



