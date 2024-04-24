Return-Path: <linux-kernel+bounces-156138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A068AFE66
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B58BF285092
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4357D15EA2;
	Wed, 24 Apr 2024 02:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aZdb4H9y"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B65F168C7;
	Wed, 24 Apr 2024 02:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713925764; cv=none; b=B/ySM4BxiFwQKv6lnpJ354oVoBnjYruNWHXULSCU474noeP5pshBeEpede/W7a+MtMymP/RfAPBOTPCocevtH3QZxkoFy/n0DRm98Y3VbR/oPEtnbMt5q1OQ35LrtfMfiv5Dwsgll9EMA65hpjAsSV7aw7zd8up4PcC+FOnS4tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713925764; c=relaxed/simple;
	bh=NR8Ho+ac/jZoep93KWW47zKovZwgFCM6UAhcBZEnfKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YviXQtBMOEQA9LH2H7auIGz2J07rB0+g7wVB1mzbc9zmfn1GIMJEJjiQlMmTh+SeiVNMjq+Pa+hwl1jG0mpfa4VSqXXgev4CCsAFR1G1ZrD++LJfkG2uMBi9wGiABbzZ4v3ICvQjhmWmpKW+FrfUgcfuB3QEZgyL1UhyLgNYacw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aZdb4H9y; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 90B2D40E016B;
	Wed, 24 Apr 2024 02:29:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6tiFnfxbvehF; Wed, 24 Apr 2024 02:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1713925754; bh=hTf9OOp2UvZP+qJesHah0hK9B/NH+9VHy8xPsB4sdLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aZdb4H9y6ci9mgP0EVMpDK7MO8mzJmYWASUdFUZsNMnoR1QP+ZpZ3md7mLwXktfRg
	 IJMqH2SWWenKzBS0+OQcdP96aoDOFW2Vqu960mQfvVdh72t3vq2HC39yEk55uM8JA7
	 bvJyKIccXcuiuMispo6RqBhpjvhsPYWRVQAEYVGr+/567hn3J205KmDt7B+7zVacPM
	 yGzKSCHhVO4AX2XiOL4mtjqIb9alsZKgQHuKTcAJlLcM6B8UnXwdNo+1OVJOfsG7Jh
	 vltJo0m+Fel/VGU+RUmCRMrDm7bT+bvqeeBZ1EvgL9/+tJSbIO3aM+8XUSbQ1sQHqb
	 rE0P6YXznMvrFxF92FkrPN8yOb2jhlQdAtcJ3TEiKpzNmwBwc2UHpUU6ny0UQYc553
	 j/ow5mfUg6Uip5POJAGI82JC0+l5/LyVE94UxzlPVz7+vUCSOXRUsF0aOjMaEcaF0n
	 WV/2YKI60vjTrae9w0xe+67LbXuBVyv3BdA1pBKPtSlCgtU+u4DTeCZhG4NiHYV2Ca
	 ZpJQMOaOu+nYobxjUPKU+dG/WvRk/UQN4kOFVH++nGQUIKt48H7rGmmt+9+LoYNavQ
	 eca1eqXFTyqvLEnfKVCRykr4flvM8b6f3NQbxicZpbQstilAZ+kAxzGhEQx5RDCm4N
	 0nCmtHZc5SRfKb1i9CXoxMgk=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 70FE540E0177;
	Wed, 24 Apr 2024 02:29:07 +0000 (UTC)
Date: Wed, 24 Apr 2024 04:29:01 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, Avadhut.Naik@amd.com,
	John.Allen@amd.com
Subject: Re: [PATCH v2 05/16] x86/mce/amd: Clean up SMCA configuration
Message-ID: <20240424022822.GAZihuRjwlK6kOF0ya@fat_crate.local>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-6-yazen.ghannam@amd.com>
 <20240423190641.GDZigGwXXEPeDnfOsr@fat_crate.local>
 <eb9c5d9b-07d2-4b56-98dd-c2616ef73a0a@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eb9c5d9b-07d2-4b56-98dd-c2616ef73a0a@amd.com>

On Tue, Apr 23, 2024 at 03:32:00PM -0400, Yazen Ghannam wrote:
> This is not the same.
> 
> "CFG_DFR_INT_TYPE" is a register field.
> 
> "INTR_TYPE_APIC" is a value. And this same value can be used in other register
> fields.

I don't care - this was just an example of how it should look like. Like
the rest of the code around the kernel and not like an obfuscated
C contest mess.

> I think it's fair to just use logical AND for single bit checks instead of the
> FIELD_GET() macro.
> 
> But the FIELD_PREP() macro does help for setting bitfields. I think it's
> clearer than manually doing the proper shifts and masks.

To you maybe.

Pls stick to how common code does masks generation and manipulation so
that this remains readable. This FIELD* crap is not helping.

> Okay. I was thinking to keep the names shorter since they are only used in
> this file. But I'll change them.

If you want to keep them shorter, then think of an overall shorter
scheme of how the register *and* the fields which belong to it, should
be named. But there's a point in having the same prefix for register and
bits which belong to it.

> Okay. I'll include the follow up patches in the next revision of this set.

Pls do.

Thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

