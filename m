Return-Path: <linux-kernel+bounces-164039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AA28B778F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8439E1F22077
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7545A172761;
	Tue, 30 Apr 2024 13:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="KBafVTva"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2FA17167F;
	Tue, 30 Apr 2024 13:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714484901; cv=none; b=M4cgHupqXXArWpqWN4LAb4Ax0MIu3xE00uLt0ibiSuddC991uIuslTwqYN1DFRrLtsEZef3ky2WNDZked1GqRJU13BbCYlRVUbheJmwhCHadL+4LVrkqCDV0rO+n00+1qg7+LIfrXImgen1K98ZRn5eqs1YxX9QKxpzNGcKXnaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714484901; c=relaxed/simple;
	bh=8G2dkZsISNPsJnxDPFxSqCHDC2NnCRCxIewWXpeyS3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCKny+gffUkarL3VCegNeckiw6CMYOFwIvXXINHJZNczXSDF7M3MmLCXvIdL/OCxIQnGLFiW2M5a5mj9DvEcqFfnBcjOGX+o1y7+XjeINwc/i1P1i8rbANhppaBu9rXjZdEO8oeyQ4tQWqnfAdNIo7wvxElJQBpoNYTvdd7yA5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=KBafVTva; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 205D840E0187;
	Tue, 30 Apr 2024 13:48:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xECjcqlxMJe3; Tue, 30 Apr 2024 13:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714484893; bh=MasTPhLFk4wvJV4dMMwrd241d1uVUzrMfthE7bDhqs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KBafVTvazS/DYhOcVg3G7qk11+hDp6roSdu4mbuGw6v7Ngnp8p40JyJSJWDHccys6
	 itbO29c7cUIL1JEuh62TxdRk2YFA78dmS4+kFSWQImB1KT9fln2ulB63EX0DVru7tR
	 GmBBmUfjaA+fy8iDqwGqwDtPCuIinwQ1PBNsWEMTl/NSD+bIiGqACrYJGo5RPf+whn
	 Bof/EksTibY7li1o8GcDTltZ0KkWInC8V5X7/9P/El23WD73oEvE4KlZ9MdPmUfnz1
	 fpkYOnEa6OLfMKI5eda35p3796aEtYYV3IsrPA7+gmzMJPrcRmlummRoHWfa3EivKv
	 SzvyRVPRqs5ct2ZFGjeHI6WyyqL5Sww08b5b0mLQKOJlDgcCRObtXstZDgl7OJNVVw
	 EnxNMwy1pjWSSu+nHEPvD7KLxU/G4x7AdAdiX5BZztK8LbYHHz7I+XC0dJ/d45GJHI
	 4T2fhUi1+WKU7BpIsuqxRI501JOt/M9nep+PqnRvEjJtI4fhcj5HAvSDIsgCmmUDI4
	 e2KRujjk7DNWpiPia8Sig1dedl+nUwxMfHuLYbX54p/pRcfN41aFZ1iFB+K6E9RFBn
	 E+Wm3Zv4oKLd0y08jGB0WLLceBLbqs9JRUXpPKHvagwGlUASVJu8cXB+BIONvQOo4T
	 DHSnOUtnxDn3rOX42F34KxA0=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C678B40E016B;
	Tue, 30 Apr 2024 13:48:05 +0000 (UTC)
Date: Tue, 30 Apr 2024 15:47:59 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: robert.richter@amd.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
	Avadhut.Naik@amd.com, John.Allen@amd.com
Subject: Re: [PATCH v2 07/16] x86/mce/amd: Simplify DFR handler setup
Message-ID: <20240430134759.GBZjD2j942leiJGSrQ@fat_crate.local>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-8-yazen.ghannam@amd.com>
 <20240424190658.GHZilYUvw1KfSfVd_e@fat_crate.local>
 <e0d10606-4472-4cde-b55d-34180efad42b@amd.com>
 <20240429125956.GNZi-ZzN1Izxps8ztT@fat_crate.local>
 <d1e329da-6a04-47f7-bdab-ea6c4f584802@amd.com>
 <20240429141244.GGZi-q3NdmI17pai4N@fat_crate.local>
 <891ec639-e557-4dbe-8afa-3317b9c173ce@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <891ec639-e557-4dbe-8afa-3317b9c173ce@amd.com>

On Mon, Apr 29, 2024 at 10:25:02AM -0400, Yazen Ghannam wrote:
> Yep, "MCA init cleanup" is another thing on my TODO list.

Right, so looking at the code, early_identify_cpu()/identify_boot_cpu()
could call a

mca_bsp_init()

or so which does the once, vendor-agnostic setup.

identify_cpu->mcheck_cpu_init()

already does both the BSP and AP per-CPU init.

With such a split, I think we'll have all the proper places to do setup
at the right time without hackery.

> The BSP still completely finishes init before the APs, correct?

Yes.

> I recall some effort to make CPU init more parallel, but I haven't
> been following it.

I think you mean parallel hotplug but that's for the APs only.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

