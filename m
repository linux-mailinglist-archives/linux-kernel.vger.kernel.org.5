Return-Path: <linux-kernel+bounces-155781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B33F98AF707
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B521F23E14
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8FA13FD67;
	Tue, 23 Apr 2024 19:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="LsU0H/N0"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E871213DBA7;
	Tue, 23 Apr 2024 19:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713899226; cv=none; b=jy3fyllLgkFZQTRXnlKmFT2PjTW9g8JE0VMujWLKnUVlvZuOhMJ+x/aWVM5XWty/7zJ5wZfZZCn4f2fDsnR/9+6X8No7jbO3riqysjnPbpmPSh+2R1mXZ7mjwHNLXodIMvUWq8edsrXWc8d5CjkDSI8EzzDvCWcajAy+3GX9WT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713899226; c=relaxed/simple;
	bh=PNtB5E/dSzTUnrM1XdzP2BwPgmnkeAYe7G+u4YVpH4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcHnQUQHh1u9gW/N70edWN12TowffPajr2ApfHq/zkSIVA8zf20XWZSmmv+idkPSu63hKzVICPbSYfp2AKxfaClYPglHdxi1BCepI8UA6EdJBJF9NCYMC+wtWXs5MQ0aUgRJIsyE4XX2z70UW9Di/wkCTh4VPtSfmfJy4glcjOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=LsU0H/N0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EABF640E0192;
	Tue, 23 Apr 2024 19:06:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2XDFqA5ueUU8; Tue, 23 Apr 2024 19:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1713899214; bh=G32JCLi6OGGQOH27jEZfa4k1/difhgj3x88QRycmcVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LsU0H/N0kUd2yFMGNvS289L5pzUQSBCvgiqKztgmX6u1YugO/DYcnYdDs5acJELVf
	 cF4oXMKZs/QokBBR1qCtUbrJYO69cMlMsccICGqlH2pKKD98DQ3zp6Gu63ynh4a25W
	 lVjgN+XVdYC6KHPZk6YijXj7VdNIe8nIKBoIR6Xy8F3guRUm8Nk3aENzK3zMoTpw4Q
	 101pO68Pb7SGBBE9kY5HiVrDHgLCnGB7dGVjBI6gUL6G93DB14ynjObccqldXTZIhP
	 +fJ6J4X9lc4C8wKT+4BY4fMpeaDQHSR+jWemcXQyBh92Lccpe3KVw5o7leettkkWtg
	 b0C+8T6WugwWDNCOGYDexM9ZuAXC74Y6lcv5CTYqLNxVBgcICvtad43ZDvvAFUIZYx
	 jmWc5dzlJApe9d/3ln5Fi8FbKkm2RklRx/wWQovH0xpW5od/yzsoPc8IzOQf3+DJmy
	 OODGcGdH171guKOKZ4B0599Bl15qmxsbeSZTj3XscGa9FsrtI8J3+2EgseA15ydzu9
	 8Uv0YvmZCqR3tG7zY7jKbta+GvBW11l0/sh00XqXUjgK2/keJanJwoElOz0ectiVBd
	 taOr29kzLf6ZGvzhtM4wsguZ8oGlDBayc5FM6X3ywW0i/F+aS5gc9QCvH9k4suMnaV
	 +W405xazP7hFxhP45BVprg+M=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BAFAA40E00B2;
	Tue, 23 Apr 2024 19:06:47 +0000 (UTC)
Date: Tue, 23 Apr 2024 21:06:41 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, Avadhut.Naik@amd.com,
	John.Allen@amd.com
Subject: Re: [PATCH v2 05/16] x86/mce/amd: Clean up SMCA configuration
Message-ID: <20240423190641.GDZigGwXXEPeDnfOsr@fat_crate.local>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-6-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240404151359.47970-6-yazen.ghannam@amd.com>

On Thu, Apr 04, 2024 at 10:13:48AM -0500, Yazen Ghannam wrote:
> +	/*
> +	 * OS is required to set the MCAX enable bit to acknowledge that it is
> +	 * now using the new MSR ranges and new registers under each
> +	 * bank. It also means that the OS will configure deferred
> +	 * errors in the new MCA_CONFIG register. If the bit is not set,
> +	 * uncorrectable errors will cause a system panic.
> +	 */
> +	mca_config |= FIELD_PREP(CFG_MCAX_EN, 0x1);

Can we please drop this cryptic crap?

	mca_config |= SMCA_MCI_CONFIG_MCAX_ENABLE;

if I trust the PPR.

> -		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status = !!(low & BIT(8));
> +	/*
> +	 * SMCA sets the Deferred Error Interrupt type per bank.
> +	 *
> +	 * MCA_CONFIG[DeferredIntTypeSupported] is bit 5, and tells us
> +	 * if the DeferredIntType bit field is available.
> +	 *
> +	 * MCA_CONFIG[DeferredIntType] is bits [38:37]. OS should set
> +	 * this to 0x1 to enable APIC based interrupt. First, check that
> +	 * no interrupt has been set.
> +	 */
> +	if (FIELD_GET(CFG_DFR_INT_SUPP, mca_config) && !FIELD_GET(CFG_DFR_INT_TYPE, mca_config))
> +		mca_config |= FIELD_PREP(CFG_DFR_INT_TYPE, INTR_TYPE_APIC);

Ditto:

	if (mca_config & CFG_DFR_INT_SUPP &&
	  !(mca_config & CFG_DFR_INT_TYPE))
		mca_config |= CFG_DFR_INT_TYPE | CFG_INTR_TYPE_APIC;

Plain and simple. Not this unreadable mess.

And use proper prefixes with the register name in them:

SMCA_MCI_CONFIG_

or so, for example.

>  
> -		wrmsr(smca_config, low, high);
> -	}
> +	if (FIELD_GET(CFG_LSB_IN_STATUS, mca_config))
> +		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status = true;
> +
> +	wrmsrl(MSR_AMD64_SMCA_MCx_CONFIG(bank), mca_config);
> +}
> +
> +static void smca_configure_old(unsigned int bank, unsigned int cpu)

Yah, at the end of the patchset there should be patches which remove all
the _old things. Not in a different patchset. You can split things
accordingly.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

