Return-Path: <linux-kernel+bounces-44999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35060842A2F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74D97B28005
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB0C12838F;
	Tue, 30 Jan 2024 16:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RXtmGVDb"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11256A011;
	Tue, 30 Jan 2024 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633632; cv=none; b=nEiGqSZ/bxgY6VkilRq7IqpTFJ9NF5gRYgZSGcJZUgaGdKecx3aVL8VjEsRABgU55vyV4LUfSq7WgW5cqeJ2LdbcOt7zpQmruYJi5cA364vAHX7+e65l08FWRn2GXVT5udatcj+nvc1VCR8KTXS+lszEUygwGaKg0e6DA4BfTdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633632; c=relaxed/simple;
	bh=yg1zQQV9Nu99DapNhBuQXuTTD3Bj++ni0ku8vLyZywU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meXckPeAMfyfOHHKp9Eu82Rcc3qclwtBKdOilXRKDBroBhQMAZR++XGhWpVzuHruXSSdVvapInXRfgNsLB4dN8dxWYu+iamiY1/DTJDKxAFMniZaauNE0u1akuoyVX8LQB9CdR+MRw8Wu+3Zk3fPi8fRUg41J61IF2olA1OZ+Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RXtmGVDb; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4FE2A40E016C;
	Tue, 30 Jan 2024 16:53:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id G4O6xBpjgM-n; Tue, 30 Jan 2024 16:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706633626; bh=m1gOw3POJEroKB8FEffV3lkpXkGsBoiq2LcDfaSmpKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RXtmGVDb9H2b3bq0L5d0NWOi22kaNIUL9uPZy/EYnkE2COoO5Kyi4IXfBZ0OjlJvu
	 Ll1ByOC5BZABPPl5S6SOrUMBuTAkSkNJXlMRVbqQpVaBSwmZ7Nq/1T1mJtkkBvAks1
	 pNiKhLcypAWPWm1224sVY+0giQ4IG44ZJ3F+GbHF+tVeLUdX+VohFdgDEl2kDVbw0W
	 GUObO9efWvOiEYsF1xh26QVow3BmV8vkYn3nF5Y9JCKsk40zuWUO6EogedmcC4ihx7
	 nLBr1mtJKhnTCFCEcD5MmimFZTJJP0gjclGxkUpeVUH9xyFTSULf8Uoh4U4Agb07ke
	 MHpjIY/Sq1o+raZx7VonkiCnqCqlpWJ91bkAhGFxI5I1LnmbJUO/oaZ9uMSB3SKmll
	 D1oq4oz0hZbVYM7z0N2+aW/3ALIwSVFqRYeWcMF8Cx0n7O1uZEHveQX7Z9hjTeWf+3
	 PJhSMyyw87Tnaj08fRiz0QjoJHySkHltOFxvReB9xehFiId1C171Rqr251IA8V65k0
	 FAUFhBMOUwOp1oSdJiM5a+Ac5/9tn93MiUza10UxFAZ1e0xl8pgL/fanw31d5VyX2B
	 iDNZK1EpWQyBXJQKRbHI09F+yPvijgVviuRnfAzZeLCAupX5jH/6b3yH8beBY/h4C5
	 +Q3B88ddz88Wseb6dgHr5LMg=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 51C4040E00C5;
	Tue, 30 Jan 2024 16:53:35 +0000 (UTC)
Date: Tue, 30 Jan 2024 17:53:29 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Li, Xin3" <xin3.li@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"Shankar, Ravi V" <ravi.v.shankar@intel.com>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
Subject: Re: [PATCH] x86/fred: Let command line option "fred" accept multiple
 options
Message-ID: <20240130165329.GHZbkpiabX7i6OBN9C@fat_crate.local>
References: <20240127094912.1489-1-xin3.li@intel.com>
 <SA1PR11MB6734365A1C02A91A831FDB9CA87D2@SA1PR11MB6734.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SA1PR11MB6734365A1C02A91A831FDB9CA87D2@SA1PR11MB6734.namprd11.prod.outlook.com>

On Tue, Jan 30, 2024 at 04:44:22PM +0000, Li, Xin3 wrote:
> I kind of prefer to fold this patch into this commit:
> https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/commit/?h=tip-x86-fred&id=7a1d75084df087dcae703d70a49274a3982e3681 

Yes, good point, I'll do that.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

