Return-Path: <linux-kernel+bounces-57722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED3984DCBB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 510C21C2307D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C968D6BFB8;
	Thu,  8 Feb 2024 09:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="19wkwW+6"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734FC6F53E;
	Thu,  8 Feb 2024 09:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384072; cv=none; b=VM4qDwqRhCrEstw42OHE7fH/YcrJgp8937gHhSrp2+Am6lC8ThrJjeKHwTN97NrW1z17D953UrR2ZbJ9BC1m7+q3lNa1asExGzZLsshzwu6cSYpJsQFtxgJ4W0SKZxarTMaoyjHoWxjdK7TKiRv0NVn8WFPFUegyxdMQcJ211g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384072; c=relaxed/simple;
	bh=7Osbsv9Uu5LnSEkPrNLL6eFwAd2oq5PdQu+OGCPcDYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxydNMVldUl5H57RHvQuJBTDDViP9TMslvqe9jpckIWDtSwj79yqMkAMFh97WRNA/jfRpHY8WGvWD2E4I6VgWly0g07vzPgVw1lTJi+1JUj83SnGAOHgQ5CtK5qIz8E3TqnM+96YLBuCpGJkO4WkLMh/XRlfwh/WwOSe+s/WWA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=19wkwW+6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vb5dORbqze0SdpTtcMmBFKm/vy+xDGZxBk1OHiDwRbc=; b=19wkwW+6sREDBf78amIq92Zl1u
	e0eDGWzYrrGtPBT4FJQqeLmWlR6shetElr7ZzQCoLltdJmNRw0G4p65NnJYLS2gWYBIG3kvGV6Zb2
	CFEwQkt7+rau4DEIzj3JN+cbQOW5aH8P3W3GtuwGs6bHnQB31qUBihTOi6hWKSukGnetdMu40rso5
	BCwYq62lFyF5fRzDyTdtThxAyJqGAZ+uC+eAisSBHqM5Hv8wSPjV0s8VV1W9GYxawEocCSD9GXL7k
	LRqcTe00XNGg5NXGm9EvurzWQCwplVd2IY/XPRawXuE4h+SXY2uu9DVLxciVr7wpLRW6YklafcQwd
	HHZQ/DXg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38480)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rY0ad-00048s-1h;
	Thu, 08 Feb 2024 09:21:03 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rY0aX-0005QB-5C; Thu, 08 Feb 2024 09:20:57 +0000
Date: Thu, 8 Feb 2024 09:20:57 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Zev Weiss <zev@bewilderbeest.net>
Cc: linux-parisc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Helge Deller <deller@gmx.de>, Florent Revest <revest@chromium.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yang Shi <yang@os.amperecomputing.com>,
	Stefan Roesch <shr@devkernel.io>, Oleg Nesterov <oleg@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>, openbmc@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Sam James <sam@gentoo.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/2] ARM: prctl: Reject PR_SET_MDWE where not supported
Message-ID: <ZcSc+ftxHY8RyinQ@shell.armlinux.org.uk>
References: <20240208012620.32604-4-zev@bewilderbeest.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208012620.32604-4-zev@bewilderbeest.net>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

Where is patch 1 of this series? It doesn't seem to have been Cc'd to
linux-arm-kernel. Therefore, this can't be reviewed.

Thanks.

On Wed, Feb 07, 2024 at 05:26:18PM -0800, Zev Weiss wrote:
> Hello,
> 
> I noticed after a recent kernel update that my ARM926 system started
> segfaulting on any execve() after calling prctl(PR_SET_MDWE).  After
> some investigation it appears that ARMv5 is incapable of providing the
> appropriate protections for MDWE, since any readable memory is also
> implicitly executable.
> 
> (Note that I'm not an expert in either ARM arch details or the mm
> subsystem, so please bear with me if I've botched something in the
> above analysis.)
> 
> The prctl_set_mdwe() function already had some special-case logic
> added disabling it on PARISC (commit 793838138c15, "prctl: Disable
> prctl(PR_SET_MDWE) on parisc"); this patch series (1) generalizes that
> check to use an arch_*() function, and (2) adds a corresponding
> override for ARM to disable MDWE on pre-ARMv6 CPUs.
> 
> With the series applied, prctl(PR_SET_MDWE) is rejected on ARMv5 and
> subsequent execve() calls (as well as mmap(PROT_READ|PROT_WRITE)) can
> succeed instead of unconditionally failing; on ARMv6 the prctl works
> as it did previously.
> 
> Since this was effectively a userspace-breaking change in v6.3 (with
> newer MDWE-aware userspace on older pre-MDWE kernels the prctl would
> simply fail safely) I've CCed -stable for v6.3+, though since the
> patches depend on the PARISC one above it will only apply cleanly on
> the linux-6.6.y and linux-6.7.y branches, since at least at time of
> writing the 6.3 through 6.5 branches don't have that patch backported
> (due to further missing dependencies [0]).
> 
> 
> Thanks,
> Zev
> 
> [0] https://lore.kernel.org/all/2023112456-linked-nape-bf19@gregkh/
> 
> Zev Weiss (2):
>   prctl: Generalize PR_SET_MDWE support check to be per-arch
>   ARM: prctl: Reject PR_SET_MDWE on pre-ARMv6
> 
>  arch/arm/include/asm/mman.h    | 14 ++++++++++++++
>  arch/parisc/include/asm/mman.h | 14 ++++++++++++++
>  include/linux/mman.h           |  8 ++++++++
>  kernel/sys.c                   |  7 +++++--
>  4 files changed, 41 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/include/asm/mman.h
>  create mode 100644 arch/parisc/include/asm/mman.h
> 
> -- 
> 2.43.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

