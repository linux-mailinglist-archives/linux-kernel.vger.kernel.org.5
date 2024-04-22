Return-Path: <linux-kernel+bounces-154002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B56178AD5FF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F3C6282047
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B95D1BC41;
	Mon, 22 Apr 2024 20:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="itm6atDQ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC53F1B947
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 20:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713818530; cv=none; b=H5z73baIJAmhzpezlWR2R3NsOKbRpcG0V44dFwLlPerdABTrIXq/yeDOJDoEhuHCR2eq2lV/KaV1oZW029DuaG1c/aZJeI8aUf83GENI33hkV0XqNFJCnZ7hyNhR7DAoFpcBajDJLbJuEy1QkH7mjqrq48xD12fpuk+Z4TdDgXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713818530; c=relaxed/simple;
	bh=51xIj97O9lQ9Y9TaGc9pJwYMYuzv07feAOfehZkC93U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxsSbHE5EMXuZ9AI2pJ0mEp+OTM2miodh4B3uJj3zRrQ8GWvG+NV9NxYOYHfTPDwFHAS/STr7ylaxgf/RNEkKyAGbStMBsc/5F7IHWK58F4OFVikZiPyaVfWMrrbe1clv4W1xQiRcX79OUAl/0C+gCPD/yGI/53KuIrBE/jXPCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=itm6atDQ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 021E040E0240;
	Mon, 22 Apr 2024 20:42:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Ml7F_4ndxso4; Mon, 22 Apr 2024 20:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1713818521; bh=OlkiVCvteYN4pxgphraaSRuyPSDJ4D5rYH0N0OYe2js=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=itm6atDQjc+oW7a6N5Ron8h+aHooV2kdwWEFi8HBx/+i4P3bT3uqGvHMHRFP7PM+m
	 u1Y70F15Dqpuf1C8Y3sOYHclM55/rCpDES7XF2noYyq70s3HpAKQkxNatL4E9iEaRO
	 3yGOYwBr6FbkCeAnPLFkeaPhcAevdvUuNhvR6wVfrlccAPcKantz8EzLh/bS6XOeeH
	 RBSaaOWLjHG76k9nrZIqv8O36ByTz9wPUyQKY2F8ANKLUH5kdYZKjhO9Zi6Todw6uZ
	 /wUHnVFLAtgLN4tKjc+83flYHHwnPxhhkoU8ekZr3JKb2jT3lm+Urt5IlMFlj43k3t
	 2yRGTbn1dbat1yt1ZJS+69LgPTFizYbHvlIou9o/w1tep1cYr9fNJugye4oWgsrXXT
	 7fiSzAZWyXmb7N7Y2WiZ68N7oRB3kWY1t/SZFsjNSLV6qgPm3kS/nzrXeRsAS6Oo4/
	 pPuA5RUf0blCD1gEuSBPmmRSLHyLqAFtFEsmgARvKie62v7/gbsSxzCDDGuxu7c4m9
	 yVJDFzWQv3hwbDTpQWse9+8dCnDUXl02qpQXEAj+TY7NWDllfVRdb5VWGUtdvUXeir
	 12r4CmYerySbiv1bDKSPVTgP6LnrACV83xJtnylYHABI5XqNbkorK+CmGC7JCkrhqG
	 TiZeoRuK2SDt/MbF1aEgk+b0=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DA14640E00B2;
	Mon, 22 Apr 2024 20:41:51 +0000 (UTC)
Date: Mon, 22 Apr 2024 22:41:46 +0200
From: Borislav Petkov <bp@alien8.de>
To: Robert Richter <rrichter@amd.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org, jgross@suse.com, tglx@linutronix.de,
	x86@kernel.org, Kim Phillips <kim.phillips@amd.com>,
	Robert Richter <rric@kernel.org>
Subject: Re: [PATCH 2/4] perf/x86/ibs: Use CPUID region helper
Message-ID: <20240422204146.GCZibLiqZhbY1J4qFJ@fat_crate.local>
References: <20240403153508.7328E749@davehans-spike.ostc.intel.com>
 <20240403153511.75CB9DA0@davehans-spike.ostc.intel.com>
 <20240416151242.GGZh6VaiO2gC4ej2BT@fat_crate.local>
 <f142e9c4-4829-4ace-8757-485246ad3572@intel.com>
 <20240416174850.GEZh66AmnDjrLxoXaw@fat_crate.local>
 <ZiEMnWaHkn99_oyW@rric.localdomain>
 <20240422172055.GAZiacdxkQU0XAbybW@fat_crate.local>
 <ZibEFZ6DoxDeBxxp@rric.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZibEFZ6DoxDeBxxp@rric.localdomain>

On Mon, Apr 22, 2024 at 10:09:57PM +0200, Robert Richter wrote:
> Since we check get_cpuid_region_leaf()'s return code here we know if
> the cpud leaf exists and return IBS_CAPS_DEFAULT if not. That would
> not change the refB behaviour.

Yes.

> Though I think that case is rare or even not existing, I would just
> keep the implementation like that and as it was for for years.

Yes.

> > > This slightly modifies the functionality so that 0 is return if
> > > !IBS_CAPS_AVAIL (instead of IBS_CAPS_DEFAULT).
> > 
> > If !IBS_CAPS_AVAIL, then this is revB. But then you want to return
> > IBS_CAPS_DEFAULT there.
> 
> No, on a rebB get_cpuid_region_leaf() would be false, meaning the
> cpuid leaf is missing, function returns with IBS_CAPS_DEFAULT then.

So what functionality modification do you mean then?

When will IBS_CAPS_AVAIL be not set?

GH BKDG says about that bit:

"IBSFFV. IBS feature flags valid. Revision B = 0. Revision C = 1."

so that has been set ever since on >= revC.

And on revB we'll return IBS_CAPS_DEFAULT which has IBS_CAPS_AVAIL.

IOW, I don't see how we'll return 0 if !IBS_CAPS_AVAIL because latter
doesn't happen practically with that flow.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

