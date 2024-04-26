Return-Path: <linux-kernel+bounces-160139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E72A8B39BB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4101C238C4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB79148821;
	Fri, 26 Apr 2024 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="F4nGAP97"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5042942A99
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714141321; cv=none; b=WPsLIURqWDtDLOUGmb1vqn8qorP0apNH+2E4nvqVkWHAGCHKQSy79Zt74Fzs4M95FyYeWo8WDLV5kCtqw0YWVM7vLD+Bkl1XJphLO7z7hmUa+mn7QmTNHLnl8iLrVCvZJ/x52aAjm6MbWNn69ULO01erlzdj8FkOAWb1mDV9xho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714141321; c=relaxed/simple;
	bh=vDHEzSaszVlCKHMx4cB2NDow9Th6KgxtjK0/CpMgmYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcWR6T2faYViN9mHQ7lWO8hTHhpaTZ/RrxdGM91OfW6+x/2N4RaXuF6xWx5EOPkbINxV/ad6emdMJdl8Jj/4VgFUIiC+KYHglzjT63AbeNhU57rEPw8Lo5Hc0w9egKTDV0IqWu7eFIZijUA1c5JWMAGxGons2iLPYOc/QBmMf7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=F4nGAP97; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A561B40E0247;
	Fri, 26 Apr 2024 14:21:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4nr6ztsoQAeU; Fri, 26 Apr 2024 14:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714141312; bh=S5ZM4B6BQIwAX7AeKzf8qU0S9c3jJ6RtzIBBBo7BmUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F4nGAP97ss/AfZh+ukrQwTcMEJZtdG1sbwaKNitN20yduwb7gHFd0MAWB/POEXh8D
	 nozHf/jAPO67nYwIMAWGnobXVH4I9+cQSDjzocW+9DtmEIH1OnvtBm0hFGPV/leG0X
	 Ce22/yPF/rywQdXZb+wyke3fV0qTBcOd9LnAsuUVudQKKDngFQ9fH/cvs0ttQ4EsJh
	 wYiSzdh+75NsvdEH6Sh2G1HIoa1f6jov65xVjeSykBAJi4beDoKJwk4OR2xiboE+3s
	 uGgCvxWXagN5EM3q1csR1gL8/B8V2JPLXyGrI7z6G0ZHtQhRClB2Ue9DOp2r6wXazH
	 XVZt7T9mHCEYyEjzpAIqYPMvA1/R9QXPHfY4HKZwMaFcr3dOgYEIZJWnlclmdyOd4V
	 wKcNEziLWXGWpZyTYTJyzLLazZduq/dgqssRKUfbYz5WgZRElloS3+w54ACCPqD1cU
	 wNxIOYZ2IC1PX3QwwS7jy3XuiOk82910etfsfYTkkzLPa/fXyqrBgPNk1ThrRiRxkY
	 Fo9lecmpFLaE0M0GHDzFklziwJdgTFEFovOebmwJucq3vUXaGJJBFKgKtsDDgPz4Yc
	 FGPiAzTjFnyRvFE4L7TLOQlmY5vdAa4jBuPkfW5Q1zeRB+NeMCrYzOeYBUYiRYpwuo
	 ZD1iBr1Ua0SrdzHG8FVDY10s=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 42A2140E0177;
	Fri, 26 Apr 2024 14:21:26 +0000 (UTC)
Date: Fri, 26 Apr 2024 16:21:19 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, rafael@kernel.org, peterz@infradead.org,
	adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
	jun.nakajima@intel.com, rick.p.edgecombe@intel.com,
	thomas.lendacky@amd.com, michael.roth@amd.com, seanjc@google.com,
	kai.huang@intel.com, bhe@redhat.com,
	kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] efi/x86: skip efi_arch_mem_reserve() in case of
 kexec.
Message-ID: <20240426142119.GEZiu4X8VPK5He4zH1@fat_crate.local>
References: <cover.1712694667.git.ashish.kalra@amd.com>
 <cover.1713222642.git.ashish.kalra@amd.com>
 <a3032e4b7a5406c26aeb66e9380043c410d07e3d.1713222642.git.ashish.kalra@amd.com>
 <20240424144807.GEZikbp0NjFP5AM_ms@fat_crate.local>
 <16b34494-7e5f-4feb-8a21-58e7b8fa97e2@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <16b34494-7e5f-4feb-8a21-58e7b8fa97e2@amd.com>

On Wed, Apr 24, 2024 at 04:17:09PM -0500, Kalra, Ashish wrote:
> With SNP guest kexec and during nested guest kexec, observe the following
> efi memmap corruption :

Before we delve any deeper here, lemme make sure I understand this
correctly:

* You're in a SNP guest and you're kexec-ing into a new kernel?

or

* You have a plain hypervisor which runs a non-CoCo guest and that guest
is a hypervisor too and it starts a level 2 guest and *in* *that* level
2 guest you kexec a kernel?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

