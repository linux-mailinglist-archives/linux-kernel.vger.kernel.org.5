Return-Path: <linux-kernel+bounces-84847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3134686AC76
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5151F2672A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF1D12BEA1;
	Wed, 28 Feb 2024 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kvlx29TF"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C277E56E
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 11:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709118155; cv=none; b=kMfiaa80OGsEzELD/kK1EGh4enGm/iMa5j5vTYdClX+6o3ZMexWsMhfdc3kwxmXQaw8SZDs1c1IEKTeSgb6PCyB1QtS2F/uJq9bAJgkgePnF2dfvk0v4fYn0U2X/kqV2cAzSZPcyEbVz6oBYNSgImoRr5jRvU2sPiiNyY34EOC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709118155; c=relaxed/simple;
	bh=mP1LTdeJ3Dns0bz8m3e7GknssXAWqlpGOWgSsRtPbmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lk+feAraWS5wzJPbh+0RlKOVsz/A5LYY5HJDc2Xa19lzhNb1W4uB3C9IttxDSet19LHAgbyWphT9+im04aBrff2EHJ7vvn6a28l1lTsGhJLHxxg1Wc6CC+tlcbeH2YEKvK8XV9TB1l3LYdDVCFBKoLDBHpmIjDWCN9k6i9Zj5lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kvlx29TF; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2799040E0196;
	Wed, 28 Feb 2024 11:02:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SIzcVFrYMp_X; Wed, 28 Feb 2024 11:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709118147; bh=66W6K62NDaGuzFz8YAZkJ+BJvGSDyNWZIMt6wCMS1WA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kvlx29TFSzPSgtP5aT5OFRz//RpQwuzBMVHQqBKDp0dt+hjzmZyp07TGhJhp1FWy2
	 tgDDvPAGJHg33wCgCA9MYHVG6MJKoPordvytsnq99nQKtr8MlKV6AvyrURulOWhvdi
	 NYWRH1JikkOug4i2svew0qoXtndxyoyPwTEHvhk8M9mMTh7CcWEC/PONvM4QpkM4HE
	 SyRdRa6Yz1v78sqo/4maNFNtUhGOHiVSMgnh6Q2ZinpEM4vr+0RC0p6x9sxws/PmiD
	 f6fhvhm8U5ZEsUdc3O9jcgtbYuPhyE8PB2rd9PJX1oXER0lMtHc+9GgQxZspvy7ilw
	 LlDMWwTkeXGCDNX9oOyiYxt4tAb8Xc43+D1lsLIMxuOuuJCSgZNtNjIksgmw21Opz4
	 SLnmCOMjKWSL9g8yoAWb13a+9Of3xw1Ef4bE/IF2YH5HA3jZO1miD+h3+r7fOEgUbC
	 slTmKWbJNEbETF2UHuIIMMpByc37djh5mphqSsmA34l03KiWytYJWqks5Z2JaLOOgD
	 tx5GsN48A1MyhFXlluvrd+MtTtmWmo+tJMYtjy5NZwpXFwcLUMYIYzr4QzAoCqeuDT
	 NmaU7A5bHO3Yk4/NdaK9NAAKkv4L3rt94BDng2gEEVReluLmkk9R6TfS5SlHWFYPa2
	 O1mg+RwpQBtuxbjIaFPFYYBQ=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BC40240E01A2;
	Wed, 28 Feb 2024 11:02:11 +0000 (UTC)
Date: Wed, 28 Feb 2024 12:02:07 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "dyoung@redhat.com" <dyoung@redhat.com>,
	"Gao, Chao" <chao.gao@intel.com>,
	"luto@kernel.org" <luto@kernel.org>,
	"Hansen, Dave" <dave.hansen@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"bhe@redhat.com" <bhe@redhat.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [PATCH 1/4] x86/coco: Add a new CC attribute to unify cache
 flush during kexec
Message-ID: <20240228110207.GCZd8Sr8mXHA2KTiLz@fat_crate.local>
References: <20240219203222.GIZdO61ucfq4bFxRT0@fat_crate.local>
 <283877fd-78c7-4322-bbce-ba6420d56765@amd.com>
 <20240220142812.GBZdS2_HJEA50F8RZD@fat_crate.local>
 <28a494ca-3173-4072-921c-6c5f5b257e79@amd.com>
 <ec58908ac8bc7d953d4c00825217615918436721.camel@intel.com>
 <24844584-8031-4b58-ba5c-f85ef2f4c718@amd.com>
 <20240221092856.GAZdXCWGJL7c9KLewv@fat_crate.local>
 <CALu+AoR-VFHCK_7LHiJ3z_Vk1B=sFS90iAyCs9qmSmf2+XORLw@mail.gmail.com>
 <CALu+AoSZkq1kz-xjvHkkuJ3C71d0SM5ibEJurdgmkZqZvNp2dQ@mail.gmail.com>
 <8c3e3e8c32b50cf488413d965ac6730ce8814214.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8c3e3e8c32b50cf488413d965ac6730ce8814214.camel@intel.com>

On Wed, Feb 28, 2024 at 09:21:00AM +0000, Huang, Kai wrote:
> Based on this I'll change to do unconditional WBINVD during kexec() for in
> stop_this_cpu() and relocate_kernel().  Please let me know if you have any
> comments.

Yes, pls make sure to summarize in the commit message what this thread
figured out. But basically, we want to try the simple approach and
WBINVD unconditionally on the CPU stopping path so that caches are clean
and there's no potential issues...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

