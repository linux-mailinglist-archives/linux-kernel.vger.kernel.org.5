Return-Path: <linux-kernel+bounces-156556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C1C8B047D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787AB1C22647
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2CF156C7F;
	Wed, 24 Apr 2024 08:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="duzIhUsy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852231D52B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713947929; cv=none; b=fSyXUS+MAn0AQTnibPeZdjri3rkCkrVfPLdCOfjoSkNLv4vwkZkZqZH55YvruI8WXBzoJT7TlgqK2ZoBmLHCmlbkb+ojo8ZuuP4jexJPkyM7DzDzPaHdNQp6un3rUzjz8cbsbc1F93DURWN7yDtnU5qeCszC/kZ2oIKvjIOu0OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713947929; c=relaxed/simple;
	bh=hMMvxpDfbjDULv1fmXRnELIn09JQOXoi13BP9n0Ktzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmvoycvbPdpqlM39ClGRKiLqSjufbEE8Gg5Dng0sJRx1IxzfnoC7XCQk9CMjmNKTAL1fVDqWcGH+HtmM2lX7akdI6k3UjUvdJCsZTxmy+HV+ivrCLDBNf8ateCHbg4FrP1g8XcAPoUfly1yMG0zXMzPNCDp13b6l36qeLkj6ywU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=duzIhUsy; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713947929; x=1745483929;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hMMvxpDfbjDULv1fmXRnELIn09JQOXoi13BP9n0Ktzo=;
  b=duzIhUsyQ6vjwkTaGsJmxpJSFD2i3M5sWE+Yt9+vY4slbPL6D8og1zph
   0mmYWACGyWP9LB/pgczZSyLASUN4Tx3XG36JoKo+WXzwSnQ9YAvBHph6S
   y2xNsNxkPVj3j/+0nPTDRUIUq5VEljiBVgv+NQz6N/DRVVP0aTbumjyAK
   7/G3ruv6F0NBEvt6RcdznEj9yKJ5kXE1FSYF3IrHES5k4Y5199fcZtqx3
   yygl0Oa1GbOiJSQHWZ66KFJpk5FBh5bRcnI1OFFJUfPaxLv+Br+2Ws034
   R8agCo8KiKR7aVOsKmeY3zLANL5uWgPojpr0n+/XKgxy4KuYUEXeBc92B
   Q==;
X-CSE-ConnectionGUID: +uLxZ/PUTg2sqhJuWVLiIg==
X-CSE-MsgGUID: Tmdh/qC0TOmpQclm7wKzqA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="13398958"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="13398958"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 01:38:48 -0700
X-CSE-ConnectionGUID: +3UgJW18TYqRu6s+Kb1SXw==
X-CSE-MsgGUID: BmfrGwObTz612CZwmk9qVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24711899"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 24 Apr 2024 01:38:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 3DCFA28A; Wed, 24 Apr 2024 11:38:42 +0300 (EEST)
Date: Wed, 24 Apr 2024 11:38:42 +0300
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
Message-ID: <k4t62qfiyapfh2hjp4bpnaa4bmtlajpm5q4an3qs4jimhldcwv@wtrp63ofrfk6>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-5-kirill.shutemov@linux.intel.com>
 <20240423160258.GBZifbsuoTIbWDapej@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423160258.GBZifbsuoTIbWDapej@fat_crate.local>

On Tue, Apr 23, 2024 at 06:02:58PM +0200, Borislav Petkov wrote:
> > 
> > Currently CPU hotplug is prevented based on the confidential computing
> > attribute which is set for Intel TDX. But TDX is not the only possible
> > user of the wake up method.
> > 
> > Disable CPU offlining on ACPI MADT wakeup enumeration.
> 
> Something's missing in that "justification". It should explain why
> CC_ATTR_HOTPLUG_DISABLED is not needed anymore.

It was wrong from beginning. If ACPI MADT wake up method is used on the
platform, we cannot handle offline, regardless if it is TDX or not.

> And looking at patch 3, I'm still unclear as to why this change is done.
> Is it that the "ACPI MADT mailbox wakeup method" is going to be used by
> TDX guests now too so that you don't need CC_ATTR_HOTPLUG_DISABLED
> anymore?

ACPI MADT is the only wakeup method supported in TDX guests. But offline
is broken is because of ACPI MADT, not because of TDX.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

