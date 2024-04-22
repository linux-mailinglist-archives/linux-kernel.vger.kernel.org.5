Return-Path: <linux-kernel+bounces-153805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7B78AD371
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43C3BB22035
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD45A153BF2;
	Mon, 22 Apr 2024 17:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CK0eNxV2"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135231DFFB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713807878; cv=none; b=pxSQGUJNMjJqc0xcDdvUjrKT14i30yrvHk1PWvGVptf+1VUSY2/cvJyl5KoljHPAHlxq3TVnOt2bkgyGUvDO31JPY1WUR9Pm4LSD1y/ouuFWn9V7bH/YcpwsUEsngDPAth3aqVevhOQgDVLlh/RX0AY9wThr4erSVAfnPySqqgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713807878; c=relaxed/simple;
	bh=7drD7tmNeZZ82Un6/DUMO06pOaonB1g0qkyj1n4wMo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aiXAFFjHEC2xNgJehJqOM3K2LQyhH/vEYCMeDVCJdr5KB13ncIpdpQ97uWRIlkMgkZK83CkX9cCU8xgVYyE7lJC4ph05E2pTZCJNZpCFdYmO1mDNDHEAuW+gUnx+5eOI8BomUJHhXbC3qoUkgv71CmvOgvD/DtQS9SFydu7jQck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CK0eNxV2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 957AF40E024C;
	Mon, 22 Apr 2024 17:44:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id d9q0rHF2ZGYT; Mon, 22 Apr 2024 17:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1713807868; bh=LiCv4ti/ZUxju0UMuzlsEkcZFBZgjZl/ErGFhRv0GKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CK0eNxV28Th0YAv78TBTiplIKq8rl1XqmfVtKP/azvJsDJk+ZverSTi/9A1Z1vegj
	 fydDP2t7OcVfOwSyRLLryiyrlHdnwdTFh4ObvjbV2FpneGEj4tPQCuug1w0ZACe7YJ
	 asmyfjzaewZJucnlqOZjiKbO8YtGSLaFSfI9Yv4LpqyISdgHPAx3qoz3guk+zNqKMT
	 8TKnbMKSKiFyT6dXL+X7J+ZdqFr2R/wiJSRTtOq/4YdoyuU2Nt1wW61d3Xn/f8YCr9
	 /amkoUCKbtiWHYzNau74XXSJUxfuxihrbNNhpBt9F8qwwCR7v3hZWGe7h8nwLlT+Ec
	 G+q6BrVk7kpYG5qrYqu4Mls4YsFGHMM/QbkqUbK3ot18vmthM3P/4wWEJCs4kZgX5e
	 x/3X9AbD6s6SI7gqKgHceNQw3tTwJzNILse1VjQaj7hHjRjaZE3ioPoHiGy1YWKvEy
	 6C9Y7uaR9XGEURRdSdu6Lt53RHS7E5IIZBgzgzDKh5HrfIKlqNiX6ybU1Mws121Gkk
	 Hjm5s3Ejrwz4d81GZ9UyT/hpv59rjnsYPgMEdk0WOJ1Bfmz6PvxlW3zXRdJ8yXmlfd
	 A6sIOd3KWeYYVMhGYDBzOMiAdBbNyLifED8Io3jeM2TNpA+yzhRxVQD/ygceMQ15yF
	 hKM5ETAonMLH34yCfm1aOiHU=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8F2DE40E0249;
	Mon, 22 Apr 2024 17:44:22 +0000 (UTC)
Date: Mon, 22 Apr 2024 19:44:17 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
	jgross@suse.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH 4/4] x86/xen: Enumerate NX from CPUID directly
Message-ID: <20240422174417.GBZiah8YrdzM6_bA2R@fat_crate.local>
References: <20240403153508.7328E749@davehans-spike.ostc.intel.com>
 <20240403153514.CC2C9D13@davehans-spike.ostc.intel.com>
 <Zg7B0JwJD6sfjVIY@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zg7B0JwJD6sfjVIY@google.com>

On Thu, Apr 04, 2024 at 08:05:52AM -0700, Sean Christopherson wrote:
> ...
> and then the NX Xen code is more simply
> 
> 	x86_configure_nx(x86_cpuid_has(X86_FEATURE_NX));

I can't say that I haven't looked at the KVM features code and haven't
thought that, yap, some of the bits we could make generic. And I was
going to even suggest that but then, there's this bigger CPUID feature
rework that has been brewing on the horizon for a loong while now and
where we want to read out the CPUID features once and have everything
else query those instead of everybody doing their own thing...

.. and some of that work is here:
https://lpc.events/event/17/contributions/1511/ ...

and tglx wanted to get this thing moving faster...

So yeah, I think we should finally unify all the feature bits handling
and reading so that there's a single set of APIs which are used by
everybody instead of the crazy "fun" we have now.

And then my hope is that you could kill/merge some of the KVM infra into
generic code.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

