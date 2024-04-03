Return-Path: <linux-kernel+bounces-129460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFB3896B5A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBCA1B2C365
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA5B1350DB;
	Wed,  3 Apr 2024 09:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GILhvSpi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39E445977;
	Wed,  3 Apr 2024 09:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138089; cv=none; b=Ac6eFW2nD6d7a6+JIanMt/JbF+j2VE+5wSEV15FDXS6rLvGXMQhUNeS1+gC61+S+0bwJ3uH68YTHHUzZTmwUfi9WPV4Ls62iKttANTgsW/JJ/BW45u6vWnrjkTz3JOoeVh7uGKeE8kw4dEH07bVC8lFp2Wdigz06bvfaYGxiw24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138089; c=relaxed/simple;
	bh=A2CL1ofQoEGLwEJlow8AfmxUR9gVZAq0lKbB9yM/nfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZol4vLPPOkiYYGNLdgfPk7X1Uku30T4oD34rzLYrdq1o29ro+/0n4sZ4bIFo+AS3D62XZcKebbx8rFxf7FKtyJlrq/YuLK9iITgQumjSumx/vIKFD41UFAbP2m9e3gD8TNohMJFKttFxZWnAIzO+wEVqq671/mxieBDt8KrPCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GILhvSpi; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712138088; x=1743674088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A2CL1ofQoEGLwEJlow8AfmxUR9gVZAq0lKbB9yM/nfM=;
  b=GILhvSpiYpXFMVzRkyjR3SAeSM43XXwdTShcqYNFjcfQwhxqP0Y11cC/
   ClUiyyepJSzwIX265nQPqktAlMgBh6766vC5yXB16QCzzWlgRUg1gbFq9
   2sFSgOdkjvC5h4/MZHlywnHkVHzzRGObNoWvH9KgJ76yPfXzjaov5K9+0
   cY68dbKlyQln3eGMq2X59fhXbk6isbL5serijdlHuwvDaTkkVClfxRTaO
   9zmNEP1Pu6fhm0Lv2ZNyGhxpwU36sFjjbaLBEPu7+IX1Jk+YkEqPbM1ac
   2q0tX8x7Rdqxe70fC5FZrymvY7SUel8jdj8JMxvJjPiJ/5lg2Rc1fkUeU
   A==;
X-CSE-ConnectionGUID: yMDYYtfmTRO9ZQxrRdT76Q==
X-CSE-MsgGUID: +ixE62QRSoibxyHNueb0jw==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7484482"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7484482"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 02:54:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="915176835"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="915176835"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 02:54:42 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rrxKK-0000000156X-1oA9;
	Wed, 03 Apr 2024 12:54:40 +0300
Date: Wed, 3 Apr 2024 12:54:40 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guanbing Huang <albanhuang@outlook.com>
Cc: gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
	linux-acpi@vger.kernel.org, tony@atomide.com,
	john.ogness@linutronix.de, yangyicong@hisilicon.com,
	jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, lvjianmin@loongson.cn,
	albanhuang@tencent.com, tombinfan@tencent.com
Subject: Re: [PATCH v4 1/3] pnp: Add dev_is_pnp() macro
Message-ID: <Zg0nYNWKh9x3r-bN@smile.fi.intel.com>
References: <20240403074130.93811-1-albanhuang@outlook.com>
 <PSAPR06MB4952DCB31578A5CB547612E3C93D2@PSAPR06MB4952.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSAPR06MB4952DCB31578A5CB547612E3C93D2@PSAPR06MB4952.apcprd06.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 03, 2024 at 03:41:28PM +0800, Guanbing Huang wrote:
> From: Guanbing Huang <albanhuang@tencent.com>
> 
> Add dev_is_pnp() macro to determine whether the device is a pnp device.

PNP

Suggested-by?

-- 
With Best Regards,
Andy Shevchenko



