Return-Path: <linux-kernel+bounces-128322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE1089594F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC367B28BF1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F7E14BF93;
	Tue,  2 Apr 2024 16:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HxV+gvzw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E4A14B075
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 16:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712074131; cv=none; b=FSRldNMgkXwEHKtiqEv8NEUXECV0ZH1We5GZ6dLZ0wPHY5/+lkzU0MI9qVd3EfLb9RTsB1NI8VvJ9Ljjn/7mFQKqmfUQ3j6DORuVJ/dGlUAC3iVT+TFe+GxorQ3ORUVDcvISbwaapxfzwGsvxtTJNWpNqh5SUWsc0W5C0rSDwx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712074131; c=relaxed/simple;
	bh=+cooX29KsUZPskI4kS+tTsbzu2UXdAVR11S7vVNuXXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXAIup3vlBcix7YnFrUlwFQyOTthYxUdcEsahaBFGTkAGBYOmN12XmruHAQ9eoW3AbaHKaLVoV+8MzOTfAc/hwB879AS2CczGPbZDJIShKia4PpaZY+VGaFWfhHM0MLmFdet40+n0GnjQ5jyjc1Fu2hG1/FQk1sEMsePB2ytn0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HxV+gvzw; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712074130; x=1743610130;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+cooX29KsUZPskI4kS+tTsbzu2UXdAVR11S7vVNuXXI=;
  b=HxV+gvzw2Vz0yFFauvTauNpzQwidQCWtKq7WNJ86+kDvgkKzlNgb0Lkr
   O/Xb6as9P/d939Pc+MxWldk80ItstrpG0YPY/ceCWFy/sMmrg2CRTxauo
   O9GsmefUfEF8M5rCtx8ODZtZ0vPxSOGO4P3qSkOlkqPlnd4PSb86ZG/Ah
   f0ILlyXKljmxWzHXXwsyVGgH7XVBWSVm3smNv8VYqYYhbecVFSSGo1Mpf
   krYdd0UPvQ5+9UG215GYizZcBPRremeARNlo7onPGwpwaNKD8+IT16Ekz
   YiXp5n6jyyn7DAqWg7AFhmnLK4Hnp/ZOB/un5ZflquGaukTq+1svdmKG8
   w==;
X-CSE-ConnectionGUID: XUuT58I+SwG5nzHUjpiA+A==
X-CSE-MsgGUID: 3en1JOfhS/G7vOviQAl29w==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="10223973"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="10223973"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 09:07:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="915145652"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="915145652"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 09:07:31 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rrgfZ-00000000r5i-2r0s;
	Tue, 02 Apr 2024 19:07:29 +0300
Date: Tue, 2 Apr 2024 19:07:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 1/1] auxdisplay: linedisp: Group display drivers
 together
Message-ID: <ZgwtQWMs8oz7NxnB@smile.fi.intel.com>
References: <20240326190550.1421216-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326190550.1421216-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 26, 2024 at 09:05:28PM +0200, Andy Shevchenko wrote:
> For better usability group the display drivers together in Kconfig.
> With this we will have the following sections:
>   - Character LCD
>   - Samsung KS0108 LCD controller
>   - Single character line display
>   - Character LCD with non-conforming interface
> 
> Keep Makefile entries sorted alphabetically.
> 
> While at it, drop redundant 'default n' entries.

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko



