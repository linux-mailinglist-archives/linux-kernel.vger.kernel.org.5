Return-Path: <linux-kernel+bounces-62470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1E785214D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F16D0B22A72
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D0E4CE18;
	Mon, 12 Feb 2024 22:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ROtNTCb/"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1314C627;
	Mon, 12 Feb 2024 22:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707776374; cv=none; b=EA0Ui12kQhsR81rH8hjXinqmdgwa7qtFhbFBkPUFNLEJduR0zQh+nOtOlTF9V2XHCzqpC0Iv6GdumzK6hJr95EUqvROZ2o0EjQMVmAGsAN2muOSKt5hT74v5gwcMCQ61Ma2N6O3WkbDhYWgPlMz1D6mIE9XiKuDvuXTFLw17HmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707776374; c=relaxed/simple;
	bh=TOV0VPbgYhVuGs3WaQo1Bs/dFoe+twoUgMCmPmx1f3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jT3CjySiFrsU8oOa3esJRNJMeWTRMNp2EPN3da8gClRaWtSNd/j1TNMmYhrdctpFNNftyrk3P7NfOB4lnzi7JgUG33A62Ouiong5o9tDfCYEWMmhdhXc/NBG5t0A/vqTCZ1I880GrHiQdbJX4jUfQpY/OqXHwJrb5TTdEvrDVq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ROtNTCb/; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 319F240E01A9;
	Mon, 12 Feb 2024 22:19:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id U-nMxRo4Sa1P; Mon, 12 Feb 2024 22:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707776368; bh=aGQuQtLo2pIRz9eissMy1rrrA1/OASmalUGzgXffMq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ROtNTCb/mLSODiJ9SqAKHNYqCmEH0YrHfjR//4RqPvJ3M+I2IhOj/HAnCT+CiJaQf
	 b44LBGNltF7swU2gX8mKFZRKmAFrelSevAG//YdwzMU9O0YPx3AQUZF8pBMamJzUS9
	 FtamvwtRU5I9LGFxp/j+z0jIqgf06MfXECDix0fDFU6WXohD+Wdm9qytyKDV3fRimM
	 /7q81GZTWqYGQN4Vr+jGYBLU/wp0WWNAyWulDqLMHX+lke+n8HtAFEAreW6zCf9JVG
	 96nl13X6XwaYH4A+p2TCn0sEYbudyFsAP5zTucclwB09F9NgEfZ+S/oe0yafv/PTgd
	 YkXwAWxiUSZu3JiFGP2dPAvPERk5Y7uB7YY9yt7xXO5LF5op+3vP1imGGABLwaxj4h
	 bC6X9VOkXiNzAOuRrFR+Zb0zGXr0CrgLh9ZxSotYoVYfzNXVq8Hew3NOYr8UVsnjOE
	 F+9ffLn71s0H+A1Q0gqSQfX9MBtbAtJQmkmgiB9z+fn/fK3oLqy6fAszgwPHl97fcP
	 3sXASAoRLv7c0DY1/pssp+ayYCFSEJxYScpk88B/URoJghUVlQ1qxAj4Tu65iKLrG4
	 9+3ujZKtA47ZSD0PCU8QnK5//Xkh+dMXYqCQxd7ZmDXmFN5TJ9t9+D5P9hy37/xMNT
	 CYseFqLTLWhiLWxZM/hJDPG0=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F3C8140E0196;
	Mon, 12 Feb 2024 22:19:19 +0000 (UTC)
Date: Mon, 12 Feb 2024 23:19:13 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tony Luck <tony.luck@intel.com>
Cc: "Naik, Avadhut" <avadnaik@amd.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
	Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Message-ID: <20240212221913.GRZcqZYRd6EPTTnN97@fat_crate.local>
References: <774e7ca5-154d-4ca4-bc4c-2f945c20b938@amd.com>
 <20240212085801.GAZcndma4UTPtKm33e@fat_crate.local>
 <20240212093246.GBZcnlvkPKDC8C7rv5@fat_crate.local>
 <SJ1PR11MB6083B3511D18787BE823AB2CFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212175408.GIZcpbQHVjEtwRKLS-@fat_crate.local>
 <SJ1PR11MB60830AF35FA89C7869B8C11EFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212191401.GLZcpt-XHFqPg3cDw-@fat_crate.local>
 <SJ1PR11MB6083C60D7584B02E9CAF19D5FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZcqPhVO_DtD2x5N7@agluck-desk3>
 <20240212220833.GQZcqW4WxKH34i-oBR@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240212220833.GQZcqW4WxKH34i-oBR@fat_crate.local>

On Mon, Feb 12, 2024 at 11:08:33PM +0100, Borislav Petkov wrote:
> I'll have to dig into my archives tomorrow, on a clear head...

So I checked out 648ed94038c030245a06e4be59744fd5cdc18c40 which is
4.2-something.

And even back then, mcheck_cpu_init() gets called *after* mm_init()
which already initializes the allocators. So why did we allocate that
buffer statically?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

