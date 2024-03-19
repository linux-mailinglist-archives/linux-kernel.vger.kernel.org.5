Return-Path: <linux-kernel+bounces-107549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C61287FDF6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4DF31F22887
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A4E4085D;
	Tue, 19 Mar 2024 13:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hXV5zmdt"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8575440842;
	Tue, 19 Mar 2024 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710853274; cv=none; b=W4jKAMyhP0gomsLX4shvWwg7zAP3gWvIpRQaoAk2CJ+kd466nDR0xRq1ixSEE7eEd04ldOuQphaxQ7XspXsrr/P0I4xqB9jNsyCgpWNtSyeLUe/nZSBVvpHRYjM3aA8y8blWDsEJDJEBa6rXNkSrCElzt1j8k8AvN/uf6qcVuFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710853274; c=relaxed/simple;
	bh=TgEfrvfBUBL4IVOuxBhr0pKo8YicUVFhJKL/8ekpfa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hY14nqvSYviqnjJ34Q8PL4xw7RsQD09Cnim8H/BvbshV6ZSXN70QcXDcgpw4tritXkMvXvANqh9VowyG2E5VAHgnUQ5/3RycsZ4rzeQm/gwmPc9QDJEZH/LJafbz0mHLBv4NQkY9fwGnXDCflaMvWaNiNyc0Dowi6sBcpRZSzmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hXV5zmdt; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 61AD140E01AB;
	Tue, 19 Mar 2024 13:01:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id e5CT8tOpLMEZ; Tue, 19 Mar 2024 13:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1710853264; bh=lae9HIcBgJTSZyyH9wjSWTukez5Rnf/xjToMCRJgt/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hXV5zmdt0GUtQ1qGZk9LrGHR9YNUib4w40WSwWQH0b/BYDmRergqnN6OyGJnZu6JD
	 q+RWDF9nko9QzjxBNO+Sb621CibpCuIoNdd6s25akbviXYNFodPVvpwcan8Lsfawr0
	 DS60TSnCXwPu87GeUtzRKxS2LOnsVbOu+ADE1XD29JoTWoK/71y+YRaHry87CzpZAM
	 hZ6L4Ueg1Y3v4+DqjEZ0Nt2rIt2k/PXeR2aHtqpK/DBs6MTtjCT8C0BQ08FN5UYryw
	 ezJr+0M6icOOffsDGPneL7heW/oa57m5UOygNuhjJpivbVTd7OqqBaOD3NZhoqlTsd
	 qrTdhZK7VW3CBM+8pR/2CQ6LOIkZ4X32huTdblsqZQ5++xaJUFgxeHrgUo09apc7ji
	 lKOgPMNADZe2ijrWiD8dDtC/DQtL3Kq71ohJfJtdZV4PIQdRJCaIBHtZ/WTN02RTtm
	 YeFyIftYXc5erVsp4MCk8yw/U7JgAQnSlOHtQbn+d16FaAhL88i4T99yxl4dMnSCI+
	 5p97qpGfyvx0SjFsWOF6dkRTpY7lgXOZ1KvT7pgKO9XgYl2R8H7cN5EzeXkRt6Vxn7
	 VjTX5v6qHZxl7OcwkBOylTBEsb2c/W/dcFhp7sDOHHDO6JQ8Zcmv8ezKQwxGSczJ38
	 a+UsL0oQT45NJ8v4pWEuleQQ=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9D67F40E00B2;
	Tue, 19 Mar 2024 13:00:59 +0000 (UTC)
Date: Tue, 19 Mar 2024 14:00:54 +0100
From: Borislav Petkov <bp@alien8.de>
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Subject: Re: [tip: perf/urgent] x86/cpufeatures: Add dedicated feature word
 for CPUID leaf 0x80000022[EAX]
Message-ID: <20240319130054.GCZfmMhp-7Qa0eDaTC@fat_crate.local>
References: <171084456107.10875.4104379273551108641.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <171084456107.10875.4104379273551108641.tip-bot2@tip-bot2>

On Tue, Mar 19, 2024 at 10:36:01AM -0000, tip-bot2 for Sandipan Das wrote:
> The following commit has been merged into the perf/urgent branch of tip:
> 
> Commit-ID:     f0a22ea644717fa21698a32d342fcd307e53a935
> Gitweb:        https://git.kernel.org/tip/f0a22ea644717fa21698a32d342fcd307e53a935
> Author:        Sandipan Das <sandipan.das@amd.com>
> AuthorDate:    Tue, 19 Mar 2024 13:48:16 +05:30
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Tue, 19 Mar 2024 11:23:47 +01:00
> 
> x86/cpufeatures: Add dedicated feature word for CPUID leaf 0x80000022[EAX]
> 
> Move the existing scattered performance monitoring related feature bits
> from CPUID leaf 0x80000022[EAX] into a dedicated word since additional
> bits will be defined from the same leaf in the future. This includes
> X86_FEATURE_PERFMON_V2 and X86_FEATURE_AMD_LBR_V2.

That CPUID leaf has a whopping three bits defined and the rest is
reserved. You should do a dedicated leaf when we use at least 50% of the
bits in the leaf. But not like this.

Please do simply another synthetic leaf and put your bits there.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

