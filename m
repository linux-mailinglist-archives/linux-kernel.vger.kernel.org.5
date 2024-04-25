Return-Path: <linux-kernel+bounces-158467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5A68B208E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEDF92899C8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A93412C465;
	Thu, 25 Apr 2024 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gMHir87u"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A142212C463;
	Thu, 25 Apr 2024 11:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714045237; cv=none; b=Bxi9cxFugX/Is71p1nfUHDEFF7mNKi6V6dk3UdIj0jUQxxmxZo3vq8bNaTxnGkRDnP9Oh1irnZWrmyksGRp6E5zSGM0CIZo4N6Ior1KNCUy+9bWxpHwdYCk+h4H/FWnrSJQhOhZRsuocombQhLlex6Qdnbr+pRCk7zHK/MhZ3CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714045237; c=relaxed/simple;
	bh=Q4deqpKZxo2WWcmbcro48GqHU+FovZjZZSSlt7hvZhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/yiKF3pLTIdUfJXxoH3zpndUIDOIhd75NLGZW+cSN9GUfl03bGHZv/LTk9lyNvdzeHiCaJ8sK/uF/biX6eVRlKdt/v4wNhvdlrUJreeKRmmxSmqriG+hnnDcbA28STPUBVULDa7PWSy2UXIqE748U3rVLIKLT9lm6NKTthCHZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gMHir87u; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714045236; x=1745581236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q4deqpKZxo2WWcmbcro48GqHU+FovZjZZSSlt7hvZhA=;
  b=gMHir87uXraaIt0vvlUBuhd1wpuxHBR1j9OCOPLVCAb6T26bsYUjlvFQ
   YtGebmQolf+KZsPeRT4H4Z756Pybrex2Ki26+D53bXPiU/7nQONEc0WA4
   GHzk+3BHGjJTIu4MWNLRDiJ3dv3/s+5QgjOSuRJiBXhJgHF6qLftaGYBR
   JwSFB/UeT9S5V4kpZQAbqxzrl/m0yoXQHbKm2DKwtxDM9FcEV1Tss7hXA
   DeQNsM4g1oXXMgqhWYsbrJxMrvv+3ynyPAGR6QT4TQUfdEGdhzmt2bgbt
   mT2DJOFkzrabIqJfv1FlSlSTIl6EnmByXJKIDkZXCLmGvoqmuuEYR1p/0
   Q==;
X-CSE-ConnectionGUID: 6LjUTFg6S0+BfIV5F0mm4A==
X-CSE-MsgGUID: 3jWYmDl1R7iohbI2iVHO9Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9591834"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="9591834"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 04:40:35 -0700
X-CSE-ConnectionGUID: fg9O2DFoQaeRUlwRK66OOw==
X-CSE-MsgGUID: vX3vZMGkTtaG8XLMWnBIIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="25531667"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 04:40:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzxSn-00000000yhj-2cKc;
	Thu, 25 Apr 2024 14:40:29 +0300
Date: Thu, 25 Apr 2024 14:40:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 0/9] spi: pxa2xx: Drop linux/spi/pxa2xx_spi.h
Message-ID: <ZipBLUa57YxBAeZD@smile.fi.intel.com>
References: <20240417110334.2671228-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417110334.2671228-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 17, 2024 at 01:54:27PM +0300, Andy Shevchenko wrote:
> As Arnd suggested we may drop linux/spi/pxa2xx_spi.h as most of
> its content is being used solely internally to SPI subsystem
> (PXA2xx drivers). Hence this refactoring series with the additional
> win of getting rid of legacy documentation.
> 
> Note, that we have the only user of a single plain integer field
> in the entire kernel for that. Switching to software nodes does not
> diminish any of type checking as we only pass an integer.
> 
> On top of that it includes the previously sent "spi: pxa2xx: Cleanup
> (part 2)" series that makes effort to clean up even more things.

Any chance to have a fresh look at this?

-- 
With Best Regards,
Andy Shevchenko



