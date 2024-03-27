Return-Path: <linux-kernel+bounces-122107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCDA88F1F2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF2E1C2F593
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE9A15253A;
	Wed, 27 Mar 2024 22:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="knSnfJjv"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B025114C5B1;
	Wed, 27 Mar 2024 22:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711578946; cv=none; b=nj50usd/HdxFhbyOvG4Jh/zpq9n8atFE63NBi/StX7VeQ2dugPiFM5QNFBeYrXh4esqguShd1+4HOWJJ94rRBtDKCyS3E0fqhETilMEbSuhgNeZ/VhXlLUIU8K2OVO14mMnAODXXNkydeHV3NfmjaKHPz2dmQ+bOq5z6tnQ+QEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711578946; c=relaxed/simple;
	bh=Oe46liavg6s+uxvOvEuM+L5AqQ2CWTc7CeWZoAczl7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9+/OHtHLGTZT3iVprYbMwkBgsAJ3IWeDTFxTkguqe+E/0+YjdR+xCaW/pQiojYcMsGpRu61brAIwISOkzdK6/l8U5J5T3LYMJP2qx/5A+pmM/nWOpQXb9Z1UncLMDVyUhJKYDeuwD/TVoc9r5AJyeOr83F6zLcvISmvN2QjvyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=knSnfJjv; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7A82A40E016C;
	Wed, 27 Mar 2024 22:35:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id biQjnQ8wDA07; Wed, 27 Mar 2024 22:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711578938; bh=kQxB+RTMdVrqYKpJ87igtdmlhA/0fWug/WgMwwj9rmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=knSnfJjvxDZXkr6KkrUJzMVf4KJKelEYj9ijRt5G6YGNBIAImBMEeXD8C55emh28r
	 5or4e8raC6lYYzfiy/28o3cF4Y0mUCDMBe+0+1lVzc7d6xadV9akXMExK8ru/mys87
	 yKXM7paUYIat0op8ziiXA+8tk1/GBH+THthWO0F9UqV/KtUCRNRDq/PbzOkPNeUUcw
	 wid9wK1m4HBnFeYueriRwmnWZHbvWDiXV7sQOsI6XO8GUW4n/k//WU65w4geslCwlj
	 /+GLGym1PnFOxNx0TfUzzXqKM3xVh1XL7pW7VGwZNGY0dQ+B12D0AuyGE10HnaK6i0
	 ZKEfpmC5O8UDVBrpI+vb9QMh3e/Z9/p8ujGTfU8pL7dnqj4DIErbH3fl/UhT/zcFlw
	 AnfQqNaC5d/H6VnjazUigKrz+YMFLgZWnRvRZRIOClRyA6HrkjRCbxQxZ/N+HowTbz
	 AabE74uhSBLuVe7t2SgoWkEWRV2d5I7qoDCwReC6kbmfMegy67oBBo8zMRnRKaqhig
	 o6A5hTIZjoFi04qqigGVMi+dkub/UY0S5VeN6mSgtSk6U1jTCzRM6omIR/ueQdioQy
	 my2yW8vpjMj15YjTAZK32PB69r4eqY2lCQEmT3eLQcz7DCKRSTffQhY6WAanDgDHLp
	 wy7KrqG3ClD/kUh6Rz5vutvQ=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7FC7440E00B2;
	Wed, 27 Mar 2024 22:35:28 +0000 (UTC)
Date: Wed, 27 Mar 2024 23:35:22 +0100
From: Borislav Petkov <bp@alien8.de>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Avadhut Naik <avadhut.naik@amd.com>, linux-trace-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, rostedt@goodmis.org,
	tony.luck@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
	yazen.ghannam@amd.com, avadnaik@amd.com
Subject: Re: [PATCH v4 2/2] tracing: Include Microcode Revision in mce_record
 tracepoint
Message-ID: <20240327223522.GDZgSfKj1CVyZ0zfxs@fat_crate.local>
References: <20240327205435.3667588-1-avadhut.naik@amd.com>
 <20240327205435.3667588-3-avadhut.naik@amd.com>
 <67ba2ece-6b46-4ae1-a944-a38f84360d0f@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67ba2ece-6b46-4ae1-a944-a38f84360d0f@intel.com>

On Wed, Mar 27, 2024 at 03:31:01PM -0700, Sohil Mehta wrote:
> On 3/27/2024 1:54 PM, Avadhut Naik wrote:
> 
> > -	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x",
> > +	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x, MICROCODE REVISION: %x",
> 
> Nit: s/MICROCODE REVISION/MICROCODE/g
> 
> You could probably get rid of the word REVISION in the interest of
> brevity similar to __print_mce().

You *definitely* want to do that - good catch.

And TBH, all the screaming words aren't helping either... :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

