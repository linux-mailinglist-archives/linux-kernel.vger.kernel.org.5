Return-Path: <linux-kernel+bounces-56117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4CD84C622
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67BEA287DDA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86252030D;
	Wed,  7 Feb 2024 08:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="I4tpDPfL"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436362030F
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 08:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707294274; cv=none; b=KqvvDB76ilmsis/Or2WeJhG2zQspcqB7+QeAceZe79SdxIDJZ0qNIbv912klKMfu6EudsnETDLMSGKqqllUvKo/+WDFLkaxH8IV2GQnT4lVuLNjgDwPIaYaFi7SH+lvAhZCxsg+q/OozIxFWPioN8uHQGVJCGXgFl87KNFcR/kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707294274; c=relaxed/simple;
	bh=HpwKvo0uAhfpy70Id63b3QXrIH8sMkAlZqCmstgxuWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxzdVboiu5Of2wlABR3/rL61PazMiBPUlqNlAz2bUpwpJkkZ1IXw+2PLnbJ9rMeOUylJ7DiatGf3AzmCSxXvij+i6Vvgu8WaxRbtgu91Emjvp1WAOaAdrbyboBhhVF5mf6DAiTQ/Es2Db86QJjzCTC2fKvCeZRXJnal0FtDdXOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=I4tpDPfL; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 882F940E0192;
	Wed,  7 Feb 2024 08:24:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CFSBZ7m3g6fk; Wed,  7 Feb 2024 08:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707294266; bh=UXes4RVGRFQzRZWda+DnplAwh6NrhwGhzGkpIQWlYes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I4tpDPfLH8cShQQ1rStHIwV6gKToRKAi/yyo1v4t/AdxYpsqFWD/dmMLb7Bdg0T2I
	 BQhquc+bR0wlLmk3wQMJGaRM7XKuSi255ZH0R3BOgpPptnxHZ0tSEI3KiPwoAPT672
	 3oeYFv/OvIp9vkeJ/b4BzrX+ZOg9f33fGj6EHMI0pmXfYaWuBa1YYVe3jUxt038KLI
	 SOTmm/+YwUlVrlEbAIiILzrgHqZcc3gC6SosNLuJM7Kj+U3eszsDeLvgSfPOMgSmCM
	 IpdDqO3RvA/LPUyfsa7z7lyxFeSXLERJ4KOtL2OpEOWqi5dRDMK1EmUmNpr/LiIzfg
	 3TsOpy5+KEctz02FaUOX3TmRrgYAXLQoM0AaMczVLWobKi8UhWWC3Rs5G7ts3h5Weq
	 fd3IJHKxFe2sy82+KWHIC4uc39/s2xLHcW8RkJcq3ZN6iz5IbjEm0Tn2vU1sYzG5qu
	 ZYMDF9KX9a6ioOu7AP3eXe0GUQpN4wlOVaCmcR5mR1pYDlZ74DmhwAZLMiJP3a3TDu
	 QUxo9IrZbdOj8qz5a8ZOvHmTFswXbztsDOItbqMF5J1eBsn59A9kUHiE4P4t8iNRgY
	 JghTG4ZfTc0RxveJGsHdyON0YWwZYFye1AO5HHIsU/p6pyNMeD4auJNhFw2MlLW6SO
	 uizsgbgap1vhuWKNABUbSQXU=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4D2C240E01BB;
	Wed,  7 Feb 2024 08:24:18 +0000 (UTC)
Date: Wed, 7 Feb 2024 09:24:16 +0100
From: Borislav Petkov <bp@alien8.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] x86: vdso: clean up vdso Makefile
Message-ID: <20240207082416.GCZcM-MHISTCdT08VW@fat_crate.local>
References: <20231121235701.239606-1-masahiroy@kernel.org>
 <CAK7LNAQXw8owCpehxnUQG7upkENMezazzHFsdu9kggcZQLgykg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNAQXw8owCpehxnUQG7upkENMezazzHFsdu9kggcZQLgykg@mail.gmail.com>

On Sat, Feb 03, 2024 at 12:56:22AM +0900, Masahiro Yamada wrote:
> Hi x86 maintainers,
> 
> 
> Gentle ping.
> 
> It has been more than 2 months since the submission.

Lemme have a look.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

