Return-Path: <linux-kernel+bounces-95518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3AE874EC8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E17BDB25422
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D725812B141;
	Thu,  7 Mar 2024 12:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bylKT12q"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DB712A143;
	Thu,  7 Mar 2024 12:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709813821; cv=none; b=o+9hfjqcE5fGkmUW1v1p4OrQOrmC9ZrAKpev+EbUnZJeC/SUnu/lgzenjRVUU+aDXOcDTAAcPh8ZUEa8aCUUEnfnZMusKoxI/l/PLiv+s1+oxrlg60XE+ezqMC+h3r8nR4DY614W+na9yTMRuBaE/Whtl1q/vyKtQlVGKjg+lOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709813821; c=relaxed/simple;
	bh=4UjKhO2St8Z8PM74cHTkCT8nSA7UO5acrjL3xp50NJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7Xp1dam4F0DceZvYQw0VxW6BHawKQC6tHRfODwV8VI/ZXTQ5AltEVZ313bkSNxLyAwa5vB9nqvODsdfcbEj3j6rMsU8BzADzsXFb4/b60rmDPe1aT1zKqNn4wff1W9Yt9dE+jx44x8fV7OLbYltQFSjYcwHYFvNfcq6nXXXNys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bylKT12q; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B226F40E0174;
	Thu,  7 Mar 2024 12:16:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CW9Ueswgo2ad; Thu,  7 Mar 2024 12:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709813807; bh=o6ERHtHohBl+uhp2qXm5zLwc6fLO22uHxqSTgoioRzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bylKT12qv6XOHKOkgxzJ8Hjec9OBdSrv/hRf9mB6qmSaS8GTEPMSBP5YlE9s9qolB
	 oQ1f2BTHnqpaVBw2rB5JctoguoA1SErh41QVZAvrnb4HbJJw/soB3wTiCSajKHn3ZQ
	 9JSWitZL1a4BM6NgE3mFqUhHHs+TGvvk3DvYF/GxXQdMc9+aMKpI8HLgrCiSRPXDf9
	 v8cHRo3bBhZkbOsEhV/YIgvu5nFuTlPLaJUZuMaUni8/FAj3w7VTlX0ndf1KfOvJ/p
	 n1rIogMv3YR8CSTEaR0Qk6Buxmc5Wr27rBrEkrG1IeDJ+WEzO7Pce+btrWNYQLza2g
	 BbafIBk+neQLKnqy0zZfFPAWazdYCgG4Ml7lAmrTqwFz2gcrz795q57jnyYAzmTpyO
	 TMhGAzfN4UYH6JX3fsgGbEWr2Y77i+MRrKNgaS7qfMxsvsMS7AJCxBQRVKncaUeDvz
	 lixM+I4bj85X/fgHX9yKk00Y6DqClcZQRt4KgrXA7fSUy31lulWS2ZW2kccX4aSFqc
	 gmLbk7cV5l8E4g18CxHaLikfqlxr+p7rQlk0XS2I3mszFkfweovEnTQXPA1Rtj+sHX
	 PvnmhKqWDEKeZkX1R6ORpMhs+V0qsPXM3qNB1bn5D4lBLF+6xrVJwOfODXJp4dQ2Q7
	 W91PTnaM05xuSyFNzFDC7H0E=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4267640E016C;
	Thu,  7 Mar 2024 12:16:40 +0000 (UTC)
Date: Thu, 7 Mar 2024 13:16:34 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tony Luck <tony.luck@intel.com>
Cc: "Naik, Avadhut" <avadnaik@amd.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/mce: Dynamically size space for machine check
 records
Message-ID: <20240307121634.GAZemwIgbKKJGaUVFg@fat_crate.local>
References: <20240307000256.34352-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240307000256.34352-1-tony.luck@intel.com>

On Wed, Mar 06, 2024 at 04:02:56PM -0800, Tony Luck wrote:
> -	ret = gen_pool_add(tmpp, (unsigned long)gen_pool_buf, MCE_POOLSZ, -1);
> +	mce_numrecords = max(MCE_MIN_ENTRIES, num_possible_cpus() * MCE_PER_CPU);
> +	mce_poolsz = mce_numrecords * (1 << order);
> +	mce_pool = kmalloc(mce_poolsz, GFP_KERNEL);
> +	if (!mce_pool) {
> +		gen_pool_destroy(tmpp);
> +		goto out;
> +	}
> +	ret = gen_pool_add(tmpp, (unsigned long)mce_pool, mce_poolsz, -1);
>  	if (ret) {
>  		gen_pool_destroy(tmpp);
> +		kfree(mce_pool);
>  		goto out;

Might as well get rid of the out label too since you're not doing the
error handling pattern of jumping to err* labels and then unwinding. See
diff below.

Otherwise, patch looks ok to me, if we can test it quickly with all
possible scenarios and Linus does a -rc8, I probably can take it even
now...

Thx.

diff --git a/arch/x86/kernel/cpu/mce/genpool.c b/arch/x86/kernel/cpu/mce/genpool.c
index 42ce3dc97ca8..cadf28662a70 100644
--- a/arch/x86/kernel/cpu/mce/genpool.c
+++ b/arch/x86/kernel/cpu/mce/genpool.c
@@ -126,25 +126,24 @@ static int mce_gen_pool_create(void)
 	order = order_base_2(sizeof(struct mce_evt_llist));
 	tmpp = gen_pool_create(order, -1);
 	if (!tmpp)
-		goto out;
+		return ret;
 
 	mce_numrecords = max(MCE_MIN_ENTRIES, num_possible_cpus() * MCE_PER_CPU);
 	mce_poolsz = mce_numrecords * (1 << order);
 	mce_pool = kmalloc(mce_poolsz, GFP_KERNEL);
 	if (!mce_pool) {
 		gen_pool_destroy(tmpp);
-		goto out;
+		return ret;
 	}
 	ret = gen_pool_add(tmpp, (unsigned long)mce_pool, mce_poolsz, -1);
 	if (ret) {
 		gen_pool_destroy(tmpp);
 		kfree(mce_pool);
-		goto out;
+		return ret;
 	}
 
 	mce_evt_pool = tmpp;
 
-out:
 	return ret;
 }
 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

