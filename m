Return-Path: <linux-kernel+bounces-162301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E53898B593D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223AF1C214E1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3626654908;
	Mon, 29 Apr 2024 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Xd1t8Jex"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11DF53807;
	Mon, 29 Apr 2024 13:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395613; cv=none; b=Xw4AXMQ3xB5LkUghKF2+g5avGOk7obSdaqlNk55c5ovVQcnUiA42YHKFl2oSUcsSlfu0qOdbiqnESuq2zb2ECxG+IJusFdbbHqCdkg1c/jf9ERXGTX4E4/9IHq0gPHCV4ATsboBuQABEPg1/ivjtWALlv22hzkK3ZA4Uolk6qlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395613; c=relaxed/simple;
	bh=FEbPEHo7bgSqPQfc2/MfCeUb7zmD3vG4LVEUjIDmXco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDENHaGrvMsexWVps+PA2Dlkhbc/gF9qC6nyTH9zIgnDWMEI/HpV6k2kIalHEjaILujTSaanwi6BslJY6HP7rBgHyiE2BaLupoXE9x25n1QynBFQ9WyYXNpc0Rk+hnKUoFNwGKdfi0Nkiub7bH5Ike0d2UoRIgW/NGL/af92klQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Xd1t8Jex; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8501340E016B;
	Mon, 29 Apr 2024 13:00:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8jTUar58q1qr; Mon, 29 Apr 2024 13:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714395605; bh=jdsg8DKKIUcN9Hhk1trAm+hpQj1YjGqawe164u8r6aE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xd1t8JexRJaeVw0W6g7ZLlK3LvIeeXvhs18aFMPpQk3vxUjXRayqkGTCLBppNLO8r
	 8Dsd1BByifNPOhgK5qdPhNQ8DPZ6yvfmhXKykz53V3RubDwaYjgwmG2WXuoWbntwLV
	 3ZFi1qcnkwt/cNneN4UhC2vX+yweEQ9Acgsnv7vpNyFHDZiTnkA8Lh6QoCXrl/nqP1
	 o3s9TLUVH2+YNo7zm8MCfigiV0Yv7WmLvEwlPx0K0U7MZsn9XPwUN7bnckYcroXf2F
	 /KULlanHGIpwZGT/3DMRZ3jv0qrq26bbp2ZYu4j1fD29DRvpgItSeJKvRNc0EBw1XU
	 irNeUgDqId5Mf6HY3WC0G5Ynzxoznz0a/G9ZeKEaz9qeK74CT5lCoCJ3UwXaOH12Zi
	 FbKOFXQINNQng+RPjp4LF+n9U/Tn30AnzliQweEzU+xDagyZh66DxpVn+Wn8019fkG
	 YSQFC6/J82a68dH4XRMJLVv8UnhQW8DT3NuKT4qI3OD5egEhYi2+D+7FpGcNMjjY9g
	 9k3jr01zZxN9Rwbnykc4nxIJ0oaROssSmS+ulHgpiOB3BvDEm1Xrh7FWVqXruqX1KT
	 VHrPlMGSFDEhsd95DO3hLnF106hFAZNx64aiFj2qm469YqjEiz4EN17lxLYhM/mDgj
	 MJ2SoZo3qrbx9OqUzstV7TRw=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7F5D540E00B2;
	Mon, 29 Apr 2024 12:59:57 +0000 (UTC)
Date: Mon, 29 Apr 2024 14:59:56 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: robert.richter@amd.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
	Avadhut.Naik@amd.com, John.Allen@amd.com
Subject: Re: [PATCH v2 07/16] x86/mce/amd: Simplify DFR handler setup
Message-ID: <20240429125956.GNZi-ZzN1Izxps8ztT@fat_crate.local>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-8-yazen.ghannam@amd.com>
 <20240424190658.GHZilYUvw1KfSfVd_e@fat_crate.local>
 <e0d10606-4472-4cde-b55d-34180efad42b@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e0d10606-4472-4cde-b55d-34180efad42b@amd.com>

On Thu, Apr 25, 2024 at 10:12:44AM -0400, Yazen Ghannam wrote:
> I trust the value from hardware.
> 
> The intention here is to simplify the code for general maintenance and to make
> later patches easier.

There's this BIOS thing which programs those and throws a wrench in all
our trusting in the hw.

> All Zen/SMCA systems. I don't recall any issues in this area.
> 
> Some later Family 15h systems (Carrizo?) had it. But I don't know if it was
> used in production. It was slightly before my time.

Yeah, already solved in the previous mail.

> Right, I found this:
> 27afdf2008da ("apic, x86: Use BIOS settings for IBS and MCE threshold
> interrupt LVT offsets")
> 
> Which is basically the same idea: use what is in the register.
> 
> But it looks there was an issue with IBS on Family 10h.

Yap, and it was pretty blatant AFAIR.

> Is this the only case of a real issue?

I don't remember anything else but I'm not excluding there not being
others.

> If so, then why apply this method to the THR and DFR interrupts?

Meaning what exactly? You want to trust the hw for THR and DFR and let
the others use this offset reservation we're doing?

> Right, and all CPUs should use the same APIC LVT offset. If they differ, then
> setup_APIC_eilvt() will fail above and return.
> 
> Why check "if X != Y, then X = Y"? Why not just unconditionally do "X = Y"?

Why unconditionally do the assignment if it is already assigned?

I don't think x86 does store tearing so that we get deferred interrupt
on some core while some other core writes the same function pointer in
there but why even risk it if it can be avoided with a simple test?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

