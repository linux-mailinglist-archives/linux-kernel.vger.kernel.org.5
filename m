Return-Path: <linux-kernel+bounces-142895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2CB8A31BB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23491285080
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EB9145333;
	Fri, 12 Apr 2024 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bm1cA1ya"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0521F146D68
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934124; cv=none; b=rVT/6BNtKxL6mHcWvn+bfon701weM7UlXYKnUPLt3yeL4azSwUWYBNuXLashHMil5ojUAaaPzke4bfiaR8xH/e3IkwlB+Nrn1enSqZCyCTean7YwNzmhyJAWzF5L1/REKPF5WdpJ5Jyh0cQgfREdQrxsH8QbMr6SlUFjuYhcvtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934124; c=relaxed/simple;
	bh=uMShFtLOUG8eV3KMCwAPHQbJV1SdgUmb18i0oOTiTpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgQK1TUi5F3DMMUFEF9W8wB2jmMmjIuQB95PUaeGlHvu6dRxEJHU8T7507Pa7u8CVHninn7LfNc9S91dDsCmVunizgxHBXwbml+NpNX/dPJLglpQEt/5ScmyfWVfuW27DtNg/RdQQuqkG80cS/kG6Eu+RyVLq+G95/mEKd/KvRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bm1cA1ya; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712934123; x=1744470123;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uMShFtLOUG8eV3KMCwAPHQbJV1SdgUmb18i0oOTiTpk=;
  b=bm1cA1yak0r3+RMO/7mjcuGJ+l1khXSGO1Px3NdmDd1nn0zjdU9mL67+
   +fpwkEBcfspBQmBLcYbetygYc20eSkM+oQRkliB1wisD9T6V9C63pmSWI
   ChhXdVe7BSBVKTzONujeb00ujz7S6ge7j1HKkG1yJjivgdeH/lV94hblU
   NdLz6iSXkvN7yokOlVGK6gmZFlTLIKBB6ZrUzI88RReGRrNWLZ6FM1/Oi
   CC6CEIsb/U68G9JdBxCuZeG62uO3noRMqt7s3/z/emCJGzKRdycvLL0dZ
   WbH8D4/IoK42l3PcvEo/ARRiLUcKenTLE7UmvQOfu6FiJmLgNFE+Q/6xX
   Q==;
X-CSE-ConnectionGUID: fGfX9lJvShKktvByN47pOw==
X-CSE-MsgGUID: +qSY3yqEQwmR9MqLvNDv3A==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="19786970"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="19786970"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 08:02:02 -0700
X-CSE-ConnectionGUID: /S7f/l5ET5e4oP9wsilGiw==
X-CSE-MsgGUID: kE81WDBHRhuHx/4CFCqFjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="26063040"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 12 Apr 2024 08:01:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 43ED4E7; Fri, 12 Apr 2024 18:01:58 +0300 (EEST)
Date: Fri, 12 Apr 2024 18:01:58 +0300
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, 
	"mingo@redhat.com" <mingo@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>, 
	"bp@alien8.de" <bp@alien8.de>, 
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	"Reshetova, Elena" <elena.reshetova@intel.com>, "seanjc@google.com" <seanjc@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv2 0/4] x86/tdx: Adjust TD settings on boot
Message-ID: <gpqnnq6zubgltybaruzbpvdd3k27exylp3bzmz6cqpvhx5ee5e@vto2bmdz7kji>
References: <20240325104607.2653307-1-kirill.shutemov@linux.intel.com>
 <sbunoj5dm6xifhqog5aaeujrbiilfqufum5msoiqtp2di3nsbs@wdoa37qkziwe>
 <46cb81e0dda6196a1339cdfc93ea93f2d13c3e4b.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46cb81e0dda6196a1339cdfc93ea93f2d13c3e4b.camel@intel.com>

On Wed, Apr 10, 2024 at 02:41:13PM +0000, Edgecombe, Rick P wrote:
> On Wed, 2024-04-10 at 17:37 +0300, Kirill A. Shutemov wrote:
> > On Mon, Mar 25, 2024 at 12:46:03PM +0200, Kirill A. Shutemov wrote:
> > > Adjust TD setting on boot:
> > > 
> > >    - Disable EPT violation #VE on private memory if TD can
> > >      control it;
> > > 
> > >    - Enable virtualization of topology-related CPUID leafs
> > >      X2APIC_APICID MSR;
> > 
> > Any feedback?
> 
> It is missing a lot of the normal things that come in coverletters like what is
> the problem and importance. It might help attract more review.

What about this:

The patchset adjusts a few TD settings on boot for the optimal functioning
of the system:

  - Disable EPT violation #VE on private memory if TD can control it

    The newer TDX module allows the guest to control whether it wants to
    see #VE on EPT violation on private memory. The Linux kernel does not
    want such #VEs and needs to disable them.

  - Enable virtualization of topology-related CPUID leafs X2APIC_APICID MSR;

    The ENUM_TOPOLOGY feature allows the VMM to provide topology
    information to the guest. Enabling the feature eliminates
    topology-related #VEs: the TDX module virtualizes accesses to the
    CPUID leafs and the MSR.

    It allows TDX guest to run with non-trivial topology configuration.
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

