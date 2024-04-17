Return-Path: <linux-kernel+bounces-148988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 414038A8A20
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C9A1C23BB4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2EC171E71;
	Wed, 17 Apr 2024 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eqBigC/X"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0D513C8E9
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713374560; cv=none; b=q+bj5/ha4HSAtUZFgsd0+2vLHuscxekkpGRCzeDkqNYT0Jrx4kzoqiz+Eqv3/CWUsUByITTD6W1dvcCVeGzYnkQGnIkSrQdUJFxk0JbJHa144zXyuowN+3hdA7qwwHcZlfu066Dm/wlhMCCMbF/mXMbdzei/TFhhYTwmQERAPcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713374560; c=relaxed/simple;
	bh=eHImo8FFvRAWgxCctWJzMGTyZsJQGg0HJ+CpMj/m9k8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQu/3tQPY/I9p5udYF1jsqJbxsxjoZ0EJ9NHT+MfJrpR+7cvIasnTSGRLej7ARlyvFqbt653dAzSJ6OBBoAmfY1Cd0TFTV6QVkE8nK8hRDdvEAlnlrN1bSl3vSaqTPgJMxTN6i9We68gjBGgluxPTwdJ2wDKJMkCJ8PM0X2OR1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eqBigC/X; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713374559; x=1744910559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eHImo8FFvRAWgxCctWJzMGTyZsJQGg0HJ+CpMj/m9k8=;
  b=eqBigC/XkUWmgmyDqMeZNUtikpOTR9FpVS8OA5nqwIl22KJIy6bScj2i
   0xLYhdvrhOP5ZrnnsAqb1WW/P6tkBw+69DZrI4VEs9G1JuCwUrhUIdJKw
   uOMgEbIhe+Z/PWH0TbNWu7LAMtcmCc1ohwyNir80IxsjCez8ZPqtLgm+7
   OkTS9nCFv4YvbLz3LNXUPoxHvHRB7gsbjPFcyx/Lvo7E+z92q2R1ILvbK
   lG0pdBfkG44/gfIUf+aXBS3R4aUc8yRisMAXhnsGKFYkb1YqOWojN+jRP
   yI2csNa8mov/oNsSOeifU62dX6OlCjSN3f8q9n37bWeQL1XHbpG+qU5or
   g==;
X-CSE-ConnectionGUID: aVZRN8rGTBy9ShPIn+ZgMQ==
X-CSE-MsgGUID: oxsuMUq5T7OUVkfM/eDgFw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="9008761"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="9008761"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 10:22:30 -0700
X-CSE-ConnectionGUID: Mxq1fQuMT52yQPn4X0Iu8Q==
X-CSE-MsgGUID: Vi6j8bhpQZCUgX9UTuDIbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="22775215"
Received: from wangc3-mobl.amr.corp.intel.com (HELO desk) ([10.209.4.219])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 10:22:29 -0700
Date: Wed, 17 Apr 2024 10:22:22 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Xi Ruoyao <xry111@xry111.site>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH v8 2/2] x86/mm: Don't disable PCID if the kernel is
 running on a hypervisor
Message-ID: <20240417172222.f4h2csf4xkffccqn@desk>
References: <20240413044129.52812-1-xry111@xry111.site>
 <20240413044129.52812-2-xry111@xry111.site>
 <Zh8Oli5MIyekLrbu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh8Oli5MIyekLrbu@google.com>

On Tue, Apr 16, 2024 at 04:49:42PM -0700, Sean Christopherson wrote:
> On Sat, Apr 13, 2024, Xi Ruoyao wrote:
> > The Intel erratum for "incomplete Global INVLPG flushes" says:
> > 
> >     This erratum does not apply in VMX non-root operation. It applies
> >     only when PCIDs are enabled and either in VMX root operation or
> >     outside VMX operation.
> > 
> > So if the kernel is running in a hypervisor, we are in VMX non-root
> > operation and we should be safe to use PCID.
> > 
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Michael Kelley <mhklinux@outlook.com>
> > Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > Cc: Sean Christopherson <seanjc@google.com>
> > Cc: Andrew Cooper <andrew.cooper3@citrix.com>
> > Link: https://lore.kernel.org/all/168436059559.404.13934972543631851306.tip-bot2@tip-bot2/
> > Link: https://cdrdv2.intel.com/v1/dl/getContent/740518 # RPL042, rev. 13
> > Link: https://cdrdv2.intel.com/v1/dl/getContent/682436 # ADL063, rev. 24
> > Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> > ---
> >  arch/x86/mm/init.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> > index c318cdc35467..6010f86c5acd 100644
> > --- a/arch/x86/mm/init.c
> > +++ b/arch/x86/mm/init.c
> > @@ -275,6 +275,14 @@ static void __init probe_page_size_mask(void)
> >   * microcode is not updated to fix the issue.
> >   */
> >  static const struct x86_cpu_id invlpg_miss_ids[] = {
> > +	/* Only bare-metal is affected.  PCIDs in guests are OK.  */
> > +	{
> > +	  .vendor	= X86_VENDOR_INTEL,
> > +	  .family	= 6,
> > +	  .model	= INTEL_FAM6_ANY,
> > +	  .feature	= X86_FEATURE_HYPERVISOR,
> 
> Isn't this inverted?  x86_match_cpu() will return NULL if the CPU doesn't have
> HYPERVISOR.  We want it to return NULL if the CPU *does* have HYPERVISOR.

I think the implementation is correct, x86_match_cpu() will not return
NULL if the CPU doesn't have HYPERVISOR feature *and* matches one of the
CPUs below. It will only return NULL if none of the entries match.

> > +	  .driver_data	= 0,
> > +	},
> >  	INTEL_MATCH(INTEL_FAM6_ALDERLAKE,	0x2e),
> >  	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L,	0x42c),
> >  	INTEL_MATCH(INTEL_FAM6_ATOM_GRACEMONT,	0x11),
> > -- 
> > 2.44.0
> > 

