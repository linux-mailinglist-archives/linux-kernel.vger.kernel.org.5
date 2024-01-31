Return-Path: <linux-kernel+bounces-45853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE11B843712
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B50D289EB7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231D23E49C;
	Wed, 31 Jan 2024 07:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="T5g/Z/H6"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFBE4E1C7;
	Wed, 31 Jan 2024 07:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706684614; cv=none; b=l67TZkDWxFIjuroKS9u9kfbxX8oWdnAGn6Gqx95WSRiMnIdX7K14dLuZ+xtiMnNG/6jPYdo1iKpexRcEYcYaQmNKXrnBchirAX6ThdCAwAvLZ/9KYSgWn650R7vuIprBXWtyYswYzpIP6qA+kIUNQQL0CKki6fLe7hP7OT0Ij90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706684614; c=relaxed/simple;
	bh=5itVcZvJGL/hDqK27tMy8SfbPP90T+bCnU7FBMbyvXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYZgXxJdTWZIbEyKy2t0c8Y5LhdAYKXH3E63yC0H8HiIp7UiNbpkTqACLOnXndxROIF6iFtFCS2BKRoaIfAD0iiAO1rNclaaK528nbNqE/gEfiOeT4y+j1tay0LoxzOQOYDEjWeo1xKkB0bilNt7B3yp8wiIP7G7hNNATMZfmuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=T5g/Z/H6; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3014140E01B0;
	Wed, 31 Jan 2024 07:03:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Ib3tZYV1kXao; Wed, 31 Jan 2024 07:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706684601; bh=y1ZSshQgQ9DfksLhtLrUmW9w879xcK84syg8TCitOBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T5g/Z/H65Hn/vMu8N7w7lLAoaWQ6/dyzNc2qaWh1LxPuQWma6iXnbEfVZoAA/luVv
	 GlBSmZtelrWQEdxZffKucvpiQLVufGKT/gq35OHqXm5pySsAaz/5JKI0WuogH/T1dd
	 fUUasjzreZr8ikYUCsi+UhVzy4bAFcp72SaNDXtIfX3LCsfjZSjOwXid8LEGQ0yIIy
	 4I5sm2kX2S4IoFLYJmgxskYJuZmYhnUaRqYdJRoZsVa+69lq0opmx1d9OsWHAd2Gdm
	 l8zYFIPZQZhEwR1sIN/oPHbiQzoEQ9agncL20Ey+0RZlOtpjJeIK6VSa1AJ22DuQek
	 kVs5H7gGMFFYC/dh6qiC/c4XbV8sJYf9uUXR0V/KnleqpcmyiWqwjd4fF57hI0Xsx3
	 0Z7/Fj1hveWHGVifQn/Na1WkHgN4L1N2pcqjY80YcGSta9zEuqKATv0UaeG2XRGUZL
	 MwLs1fzbM0dG9eYB798gjzt0xOwGJ5k20S4dN2KVoolkToWw04iQKUGURzH+4Ky33N
	 mTSb6t5IXVypD/VmV4a1yzlWRWq32B+I4sf7Lwl3o8tjA9v8o5PapqAJ0TQQHhPZFG
	 rfWunHOIPA0Y8fb8bzvcpKX0YtmP3KbBTZpZCAShB7SdJHwCnuv0G7B8/pr4EaA51u
	 WiCh81Y+Z0tdNtavLAq5yiY8=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AE21B40E016C;
	Wed, 31 Jan 2024 07:03:05 +0000 (UTC)
Date: Wed, 31 Jan 2024 08:02:58 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	wangkefeng.wang@huawei.com,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-mm@kvack.org, Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH -next v4 2/3] x86/mce: rename MCE_IN_KERNEL_COPYIN to
 MCE_IN_KERNEL_COPY_MC
Message-ID: <20240131070258.GGZbnwov0g918F-FGz@fat_crate.local>
References: <20240111135548.3207437-1-tongtiangen@huawei.com>
 <20240111135548.3207437-3-tongtiangen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240111135548.3207437-3-tongtiangen@huawei.com>

On Thu, Jan 11, 2024 at 09:55:47PM +0800, Tong Tiangen wrote:
> Currently, there are some kernel memory copy scenarios is also mc safe
> which use copy_mc_to_kernel() or copy_mc_user_highpage().

Both of those end up in copy_mc_enhanced_fast_string() which does
EX_TYPE_DEFAULT_MCE_SAFE.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

