Return-Path: <linux-kernel+bounces-158411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B98F8B1F8C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B040B21F02
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A37120DC8;
	Thu, 25 Apr 2024 10:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PyZWbSGY"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A941DDC9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714042009; cv=none; b=QmGBn4Fe9hjNGQhnPqxyHdG44rtwzqGb/AhsDz4NZccrBwcRsj7eM/zbrWSiArvCia/0n7AHEOdSXevR8+jozVN83hFXNSvlfbS1fpVdyCEASOKV3cHqfV1So7pRBSDKdK48McWwcb/uYDv9yzG31DOIxSUoOl1cMGS9luhMR70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714042009; c=relaxed/simple;
	bh=bSlPWItETblFtE5qDawxpvfw32M0Dl6JLTvZDWPZUgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNYQ6RWYTNYwa9koaiIRCVwaTL00zP5lzdLDyU66/dRMKLvc56NXqmgn9pvorQtBGM8Dw/m8SLWiZ8lMVquWtkiHeZ5QKoAEkVg8wu5BExgzYRJsdovnRpuq00OOZ8FkXE6wMS+YKGK7cJKyNsn+MvSHPM2uSfqh+qP3VjtLsPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PyZWbSGY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 82ADF40E0192;
	Thu, 25 Apr 2024 10:46:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id x7w6dCPNQeMY; Thu, 25 Apr 2024 10:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714042001; bh=afvioA5d1z1R2jypqbZ7D2fAvRrDwNBDSxsUVFXytlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PyZWbSGYC8kKE2trmLSlNs+UgS/6ilbpNIY6WuDSzhE7HjToffoXRLdtrVe6FZvnn
	 S2241CJV6IyYTCA0FGgaNqfQos+DPIJYGT0DgFL9xQ5VYuyrLG/bsWlTbdDgFbhSjZ
	 FU2L7UiPwVZ7RNTWnwPfl0Rme9Hu4h/OE7zh0GDjbQUxuEc8m1R7kNLQykpnMihnH5
	 YLZA4ZIdhezMV5prTf1RutevFztCzTG1V11Dx0X6p/A8Wdq9AufUOaO0ffKi3rWdL3
	 bFlBjbnBBGWOZKAto8T3n9H2w5nIMbrhfP89l2bMDLo+wi5uRNfE982Wx/wnWKCsMH
	 0LkgdaXMOP82BBzK9qyh8hJZxl4HJpzy29lN8/GG/ZrfkxzPkQ6AGSb3OGmNB+hzRC
	 Wadqo5ciM/slsxtGGu5Ynb6C4VWYI7ZSklOYBzsVTcQzIHGJfX2y79QyYGfnlizno0
	 WCaeeREoq8CDSbzl1WwCIHVJcqt8bpSDxsdqgXOdog8lSJug9gtVVsWRoMstogQAWc
	 wJ3muekxXZNf/iiDaq8orqQUphRazbmq2iaV6Qj1BYfwBYubdDA5yG6f8vult3MZC0
	 q0Onfb5VyJlCQ8ieJh2/IwMcmwldkEN2k8KlW+RO8/TCEAZGsBeaafYxjPMiTB1pxe
	 TeIvHU7aarh1eBQ+tw3ODDwk=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 77A4640E00C7;
	Thu, 25 Apr 2024 10:46:29 +0000 (UTC)
Date: Thu, 25 Apr 2024 12:46:24 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tony Luck <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Ashok Raj <ashok.raj@intel.com>, Bingsong Si <sibs@chinatelecom.cn>,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v4 29/71] x86/cpu/intel: Switch to new Intel CPU model
 defines
Message-ID: <20240425104624.GCZio0gDJABGjzoan1@fat_crate.local>
References: <20240424181245.41141-1-tony.luck@intel.com>
 <20240424181508.41713-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240424181508.41713-1-tony.luck@intel.com>

On Wed, Apr 24, 2024 at 11:15:08AM -0700, Tony Luck wrote:
> +static bool vfm_match(struct cpuinfo_x86 *c, u32 vfm)
> +{
> +	return c->x86_vendor == VFM_VENDOR(vfm) &&
> +	       c->x86 == VFM_FAMILY(vfm) &&
> +	       c->x86_model == VFM_MODEL(vfm);
> +}

Why is that one here?

It looks generic enough to put it in asm/processor.h so that it can get
used elsewhere too instead of homegrowing things again...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

