Return-Path: <linux-kernel+bounces-96703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E307E876041
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200CF1C227C2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFBC51C5A;
	Fri,  8 Mar 2024 08:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kqmvPM+3"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F8C535CB
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887924; cv=none; b=Og08ItNdWkRQqmkLF/9AiNY9teUsHMBcxD+PKfg8PV/P66UjxXPJ3654X6XLKkeHrnQvtr4Z0fkb1y2qX3VrDFVOUXhbvO383vRQs5HvBD1AJ6m1P0DIIN6dBQVAKt5FWTZn8CViTINWHO1Ba59bFnCIPh/ZlEmAjFGKkOmhre4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887924; c=relaxed/simple;
	bh=d+eBbj2Nb0MVYio+UGs/GW9tbBgCmaxT8C2mIJFu8hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jknEgNeV+MwxPktUTtGczLc3n2CSziYbJ4OlXkeUjAR0fPtodGY3p7gCVqM+sdEBYBRRxjZ9yx8Ainbz9LPTZ1OVb6v5tdkLlJVn9cnOj7ZqiQE14Df7uGoCmUlaQozLxHZVcW4C4sIm+4PBg7v5Xw2E6H16VpM7WnlLUDRB76M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kqmvPM+3; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7796E40E0185;
	Fri,  8 Mar 2024 08:51:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sLcw8XwCxoTY; Fri,  8 Mar 2024 08:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709887912; bh=lx4Oc/E94A1DyWPnxqgI54qZbFg5c/KtJ3SnWzfJCc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kqmvPM+3Se9m+y2A+hU2WmMxedCJkTR6tEGhzykqgFhW79XV5xdqXLZSTrOZUc8td
	 TNycdi83Unnxk9/3oqt5aBXXkhfJx3aX8SgikAgf6kZe12/HudJH6onEAPBf+SbvmW
	 ZkRH4qr1JCZLZFBXdBdQKG6fh1fICmT4uoKlAx9UMUdgnEpsQgyUjCpbdzSUrk8REg
	 yGVCDPw9D6NJ3FhHaeE7DRItp6Au0w9Frw10j5QTloBNfxmNpKRjnPFho2IPD7ow1D
	 mFKIt4a/7UtP0zHQIfiyTFFVdQsItC34RmuZ4GIlxKdMigXsPJ0G01Nr796WAJLatV
	 qspslUWAPE+i1Fa3Bm37LNFprisdee2XYgFBXunKL3phhr/tpOICoorJs2/d1kS9+K
	 LNUFT7M/PQUwfI4H3t7BXWzTHYY05qv5ueZ3vMbiGHkAeXNMBJf83mrpRlV2hRmZqY
	 3R3IeKR82ghjbFzGJTYAz0eUdmEC5GFzqBhJA7ugOCBuoTJbXbO9z1tri9/BQYq6uH
	 uN7nyJQZekm0bjpDH3g86/Lz5aR59gnxO8MSFZvVU0HUZbTHuTcjJfhNl1OTaGL4sg
	 qH+lJZiJVZyaaxaMMxY0POU7t8V2qyUniM72hWKTwRALj38LsLNrRVrCHkWe9Vegbe
	 5rSDkeI7Me3ePWuB4q0xbdNQ=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E74CF40E0173;
	Fri,  8 Mar 2024 08:51:43 +0000 (UTC)
Date: Fri, 8 Mar 2024 09:51:37 +0100
From: Borislav Petkov <bp@alien8.de>
To: Peng Liu <pngliu@hotmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, rick.p.edgecombe@intel.com,
	daniel.sneddon@linux.intel.com, dave.hansen@linux.intel.com,
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/apic: Delete useless BUG_ON in
 validate_apic_and_package_id()
Message-ID: <20240308085137.GAZerRmfUsYBfZeDYr@fat_crate.local>
References: <TYCP286MB21461411BA788E6681AF448FC6272@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TYCP286MB21461411BA788E6681AF448FC6272@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>

On Fri, Mar 08, 2024 at 04:01:52PM +0800, Peng Liu wrote:
> Both topology_update_package_map() and topology_update_die_map() have a fixed
> return value 0. That is, they never fail. So the BUG_ON() checks on them are
> useless and better be deleted.
> 
> Signed-off-by: Peng Liu <pngliu@hotmail.com>
> ---
>  arch/x86/kernel/cpu/common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index fbc4e60d027c..44b08de3971c 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1796,8 +1796,8 @@ static void validate_apic_and_package_id(struct cpuinfo_x86 *c)
>  		pr_err(FW_BUG "CPU%u: APIC id mismatch. Firmware: %x APIC: %x\n",
>  		       cpu, apicid, c->topo.initial_apicid);
>  	}
> -	BUG_ON(topology_update_package_map(c->topo.pkg_id, cpu));
> -	BUG_ON(topology_update_die_map(c->topo.die_id, cpu));
> +	topology_update_package_map(c->topo.pkg_id, cpu);
> +	topology_update_die_map(c->topo.die_id, cpu);
>  #else
>  	c->topo.logical_pkg_id = 0;
>  #endif
> -- 

https://lore.kernel.org/r/20240213210252.901865302@linutronix.de

If you wanna do arch/x86/ patches, do them always ontop of tip/master or
the current linux-next master branch.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

