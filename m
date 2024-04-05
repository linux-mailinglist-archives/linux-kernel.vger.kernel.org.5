Return-Path: <linux-kernel+bounces-133231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B7789A0E8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88AAE1F2469C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FE716F90E;
	Fri,  5 Apr 2024 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mioocbvm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D466616F856;
	Fri,  5 Apr 2024 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330437; cv=none; b=emXm9w2DQvkPXnjoFwLzRKRrbK4jtJrDZ8B6sx6LLMYDiIVl7fl0FYY6vwz4vjavP34YmYcPlt3jIHSO5tXAnlUB26DRh2bobvftQiYMTRO7ADUID4wJedVyvnJUHwtW23dJBHg0HDF1aR3LcRvznc9sIU9A0II6QbBnCmcn0YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330437; c=relaxed/simple;
	bh=/FxoBaNkGIGWaL8ag3j0vat6e54Em4sF2CHGCNnJtrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yat0Uv7KiQ5XDcPmitVPesRj18F30xK7pO8bEKUKIYea/K26GwPdEj5DOZFE4Fw+OOgXYACX/OKZTCxlMBR58BQRo2HpNx80ONtPxkFEnmtITyHY7tVa3SSX1oizKNyhEGX6XbJZ9/DPP+YZAIaGwPmTTHfFFyRQn1FK2NnFK9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mioocbvm; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712330436; x=1743866436;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/FxoBaNkGIGWaL8ag3j0vat6e54Em4sF2CHGCNnJtrc=;
  b=MioocbvmoO8g0vr5/wnKmMzdmgxce7fwkz9qIgJdLiqQEgTCC0KisPAE
   C3N1m6m3QxBz4tWWbi0Ejmludn9tfzvLVxeR5xrLgZ8U5+Q3pA86a+OPg
   38MH3NHvN6YF7rEXWEM3P7hu3jcVYPHCrJlPlb6NLTvNK26IRGcm9uLCV
   edd8z6h4U8bCUeI307D2Ojiu6iXFOYWI1FwtoOoRTnGZYn409RdxP0elt
   MVhbUpzeaWaUmg3CA/HfpY6JzRZwt/6VQwpyJyuuHLW3J3YbkQI0KA21d
   hNgxaMr3tNuRdnAPp6xFV+4MJCWLA8ILnhLJ2qVPcWIsVqyDJXxOyRj0R
   Q==;
X-CSE-ConnectionGUID: bn0z4aisQfCOW3k4PlbKPA==
X-CSE-MsgGUID: VYb91UKlQF2xXa0eT+Bqvg==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="18274397"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="18274397"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 08:20:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="915256804"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="915256804"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 08:20:21 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rslMY-00000001mVm-3HN5;
	Fri, 05 Apr 2024 18:20:18 +0300
Date: Fri, 5 Apr 2024 18:20:18 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 0/4] ACPI: x86: Move x86 stuff into dedicated folder
Message-ID: <ZhAWsg4WBPNRyNyB@smile.fi.intel.com>
References: <20240404183448.3310449-1-andriy.shevchenko@linux.intel.com>
 <aac4b3ea-72dc-4afd-8f1f-06821de953c4@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aac4b3ea-72dc-4afd-8f1f-06821de953c4@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 05, 2024 at 07:45:29AM -0700, Kuppuswamy Sathyanarayanan wrote:
> 
> On 4/4/24 11:23 AM, Andy Shevchenko wrote:
> > Move x86 related modules (which are solely for x86) to the dedicated
> > folder.
> > Note, there are more modules, but they are related to tables and
> > potentially might be used for other architectures in the future.
> > Hence touched only non-table related code.
> 
> Except the blacklisted patch Nit, rest looks good to me.

Not sure how that related (see my reply).

> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko



