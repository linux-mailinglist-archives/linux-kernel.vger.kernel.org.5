Return-Path: <linux-kernel+bounces-123433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D85989088C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6EBE1C29191
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8630131BDC;
	Thu, 28 Mar 2024 18:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qtqHVRfJ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562C3131E59;
	Thu, 28 Mar 2024 18:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711651678; cv=none; b=rCGszEKag4XiaHHFS+XO1gEze212qVonkE6oCA2O7F/1WvHuoBZ2PgtnjCxUyBXKlo48o96YPzRQ4MKsj9kY58hQZqBhb9lqVyiUAkY49mkXl9llV+RGl7awpLNPaRFZuLfCXsrdR50ccxXE6EaNyTdnR4sSrBu+bY7NJlJE1bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711651678; c=relaxed/simple;
	bh=g6StRBHsTVZSxHL0TornCMnMWzf+XeBT0TuciQlLyIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gp7bWXA1Lx5mPm6mkK2WLa7z66z1JODsxPG3mJDT2ILhEapguBT1+R6Jn30oBs7yHN1UJkEWPQ3p7905ydTGR3TyfJu485Fp+s1jkViL02qTEiHG+JhXLewP3KGPOikVSHLg8a+Quq1eOOEvzErT9S0tHagQjdt+1verhXQeooQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qtqHVRfJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xlwUW7hO6KLAS8sHng2ia5d8RT6xl+DwoE+2+h3+WD4=; b=qtqHVRfJvYEAIKUu+9WiDZ7IZb
	81d2puBqVN+HP6ywT6bbPAZhFgjp1qFYzN7hrr7AFC/7gQmaDLjH4iotqGvmv//kP8MWdP5H96+NL
	U7Lx3Vg7qNKbkNjGQB4DBBFZwgcPGLKGud4uMHILSAWshNjU7HciQzl2UAeOQ3stVuOF87ZjdLxo/
	xbs2iaXPHruEsCsB5oZePd9LMH3UW2834ZrrakQcZGRMV+7aKcKaVHB/GVY/VX6sSdtX9S2z4NuD1
	HRh+5f+b6gEImbDxWcEX5Ugh9RMK2CC3QMGG2IDSdXdnDvDiNePmx06s8U+h75xelPOVA3puG9zOT
	cRDKizTg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpun4-00000006xdZ-0ZW0;
	Thu, 28 Mar 2024 18:47:54 +0000
Date: Thu, 28 Mar 2024 18:47:54 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org, linux-mm <linux-mm@kvack.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: next: sh: mm/cache-sh4.c:250:51: error: too few arguments to
 function 'folio_flags'
Message-ID: <ZgW7WhTBcDX5Fl81@casper.infradead.org>
References: <CA+G9fYvB6unkhzFomVcg+M14Cc7xSKkzhMuXaWqZQbDej_aduQ@mail.gmail.com>
 <20240328114612.d60b7ad4eb552281bedbff10@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328114612.d60b7ad4eb552281bedbff10@linux-foundation.org>

On Thu, Mar 28, 2024 at 11:46:12AM -0700, Andrew Morton wrote:
> --- a/arch/sh/mm/cache-sh4.c~sh-remove-use-of-pg_arch_1-on-individual-pages-fix
> +++ a/arch/sh/mm/cache-sh4.c
> @@ -247,7 +247,7 @@ static void sh4_flush_cache_page(void *a
>  		 * another ASID than the current one.
>  		 */
>  		map_coherent = (current_cpu_data.dcache.n_aliases &&
> -			test_bit(PG_dcache_clean, folio_flags(folio)) &&
> +			test_bit(PG_dcache_clean, folio_flags(folio, 0)) &&

Yup.
https://lore.kernel.org/linux-mm/ZgRqLDP7yVCT2dnh@casper.infradead.org/

