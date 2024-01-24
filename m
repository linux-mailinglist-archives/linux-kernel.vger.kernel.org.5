Return-Path: <linux-kernel+bounces-37659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FC783B32B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0C91F22DD2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC6D13474B;
	Wed, 24 Jan 2024 20:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="i5sr+awf"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A998B1292FB;
	Wed, 24 Jan 2024 20:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706129174; cv=none; b=TJC+ge+OvEf5fb1lA87jck5msN40Gl3AkSoWxgM4o1QZkx2AV/+qujZcxu3dBtZ7xgL3/WxUJ0GbZOyv2tfDjfnwkAU9o/HYykaCq/VzJcSMKiNzVKH8nCjzjeR/kRRjZgjhS2QrUmmqbn791GFZ1UF7BkjVhNYo/En13WWqg8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706129174; c=relaxed/simple;
	bh=UjE5Q+LBZH41t7c8Tpa+Ancl32cB60/LEnGAn9oBThk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dv787efsy+YMPJbPnbiapJbaq6ARdMTtOCpDMUE3sW6yNtO7/O/IqU+3zxHlD58g13A6Ijq/RQzGUkn1Thn6C7osJr2TMubPguDXK7ZmCW/GXDbMPMCgO63p7vgsUx1NhhfxhpUXReq9gp5iqkfkIhT1YzjI0Ht17l6GBRooZN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=i5sr+awf; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D1D5240E01A9;
	Wed, 24 Jan 2024 20:46:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xGfJNrxjAZhc; Wed, 24 Jan 2024 20:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706129164; bh=YC7sFPFz1dmASFdUOdTPzJWpCkLFetesrJj/fhRpmns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i5sr+awfhPznMKGJvmzG/E2p2uu/4F0X6PyFtEeJ9zcc4KBmWZMUbMWKXon6CXR5D
	 xYUMOOp1SgfhzSEqdyNVAHgQchTqbTOVbWwGPRTREbVwx8pQy4hSChFApM8EVcyUc9
	 L7w1Bm1QHWTcP31OCQMbHzanJ88DHIzZeQtSv9jQMRWr4ssEFEFltANR5Itl6P4Sul
	 dh2+u4zSG7eqGK8GLP/qS1sF6rmrxz0+U6FawlaTY7r5a+4E5fIXgCyHOkd3iLZ2Fa
	 8dVJI9jqg/GGwgsKUkB5gfptGaoKPQZ3BFnJ/GStCi1uGW0degZHIv1uY7DGd8FmV8
	 3OKCNmnJXN5ei+SkLYAr0W20i9ZH6SQdGuMFs6QovkaqMNoJWBrixH7yecMnhaPjRS
	 Uzctbu3oj+PStFAhzzQbhP3a+aqVTCJzBrxUYbwum/Mc7BSptTbPsmAIQGtY0IcX5n
	 CQrr0YqpzQIDbFqAREampgTWUvzbyprCiMZWywVCZALzRZtmtIeTqR5ugU6SsjTezE
	 R1y/L98CPl0/hpE9U5Xas2CdRbqLWDrHR/V3OzJCRokqNHTxD5IwHl2oCGnvP+gflR
	 dtLLpSY0HOL42YQVk80vgX4dQ/H21PirQa2Bg6aEOnbY7QLiQp/W0g7jR806dSg3iV
	 nIAM19oSqQpwk7VcLpormEOk=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 513E840E00C5;
	Wed, 24 Jan 2024 20:45:30 +0000 (UTC)
Date: Wed, 24 Jan 2024 21:45:25 +0100
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
Message-ID: <20240124204525.GIZbF25bekUME2flt0@fat_crate.local>
References: <202401241810.jbd8Ipa1-lkp@intel.com>
 <84128a3c83654493f637b8349153af10d69e2752.1706118776.git.babu.moger@amd.com>
 <39c4501e-4937-49de-b12b-742e6201df6f@intel.com>
 <20240124183153.GFZbFXmTKTLEpwZshW@fat_crate.local>
 <e96df7ac-f0b4-4300-8546-7c1df836dea2@intel.com>
 <20240124191429.GGZbFhldYr3K85H9cg@fat_crate.local>
 <6635c607-cab2-45f4-a0fe-ff4f53b36849@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6635c607-cab2-45f4-a0fe-ff4f53b36849@intel.com>

Hi,

On Wed, Jan 24, 2024 at 12:04:31PM -0800, Reinette Chatre wrote:
> >   54e35eb8611c ("x86/resctrl: Read supported bandwidth sources from CPUID").
> 
> I think a "commit" prefix is required here and below.

Yeah, but if you see a 12-char sha1 followed by a title in (" "), that
is a commit and nothing else, right?

If I say "commit" too it is kinda redundant.

> > Fixes: 92bd5a139033 ("x86/resctrl: Add interface to write mbm_total_bytes_config")
> > Closes: https://lore.kernel.org/oe-kbuild-all/202401241810.jbd8Ipa1-lkp@intel.com/
> > Reported-by: kernel test robot <lkp@intel.com>
> 
> I do not know if this is something tip prefers but the general patch checkers prefer
> that "Reported-by:" is followed by "Closes:".

Good question. Documentation/process/maintainer-tip.rst doesn't clarify
that, lemme send a patch for it and see what my brethren in arms think.
:-)

> This shifts the alignment slightly to no longer match the open parenthesis.

Fixed.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

