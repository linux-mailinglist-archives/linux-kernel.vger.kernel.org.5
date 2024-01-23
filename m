Return-Path: <linux-kernel+bounces-35612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2299583940C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCC451F25E36
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8867561687;
	Tue, 23 Jan 2024 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FMBAiTrj"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14B261669;
	Tue, 23 Jan 2024 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025697; cv=none; b=XMZ5tHAQXiatMz/NQPTLKoRuZ/ZsJAaZtih4ngbssFKUQRVuDrBmZmYz1/7veOfsC1zx2+tkmy34ZMDQacrzW/zfhEnRgJJ92We4LuOs3sgUqdyvl3JPptTBeI02rdI+PtLrwV8BvLDgz2HFsy6Go7KkidqL5e6SOvTYDJVVEL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025697; c=relaxed/simple;
	bh=kMngTv9iMth+WLwac0PFpKN5pu5PJxBvKoAMsrZ36u8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ef+4qOkTb9d5cktFjFX+9JUdrAndCdnOnqAWIh/Pes6CuyFqizAEkf4v1Z88MCVtj4hDE65YVZracOMYrFu/3vQRIEI1Mv0bjCJe6wdAj5loTlzcTtx8uyRFn1SK1wlfXXXGFMvBlvRwNp7gFaFocFBIhFz2n/WomM434Buq0iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FMBAiTrj; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D9EC540E0177;
	Tue, 23 Jan 2024 16:01:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EKJmDPwUzp3M; Tue, 23 Jan 2024 16:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706025688; bh=TuGT8DPp+kWiiQKrjA1x+Hi0QfTiR211X4cNZRQ96Ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FMBAiTrjPah7qNX7mCplVvBIbz3eHUnIvaazryKmfQp1teB/sWXqYNkznWqRLXcCb
	 Z0rc0yGdnakDhrWi2Ogp1ec9eEzBCCKb80wgikPhMZgqjQCYL3xbGeICpPtl7e0Nj9
	 7yIyJkF/KxvnvO+n8V6/s3i+jqo9ufnqVOCey6B4MaQ332jM8aLfVyi5fO60nfgR5Y
	 F3cJpIiAdT5DnZ4HFoqbfLJnzGI0gyBG4xXpiySQ8wEylVrhc4CRMK+u9l1YQGSTEk
	 AaS6asBW2TVOi68qtPluJP/gZNdmde8o+oo4ELFgAGaP9IrfAHtKK74XDGkQEzDmgG
	 qXOnAGy2a8nK4fN+6EKFyP7GSY5O5GOrS4iLmyDJVvX+tOpr7vYuT1RaSJyC2ju7X9
	 TKU7Q/g+qz4NWxqNzYToc+bJblClqrHE0sfygypz+8zGjwxlfjbKHTBwW74Sa3/hBW
	 nyNVWWj981uOAavtRPkr+ymfdofAJ8XuY/Yv6iU4mMZE5exsFZeiBAjuveSFt+rVYq
	 rX/tJYlxa0XbKRXcvHv5F5v/lyGtqkLDlZOVdeTQhlfMSEjwcIBI3B282dVXCB9+9Q
	 dkkqg1KNgEWRUDyCTA/SuldGvGG5AdjntHri426dQmEpgV8ABH9g8ImxBL60Ym5Xns
	 wnDTSnrDEI9ulr/5139X+BIY=
Received: from zn.tnic (pd953099d.dip0.t-ipconnect.de [217.83.9.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E647740E01A9;
	Tue, 23 Jan 2024 16:01:04 +0000 (UTC)
Date: Tue, 23 Jan 2024 17:00:49 +0100
From: Borislav Petkov <bp@alien8.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, herbert@gondor.apana.org.au,
	davem@davemloft.net, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, seanjc@google.com,
	kim.phillips@amd.com, kirill.shutemov@linux.intel.com,
	jmattson@google.com, babu.moger@amd.com, kai.huang@intel.com,
	acme@redhat.com, aik@amd.com, namhyung@kernel.org,
	CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, LeoLiu-oc@zhaoxin.com,
	GeorgeXue@zhaoxin.com
Subject: Re: [PATCH v2 2/3] x86/cpufeatures: Add CPU feature flags for
 Zhaoxin Hash Engine
Message-ID: <20240123160049.GCZa_isSHlj2NBa8i7@fat_crate.local>
References: <20240123022852.2475-1-TonyWWang-oc@zhaoxin.com>
 <20240123022852.2475-3-TonyWWang-oc@zhaoxin.com>
 <20240123094427.GAZa-Ke5d2Kwyk2nSU@fat_crate.local>
 <AADBA4D3-3D36-4AB6-B0D1-510DD5347430@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AADBA4D3-3D36-4AB6-B0D1-510DD5347430@zytor.com>

On Tue, Jan 23, 2024 at 07:42:00AM -0800, H. Peter Anvin wrote:
> Well, Centaur bought Cyrix, and then VIA bought Centaur.

I suspected something like that.

> I think Zhaoxin is a joint venture between VIA and the City of
> Shanghai, or something like that?

Aha.

Btw, lemme know if your reply bounces too. I got

<TonyWWang-oc@zhaoxin.com>: host mx2.zhaoxin.com[203.110.167.99] said: 550
    Sender IP reverse lookup rejected (in reply to RCPT TO command)

earlier.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

