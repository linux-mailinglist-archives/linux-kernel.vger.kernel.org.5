Return-Path: <linux-kernel+bounces-118920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6007988C13D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 016011F62C13
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3768A6CDCC;
	Tue, 26 Mar 2024 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hLFnzUYW"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B431B6BB5D;
	Tue, 26 Mar 2024 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453804; cv=none; b=YJ38htV0hWG3o3XsKnDXFU8ZcTeoQfrK+whnZnezDDdmdccRM2jDA0qVZNuIk19A7Cwm1asE1VmEW8GHO1oxpsz3Ep2YMc9+8gYPuwTCZY+wIfhtYLkVpQpSXq4W/1u49urXJj61/7gu5uWc2q20eIbAzEFMY2FX0468npD5Ek0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453804; c=relaxed/simple;
	bh=EDRGr0XiS5XxgjyxuIYgM/fzheL+KMSa8NRn3sANHUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONCwi23eKoWqCYlqdaH2fLYTxslLHe9etMrAquJ4/UVE6WXmJS1VM0tZOwpHdc0BQouJg1tDfqkd7dlRi6LPbFaMr1H707fJbEqDghaXwTQhse/T0ID9X9j48tj5ODHd1m299rm3vvxZzpaxwaM81wuqHga2WqCQGfBFCdgmzTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hLFnzUYW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 914D740E02A5;
	Tue, 26 Mar 2024 11:50:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Vv1Q3r0T9g5U; Tue, 26 Mar 2024 11:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711453797; bh=YQSqFoSKslIAbcaScbRhUZMD4A8hZrrFlPhDRUl7ZX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hLFnzUYWhUz892PkZodHyUd8IPNjT+lL1SaZUL+TZZzlAsRDOdByeyOPYG3BVmvys
	 +cRgnTn0A6SY9aw2qnKM23tK/wnvbW11lUje6FQhKWuw/P4tl7xd85/IXDTn+hMV3r
	 r4ysTvjhDE140zt1w4Fr6tGmvLWCCYDbXkl/1Uot+Y7Tj5cme4eqEn5A/p5yWVNBym
	 Wu5ZbYbwfZkf5OG9cTXumtMUaAPvzZtKM8kkhvXNpxf8I+gJVep8LRbMu6oTyTDJVg
	 5Ost+Z6PaCOfaXsRxc0mwhKXIUozIV3/5any2wmL9n2GqLW4J4/hNwjOWrujxLC4Bf
	 rUqsZ3CnZBOgfhKw05cpH9fOzhuTChPJ0u6WWSuKeM2Ws6ZzJ5uxMiCzgCoCIOxrHq
	 CrWkfT4Kk6R8V+5L2JDd5UG8EFvlt0pxCbgrWGfQSekHs0HnVkMVCfFHpxRC+ficjm
	 Nvgkq5HIGXp7wZMCdLQY6kpGUVjtNg3wljdry05KCYb/udEe2CNIu3yMOYvM/C6a5g
	 i08aQ3SzvKy0LRgA0D/dDQLTX21ASVv7TNYd1soJwmo0K/EVQDzGrCOgMPU4QKEuTz
	 NbS7zV2BvbDLvXM/s+hJwutv3YAt6Y8b7gyZIkf5j8MquXwy5DQbY30ZRwcxr6Nl2Z
	 UmimZ13ua8JGxLQ8UwjIOROs=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5AF5D40E02A2;
	Tue, 26 Mar 2024 11:49:50 +0000 (UTC)
Date: Tue, 26 Mar 2024 12:49:45 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tony Luck <tony.luck@intel.com>
Cc: "Naik, Avadhut" <avadnaik@amd.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86/mce: Dynamically size space for machine check
 records
Message-ID: <20240326114945.GEZgK2WUJRKexfQomR@fat_crate.local>
References: <20240307192704.37213-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240307192704.37213-1-tony.luck@intel.com>

On Thu, Mar 07, 2024 at 11:27:04AM -0800, Tony Luck wrote:
> -	ret = gen_pool_add(tmpp, (unsigned long)gen_pool_buf, MCE_POOLSZ, -1);
> +	mce_numrecords = max(MCE_MIN_ENTRIES, num_possible_cpus() * MCE_PER_CPU);
> +	mce_poolsz = mce_numrecords * (1 << order);

So, on a big fat machine with 8K CPUs that's, what

	8192 * 2 * (1 << 8) = ~4M

buffer?

Well, if you have a fat machine, you get fat buffers too.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

