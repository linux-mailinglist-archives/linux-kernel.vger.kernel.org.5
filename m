Return-Path: <linux-kernel+bounces-133230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5119389A0E6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03FD3287497
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A6216F8F5;
	Fri,  5 Apr 2024 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bw87D4sm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884D916F850;
	Fri,  5 Apr 2024 15:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330436; cv=none; b=Bi+OOTJtJ6YsHwwTp3fRa/5kMiWdh+UWR6r3LVyHsBWTj/SKWoVDWAtsLfOT+cUI+yCTb8f7p+H66OaCvCdEbmln03j4YARc0SFpNkNnpiRRUoYMEThfL4cuRGQD3a+5WwwygmieB2WGSM8RdTJdHCFWZ3jw3ZPOg1CffRoudIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330436; c=relaxed/simple;
	bh=iLxrV8OLJBLSSBzXUgsi4X41ZUQ9qZyi/i2pZUh7N7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rwdd7Ix496zXgwSaHQU3sFNbJfxXNr3we0uY2Rv/+tky6Oy6LG6vd8XJTSG8F3zQkwKDUDIU5aY8D2mCo9KlK7vpwFvtKZsQp4tcz39bHwHa+UolmQHcA2CEB1HC/qk7cDF3QR6nwsADei/HBhzK5/viHjBJ+mghoBJFfLMnmuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bw87D4sm; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712330435; x=1743866435;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iLxrV8OLJBLSSBzXUgsi4X41ZUQ9qZyi/i2pZUh7N7I=;
  b=bw87D4smkCBV+1eJs+tsSxCn3h5EWtitz+tKFP4Ami0dPDNeuC7gGVal
   BM/kwxIqNF7rcx+rV/MoWhCcuuW1c9R1mrwD6be5nNaCV8TRTMROq7ugE
   J7wMB9uL7cwvnDY0DjdxkM6n0Rm4ikMEftJ0kVZvRAD6xdUpaZ2+eA/Fg
   oMFC5RP8vnJTlkZTPoMxPqhRP3jkuxzo0LKP+m+LVSAOl5dGrzI+PxSmM
   WnU4VyRDLQ78JGJ8o4kVpqw8VG1IbCRk8L5Sv/xhpkICRbJq7uzu11/lv
   l/vBFJkasNofNOyPufiI1p/v0IFODayzwgbvChy0ZpGpgo111PyLfSoT5
   w==;
X-CSE-ConnectionGUID: oja9SY2aQUa2nskqpEZhYg==
X-CSE-MsgGUID: 5nZZc+FTQcqtMVdZ9NcqAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="18274366"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="18274366"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 08:20:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="915256791"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="915256791"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 08:19:58 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rslMC-00000001mVO-1PB5;
	Fri, 05 Apr 2024 18:19:56 +0300
Date: Fri, 5 Apr 2024 18:19:56 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 3/4] ACPI: x86: Move blacklist to x86 folder
Message-ID: <ZhAWnOMaIcgXykft@smile.fi.intel.com>
References: <20240404183448.3310449-1-andriy.shevchenko@linux.intel.com>
 <20240404183448.3310449-4-andriy.shevchenko@linux.intel.com>
 <311c6f62-4232-417a-beb8-df9ca8a732ec@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <311c6f62-4232-417a-beb8-df9ca8a732ec@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 05, 2024 at 07:44:15AM -0700, Kuppuswamy Sathyanarayanan wrote:
> 
> On 4/4/24 11:23 AM, Andy Shevchenko wrote:
> > blacklist is built solely for x86, move it to the respective folder.
> 
> Don't you need #ifdef CONFIG_X86 for acpi_blacklisted() in
> include/linux/acpi.h

It's unrelated to this series.
It was like that before and this series doesn't change this aspect.

AFAICS the API is called from x86 only, that's why it's not a problem,
but strictly speaking you are right. Feel free to submit a patch.

-- 
With Best Regards,
Andy Shevchenko



