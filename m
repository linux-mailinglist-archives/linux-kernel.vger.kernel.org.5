Return-Path: <linux-kernel+bounces-130378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794FF897856
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E24EB39C63
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887DC156F47;
	Wed,  3 Apr 2024 17:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="GclBP5ub"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3FE153822;
	Wed,  3 Apr 2024 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712165483; cv=none; b=Y1cj0Lyy0XQJauKwnDX3IhDSFMWLlwbgmDccGzcpk/51UlwdWWK7GUb0ghp5pKVeMFuvwZtRafEY0B6+QMeAjVeLt+9ONafiNTRx6fBFIFm5JIGGuzb3BssT+2hHXJY+tNZ7jhA77UUpYb4k1T12xPHSAKg/MQxitxgmXaXy+qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712165483; c=relaxed/simple;
	bh=p8kFOHHCyWwKbveWt4IGtYlKJWXq91L+5BVvJtaXKVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4vQ/RtwAtJapjj6DcL0jPXPWcGrmO9GNpkFUSPV0goMzr4PTJmqs4wWa3BLKwgFKP2KIc7e933CkcS6b8PQ5nKC4lDNVhuGbzhXoXexUIwOVQSwHEjE0DkFdPMF2d7gk3fRHzeXkctx42nmSVEUmzsFYH7ea556alnhzjjNuwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=GclBP5ub; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 11D3940E019C;
	Wed,  3 Apr 2024 17:31:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qDuJysMCZqxA; Wed,  3 Apr 2024 17:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1712165476; bh=SqzbwmgaxncEHBb2O8Cg95rsLFDj7m8knponlADWYWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GclBP5ubHAxrweyKt+dmOSMJD06C9mga7MqTNKDl07owy3DYm3qc0nD3J2VdWGbBZ
	 Uy/WjCAMFC+lulX1n90ArsRZcq+BfSWrJ3wQH3DzLPvQ1CH6NO0o5AtqvhUde6PG58
	 ph2cV2MWY2lIIMOYsbInaQoBXBR4ATPxo0EqNUI2Gx2gIaX3vY3BkTwaubmhqpAov1
	 yWZgjdNMuQ6ldV2FPTp8SvoNqo7kNvXN5o4EWdywiK0qpObr8MpfVNkEJJIOK3HPM5
	 QyiCFzHZCwArrMnjb+BRggNbH4A/1EOav0/s24Jiazxk1UAPrffbKdDDzNdPRCXUP0
	 JguCK+UZszaG8vWgHUUzVg5iZ53QjtH4u0Gox84a2ISxThqJaTZGXcqGLP5eN39pti
	 2JCuf0pVUEm0R2jPKv2cyZQbTXBlj23ejO+VPrYbbWg8Ny605r8RpkiCqgzxFiN9+N
	 UooERxKEwjHH/UCp+Ehnecw62Hi/dLKbbOluwkE2/sgNUGtBKR2XCGyuL0FRuKNVb5
	 pvaDlXIYhUbbJSp8+Hir5CyZQ4ahgt72FVhZB6Dm/LMqGIZhjWuENdy160Vwh1d723
	 x7NEbWHDrZxS4fHEcpYxSvfXqQO4GeVH4cDXNhnjWYLi31DpN5GA7glY8W5gpAeXlI
	 6IVspoKqV26XDWoCX4nrPC3g=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5A12540E00F4;
	Wed,  3 Apr 2024 17:31:07 +0000 (UTC)
Date: Wed, 3 Apr 2024 19:30:59 +0200
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
Message-ID: <20240403173059.GJZg2SUwS8MXw7CdwF@fat_crate.local>
References: <20231024201913.GHZTgmwf6QMkX8BGbo@fat_crate.local>
 <20240103184656.GEZZWroPmHLJuP6y5H@fat_crate.local>
 <20240104131210.GDZZauqoeKoZGpYwDd@fat_crate.local>
 <20240104132446.GEZZaxnrIgIyat0pqf@fat_crate.local>
 <20240104132623.GFZZax/wyf5Y3rMX5G@fat_crate.local>
 <20240207175010.nrr34b2pp3ewe3ga@treble>
 <20240207185328.GEZcPRqPsNInRXyNMj@fat_crate.local>
 <20240207194919.qw4jk2ykadjn5d4e@treble>
 <20240212104348.GCZcn2ZPr445KUyQ7k@fat_crate.local>
 <78e0d19c-b77a-4169-a80f-2eef91f4a1d6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <78e0d19c-b77a-4169-a80f-2eef91f4a1d6@gmail.com>

On Wed, Apr 03, 2024 at 07:10:17PM +0200, Klara Modin wrote:
> With this patch/commit, one of my machines (older P4 Xeon, 32-bit only)
> hangs on boot with CONFIG_RETHUNK=y / CONFIG_MITIGATION_RETHUNK=y.

I wanna say your old P4 heater :) is not even affected by the crap the
return thunks are trying to address so perhaps we should make
CONFIG_MITIGATION_RETHUNK depend on !X86_32...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

