Return-Path: <linux-kernel+bounces-55252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD94D84B9BF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A21E1F251C5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D1C13341C;
	Tue,  6 Feb 2024 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HaiVIfge"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683EC133400
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233762; cv=none; b=eoXP3XIZuprUp17m/BXLUkiDauOPxBUY+BdtJJO3V3sNrKmukfZtCDbMuasWFPVKs7SeKlrrSYZ4gvGW4z5vDn7XSJ2k2rxO0+BQykQNb60q4GDuN6t89HIbs4Hpa8xqk0pBHT+R0V8yKCLIEOJHhplTam7VUYKZ7Ct+c6W2W6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233762; c=relaxed/simple;
	bh=C8ZczL4/bNIoycAPQlQvXPphm+/mjzHScMFO5zq0pwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UuDzjYJWy33IrXuafwkZLFmj/jpDMxd7pVeuJZHY/zTQwv4DgzhoNTi0Jye9lxAT/veDTpINBW8NkFx8C9ifujGXlMeRgxz2yo8CLuKkaTZoKpXM1YvG1eSitMwUtz9hycgaTfAxe+yW2WmtFbHwmd2FJhKLSpJLHqD6KYpmvxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HaiVIfge; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CF42340E01A2;
	Tue,  6 Feb 2024 15:35:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id X3LtCRBid0wA; Tue,  6 Feb 2024 15:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707233755; bh=+yirkz4/vPsUM99izCZuk7S6K6+bIxctJ+MAhodIqVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HaiVIfgeDLswx2sjAemFnU7Tctj33+O4U4Cn3/HgsRf9lwmds16LJ1sHAQRz9hxgd
	 u6ogzF3VTitk3/bPXTY0/CeoOWIA/8oFF4G+GqCUbZS9O6tRUzb44CC57ZMqbqMSfy
	 3n8oTj+1RwTbnkJnxncCXIdycPoXWoOBQ53/+K4+Qyxg8s95sUezr1+mWWfP1WjKUQ
	 v1y/H13GVKv4vyvwXaHwK9YYcC2tLCuhhtgCFaWfMSIEuX4tXsj/dlovpehQDavySX
	 oioq9/FlVNo/EYAUJHhAMJhFb7t+zrF6r7ESpza7ZxCkjG9z8YP/t9niAMLCWKcbsx
	 b0BHInfsvTLXw82eqMt/x8wJH4smlXmp7+y0canyyV3ZYvQo/4iHfTtMzLi4V2gAeK
	 MAti3B3dIPsASNFO6m99KqACWxzmUhjp8P1SNEhRyXD+pCJWxS1w5Rmn2vUI0ibkwY
	 9cdShZkxR8MlhPuKHLQ6yIayKxMklJ2nuDuUUkFsbt/zy9+SIZmHYHpxdsCTxQnW3F
	 50aKAumbBAcGvCo/mdVWeEGjPdtHRrg2wHRiJorMStp/qzPfzYiIq+DWMW+VeSDu/h
	 AmvaaLGGbTAlr/Fo5VMCYxIC/yvFQgatM0i2iVOUSbR3dF66NHTpMF/oghTYKGerE1
	 NjNggl6GxN5xlot8nF+ZYTnY=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3A53240E023B;
	Tue,  6 Feb 2024 15:35:36 +0000 (UTC)
Date: Tue, 6 Feb 2024 16:35:29 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Dr. Greg" <greg@enjellic.com>
Cc: "Daniel P. Berrang??" <berrange@redhat.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	"Hansen, Dave" <dave.hansen@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/random: Issue a warning if RDRAND or RDSEED fails
Message-ID: <20240206153529.GHZcJRwTdDkWXuopOQ@fat_crate.local>
References: <20240130083007.1876787-2-kirill.shutemov@linux.intel.com>
 <CAHmME9qsfOdOEHHw_MOBmt6YAtncbbqP9LPK2dRjuOp1CrHzRA@mail.gmail.com>
 <DM8PR11MB57507611D651E6D7CBC2A2F3E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <88a72370-e300-4bbc-8077-acd1cc831fe7@intel.com>
 <CAHmME9oSQbd3V8+qR0e9oPb7ppO=E7GrCW-a2RN8QNdY_ARbSQ@mail.gmail.com>
 <Zbk6h0ogqeInLa_1@redhat.com>
 <DM8PR11MB575052B985CA97B29A443F9AE77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20240206011247.GA29224@wind.enjellic.com>
 <ZcHoKUElwXGPzrWb@redhat.com>
 <20240206120445.GA1247@wind.enjellic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240206120445.GA1247@wind.enjellic.com>

On Tue, Feb 06, 2024 at 06:04:45AM -0600, Dr. Greg wrote:
> The silence appears to be deafening out of the respective engineering
> camps... :-)

I usually wait for those threads to "relax" themselves first. :)

So, what do you wanna know?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

