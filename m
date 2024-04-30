Return-Path: <linux-kernel+bounces-164304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA95F8B7C14
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07AD0B224E4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989F217555C;
	Tue, 30 Apr 2024 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mpl/akSL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33005171E68;
	Tue, 30 Apr 2024 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714492147; cv=none; b=Luv/IzpjqFViDLWBErcMTK1lB9/oBRXpcZTklr1qGw7dF/MZnvuFd9i2Dc5+zNXr7uZbW2CMhsYN42Iu0jbxoog3ysmyw9mMKRg3I+zIOEngLpHC3ktX9ZkamsGjKbWDWQ/rst03JmBWLwiQJWFkzsKijpp1z8cOvCpj/iWQ6tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714492147; c=relaxed/simple;
	bh=n5du6BmH1eDhxeN3CgYrS0Up0ITWwxkbEDux8vu9RSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAEcEBELrc3XIozRInljMFKfqv/4+VNrZsSpDJccNEZ72glF7NXyNtw/77A9V4UXf3k2cLAOGtV53tt3K07i5ef1FxlML3aP9jOxtoDNUbBnnbprFuEh632IJxx4C6HfiB1g1mseOD8K54Nd/Bi55+z6fk8248avVOTEtZkSUVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mpl/akSL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714492146; x=1746028146;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n5du6BmH1eDhxeN3CgYrS0Up0ITWwxkbEDux8vu9RSU=;
  b=Mpl/akSLR4FsuTffsVNQc0evC0DpxKb5DWnmfoZgsCX00eUy5NtfxfW8
   /zkK50X9RZu8Uiz7vcj+03wwHUgdFofeVVVLCx/447IL6NtZL/5qRq0Od
   GRm9HLMkxbiKtOoTgmPm/TvBmtymFhDfQ6xvjUvvZolApB5lqaKPwliUC
   U+sI8o4h25Wzjr4XpkNZAIFqFJPIhY/SN36POHD9imikOsj/VNC0TQ6dY
   b5ucnmf/NUsSG0Mss2EBANGTMMG4jg9+LQZXBdmQYmXvVSCZUObreK9UF
   WjXsU3FoaZ0vhKSsym/bKmTS7JOoJHdWMyc0yGlgxOLEQggRQdaqWyXey
   g==;
X-CSE-ConnectionGUID: aFx9boHeQD23odF0Yu/1rw==
X-CSE-MsgGUID: BIw1Mp1nS+uypYgAnztc3A==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10136348"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10136348"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 08:49:06 -0700
X-CSE-ConnectionGUID: +dkN6csMReS40ygK6hCZZQ==
X-CSE-MsgGUID: 0HHI0/4VRMCfje7CxOIIQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26586173"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.17.48])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 08:49:05 -0700
Date: Tue, 30 Apr 2024 08:49:03 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, Dan Williams <dan.j.williams@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v6 5/7] ACPI/NUMA: Return memblk modification state from
 numa_fill_memblks()
Message-ID: <ZjES7+pU7ULAq+42@aschofie-mobl2>
References: <20240430092200.2335887-1-rrichter@amd.com>
 <20240430092200.2335887-6-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430092200.2335887-6-rrichter@amd.com>

On Tue, Apr 30, 2024 at 11:21:58AM +0200, Robert Richter wrote:
> When registering a memory range a possibly overlapping memory block
> will be extended instead of creating a new one. If both ranges exactly
> overlap, the blocks remain unchanged and are just reused. The
> information if a memblock was extended is useful for diagnostics.
> 
> Change return code of numa_fill_memblks() to also report if memblocks
> have been modified.


Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> 
> Link: https://lore.kernel.org/all/ZiqnbD0CB9WUL1zu@aschofie-mobl2/T/#u
> Cc: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  arch/x86/mm/numa.c       | 33 ++++++++++++++++++---------------
>  drivers/acpi/numa/srat.c |  5 +++--
>  2 files changed, 21 insertions(+), 17 deletions(-)

snip

