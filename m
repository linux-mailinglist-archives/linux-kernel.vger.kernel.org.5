Return-Path: <linux-kernel+bounces-155499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDF78AEB5E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB941C22E5D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF1C13C694;
	Tue, 23 Apr 2024 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ggWjpk4C"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E786613BAFE;
	Tue, 23 Apr 2024 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713887138; cv=none; b=U3bV3vEXhgvoKc8aoazlyISTeQeLVc4q0U5mSN1cDlof/SpBzRybNExPmIFjHfr4SGSpXCRstph2G9WRoVPOdFnhsAnx51kZFlW7ckIL/Ka8X5RUtrgnrpVzClTFtVJNXoAeBPBRInxcB8rGzsIvwKgUG9GPoc9w5vIIzXBZDPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713887138; c=relaxed/simple;
	bh=g32tYyNwhHSjBI5XP117/+DCw7CjmkPynMd0Zm5xQ90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FT3Qp7hjVyhdU2QfOlMxjS/5SW5MgH+TPyGrqv5Q+A8LJNUkp02SmnD9Djz/8ktYnTJwzN8lPovp3gaH5A/1TBe4WgHXMSCdw3hQJx3pkxClvrBIqEnOKtuT4U+5nqLFD+VJCAlgotJdyuqJ4ZUs5vlstvRSgZge2Z5rqX3t9eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ggWjpk4C; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713887137; x=1745423137;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g32tYyNwhHSjBI5XP117/+DCw7CjmkPynMd0Zm5xQ90=;
  b=ggWjpk4Ct7tHV5h6/c6+gxgmAT0bXAdXexTj1a7rrLdLTe3wqJCYRLbQ
   +VwyEL13lwMOtP3w1nuwoNFORMY851OB11Gxz7yRtAibBs3zREjTHs9lZ
   5PYJo6DUWwzEz2YwVJziI4cEBdI6PprP+7sz93Vs37qytUdzl7/T9FIVm
   3QUyttbeHv1CxDrRnmOgZvkc5TnNBJd3+PDqZ9WhKDEm8ENEQ9BQcajMQ
   crF6NCshWksNT1NuJimpG4mM2AhP45Ktv3qYKtTtZ3PJBw8wyQesmdjW4
   /DadMWFqONqCsIpdmm61ZJY+PR3BRv7R+qLvi1cRyUZBN8SBkakyUmoQf
   w==;
X-CSE-ConnectionGUID: vQ715DZKRS2dfrtPniylZQ==
X-CSE-MsgGUID: sqniNEsySf6Uob+NUsD01g==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="13265074"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="13265074"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 08:45:36 -0700
X-CSE-ConnectionGUID: NS7n0LC0RDaT5M1xEcfcrQ==
X-CSE-MsgGUID: R/YEB9pyR/e0vS5U8r4puA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24441163"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 08:45:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzIKo-00000000Ndc-2YC6;
	Tue, 23 Apr 2024 18:45:30 +0300
Date: Tue, 23 Apr 2024 18:45:30 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: nuno.sa@analog.com
Cc: Petr Mladek <pmladek@suse.com>, Chris Down <chris@chrisdown.name>,
	John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jyoti Bhayana <jbhayana@google.com>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dev_printk: add new dev_err_probe() helpers
Message-ID: <ZifXmhyIQASs9UYZ@smile.fi.intel.com>
References: <20240423-dev-add_dev_errp_probe-v2-0-12f43c5d8b0d@analog.com>
 <20240423-dev-add_dev_errp_probe-v2-1-12f43c5d8b0d@analog.com>
 <ZifUSKFh2C4VG5QB@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZifUSKFh2C4VG5QB@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 23, 2024 at 06:31:20PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 23, 2024 at 05:20:30PM +0200, Nuno Sa via B4 Relay wrote:
> > From: Nuno Sa <nuno.sa@analog.com>

..

> > +#define dev_err_cast_probe(dev, ___err_ptr, fmt, ...)	({			\
> > +	ERR_PTR(dev_err_probe(dev, PTR_ERR(___err_ptr), fmt, ##__VA_ARGS__));	\
> > +})

After looking into the next patch I think this should be rewritten to use %pe,
hence should be an exported function. Or dev_err_probe() should be split to
a version that makes the difference between int and const void * (maybe using
_Generic()).

-- 
With Best Regards,
Andy Shevchenko



