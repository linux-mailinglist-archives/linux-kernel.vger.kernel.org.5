Return-Path: <linux-kernel+bounces-140096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2827C8A0B63
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8189282F6D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E541428FA;
	Thu, 11 Apr 2024 08:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BPXu9+eT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789AB10A11;
	Thu, 11 Apr 2024 08:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824384; cv=none; b=efVBS9ywmpCOrWCFSI8dOU7WkK3A3apKHtxGs3thD8fuMCgaIawke1b8bVuye/TME41jCxY14+Vip67dw8em8MadpRBgRWfq3ir2ClDDQ51CXCcfOrBDUoFLZj08Zc1FjMf5j+EIPVHyvlnFozIUgWZ+t1hFCK26/db1j+jEurY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824384; c=relaxed/simple;
	bh=aexm0NXn3rPt3OrBmKftet9jNwR1IawzCnXNhC1JeUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhGI23u5iv8agiRQGJdmEk3g/ZfHMS1+d2gHDWcYLEAnbU7lE5+tnumJYZ7sAq81TEiN79MpzVVHTQmhV4nkXW6DAJoz6azYGz2PJwevr2yBrp1/BwSUBN9yKNKlFpQ/u6R7oLYgEk/hE7u8K1rKEAQNh42x+6zoCxyCxhzt8+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BPXu9+eT; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712824383; x=1744360383;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aexm0NXn3rPt3OrBmKftet9jNwR1IawzCnXNhC1JeUg=;
  b=BPXu9+eTPoLiA0oZVcbUf6A/TWl6mh5icekYN32u8UudyhsvDcb+dDBL
   X1GnmWx2FVkcGU9ygxAd2/QcQVHTVf3e0CSP/cEI0+Lx7lbGJ9ZUNn7sQ
   0cJBgVdOWLA0A4SZwbdkz/uVrgUKo+GR8yTUtfYnJsMa8M1W+ZZ2g5tTP
   fPW2k0WPcrJZVHxYk/khT6OQVX1G4vZnJateeEdg/iXm3RpgvMAzlMjcs
   QYQIM80foea/I238aXoEmSv8wloV7D8+H/DAaohZzVCRUBmU4NLvkUMTO
   RWhTCCbXzzkMawbwNxRGhJTm/smw6IaI/hmTz49z2ff/zw1d4D+sEzeLu
   Q==;
X-CSE-ConnectionGUID: pPNlVvK2TCesQXAyGYPXOA==
X-CSE-MsgGUID: ukhF62avTcCYw3vlNdhRDg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8348258"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="8348258"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 01:33:02 -0700
X-CSE-ConnectionGUID: ms12RMvwQjiRcdPkrrMqfQ==
X-CSE-MsgGUID: QBXARUcxQ3qb6WdEdfJcgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="52020816"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa001.fm.intel.com with ESMTP; 11 Apr 2024 01:32:59 -0700
Date: Thu, 11 Apr 2024 16:27:54 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Subject: Re: [PATCH v1 1/1] fpga: ice40-spi: Remove unused of_gpio.h
Message-ID: <ZhefCsYbABNmVV/d@yilunxu-OptiPlex-7050>
References: <20240304175723.1200249-1-andriy.shevchenko@linux.intel.com>
 <ZhbyQSUzQ0wdqpcU@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhbyQSUzQ0wdqpcU@smile.fi.intel.com>

On Wed, Apr 10, 2024 at 11:10:41PM +0300, Andy Shevchenko wrote:
> On Mon, Mar 04, 2024 at 07:57:23PM +0200, Andy Shevchenko wrote:
> > of_gpio.h is deprecated and subject to remove.
> > The driver doesn't use it, simply remove the unused header.
> 
> Any comment on this? Can it be applied?

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next.

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
> 

