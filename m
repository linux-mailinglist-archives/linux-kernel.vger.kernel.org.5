Return-Path: <linux-kernel+bounces-86318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3E286C3DA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3BF1C222E8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483FF5337E;
	Thu, 29 Feb 2024 08:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dksbZgX1"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE092AD32;
	Thu, 29 Feb 2024 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196015; cv=none; b=pX3bXUXo+FVpyZ6fSDi9Ab/Booq3I90KyruM+x9YUCCK67GL2LNq/ABOb6gZ6bciiqbRxJK46m3x8Pvhs67zW534x1KkbeHC2tFfZQnIkGcwj6UE4MMSM93NWu5gBt/T7P5lFT/Lf24sMQB0s7v8buYTl2Eb7ca+HjhAwqOaIqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196015; c=relaxed/simple;
	bh=TpIABOi8CFz2DDFHLfZToJ/2OFIXL70FWuAQnHfHTL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hr84X0zxS8yG0eN/e7vUrgkfYjVrEpVP6C1uFFukuPRFy6o+eMbXZs7sp75q2wmyfLlJK1W+2W/88jdyXsXqkhFN0GFD4was2VmnApqdDqO8oyqrLKvDLWDQcF51HUvzff6V/6mgCh5VThvLoE9nVqhRWnc4j4aABNdqHsrXutw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dksbZgX1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 50A2040E0028;
	Thu, 29 Feb 2024 08:40:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BE24TXGbZrcc; Thu, 29 Feb 2024 08:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709196005; bh=Xgu43DQMWHM4tVOw+nnmZWTTI64ZfzAwiBOS/HGblUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dksbZgX18ASp3u4gP7ViApi04XiiLj10wBkEw1cqaKcuM8gnjNfHN53PSzePZkyAW
	 gNCFa3Uz3Hb9bjRAro3xoRkkxyJpwfOJiJvxRdNLc8D+uwAYAimZI1DaL2T7ciRaOH
	 swfSip6d2Yige1LNfeVm4aTETznBU4+IsKHhk/RGHOR95EPUSb52Xr3dlChu3EBkd0
	 Yhb/Rxuhkg8BNgczqqphO3JW5z7a/3T86yXmZVDn8Xy2exMUDGsGkTjfBa1UX3l+aQ
	 zhjSn7ZuyYLLiylXQ1kflJQL9BsJgoDfSLPgupnq12tjKt2J/poYdTma35rhQYEAr5
	 Yo21r8RwUw4Fw7wIefKAuGPjejBRLvLZYnWzXraaJZB1ybWzgMgpWh73aVHzxusSNV
	 qX7oS2zA3Cwg1ItPmbe+4U+v0aNgnAOgRPA6tvXjzFawufm1XKTT6Zp6X3HFeZkpxe
	 nO4zhKOg8r6ncwJiWnjCF2CDVx1tnT0+CNyNMAm1lT7WgntT1Io0VenrtOoIDpZDqK
	 mwGi6f9KWZXrbVyHMHCqlMSyDR9+6OV3b0my0qlsYgI/yoGgen7o1i7mt9H2Rrifqw
	 7vJewU4gGn3bTLcuFUaCrrgiWH1Qe/2vgUPtqIDMY1B4lzOgPdb6RHFJrcquBIOUk2
	 +jq+vPFhnaPPVy20oad93f2s=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C901D40E0196;
	Thu, 29 Feb 2024 08:39:56 +0000 (UTC)
Date: Thu, 29 Feb 2024 09:39:51 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Naik, Avadhut" <avadnaik@amd.com>
Cc: Tony Luck <tony.luck@intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
	Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH] x86/mce: Dynamically size space for machine check records
Message-ID: <20240229083951.GAZeBC1yS3MPonWwKv@fat_crate.local>
References: <20240212175408.GIZcpbQHVjEtwRKLS-@fat_crate.local>
 <SJ1PR11MB60830AF35FA89C7869B8C11EFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212191401.GLZcpt-XHFqPg3cDw-@fat_crate.local>
 <SJ1PR11MB6083C60D7584B02E9CAF19D5FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZcqPhVO_DtD2x5N7@agluck-desk3>
 <20240212220833.GQZcqW4WxKH34i-oBR@fat_crate.local>
 <20240212221913.GRZcqZYRd6EPTTnN97@fat_crate.local>
 <20240212224220.GSZcqezMhPojxvIcvO@fat_crate.local>
 <Zd--PJp-NbXGrb39@agluck-desk3>
 <8ee24cad-e9b8-4321-aad4-9a9ba4f8b7b6@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8ee24cad-e9b8-4321-aad4-9a9ba4f8b7b6@amd.com>

On Thu, Feb 29, 2024 at 12:42:38AM -0600, Naik, Avadhut wrote:
> Somewhat confused here. Weren't we also exploring ways to avoid
> duplicate records from being added to the genpool? Has something
> changed in that regard?

You can always send patches proposing how *you* think this duplicate
elimination should look like and we can talk. :)

I don't think anyone would mind it if done properly but first you'd need
a real-life use case. As in, do we log sooo many duplicates such that
we'd want to dedup?

Hmmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

