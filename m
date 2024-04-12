Return-Path: <linux-kernel+bounces-143426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C138A38D8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 01:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4A91F22513
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0133315250F;
	Fri, 12 Apr 2024 23:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EY8z3CLX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87B44F88A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 23:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712963913; cv=none; b=aIm0pvKiZDq9ItX9w3QG3ESR37hXd4GxHGYF7+GPSmz9Ir1z7KOb9aRoG1n0ztvK3gcqU7/C9qn8ZvEUazN5AhpPVA9sIgMqVUXM7tJm9RY2XQFdTiq+XLRF2+BpAqpCTd19eINrKROWlfqN1wkpYmnTT65UXSa8szvlvbxgRfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712963913; c=relaxed/simple;
	bh=T6w/dY9iG0zkHv9Tv196kf4Z/Xh1jcarNRLPTU311bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtvM2ZfLGkYNSVHUoOsRYfdxpDOuh9CZ8taMNQgh96CjHOM8J7wrNrjbDmuaFNwm8Cg9IUGZpAtZauB9RPbpMQROeKl1AaqG9CGG+nELKUVLdnPEDiSNqOQi5kUfA6Xrm7zam7P5SZhDEZQ5k1qE6tO6nvfi7++dHI5HF9qOCB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EY8z3CLX; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712963912; x=1744499912;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T6w/dY9iG0zkHv9Tv196kf4Z/Xh1jcarNRLPTU311bE=;
  b=EY8z3CLXqiK+YNDV31eWGkPRatNbo6DCS8VQdHqH1qaZrlkuVyD+2flX
   NT6JA7LUFIHXezZcXL/35YjDjIqubbQTqKR+Rxr2lfBXZkIbrMs3FdbsC
   Yjaumn2kmQGDW83f7Yr1yxNaIeYzLnf4HR6tKERslZg9bzoX+neZe96me
   C1W2kDwmgYXuBWTvC8BCSAsK6ivK4KSuOLW++3ZnZfd4195kfS2FLmWU3
   A1pUXW4AWjgE5z9p0gwgpRJUMVqN0ku/aIGQfPdkGJC1hdRvCtz3STB7O
   VDH2DWpOu3KlloXS0rXy5Jhgmt3pZn9IvLYBMj10YnTuxFsXqAXccGlMb
   A==;
X-CSE-ConnectionGUID: M4QYbQsDQlWI/tW647BBoQ==
X-CSE-MsgGUID: xMTw5kaZR+a38A7fkwNPOg==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="12219493"
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="12219493"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 16:18:31 -0700
X-CSE-ConnectionGUID: Sxtt5eLgTweMS8EKqszuMw==
X-CSE-MsgGUID: PxE1jPwPQqK7Yakd622N0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="25791259"
Received: from ttmartin-mobl1.amr.corp.intel.com (HELO desk) ([10.209.4.27])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 16:18:30 -0700
Date: Fri, 12 Apr 2024 16:18:21 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/3] x86/bugs: Fix BHI retpoline check
Message-ID: <20240412231648.orlj7lomjaqqj7mz@desk>
References: <cover.1712944776.git.jpoimboe@kernel.org>
 <ad3807424a3953f0323c011a643405619f2a4927.1712944776.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad3807424a3953f0323c011a643405619f2a4927.1712944776.git.jpoimboe@kernel.org>

On Fri, Apr 12, 2024 at 11:10:33AM -0700, Josh Poimboeuf wrote:
> Confusingly, X86_FEATURE_RETPOLINE doesn't mean retpolines are enabled,
> as it also includes the original "AMD retpoline" which isn't a retpoline
> at all.
> 
> Also replace cpu_feature_enabled() with boot_cpu_has() because this is
> before alternatives are patched and cpu_feature_enabled()'s fallback
> path is slower than plain old boot_cpu_has().
> 
> Fixes: ec9404e40e8f ("x86/bhi: Add BHI mitigation knob")
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

