Return-Path: <linux-kernel+bounces-100027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EA5879101
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC0A1C21EE5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F96078266;
	Tue, 12 Mar 2024 09:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ja8ULgRf"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BFB77F2A;
	Tue, 12 Mar 2024 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235791; cv=none; b=hnNMlBUD5UGLs6EPfgjsT5QhNHjZ+nzmC3LYOkB6NFh855EE7EadWwuxalCZ5dyIO1536wOiSNTB47KJ/gz8SMCJ1L5/6a6NbPUkLdRoZMpuUchiN5bZAzqXDIY9cNa2o6HGSvA3AERZ9Ht4ocEefXzfX54PggXWcT6sxzf/iQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235791; c=relaxed/simple;
	bh=+iTnRPEBhdQEFehii+LHR7rjSnjEiCTxZUKeWneYKAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrNGGLjwy/Di8/rQ9rXHwfmc0jbKS7nu996nSnVVrEXXocDsst0POqmxT4Wnx423Ctwm0cm8n+/Sd+zss0bSeeBRnDVFVjjBxk/bcmpEd0e0yQ0fITLsyBvSv6s/EBO+PW0Np6vLYZfEmeYttrceao9dtqNCSeuNXNd2hPg+Epo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ja8ULgRf; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3D32B40E01A0;
	Tue, 12 Mar 2024 09:29:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xmvrozdHiR19; Tue, 12 Mar 2024 09:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1710235784; bh=pWIOURzU/j9dPwCGogTSM9A3/WY5vlwbavmF4sdmwo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ja8ULgRflPLLMFwdq9vxGvMWNAM7GI1y1uUvIusvdbos3xThvnPXc5uZygAX31JMi
	 luuHtx7jSAjqsTlF4LZl40JYf9+gDgEaxdXRQr+Qa09ICnWoMVzoLKtsrqkbUz1poN
	 n6CnQ/pumd8VShdpIx3M2ITueKNc9QZryhUOuq9hI5Z1NxCBgSRvasz34a+gBnpxuR
	 W/BEdR0I8FWC/XFIALS2lwBy62jnSl4rfDbJKnctlQ9eoa278mW9/3zx6DOP3/jOnT
	 DLsBCfM3zD3MpKNDZE+b1xG+J1E7p1BY6je0/CS1kpDMTS/LYcZVwfR7bEAMDeMi9U
	 U0fDtJfxCs97t7WC6I7z4al4HhpKYzAZRt+uzwXMzkl3oIIgNmF7y/A2rg9gIuxOwi
	 AS+Bwp0+S6NRANSS6NNWfoVrw8hIvgC9gC+agL3V3tCTGgx6cZ+Ca3dDtxV8mqDUzN
	 tMJ3GUYddH/D+mc5BoS2CfjdGo5pxgoRGK8dLlUkjuPdx4je8Ddtd9vq4GDrGuje8C
	 cDXHAf1bveBxY7ZwNualdxWjtdm8H1xMVQXP3Sou3Z30pjBYnLVpPnJVRTUd9lxdRK
	 whC31ApVL+TIhPvLOydNiaGG9Vv70vYAEyLYCkKDEfK3hEyxz1evEscvBoGXu++0UX
	 e0yhzLBCa0I3DChalsJj7Kns=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F3B9840E0028;
	Tue, 12 Mar 2024 09:29:38 +0000 (UTC)
Date: Tue, 12 Mar 2024 10:29:33 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>,
	lkml <linux-kernel@vger.kernel.org>,
	linux-edac <linux-edac@vger.kernel.org>
Subject: Re: [GIT PULL] EDAC updates for v6.9
Message-ID: <20240312092933.GCZfAgfd1iw_sKvM4y@fat_crate.local>
References: <20240311155651.GAZe8pw0urOnUZj1y_@fat_crate.local>
 <CAHk-=whTBKoHrBpMxh7OHQ=pcdy6K2zqqsJOZeCC4xSqRXb5Bg@mail.gmail.com>
 <20240312074504.GAZfAIANxTdC5Tb0vb@fat_crate.local>
 <ZfAdWtBt60hAx//4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZfAdWtBt60hAx//4@gmail.com>

On Tue, Mar 12, 2024 at 10:16:10AM +0100, Ingo Molnar wrote:
> If you mean forcing CONFIG_SMP via 'select SMP' on x86 on the other
> hand, that's worth considering

Yeah, that.

> - although I think there will be a ton of extra cross-build breakage
> as most patches still get created & tested on x86.

I wanna say "this better be build-tested on the target architecture too"
but I can certainly see the use case of having to cross-build a UP
config.

> I think the most viable approach would be to make SMP the only model
> all across the kernel (and eventually removing the CONFIG_SMP option),
> while propagating UP data structures and locking primitives to the UP
> arch level, instead of having CONFIG_SMP #ifdefs in generic code.

Right, UP is a SMP machine with only 1 CPU. It should just work. :-P

> Maybe not today, but certainly in a few years.

It makes sense to aim for such a model, yap. Let's do it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

