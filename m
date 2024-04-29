Return-Path: <linux-kernel+bounces-162425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 655B68B5B05
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65F831C20ED6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493F977F10;
	Mon, 29 Apr 2024 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YcUNS3Iq"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F849468;
	Mon, 29 Apr 2024 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714399985; cv=none; b=Tve5/F7aP6rrnKVc3h+1t47wMEVRueUuPlJ79CHcvgy6eCbYIQ5XzLYjjQa57ROryMEPa8QgnULhA9prOQ60EpTiEELbhBCJtVLJ579h4LN3f9a55FpINeVm+DdiBb5bMVJeqDLInPZIBuuTtYCoQp9sKdPH2JzgginDiZ8y94U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714399985; c=relaxed/simple;
	bh=3gAkZO77w6Vg/FEj8UDrJXdxtegquGNjwt6XnnvslHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9CfZk/YMsoOZkKM0ZmHnIXlo++0HwhLUq/p5lk3vXILc89V0opFIPvj40LwYK8Iv2lQjcP6XqKTHaj+soeiwSGuQSdVIq3fcsrm3UVnOrZlYqkt0BBRphCUhHw9r8w1dP0rwAN8SIWHDt9q6uifustlXDvromKecRoormRlr7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YcUNS3Iq; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9263C40E0187;
	Mon, 29 Apr 2024 14:13:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BnmjDi5cs7Hs; Mon, 29 Apr 2024 14:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714399977; bh=oE13an3Sp1ZiL8L+oexSnFWbk2LomH2Gdl8IFWAPmBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YcUNS3IqG3cdvTCOxDmGgWIHR4cqdTpT1EMz/hhxhrAtUIroLJN6O5oOM/P+81bQX
	 PiZ3Txn0Zd6S1auEhZwouMkK0TJo4C/Xm6YUhdWt79m3rgJd1mkiRPNOn4tmA4ebqv
	 eC8REkxxV8dSmk4CnNps/FHnRwl3qWl3a1+zhpHsQzr86PcQ/Eqid1G8Gu7NrHvfW2
	 sF0ib0TZaCAltoXUULIXWSIqvU7045bR2nKrnjvuA86ffxpzhQ/atUYILCpcQxZh9g
	 eo01CuXplF3hMPmAZppm06XFP4esrw7SJRFwmMpbI0HpOWT6sqXlhJnKJtPiWZEKks
	 1b0wJYAm1g6x1gOS8nNkgBZo2+KG9j9iJIGyPbapIF1+/vrPvw6prD82q1xlj1/dEq
	 XCTiYl0PUaGWbaTrYe9GMelYVstUQXKzh6TeDgAoS5T4Xdq3ko8yJtlxDQ9PzZOBwB
	 zaIEmdDbpD3HzFO+cK0LH3isfShMuvewJ1MeMOjIxWLoSJS9lUuAadpfXTBtOcER0I
	 rZAclthPHh/xurXgnmRqTm/a7IL4O/VppU+lUIYEX1TZrEHZKpTodOFYGSV4F8FODt
	 DohmsijoYWhzat0KupGj7+jZwOnyz0cpEOJy8Fld54BFT0lC7hfykCbRdZPCN73EwB
	 DSYP+P1gX9dQd4V7VIj5Edkc=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 66DC240E016B;
	Mon, 29 Apr 2024 14:12:49 +0000 (UTC)
Date: Mon, 29 Apr 2024 16:12:44 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: robert.richter@amd.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
	Avadhut.Naik@amd.com, John.Allen@amd.com
Subject: Re: [PATCH v2 07/16] x86/mce/amd: Simplify DFR handler setup
Message-ID: <20240429141244.GGZi-q3NdmI17pai4N@fat_crate.local>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-8-yazen.ghannam@amd.com>
 <20240424190658.GHZilYUvw1KfSfVd_e@fat_crate.local>
 <e0d10606-4472-4cde-b55d-34180efad42b@amd.com>
 <20240429125956.GNZi-ZzN1Izxps8ztT@fat_crate.local>
 <d1e329da-6a04-47f7-bdab-ea6c4f584802@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d1e329da-6a04-47f7-bdab-ea6c4f584802@amd.com>

On Mon, Apr 29, 2024 at 09:56:56AM -0400, Yazen Ghannam wrote:
> Right, I mean we should do things the simpler way unless there's a real issue
> to address.

You need to pay attention to past issues before you go, simplify it and
break it again.

> I'm not opposed to this, but I don't understand what is at risk.
> 
> Is it that the function pointer may not be written atomically? So even if we
> write it again with the same value, a concurrent interrupt on another core may
> see a partially updated (corrupt) pointer?

Yes, it won't happen, they say as it is guaranteed by the
architecture. But I've heard those "promises".

> intel_init_cmci() does not do this check. So is it more at risk, or is the AMD
> code just more cautious?
> 
> Again I'm not against the current code. I just think we should simplify it, if
> possible.

So in looking at the INTR_CFG MSR, I think we should do a function which
does MCA init stuff only on the BSP exactly for things like that.

There you can set the interrupt handler pointer, the INTR_CFG MSR and so
on. And we don't have such function and I've needed a function like that
in the past.

And just for the general goal of not doing ugly code which should run
only once but is run per-CPU just because our infrastructure doesn't
allow it.

Wanna give that a try?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

