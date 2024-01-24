Return-Path: <linux-kernel+bounces-36972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAFC83A9AA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9AFD28397D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A768C6310F;
	Wed, 24 Jan 2024 12:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="W3cK2siY"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D5ECA69
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706099142; cv=none; b=UWAqboVUF0ZEgn2TpqJAlH0rWd6Hvz1rD9k7vvrsFuGH+M6RBVRWdHLNA/QAjtO0fiPJgPCQcclJRsH6bxIJUpi0DVsMeyuPiBP6pnvAkIJkcXExWmNupU5QgO+hjp7+lieedVhoax9IhlFkX46+TA0VnKeIp0yIZwigmoxljQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706099142; c=relaxed/simple;
	bh=hdLrqlT1YuQO57T7qv3Fix50b4rRfIshrK2u98Hr52A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgN4tG19blVuP1BHPORdSxlzh194uLA9xo9CtDev13wXs0oNIKZ0xbV38ueiUPIDtrm24pIa97R9xu6lbdP4wQM1iOAQmgtJIs6pP0QInHT21BRjN1Qseea15kCPebUNuTNjVUnrE7cVYN5aSo+MJbgv5ygA5BN2v9exp07vNWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=W3cK2siY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 063E040E00C5;
	Wed, 24 Jan 2024 12:25:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZTaN3fkMc74B; Wed, 24 Jan 2024 12:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706099135; bh=2e7i4QkwJtub1qe+RyKIh7wmtZv9acr9lQcqv94JXdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W3cK2siYsCcLtLESpixiTuZ4JgburWRzY2QBt6ThB9xjl9jG2y/ZcaUBUBKwyyOnT
	 WYcP9Wpy7nBglwuFdp62ZEgDmPEpDqre/58pNI88D1CMAYcYDHQFoWHr2u+rHyA5UR
	 /K15NZTAEhzZ+fgLTmkJJAuK5YI/QpUX/U6gPMVzb9CLnRX/sYb0Oem/kdhUxy8pXU
	 mBF9V2bq+cIecIdbIcgL+ZlH0g9jcomv0uudRgbxxNiIC4SGt/lCIda86WmvYN8wvB
	 uhKJJP34l/+YHCbleXK6hFhmvYNMce3BMhKoIwD5AftOyfmda4pFWtQ1fXS8oXZyji
	 xKIm1Purt0OV4IgAXqaJyVeXSpWn99ugAC6cVlmG0ZiWTgfIi7N3aCgddSePegw1n5
	 03VgcDesVWfqyF+bUs2YueaS3z5Xoe7ie/qMwjMm7l10F4QOsxtubmeEOk5CpqiNRg
	 +RMCY/i51Yf1gcFeSN2bK7hYNBrA0iK5em2MVfheDdrZyuxNYuuKMde4Gl+C46s6pD
	 3JanQVxQXsiQnUnX+eB5wEw6Op/xCc4Nl/NrKsS32P/7ZMlU8kIq6ULgNfXRCVgCy+
	 6P9AXxuQ8hxCIXFVqIR92Kog8BzuXyoHiTBdy2V1pDw+3inFgIbUok8OtGP98J3QxQ
	 9kRZcEEMIHtSwKitnkF42Dao=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A99C740E01AE;
	Wed, 24 Jan 2024 12:25:17 +0000 (UTC)
Date: Wed, 24 Jan 2024 13:25:12 +0100
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
Message-ID: <20240124122512.GUZbEBqH0_5pb19sKr@fat_crate.local>
References: <20240117115752.863482697@linutronix.de>
 <20240117115908.344295552@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240117115908.344295552@linutronix.de>

On Tue, Jan 23, 2024 at 01:53:30PM +0100, Thomas Gleixner wrote:
> +static inline void __cpuid_read(unsigned int leaf, unsigned int subleaf, u32 *regs)
> +{
> +	regs[CPUID_EAX] = leaf;
> +	regs[CPUID_ECX] = subleaf;
> +	__cpuid(regs, regs + 1, regs + 2, regs + 3);

You have defines for the regs - might as well use them:

	__cpuid(regs, regs + CPUID_EBX, regs + CPUID_ECX, regs + CPUID_EDX);

> +}
> +
> +#define cpuid_subleaf(leaf, subleaf, regs) {		\
> +	BUILD_BUG_ON(sizeof(*(regs)) != 16);		\
> +	__cpuid_read(leaf, subleaf, (u32 *)(regs));	\
> +}
> +
> +#define cpuid_leaf(leaf, regs) {			\
> +	BUILD_BUG_ON(sizeof(*(regs)) != 16);		\
> +	__cpuid_read(leaf, 0, (u32 *)(regs));		\
> +}
> +
> +static inline void __cpuid_read_reg(unsigned int leaf, unsigned int subleaf,
> +				    enum cpuid_regs_idx regidx, u32 *reg)
> +{
> +	u32 regs[4];
> +
> +	__cpuid_read(leaf, subleaf, regs);
> +	*reg = regs[regidx];

Why not do

	return regs[regidx];

instead?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

