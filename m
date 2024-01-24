Return-Path: <linux-kernel+bounces-37622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A93383B2B1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7A11C22E2A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F57133428;
	Wed, 24 Jan 2024 20:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gx+AhE70"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318797C091
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 20:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706126558; cv=none; b=dRH3aoPM7fnrjk+c3HEKG+1fXpiRozI8TYKpkteWaG/ts1YTMCFdMaML5pM19uo5UkTc1XVZzNmtrVZ1+cppXfxLshXRt+bPU4A/o+tX213YgpAjIFE9J9cq8eOMscX7T2JsQNYQhDDKvbbcE6gK50Uoek5vITSHRdggBpUaLWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706126558; c=relaxed/simple;
	bh=jTPaQoWtGEcd7Oo6zZIipCUXmUKB5V0hAm7D2saM/7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGU8FD8mpQZGBdjooRK1nA+MGOD3NX39bTdu9N8Uf51OuTlVTx0fEyyopq/KPglRnACS+Vv189yyhC+xLAeDRozKX4inRj5lXzfaaP29ydMxQZ/brjdqqcEEEgfGoF4/7l5oAFrS0ICNgwlVWqyDKf0AfElPxgBj4uls6BQl3KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gx+AhE70; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6470C40E00C5;
	Wed, 24 Jan 2024 20:02:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GAW0QID3evmb; Wed, 24 Jan 2024 20:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706126551; bh=RuqA/hiDlGH+hxSp2YKGEnzorWdSjH2aYOcNAjuwMOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gx+AhE70fLYufEdbnnLdDdMJDyqB7tFQ7PMXz7wGKavgPzWH5jmforuNzv2gQ4B4N
	 jOovoZRK+3W6+3ZQv0AWRz95lC7QuaE8qximILOP6L3XQT/hATgfSM2P7HVDyHSZ2v
	 am+yjZW6qYqa8ge+BA3HYHE4KDMEXoI3lN68dU1JtP9ErQbTX73lZsbHvpgKp2yh/w
	 NX5n9q+kWEwANbHi+j8uYtP3zC14b80Ej6Ejiub7WeMAvea/9OvtJbr9zSDS87sosF
	 TjtfnRdYQ1IIAR/f0ynIdtxvL3/5FXdMF1WUuxAdSKOFnkvVhg99NtX9PmlUmg4kv8
	 SYoIYpBnlLHO3SXXVQpOah8ByiKYKTIMtNOjEmwn5t2WI7+NkTYxEJGDmlj1oGuNcj
	 h8M7IxxR6qa4Dsak+zLRm7Ms9XayH+W4tBmAt49XtNmWbbOh4/qYjKwRdxMsIj4UT6
	 txWxGk7IIRZ2YYS1aziiS0Uas0TojBPmjiQx2iwICEpenoJMvcY3Ezp2kSTxmqjS3A
	 ArXSOILRb4HHvGkh0tnGToyaUMBXf+3MhnLXDybwE5cP90mKvCfPzFchBKxgiCVXlJ
	 g2i2V+cO8+zptHOEaLcoUA4lwceoI0M2qGCbD6o2fNNhpy8B+END/OY87MBTALm6tY
	 KAq1vCvtnRx+Wnh75R38yQ4w=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B273740E0177;
	Wed, 24 Jan 2024 20:02:12 +0000 (UTC)
Date: Wed, 24 Jan 2024 21:02:07 +0100
From: Borislav Petkov <bp@alien8.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Feng Tang <feng.tang@intel.com>,
	Andy Shevchenko <andy@infradead.org>,
	Michael Kelley <mhklinux@outlook.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch v5 01/19] x86/cpu: Provide cpuid_read() et al.
Message-ID: <20240124200207.GHZbFsv-XjMRGfp19b@fat_crate.local>
References: <20240117115752.863482697@linutronix.de>
 <20240117115908.344295552@linutronix.de>
 <20240124122512.GUZbEBqH0_5pb19sKr@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240124122512.GUZbEBqH0_5pb19sKr@fat_crate.local>

On Wed, Jan 24, 2024 at 01:25:12PM +0100, Borislav Petkov wrote:
> > +static inline void __cpuid_read_reg(unsigned int leaf, unsigned int subleaf,
> > +				    enum cpuid_regs_idx regidx, u32 *reg)
> > +{
> > +	u32 regs[4];
> > +
> > +	__cpuid_read(leaf, subleaf, regs);
> > +	*reg = regs[regidx];
> 
> Why not do
> 
> 	return regs[regidx];
> 
> instead?

Or do you really want to be able to use anonymous structs with bitfields
in them and then convert them to a u32 * when passing in to
cpuid_leaf_reg() etc in order to save yourself all the masking and
shifting and read out the bitfields directly?

I'm looking at the parse_topology() use case.

Looks like it...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

