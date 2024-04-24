Return-Path: <linux-kernel+bounces-157084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B330F8B0CA7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56AF6B210F2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7601115E7F9;
	Wed, 24 Apr 2024 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DA7oZmg/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B47E15B15C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969354; cv=none; b=asu2xV5qo8lGzsGQX0iY5rjW0R1O0qlKhIdehUJ6QXzaJx15ZZs+RB229jhrXiNYsBV/Hj4SUzVGu2RkvESGFfkpzYjY+Bm2aZuxUhoWqyIc2oq9g9D892UTGp/07slYAkecPmx9geraoaxxifM8w9sC1mFbch0XwwhvMFGHTEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969354; c=relaxed/simple;
	bh=kYUJMj8WambktxnBcdatjza3aKu1bxR5g5szXi3Etjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pftVxeydh959qn4MmXZ/eYXKhfbL5NLdiykJpB8OKMPxkaK+wHTvsyq8IbKavkOwxU6RA5SnN9LzgcLzbb4M59Ba4UB5W7SyPWBXgsXOWVkZLrG0J6Y8k2cX1PaeFOYuhd1kHBQibjFD3+jhTX4vpI81zvWgSjbC9eLNuWIAllg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DA7oZmg/; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713969354; x=1745505354;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kYUJMj8WambktxnBcdatjza3aKu1bxR5g5szXi3Etjc=;
  b=DA7oZmg/cVWSbjbWfdVDYpXVEc2VUX7t+ZDMiAlcdmZI1igRiYcoi6vB
   4X8LPaw/+sax049LJniGDkh5iV70d+hjKGOk4VN4Lbx1FOuPXv1nDsKUm
   y17w4koiYfd0SSofn/1NLBHZsid7OwsPIL0q2SaD/VQsrgnmU39tcsE5h
   vvB2Z/TAn9/gkFTlxaYQL22+6bmqtVuomip3hKDOtgOdi5Brhvgzss6zO
   bqwQGWuZ03+Qs9WyLklKV+O6Q7bdd6Q/daxU7b+dRRrUxllZW6nDHLHGq
   NDD6KrwP3JnOF8Q5zfJMDkehiJNK/y7oz7llooSg4ugvI53gNODpnOwx5
   g==;
X-CSE-ConnectionGUID: 32Nf0IapQQ+E2Te2iDX/aA==
X-CSE-MsgGUID: n7CWIlW7T5KOt4wfCbtNVQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9825853"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9825853"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 07:35:53 -0700
X-CSE-ConnectionGUID: a/dchSKJR/COZIoy8TSfXA==
X-CSE-MsgGUID: wBqVpR8xRTSjGjiyMjjTRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="62191162"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 24 Apr 2024 07:35:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 715EF1BD; Wed, 24 Apr 2024 17:35:46 +0300 (EEST)
Date: Wed, 24 Apr 2024 17:35:46 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv10 04/18] cpu/hotplug, x86/acpi: Disable CPU offlining
 for ACPI MADT wakeup
Message-ID: <svpuqhoglv7s2wtu754i4oicowueen47vq6eobjbznsromb4m3@4h7vy346n4ak>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-5-kirill.shutemov@linux.intel.com>
 <20240423160258.GBZifbsuoTIbWDapej@fat_crate.local>
 <k4t62qfiyapfh2hjp4bpnaa4bmtlajpm5q4an3qs4jimhldcwv@wtrp63ofrfk6>
 <20240424135052.GDZikOPIOeGxtQRBBc@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424135052.GDZikOPIOeGxtQRBBc@fat_crate.local>

On Wed, Apr 24, 2024 at 03:50:52PM +0200, Borislav Petkov wrote:
> On Wed, Apr 24, 2024 at 11:38:42AM +0300, Kirill A. Shutemov wrote:
> > It was wrong from beginning. If ACPI MADT wake up method is used on the
> > platform, we cannot handle offline, regardless if it is TDX or not.
> 
> Sounds to me like this fact should be a prominent part of the commit
> message and these 1-4 patches should be carved out as a separate set
> fixing that ACPI MADT thing and I should take them separately now...?
> 
> Also, does this need to go to stable although it is kinda big for
> stable. If stable, do we need a smaller fix first which is backportable?

Correct me, if I am wrong, but I believe TDX guest is the only user of
ACPI MADT wake up method. At least it was added into kernel for TDX guest.
So it wouldn't fix anything user-visible. It might affect a future
platform that uses this wake up method, but it is a guessing game.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

