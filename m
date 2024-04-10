Return-Path: <linux-kernel+bounces-138732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C465E89F9AE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0167A1C27B7A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771DA15EFA9;
	Wed, 10 Apr 2024 14:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XHquOegT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C97E2AF16
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712758518; cv=none; b=FgsOOEYGd8EAP4lTt3Y3XZ6FiB1nWWuZhz1TbTFNbKigIgSIpOf5KjrnRHnqXp8DPPcfRxsbGuAa3CbiTDr28m8fBApccXNkkrPcoS7XKllmaVy93hH2ANUd7l7W9fFzMesYlE2uZZOIONPms0biiVAZxdPzS3AKmX/VLEiGu5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712758518; c=relaxed/simple;
	bh=YGmwSKMaLJXYdjd8+SPkn0UZfYj6CaBYd3GTUCW+d7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rj8ibsM32USWEIew1asNW8qddmmkbdQAPyI8UzLouFFt44pSH8w5Lxnk9vj7Stz63mg/aar956wzfKibp7EJZ//O58e1zUReqLwOLK/Uf/7/kQ5bSIF1nBKY3d977x0ZtK0Rv5WRgq4x79U0cnBC5fz1T09x19YE44BRjQ1Env0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XHquOegT; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712758518; x=1744294518;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YGmwSKMaLJXYdjd8+SPkn0UZfYj6CaBYd3GTUCW+d7Q=;
  b=XHquOegTVmWOze7DYyRGs50jX5RXuD5+Orh1baFwaWso9+Y5anmLoVUz
   SVEGQ1eDN4qgksyUQshhhfDUhVS9ItCv3KC+OXM7yXX/h8AbkYrAtQwu8
   MQyf4UDXwaqB2nViV15wVWAb3EqzfJvpCAfc8Tj4JReT9fMPcNo3vkQ3M
   w9KiHriqb7iem9heRdn8ZXU+G0GOcE9YhYbl5FlGbxPFjakXRZEjwp2Wt
   ofa1Mh9sbH0hWF27h+8MaBIyxhWSW1TeU5KBOdF/a0dyrKQtL6FQi1wwl
   V2H29XZPkNfvfV2ccI8JE01vApSKwcwcR4OWj9GomRJN3IdWXm91Tl1sh
   g==;
X-CSE-ConnectionGUID: JXxIVVDWRju59uSTAGfz8A==
X-CSE-MsgGUID: 4qVafSCORNqBw+8wPGfBhQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19549070"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="19549070"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 07:15:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937095169"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="937095169"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2024 07:15:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id A1355161; Wed, 10 Apr 2024 17:15:11 +0300 (EEST)
Date: Wed, 10 Apr 2024 17:15:11 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Kai Huang <kai.huang@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com, 
	bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, 
	luto@kernel.org, peterz@infradead.org, rick.p.edgecombe@intel.com, 
	thomas.lendacky@amd.com, ashish.kalra@amd.com, chao.gao@intel.com, bhe@redhat.com, 
	nik.borisov@suse.com, pbonzini@redhat.com, seanjc@google.com
Subject: Re: [PATCH v3 2/5] x86/kexec: do unconditional WBINVD for bare-metal
 in relocate_kernel()
Message-ID: <3z5wty36wzsf56hjmxmgkenrauecyutxatbzrxxlf4ukxbghf6@zqkwfjnj5wg7>
References: <cover.1712493366.git.kai.huang@intel.com>
 <5aca124fe0ca1c97bf4a2e925b3905485bf5b255.1712493366.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5aca124fe0ca1c97bf4a2e925b3905485bf5b255.1712493366.git.kai.huang@intel.com>

On Mon, Apr 08, 2024 at 12:44:55AM +1200, Kai Huang wrote:
> Both SME and TDX can leave caches in incoherent state due to memory
> encryption.  During kexec, the caches must be flushed before jumping to
> the second kernel to avoid silent memory corruption to the second kernel.
> 
> During kexec, the WBINVD in stop_this_cpu() flushes caches for all
> remote cpus when they are being stopped.  For SME, the WBINVD in
> relocate_kernel() flushes the cache for the last running cpu (which is
> executing the kexec).
> 
> Similarly, to support kexec for TDX host, after stopping all remote cpus
> with cache flushed, the kernel needs to flush cache for the last running
> cpu.
> 
> Use the existing WBINVD in relocate_kernel() to cover TDX host as well.
> 
> However, instead of sprinkling around vendor-specific checks, just do
> unconditional WBINVD to cover both SME and TDX.  Kexec is not a fast path
> so having one additional WBINVD for platforms w/o SME/TDX is acceptable.
> 
> But only do WBINVD for bare-metal because TDX guests and SEV-ES/SEV-SNP
> guests will get unexpected (and yet unnecessary) #VE which the kernel is
> unable to handle at this stage.
> 
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Dave Young <dyoung@redhat.com>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

