Return-Path: <linux-kernel+bounces-62152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA62851C5D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23F4EB2B314
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E76146450;
	Mon, 12 Feb 2024 17:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fslj4uOF"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660074D5BD;
	Mon, 12 Feb 2024 17:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707760470; cv=none; b=qVPf+Y5kgGivP8tbLguC6KpS72MS/ex+9F591oP3BRoIWSy5V3j1FFkISIlTP1UTCibNcCuMqwsoSjpvPjlymRDiNKi+g9CFfASJ90PlMkGvQMkinx/OoktET5QPbYcf8K6jZNBrpNvwOkiBWb/RcBiKuGv2qYnsG2v+1AzLXl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707760470; c=relaxed/simple;
	bh=XVTqa3OXJq4FEbUA62BIiVPd1am3XQEvHCWzVgHfLSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKx5y+4W4oqd+WtHueGqvXUGIKPr8SewIuS0+97HUsZfit2TevaDtaW8P5DG3tWTX4HKCWcuO9dapAgK7Ta2K5RAoLGTY7/BW2HUM2f8PLIeddJ0UY73/iJreesRGczzoqHFV5wqfZ9upOomQAM18BkFCUcBpOspokJqleU9KfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fslj4uOF; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 18D5840E023B;
	Mon, 12 Feb 2024 17:54:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ik5WyJfVS0Ur; Mon, 12 Feb 2024 17:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707760462; bh=cjvvoQuxUzZDExzC2BPPB8M+U4lmDA4BCUO/WyuOHuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fslj4uOF5kcxIgYZJjPTlzeow4+3xijX5mtpsY/erjBE5wuyQFoHzDXkQCOqXecQX
	 TnQokMQcS1iluBVCoNXKnSSsSbXbSRbDd3rQggRWM4U7jEFyHPnv9U6JvbGYQcvu8I
	 xtE9/cKCj7S6GbKVBiPLgScLDKTpPHXhK1A0845xITxamunGc6kpgT0qeawEyy9vjr
	 Y6lbnw6gYWfkkqhNuvxt43vZGUyO7K+toHaHG9OP0x0BaSUc64oO39VKgQCL6IKX+b
	 7iy8xquZ1XvflqPc0jI8wdKDkndDQsrx4hTXx8fpmdjCCG3V1zK7OW2Tl0BSckalmc
	 RiVAGgjt/lz3UjSKBqT8uKDD47DfXENTNXxTQAyJa0hyBDnkzh6sPe+fXB0ZwI3cIg
	 KpnO5sqVLLfFwHUmS/3QrLmVdQ8Jb8ulp0agU0BzNhf6fAuccgh+nQ34jK1Yn75MaZ
	 NOBSyaOaxCj//WDr4Z9yOAHVD7F2WXDXmbf/Y8mfeqPJIQCK0sLPcRS4ki2rBevR2o
	 rPZbWDb4I0LuyJNBJdN4sDHUT+qm2WqLBeyn7j+Gil0vWalGO6QXWqDDMDKE/OdEsx
	 Z/1bjdeYTdQOtgcSYJ4bMg0QybwjUYWjFybQ9vscYF62S9OhypZQ8LqmhJ2fAfz1r0
	 M7K53Zova2xAHh5Tr05eKnGk=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 871DF40E01A9;
	Mon, 12 Feb 2024 17:54:14 +0000 (UTC)
Date: Mon, 12 Feb 2024 18:54:08 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Naik, Avadhut" <avadnaik@amd.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
	Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Message-ID: <20240212175408.GIZcpbQHVjEtwRKLS-@fat_crate.local>
References: <20240209200920.GFZcaGcOr757W9O3IG@fat_crate.local>
 <7a4945b0-322a-444e-a0ca-860a062a49c3@amd.com>
 <20240209205111.GGZcaQP1gb6C9m0WZB@fat_crate.local>
 <5DB0FF8D-C6DA-45DC-B287-201A9BF48BDA@alien8.de>
 <75ddf61d-8dda-47fa-9da0-24221feb22a2@amd.com>
 <20240211111455.GAZcisL09LeFPWa2EI@fat_crate.local>
 <774e7ca5-154d-4ca4-bc4c-2f945c20b938@amd.com>
 <20240212085801.GAZcndma4UTPtKm33e@fat_crate.local>
 <20240212093246.GBZcnlvkPKDC8C7rv5@fat_crate.local>
 <SJ1PR11MB6083B3511D18787BE823AB2CFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083B3511D18787BE823AB2CFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Mon, Feb 12, 2024 at 05:29:31PM +0000, Luck, Tony wrote:
> Walking the structures already allocated from the genpool in the #MC
> handler may be possible, but what is the criteria for "duplicates"?

for each i in pool:
	memcmp(mce[i], new_mce, sizeof(struct mce));

It'll probably need to mask out fields like ->time etc.

> Do we avoid entering duplicates into the pool altogether?

We could do

	mce[i].count++;

in the same loop.

Dunno yet if we even need to state how many duplicates are there...

> Or when the pool is full overwrite a duplicate?

Nah, not overwrite the duplicate but not add the new one. Cheaper.

> How about compile time allocation of extra space. Algorithm below for
> illustrative purposes only. May need some more thought about how
> to scale up.

Yeah, it is too static IMO. Especially if NR_CPUS is a build-time thing
- needs to be based on the actual number of CPUs on the machine.

BUT, we don't have an allocator yet.

So we end up allocating it there on the heap.

Unless we can do something with memblock...

But then this still needs code audit whether num_possible_cpus() is
final at that point. Because if it is, that would be the optimal thing
to do a memblock_alloc() there...

> [Diff pasted into Outlook, chances that it will automatically apply = 0%]

How you even do patches with outschmook is mindboggling :-)

At least use Thunderbird. That's what I do for the company mail but then
again I don't even try to do patches over company mail...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

