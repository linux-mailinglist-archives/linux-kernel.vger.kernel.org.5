Return-Path: <linux-kernel+bounces-148933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1723C8A8942
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 490A41C22E78
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B12017108F;
	Wed, 17 Apr 2024 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FG7ROy2d"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA798171E50
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372326; cv=none; b=usFwG9XWAKFJKiLiTKIGu0rMLY+fVCx6DIMEVLfG8yNef/dbUJB63+kDpB3udlB8XmbHu25Zv6ZD3TomFPSlgW/k2qrtxaZr2ksZrr3oznvbKpbz2MUQ9tXln5OP93bs4kgecjwSEF0nGtgw8/+QCqdTCupXq6y+VXDOeDs1xEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372326; c=relaxed/simple;
	bh=JNNbbcDpsjSu5SzSQb4EGQ/IYA72a9ZEL7ImG/VKG5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvCkXNLpQkxaYDRpYbHyZG/DUPH5Ni3KGeYwlcTVV311OxQ/05TpkJLQBSKgpb7Yuob2uFVIub1HXbblvap5wq01n3LGaQz8HqHk64Sj0i5XVeqaGkqsynT8I5duf4DoER4ndjEl9rkBKLw3k0si02IMCVB6hFlEXxld7UW981Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FG7ROy2d; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713372325; x=1744908325;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JNNbbcDpsjSu5SzSQb4EGQ/IYA72a9ZEL7ImG/VKG5M=;
  b=FG7ROy2duY/+qKiyHc5doixnBOX01OSyCH+RAR9c+svr7Q0IloTumfzR
   8OtBKjJar7O4H9vxRD20YIMA1N4zwNnWYhQZi8I9EcfpYyXjiGi3XT6Ym
   UVXhR8xyuXopk4Jeiu6IOWRRm88J3XiNv599GEdHXqUngUKKd8GLBfsSW
   QoVQqahs0NPSc9WBqMEshS8Ls9efaWeHD/EtnLXtsA4cB3N2nR9WcOuq8
   HQrIZDCms2CyS7LtKFIJ/aWslHaQz+s26HPsPiUWxzReWQPpzTA2hfDQD
   NbVsoYIT8XITy/kBzkcPW72gp6I8uCasIrR06gGkHj3MZ6CHf7YEDDB3d
   Q==;
X-CSE-ConnectionGUID: cS0bFtWyTqCRBbXsAIdDSQ==
X-CSE-MsgGUID: A78hUBFuTPG92w4wLeWOdw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="9045786"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="9045786"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 09:45:22 -0700
X-CSE-ConnectionGUID: NXZ1A3m5SRyhpASJnq5bZA==
X-CSE-MsgGUID: wQjzvXvFQGOjaFwNJwQnEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="27319575"
Received: from wangc3-mobl.amr.corp.intel.com (HELO desk) ([10.209.4.219])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 09:45:20 -0700
Date: Wed, 17 Apr 2024 09:45:14 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3] x86/bugs: Only harden syscalls when needed
Message-ID: <20240417164514.66hgypzxgqxt3ssk@desk>
References: <eda0ec65f4612cc66875aaf76e738643f41fbc01.1713296762.git.jpoimboe@kernel.org>
 <dad3a832-b3d0-4c72-a9f1-1ec4e6bc6bba@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dad3a832-b3d0-4c72-a9f1-1ec4e6bc6bba@citrix.com>

On Wed, Apr 17, 2024 at 04:14:26PM +0100, Andrew Cooper wrote:
> On 17/04/2024 12:02 am, Josh Poimboeuf wrote:
> > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > index ca295b0c1eee..dcb97cc2758f 100644
> > --- a/arch/x86/kernel/cpu/bugs.c
> > +++ b/arch/x86/kernel/cpu/bugs.c
> > @@ -1678,6 +1687,21 @@ static void __init spectre_v2_select_mitigation(void)
> >  	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
> >  	enum spectre_v2_mitigation mode = SPECTRE_V2_NONE;
> >  
> > +	/*
> > +	 * X86_FEATURE_INDIRECT_SAFE indicates whether indirect calls can be
> > +	 * considered safe.  That means either:
> > +	 *
> > +	 *   - the CPU isn't vulnerable to Spectre v2 or its variants;
> > +	 *
> > +	 *   - a hardware mitigation is in place (e.g., IBRS, BHI_DIS_S); or
> > +	 *
> > +	 *   - the user turned off mitigations altogether.
> > +	 *
> > +	 * Assume innocence until proven guilty: set the cap bit now, then
> > +	 * clear it later if/when needed.
> > +	 */
> > +	setup_force_cpu_cap(X86_FEATURE_INDIRECT_SAFE);
> 
> Following on from the (re)discovery that X86_FEATURE_RETPOLINE is a poor
> name given what it *actually* does, can I recommend s/SAFE/OK/ here?

Or simply X86_FEATURE_USE_INDIRECT_BRANCH.

> This flag really is "do I want indirect branches or not", which - as
> noted here - is more than just a judgement of whether indirect branches
> are "safe".

