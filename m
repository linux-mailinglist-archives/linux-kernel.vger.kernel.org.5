Return-Path: <linux-kernel+bounces-58549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA56584E7EB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9AA1F2CB95
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5A4208C6;
	Thu,  8 Feb 2024 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b/SD1BKV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBC71F952;
	Thu,  8 Feb 2024 18:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707417867; cv=none; b=DzvY976Gke4F9s9sshm3eZaQghoCTcNlhTQkhUly6k1QEi9bI2A0w6Ksrf+KYf3m+CzzVxz4SMyJ7Ags1NFfOIljjtDELkR9xO7oXMLDqTMVyi6OfMPeUP+3vA/hFReWEThJvHXYrF1xPa3EuNwtfv1C/MLFl6UsoYw/KhCE8Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707417867; c=relaxed/simple;
	bh=FwIEvbIyDlMFxgWm5210JjjZWsFfvyKu6CmmNNZp5jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIUvghTu2lya7IVZB84CM8XruD9frGkKcqkNGqk9JGLSwwaiOf/AdlCXeHnqHOuHgdXfiR5qI+0sIsRETgf/5xKMxW0QqKSwAeFkPO0AT7Yuq0AWIHr+pn/Km5N6IqltD6WXEixKxiMWbHXl3MzGOVuOy1aVYoxYiPpZ/pofN0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b/SD1BKV; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707417866; x=1738953866;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FwIEvbIyDlMFxgWm5210JjjZWsFfvyKu6CmmNNZp5jI=;
  b=b/SD1BKVq5TYzJ27UbnQWhK03y10mrugAqQpNDVk5nwNGq830sS2ghYU
   RPVRbZSb32xBXBbd5Iagdv30DjHEPCKVs6NPpjbKZY4WUCyqnidl5Ahdo
   JGVvkAH+t5ZMocL9Kk7Td8uaUyszxRxPr9YXGidxydfwtTHpe9cDXvDz5
   /g4KqNJWZKnRvvtCDbHdDSCPKWeGN8RzPWbv7HHI62fIFijL4ccrWPMD7
   HI5OsgMH3DCKrKAfT9NMlWuOaQeRKDP3PtzB9P67ON+kBjwIlpbNQdmwR
   PLfvpxleVaytJ3WlG/d8XKFZ+lV9DHXN2RuqU8eDVja003QxDQyjJrCSB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1178492"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1178492"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:44:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="910468017"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="910468017"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:44:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rY9Nk-00000002xKP-0qzB;
	Thu, 08 Feb 2024 20:44:20 +0200
Date: Thu, 8 Feb 2024 20:44:19 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Daniel Thompson <daniel.thompson@linaro.org>,
	Flavio Suligoi <f.suligoi@asem.it>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v3 1/3] backlight: mp3309c: Make use of device properties
Message-ID: <ZcUhA49GOI6nutHT@smile.fi.intel.com>
References: <20240208182608.2224191-1-andriy.shevchenko@linux.intel.com>
 <20240208182608.2224191-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208182608.2224191-2-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 08, 2024 at 08:24:46PM +0200, Andy Shevchenko wrote:
> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
> 
> Add mod_devicetable.h include.

It seems some emails are missing, I just sent a 'resend v3' hopefully without
missing parts.

-- 
With Best Regards,
Andy Shevchenko



