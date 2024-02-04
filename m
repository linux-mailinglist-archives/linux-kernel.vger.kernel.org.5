Return-Path: <linux-kernel+bounces-51591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E65AB848CF7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 11:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F6971C2180E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16313219F6;
	Sun,  4 Feb 2024 10:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ffsS0ewt"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227BF22089;
	Sun,  4 Feb 2024 10:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707043767; cv=none; b=WVEpZVwM87PQDRUru6UqHvmzzVWeVSXR10W3yo5zuOO51aeq0X8dNdPghkLFwT9mdSkm1VlXaJpFYDCej/m2qDCQUmJioj8I76zoFCF0+5jjB63S6vxCK1w86oqVS7kxDj+iBe7hdsETGKqsovRHimqeOL7djVzTSEN9vbNaAAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707043767; c=relaxed/simple;
	bh=DD3burXbis1zh2NF68M4BRx60tt8TNIQHD6FlEYOGvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrOEKlX55WTbHEi3/HwGrlmrE1vflIzNoQ0WHb6rZUnT73yiamPbDra4qa4XCf6TPklE6YiXD3BNCO5xi5wId0l3k+z+Pz/lbRcvQ0qchpQhEQil+6dGAIo0xp+AFfNAVxeeIN073mxyPAGxKuixBS1dmoToozofS+hQ17bAS7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ffsS0ewt; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9708C40E0081;
	Sun,  4 Feb 2024 10:49:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YBhXrLijfIZl; Sun,  4 Feb 2024 10:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707043760; bh=FVNplPEFE54hHQMW1B44irG1OqEL3I+JVrCgMo9J7mE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ffsS0ewtExa2Q5lhc1iJjW9mDRLHacjIs5RZIDFqEL08myWd1QkEaz13yPAiE7Mlm
	 Bte+XQb0fHF9iTllIRcA5zCYoC6ouVB13We1QMpmPN5pJiFuu3yCeun83/6+GdUqEp
	 nT1v2nCfhBE7i8p6N/zZg6q28gRfgANqbDHAM/W5UVQPeNpsBKT3ak/Xc88WPf/BA/
	 N+jPJ8tRBuINukuT3qsVEnGpm86Cs4sq/39lOxQRHFq01pR1JtXJQM37Djpi38RuIA
	 z1xlt7DXc5422vBYT0fzIpvW/tw/d1QfiWL2/sYy5NLs87YfPKG4IpQog+itOlsyuc
	 l9ezy3WUJwmw7bclOPTM7ncsGqZwxq+0gaEwLJw3kdDyItdnjKRk2X1gSsZ0SIMxgN
	 rt4Aedmgo3xm1AoBGZa4mGfDvVy5fq6xP8A7FR95jnrNTWYoo6hc8wtmZgd1M714bs
	 SO5SGsDQraDxSA2k1waB9I+xhl3vQwQ+EmwpUFEytGUWS7KB9clYKU8rIo906rJi/U
	 pmN7kes8Gy/+ZsUAPycdg/9ufN0BJ20FZmVjSKv6s8d7qW3vt57IiCimk9FpPeS0Tn
	 N+nSu5Ak33W/xZgaTAyGoj0ybmBrG+oPXUZC5X0A9q1eUApvvylgPndYCDKHqI7C4a
	 4AiWrbv9Qwisn7VqZcZVCCyQ=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3619E40E01AE;
	Sun,  4 Feb 2024 10:49:09 +0000 (UTC)
Date: Sun, 4 Feb 2024 11:49:04 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <len.brown@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Zhuocheng Ding <zhuocheng.ding@intel.com>, x86@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zhao Liu <zhao1.liu@linux.intel.com>
Subject: Re: [PATCH 8/9] x86/hreset: Configure history reset
Message-ID: <20240204104904.GAZb9roHMCug6P9P8f@fat_crate.local>
References: <20240203040515.23947-1-ricardo.neri-calderon@linux.intel.com>
 <20240203040515.23947-9-ricardo.neri-calderon@linux.intel.com>
 <20240203093857.GBZb4JsahiDx2Ouegj@fat_crate.local>
 <20240204035552.GC26316@ranerica-svr.sc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240204035552.GC26316@ranerica-svr.sc.intel.com>

On Sat, Feb 03, 2024 at 07:55:52PM -0800, Ricardo Neri wrote:
> I can set hardware_history_features from bsp_init_intel() but I still
> need to call setup_hreset() on every CPU.

init_intel() runs on every CPU.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

