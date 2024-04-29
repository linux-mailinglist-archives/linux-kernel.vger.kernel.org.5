Return-Path: <linux-kernel+bounces-162343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C8A8B5996
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3046B1C24B09
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D01C74BED;
	Mon, 29 Apr 2024 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="L7Sx456c"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78A573173;
	Mon, 29 Apr 2024 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714396380; cv=none; b=ZV9tafPf3rUKvtnaFbpCBInfvcX7RNUpZQPw90e2dqOxFTKYLeVflCu6JACg4/2aNVJpVlrA2Cs4u8K5XB9Q2tz5J+K9rJ3c0ggwSQ3G3sHV7ZOHNXO5spmXrjQdX54JGqaD9l/+V2eCSQ1btCliag19D3a2vQqofnFTCS+KJTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714396380; c=relaxed/simple;
	bh=Gjv6GQm6tKIEB1wure+MOiP8JZurMkwVMIydiu6f3hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqpyKydvtQ1SAIM/jk1wW0YllNkpUnxCPV9yHTRhT5SFed7iAz/NSXs2ep9ZgSWEm1jD1QLp6fkrycEhir8x9nujyoeV3EBCACgKUxG/BZwC51aOHsmvRJBVcvqcNWJGK0KAiD3sgeP92HUhU7utk206E6HQK9srmLvsWqUT/XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=L7Sx456c; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8808640E016B;
	Mon, 29 Apr 2024 13:12:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9DIf3t46BTH8; Mon, 29 Apr 2024 13:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714396372; bh=pF5fwzrWofzHeRqjfHcuUa6czVPYaKvsLOZtUlu8jHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L7Sx456cMy8w6aCr4DVOS/3/IbTz82l3iPLfW7pBsMhtwvxb+NNWWDU+2k5YyOhXv
	 JKlN9cVN0ysUTBl/ARoiomeoNHgY1mXf0XVU61BoXjGBnK1UrAUlvWwwFtIHHwjk9Z
	 rXAAQqO8Gu2zFUv+NPlRW1a3FjiH9f8b/WbmetQpM0A0Ubsup/MEEd0P+5eIhXQCgP
	 YjXwgfGlytPQIPbWh/q5op+yq9HvRmBgIdezxgBcyNARlYkl3Z142LownRJ9ipLw2f
	 oONAZ9Zhb9LkmGWVprR23CI2W820WN8bUKanCuuP2E850vYjlW/PhfoKM+kmiiLOGz
	 dkbghADD9J+6VBRrjQDYGfq1wBK7lhemfuAu4JR7f+8ZCdEI1ev61IqqQzoZbkKJ7f
	 sIl0BtVxBeH4sl5RtbeCPt4n0SglxSIKwmAivQwP317ugDMn9MObrExdbWo1x7bhFb
	 MbTrf+8nZQWVG2fVmmva7twF9srz7/3qMjVU+BqktOxJY4KhdtUgm7arMtkkaTWQwB
	 r0L2+w8gtw5aIiFRItyQzlCljOUXEykEaNLW4DWQWnlBtJ/2cogeSS5YrneDpiwbMV
	 BNgj2TtH2s7oGENT58lLBCjCn8AqrKlpYWYMOSiNNdnbeWKz0MKr5r7ApCoa5Zxsg+
	 R/mbMbNdPR3ZmfKAI41yO9Fc=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B60EE40E00C7;
	Mon, 29 Apr 2024 13:12:45 +0000 (UTC)
Date: Mon, 29 Apr 2024 15:12:40 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, Avadhut.Naik@amd.com,
	John.Allen@amd.com
Subject: Re: [PATCH v2 08/16] x86/mce/amd: Clean up
 enable_deferred_error_interrupt()
Message-ID: <20240429131240.GOZi-cyLh2OhRrNTWM@fat_crate.local>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-9-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240404151359.47970-9-yazen.ghannam@amd.com>

On Thu, Apr 04, 2024 at 10:13:51AM -0500, Yazen Ghannam wrote:
> -/* Deferred error settings */
> +/* MCA Interrupt Configuration register, one per CPU */

SMCA?

>  #define MSR_CU_DEF_ERR		0xC0000410
> -#define MASK_DEF_LVTOFF		0x000000F0
> -#define MASK_DEF_INT_TYPE	0x00000006
> -#define DEF_INT_TYPE_APIC	0x2
> +#define MSR_MCA_INTR_CFG		0xC0000410

You do see those other MSRs' prefixes, right?

MSR_AMD64_SMCA_...

Is this one not part of the SMCA arch?

> +#define INTR_CFG_DFR_LVT_OFFSET		GENMASK_ULL(7, 4)
> +#define INTR_CFG_LEGACY_DFR_INTR_TYPE	GENMASK_ULL(2, 1)
>  #define INTR_TYPE_APIC			0x1

Ditto for its bit(s) names.

> +static u64 get_mca_intr_cfg(void)
> +{
> +	u64 mca_intr_cfg;
> +
> +	if (!mce_flags.succor)
> +		return 0;
> +
> +	if (rdmsrl_safe(MSR_MCA_INTR_CFG, &mca_intr_cfg))
> +		return 0;
> +
> +	return mca_intr_cfg;
> +}

This is an overkill. If we add a function for every MSR we're reading...

Do this differently: prepare the value you're writing back into the
INTR_CFG MSR once, save it into mca_intr_cfg and then write it on each
core at the end of enable_deferred_error_interrupt().

And make u64 mca_intr_cfg static global to amd.c so that you can refer
to it from outside of the functions and then you don't have to pass it
around as a function param.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

