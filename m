Return-Path: <linux-kernel+bounces-129627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121A3896D8E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44A7D1C209F9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727A3139CEF;
	Wed,  3 Apr 2024 11:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PNXH/k6C"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E677070CA7;
	Wed,  3 Apr 2024 11:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712142093; cv=none; b=Fa7vfLsEuAQ9Pd1ZjiMZ4Q5ikXPcp20AbVzocZv+6O0XAAIrT5sRItHXr5PkoCM4ggsbHH5si2uiZh1GNUb6H75PQb4Jnv8kXrG3p3iKX0Zz5rZjC1WgH2oUSdDbWneBAqZaPAlyOrkNw668jcvQE97IYo9ywBeJKvoxbh3ZwCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712142093; c=relaxed/simple;
	bh=ifQDVbnTLgyXKRXlxGD4lJ6U9r4VNF+MbWPvdiAC1TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxd3xsy9vlxXXiPvpowlBsWyCAPVFyCw5s58cFLrQ5COz9f4MblnBxXod3IdYfVZvE5BImhbPsqksOpP/Hv1WFDEKST6/q3IgNRemufyxrXOXZMW1RoKqUQ0N4Ealu6Ukc8jiU+7DQ/BwS2kH0FExpq11POuMdLkXBhC694hpZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PNXH/k6C; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712142092; x=1743678092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ifQDVbnTLgyXKRXlxGD4lJ6U9r4VNF+MbWPvdiAC1TQ=;
  b=PNXH/k6CEL88fItv68vexLE3VsYrWfbWlNssngTz1V9qQ11UhQYAvdVJ
   Hv1deiUk+A89biB2D4MDie6SGZIuFWAFvtgIU/rvZOC5fqh0eyoa2z2Hk
   vtCc5lDZGFeimKbKR1h70GuYjmmHAMYRO0VXOg/i98fdB4o/9qEjKZe/k
   kEYPue7CccsoEOQyB8qXlG83LtLmFaKdFJ5Cczk6LsaJ4Kwry5h5eE4gt
   Dk2faHCQn7XUP4AQR86g5VrLliBXR5TPHdER7+naypzeASIL7wVnJg8Wf
   1I6sSzsVE92FO/u6PFsExjfVJDVKpfJigCJHLJcIhK/Jxm21XQB68j3z3
   g==;
X-CSE-ConnectionGUID: J11Se7WBSlOA77cK9tRh7Q==
X-CSE-MsgGUID: 9N8iWgpJQv6rWWVLivAxgQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7592119"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7592119"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 04:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="915179146"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="915179146"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 04:01:26 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rryMv-000000016D0-1c2o;
	Wed, 03 Apr 2024 14:01:25 +0300
Date: Wed, 3 Apr 2024 14:01:25 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tom Rix <trix@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	linux-fpga@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v1 1/1] fpga: dfl: pci: Use pci_find_vsec_capability()
 when looking for DFL
Message-ID: <Zg03BTubHLslIi_P@smile.fi.intel.com>
References: <20211109154127.18455-1-andriy.shevchenko@linux.intel.com>
 <8ccc133a-fb47-4548-fee3-d57775a5166d@redhat.com>
 <YYq4fSRoyzFE4Vei@smile.fi.intel.com>
 <39ac1f40-66ab-6c7e-0042-8fcdc062ed00@redhat.com>
 <YYuBz0tdduAk1c/6@smile.fi.intel.com>
 <3106bd57-9144-6a4d-8ad9-3ebf804018ab@redhat.com>
 <CAHp75Vf16mH4KQ232rip9MPLoSE1TmJ_jeiwVUzqxOH5b0RFJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vf16mH4KQ232rip9MPLoSE1TmJ_jeiwVUzqxOH5b0RFJQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Nov 10, 2021 at 06:59:25PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 10, 2021 at 2:28 PM Tom Rix <trix@redhat.com> wrote:
> > On 11/10/21 12:24 AM, Andy Shevchenko wrote:
> > > On Tue, Nov 09, 2021 at 10:27:58AM -0800, Tom Rix wrote:
> > >> On 11/9/21 10:05 AM, Andy Shevchenko wrote:
> > >>> On Tue, Nov 09, 2021 at 07:55:43AM -0800, Tom Rix wrote:
> > >>>> On 11/9/21 7:41 AM, Andy Shevchenko wrote:

..

> > >>>>> + voff = pci_find_vsec_capability(dev, PCI_VENDOR_ID_INTEL, PCI_VSEC_ID_INTEL_DFLS);
> > >>>> This may be a weakness in the origin code, but intel isn't the exclusive
> > >>>> user of DFL.
> > >>> This does not change the original code. If you think so, this can be extended
> > >>> later on.
> > >> I would rather see this fixed now or explained why this isn't a problem.
> > > This is out of scope of this change in a few ways:
> > >   - we don't do 2+ things in one patch
> > >   - the change doesn't change behaviour
> > >   - the change is a simple cleanup
> > >   - another vendor may well have quite different VSEC ID for DFL
> > >
> > > If you think that it should be needed, one can come up with it later on.
> >
> > Fixing a problem is more useful than a cleanup. The fix should come first.
> 
> What do you mean by that? The original code never worked with what you
> are suggesting. There is nothing to fix in terms of "fix". What you
> are proposing is a feature. And as we know the features are going into
> the kernel in a natural order, means fixes - priority 1, cleanups /
> refactoring as prerequisites to the feature enabling - priority 2,
> feature - priority 3, other cleanups and code improvements - priority
> 4.
> 
> That said, the proposed change definitely falls into category 2. It
> makes the proposed feature to be easily realized.
> 
> Also, do not forget that vendor specific stuff is _by definition_
> vendor specific, and the proposed feature is doubtful until you prove
> there is another vendor-id pair.

Interestingly that you included
8607d9c1bd57 ("fpga: dfl-pci: Use pci_find_vsec_capability() to simplify the code")
without even letting me know...

-- 
With Best Regards,
Andy Shevchenko



