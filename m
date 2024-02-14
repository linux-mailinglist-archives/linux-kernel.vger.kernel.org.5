Return-Path: <linux-kernel+bounces-65803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ECD855213
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E1E28667A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E867B1292C5;
	Wed, 14 Feb 2024 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="KH7yOub8"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B708D17580;
	Wed, 14 Feb 2024 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707935411; cv=none; b=lCauy8gcuax4anOsKjvDMyDnAMG6Cqi/5QpPzgfiPKqIFlGO897FktIn9RiwEmEID5rKyzhJo/aptafOXSLSiSD9EPlxLxHnltkZQEaDjkKizxp6Es8Re4Bq7xEUuqNOoJPQUpxdXCTDEQg0LGMHdpnw2Iyk5T7WXjMhlz4Y6RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707935411; c=relaxed/simple;
	bh=HkIB5DKyzWpxlx3qTesPK6i0xnigJpcI7ULrUohNKmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gj4l10CXpeAe8OCJRojqO1SWbXYf8g5m6DS8O1m52C1OTBl8jlR1EXrzmmAj/8dQf9kR+6tCCktqQDelmW35UVasRt9ZOwya7U3KjuY3tUvbxRj4FJa0mar1vziyM5C0etgKUU6rrTD1ONtb+K1kUOpZHh9fCkhlxs+X3yqJn7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=KH7yOub8; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3B8AD40E01BB;
	Wed, 14 Feb 2024 18:30:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id oDoqT-OwrLQF; Wed, 14 Feb 2024 18:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707935403; bh=9CHUUOpbm7+wDKAULGdSXuwhdw848MNTurUBco/P7KM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KH7yOub8uLRIsrxweMEz7HdV+5lthB/znwbPxWr39Iy2MNBFrMCnIC78SmiRT+m4r
	 yrQQkK+DRWGsjhBhuCL9ybs/nrqUcZ9hAmwUS86CZpRFDYRJ2IBnqgy/m/F/DzGMc5
	 k155BsUAEBtmgZVcFzDTykwdN3YihVjVCxMHNCvTRrqP1zoldSN6DbkuTSdLGp0WGz
	 ioD9z/mpacqbFh3xtlfqnbMBoJjJWltm96MkcaW2rYfTa2wFJ8MTyzPtV0a5nQUaVG
	 6VF7a9cB686sJaBMnbxuLca4K5e8mj+rUvkzEj8NzDLJOsp7Bs9Te4G4SiWBVFGzF8
	 h+6/sjjHo97kNhzsPaJu1m2Y8ltZOdAWyepF6rn2XX3mLqvmQLMibMOeyIrlsqhUkm
	 efGxnQ22JKKxTk6ETWRxEfJj2ZS0a5MZl7mYGw6fcxFcy9fSKyJ4wA51ZxUdVTSU3T
	 ufp7R35GzLzk9BY6BQABw1AMGKz4EstzltJ8QC/URYRATfsMIO0NtIikNtJL5TrkeV
	 7rg4mqiHkUDHvgaumDs7sAm0FZn4qb+L8OiAw4qRUCNK6ZvV0/A1p1euX24E3Hu2eY
	 YI8bhyt7FZazpwB0K8ZgWJO8n09nQLRZNiF7dLOQLhlQ399kdNDmpJvCKrZtd2Q09M
	 0iFiI8bHzy9lnYDn/C8TxgAw=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B52F540E00B2;
	Wed, 14 Feb 2024 18:29:54 +0000 (UTC)
Date: Wed, 14 Feb 2024 19:29:53 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, muralidhara.mk@amd.com,
	naveenkrishna.chatradhi@amd.com, sathyapriya.k@amd.com
Subject: Re: [PATCH 2/2] RAS: Introduce the FRU Memory Poison Manager
Message-ID: <20240214182953.GMZc0GofSSQxd3T5-N@fat_crate.local>
References: <20240214033516.1344948-1-yazen.ghannam@amd.com>
 <20240214033516.1344948-3-yazen.ghannam@amd.com>
 <20240214103446.GDZcyXRkyf1bFzMh7L@fat_crate.local>
 <3bc7bef5-9cfc-400a-a1ba-99ebf5d94952@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3bc7bef5-9cfc-400a-a1ba-99ebf5d94952@amd.com>

On Wed, Feb 14, 2024 at 09:46:46AM -0500, Yazen Ghannam wrote:
> > This is a generic thing and thus can't use an x86-ism struct mce,
> > remember?
> > 
> 
> Yep, that's one of the assumptions/limitations I highlighted.

Right, since the notifier callback fru_mem_poison_nb is on the x86 MCE
chain and since we're making this thing depend on AMD_ATL which depends
on X86_64 currently, it is ok to have struct mce in there.

Once something else outside of x86 wants to use it, it'll have to be
decoupled and use atl_err.

Later...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

