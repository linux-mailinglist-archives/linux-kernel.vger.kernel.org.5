Return-Path: <linux-kernel+bounces-131189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D52E5898432
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886F21F28D5F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0E4811FF;
	Thu,  4 Apr 2024 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LS1puUbm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BFE745D6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712223181; cv=none; b=Xkp8ekoXV7hBEAHoHZGhkVbRGAO5LJU7Pg2Ls+qCTyt2PjK7A2fkUxN3yxVbqnVORFAVbWfAhi5nPUhojSyDs1W6/yR+jXjdF2wd1r4iZdOcZKTXBi4CnmmhVp6BmiKgEQ20U+Nt4uzzGeQivei5L+xpwds7ZzTFpEEkZf7Pb7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712223181; c=relaxed/simple;
	bh=DMeWIz1Du52cE1BkXc9SPzON+93nq6RzYRZOTm7qPd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C10A6EqU174Limu9MYLBl5cnVMNqpUYTXhw1EAnf7iXLQEc1RMZ/V2NsEMs3X473uCw2kE5YsY+ON7YHL9kPdZJRhpQcSgE/6o1Uho5/coMupWc4OGDWfoz12b56PjK5GiQKh9mvbJi+pdZsZTf1i7ziVPOrIFe3zqSrAXAXTrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LS1puUbm; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712223179; x=1743759179;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DMeWIz1Du52cE1BkXc9SPzON+93nq6RzYRZOTm7qPd8=;
  b=LS1puUbmudJkTQFdhgBVnd+bSlmS1aQVmf/UYHGVrZHF0OUWdXlpNGIk
   XPAx4MID+jaGt2GvsD5h89gR2m5JNZOBitvce4xV3aPlJKo1KxOAzlxwc
   5L2iM9FqG+uBo/41yGgmu4StoOb7GtLrMBrv+aP+y0C88EaaAC1pAvRp+
   D1OEn92amJiaSNAPM0foI2QpEKX9A4SEMSiyBuJpzt9caDlCZ68GxQsdH
   WWx4mDYOS6Sa1RIIzVcOy8/QzebLTx5FBqIznBuM7l08GV7zanYNh2Ut1
   QTY+I1DbXzA7ab5XKWVmGKQNgFHh9qsmuuMa5GKWHytaQy4i44/3+FmQ4
   w==;
X-CSE-ConnectionGUID: VlR/+pz0S+u9pea/0WkBtQ==
X-CSE-MsgGUID: 5N3VZKANQ6autQEp3dPVNA==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="11267031"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="11267031"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 02:32:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="937086251"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="937086251"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Apr 2024 02:32:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 4079A12C; Thu,  4 Apr 2024 12:32:52 +0300 (EEST)
Date: Thu, 4 Apr 2024 12:32:52 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv9 05/17] x86/kexec: Keep CR4.MCE set during kexec for TDX
 guest
Message-ID: <cxwixclmgbx3xidn6g6keihampcbzcbosog6r6lyoa4hs3teu2@sqntzeltdajc>
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
 <20240325103911.2651793-6-kirill.shutemov@linux.intel.com>
 <b94c81ef-50f2-4e66-9533-461791777d10@intel.com>
 <dlixf7bld4efdh5goir5nreabkgtcwfbvv2rovjqrvjttplqss@auuqnt4h2llj>
 <j4s4n5slt6a234w5o5r4zjmb3xj53odnmwekt6ihotfzotd7ur@ghyvphwcki57>
 <8e4e1d80-11ef-472f-befc-f61310281f18@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e4e1d80-11ef-472f-befc-f61310281f18@intel.com>

On Thu, Apr 04, 2024 at 10:40:34AM +1300, Huang, Kai wrote:
> 
> 
> On 3/04/2024 4:42 am, Kirill A. Shutemov wrote:
> > On Fri, Mar 29, 2024 at 06:48:21PM +0200, Kirill A. Shutemov wrote:
> > > On Fri, Mar 29, 2024 at 11:21:32PM +0800, Xiaoyao Li wrote:
> > > > On 3/25/2024 6:38 PM, Kirill A. Shutemov wrote:
> > > > > TDX guests are not allowed to clear CR4.MCE. Attempt to clear it leads
> > > > > to #VE.
> > > > 
> > > > Will we consider making it more safe and compatible for future to guard
> > > > against X86_FEATURE_MCE as well?
> > > > 
> > > > If in the future, MCE becomes configurable for TD guest, then CR4.MCE might
> > > > not be fixed1.
> > > 
> > > Good point.
> > > 
> > > I guess we can leave it clear if it was clear. This should be easy
> > > enough. But we might want to clear even if was set if clearing is allowed.
> > > 
> > > It would require some kind of indication that clearing MCE is fine. We
> > > don't have such indication yet. Not sure we can reasonably future-proof
> > > the code at this point.
> > > 
> > > But let me think more.
> > 
> > I think I will go with the variant below.
> > 
> > diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> > index 56cab1bb25f5..8e2037d78a1f 100644
> > --- a/arch/x86/kernel/relocate_kernel_64.S
> > +++ b/arch/x86/kernel/relocate_kernel_64.S
> > @@ -5,6 +5,8 @@
> >    */
> >   #include <linux/linkage.h>
> > +#include <linux/stringify.h>
> > +#include <asm/alternative.h>
> >   #include <asm/page_types.h>
> >   #include <asm/kexec.h>
> >   #include <asm/processor-flags.h>
> > @@ -145,11 +147,17 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
> >   	 * Set cr4 to a known state:
> >   	 *  - physical address extension enabled
> >   	 *  - 5-level paging, if it was enabled before
> > +	 *  - Machine check exception on TDX guest, if it was enabled before.
> > +	 *    Clearing MCE might not allowed in TDX guests, depending on setup.
> 
> Nit:  Perhaps we can just call out:
> 
> 	Clearing MCE is not allowed if it _was_ enabled before.
> 
> Which is always true I suppose.

It is true now. Future TDX will allow to clear CR4.MCE and we don't want
to flip it back on in this case.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

