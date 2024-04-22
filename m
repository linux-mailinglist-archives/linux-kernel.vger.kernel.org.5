Return-Path: <linux-kernel+bounces-154057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9DF8AD6B1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB801C2176F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E371CF8B;
	Mon, 22 Apr 2024 21:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="glYgGSXA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239E21CD37
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 21:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713821544; cv=none; b=FDBsnwDw+DVZv1l7PO75OsnmPyKecyxXkmo3W1XmdXvSSMJWkO8iguWG4ICw9jfP3NAGb6aMEbiOoTwJZyPrltby9BJh6P/Q9hHNf++ZK37nL2F89RKXXt1V1blH88dfOoIeJTELQykhqBA291ygWTtKV/iokv5FnHKk7UOHORc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713821544; c=relaxed/simple;
	bh=IRsFuwn6dQzU9I5rLPauWk/unA6s6gPNbq/SefNksJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMYVJcREjHTdXpUUtqieYHTyenAOXwci8V/7H++mCpis8tabdFjV52GcD3YwOnnH8u2NZJbOGcUy6e6m0PvLhk4JabaVV3bme/1TvbI32Y/thFbJEqYpAcmjEdWKSez8jyP0sQln/59ZOmY9MLfMu3XnQLPWpo21dZB6iHhy7qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=glYgGSXA; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713821543; x=1745357543;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IRsFuwn6dQzU9I5rLPauWk/unA6s6gPNbq/SefNksJs=;
  b=glYgGSXAtIh8hAcB3X4l92SdOiTePzTMWsw2Yesn0eIKLVs8OkhPE9ZH
   fwPfsXCxXiPbYFzZJ4i1QFuz0bIbH5rRELR59n2hy0AgzOP9jNv7AN22z
   8AfloMzD9UZuEbLN5b27Xf6GlBVHz3EiS7Mpqv0I/zYT8XOv1aagquEyD
   34AvQBmc+0MlM0t60GhmUztAYO02u83krO2Ii4uMdNs7qGtA6cAqpyau6
   52wYmuy/lqBOSXc8ROqWMMQTZxL6QKLTzF8V8ACWZl5X3bP30rW0uw/8J
   GZ9oomvZli+iA8O9OLygneOF5rZpzw4YJl5Usf9gAaBAMkHSUlQgQmCyi
   g==;
X-CSE-ConnectionGUID: oTpSlzzSR8SVYJBC9p00rQ==
X-CSE-MsgGUID: ys5XZwZgQFCV/sG3dQvIVw==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="26898367"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="26898367"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 14:32:22 -0700
X-CSE-ConnectionGUID: HZ0B6eXYSA6zky5jPtNC3w==
X-CSE-MsgGUID: G/20tqFXTKeF4lKFG5yfJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="24652505"
Received: from mhknutso-mobl.amr.corp.intel.com (HELO desk) ([10.209.121.126])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 14:32:22 -0700
Date: Mon, 22 Apr 2024 14:32:13 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, dan.j.williams@intel.com,
	bernie.keany@intel.com, charishma1.gairuboyina@intel.com,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	daniel.sneddon@linux.intel.com,
	antonio.gomez.iglesias@linux.intel.com
Subject: Re: [PATCH 15/14] x86/gds: Lock GDS mitigation when keylocker
 feature is present
Message-ID: <20240422213213.7og6adib7zcbpnys@desk>
References: <20240407230432.912290-1-chang.seok.bae@intel.com>
 <20240419-gds-lock-v1-1-adcbef6ce24b@linux.intel.com>
 <142380d5-27bd-4ddc-8c33-03a2f8701fa2@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <142380d5-27bd-4ddc-8c33-03a2f8701fa2@intel.com>

On Mon, Apr 22, 2024 at 12:35:45AM -0700, Chang S. Bae wrote:
> On 4/19/2024 10:47 AM, Pawan Gupta wrote:
> >   	/*
> > @@ -840,6 +843,11 @@ static void __init gds_select_mitigation(void)
> >   		gds_mitigation = GDS_MITIGATION_FULL_LOCKED;
> >   	}
> > +	/* Keylocker can only be enabled when GDS mitigation is locked */
> > +	if (boot_cpu_has(X86_FEATURE_KEYLOCKER) &&
> > +	    gds_mitigation == GDS_MITIGATION_FULL)
> > +		gds_mitigation = GDS_MITIGATION_FULL_LOCKED;
> > +
> 
> I'm having trouble understanding this change:
> 
> gds_select_mitigation()
> {
> 	...
> 	if (gds_mitigation == GDS_MITIGATION_FORCE)
> 		gds_mitigation = GDS_MITIGATION_FULL;
> 
> 	rdmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
> 	if (mcu_ctrl & GDS_MITG_LOCKED) {
> 		...
> 		gds_mitigation = GDS_MITIGATION_FULL_LOCKED;
> 	}
> 
> 	if (boot_cpu_has(X86_FEATURE_KEYLOCKER) &&
> 	    gds_mitigation == GDS_MITIGATION_FULL)
> 		gds_mitigation = GDS_MITIGATION_FULL_LOCKED;
> 
> As I understand it, gds_mitigation is set to GDS_MITIGATION_FULL only if the
> gds force option is enabled but IA32_MCU_OPT_CTRL[GDS_MITG_LOCK] is not set.

Not true, GDS_MITIGATION_FULL is the default. Cmdline
gather_data_sampling=force deploys a software fallback mitigation when
the microcode mitigation is not present. But, when microcode mitigation
is present, mitigation is set to GDS_MITIGATION_FULL.

> Then, if the CPU has Key Locker, this code sets gds_mitigation to
> GDS_MITIGATION_FULL_LOCKED, which seems contradictory. I'm not sure why this
> change is necessary.
>
> I'm also not convinced that the Key Locker series needs to modify this
> function. The Key Locker setup code should simply check the current
> mitigation status and enable the feature only if proper mitigation is in
> place. Am I missing something here?

To enable Key Locker feature, "proper mitigation" is microcode mitigation
enabled and the GDS_MITG_LOCK bit set in MSR_IA32_MCU_OPT_CTRL. Do you
agree?

If not via this patch, how is GDS_MITG_LOCK going to be set?

Below is from Intel's documentation:

  "Intel recommends that system software does not enable Key Locker (by
  setting CR4.KL) unless the GDS mitigation is enabled (IA32_MCU_OPT_CTRL
  [GDS_MITG_DIS] (bit 4) is 0) and locked (IA32_MCU_OPT_CTRL
  [GDS_MITG_LOCK](bit 5) is 1). This will prevent an adversary that takes
  control of the system from turning off the mitigation in order to infer
  the keys behind Key Locker handles.

  To support GDS mitigation locking for Key Locker, microcode updates
  for Tiger Lake systems enable the following model-specific behavior
  for GDS_MITG_LOCK. On these systems, a write to IA32_MCU_OPT_CTRL MSR
  with GDS_MITG_DIS (bit 4) value 0 and GDS_MITG_LOCK (bit 5) value 1
  will lock both bits at these values until reset."

