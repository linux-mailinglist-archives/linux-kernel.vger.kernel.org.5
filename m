Return-Path: <linux-kernel+bounces-107730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DCE8800DE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C7561F219CB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71F7657CC;
	Tue, 19 Mar 2024 15:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IIuPviuy"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF431EEE8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710862911; cv=none; b=JyY7g3TlhvLxxbYArgiKW0j7DHDz8ApNJT7IZLnuZ4l4jXcxFSDwFz3jtJ01E8ted3Dh5wgLsIcUOYZc0cdaGL/eBndKGc9+JFTSFsLns9ktI4nA0mAp4FRgk1Rmk/B91ONlYBOHpJniqZj2DdmGgn5erXQCBN8a2dS4TH7sYek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710862911; c=relaxed/simple;
	bh=fYx1qaaVkTFuusi6tTBVfZVXSX+5FNrh+peQVC300jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNNcoUj7u4ECZoQoyY777rFWvJCSCSPAgxUzLFw7nQ1ZAo8xV4YwPlN+d9yH9zE/wD23K1KcaAFOONB1tY3pPoGbPPifRKESGpZja0tu7udSTkHgGAK0G6p9dWcXDetVnGG/6enQTOgH29it8sUuELd1jN2OecldmEUY+0oUlLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IIuPviuy; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 209C240E016C;
	Tue, 19 Mar 2024 15:41:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QGXp4B054S_E; Tue, 19 Mar 2024 15:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1710862894; bh=2VAxe83E9a0c3PmycIcfnG0tKGBshoC6swKDBB5p3zI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IIuPviuymWKAB1XT6pKpsS0FW8or1NW0MYrFeXzhKweuz2nQ7Ste1ttkgzbnm2I2/
	 kSNzuY3k1vZ5ZNMIS25lywHjqy7H2Ax8v78OJ1L5a6Io8sW+GVY81S/tOp0izTqmLp
	 ov1KL59MNVabqskOytIAkhAEhhQlVg/OGlzCAos4XiOcWOQ1wjXlOSQA4gV6teQfB2
	 Z9ZYkk5FSdXnaNzpONXMeCTB5W3b1N0jSq9KB6qu9NMIH6cUb1CxBVqUGUYo5NHmM9
	 /xDFaeSeJ6YQ5qvn9rmmaAmhWwbtOHLRAexhhVXtXsWsTW/1tt9Z39ixfjvGn5Iwey
	 UjsdlbDi6PXeHZoDX3jEDsjPcbIRsTPMncf0LCoHVqAJP4jFiIso4utIqPdi0wV0NO
	 ApYwc3MmB/QX1GT7Rjyjh1oPpEKCMwcidB/vTTA++w9FwMp24L9lPc3UVdCUk8vK+w
	 mYrLWuOoDh36ZCvNnlyMqD65+7+MIyvZr8ZdG4eioN6Wfo0joDj6Sw91qNMoRiaLiU
	 OHMEjl6WaZMIaEYEze433FlLOk5L4/NPPWEt10fw6RAmgybUWQ1ydilafuSchK/VqF
	 Mz7rIt51pDeKQi7ZdtUYW8gtlIIX92yM9IkJug1Bor8GgXWYyvUhIu3TRFP+HKhYdF
	 7d4D1bEdb7iC4pCdIwcySRC8=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6765040E00B2;
	Tue, 19 Mar 2024 15:41:16 +0000 (UTC)
Date: Tue, 19 Mar 2024 16:41:11 +0100
From: Borislav Petkov <bp@alien8.de>
To: Kai Huang <kai.huang@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com,
	kirill.shutemov@linux.intel.com, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com, luto@kernel.org,
	peterz@infradead.org, rick.p.edgecombe@intel.com,
	thomas.lendacky@amd.com, ashish.kalra@amd.com, chao.gao@intel.com,
	bhe@redhat.com, nik.borisov@suse.com, pbonzini@redhat.com,
	seanjc@google.com
Subject: Re: [PATCH v2 2/5] x86/kexec: do unconditional WBINVD in
 relocate_kernel()
Message-ID: <20240319154111.GEZfmyF7IuQ5THG0qO@fat_crate.local>
References: <cover.1710811610.git.kai.huang@intel.com>
 <e1d37efb8951eb1d38493687b10a21b23353e35a.1710811610.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e1d37efb8951eb1d38493687b10a21b23353e35a.1710811610.git.kai.huang@intel.com>

On Tue, Mar 19, 2024 at 01:48:45AM +0000, Kai Huang wrote:
> Both SME and TDX can leave caches in incoherent state due to memory
> encryption.  During kexec, the caches must be flushed before jumping to
> the second kernel to avoid silent memory corruption to the second kernel.
> 
> During kexec, the WBINVD in stop_this_cpu() flushes caches for all
> remote cpus when they are being stopped.  For SME, the WBINVD in
> relocate_kernel() flushes the cache for the last running cpu (which is
> executing the kexec).
> 
> Similarly, for TDX after stopping all remote cpus with cache flushed, to
> support kexec, the kernel needs to flush cache for the last running cpu.
> 
> Make the WBINVD in the relocate_kernel() unconditional to cover both SME
> and TDX.
> 
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> Suggested-by: Borislav Petkov <bp@alien8.de>

Well, I suggested what you have in patch 1 but not this.

You can't just slap tags willy nilly to patches.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

