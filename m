Return-Path: <linux-kernel+bounces-161538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EABF28B4D6B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 20:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FAE71F213FD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 18:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A53074414;
	Sun, 28 Apr 2024 18:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CJDRk3rb"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50E373534
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 18:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714328855; cv=none; b=d8yd4idZ1sYTPQn6xjtRW1kG84qvCv5CLmVBnSFo2+RNd52gYEA8Jq5AbvYWtMS69tUZLqA4vTkKo55Z/XCOf+2UKiYSp4UmWStfkgjEVpaEHuHVW1ygFBkD3CqBEobHpMZ7KX0yuv11QZiWw6s8bWApujfRe19QlxWZCxpcP+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714328855; c=relaxed/simple;
	bh=5l4qF059Jl+xZK4vczGzOFodQkWmNupernBCDwDVl/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyggzSYwjg3vGmNwqJ2Ln0jkP+GUhtbpWTrX9q7e3DeLxZS8VDEf1LtktaEOsnAl+Xs+1N7CFP+RbkkuYGMnieDAagr87gzfVQOqbncXx6w9eNJpal1rGDq/UkGYUm3thpdq4nKLth0lVUbb45krHw2RI0y+s5k+qTYMZ2k+yZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CJDRk3rb; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D0E1940E0187;
	Sun, 28 Apr 2024 18:27:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jHKaPin2l2oW; Sun, 28 Apr 2024 18:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714328847; bh=8LO+Vbu0GXOa88VCWMTXRnKezCCEZXtnWJGdmYc8JQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CJDRk3rb863RBLi84AgiqtF9j/5FQmQO8m9PxU8fWffYIgxzeHilmsTdUSN4B5Mh4
	 eIQlQalZscgCkLtbm7RKM3u9BuMoBIU+LKBWg/SxY6wEvaAT8j/Z5ptMqcM/S8TfRv
	 cL8Rm5wgDodX53uYuDpfMJpEGcy/e5yT0DN6++5XsALrEQ67aoD5IH09qcWN9ztCUA
	 BYLUNMRawuObmtXv5cri+AtGx7IzBHx6PMJ0gZD5aUUehOp99VdvNAZ73Q/bgR8fsA
	 Yw9TZQvHC034TEIWD5VnjwPh5S/h2tlhI47r5Nx/JmbOLoXu6WHMNJ+yy1zjQISxgT
	 ZXLZwZdin8+rSRZ9DBKdOoEEo5hjyUOwiomIv0dIIgc6uRpju3lMmcPbRD1CQ/fsEk
	 exUXJP0OMPX0yjBdFlsV4FNicfdqwIuk1JHHBIZUOcHkfXRIjL54zBIt74PoD7z81l
	 /ZTjvRI2S9kyKV1jhGvmKsY6JonhRG+oDvlIfzezpyl4m979A6E6tod5llqcqEruV5
	 fCWg3ubwMHKy1P9LLDNrOB00IyD/MYaxjxPrHIonaI/e2sLF/HiPBK9pPm++5x29Fc
	 kjNy40YCN0cq3WYxN/0w8ujFmzYTGR+qC/J3pTYQX4PhezmWlBTsIEop2DD37p7WV7
	 mBA2KAfy3N3hr8uHq1L8vedI=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 936A240E016B;
	Sun, 28 Apr 2024 18:27:15 +0000 (UTC)
Date: Sun, 28 Apr 2024 20:27:14 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Raj, Ashok" <ashok.raj@intel.com>,
	"Si, Bingsong" <sibs@chinatelecom.cn>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v4 29/71] x86/cpu/intel: Switch to new Intel CPU model
 defines
Message-ID: <20240428182714.GGZi6VAr-oBybEOXnO@fat_crate.local>
References: <20240424181245.41141-1-tony.luck@intel.com>
 <20240424181508.41713-1-tony.luck@intel.com>
 <20240425104624.GCZio0gDJABGjzoan1@fat_crate.local>
 <SJ1PR11MB6083654145DEDC921F7E39BAFC172@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083654145DEDC921F7E39BAFC172@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Thu, Apr 25, 2024 at 04:29:37PM +0000, Luck, Tony wrote:
> But since it is only used in one place, I should just do that test inline without
> a helper:
> 
> 	if (c->x86_vfm == spectre_bad_microcodes[i].vfm &&
> 	    c->x86_stepping == spectre_bad_microcodes[i].stepping)
> 		return (c->microcode <= spectre_bad_microcodes[i].microcode);

Right.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

