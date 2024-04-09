Return-Path: <linux-kernel+bounces-137128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD3889DD4B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73D79B276A3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B1B85652;
	Tue,  9 Apr 2024 14:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yt5oK5c5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC48136E17;
	Tue,  9 Apr 2024 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674086; cv=none; b=dNQ1PVfhmuAYCAECUbzSROP4S4bWF0FBTwzdBYRNTKip87hvQQHtEUYoNRaJE8+EvQ0LRD6wK6L1K/WebkOCKQyCG6LLkX+b5ZhnxrZrK4clti1zzWgSQVx9jVMz/YxK4xbkQPcUGiFfAZ7XUd75xE4uzaumR/9Fj8wrE2YBVrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674086; c=relaxed/simple;
	bh=qXiImrPjk9pciUK+qkOQS8Qk++NVZZHB0HTKd0iJ9jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9hLzSFYwwyZeAE4Vw53nnS1dNnZ3ehiOlAo4eHGj9N62i2Q64Z8s1dKHt+P+OQ99LsgFnQy1cuP1J4nwpwGZ298E6871KxI6T7rsfq7HJp50X+MIUQbev2Y4xJUrykNarUSMtd0kCUctEANTj3hid2PIvDc8N711SUy0GuxS4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yt5oK5c5; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712674085; x=1744210085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qXiImrPjk9pciUK+qkOQS8Qk++NVZZHB0HTKd0iJ9jc=;
  b=Yt5oK5c5HVUKIUlYMIxTv7sA16AdSarSi3Xb1TBzjW6r0GoY6TFEtFPg
   4ZWaqz9h1hqYR/H0UJ2GjjKYBmKSMzSdyqVI9XW39JfcMT7xfxej3YEos
   0UixIj/1KOQSmvDzhxh/TE3Ui9r9lHg0R07Lmk5Uf5ScZ9IAt6A5ZT1pS
   yYzTBsM9GGIq1d4a+jHX5PG1d+Tf9uFm62EekzgMb1Mw6bvqmSEMBinlD
   vrw6V0JKFwiw4AC5JkJW/2F6jjLScA6JEH/2cEZgMR/W+gDbIfV/1QJhb
   qutdhqewaCGzq5f9eyDRw1hP9Lc/bdqQOFWPzsqou+HG6USe1yiy5AzYh
   w==;
X-CSE-ConnectionGUID: Qqd54Ye4QHKMCFNo96nAYA==
X-CSE-MsgGUID: COLdtpSeRJKYk/pZmAkP4Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="25489948"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="25489948"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 07:48:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="915401658"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="915401658"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 07:48:03 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ruClU-00000002pl6-2uK6;
	Tue, 09 Apr 2024 17:48:00 +0300
Date: Tue, 9 Apr 2024 17:48:00 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hugo@hugovil.com>
Subject: Re: [PATCH v2 00/16] serial: max3100: Put into shape
Message-ID: <ZhVVILIFP3VKb4b7@smile.fi.intel.com>
References: <20240402195306.269276-1-andriy.shevchenko@linux.intel.com>
 <2024040903-handcuff-lanky-cc13@gregkh>
 <ZhVI7wzYKrutk1LA@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhVI7wzYKrutk1LA@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 09, 2024 at 04:55:59PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 09, 2024 at 03:52:19PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Apr 02, 2024 at 10:50:27PM +0300, Andy Shevchenko wrote:
> > > Put the driver into the shape with all new bells and whistles
> > > from the kernel.
> > > 
> > > The first three patches marked as fixes, but there is no hurry (as it
> > > was for ages like this in the kernel) to pipe them to stable. That's
> > > why I sent all in one series and it's good for tty-next.
> > > 
> > > Tested on Intel Merrifield with MAX3111e connected.
> > > 
> > > In v2:
> > > - fixed a few typos in the commit messages (Hugo)
> > > - added an additional fix to patch 2 (Hugo)
> > > - appended tag to patch 13 (Hugo)
> > > - v1 (20240402154219.3583679-1-andriy.shevchenko@linux.intel.com)
> > 
> > Only a portion of this series applied to my tree.  Can you please rebase
> > and resend the remaining bits?
> 
> Sure, thanks!

v3 just has been sent: 20240409144721.638326-1-andriy.shevchenko@linux.intel.com

-- 
With Best Regards,
Andy Shevchenko



