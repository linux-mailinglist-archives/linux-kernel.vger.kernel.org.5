Return-Path: <linux-kernel+bounces-73179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8035F85BEC2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 209E6B231CD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507FE6BB2D;
	Tue, 20 Feb 2024 14:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XBBddVhk"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA9F33D2
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708439320; cv=none; b=qVpCwPXf+B16es00eLofnDyvL6gVWexcf2o6LiSGkclJBJ27t79lfeGtdVQEobsa9lBYuZY3d3cBj2xfAYp4jdiRLirIDAl1qfTpNNmRu+QxBkEZceyzFkhK4rB/k9Zvj50m/ePFZiMk6saFR9AfBmmVX8tSe6tJhaT6UJLw80g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708439320; c=relaxed/simple;
	bh=pjY/nrgaNL5+InMjrOrmdqrlVDzlBmSi1IwhLsv9YH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGGYPEcoLy15JrZsk0RnJvPJwK05FuPpqJMHqu6j7uEjrcbh+QKMhRGybO4xw6ca4qgFTh9L1FE+0qCknEP5+bZh6r0h9BlG4U+lCTqQe36i9V3TC6beAI9Zg4YhkdeglnzMOxISnm9zxo6RxSsMVFHURgnL+e9OaIPxn0a251c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XBBddVhk; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4776340E01BB;
	Tue, 20 Feb 2024 14:28:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6rCDkdtN_Oe5; Tue, 20 Feb 2024 14:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1708439312; bh=32+IbPnVLtr/jMqd20s6KTqF26jFBldrXWMcleqNzQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XBBddVhkaM773FBWgccyQIVa7oHrRo9Oc+LAcVpp+9tYeHIBemmVeeNHxPCic+1zg
	 gbOZtpdq0/+K6SlqWBzjjk8s9Vy70iIjQhjVJa07clVCi9BeilPTNxNkEY4TGJUVEf
	 vy1B8X0idKzNB/srGyzAeAld7ZIrs5hD/CFnjv4rbOsWKP14Z0iFtboIWAvwWAL6BC
	 +/IULwZNCqE3Pyj3EjywBqbsufzk/vtzUmPxzdDhVzE0O75sHvESvhqAMq0qYxruzb
	 4OUIoDazb68s1K1jLFY1Z5QU0K1wi88fBcYRBI6PNJ+5uLiUuMx7a1swKaCHtAlrJg
	 nO/VKO5CC1RpbHS/Dl3vQQUMi+wCg5EPUMjmHsTDUoatL7o4HJgaXIlEA0ng/xld5m
	 STF0ZRFioV3egLxmcebUCCGA9qjWv6SQEJTUQ9IszfPRlkwXxjcQX2rASCv+O/KUN2
	 we13hHkMe319Db9UGULva/3tHrjMQfL4cNp3eTC0wsP6CZYgVMUx1bUARKf7AA6S/B
	 os3jNq0NrsSgviEeLWraNif78FxHmry1SD1yL0hio+PzLlP/LQCyNChNBKkOgxPA1o
	 7a3Ae9orNWcWVU5eIjAiTsqcmLde60BynZMEwf4B0Gu0Mt9BZFrMZfytWXF6N7//zR
	 GcCLobWJw+CTeVRwnhRrqry4=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DD27C40E01A9;
	Tue, 20 Feb 2024 14:28:16 +0000 (UTC)
Date: Tue, 20 Feb 2024 15:28:12 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: "Huang, Kai" <kai.huang@intel.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, dave.hansen@intel.com,
	kirill.shutemov@linux.intel.com, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com, luto@kernel.org,
	peterz@infradead.org, chao.gao@intel.com, bhe@redhat.com,
	nik.borisov@suse.com, pbonzini@redhat.com
Subject: Re: [PATCH 1/4] x86/coco: Add a new CC attribute to unify cache
 flush during kexec
Message-ID: <20240220142812.GBZdS2_HJEA50F8RZD@fat_crate.local>
References: <cover.1706698706.git.kai.huang@intel.com>
 <cd88e97e53c502f0a457d6a82a31d9e8e0f9fca7.1706698706.git.kai.huang@intel.com>
 <20240219161611.GBZdN-y6DO-cspaZrf@fat_crate.local>
 <9164b0e3-f520-4aab-8b80-520131f0e4db@amd.com>
 <20240219203222.GIZdO61ucfq4bFxRT0@fat_crate.local>
 <283877fd-78c7-4322-bbce-ba6420d56765@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <283877fd-78c7-4322-bbce-ba6420d56765@amd.com>

On Mon, Feb 19, 2024 at 04:09:47PM -0600, Tom Lendacky wrote:
> That's why the '!(sev_status & MSR_AMD64_SEV_ENABLED)' works here.

I would've never figured that out just from staring at the test. :-\

> Basically, if you are bare-metal, it will return true. And it will only
> return true for machines that support SME and have the
> MSR_AMD64_SYSCFG_MEM_ENCRYPT bit set in SYS_CFG MSR because of where the
> 'cc_vendor = CC_VENDOR_AMD' assignment is. However, if you move the
> 'cc_vendor = CC_VENDOR_AMD' to before the if statement, then you will have
> the WBINVD called for any machine that supports SME, even if SME is not
> possible because the proper bit in the SYS_CFG MSR hasn't been set.
> 
> I know what I'm trying to say, let me know if it is making sense...

Yah, thanks for taking the time to explain.

Here's an even more radical idea:

Why not do WBINVD *unconditionally* on the CPU down path?

- it is the opposite of a fast path, i.e., no one cares

- it'll take care of every possible configuration without ugly logic

- it wouldn't hurt to have the caches nice and coherent before going
  down

Hmmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

