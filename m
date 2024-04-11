Return-Path: <linux-kernel+bounces-140508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DFA8A1590
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0E61F24222
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E03014F10D;
	Thu, 11 Apr 2024 13:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnEQMbCj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D6214C594
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842316; cv=none; b=Wgac5w4PF+Tc1O/sqJUi4f9kOnN4aaA8TERk2kMK/DpVxZ/vOKXWAjtlOOvXMSrwm2uvWRrrwFY7FmEtiIItnVqsRNsEavWKvu+BUA/sccaFmY7cUH66RHRr5AUKPXmtKs8/jYWas7qMt+5xSXuY1arp/3h9IhPYvotLTIKReB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842316; c=relaxed/simple;
	bh=bTynQeGWlowWeebPAzjnvqcyKByxZd8qxbvPbpIUZ+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liPQm5B4UQjVViP6vZ9S1lJGcqlp/7z4aCgCTRphPN4Dh6Ibi6oQZGS/eNxO6NDm3keT+gzShS0Orbh8Kfa2LpZkcJAFvkhlo+AZCD91r4L9MCLsz5/9lcA1u4QqKfT7MB8dI/N6TVC+t1CgBOD9KlHdtqnzS53rZBH0+jmkNu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dnEQMbCj; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712842315; x=1744378315;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bTynQeGWlowWeebPAzjnvqcyKByxZd8qxbvPbpIUZ+0=;
  b=dnEQMbCj9gykvc9jls7WAsOo4MnzAk8zz2p2lbaFfwH9iCbl+vPq/t64
   rGFyI3Yt8L4kSEDXDv0gXYRTISxv1Off8Q7xXfPlpnG+5eHOohj9N2taa
   FVmtil03wOoJHvJYhlLo8zP8/uSNZySX4Gs8XsXvzNANr6EQcD1nzmIWE
   YFD36GsMznEwKp4sEznZjHhTmPt6StXh1gECRf9xZ3HPSoZoxNEyaJgTs
   T5HQbSBGT2nKrKQ1i8z3K2iu8HglsjicIYlHd00oSnig3yjWhJ+oswYXG
   9s/VZJ5oEln48GiDAQldxiY5GXUx4VCOf0pAeuKik7tCsACCNHTEmGSM6
   Q==;
X-CSE-ConnectionGUID: 5cL6WY/PRdq9s9DMMlQPCg==
X-CSE-MsgGUID: XgsdrAHUT+ig8SmrPfETzQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8102772"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8102772"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 06:31:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="937096996"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="937096996"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 11 Apr 2024 06:31:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id B9C4932A; Thu, 11 Apr 2024 16:31:49 +0300 (EEST)
Date: Thu, 11 Apr 2024 16:31:49 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com, 
	bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, 
	luto@kernel.org, peterz@infradead.org, rick.p.edgecombe@intel.com, 
	thomas.lendacky@amd.com, ashish.kalra@amd.com, chao.gao@intel.com, bhe@redhat.com, 
	nik.borisov@suse.com, pbonzini@redhat.com, seanjc@google.com
Subject: Re: [PATCH v3 1/5] x86/kexec: do unconditional WBINVD for bare-metal
 in stop_this_cpu()
Message-ID: <bvtzoqizxzz5ltepttwxu7nlny3najrci6reuybdfwcxpcpqtd@ixovf5h32j62>
References: <cover.1712493366.git.kai.huang@intel.com>
 <33b985a8f4346f4bcf0944eaf37193a906b11af3.1712493366.git.kai.huang@intel.com>
 <a4o4wlaojm5am4hc5yhr2mpn7clm3sjy5vx3w76ahm52lhxvwr@msdcnkcj3i6k>
 <4875349a-90e5-4a04-8a56-7d172b17e245@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4875349a-90e5-4a04-8a56-7d172b17e245@intel.com>

On Thu, Apr 11, 2024 at 09:54:13AM +1200, Huang, Kai wrote:
> 
> 
> On 11/04/2024 2:12 am, Kirill A. Shutemov wrote:
> > On Mon, Apr 08, 2024 at 12:44:54AM +1200, Kai Huang wrote:
> > > TL;DR:
> > 
> > The commit message is waaay too verbose for no good reason. You don't
> > really need to repeat all the history around this code.
> 
> Could you be more specific?
> 
> I was following Boris's suggestion to summerize all the discussion around
> the "unconditional WBINVD" issue.
> 
> https://lore.kernel.org/linux-kernel/20240228110207.GCZd8Sr8mXHA2KTiLz@fat_crate.local/
> 
> I can try to improve if I can know specifically what should be trimmed down.

What about something like this:

  x86/mm: Do unconditional WBINVD in stop_this_cpu() for bare metal

  Both AMD SME and Intel TDX can leave caches in an incoherent state due to
  memory encryption, which can lead to silent memory corruption during kexec. To
  address this issue, it is necessary to flush the caches before jumping to the
  second kernel.

  Previously, the kernel only performed WBINVD in stop_this_cpu() when SME
  support was detected. To support TDX as well, instead of adding vendor-specific
  checks, it is proposed to unconditionally perform WBINVD. Kexec() is a slow
  path, and the additional WBINVD is acceptable for the sake of simplicity and
  maintainability.

  It is important to note that WBINVD should only be done for bare-metal
  scenarios, as TDX guests and SEV-ES/SEV-SNP guests may not handle unexpected
  exceptions (#VE or #VC) caused by WBINVD.

  Historically, there were issues with unconditional WBINVD, leading to system
  hangs or resets on different Intel systems. These issues were addressed by a
  series of commits, culminating in the fix provided by commit 1f5e7eb7868e
  ("x86/smp: Make stop_other_cpus() more robust").

  Further testing on problematic machines confirmed that the issues could not be
  reproduced after applying the fix. Therefore, it is now safe to unconditionally
  perform WBINVD in stop_this_cpu().

You can also add links to relevant threads as Link: tags.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

