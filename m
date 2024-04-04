Return-Path: <linux-kernel+bounces-131641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 084C5898A56
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76B07B22E41
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4414D1BDE6;
	Thu,  4 Apr 2024 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="F7MiIFA2"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BFF33EE;
	Thu,  4 Apr 2024 14:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712241863; cv=none; b=jD4Iy2Lz076wDeVaTjH3GV/FOrueEubSjXNReN5baZJX8bkBL2KUIw+K1UQAtho/fy29xQy9qDYWZiefDwJKpphNUjwL0RapHuYy4Sl+m3byb0f0iJBS/Htgy9tGBxnPJwSSvwnUlwQiFWcCxU+Gvuuvz5Ff0HSF4aCachuGlJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712241863; c=relaxed/simple;
	bh=LQayOTlG/JO3IHd7vRlybsoXaeGw9cHDkzFlQyFFYuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V96Vwf9qMb8TiGXjbenznW1QGIg5fLkuMhkad2yPeUrdDVqFaXgCJmJnNzvpq2MMDA8S5W7dtyEQF2jtUU3nsD5qoF42eIKLiGMGH3ScMQbGyryRg5Cgl/tdi7wghpVNykb0yJdwfs8j7XcIczM6YsiKC2q2qCig5TTwYRfmt/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=F7MiIFA2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B787540E016B;
	Thu,  4 Apr 2024 14:44:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wEHAaU40xhaC; Thu,  4 Apr 2024 14:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1712241854; bh=DiZ5mWVhrG4nPWIZ2MMsXc8US/Df9BxuZOmel4lbnRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F7MiIFA2PKmqvFzO5iUZGENLdvyM/10LCTyLI5ufyIrEn2lge4cqYQJ4M7e0mwN/b
	 ruR2ap2rkO4WqTa7XBOTM9614Wtb2hx+ReiE8giLbv+An2Ml7QplBCkWe8OIJzD149
	 6JkppF0TB9B/EJEPURlyqRc7rsLitWS1oBftBVtVahEcayNr1OZ0lxcm+hA794sJ9J
	 MkTLDK+VQeOaQlmbIfi0lZIUjpSqfgWUK/pS4OSLHQDNtt9efBYi1U1NWclhL7wLKz
	 dttVR0uM6+h11/if5M0Yc9ghM27K0zuy2CBtESKQOumjP+bLs/OSBMdRg6Fm47gWu+
	 D0+Iewcy57HS3EUTyOtGLNvp2Q++XNr1s41XkTPpEQgsmjrxYPIkcd0eoIt7tqIf+q
	 g1PHACAoo5/K8Fhpwqb6h+WBhRnojBbA5DlT3l9uIQaDD1emK3B/899yZYLELNm/xQ
	 UuIHduDqYuIRArC4gfIbUkTtnmlCGFcfdyCSJ5Ruwht8D3nmUw2rD8AyILJGDtHhYT
	 No7nvr68dd3JkZk6fnbu/Q3MhzaBQP5YdeILjxl5tiucC6zxRq+Ex57AuFxmTR6kS8
	 tkQM7C0NxfdiBtlrdzXbakMob36h6lNYUxteFErjZ8PcUVDujc86BPwH42ote51HZY
	 Tg5Lypq2g7aA46R5NImQGCqk=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BBF9740E0177;
	Thu,  4 Apr 2024 14:44:05 +0000 (UTC)
Date: Thu, 4 Apr 2024 16:44:00 +0200
From: Borislav Petkov <bp@alien8.de>
To: Klara Modin <klarasmodin@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	"Kaplan, David" <David.Kaplan@amd.com>,
	Ingo Molnar <mingo@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"x86@kernel.org" <x86@kernel.org>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH -v2] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <20240404144400.GEZg68sPtF1xTFmUUH@fat_crate.local>
References: <20240104132623.GFZZax/wyf5Y3rMX5G@fat_crate.local>
 <20240207175010.nrr34b2pp3ewe3ga@treble>
 <20240207185328.GEZcPRqPsNInRXyNMj@fat_crate.local>
 <20240207194919.qw4jk2ykadjn5d4e@treble>
 <20240212104348.GCZcn2ZPr445KUyQ7k@fat_crate.local>
 <78e0d19c-b77a-4169-a80f-2eef91f4a1d6@gmail.com>
 <20240403173059.GJZg2SUwS8MXw7CdwF@fat_crate.local>
 <f37a111b-f5c5-4337-8eaf-46a2c28f01da@gmail.com>
 <20240403204113.GLZg2-6f0nH0Ne9CQt@fat_crate.local>
 <edefa2e5-c320-4021-bf8c-c6b1adf87441@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <edefa2e5-c320-4021-bf8c-c6b1adf87441@gmail.com>

On Thu, Apr 04, 2024 at 12:25:42AM +0200, Klara Modin wrote:
> All the more reason to continue then, even if only for nostalgia ;)

Here's an argument for you: please save the environment by using only
64-bit hw. :-P

> Jokes aside, I do run -next kernels regularly for my daily drivers (which
> are x86_64), but it's honestly not very often I notice bugs there that
> affect me. They have all been pretty minor or very obvious and would
> probably have been caught regardless, but I'll of course still report them.

That's good.

What you could also do is build random configs on linux-next - "make
randconfig" - and see if you catch something weird there. And maybe then
try to boot them in a VM and see what explodes.

In general, testing linux-next is a very good idea because it helps us
catch crap early and fix it before it hits the official releases.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

