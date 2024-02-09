Return-Path: <linux-kernel+bounces-59527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A457584F864
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D07041C23880
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFC571B59;
	Fri,  9 Feb 2024 15:23:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E8B6A018;
	Fri,  9 Feb 2024 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707492190; cv=none; b=c5+lNnFq93E4Lv52l+Czcr6BI0A/x+arK+CwKvtMyoifL3uWJ3wZcIL6VP+5eFn0Eos+jOL9mTPrOebsEziAWMyzCo90JeUi/wgLbAboYDzCGMAOoaRpZbOUCjuz6PVcOzSpUisv4olH2mLshBxVqF754NxTmbLcHIhNQ+rp7nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707492190; c=relaxed/simple;
	bh=m2GtP3oJbma8OSgw9pn0bkUtgTo97dKzEZVlHy7h6nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iz5m+g866t1A06upNPECLVtzDrTetHMfFtPuw+UZ5ONXuaO5tdtdJJYr+H/sCB1OSgvLTCPWhmgw23A0loVAjNKa1OEmS+zy6DBjrkemgK1PuWY25PqQwoPhT4bBrpcKO7U757KglFVON6349l54m9DBHbGztYpwsfIQw36w6e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=black.fi.intel.com; spf=pass smtp.mailfrom=intel.com; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=black.fi.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1325539"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1325539"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 07:23:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="934452278"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="934452278"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Feb 2024 07:23:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 02498159; Fri,  9 Feb 2024 17:23:04 +0200 (EET)
Date: Fri, 9 Feb 2024 17:23:04 +0200
From: Andy Shevchenko <andy@black.fi.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 32/32] Documentation: spi: Update documentation for
 renaming "master" to "controller"
Message-ID: <ZcZDWC7wQa-V_1Uv@black.fi.intel.com>
References: <cover.1707324793.git.u.kleine-koenig@pengutronix.de>
 <3d643e22cacff12d3918ad5224baa1d01813d03b.1707324794.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d643e22cacff12d3918ad5224baa1d01813d03b.1707324794.git.u.kleine-koenig@pengutronix.de>

On Wed, Feb 07, 2024 at 07:40:46PM +0100, Uwe Kleine-König wrote:
> In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> some functions and struct members were renamed. Adapt the documentation
> accordingly.

Somebody should add a section about terminology.
Now we have again desynchonized (some are using 'host controller' /
'peripheral device'). As a result some drivers are defining variables
and data structures with this schema.

-- 
With Best Regards,
Andy Shevchenko



