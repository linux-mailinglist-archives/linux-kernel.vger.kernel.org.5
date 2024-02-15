Return-Path: <linux-kernel+bounces-67579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261C3856DB5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D658028A31C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E391313959C;
	Thu, 15 Feb 2024 19:28:31 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6B41386A2;
	Thu, 15 Feb 2024 19:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708025311; cv=none; b=c7+T89N2qwENo/jJh33jBMNqen44uiaHX2dTDNImCIIpmjcfECLixzn2tvGVnBF8Yn419N8ijCFbbGt1Ew1c0ecjvNRU13ATuam2oqapC9gcwUg7fk6J6WkPsGp59jEAheiybxLhxOwKTcOK/sZrjXo5Gv3crswZS+BpN2Zxwtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708025311; c=relaxed/simple;
	bh=XyUpYMqm+MruYqEW1nlJVPSe9Fd8Xr4O/PW5oclYSzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdfjVeeHJZTiNvUbQ/8Gf1+1S3IZ122Ronv46PkoUohpNXVBVnRAwPlPxT28VBhBkq6r847K0T1v5NMp+wzWpUxEgAFHHRfjgIiocUHUeqBwSxqfywKo3Atp2ms4KC4IkaQjXun/uGOilX9lGIFofY5f7GKvccHokysHfGF/qTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="5947083"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="5947083"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 11:28:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="912216399"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="912216399"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 11:28:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1rahPF-00000004sFr-0Zb3;
	Thu, 15 Feb 2024 21:28:25 +0200
Date: Thu, 15 Feb 2024 21:28:24 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] spi: dw: Convert to using BITS_TO_BYTES() macro
Message-ID: <Zc5l2J2YpsnInZvt@smile.fi.intel.com>
References: <20240215180102.13887-1-fancer.lancer@gmail.com>
 <20240215180102.13887-2-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215180102.13887-2-fancer.lancer@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 15, 2024 at 09:00:46PM +0300, Serge Semin wrote:
> Since commit dd3e7cba1627 ("ocfs2/dlm: move BITS_TO_BYTES() to bitops.h
> for wider use") there is a generic helper available to calculate a number
> of bytes needed to accommodate the specified number of bits. Let's use it
> instead of the hard-coded DIV_ROUND_UP() macro function.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko



