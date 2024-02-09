Return-Path: <linux-kernel+bounces-59530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC1D84F86D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D053A1F257CF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05FB73181;
	Fri,  9 Feb 2024 15:24:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DCB692FC;
	Fri,  9 Feb 2024 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707492289; cv=none; b=V2g4ALKCepYPXSeW64NJ4CQGmbU31UX8YnnjFQOJ0H5XrIINyJMt4mLvlO4iLRgRG12t7ASVLXsKpsxqNIbbXeAGhOh2isMGL4AEvP+ZppGOnsDT3ClRsXJ0INfNRuUqsmEJc7qJ8qsTkUsUdheSjmKmE1+WfovCwvtQOCH9Aqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707492289; c=relaxed/simple;
	bh=RM8H6bUC9U8mMKpRD9Ey5fbo1RLNZ1HsaM1tQ1l/zIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m38dJZ8rHZnVfVXviwk5nXU2tsS8mO+fqLuS9vAUs7rrV4t35CJE/xJ9BKmDevqsN1HJIPbnxq+1+aOQa5NqhaV42EaCvLic7P/Ptek6RorF3ZroX67NtB/KaR7i9VmkTSMpcF/16H3GUMyJxvLD0slbzjHLlXCSykkT9JO/Gs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=black.fi.intel.com; spf=pass smtp.mailfrom=intel.com; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=black.fi.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1325892"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1325892"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 07:24:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="934452854"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="934452854"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Feb 2024 07:24:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A16F7159; Fri,  9 Feb 2024 17:24:42 +0200 (EET)
Date: Fri, 9 Feb 2024 17:24:42 +0200
From: Andy Shevchenko <andy@black.fi.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
	Jonathan Corbet <corbet@lwn.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	James Clark <james.clark@arm.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 31/32] spi: Drop compat layer from renaming "master"
 to "controller"
Message-ID: <ZcZDugcgkClwX7qp@black.fi.intel.com>
References: <cover.1707324793.git.u.kleine-koenig@pengutronix.de>
 <ad1d949325b61a4682e8d6ecf9d05da751e6a99f.1707324794.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad1d949325b61a4682e8d6ecf9d05da751e6a99f.1707324794.git.u.kleine-koenig@pengutronix.de>

On Wed, Feb 07, 2024 at 07:40:45PM +0100, Uwe Kleine-König wrote:
> Now that all in-tree users followed the rename, the compat stuff can go
> away.  This completes the renaming started with commit 8caab75fd2c2
> ("spi: Generalize SPI "master" to "controller"")

It does not complete the conversion.
We still have spi_alloc_master/slave.

Besides, we still have drivers that use master/slave terminology in
their (local) variables, functions and data type names.

-- 
With Best Regards,
Andy Shevchenko



