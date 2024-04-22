Return-Path: <linux-kernel+bounces-154061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 362988AD6BE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E142F1F22307
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865141CD39;
	Mon, 22 Apr 2024 21:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cVg1i8fU"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2F2EAC7
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 21:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713822327; cv=none; b=nklYKUMPSVmho0u8LXr9cecFvc8EDIRdWvVTZEIcXZkNGPw4bnvkDlm4pnkDMDw9EtnI/ZrGOBzMCUaQfrP5zqI/sSn/IFdE0IvZMTvIDtAPHJED3/rNf0ZHPlDhvHQTleWEi1D06cTq7x40xMwM8TX/l57x7kWxeUc1QMrwhtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713822327; c=relaxed/simple;
	bh=ZSuzDg/LcArEYxGCMe11hal700cget9HsaKNgKlcVnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9Kr6SdFCdcMWixcUnQvTeJYQTMHm4f7XCztXQ6OnfsugBPocBpOotlYubjvJikZy8uyegSpjkfAYmhEp2xJxWN3iuQMTEmcDaWDmNioexW7OycB04COlDvU3irtiYn+AYoo97CD2ZFqcgS8U0GwAcKS+gvzDDPVnK5snd8t6Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cVg1i8fU; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1016140E0249;
	Mon, 22 Apr 2024 21:45:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0xwvHYVLWWMn; Mon, 22 Apr 2024 21:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1713822318; bh=17I7heHTc5W4ZEV4cDoEiYI1yXIXX45AaQWVxYzK10c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cVg1i8fU6R82TQasmQg66U8qIvIGH1rLw1DNX/PDuvC8vvUJoj3MjcGvDB7as/vVr
	 6uGhbMpnAXVTtcPNMV0dkCD2K46OkkHTzgcBO/etOgJxdBfO6jC+jLIS7eJ96N72U8
	 NzRI4zea0WyIvPZu0eRNzbA25lnfih+en/V5MxmzNQ7Jk4A65AhqctW4YbkHwlYGUj
	 XPZdKcjPsSr49NlRobPrcCRiUZzo/jvE9lFufq3MACQxHATPZfZ5glVr+YT82+HwLp
	 tMKAB8TdzCd5SoRFXb1rJ8fJCFhsaC+4kZ7l++I6Ao54+FWmw5qtzAoXi/cGBWIc5h
	 ivUH62BTNmmKeJswFkdWh9bn+7BAWS8bFgvAmOWdFFkF4nAzDdT+19ynTyuEj7FEN0
	 KTtLm8GNg2Wrf5tOM0p6b3vTFJCLpXZJ6RF0qx3vEqEduHHThKXLh2i8KXMhb+puDf
	 TrqPgXPsYWPK0K6xpjXUADcmsc7UQVRHb/NFmidlZwDVoCmvigiGyjEIwEzafcJWc/
	 /kJQKE1oYfLZ+ZqY/Yq8jaAVAR2Ebdo59dJ3R+r4VKZl6NXfNKt3qCcmCJxWAGnl6x
	 3bz8vDWsKGUbY5VCwLDwIlrAdOxduRTwBOcL161vdtfgCry24gcw8iBhUjuGnFPQvM
	 DyLk7y+v4WOXltIHmkJ57IyE=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AC3E940E00B2;
	Mon, 22 Apr 2024 21:45:09 +0000 (UTC)
Date: Mon, 22 Apr 2024 23:45:03 +0200
From: Borislav Petkov <bp@alien8.de>
To: Robert Richter <rrichter@amd.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org, jgross@suse.com, tglx@linutronix.de,
	x86@kernel.org, Kim Phillips <kim.phillips@amd.com>,
	Robert Richter <rric@kernel.org>
Subject: Re: [PATCH 2/4] perf/x86/ibs: Use CPUID region helper
Message-ID: <20240422214503.GDZibaX4G2HWQgZuvH@fat_crate.local>
References: <20240403153508.7328E749@davehans-spike.ostc.intel.com>
 <20240403153511.75CB9DA0@davehans-spike.ostc.intel.com>
 <20240416151242.GGZh6VaiO2gC4ej2BT@fat_crate.local>
 <f142e9c4-4829-4ace-8757-485246ad3572@intel.com>
 <20240416174850.GEZh66AmnDjrLxoXaw@fat_crate.local>
 <ZiEMnWaHkn99_oyW@rric.localdomain>
 <20240422172055.GAZiacdxkQU0XAbybW@fat_crate.local>
 <ZibEFZ6DoxDeBxxp@rric.localdomain>
 <20240422204146.GCZibLiqZhbY1J4qFJ@fat_crate.local>
 <ZibW8D9-CTd8G-_v@rric.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZibW8D9-CTd8G-_v@rric.localdomain>

On Mon, Apr 22, 2024 at 11:30:24PM +0200, Robert Richter wrote:
> I mean the case where the cpuid leaf exists but IBS_CAPS_AVAIL is
> clear. That could be possible with some cpuid override e.g. in virt
> envs.

Until there is a valid use case, I don't care.

> Not on real hardware and if future systems not decide to enable IBS
> feature bit and clear IBS_CAPS_AVAIL, which could be a valid case IMO.

Then they get what they ordered and get to keep the pieces.

We don't support every insane configuration virt comes up with.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

