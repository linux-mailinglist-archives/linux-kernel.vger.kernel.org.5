Return-Path: <linux-kernel+bounces-46780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2509784440B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0EE5286457
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A0712BE84;
	Wed, 31 Jan 2024 16:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="lNNaRsSG"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE6012BF19
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718333; cv=none; b=OxvaE9zhfjVLwiwUEozqjq8HlJl9HBb81r8vuY5yDizbf0puHhRB6fvyrbChEKSkyfopFEkpXY9VgIXOhIxHbHFCDFid/ALF/F1TialJOP9AUCWFGNyReFrRnbdjhpR94M6Ys+t2tuEg152Y/BDtPsAmvDQCCTl/QADw0idKVpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718333; c=relaxed/simple;
	bh=OFA7ZCRFxJy1HQvH7ovEWnzGClSG0rOccriqeONMg8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NT6k7DYpKg8OTPk9cwTS0s0Jq7AF+LdxWx/NIzdeO5fQ9qWhmOu1a1eXBy/1b0p3buhUZBfbx7uRAbTjvhVRpslPwaTYHRdBDZyKlsRS7mH1VsHzrPwhKvXQjO9D/+MBvGMVPwjldNLr8oQLSB2yc6ze/xLaIT0KiB0qiPB8bBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=lNNaRsSG; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E994E40E016C;
	Wed, 31 Jan 2024 16:25:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6FNnkf4LnPtn; Wed, 31 Jan 2024 16:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706718325; bh=0K7KpkYTFCysw+xyfDHLT5SJhKiQkmTyFk3X1vmAvbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lNNaRsSGsNjoFQihdXRcJv93fk/90PFeBDtGGphEMNQ82kocxO+TQxL/vZ06ozdlm
	 U2IE8o1EjpHvc/EG61kd84wlZaaUWiaWartsTOZreKeVQ0FPe1da6/nYeca1/bdiVz
	 F80fOENTSJnK120AuEWgyMAcCstLyM+DDTFRZeCOJQSyx1BHD2yaO8m/uXZJq2px1p
	 6PXMhMhLiX71/M8bw/kKeFHjB+NH78bfXGZdbWedB66ZPeTowWeOZSq8Jpr1ErnGGe
	 fcpa+9X3M/N5WuCt+O1cbK/D8fWKF42zvtzs9vMObp7OL1JSyfmcHAg5tXQM9D8FPC
	 1+r+BGOjPZQwvIf6Pqk3Cj9hDaZ5VJOkYLZUDNszS60K7a2aRgKQt52EoR9oXcKTsC
	 O3dbuka0VZHkuNCZSi6bCpzaNtadobijQ0Jhd21sDpLvwJIa6pu3q0FHIeVx+zulF9
	 vQzNGnCWtJGV0tjfT3JQACt5kZdvNDENEzk4MDcxDBLWamRp72UQa2RP0l9Vw/d2Jz
	 WpOrnEM0mcevL6IaplwK4YD73/fd1nMBvvhnJYOxtc84xble4bVVYh5zF5EhZqTXc2
	 HZQacgN23i1fSdLXhx7Heoyt2QmBC/yLGsN1LnFweMl1GrYojXQLeLHTOrPo1/JO7L
	 9Xt11hStfQWWyqgcRzhICa7w=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0A96540E00B2;
	Wed, 31 Jan 2024 16:25:21 +0000 (UTC)
Date: Wed, 31 Jan 2024 17:25:21 +0100
From: Borislav Petkov <bp@alien8.de>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] x86/alternatives: Do NOPs optimization on a
 temporary buffer
Message-ID: <20240131162521.GGZbp0cW8aWuYikuAR@fat_crate.local>
References: <20240130105941.19707-1-bp@alien8.de>
 <Zbpylz6ep3skWF9d@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zbpylz6ep3skWF9d@windriver.com>

On Wed, Jan 31, 2024 at 11:17:27AM -0500, Paul Gortmaker wrote:
> So as a "next best" effort, I let this rc1-alt-v2 branch run overnight,
> and after over 2200 iterations, I didn't get any boot fails.

Thanks a lot!

As mentioned on IRC yesterday, the important thing is that this doesn't
break any of your guests. And that is good enough.

Much appreciated, thanks again!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

