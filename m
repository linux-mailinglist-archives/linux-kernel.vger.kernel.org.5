Return-Path: <linux-kernel+bounces-111804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 376BC88713A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694651C21D91
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651575FB86;
	Fri, 22 Mar 2024 16:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cz2tiAY6"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482E95D479;
	Fri, 22 Mar 2024 16:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126184; cv=none; b=vGIzZw/0nmCrrngpyGiTHKAE8nCeFeyRIWoQh3TdiyLmg8iSccLUsTrXnv8oo0KXW42nn8slWYG7+PqjYvDrw+G+VjC3y+8QrG2S5MVoYW08Sv9YGe70jXjsIZ5A247H6UstuNmoe0BvXh+W0D7s1IMZAXV1NihUHLZyp095wVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126184; c=relaxed/simple;
	bh=ofr4IJKDtc++5mO73WvnwKV12KcYZaZurnkDZn0wcGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcCkFlhTox+t7DLij7IyLGe+TLXI27Fup/VIl8eypoM3QsdHqqtwCM7bvyR1LMlNZHpRVIv3PQlu/OjATmzsQ8zkPkaIGYhWKpMGC/LM8DcxuncFARPHE5vvbn8UTgU2gmyyKYdWXsVnH7zdRIMxF+kSH/kxq6Bz4HBRMj0h0Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cz2tiAY6; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9D1F340E0140;
	Fri, 22 Mar 2024 16:49:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id u9kkTKGtkJhN; Fri, 22 Mar 2024 16:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711126167; bh=zmgmuyyu04qQDDakR1Zt6nICyLhZvl92PNFJ6jYHiqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cz2tiAY66U7fVC3nUBO5DuS8PIl8L4w0wz0PXUiFgot9znI4XTczaCmkzRj20IbXu
	 H+fQ8Vc101mEukRzjo9t4uQKnlkN0dgn0gYWqZUc5MO1qXgrW4rXhp4HPuTAdhgcNa
	 by0l1ZT8teq3Ibf8LeAwT0A8ZdpvfYZztd6b+k32U64coFMkf9Mnd58uCPWa2zro4O
	 eczmAcswk65Ex4bWdfbx/o8FADM4PIMFxHfHxEpvq6YPXfU/ZF7xONWBVC1wpb4PdM
	 XGRgQQbAFp3U1iEWfxjQLv1oQL4g6paR2/iMG/alp4l/QKGe9Lp7kjCEoQxn7uXKG7
	 iOk8w4Gv5AnLUvN1wPxu5aPmKdq6pEbD6majeOPhuqFGmW548f/VTjkHTfr6cNAcUJ
	 i5aK3NeQCLBwPeuReyuQYF/MAs7EXqqbcm27F+Hz/U17e66qWZegeJeyuKgGjqgE1k
	 O3nem+NimSvS89HggVYwS04SgM7pDrf0ITYXNbqM5uugIyU6vEGtc8ofi9+iJgyDNu
	 DIg8I3dgOjp4UjEZyCWJ2QHiZuKc8K2J0E6auUcEMU+J+poXapMN00UUUy2iKPU9LZ
	 AIfdBxShVWztuIPTxr5TTekj8U4HyVNhTyqxNdQ6FnUfo9Xm/+gqCA7xC8RkC/Bytv
	 1PFXb6Xn09jhAm2hvEGDRico=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 92D2940E00B2;
	Fri, 22 Mar 2024 16:49:18 +0000 (UTC)
Date: Fri, 22 Mar 2024 17:49:12 +0100
From: Borislav Petkov <bp@alien8.de>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Subject: Re: [tip: x86/shstk] x86/shstk: Enable shadow stacks for x32
Message-ID: <20240322164912.GAZf22iBdqdkIFcrsl@fat_crate.local>
References: <20240315140433.1966543-1-hjl.tools@gmail.com>
 <171110519880.10875.7663158781394877164.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <171110519880.10875.7663158781394877164.tip-bot2@tip-bot2>

On Fri, Mar 22, 2024 at 10:59:58AM -0000, tip-bot2 for H.J. Lu wrote:
> The following commit has been merged into the x86/shstk branch of tip:
> 
> Commit-ID:     2883f01ec37dd8668e7222dfdb5980c86fdfe277
> Gitweb:        https://git.kernel.org/tip/2883f01ec37dd8668e7222dfdb5980c86fdfe277
> Author:        H.J. Lu <hjl.tools@gmail.com>
> AuthorDate:    Fri, 15 Mar 2024 07:04:33 -07:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Fri, 22 Mar 2024 10:17:11 +01:00
> 
> x86/shstk: Enable shadow stacks for x32
> 
> 1. Add shadow stack support to x32 signal.
> 2. Use the 64-bit map_shadow_stack syscall for x32.
> 3. Set up shadow stack for x32.

Why are we still diddling with x32 and not patching it out instead?

https://lore.kernel.org/all/CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com/

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

