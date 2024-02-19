Return-Path: <linux-kernel+bounces-71970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 843DB85AD37
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24A111F237E8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3002450A98;
	Mon, 19 Feb 2024 20:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BimRrHNC"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D483E470
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 20:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708374772; cv=none; b=ZSCmjlDfuSmAd/bPs8ZwRFSApBkOu1740C5no4CcSiQ4lFGzIMFXTFlZdgBNDKkasBKaZYKmuO2IKeI7mbYlB9ivOwiFE2XaoTKv9eNbBVxmKg3JykBfrDG43qSyF6ksHhAqh1wSBUdEbpShV3UDSsLmQBsuQj6bxVoXPCeYwS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708374772; c=relaxed/simple;
	bh=UC1P/btH7hghle14fLEvqtjjREZN5JWtL/kj1HAV5bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9M6h81u6JYQmZ1BER1ledEGF7eZ+66LWCubv34XfNa5AwimtI1pl73Y6w4FPpb1LAgE0PSQc9bPrft2UYm8QxSUK+SfZHnNpOT5S0c/lFPexeihW/YCZG8YyOSJAaHB9n5T3KmxfcQZ5+G2Gdp2oFlY5tmPIheHjTZnxTI5Ors=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BimRrHNC; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 73A1D40E01A9;
	Mon, 19 Feb 2024 20:32:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gssax9miUJFH; Mon, 19 Feb 2024 20:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1708374763; bh=LYY0q0/KETPrnPX+RX2AjJNvJ7z0hoXsmDLfCgmGPBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BimRrHNCapxjHaMlw10cyARByVbrZEQIL0M7vk/RaZY+lP6DrKoVDc1FOc9f2vz7u
	 NGWZpvVG81NBHG97jf6f3pIyJ9zEksMd1fvWDYOL/IFYb4JFRbhP3QUHdNDcYGYDF0
	 VNEYPjODyxgx+FPzhEKKuol/XsCW73Z8g+d6G2yhblXfK9lAxmnp1QAzxs1OVWy1wb
	 onzmvlQ8+NfU3rGBeUtGA2IhRqMRyYGjyA9uXskygiqve48yhUIhCA7CFEPwNLj7AR
	 mrE+tC8FkGXF35kMNusGkaR4ZdzPzb1PyM8QgSTo3t709poiU7RVkkcBoqBrwmx/Xs
	 Go8RQTNHq8QvhNabvWutwbBY86TlAtwnzeo0wUmXKJpjjuAMQ5uDfuZocI0UIHyfg+
	 gFXy+XESBRCwizzGPdaoUQaaiFiUzFy/4L7nYYmqI9ILfwVc4G3/Q/wR2riapFgflC
	 eCrwVF81+/R/6qDyhn56c6CV1XA1vgTjlNfuFInQ8AWh654WoV5L2CwcEbbi40wbj/
	 B5vsPFug291+T/s8lPPb8LHFsQ+R2ntGalhBn5+My0wXcjV66jraherewExlp++/KQ
	 DxAURxkUkkGogoN/5MBIn2jUn6rJrn+HHyGkBO+LupkYXqXw64TnSP0TMhXM30KVd0
	 n+uIEL3SeVlDsKex7CG5gjUY=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 32B2340E016C;
	Mon, 19 Feb 2024 20:32:28 +0000 (UTC)
Date: Mon, 19 Feb 2024 21:32:22 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: "Huang, Kai" <kai.huang@intel.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, dave.hansen@intel.com,
	kirill.shutemov@linux.intel.com, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com, luto@kernel.org,
	peterz@infradead.org, chao.gao@intel.com, bhe@redhat.com,
	nik.borisov@suse.com, pbonzini@redhat.com
Subject: Re: [PATCH 1/4] x86/coco: Add a new CC attribute to unify cache
 flush during kexec
Message-ID: <20240219203222.GIZdO61ucfq4bFxRT0@fat_crate.local>
References: <cover.1706698706.git.kai.huang@intel.com>
 <cd88e97e53c502f0a457d6a82a31d9e8e0f9fca7.1706698706.git.kai.huang@intel.com>
 <20240219161611.GBZdN-y6DO-cspaZrf@fat_crate.local>
 <9164b0e3-f520-4aab-8b80-520131f0e4db@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9164b0e3-f520-4aab-8b80-520131f0e4db@amd.com>

On Mon, Feb 19, 2024 at 01:45:37PM -0600, Tom Lendacky wrote:
> This change won't return the correct answer. The check needs to remain
> against the sev_status value.

Feel free to explain because this patch is confusing me.

> > So you can't put it before the if - just slap it in both branches. Geez!
> 
> I think that will still work because sme_me_mask and sev_status will both be
> 0 on bare-metal if 'msr & MSR_AMD64_SYSCFG_MEM_ENCRYPT' doesn't evaluate to
> true. However, that will cause any platform that hasn't enabled memory
> encryption (see SYS_CFG MSR), to also perform the WBINVD.

If it keeps the code simpler I don't mind. That's so not a fast path.

> That won't work, because the current system may not have SME active. The
> cases that needs to be caught are kexec'ing from a mem_encrypt=off to a
> mem_encrypt=on or from a mem_encrypt=on to a mem_encrypt=off.

And I'm saying, we should keep it simple and simply WBINVD on SME
capable machines, regardless of the encryption setting.

Any downsides to that which are actually real and noticeable?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

