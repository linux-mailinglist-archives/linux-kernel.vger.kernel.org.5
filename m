Return-Path: <linux-kernel+bounces-105152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3FC87D9C5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 11:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DD441C20D42
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 10:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3112417BA9;
	Sat, 16 Mar 2024 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hl4lpG4a"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3709B14285;
	Sat, 16 Mar 2024 10:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710585005; cv=none; b=KkhgDuksym9jk+JqB8rNFp6f4jJl3fKvaNeKNypHSCR9FCGTzsrhbG/v1op2RlW81dyptgJISUGBrx8t1xhmVKT71/oAy/unHtFXCP5bJ3P7+6733nhtDUDBEBjH68cQyQEUpa7pMeeOKsnGiyekDrGXsWPiBtLLvT6YolWAjZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710585005; c=relaxed/simple;
	bh=2hvmzk5LTBV7MSnfl+yy7mV9huk4GVf+hrtucv0rAio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5bISmSiymNVd6Jhan4MSlCCTsdIj8FJyDLGm80xKKD2uf/ZsUsbgbt+waKLGtm/65XgoOZYmvYXZAhdWqMzQUQ+AV1uDkLLbahSSuT4wDCMJCAm96cm3aequ+rHDxHY+/LG0ynh5hRnb2jgFY6p69uR1jN3QOFfUOLw9Q1P3fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hl4lpG4a; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1A76D40E0028;
	Sat, 16 Mar 2024 10:29:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dZdn1D9LnRxm; Sat, 16 Mar 2024 10:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1710584989; bh=622fp/iwp0ja+uFsTK0H2ih9wpqwwCGXkZw+tdKCZZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hl4lpG4aBMiBGkEAdBApzAWkUTNmIjN6gGZru/Omfr2NSGYd+Eur8KsJk1v2bhbcX
	 mNTFUAGfZFWMDyzbt16LVieLOBiur2s1/G8CUcJWY4DsLnNp+nefPnj8jrikbBlmmc
	 kDRvjWw4fIVwOVve0hPhIa77byI1sIVcZ24TTiKB5JY5Qyzflm7yhELCbUjHtSjyb6
	 3gHPtyuY+uhH+SpjB4q9plg4l5PkzpysVkznlLhnmDHlBpeE1b/axg1deSbOY+ALbK
	 zCoshMVYuVJzut6EdV9om+PfTzodOWueFePPk3z3zEHTFJeXYfATWwxop60/WzYeaF
	 oJa4Kbm/ZFbXgFtK3h24dbmM54ynEGBYrTvJiAXc78BqxMTYKHtGPzI0RM9BxdKKWp
	 bIlK8QswcadJSZuaeQSmOe0DO/dYKtrk1wPBxVme05UAbblpOvAAdGPxI46PPfYpYJ
	 VIM+6nTjL2P32pu3V6Qg3TR2tFPinqIfiUr+yhzuul040Brh8DMdh8dYsREhh9DKe8
	 9UDv/vm5rP3ZaGprd05tICZiXGJIWxk8750U7Eb44jursEcGWn0hRWC1AlqEwP786p
	 Rj62Htck4PEabWcxU720Tv6Ql4bFzLgkG8sodSDkCyhmRtHWPKdTIOCz1RjQ6nPvp2
	 0G0rWKf6D5nBjoUO+kJtw/to=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0303840E0140;
	Sat, 16 Mar 2024 10:29:28 +0000 (UTC)
Date: Sat, 16 Mar 2024 11:29:21 +0100
From: Borislav Petkov <bp@alien8.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Vignesh Balasubramanian <vigbalas@amd.com>,
	linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
	mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com,
	ebiederm@xmission.com, keescook@chromium.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
	jinisusan.george@amd.com, matz@suse.de, binutils@sourceware.org,
	jhb@freebsd.org, felix.willgerodt@intel.com
Subject: Re: [PATCH 1/1] x86/elf: Add a new .note section containing
 Xfeatures information to x86 core files
Message-ID: <20240316102921.GAZfV0gQ9Sn_hYcKhW@fat_crate.local>
References: <20240314112359.50713-1-vigbalas@amd.com>
 <20240314112359.50713-2-vigbalas@amd.com>
 <dd54d6de-0bcc-4b2e-a420-b1a429b06246@intel.com>
 <20240314160824.GDZfMg-J1VOyjxIMiV@fat_crate.local>
 <6ce6aa20-25d2-4784-823f-2a18f592e002@intel.com>
 <20240314162954.GAZfMmAnYQoRjRbRzc@fat_crate.local>
 <87cyrvjbpb.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87cyrvjbpb.ffs@tglx>

On Sat, Mar 16, 2024 at 12:51:28AM +0100, Thomas Gleixner wrote:
> Anything which is not enumerated in CPUID does not exist in
> XSTATE. Period and end of story.

But why not have a simple buffer definition which doesn't need CPUID?

Also, doing the CPUID thing would need extending the gdb remote protocol
as explained here:

https://lore.kernel.org/r/971d21b7-0309-439e-91b6-234f84da959d@FreeBSD.org

The simple buffer layout won't.

So regardless of where hw is going, I think a simple buffer definition
is always better.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

