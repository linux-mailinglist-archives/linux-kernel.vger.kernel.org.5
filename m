Return-Path: <linux-kernel+bounces-60711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9E58508C4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F78D1C20926
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 11:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881AA5A4D5;
	Sun, 11 Feb 2024 11:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Yt1AGD0l"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147B75A4C5;
	Sun, 11 Feb 2024 11:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707650116; cv=none; b=jejJGztuM20HUADPxaWlvMbunKrwQS0Q9Oi5U+mnZqSLxPBnKqAbXtr9vC+uRGwbTME7flKXLTNLm7nV6YHYzLvKy/1ApGQoLuHAjjuWUWyyOohNxx4ZKKDT25a2D9ihuBhBVyJ3nJzZr83slaHd2mT8pO1r2WD9hDKmkesSbx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707650116; c=relaxed/simple;
	bh=mYIEtU2PfanaWgJd+AZ0vgHXycLMYk0fVLVCCxRIknI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q71Ao2DR6xArr3Us5QiFhuiBpB/jLWGY8pSliUeeX4KosGIxKAUmXFX2hNWXKKAaCtbh0I/nGcSOgj6WIwJ/gfo0AOlMXm3KlCeqI7wRXqS5cDNS9anXK0BmhxhkN+oRFss6SWDeVEm9AoSDHfW6YE8CMNIBEGJ33unINDhMLYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Yt1AGD0l; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 08AC940E01F7;
	Sun, 11 Feb 2024 11:15:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rUD5dHM3cadi; Sun, 11 Feb 2024 11:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707650109; bh=L952WNaevr3C3E6/nHITfrIqPb7M0nLdrJE6MbmMB+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yt1AGD0lEvjKxTlemTk5GLahKVFpv8J79n88riJI6x2xdIKWyra2ldl7mCmn/BMWD
	 rUWPtibXNGglgF3wSKQuBPY2kcWa7nzpp1Yww2oQEDrTWv6gEgcg+WF05WlNrUq2LZ
	 gIDdbi3ghaaeW5BFsvQ4pSNwzabGNMx6TIuYXDeIPqD70iHPsGIwJnMogDtu8AA4NS
	 qqxa2NlFnmVah6A8w1BJv+vorL+AHl3Kn4l17mw9pb20YsMnr9CuZ2G9piOkMcWYRK
	 KjhUeDzU38SO2jrMOeb0kOtayufUzRjyO06jQ1+bkjqr9e231SWNYDl1RdSlzC1WvX
	 ewzeSg+Y+JfMoC6E4UzS6mlpFzAcJLMIspslZtnCgkGikXqT76AFoJOsU8RKfvwkXi
	 /SXSgD/g8qnLyKF/09I7oZkosdkycPsEGH7az4k48IF9OvRyRJMdboPV+ifWu4Mbuw
	 RMCk5wZpaBju6s1rvjrrdpC4jwqzsHwNlcFUo7Ffo40mDGbUERI+xiEa1JfyHpgaPO
	 WZThzWJAcESmneik5GQvYDjLD/kmFmgg56ihOr/LBZ/fKJIBQpLUoDqft/d76/afCP
	 qfzjsQx3/kgR/kMmas5IMyMIZ2twUiDjQSgYWzWO1Rg4lRrlPqcWLmbZEcL3Jm0VVi
	 Uqee6BIcfvPhhgdqBNoT0kgg=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8698240E01A9;
	Sun, 11 Feb 2024 11:15:01 +0000 (UTC)
Date: Sun, 11 Feb 2024 12:14:55 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Naik, Avadhut" <avadnaik@amd.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
	linux-edac@vger.kernel.org, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, yazen.ghannam@amd.com,
	Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Message-ID: <20240211111455.GAZcisL09LeFPWa2EI@fat_crate.local>
References: <20240207225632.159276-1-avadhut.naik@amd.com>
 <20240207225632.159276-3-avadhut.naik@amd.com>
 <8b4f8ec2-7534-4f77-b44f-6728c699ff64@intel.com>
 <51255499-0b5d-45c6-9c72-f353bae83c0d@amd.com>
 <20240209200920.GFZcaGcOr757W9O3IG@fat_crate.local>
 <7a4945b0-322a-444e-a0ca-860a062a49c3@amd.com>
 <20240209205111.GGZcaQP1gb6C9m0WZB@fat_crate.local>
 <5DB0FF8D-C6DA-45DC-B287-201A9BF48BDA@alien8.de>
 <75ddf61d-8dda-47fa-9da0-24221feb22a2@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <75ddf61d-8dda-47fa-9da0-24221feb22a2@amd.com>

On Sat, Feb 10, 2024 at 03:15:26PM -0600, Naik, Avadhut wrote:
> IIUC, you wouldn't want to extend the pool through late_initcall().
> Instead, you would want for memory to be allocated (on the heap) and
> size of the pool to be set at the very beginning i.e. when the pool
> is created (~2 seconds, according to dmesg timestamps).
> 
> Please correct me if I have understood wrong.

Nah, you got it right. I went, looked and realized that we have to do
this early dance because we have no allocator yet. And we can't move
this gen_pool allocation to later, when we *do* have an allocator
because MCA is up and logging already.

But your extending approach doesn't fly in all cases either:

gen_pool_add->gen_pool_add_virt->gen_pool_add_owner

it grabs the pool->lock spinlock and adds to &pool->chunks while, at the
exact same time, gen_pool_alloc(), in *NMI* context iterates over that
same &pool->chunks in the case we're logging an MCE at exact that same
time when you're extending the buffer.

And Tony already said that in the thread you're quoting:

https://lore.kernel.org/linux-edac/SJ1PR11MB60832922E4D036138FF390FAFCD7A@SJ1PR11MB6083.namprd11.prod.outlook.com/

So no, that doesn't work either.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

