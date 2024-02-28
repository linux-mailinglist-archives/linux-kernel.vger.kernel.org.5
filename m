Return-Path: <linux-kernel+bounces-84842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D21DF86AC53
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6449B1F233EC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881637FBD7;
	Wed, 28 Feb 2024 10:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OOgdDc5E"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363567E0FE
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709117110; cv=none; b=npI52K53//0dquJXXXp4mSZHGsaYJYF0y4L0T3P+tWjIbtuN2tY/FzE+Z5RkJg9waQYAF3sSxKYa0re+zLUSor9wpF6tCoENm8E4X7wYedhC4PsepJ/FsUXNYiI9Ny3O8afzeak5jKwjW/oE+e6AT5D39eIbUYyXH+thRcf51a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709117110; c=relaxed/simple;
	bh=kYedqZvj+2++aCKAQmVOXmTmk5jZGQA9WwbipNjpR4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gx3vBCSBuOFyHonrElWhUy/UYumRc4r55V2EqRedw3/gAdl6TQfIMZ0X1nvM8cT8dIgGtkHR0q+we4y3RXdzQtOLF0fRDDzBIZOJvRcF4Vm31zkwjzQvOHFmjzPfSY7JCuPq8ZKT4wG82r3mlyonVKZGbiTimvUp9OLZrVguEwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OOgdDc5E; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0FA2640E019B;
	Wed, 28 Feb 2024 10:45:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1rts_zqtANC4; Wed, 28 Feb 2024 10:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709117104; bh=8NsXIGA6zLBS15CRyXBxzpZBjAy1d/Jp0whp595UTb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OOgdDc5E9b0wbP8gvGFryzX9PwtOJbhffmpgXOQZVJMyesLQhaMqRcsmmXYxoH5cr
	 D/jVKqFtKP1zirLIaMObF9Z8R37NUptdUnfMdbxo4tWaEsCky9Vy8ESD4NB4qn+hfU
	 JwE3edWdamB4i1XgHzPcB3wVE25YUpQmAGVTf9sDt87ZF1hCfKMRIuV6meqRoiHJk2
	 3/h6m1iYRSKPTjS5QMNFtXpu6+TqoTf/J4Y6AezXzeUroPia2eQtecPpPiLAG4bvpj
	 C3DIGlF7Q0Wjadxd7MRAUeXx6YJRgVBXU8OtR618VOjA/OXZ8x3UHktZ//1BXOOld/
	 qsD8q+Ohy1oED+C3HQWZcD5JNKp82lm0TMWXC5pFkxPfqPe7I05ndbyxeWRRpQOmi3
	 5N5Qf86sxLtP/wqvfcEzF3xP95i+YaVfgaEulDxQzCf6mizS9Iyux80W2yiQ9Wcmpt
	 yeEhAOSUOeh/DLjB0HVgJ8Eho6FoMnS2IW4rl4pTHDt7aFskeTTvTkAilUdmE9S9Xi
	 PjhjXP2bL4S0+3xSAl4zoq5fd9FKA55XPGOLfobhnh+Azy7NYgtk9fZGBdO2DNQF44
	 fFtilNWB11vrpcwd9lGhDJNJ+o8x+fbqSfyvj04OL4LtUc9bilgBML2C32VLmLj5zi
	 aXqYjUmYURJPYivkbEIraMIc=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ECB2240E01A2;
	Wed, 28 Feb 2024 10:44:47 +0000 (UTC)
Date: Wed, 28 Feb 2024 11:44:47 +0100
From: Borislav Petkov <bp@alien8.de>
To: Dave Young <dyoung@redhat.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	"Gao, Chao" <chao.gao@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>,
	"luto@kernel.org" <luto@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>,
	"bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH 1/4] x86/coco: Add a new CC attribute to unify cache
 flush during kexec
Message-ID: <20240228104447.GBZd8Onx_D_Doz8dzE@fat_crate.local>
References: <9164b0e3-f520-4aab-8b80-520131f0e4db@amd.com>
 <20240219203222.GIZdO61ucfq4bFxRT0@fat_crate.local>
 <283877fd-78c7-4322-bbce-ba6420d56765@amd.com>
 <20240220142812.GBZdS2_HJEA50F8RZD@fat_crate.local>
 <28a494ca-3173-4072-921c-6c5f5b257e79@amd.com>
 <ec58908ac8bc7d953d4c00825217615918436721.camel@intel.com>
 <24844584-8031-4b58-ba5c-f85ef2f4c718@amd.com>
 <20240221092856.GAZdXCWGJL7c9KLewv@fat_crate.local>
 <CALu+AoR-VFHCK_7LHiJ3z_Vk1B=sFS90iAyCs9qmSmf2+XORLw@mail.gmail.com>
 <CALu+AoSZkq1kz-xjvHkkuJ3C71d0SM5ibEJurdgmkZqZvNp2dQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALu+AoSZkq1kz-xjvHkkuJ3C71d0SM5ibEJurdgmkZqZvNp2dQ@mail.gmail.com>

On Wed, Feb 28, 2024 at 10:54:22AM +0800, Dave Young wrote:
> Update: tested on an old laptop as well,  I did not find any problems
> with unconditional native_wbinvd(), kexec and kdump works fine.

Thanks a lot for testing it!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

