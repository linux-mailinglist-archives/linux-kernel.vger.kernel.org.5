Return-Path: <linux-kernel+bounces-51013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AB384850D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 10:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01E481C21D9E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 09:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F5D5D49F;
	Sat,  3 Feb 2024 09:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="j283KEeP"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C93EBE5A;
	Sat,  3 Feb 2024 09:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706953156; cv=none; b=b5lOWPjbQyTyzuwMpLvjVLK1Jwj9VPO0tyq/Rf6SW+TzAfnCBdoAW7lNhLNs/cJmWDibBVxCD+kwGmcteMQH6KdHfI6Howvx7MCOj/WpVvgPnZsl2aBHaVaDFOJS0F/U/m0kA6qqDoKocti8TQYf/r9OqaxQmFFx2Kde9PkQjEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706953156; c=relaxed/simple;
	bh=lVbgmDUgBgLygaRWRAKaGyFpupFSC3ko9J1ndrQ/0D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyTFhEKRK1m9xOnCoMxV5rtaOn87cCFllUyd+Q5da9yhrSJ0yyKuBL8IWX/JxtayWGzxYAgBSsnwgOV24cC47rOGIgOLg2ysy5HsU2ot8Fxp/JLUeiqdfRDZz/7D4w4YC8YxOO48Jd+CLxCIlWPODamX9Et5azb4gyoMv3pgewg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=j283KEeP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1A42540E016C;
	Sat,  3 Feb 2024 09:39:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wwaJ8cgx7y8X; Sat,  3 Feb 2024 09:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706953150; bh=i2KHIKbtkkGsCULuJMz9deZTc+97GDwUtYXJksBBIfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j283KEePA50ylcoNJKMNHGidfuqzTgO5YioGpvxSxtYeoxAilTiA0BkK5jTdJNVcC
	 DNclSP+xqnT9Ye+SUbu9uOm8Eq5Hp+5J/8nbtOfAJGpM2vvb1atziaQq+a4lI101OZ
	 FPTXVXoF1NsI86Ot2iV80iter/op6Mwu7UumMS5NgWLAecJg/w/jGnZbJCIi7eh8gY
	 63mbwYO2eRSJpKiWPBi+vIYRQFNzzG3dQtXReJDl9/vuAXKPSzBx0Z8kvuQ4u35LqV
	 cJztqrej2n9pdWmxYfL7HE2tUeqmSJ4ayn75eqRSv8XZExLaSKmTaDux2TaHqXWmTz
	 KUDn9d2FGVnlUUTxk3M2Ll/pEi9kB7OLDpJg/e3SWD+vb/WbR0tNKe57JPmA0BYmLD
	 M089Uc3leq+cDFaboZbnPirG4qnYhEryoas8A4syzDofS2+pdFRx2GoRxhB3dzrJ9c
	 tSWldAGYn1aoiBP595fL0c4evbW5PrKL2t8qYKTy3+k/c5b4Ks4XAzl/XgWuXXpoHQ
	 EJovlxFXadru/nFzhCXfR6p8dYfU1VaD2sCeoHoovdrpHxqMaemIDgkq9xQyTN0Iir
	 7VYAo4Km7qYlNWFSgkTpkEl31jCRZ7F912Od2Ehk32LgZeV//6T0tXVKgIMdANXQXz
	 r1J7B4AX5PWMiX02NFGnQySs=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E207240E00C5;
	Sat,  3 Feb 2024 09:38:58 +0000 (UTC)
Date: Sat, 3 Feb 2024 10:38:57 +0100
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
Message-ID: <20240203093857.GBZb4JsahiDx2Ouegj@fat_crate.local>
References: <20240203040515.23947-1-ricardo.neri-calderon@linux.intel.com>
 <20240203040515.23947-9-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240203040515.23947-9-ricardo.neri-calderon@linux.intel.com>

On Fri, Feb 02, 2024 at 08:05:14PM -0800, Ricardo Neri wrote:
> +static __always_inline void setup_hreset(struct cpuinfo_x86 *c)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_HRESET))
> +		return;
> +
> +	/*
> +	 * Use on all CPUs the hardware history features that the boot
> +	 * CPU supports.
> +	 */
> +	if (c == &boot_cpu_data)
> +		hardware_history_features = cpuid_ebx(0x20);

That's not what this does - that sets hardware_history_features on the
BSP.

Why isn't this whole thing called in bsp_init_intel()?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

