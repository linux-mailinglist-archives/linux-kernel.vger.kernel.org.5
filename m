Return-Path: <linux-kernel+bounces-143378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 954E08A37D1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66701C20D52
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D7C15216A;
	Fri, 12 Apr 2024 21:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qe6zm3fd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A43152160
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 21:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712957020; cv=none; b=oMtgS4p57MddTqPWcHnRRb7ZfvWVVlsRkaIAZHgd6ZT1WAA9d5oT5prvrb9Vq3GYNkV8yCwjt5sbMSEWNpo4NimKBXUsoEavFEsgyv/RtvJUUr97OpBVXZE8j4tuG9p2HVhTDKpAocitLXDlu0J+rUSihykMhjn++Od/Zj4Ga4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712957020; c=relaxed/simple;
	bh=Bq3H/RyDbl490yZ4MG8+fNB+9hwAPtOP5y4q+oQYBho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srcoQUSm6wUNp6vpeRYOXb4gFJ9TdszPaBrCKw5T4KGmgl6dh8HLhAssRQaE3IN1WWuX/TpePRALRFn1eX/arChGn3EyHLBpkcxgnxqKxUxtk+FIOCub10E25Sf8cWCL67RtT7L96jJ8li4iI8chKZBoVPq9L6lqYlKQZMMXKJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qe6zm3fd; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712957018; x=1744493018;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bq3H/RyDbl490yZ4MG8+fNB+9hwAPtOP5y4q+oQYBho=;
  b=Qe6zm3fdJJW8Dsl98JfJC7y3bYsK6aZUgCIqRMmWoUnOQwoiuN/WKUNe
   OGac4UTPcIAImUYivHKgGjnA9VFUSknw06UPxIks0SFwEhCoQp9Et5Sz8
   f2TOl4Bx8Vzy/wEc2+Tsva7lEuCuZyv+5RmJrcoq6w3q1c5c0oBpu6I6h
   KO0f2N8fzClWL0jL1wjFMuPRPZ1iJLGFkl34+L6JGLrd1yIs4i//dZ9rq
   KnM2SkhX5uIhDFwdlpz8Uwy5HOvA1K+eUdJ7X4OnJQ3+xgQyK08+C6b5y
   Eo48oFlzQLk0jqPSODRsRNEi7LAbWyhoYAk/2vGHYnfLL5ZbIVmcG5EzS
   w==;
X-CSE-ConnectionGUID: MZ1lGiYRTaWeG2dpUu9eTw==
X-CSE-MsgGUID: wM+UlvEyTdufYAIhhjWS3Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="8346708"
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="8346708"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 14:23:38 -0700
X-CSE-ConnectionGUID: vPs/dnBQSC6BvKbTYFciEg==
X-CSE-MsgGUID: OoOkRVn1TCSCTa+GcWkhyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="25770875"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 12 Apr 2024 14:23:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 73F98FF; Sat, 13 Apr 2024 00:23:33 +0300 (EEST)
Date: Sat, 13 Apr 2024 00:23:33 +0300
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, 
	"mingo@redhat.com" <mingo@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>, 
	"bp@alien8.de" <bp@alien8.de>, "Cui, Dexuan" <decui@microsoft.com>, 
	"Reshetova, Elena" <elena.reshetova@intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"seanjc@google.com" <seanjc@google.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
	"cho@microsoft.com" <cho@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/tdx: Preserve shared bit on mprotect()
Message-ID: <h6cd5ag3t4t46hxnun427tuubnvwg542nydaxugs4i5p2knijk@ug3vsfpyvklk>
References: <20240412191247.369841-1-kirill.shutemov@linux.intel.com>
 <40abc379ba6c690fd5a768070b7906c694a1b49d.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40abc379ba6c690fd5a768070b7906c694a1b49d.camel@intel.com>

On Fri, Apr 12, 2024 at 08:48:56PM +0000, Edgecombe, Rick P wrote:
> On Fri, 2024-04-12 at 22:12 +0300, Kirill A. Shutemov wrote:
> > The TDX guest platform takes one bit from the physical address to
> > indicate if the page is shared (accessible by VMM). This bit is not part
> > of the physical_mask and is not preserved during mprotect(). As a
> > result, the 'shared' bit is lost during mprotect() on shared mappings.
> > 
> > _COMMON_PAGE_CHG_MASK specifies which PTE bits need to be preserved
> > during modification. AMD includes 'sme_me_mask' in the define to
> > preserve the 'encrypt' bit.
> > 
> > To cover both Intel and AMD cases, include 'cc_mask' in
> > _COMMON_PAGE_CHG_MASK instead of 'sme_me_mask'.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Fixes: 41394e33f3a0 ("x86/tdx: Extend the confidential computing API to
> > support TDX guests")
> > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > Cc: Chris Oo <cho@microsoft.com>
> > Cc: Dexuan Cui <decui@microsoft.com>
> 
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 
> So does this mean there is shared memory mapped to userspace? Or is this a
> theoretical correctness thing?

Drivers can do this. Things like VFIO, I guess.

I think I should have credited Chris for reporting and testing the problem:

Reported-and-tested-by: Chris Oo <cho@microsoft.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

