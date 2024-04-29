Return-Path: <linux-kernel+bounces-162249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B978B588D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14AF71C23070
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13603C133;
	Mon, 29 Apr 2024 12:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ule6R+K6"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9293A322E;
	Mon, 29 Apr 2024 12:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714393854; cv=none; b=KO4PcIvIqGC0WC3UnA0HzWzVb3QLXv6EZVY+VXvjtl5D6Y3nKuuKVPpHmb5Z6E87jvbatmLC2NsIgi/GIFsQK3fP1yrxDe1vzrsPJWOhnHG5vOL3sj5fwCMtdM0kBhlvlRz23imgAmOMeTUqLtFLDrASD0aRbzjPerLBmQwVv20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714393854; c=relaxed/simple;
	bh=7N0utKAEx4E/O+TGpndTrMTBy90ouwclTFUM80d5C0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UICQN7v8SRtN289dlCcMeY6ytKyY25J5jc7jKq2FQvo7DdjT+f+5kK91RQJ7pAvI2dXZM3e6op6HmXH2nJ1LWraAheWkDUzIwXK1VLqM26IMyQmTeXQHOpC9NIxEDVkERQgqRnx8kOYPF7i5NCL8kAQYEkzIqJG7/NsySVo1B1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Ule6R+K6; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 065FA40E0187;
	Mon, 29 Apr 2024 12:30:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hjGpXXIOrkZm; Mon, 29 Apr 2024 12:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714393844; bh=P53mqjXOTmkoFUZX78LGD91nZVEGE1SG7dpgszC6P1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ule6R+K6K4cCkTfEev7OmO5agpjnJMB1butWf2LNU9DbJ7cYvoLoGfrzDVVibk7Ar
	 lOtczadxrOmM9IdzJPDZjFSZohe3ulrAABFx/oqYiQrOejCd35YffTY3D0Vau8CXht
	 WiOVXig5ocdgn3lBNve7Ya3LDT9z9uxezxFaM4v6UqZUs7tOu7g+HpsXWpgF63/srg
	 YIXkBdBoRaj+nBabw/9Czd62kVt5BuY1LgRFU7xwkckuvCE8OYTaYrFcJXVJkfHLdx
	 1s4ChX1J2YbfBMG1pzvlhNGZ2FolO00mDtuU+tlUiu/Nk9OiDU288UzzvSeYCsyzsb
	 WtZToIRWHu60GFTXnkBc3I9a6SFAKPpwrvoniYL3swieAlRFmIUTgHhUNhQS/C3TqI
	 9Vdn4NC6b8V2UMSNaZBBJOSnv1vh+iRdgVi602C4blcqAqXf61riyXVEODkqmha5Ij
	 9wPL6Gg2iiTuEVAOGByblZoHjeJ4YmQkV/tR1WikTo+Em5RLPfxZnNKuOc4JRZAjED
	 TbwROhjjEnrLFEWYYZz6gLOkgH17xBCk7Y1Baah4ty79QrK8QQJX+0Hy29YFvva6nv
	 jNnUMpQFiU9Z8zjqqKDfjER9xh3nmiCWxEw3C2pAy24sJQl9RdAb46YGT1e5iekNyN
	 jmXINKOX3//0gf1bA8TEkUjs=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4787740E00B2;
	Mon, 29 Apr 2024 12:30:29 +0000 (UTC)
Date: Mon, 29 Apr 2024 14:30:22 +0200
From: Borislav Petkov <bp@alien8.de>
To: Michael Matz <matz@suse.de>
Cc: Jiri Slaby <jirislaby@kernel.org>, Ard Biesheuvel <ardb+git@google.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Song Liu <song@kernel.org>,
	Ricardo Ribalda <ribalda@kernel.org>,
	Fangrui Song <maskray@google.com>,
	Arthur Eubanks <aeubanks@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] x86/purgatory: Switch to the position-independent small
 code model
Message-ID: <20240429123022.GBZi-S3p4vlPK10pYM@fat_crate.local>
References: <20240418201705.3673200-2-ardb+git@google.com>
 <3f23b551-4815-4a06-9217-ff5beeb80df2@kernel.org>
 <20240420131717.GAZiPAXY9EAYnHajaw@fat_crate.local>
 <836c267f-a028-acce-8b19-180162a5febc@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <836c267f-a028-acce-8b19-180162a5febc@suse.de>

On Mon, Apr 29, 2024 at 02:05:12PM +0200, Michael Matz wrote:
> It may be so ingrained in my brain that I'm not _always_ saying it when 
> talking about the large code model over a beer.

Doh, you should. This is what you start with! :-P

> And indeed I know of no particular problems with it vis GCC, but that
> doesn't mean it's a good idea to use :-)
>
> So once again: "everyone should simply stop using -mcmodel=large.  Noone
> should use it."
>
> So the patch goes strictly into the direction of betterment of the
> universe. :)

Yeah, it is already on its way to every kernel near you. And looka here:

$ git grep mcmodel=large
arch/powerpc/Makefile:125:      # 64bit relocation for this to work, hence -mcmodel=large.
arch/powerpc/Makefile:126:      KBUILD_CFLAGS_MODULE += -mcmodel=large
arch/um/Makefile:34:    KBUILD_CFLAGS += -mcmodel=large

x86 is all free of the large model now.

One less thing to worry about - gazillion more to go.

:-P

See ya on Thu.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

