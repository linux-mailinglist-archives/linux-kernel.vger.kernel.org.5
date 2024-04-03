Return-Path: <linux-kernel+bounces-130593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E504F897A35
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A002A28D86E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7564114C5B3;
	Wed,  3 Apr 2024 20:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BySGX9+L"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1A7156678;
	Wed,  3 Apr 2024 20:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176896; cv=none; b=sZRoiz8rvKQ/5nzpsFM+xngGzddXhRjJufvbrS7ALKZZ8Uigx682PaKN9y/74jaCdEZTf9efMus7xp4WWGb7cv7mTcxrwEGZWsKP9482SW6tH8yPXSlvaSN2P0NmTS5hES6xzpGPYpyA6HabrfQmSpXUTqcWWrJVVSMNQxzZBiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176896; c=relaxed/simple;
	bh=WBi+jMy/cPJPoUYrHvBCMEz4c/n+8y/p4u1tYF4xRno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqqxbuK7r7HeedaDSWDa5OjMRGOyV5/Q8Gv56WWalndJf6dPKb/kc5w3CcJvDWiw4gBPBgUM33kTEKuAsaVDYfWIuQXMLOmowbykh+vVFv4UuiI8T14/QO5A9G0oc5fmiJf1fMi/R9dLEQUzsOGpqrsnRcz5v5auatjy28nuRPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BySGX9+L; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BE54340E019C;
	Wed,  3 Apr 2024 20:41:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zNPoDRuXVeZZ; Wed,  3 Apr 2024 20:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1712176887; bh=SudQJGK2u0OMPdgM7lq3lvNT9ANcyHz0cK1GxOTp9BE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BySGX9+LYW3pLRDpGHmCEpj8LlqR+z//OiqByTtalHc4xBd75tW8b5V0Jr34TA/3W
	 yjx9cCKdcBvMFuXU3C+ZU3d0CrJQnoG5nVrD8Pns+U9MMXhmfZeETmT51nvXb4DTB9
	 j0qZKmvJnrw4uIE57DNd8oQldFYPBtIedgZDFUSCnQsRrwdrvtjn2eOHv/E1nbMSRh
	 NdhKh630+Ly9kS2clCBCQZzJbGvhFdKIOm3d8hl0GEzZXcp1lIOILFyl7GYJ9aRsPt
	 +j+PXD9NCDmj/8ERs111FN4tm4IPGRHXOEb1WZoljJdiljRfy6yn0sibBrlCk2gtYg
	 qo1G76qZ9SZNgFocPNU+3unM2u2ryoMyrAIbn2K0ucnWtFjZPQmJ4gtvt57lhcwyC9
	 9rlSzswBDovoHu+9YC5MdOjBsbA9UGVnfAtnKhii6hUIUqkUBbWRpNGU7gXqtaQ+aT
	 JtkDXdYYpE51eecfTba+NJMpfcLdm6e4rRKeVz8t0KuW2GY/8Vrm1YZiRcSA1FAVh5
	 MII2IBShIxaFWToN0C9aUb4IjiJOcZI4yv1gvOC0S5CZiCDV/Uuvs0uLOW9kbGxmho
	 W6VsPS8/2tsBFKH8jP1tGZKJ146cfvI6OfRhUa6nlQzuQo3/rfJgkqi+/WLOZO0PEr
	 DUHg+CcFLgIzLVRHRfsBCYYk=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6D26440E00F4;
	Wed,  3 Apr 2024 20:41:18 +0000 (UTC)
Date: Wed, 3 Apr 2024 22:41:13 +0200
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
Message-ID: <20240403204113.GLZg2-6f0nH0Ne9CQt@fat_crate.local>
References: <20240104131210.GDZZauqoeKoZGpYwDd@fat_crate.local>
 <20240104132446.GEZZaxnrIgIyat0pqf@fat_crate.local>
 <20240104132623.GFZZax/wyf5Y3rMX5G@fat_crate.local>
 <20240207175010.nrr34b2pp3ewe3ga@treble>
 <20240207185328.GEZcPRqPsNInRXyNMj@fat_crate.local>
 <20240207194919.qw4jk2ykadjn5d4e@treble>
 <20240212104348.GCZcn2ZPr445KUyQ7k@fat_crate.local>
 <78e0d19c-b77a-4169-a80f-2eef91f4a1d6@gmail.com>
 <20240403173059.GJZg2SUwS8MXw7CdwF@fat_crate.local>
 <f37a111b-f5c5-4337-8eaf-46a2c28f01da@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f37a111b-f5c5-4337-8eaf-46a2c28f01da@gmail.com>

On Wed, Apr 03, 2024 at 10:26:19PM +0200, Klara Modin wrote:
> Probably, I don't have much knowledge about this stuff. The machine can at
> least be useful for testing still :)

I wouldn't use it if I were you as it wouldn't even justify the
electricity wasted. No one cares about 32-bit x86 kernels anymore and we
barely keep them alive.

It'll be a lot more helpful if you'd test 64-bit kernels on 64-bit hw.

:-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

