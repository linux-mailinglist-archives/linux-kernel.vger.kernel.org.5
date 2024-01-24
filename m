Return-Path: <linux-kernel+bounces-37804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A7C83B5AB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50BA21F22FC1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2F6136673;
	Wed, 24 Jan 2024 23:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Axu6uOd6"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037E1136665;
	Wed, 24 Jan 2024 23:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706139759; cv=none; b=d9PrO0PMaev9zfr3m3mRf2cGIo558enFRgZFgGTWdCw8YijISj/giScnFLQVf0eiXujCKu0puPxFdm+BtOpE65vk4Ov0ltE7Rqg9Waf4beXuveSsEL3pXRYBsc9SYGOAS8TsJsiDfzs6A9YtqJg3J3SVKVa+zp40LtUtTGbPKSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706139759; c=relaxed/simple;
	bh=BJKGNUgtTG3RZ46dPdXGKbprSG37lr5au4itF+G5jIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4PPkWJ2F+ukWWqfTbZwLvcQK0aoSJzCClwetRRLQ0Ch82tD1Df0IOCptS6X/KUzDQbyO983dleK077hlnCu2vdsxc9mw2tLMn2vlxaxtnjAsSFLIzkqYsvEkm1Z8UJieefrRrMuNLOSYPhltWyxSCVJnwRlBM7wXR3XAlpxHso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Axu6uOd6; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 09A9040E0177;
	Wed, 24 Jan 2024 23:42:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SfBndxK70_zN; Wed, 24 Jan 2024 23:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706139750; bh=33jJJ+8skadgOwQahI/TwxglNGyTrWWjqwph5sZO6KM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Axu6uOd6OgqAYyzp3Ymg3B8f1MU6MMiq6h8L5IdMt7VszfUlouTpQE/uZbrcYz0qy
	 CORiJbVzv2sP8ePw07JUhk6B9CZcTjDMOGutruIFS6sVF/38CqL7sWWq2lDhFRLNa6
	 whSoNDQNjM11qEpscHha5U3U0jFxWQzHdxcxv4v8u506vtyIS3qBA5G5mJg/pOEXyc
	 I3S1lYL9EZl8UWJfr42bkURkTTam5ELcuQjdm2OEEKGGe4ZE4mkxgrkiQAd3rAdAwc
	 /Uu+tDTYD5qqWPlBzq/4LubReuESbxsVYnA1Q6RtYKh5QTCg5jylRSk4ogyY8SXUwB
	 ZmA4UB9n+g4bTVu7og7M13RpFYXtcYNHsE90Cj0a5GcKjGAEi0z2yKkLpk6jcT7vyO
	 x2lG0cxK53sqhbq4jgwbMfY9qtXpwXo61rn3gQgFdCVWLl15CxYlNoK7MIgc3jXUwQ
	 vGevPIjAIUezJo0zUkyaW0AlwuFrTV8WLJNu9wy2TxmjfckfHBrhYDkddWyKpakZad
	 dR6T0B2+WR7suxrTJ95OOipy0022GU65WhzuRWAHG12uTBXOaShl5/DvKNqhXagPel
	 EtJuWaPhaRcy1e+lBgCG7OMpupHW5x3Vm2mPOTFDsekujksIMeavTK8UZh1guv6jc2
	 9h9iJW+3gOUN5SpS3mPln7Lo=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A47AB40E00C5;
	Wed, 24 Jan 2024 23:41:55 +0000 (UTC)
Date: Thu, 25 Jan 2024 00:41:54 +0100
From: Borislav Petkov <bp@alien8.de>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Babu Moger <babu.moger@amd.com>, corbet@lwn.net, fenghua.yu@intel.com,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
	rdunlap@infradead.org, tj@kernel.org, peterz@infradead.org,
	yanjiewtw@gmail.com, kim.phillips@amd.com, lukas.bulwahn@gmail.com,
	seanjc@google.com, jmattson@google.com, leitao@debian.org,
	jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
	kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
	kai.huang@intel.com, kan.liang@linux.intel.com,
	daniel.sneddon@linux.intel.com, pbonzini@redhat.com,
	sandipan.das@amd.com, ilpo.jarvinen@linux.intel.com,
	peternewman@google.com, maciej.wieczor-retman@intel.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	eranian@google.com
Subject: Re: [PATCH] x86/resctrl: Fix unneeded variable warning reported by
 kernel test robot
Message-ID: <20240124234154.GMZbGgQi1PnDe8GrQh@fat_crate.local>
References: <39c4501e-4937-49de-b12b-742e6201df6f@intel.com>
 <20240124183153.GFZbFXmTKTLEpwZshW@fat_crate.local>
 <e96df7ac-f0b4-4300-8546-7c1df836dea2@intel.com>
 <20240124191429.GGZbFhldYr3K85H9cg@fat_crate.local>
 <6635c607-cab2-45f4-a0fe-ff4f53b36849@intel.com>
 <20240124204525.GIZbF25bekUME2flt0@fat_crate.local>
 <7d6e3d39-ce53-40e4-bba5-242911a1522a@intel.com>
 <20240124224657.GKZbGTYTjN2m8VirbF@fat_crate.local>
 <abf569d6-9634-424f-97b3-a71716b3cde5@intel.com>
 <20240124233424.GLZbGegG_5eUaGBOlz@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240124233424.GLZbGegG_5eUaGBOlz@fat_crate.local>

On Thu, Jan 25, 2024 at 12:34:24AM +0100, Borislav Petkov wrote:
> On Wed, Jan 24, 2024 at 03:03:15PM -0800, Reinette Chatre wrote:
> > Since you are the one that decides the rules for inclusion you can make this
> > check to be one where checkpatch.pl can be ignored. No objection from me if
> > you choose to do so (and I will note the precedent for future patches).
> 
> Nah, that's not nearly as important for you to change your workflow.
> 
> What I'd suggest, though, is to sanity-check what checkpatch suggests and
> ask yourself whether it always makes sense.

Dammit, there's a reason I don't use this abomination:

$ cat /tmp/0001-x86-resctrl-Remove-redundant-variable-in-mbm_config_.patch | ./scripts/checkpatch.pl

WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#9: 
      commit 54e35eb8611c ("x86/resctrl: Read supported bandwidth sources from CPUID").


WTF?!

I have a line underneath which is even one char longer:

"  commit 92bd5a139033 ("x86/resctrl: Add interface to write mbm_total_bytes_config")"

but it doesn't complain about it.

What a bunch of crap.

I'm writing it as a maximally readable commit message and that's it.
Human-readable beats any script, any day of the week.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

