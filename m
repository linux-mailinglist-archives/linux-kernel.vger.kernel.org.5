Return-Path: <linux-kernel+bounces-167859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BD58BB06B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C108284F66
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF99C155307;
	Fri,  3 May 2024 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f0hIUzJ0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5029BA55;
	Fri,  3 May 2024 15:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714751669; cv=none; b=IAK3gevP6oqR+gLvTRDlp+B/OErAFkZ5NE6M3BpP7VedfM3sRaIVZI/BsE5fS9EYe93Oue4I2Npu8vWU4wyZcyBIfeiZnjfeUPalrqDPnnTJ1iQ1TH79eVC73YCWKo+Em1TVVeWRoWQLQltnInyUroBSTMnfWuXRe78xMy2bDF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714751669; c=relaxed/simple;
	bh=e0xaJg5bRHsT7ykU7u4th851abcxqqXW2gAfWEUvvJQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZjJMdo68riVFSJ8XKlrHTs44+MGfef7vFTVz6Jtuy5g7EWK8kbgyr8bBbDb5P8gEt84vXOqqEJafgDeQW+1hp/hT0RCTi5HM/+FHe5ntYQmoe/L1BQO+9lXO8Tr2tjnIwLQXHtbQhxdyFkZr/CmpTnpfWV8lUdGBtGkiDxoi80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f0hIUzJ0; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714751668; x=1746287668;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=e0xaJg5bRHsT7ykU7u4th851abcxqqXW2gAfWEUvvJQ=;
  b=f0hIUzJ0XuSBgm8iYZcXIEAKn7WquBo2KuDYqsmQXIijZFhDGuG3JSHm
   rok1uH3TK1cs1LJMi3bR5XV89Q1nILFCRVcEA0m0NHEPrxigb6hsTndbq
   l0zU0WSG4SQj2FvD+k0vQ3+IhqvmvkTJiL90IjKuwM69rluL5xjivUGOf
   1m3YiJ2GkDqSnGXG5PizHeNKs21ZZ6uTF2k6dchlZ8yxqVDcVwpvoxiPv
   Z+0T4pbQ+cQSPXSs/ONjeFa+99DhHFCUcWioXPLnVHY8R9iN+Oy0LOZJf
   TJvJ6pigrZX6xkaY4o5KsXzltQ8teYjrUTisaaj7Di0z5vR3OvSmb0pJ2
   w==;
X-CSE-ConnectionGUID: qAhlbFrKQbK6ACEW2O8Okg==
X-CSE-MsgGUID: CfH43xUNT9qSwRStWGEiOQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10691162"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="10691162"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 08:54:28 -0700
X-CSE-ConnectionGUID: m37l3Jn3T/GDycsvx28mtg==
X-CSE-MsgGUID: aY4IjkaaRamEAthRQWNPoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="58392359"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 08:54:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s2vEt-00000003hAw-0nBR;
	Fri, 03 May 2024 18:54:23 +0300
Date: Fri, 3 May 2024 18:54:22 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spi: bitbang: Add missing MODULE_DESCRIPTION()
Message-ID: <ZjUIruF2kLgypVW1@smile.fi.intel.com>
References: <20240502171518.2792895-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502171518.2792895-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 02, 2024 at 08:15:18PM +0300, Andy Shevchenko wrote:
> The modpost script is not happy
> 
>   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spi/spi-bitbang.o
> 
> because there is a missing module description.
> 
> Add it to the module.
> 
> While at it, update the terminology in Kconfig section to be in align
> with added description along with the code comments.

Please, ignore this. I think it makes sense to split to two patches and also I
forgot the -txrx.h related to bitbang.

-- 
With Best Regards,
Andy Shevchenko



