Return-Path: <linux-kernel+bounces-119246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B9388C617
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9DEB1F6559F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C0713C81C;
	Tue, 26 Mar 2024 15:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R8skvvph"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F10513C803
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465227; cv=none; b=tP8YisaUL/3eDI/o3VWumDWeAn8+hczmdHuRLSIi+1b4K+58tMf0OefKLRAM0GcIuHdw0vPntDxXd8rUy11CYnFe6tTOFme8pFTN2fKIkc7Jrp9WW7c43mYRbRr30+gYYTQ8KSgBmJ0gboplyLnQTu6kUUmrtZqItaZm3h2a4+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465227; c=relaxed/simple;
	bh=qUUvhGe91HR/wsvtB7K0cyzfk4u4vLEk2tLsleCKi1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpT/o0j58FjB03M5wjgE9KyzbjDjllP55RjxArEw8bCoJ0swgO6Bv1C0voWoDYn8QS4nAEYgugrhdJ3Jccz2mdTzpZMPyS2pCmF7c77Kwgvx0EG9zU452scl9Ug2zQIvzWYLAa/XSb7o8pMxbvPF9SP7XaFCZKN+x4aPMOYpbXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R8skvvph; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711465227; x=1743001227;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qUUvhGe91HR/wsvtB7K0cyzfk4u4vLEk2tLsleCKi1Q=;
  b=R8skvvphTzaoMR+Y9DFHEYRMULlEyR5hgBmQ3zHMAFz/FyLnh6odak0H
   vHrSG4qnlptIgL7lXEDope2POW8fi/s2ie+QOsa0JsV63dGyC+ZHPXJGI
   SR8LsFZQ3AIlPP/ADyphjW8NB2IiCnPhHk/kmJYVhp1UC7aDYT4ADJrTZ
   odO4LP2J7+4wkX8TN/vwWQsnr0oU032yknJ9cCgZ59nsZEoX8Ht1AUcYt
   D6ytmExB1DP6bF0oFD39aUh9T0UukhncVZm2srSfWn4HDDXZkV9QLEKKI
   nFMek2gUYfV0ByUrT7U+J4NnwbpUoDccylbyfwDrbYX/nOf5U19hfBIG8
   A==;
X-CSE-ConnectionGUID: PlSfnVXfRxKuxRiw2JPeLw==
X-CSE-MsgGUID: 2/WQUYCKQSK29nxzgrOiSA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6414839"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6414839"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 08:00:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914882655"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="914882655"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 08:00:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rp8Hj-0000000GKif-1YRd;
	Tue, 26 Mar 2024 17:00:19 +0200
Date: Tue, 26 Mar 2024 17:00:19 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, robh+dt@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, kevin-lu@ti.com,
	13916275206@139.com, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
	yung-chuan.liao@linux.intel.com, broonie@kernel.org, soyer@irl.hu
Subject: Re: [PATCH v1 2/8] ALSA: hda/tas2781: Add tas2781 SPI-based driver
Message-ID: <ZgLjAz99JZQvrx_h@smile.fi.intel.com>
References: <20240326010905.2147-1-baojun.xu@ti.com>
 <20240326010905.2147-2-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326010905.2147-2-baojun.xu@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 26, 2024 at 09:08:59AM +0800, Baojun Xu wrote:
> Add TXNW2781 support in smi.

Same comment WRT the commit message.

I'm wondering why the patch 1&2 can't be folded...
If this should go separate, with the commit message fixed,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



