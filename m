Return-Path: <linux-kernel+bounces-102048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 507DA87ADF8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068761F2BAD4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF79153BFF;
	Wed, 13 Mar 2024 16:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cDqMVQ3g"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0521534E7;
	Wed, 13 Mar 2024 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348428; cv=none; b=h/bjZ1tzIejTHuv8qlgWaiCrrsrTbQyF6TYXOnCZHubx1WsmsfZgDW9X+9wYS9bw+VqjquRCrCY+R3UhazsPTv0jeojUQ8rcafXunX20buzuq2YFfYtleMrF6nGsXCBzmoVLZDFCcmD9H0z4sXGgXzfzp3l7ZAnfdk9l7GHQXpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348428; c=relaxed/simple;
	bh=SOZ7SCjHT+oG5ANBLg9w5L3CwtTlMcNg+9Ltr/PWxwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIDhA5CfKc0sRrfDnRDFxgcRyPSxaZ4C6PphjCeUNnZrXdSz6A2+aWzRnD5jNXBXkb7Mzs1ybIfH4JSOFr9lp5CCjFqgdZMYcrVEfFa00scOPRxyxMhS92epFSRMwWpdYdnBoaMGx/uH19Wc2/F3ik5e8TzU+7iPIz+U/aAwnjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cDqMVQ3g; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8CA6A40E0028;
	Wed, 13 Mar 2024 16:47:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kpc4JpKKqXNJ; Wed, 13 Mar 2024 16:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1710348420; bh=fUn8lg6sJ972ZUHX8qbessMcsE7w3gCgvfzJZ7LzHsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cDqMVQ3gQ38ZcicNunGtnHy/3owSTvOBhB3f2oG7xn/z2RBj2BJQgxlyxwFS1/kI4
	 x/yM5Xp6+MiW1fAb1ObkUx1xY9dV2smzX07a3HjVQbMko4yn4Nbgf5a1cCuaiFmUYn
	 6nlg67x6hAIt1JMyLMD0BLZHist5wVADUAbztj1filjxChhy6o3CplVlDGuOrr1Ojm
	 puDFNOxkIcbJnre3/aqTJMZlsiOGKitE3k2k6Wu5COi7oSTjf47xgRCCYbAQtL4tgb
	 U4EbP8WlH/xdRA3Qh0LcoSZqYnFVedW+uksihkFmUQSM0mupdqkeg0tFw7ea4taWTM
	 mPzyBCkOXvvSivjIs0EsvN51jXcMaJmzibBjuKBS2fsg8TDEAB5yDqjWOn1fGXG5XL
	 Ep2aLXE0CcAaYAtSLqtsWUoHB5CeehXjZ8+hnjZEmglR4go42utV0GbleOD2vrshw+
	 eI1ae/MXS+kKulhxN81VwbZRhvaxLBAquZKI+YhLHcPX9Gb2CkwqxIvMdYCy5b32ZR
	 /ydJ5UVim4pEJA/oMoTdSJ83t3Kv/rLa2r9fuEZnZGrAV1dn5iwX+7di5TXV+7r4Hq
	 9pkQoeL2UjHuPnM3hwBkTUUkQvQnc4qa2u5kfh2ubZ6ad4er6rKm/347WbtQ1OPiVM
	 qco6rckr1kJoXBXzHEmE/PZM=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 59EFD40E0196;
	Wed, 13 Mar 2024 16:46:49 +0000 (UTC)
Date: Wed, 13 Mar 2024 17:46:44 +0100
From: Borislav Petkov <bp@alien8.de>
To: Sam Sun <samsun1006219@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	"xrivendell7@gmail.com" <xrivendell7@gmail.com>,
	syzkaller@googlegroups.com, linux-edac@vger.kernel.org,
	hpa@zytor.com, x86@kernel.org, dave.hansen@linux.intel.com,
	mingo@redhat.com, tglx@linutronix.de, tony.luck@intel.com
Subject: Re: [Bug] WARNING: ODEBUG bug in __mcheck_cpu_init_timer
Message-ID: <20240313164644.GDZfHYdAORMso4b-Xx@fat_crate.local>
References: <CAEkJfYNiENwQY8yV1LYJ9LjJs+x_-PqMv98gKig55=2vbzffRw@mail.gmail.com>
 <20240313145218.GCZfG9ovrh2ukJ9uAO@fat_crate.local>
 <CAEkJfYPzStpPfnNkojU-KvVP2GLxqPOiZ3=1DViPTyNUUQ0-1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEkJfYPzStpPfnNkojU-KvVP2GLxqPOiZ3=1DViPTyNUUQ0-1w@mail.gmail.com>

On Thu, Mar 14, 2024 at 12:32:20AM +0800, Sam Sun wrote:
> I applied this patch on the latest kernel mainline commit, and the C
> repro could not trigger this bug. I think this bug is fixed by this
> patch.

Yap, it doesn't trigger anymore here too with your reproducer but thanks
for confirming. I'll queue it after the merge window is over.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

