Return-Path: <linux-kernel+bounces-159045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2040C8B2896
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B9E8B25D97
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75DF14F9F5;
	Thu, 25 Apr 2024 18:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TTm6ir8d"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4426B14C594;
	Thu, 25 Apr 2024 18:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071408; cv=none; b=T/MsBMKQyBsUrEz+WpFHOpedMV+jLg7pJJb3NhztWR6hPVNxoYAdl1SZBBDlGfDjbILjJG6C9saxpAwAP5jHpRetXnirnAr0cLMnQU/Ni/UP92BJNh3khiA7tmx+Tl9vq0qMpNKnic+IbRq9WjxX1a3+47uQ8tEb10zAjMEPw3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071408; c=relaxed/simple;
	bh=GyYS//eJdsqAA5UfCzd5uB8wCmszHJBWWtWWa6emUxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJdrFdpwwfn4H3E0Ff7nv0Svvbx9leoInOAdRG+2oj0shcjrMfOkanIkL3o3PM412/GgDWOQkgrjJHYhYQU9C05+/mzFZJm8n2CsJX8SLFLGlDl30bUFVHH7ASi9BkPAAjHSHzo720gPELLoGuCeg9sVgbKKuwz/au9xAUJuXPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TTm6ir8d; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714071407; x=1745607407;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GyYS//eJdsqAA5UfCzd5uB8wCmszHJBWWtWWa6emUxo=;
  b=TTm6ir8dmKYyXMVLrLtnB1BA/RDmwYYXHduej1Sb/5gGanZGYBZ/VtnF
   dZ3+209YvO/KmUL27zdmqhJKpm2m9TKRBn0bAihQ9OcRpqph2OsOidv2W
   ixRKPPBl1tBy6ZiLtCOc/w/I1/1IqFtQ/51pl+p+r2hBU3BvnEemrh+y8
   jlz6nKFcPmHIFGpdLEN4tzg3vMBGSlcEifetZMl5ngDxZXiDmoeJtmUmv
   f/7m3lKQq2XkXerZwFSMUSEJa2XYXWbLqVWirOhYvIrOEw1Wp36lnlra+
   3Yp6t7lTr/f76QOX+ESug7RhS0JXmz8P31vT6TJzERpuOPWt69C/8bgjj
   g==;
X-CSE-ConnectionGUID: ioMGhpM7TyyeuKxafuHrTA==
X-CSE-MsgGUID: cvCQ6tj8Ru+TJnUBix38pw==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="27239580"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="27239580"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 11:56:47 -0700
X-CSE-ConnectionGUID: lPC2oQ9MTN2RMZAN0mpQyw==
X-CSE-MsgGUID: HdQYBYCPRSOOpuzne7EUOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="25056447"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.252.128.24])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 11:56:47 -0700
Date: Thu, 25 Apr 2024 11:56:44 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v4 6/7] ACPI/NUMA: Add log messages for memory ranges
 found in CEDT
Message-ID: <ZiqnbD0CB9WUL1zu@aschofie-mobl2>
References: <20240424154846.2152750-1-rrichter@amd.com>
 <20240424154846.2152750-7-rrichter@amd.com>
 <6629474eab671_b6e0294e8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ZioGhwNWQyFjRtZ-@rric.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZioGhwNWQyFjRtZ-@rric.localdomain>

On Thu, Apr 25, 2024 at 09:30:15AM +0200, Robert Richter wrote:
> On 24.04.24 10:54:22, Dan Williams wrote:
> > Robert Richter wrote:
> > > Adding a pr_info() when successfully adding a CFMWS memory range.
> > > 
> > > Suggested-by: Alison Schofield <alison.schofield@intel.com>
> > > Signed-off-by: Robert Richter <rrichter@amd.com>
> > > ---
> > >  drivers/acpi/numa/srat.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> > > index e3f26e71637a..c62e4636e472 100644
> > > --- a/drivers/acpi/numa/srat.c
> > > +++ b/drivers/acpi/numa/srat.c
> > > @@ -338,8 +338,11 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> > >  	 * found for any portion of the window to cover the entire
> > >  	 * window.
> > >  	 */
> > > -	if (!numa_fill_memblks(start, end))
> > > +	if (!numa_fill_memblks(start, end)) {
> > > +		pr_info("CEDT: memblk extended [mem %#010Lx-%#010Lx]\n",
> > > +			(unsigned long long) start, (unsigned long long) end - 1);
> > 
> > This looks like pr_debug() material to me.
> 
> This should have the same log level as the message below and/or its
> corresponding SRAT message. CEDT mem blocks wouldn't be reported
> otherwise only because a smaller (overlapping) entry was registered
> before. That is why I used pr_info here.

It does feel like this message belongs but maybe it should also 
mimic the SRAT define message and emit what node maps this range
if memblocks were extended.

But...seems this will emit a message for every CFMWS range, even those
where no memblk needed to be extended - ie the range was fully described
in the SRAT.

Sadly, numa_fill_memblks() return of 'success' has double meaning.
It can mean memblks were extended, or that (start, end) was found fully
described. I don't see an good place to insert the message in
numa_fill_memblks(). 

Sorry, just stirring the pot here, with no clear suggestion on how
to emit info.

> 
> > 
> > >  		return 0;
> > > +	}
> > >  
> > >  	/* No SRAT description. Create a new node. */
> > >  	node = acpi_map_pxm_to_node(*fake_pxm);
> > > @@ -354,8 +357,13 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> > >  		pr_warn("ACPI NUMA: Failed to add memblk for CFMWS node %d [mem %#llx-%#llx]\n",
> > >  			node, start, end);
> > >  	}
> > > +
> > >  	node_set(node, numa_nodes_parsed);
> > >  
> > > +	pr_info("CEDT: Node %u PXM %u [mem %#010Lx-%#010Lx]\n",
> > > +		node, *fake_pxm,
> > > +		(unsigned long long) start, (unsigned long long) end - 1);
> > > +
> > 
> > This makes sense to mirror the SRAT pr_info().
> 
> I evaluated this.
> 

I read Dan's comment as simple acceptance. Like, yeah this one is good
because it mimics the SRAT pr_info.


> SRAT shows this:
> 
> 	pr_info("SRAT: Node %u PXM %u [mem %#010Lx-%#010Lx]%s%s\n",
> 		node, pxm,
> 		(unsigned long long) start, (unsigned long long) end - 1,
> 		hotpluggable ? " hotplug" : "",
> 		ma->flags & ACPI_SRAT_MEM_NON_VOLATILE ? " non-volatile" : "");
> 
> There is no direct mapping of SRAT memory affinity flags (acpi-6.5
> spec, table 5.59) and something in the CFMWS entry (cxl-3.1, table
> 9-22). There is no "hotplug" flag and the "non-volatile" part would be
> ambiguous, as some logic must be defined to handle the "volatile" and
> "persistent" Window Restrictions. Since the CFMWS restrictions are not
> used at all by the kernel my conclusion was to just dropped the flag
> for the CEDT info.
> 
> Note there is a mapping defined for CDAT DSMAS and SRAT entries, see
> CDAT 1.03 spec, Table 4.
> 
> -Robert

