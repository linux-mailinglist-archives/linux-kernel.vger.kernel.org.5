Return-Path: <linux-kernel+bounces-166654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C103C8B9D9F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F146C1C21459
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B010915B542;
	Thu,  2 May 2024 15:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fo4d0fzN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8218C15574D;
	Thu,  2 May 2024 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714664247; cv=none; b=cBxvXNGAl/t6fXiofLmgFAK4sJ6RNHR3RM/CcuiNFv1XtDT8on5IieXGB5t6v/Okcjn3FcX40DhOwjuKLAsaLZzD3xsTETG7uitLlabapJLpvuiC7q3ZfYH2RxgBHVn0W+hlZ/yuBH2y2cTtYQvUA1gdFWpZ7E5dsTuAoNblqdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714664247; c=relaxed/simple;
	bh=j38UorVmR/AGSdNTHCstKIyo+0I5Y1p2zSzuxJtlmJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWHneD2eLxg0/9ffKEu2/TUm4JlJ1fhsRRvP2jMiqNkIu503WSAnmp+dQiwHLBQoE3axUfE3ZpgEwh9qFXNqtnArO3yYNurV7l7cJPEAZSYvEQOpdGCuxupE6t7DeA+DypeCT6ggNRg2bk0RRsyIEtRvnilH6Cr3r/lfre2WT9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fo4d0fzN; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714664246; x=1746200246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=j38UorVmR/AGSdNTHCstKIyo+0I5Y1p2zSzuxJtlmJ8=;
  b=Fo4d0fzNecH2EqhMu8FUUpP6n49EyqYnvGvYPgLV1Qe/M3ej94QTgK/m
   shH3EnWMpHbxZnH4VQUxRwbUCwi/8Myi7y3NClE7ENDDcrpBXmDhiyd6F
   Zu2J4lO6NCfQ565S8BTeyS+JlyN+IjIqNjQzwHi20B2dORQnJ1k0H39tj
   rLMqJyL1ZXLXJ0SVWsZJGNONy28K8jsCvVCD31XyoviYAPtzmiLO5PxZ5
   1B8BIBWuVEV2YwOmMNow5AgTzl29Qr7neue/SV8SX0LPjTdWzZUftLzYY
   A5JpPVp4GhhW9vW7Gji2TTRhiLv6MzFn3fAjRMD/IBF2/g4si4yEreLqD
   w==;
X-CSE-ConnectionGUID: rME7CR6tQFuzSl67IhZFPQ==
X-CSE-MsgGUID: ecH8zU9+QD+eqRHGvufOXg==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10978268"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10978268"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 08:37:23 -0700
X-CSE-ConnectionGUID: rQ0mIaCQTiOvdIA7WfTaOg==
X-CSE-MsgGUID: 8QDHy7o5TB+CjJnL4WNbZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="64596205"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 08:37:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s2YUm-00000003MfF-3qvM;
	Thu, 02 May 2024 18:37:16 +0300
Date: Thu, 2 May 2024 18:37:16 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: nuno.sa@analog.com, Petr Mladek <pmladek@suse.com>,
	Chris Down <chris@chrisdown.name>,
	John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jyoti Bhayana <jbhayana@google.com>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dev_printk: add new dev_err_probe() helpers
Message-ID: <ZjOzLJ69qjT5CVQU@smile.fi.intel.com>
References: <20240423-dev-add_dev_errp_probe-v2-0-12f43c5d8b0d@analog.com>
 <20240423-dev-add_dev_errp_probe-v2-1-12f43c5d8b0d@analog.com>
 <ZifUSKFh2C4VG5QB@smile.fi.intel.com>
 <ZifXmhyIQASs9UYZ@smile.fi.intel.com>
 <d827817909756e4b65a3bb5753d0243e344109de.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d827817909756e4b65a3bb5753d0243e344109de.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 02, 2024 at 01:54:36PM +0200, Nuno Sá wrote:
> On Tue, 2024-04-23 at 18:45 +0300, Andy Shevchenko wrote:
> > On Tue, Apr 23, 2024 at 06:31:20PM +0300, Andy Shevchenko wrote:
> > > On Tue, Apr 23, 2024 at 05:20:30PM +0200, Nuno Sa via B4 Relay wrote:
> > > > From: Nuno Sa <nuno.sa@analog.com>

..

> > > > +#define dev_err_cast_probe(dev, ___err_ptr, fmt,
> > > > ...)	({			\
> > > > +	ERR_PTR(dev_err_probe(dev, PTR_ERR(___err_ptr), fmt,
> > > > ##__VA_ARGS__));	\
> > > > +})
> > 
> > After looking into the next patch I think this should be rewritten to use %pe,
> > hence should be an exported function. Or dev_err_probe() should be split to
> > a version that makes the difference between int and const void * (maybe using
> > _Generic()).
> 
> I replied a bit in the other patch but I'm of the opinion that's likely just more
> complicated than it needs to be (IMO). Why is the PTR_ERR(___err_ptr) that bad? If we
> really want to have a version that takes pointer why not just:
> 
> #define dev_err_ptr_probe(dev, ___err, fmt, ...) \
> 	dev_err_probe(dev, PTR_ERR(__err), fmt, ##__VA_ARGS__)
> 
> 
> (yes, while _Generic() could be fun I'm trying to avoid it. In this case, I think
> having explicit defines is more helpful)

It seems dev_err_probe() already uses %pe, so we are fine.

-- 
With Best Regards,
Andy Shevchenko



