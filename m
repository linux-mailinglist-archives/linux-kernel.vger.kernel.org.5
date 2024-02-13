Return-Path: <linux-kernel+bounces-63415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17136852EF7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C270028145A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FD1364BE;
	Tue, 13 Feb 2024 11:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FzGpoSCc"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A2533CD2
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 11:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707823111; cv=none; b=Hoc8yCK9SQbyYsZ3vSRv9fgTkhKABtO+2zvkoKzokFF41Sxau+1wX+yZw35W4BbZNYpxs6lwAnR2e5BUAvCCrmHl79OLUW2DyU6EwOAzW5xb+++krawTOEpbtMXr18rMzwxUWFM8B14pw6hmJauu/KsDzcwvgfRXHOjJBWJWbyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707823111; c=relaxed/simple;
	bh=pOuycacgZVSd0+Xk2nlR7yGsAnTnGbn6e75fF1Lc+R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnLkQyX9sqiQGCtnPSWecFIzoab3sbmDgnH35zKkayWU4kynC4d/pTu6LK8AII1XRu38+am9mR+W7XQnoE09XH9o67DZrzDEFz/T2KYu8/stMj7ForK4j0URKCqWaWpPNA2QuzheVY2ihnHwq9KzUPMpEEDJSDWsRsBgkDKoCi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FzGpoSCc; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 62C4E40E0192;
	Tue, 13 Feb 2024 11:18:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9FkHX8FMSUfN; Tue, 13 Feb 2024 11:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707823096; bh=mnD0LyfphM+5T3FfKZ8+3uwWUYYqYaWpKyqC6RAcHs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FzGpoSCciCs42AFik0XBwUecSZEj6IDLGvqmWyfIfL0UNbQ3Ml+L+/Y1gpVlPDF5N
	 MSNM2x9qUUbH+xFGo/rukBRDWl6tpqZ1zLe3pOy7j6YSOOAcU7yi3GE2Wf52BXFiuu
	 fGnqO+HLSrY21vKyv+/+n+omu5um5ccj8eEJ/tjiT3kEu1MxfKCFetNVU8aVBmdURn
	 4mti7Zvgutvustdf0qxPKe680RWTEYxpN/FSKCMT7TRRAY5pzVKYDua9iAGUFRLKqO
	 HhiLKY8F6UilArk+G0xM2xBz8Q/IzFeSLhKsEG5D39qdV0yPBDrtdEyrgtJIWgMHBl
	 AKnemHF4tULcjrhuyqiEJuDnVLfIkQMWdF7rYP9D6IcgdfveczFGktroMlrJ1zXEb0
	 7bmh824dndmy+sztiyaCli/Fh0fmL7fj0vg7zM71FgJKSwe0p20C95R5hMuwGlbdXE
	 DguQc2FSXsOZp2Oag4JlbyxBtTFaPNB8PY6cjFt9ER7lC9mzo+GHxdC+hEaTUyrlzM
	 yYnVX4EK36z6zrCWoAuzDZtk0beiOLCOAOPs7n9rKCIFlq5/WzsbqGGe0BzKvi8qiB
	 D6mam0D2c+tPPfdkPNPemmHQTlLgxTfbG45Nteloum50ebADBh60qrdhhaGAs0cxGs
	 uwqBYF7q5IzVJFozHtRemrjM=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4591840E00B2;
	Tue, 13 Feb 2024 11:18:10 +0000 (UTC)
Date: Tue, 13 Feb 2024 12:18:04 +0100
From: Borislav Petkov <bp@alien8.de>
To: kernel test robot <lkp@intel.com>
Cc: Ashish Kalra <ashish.kalra@amd.com>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Michael Roth <michael.roth@amd.com>
Subject: Re: [tip:x86/sev 22/33] drivers/crypto/ccp/sev-dev.c:1672: undefined
 reference to `amd_iommu_snp_disable'
Message-ID: <20240213111804.GAZctP7KibCgW5DVpw@fat_crate.local>
References: <202402130940.IHNXTMSN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202402130940.IHNXTMSN-lkp@intel.com>

On Tue, Feb 13, 2024 at 09:23:56AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
> head:   45ba5b3c0a02949a4da74ead6e11c43e9b88bdca
> commit: f366a8dac1b8fef28a470d4e67b9843ebb8e2a1f [22/33] iommu/amd: Clean up RMP entries for IOMMU pages during SNP shutdown
> config: x86_64-randconfig-072-20240212 (https://download.01.org/0day-ci/archive/20240213/202402130940.IHNXTMSN-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240213/202402130940.IHNXTMSN-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202402130940.IHNXTMSN-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    ld: drivers/crypto/ccp/sev-dev.o: in function `__sev_snp_shutdown_locked':
> >> drivers/crypto/ccp/sev-dev.c:1672: undefined reference to `amd_iommu_snp_disable'

Yeah, I know. This should fix it:

https://lore.kernel.org/r/20240207204721.6189-1-bp@alien8.de

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

