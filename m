Return-Path: <linux-kernel+bounces-150900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E4B8AA681
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAA0AB21820
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 01:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDA21362;
	Fri, 19 Apr 2024 01:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hKWY1e0a"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813D27E2
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 01:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713489496; cv=none; b=DLfLE2h23RcQ9DxlYT+m7tAQyvixQkmeT/JGLmEKT1ka/zrD1rTMChKonLgcFruvlQHQ2wcOTl+p5DXfI4e+cUDvY8pS+tory2PU6zld4NosR4G0ixEZHdoyKknJUJACZt+ZsQn2Fv8DTRlrDQlGJylfvTJMk6zPZezTrYBtlaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713489496; c=relaxed/simple;
	bh=K1im4bHfvgpOGWvoUKD1j9lm7YqKiEjRz2tzXl9uvNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ki95wFKrSUc7WHjSaw74Z8QZw+7/RSlxWFZSqFuXwW4/uDHPEq15IXEVDaPivgR9iaGaRqb2DMCCk5rOt5wgmE9ygi3qS33+AwHrYC2ukwVAApJdCJc+LLN3E4Y4gIRKmguPlxqTHshhnDgncCReD6bHRSKM85CV0TzjCGckEmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hKWY1e0a; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713489494; x=1745025494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=K1im4bHfvgpOGWvoUKD1j9lm7YqKiEjRz2tzXl9uvNU=;
  b=hKWY1e0aMqg0oXiVc5qBuvq7y4oGINBKkR18K056jABmNs1kE9z8v8nQ
   8TIkr9x6rKIQt1CTSaTAn3XlUgKdZDgyLVlsVXUPhtnHA2+shI7+sYA46
   oNr5b9Tdyx9eAOVxqiz9Iuh5r0YVjPFgnDLXKXCLhRD5qhZaiA0NJqUv+
   0hKmXdS1A5+ukE25CZmHqKoL6AggyT+GPt90rSeSp7n9Wxsqczw1t7TFk
   ueIaGvQioBDR7rpwbU6J9kE3f0rPUIFKNPTuaDjeMbymtyWTFI8rI8H7g
   UahcKUgRTu6e6S+e02M5DxiAIjbshOGm2/wdaJxKAmtqpoGiSiLNr1O2w
   A==;
X-CSE-ConnectionGUID: fYVxvTQZQBeZLKAHRcGcnw==
X-CSE-MsgGUID: 5Omtx27YQB6IN06rzgG5zA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="9298668"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="9298668"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 18:15:29 -0700
X-CSE-ConnectionGUID: XJThbsBkSeiRHKyhs3iP1Q==
X-CSE-MsgGUID: eGGIpkEuRs6I3ZKY8r8iIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="23243959"
Received: from sferrell-mobl2.amr.corp.intel.com (HELO desk) ([10.209.93.160])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 18:15:08 -0700
Date: Thu, 18 Apr 2024 18:14:45 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
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
Message-ID: <20240419011445.2ryomgruj2ein6wh@desk>
References: <eda0ec65f4612cc66875aaf76e738643f41fbc01.1713296762.git.jpoimboe@kernel.org>
 <dad3a832-b3d0-4c72-a9f1-1ec4e6bc6bba@citrix.com>
 <20240417164514.66hgypzxgqxt3ssk@desk>
 <20240417175723.r4si62d6oqirqadb@treble>
 <2a490bb4-fd00-46e7-b7c3-bb8ef962d8b9@citrix.com>
 <20240419004845.ker26cp3hslttslk@treble>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240419004845.ker26cp3hslttslk@treble>

On Thu, Apr 18, 2024 at 05:48:45PM -0700, Josh Poimboeuf wrote:
> On Wed, Apr 17, 2024 at 07:01:54PM +0100, Andrew Cooper wrote:
> > On 17/04/2024 6:57 pm, Josh Poimboeuf wrote:
> > > On Wed, Apr 17, 2024 at 09:45:14AM -0700, Pawan Gupta wrote:
> > >> On Wed, Apr 17, 2024 at 04:14:26PM +0100, Andrew Cooper wrote:
> > >>> On 17/04/2024 12:02 am, Josh Poimboeuf wrote:
> > >>>> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > >>>> index ca295b0c1eee..dcb97cc2758f 100644
> > >>>> --- a/arch/x86/kernel/cpu/bugs.c
> > >>>> +++ b/arch/x86/kernel/cpu/bugs.c
> > >>>> @@ -1678,6 +1687,21 @@ static void __init spectre_v2_select_mitigation(void)
> > >>>>  	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
> > >>>>  	enum spectre_v2_mitigation mode = SPECTRE_V2_NONE;
> > >>>>  
> > >>>> +	/*
> > >>>> +	 * X86_FEATURE_INDIRECT_SAFE indicates whether indirect calls can be
> > >>>> +	 * considered safe.  That means either:
> > >>>> +	 *
> > >>>> +	 *   - the CPU isn't vulnerable to Spectre v2 or its variants;
> > >>>> +	 *
> > >>>> +	 *   - a hardware mitigation is in place (e.g., IBRS, BHI_DIS_S); or
> > >>>> +	 *
> > >>>> +	 *   - the user turned off mitigations altogether.
> > >>>> +	 *
> > >>>> +	 * Assume innocence until proven guilty: set the cap bit now, then
> > >>>> +	 * clear it later if/when needed.
> > >>>> +	 */
> > >>>> +	setup_force_cpu_cap(X86_FEATURE_INDIRECT_SAFE);
> > >>> Following on from the (re)discovery that X86_FEATURE_RETPOLINE is a poor
> > >>> name given what it *actually* does, can I recommend s/SAFE/OK/ here?
> > >> Or simply X86_FEATURE_USE_INDIRECT_BRANCH.
> > >>
> > >>> This flag really is "do I want indirect branches or not", which - as
> > >>> noted here - is more than just a judgement of whether indirect branches
> > >>> are "safe".
> > > X86_FEATURE_USE_INDIRECT_BRANCH sounds good.  It's a bit long but does
> > > describe it better.
> > 
> > Works for me.  Definitely an improvement over SAFE.
> 
> USE_INDIRECT_BRANCH is now irking me: "use indirect branch for what?
> when? why?"

I don't think feature bits in general tries to answer when & why. And it
shouldn't be the case, otherwise we will need multi-line names. IMO, it
should just tell what the feature means. But, I am not too hung up on
name, I am fine with X86_FEATURE_INDIRECT_OK or anything similar.

