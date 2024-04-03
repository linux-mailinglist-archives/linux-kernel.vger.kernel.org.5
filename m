Return-Path: <linux-kernel+bounces-130076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3C08973D5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C0631F21AD7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F11114C5BB;
	Wed,  3 Apr 2024 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YUJF5+Iy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299EA14C5B1;
	Wed,  3 Apr 2024 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712157328; cv=none; b=ggDY2dGhIg7yC2cNdAdMHd8OpCyqwU2y98Nqi/ZKYIP1LMbpUX3S2ivD9U4CyJELkF/Bq2WTlHMAltDKZO/fbCr4EDXG2mJwQIMvVt5VUa+LQf/E9U738FIGpVaa6U8k1cDeJpLSZlrHLPqOxsThGvHuloQJRWhopMnFuDcjbT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712157328; c=relaxed/simple;
	bh=G+3dp7VGKvmjKZ/6zX13Wl3Vat/CB+UfkoJwKhp3mSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjsqBtgw/dxThM/eqQ3TzKU9anzWpBgYjAVFRo9jxiYchozjN/hesICzzoXInYa87qTyQ+WtrO5e287DUnKdOMwa/gihBHLB6fpIIKZu+mJyHZU+lBzBi6n/To5fMs7wpQ7JAvmQtzt6Zd1IH+OjSbffgwX5AxDVNNtV69w9OY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YUJF5+Iy; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712157327; x=1743693327;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G+3dp7VGKvmjKZ/6zX13Wl3Vat/CB+UfkoJwKhp3mSY=;
  b=YUJF5+IyjV/9VQfs8QiDXqP7wRLQUcbbLbefkODv4zMEM0O0fu4y4d8n
   7oQQDjkt42Z06VNFleXLANJMpiIEZrTQGWpYw7j49Lukd/obeej4lx8DY
   4iAsv8CRO6zZ7ylB6KJV3OB6wTqvNOzCa1RSFp9Ieb55GiLPiIoDyhjHw
   LGVa8MueWYd06uzmCmaqkKSsiqK1YM742hRoyWqo8Ce5OSQpaDyqljqqi
   kWzTrb6JRomJaxyTqIWiNIOcX3p0p2f+lUukFfhHkrfgLy/0v6xRqGp4T
   e0xK8Wewa+4HR1EXHPoO2UG0Xl5vUvcCylK0nPKUnoc7mQ0QN+sUNFYSQ
   A==;
X-CSE-ConnectionGUID: 3QvqVeL1TKCbGcZGnaiGpw==
X-CSE-MsgGUID: IL3KToesS7yhQpbbMaczVQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="24897304"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="24897304"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 08:15:26 -0700
X-CSE-ConnectionGUID: 8raQbmlSSfugqpi13Ne8wQ==
X-CSE-MsgGUID: W0lH8cfyQcSDz9K7UddVRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="22936198"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 03 Apr 2024 08:15:24 -0700
Date: Wed, 3 Apr 2024 23:10:31 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	linux-fpga@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v1 1/1] fpga: dfl: pci: Use pci_find_vsec_capability()
 when looking for DFL
Message-ID: <Zg1xZ+k8eZJwOs41@yilunxu-OptiPlex-7050>
References: <20211109154127.18455-1-andriy.shevchenko@linux.intel.com>
 <8ccc133a-fb47-4548-fee3-d57775a5166d@redhat.com>
 <YYq4fSRoyzFE4Vei@smile.fi.intel.com>
 <39ac1f40-66ab-6c7e-0042-8fcdc062ed00@redhat.com>
 <YYuBz0tdduAk1c/6@smile.fi.intel.com>
 <3106bd57-9144-6a4d-8ad9-3ebf804018ab@redhat.com>
 <CAHp75Vf16mH4KQ232rip9MPLoSE1TmJ_jeiwVUzqxOH5b0RFJQ@mail.gmail.com>
 <Zg03BTubHLslIi_P@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg03BTubHLslIi_P@smile.fi.intel.com>

On Wed, Apr 03, 2024 at 02:01:25PM +0300, Andy Shevchenko wrote:
> On Wed, Nov 10, 2021 at 06:59:25PM +0200, Andy Shevchenko wrote:
> > On Wed, Nov 10, 2021 at 2:28 PM Tom Rix <trix@redhat.com> wrote:
> > > On 11/10/21 12:24 AM, Andy Shevchenko wrote:
> > > > On Tue, Nov 09, 2021 at 10:27:58AM -0800, Tom Rix wrote:
> > > >> On 11/9/21 10:05 AM, Andy Shevchenko wrote:
> > > >>> On Tue, Nov 09, 2021 at 07:55:43AM -0800, Tom Rix wrote:
> > > >>>> On 11/9/21 7:41 AM, Andy Shevchenko wrote:
> 
> ...
> 
> > > >>>>> + voff = pci_find_vsec_capability(dev, PCI_VENDOR_ID_INTEL, PCI_VSEC_ID_INTEL_DFLS);
> > > >>>> This may be a weakness in the origin code, but intel isn't the exclusive
> > > >>>> user of DFL.
> > > >>> This does not change the original code. If you think so, this can be extended
> > > >>> later on.
> > > >> I would rather see this fixed now or explained why this isn't a problem.
> > > > This is out of scope of this change in a few ways:
> > > >   - we don't do 2+ things in one patch
> > > >   - the change doesn't change behaviour
> > > >   - the change is a simple cleanup
> > > >   - another vendor may well have quite different VSEC ID for DFL
> > > >
> > > > If you think that it should be needed, one can come up with it later on.
> > >
> > > Fixing a problem is more useful than a cleanup. The fix should come first.
> > 
> > What do you mean by that? The original code never worked with what you
> > are suggesting. There is nothing to fix in terms of "fix". What you
> > are proposing is a feature. And as we know the features are going into
> > the kernel in a natural order, means fixes - priority 1, cleanups /
> > refactoring as prerequisites to the feature enabling - priority 2,
> > feature - priority 3, other cleanups and code improvements - priority
> > 4.
> > 
> > That said, the proposed change definitely falls into category 2. It
> > makes the proposed feature to be easily realized.
> > 
> > Also, do not forget that vendor specific stuff is _by definition_
> > vendor specific, and the proposed feature is doubtful until you prove
> > there is another vendor-id pair.
> 
> Interestingly that you included
> 8607d9c1bd57 ("fpga: dfl-pci: Use pci_find_vsec_capability() to simplify the code")
> without even letting me know...

I'm sorry. Apparently I forgot what we've discussed in 2021.

In 2021, I was waiting for some more comments although I was already
good at your patch, but sadly I didn't follow up and missed it. In
2023, I was pretty sure no more comment and I could just apply.

Thanks,
Yilun

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
> 

