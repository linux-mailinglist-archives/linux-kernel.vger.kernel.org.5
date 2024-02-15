Return-Path: <linux-kernel+bounces-67586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 768CF856DC9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16C05B27048
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE87139563;
	Thu, 15 Feb 2024 19:32:31 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE6213959D;
	Thu, 15 Feb 2024 19:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708025550; cv=none; b=ey0WwccKyDl4Uel0+cs3jSkERDOhqJkF7L5tczFjncQKaXNMQd5kwdaEOGvgPkPEM34/IbQyblpVlLnhGhshaIGLZkSf0qIKgdQeVX8Rz/XZve5U/Ndx6tgaaN3xmK+f8L7arnYkc/GiP6ONRLugBZyefyNyC1dS8V9o0ALUesI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708025550; c=relaxed/simple;
	bh=0FW1mUswcLzm38bMkQPll4laEW8cSfpCg8npIV2qS0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLjc8ln9+oACo2qiuFLrirKs8DsLWO1saMmzKSd0Js6Cb1vP11J8lH2MG3ICawOYgw7SQLEZ3nMRa45rGdSTtrpmEyTQZ93bwNG0YB58LbTltixOrHeTxUGv+fld1L3ASH1QohJpOjs2UN8GxcPtZ1gG6HInR+2+VnDim/2H0no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="5947649"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="5947649"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 11:32:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="912217404"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="912217404"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 11:32:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1rahT6-00000004sIB-0ygV;
	Thu, 15 Feb 2024 21:32:24 +0200
Date: Thu, 15 Feb 2024 21:32:23 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] spi: dw: Drop default number of CS setting
Message-ID: <Zc5mxyTjq6X_QRsQ@smile.fi.intel.com>
References: <20240215180102.13887-1-fancer.lancer@gmail.com>
 <20240215180102.13887-4-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215180102.13887-4-fancer.lancer@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 15, 2024 at 09:00:48PM +0300, Serge Semin wrote:
> DW APB/AHB SSI core now supports the procedure which automatically
> determines the number of native CS. Thus there is no longer point in
> defaulting to four CS if platform doesn't specify the real number.

..

> -	num_cs = 4;

Simply update the default here?

> -	device_property_read_u32(&pdev->dev, "num-cs", &num_cs);
> -
> -	dws->num_cs = num_cs;

-- 
With Best Regards,
Andy Shevchenko



