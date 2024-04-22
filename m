Return-Path: <linux-kernel+bounces-153795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC3B8AD342
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68088B228F3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC67153BF5;
	Mon, 22 Apr 2024 17:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MhODt1fX"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A41153BFE
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 17:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713806480; cv=none; b=nsTZmJDXCIt0qwWZuDAsYT7O3fyc/4FFHxekE3m7wht0m/si8CObNDKdoFPKqDyDlTjuk9XkNAPr9XZd/nY00yHGLNvrStv2NBdX2kiErgmEz9ZNTAVKBAXgpqwGdEUi6yCs+D/CKm94k6Ttx/oOV1hI3Uns/toXXnW/3z/W1UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713806480; c=relaxed/simple;
	bh=AavZtiE7Y5jNJbDH/UEH67bAAXiGlqHLEG6ZnZQvljs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFxjGL/RLtCc1Ej/KTGX6U7Jz8O752Ci2kGGWvBUaw+D7DzTDVdGtfltF+Q4U7SI+mPv+lALe3Z8oiaMilEiEh8dm00GvBOktlUqhNUC8RlJHAlE14cGUJXErkfifaMv2q0cjQxABZq64v/eogxRIahibwp7VKQcBe071P2fIi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MhODt1fX; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EDEFB40E024C;
	Mon, 22 Apr 2024 17:21:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sj62pO-FdWHX; Mon, 22 Apr 2024 17:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1713806471; bh=X8dsCphHnI+xsPA20/Uvl8+GpfgKITkke/sIBay9D1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MhODt1fXLmpag8dMVPz8uw/255+oWmZ08NlTWiUJAbFf06ZhqHSSohc8MUq8OeWFk
	 1UOkv86OR2kEb5mYllvK6XVbMdDhEg35TD4qw9B8Hxr0U49f/m06qVrKllRVwBJmm2
	 hkxCuSxaZ7FpyXSQ67Vx69z+3l456+zCRWa3WaYD6ULAH9rZZyE0ZFl2wUZpshaVAR
	 JWAbiAvGX7AKqBOqtCh9WUfLPWckiDAKKTvycEQzIHt5pPfnwLdTXi96f6poqATLdx
	 kxv5vRdHysZpU+zHO/O6q83Lrtkiw+1Bw3HkAchs6begHxTSlGwhJ6OoVDPCn/VA7f
	 gLFpjpLQ1JD+Cfs4tY8+vFa30VOxUhd28+jy4wkcXyp63pbjDqwDIrHzYrC9xgH0dm
	 X1+HADg5fb5QroKM3xYNcXMknIReNHimiBnCdeu08jzmTxBRNb/dKo/xK+6itOuCSU
	 /6rE+DVFtrxfYJhZb0tld1nIVhqhFkfiDAF68IMDWA/iRrgoyApJy5YV7Gj3Og41QC
	 Go6I1c+pD67gDIKmYfnoRj6yAMPckBoxH+xrx6oaIXFYe0+bvrDZwE0kgNoppDN45q
	 d3geGaRluA2xXuHo6g86X3hrlodFowOuEc8SCUEoM1yr4Cl3I3GXaFX/ADzml1YPBA
	 pu4rJrsO4v5D1QVvAQTMyA4Q=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 18A1840E0240;
	Mon, 22 Apr 2024 17:21:02 +0000 (UTC)
Date: Mon, 22 Apr 2024 19:20:55 +0200
From: Borislav Petkov <bp@alien8.de>
To: Robert Richter <rrichter@amd.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org, jgross@suse.com, tglx@linutronix.de,
	x86@kernel.org, Kim Phillips <kim.phillips@amd.com>,
	Robert Richter <rric@kernel.org>
Subject: Re: [PATCH 2/4] perf/x86/ibs: Use CPUID region helper
Message-ID: <20240422172055.GAZiacdxkQU0XAbybW@fat_crate.local>
References: <20240403153508.7328E749@davehans-spike.ostc.intel.com>
 <20240403153511.75CB9DA0@davehans-spike.ostc.intel.com>
 <20240416151242.GGZh6VaiO2gC4ej2BT@fat_crate.local>
 <f142e9c4-4829-4ace-8757-485246ad3572@intel.com>
 <20240416174850.GEZh66AmnDjrLxoXaw@fat_crate.local>
 <ZiEMnWaHkn99_oyW@rric.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZiEMnWaHkn99_oyW@rric.localdomain>

On Thu, Apr 18, 2024 at 02:05:49PM +0200, Robert Richter wrote:
> There is the X86_FEATURE_IBS bit (Fn8000_0001_ECX, bit 10) which is
> available from the beginning of IBS (all Fam10h production releases,
> revB onwards).
> 
> And right, IBS_CPUID_FEATURES (CPUID Fn8000_001B) was introduced with
> revC. The capabilities of revB are set in IBS_CAPS_DEFAULT.
> 
> It doesn't look broken to me, simply the ibs caps field was introduced
> later which can be determined checking the return code of
> get_cpuid_region_leaf().

Right.

> My preference would be:
> 
> 	[...]
> 	if (!get_cpuid_region_leaf(IBS_CPUID_FEATURES, CPUID_EAX, &caps))

Right, checking get_cpuid_region_leaf() retval should happen.

> 		return IBS_CAPS_DEFAULT;
> 
> 	if (caps & IBS_CAPS_AVAIL)
> 		return caps;
> 
> 	return 0;
> 	[...]
> 
> Not too complex?

I'm wondering should we even support those old things? All revBs should
be probably dead by now. But ok, it's not like it is a lot of code or
so...

> This slightly modifies the functionality so that 0 is return if
> !IBS_CAPS_AVAIL (instead of IBS_CAPS_DEFAULT).

If !IBS_CAPS_AVAIL, then this is revB. But then you want to return
IBS_CAPS_DEFAULT there.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

