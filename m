Return-Path: <linux-kernel+bounces-168152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AA18BB456
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D741C22C55
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75691158D67;
	Fri,  3 May 2024 19:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="GHrbTJnX"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD5A41C72;
	Fri,  3 May 2024 19:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714765626; cv=none; b=PCZA74cX46TvEu8v+I78PcXFXKMDiwfCmoeeF1gi3/h83f7yaz+/f8ftgKjgkmnr0sB6yXpFjm10XX3kYjzLO5dfeGv3RYO2fXcecS9wxrq2O/XLESa7JfJng8VDSxquzDptohDWWXLg0SV5+2xQoxyXehHRLjMgx8wAWiUAG0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714765626; c=relaxed/simple;
	bh=38Oe0TTS1d5mmNZHF8apJST8m7sFv9qPew/sat94rso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bq/AxCQnbqJj/T0ejdDkXRCwsjeQNkdfgbzIdNt0zWbIzQLNPD0nib7lssLHfUT5T3Dro4PuxewiBU7cw7w/eQpFG0nE3qfIBeTL6iyAoI4MARV8Lm9wOXIAFsNoYdr2u+6x9yBpwUATSNAXS+RKj8dwan9QTG3TlGNH2K4zhtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=GHrbTJnX; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8E13A40E0192;
	Fri,  3 May 2024 19:47:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id oFqlqvI6Q3DU; Fri,  3 May 2024 19:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714765616; bh=yzvLC6+/q4ZSI1AV7yc/hUTsRe1cV21NxgKZRSc1g10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GHrbTJnX3zJTL4ZmrSH8GDrXwkuBC6ZYQPfHWVgyFNuf5eqOWgIRxr+yj9GschRp4
	 ncZf+eUpkGqnkoo053bn3YPf38iDjfeJm8Fr1ufBdd93/wtwYNVdi6Dz6nkPLMxHA2
	 kD3Dw6Cjhj68Rfs2miNW9ZMKYC4kP3ktbdr1+whcdQJI/nnJtibB5vMR7Te7MeVlHD
	 udaP+ymEFbHn9RTpb5H6QmuBgBM4WMFFRcNcO3FaILHTOhQlzv9Pcf+PjnjHb5y69f
	 kHiwnxmKoDCYZarFpUnz3Yahr4I2sxWWIw1RTMCVTgdFVn/QY2LDZibXJ9xRM2fZf6
	 Iq8MBsNbWbvNPtBoyPGGSc1JmkQdRulvtDDcPShqPl1udcHGD4kfMt68Qct6XdzDdE
	 /rfjwqsTac5wl/QjCW2ggPPd3SKWIUTQUsOievCxys12LGfigH3apKV+T0xHs5bOHg
	 4w7Ji1taQYI7Y+Rql4q85tzAOh2uYuz4C6g1eWvPk6Oc5CXpT0fMsjkSHIh4FSKVPZ
	 mwA7J6axFog0Zv6a8ujrsEaKD8AQzD4cRda0Xw622hMf5/XPoDPxIvJuMax9hYafcn
	 Bg5n9OMLYQCHeVc1O2VM4l5yAK3g+ZjIkgRX0UZSF++NsDanLs5iVaBA0cXkifVXOJ
	 gFy/lbRCmlUw7cZdFH3Vga9Q=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0322D40E01F6;
	Fri,  3 May 2024 19:46:38 +0000 (UTC)
Date: Fri, 3 May 2024 21:46:32 +0200
From: Borislav Petkov <bp@alien8.de>
To: Robert Richter <rrichter@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	Derick Marks <derick.w.marks@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v7 1/4] x86/numa: Fix SRAT lookup of CFMWS ranges with
 numa_fill_memblks()
Message-ID: <20240503194632.GBZjU_GOFUNDD-3zkK@fat_crate.local>
References: <20240502131012.2385725-1-rrichter@amd.com>
 <20240502131012.2385725-2-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240502131012.2385725-2-rrichter@amd.com>

On Thu, May 02, 2024 at 03:10:09PM +0200, Robert Richter wrote:
> For configurations that have the kconfig option NUMA_KEEP_MEMINFO
> disabled, numa_fill_memblks() only returns with NUMA_NO_MEMBLK (-1).
> SRAT lookup fails then because an existing SRAT memory range cannot be
> found for a CFMWS address range. This causes the addition of a
> duplicate numa_memblk with a different node id and a subsequent page
> fault and kernel crash during boot.
> 
> Fix this by making numa_fill_memblks() always available regardless of
> NUMA_KEEP_MEMINFO.
> 
> As Dan suggested, the fix is implemented to remove numa_fill_memblks()
> from sparsemem.h and alos using __weak for the function.
> 
> Note that the issue was initially introduced with [1]. But since
> phys_to_target_node() was originally used that returned the valid node
> 0, an additional numa_memblk was not added. Though, the node id was
> wrong too, a message is seen then in the logs:
> 
>  kernel/numa.c:  pr_info_once("Unknown target node for memory at 0x%llx, assuming node 0\n",
> 
> [1] commit fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each
>     CFMWS not in SRAT")
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Link: https://lore.kernel.org/all/66271b0072317_69102944c@dwillia2-xfh.jf.intel.com.notmuch/
> Fixes: 8f1004679987 ("ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window")
> Cc: Derick Marks <derick.w.marks@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  arch/x86/include/asm/sparsemem.h | 2 --
>  arch/x86/mm/numa.c               | 4 ++--
>  drivers/acpi/numa/srat.c         | 5 +++++
>  include/linux/numa.h             | 7 +------
>  4 files changed, 8 insertions(+), 10 deletions(-)

This needs to go through the ACPI tree but because Robert asked and FWIW:

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

