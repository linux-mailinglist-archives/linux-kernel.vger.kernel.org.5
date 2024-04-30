Return-Path: <linux-kernel+bounces-163952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4FA8B767C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B0BE285AEB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B19F171E72;
	Tue, 30 Apr 2024 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="k0hz+6Yi"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6397D171669
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 12:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714481898; cv=none; b=NlZsJZZMAsJ+uQ6968uRAiL+Hzg+A7TPWn5CjQ1Mzt2sE6kIVRRp6VpL1FH+9mTRiEBzFR6pIEm9bJdK8BREGBHGEb4OIpLkbug7mLcGiv/mdWgFNKvW0B4UzHbxNXEp8x94apyTQT3d6I2mjOeja8TXS28W+3gVVhAMcz/driM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714481898; c=relaxed/simple;
	bh=6u+FWsINnrfSGtCwyNnQlvbx5yJBBCmbil7RE1EkMdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6jTyxc06e6AMDdc3yAbpebAU1+FRFmcs+VCbnbmR6ItZ5aSdxVLJizE0oebqpjL+KEB7lUOjWJnZ3dZK1wqBHR42sErHme0wgjItGsBmcCqo9d6gNMhfUzjBejsHFIcpGZkhnhIIxIco/biIX7IJcFW16vCwcLNuhbfcTO9ym8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=k0hz+6Yi; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BD00D40E00B2;
	Tue, 30 Apr 2024 12:58:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZV3pt-UnzM2i; Tue, 30 Apr 2024 12:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714481890; bh=JIpGJ222f6DlJRq4eDp7EoEORpRjHOTnZ9jXZzNPKUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k0hz+6YiJrTAJEVtCM44lX+k6fS0nhtBTM7sNoVHfqYqDltk9uRgnk05/peANK4Xw
	 DY34QJaWudiQm121U/c2t8W9sEFjrtGuAllZvb9yd6NnZOvydLsGezVRgEZ8WKtd0J
	 AlUwp1g0Vpq9x5deLTXx8qHmrAyEMVQQki1fARM4o3YIuhF4f5RTgZBmkk/h7utIgs
	 ERZvpCAJpzbElAae/y10YkkGASFA94BjvJO2TbYLWwKOtCtsWy3CnZe/uian3x3y63
	 /rLaLb4RnEs0KNL9O/1vJWSbEETl3egE9GeE6s1cncuMM8FAk+Q/8S1b+9fKt8gabi
	 iPQoSYgmOWupQU8E2vUFZTj6ztwyzt6qcC58Gp6nkowShdJRbvLwEGNt+qgufoxC2V
	 BSJ34iFpEpqUkQ5PJf/nCNAVbzs++JNLutcdMVAiA7Mw5wg9P9T4e62l/5sr/nQ7rJ
	 ucRyNe40IPf7uvX55ZYNdyn8DAYJeau5s/qCxKUsc+f0N25+8lPKxZ/vnRWTbd22yQ
	 VdzC5qJ2io5JiDh8EQUR2OORscxfnjDuiQzyRdm4abg8tl/ULDMf5o13YZnYRwBifr
	 22oeZvMnpDmhujKIXyfkN+AXuWCT77avEaGABW3EQqG1WbUIKnCZjlU+nAdu+UqTML
	 sFmaxBKupr32m8kBpVxTKI88=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5CE0740E016B;
	Tue, 30 Apr 2024 12:57:50 +0000 (UTC)
Date: Tue, 30 Apr 2024 14:57:44 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Kai Huang <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv10 05/18] x86/kexec: Keep CR4.MCE set during kexec for
 TDX guest
Message-ID: <20240430125744.GQZjDqyM3k_peEw-bc@fat_crate.local>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-6-kirill.shutemov@linux.intel.com>
 <ZhVPIDDLkjOB96fI@google.com>
 <3q6jv3g4tezybmd667mqxio7ty22akxv7okrznmzx3tju2u4qo@2alzjkbgm2lh>
 <20240428171111.GKZi6DLy_ZwuZsZdFq@fat_crate.local>
 <e35yxpa2xdynm7focg6k4u2bjzojn24bmeaszh2jz52e4szc5f@6mgtrdnkewhe>
 <20240429144454.GHZi-yZkD0boKk5N17@fat_crate.local>
 <yh7wbdce5o35l4nkrkml3jp7tyzvzxwnfji2vmvnvaczsl6gdr@6qnwpw7g76a3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <yh7wbdce5o35l4nkrkml3jp7tyzvzxwnfji2vmvnvaczsl6gdr@6qnwpw7g76a3>

On Mon, Apr 29, 2024 at 06:16:54PM +0300, Kirill A. Shutemov wrote:
> Yes, that's what happens in current upstream.

Let's rewrite that commit message then:

"TDX guests run with MCA enabled (CR4.MCE=1b) from the very start. If
that bit is cleared during CR4 register reprogramming during boot or
kexec flows, a #VE exception will be raised which the guest kernel
cannot handle that early.

Therefore, make sure the CR4.MCE setting is preserved over kexec too and
avoid raising any #VEs."

without that bit about TDX guests might be allowed to clear CR4.MCE
which is only confusing and unnecessary.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

