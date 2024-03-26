Return-Path: <linux-kernel+bounces-118823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DC288BFC5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAE4B1F61885
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD524C7D;
	Tue, 26 Mar 2024 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ma3wmkoE"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2159803
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711449809; cv=none; b=aJ4FYRuraycjsuKs2BRsdHzAw6vh3+07M7kyT8fYjw/np8e0ttuy/YO9b5JPds7A+r77ra80OnZvN1WJug3hNUHAycBgSFrDV23oEVSinpIbgzKNxQMNYytxWe4rdQQ4S9wdVqhVkC6sBQ8kL/MO1mPJoppRcLN2+fXNZL20ux4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711449809; c=relaxed/simple;
	bh=WgBOkSph8YE6r15R6eAD8yOcsDgYfhDEOEsTEidyUYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xz9cR9n+PKm2JlCABdtdIUorkUwynS5E7TyFSPex9qCkC40IhzhuuniiIrsg/bp3s9+PWD1nU0jTH3eVOm7XCzg/1mSDF4JmIl+0Sq/kwejZ8LXJXHfh3F03Ph/DEE90FLSmmpNQOFXrkuNcHMXV08GDE3Ho8kmboBPhMQNyVFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Ma3wmkoE; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 502AB40E00B2;
	Tue, 26 Mar 2024 10:43:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AqWj66o2AZzh; Tue, 26 Mar 2024 10:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711449800; bh=UfHnBcO2l55t1+byxLnLpzaI6P/73EGJPn+0ciXnCHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ma3wmkoE16n6Ng4QQhJW7ksONFspnMp+zQsglusbA5dLb9WKMK7JqyTGqIf0rntEt
	 zQTCEmsn8Ykr3YnBUY+qAKzyIe3xaNgm6OdRfZOKVN6mY2Lt+KNyjC8FJdOwsu8f6Z
	 xNSc3L/wgLJzrRKF3SujU7hL3owkiCTlAMqGaVfKyHc6s8E3oN7U0EOAGMU2hj8k+W
	 BADwEi6mXPMA3Ny3WpPxUw5UWpAVrLvly10uYG2BIsXsxsEb7VPjiPTAWIBGqq0DMP
	 g6xAC6PB2i2Qh7OV0xczlSUVCdcTChvj32+JyEdbucoMqMs2EvAJaJZs+GyUB5rDmP
	 Jddw9J7XXer2SG5XYj+CDg3H2a0E270B7AkiQEq3mTRudx4fiB8IhVpnxzomfpsTnQ
	 HVEsyoxwArtavnLBP0c6x5Kl7rR8Tm8fBJjR5lce4wFOGd9sY38+8/lwy4mfyWv9/6
	 WWR3fB46kEdNhjn+n1HMzZtCd1OZQOZ/rCnctxzrtx+EjaH51An3022F5TI+8Q6Ngt
	 gNQ8I/t5AOPS2FOceY0Rh7+nn1mmYCrpw8nloH7jIXflKAoYRPeE7FzOAhil0FKvf2
	 83670SL9+oklZfvqq/C3vUKyvnXoijp3Uowa5yNM14z4XsJPfLrA2eadzFu23rnD9d
	 mjKOC0+ThZe6E0jZHq5dgVts=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6FBF440E016C;
	Tue, 26 Mar 2024 10:43:11 +0000 (UTC)
Date: Tue, 26 Mar 2024 11:43:06 +0100
From: Borislav Petkov <bp@alien8.de>
To: alexs@kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/dumpstack: uniform die messages prompt
Message-ID: <20240326104306.GBZgKmuqvLPzppFxyD@fat_crate.local>
References: <20240202074512.563274-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240202074512.563274-1-alexs@kernel.org>

On Fri, Feb 02, 2024 at 03:45:12PM +0800, alexs@kernel.org wrote:
> @@ -405,8 +407,8 @@ static void __die_header(const char *str, struct pt_regs *regs, long err)
>  		pr = IS_ENABLED(CONFIG_PREEMPT_RT) ? " PREEMPT_RT" : " PREEMPT";
>  
>  	printk(KERN_DEFAULT
> -	       "%s: %04lx [#%d]%s%s%s%s%s\n", str, err & 0xffff, ++die_counter,
> -	       pr,
> +	       DIE_PROMPT "%s: %04lx [#%d]%s%s%s%s%s\n", str, err & 0xffff,

Why do you need this DIE_PROMPT if you can simply do:

		"Oops: %s: %04lx... "

?

And yes, I think I'd prefer having an "oops" in there as it is a lot
more prominent. It is called a "kernel oops" everywhere.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

